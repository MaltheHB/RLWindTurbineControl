
import gym
from gym import spaces
import numpy as np

class BladePitchEnv(gym.Env):
    """
    Gym environment for blade pitch controller gains optimization.
    Action: continuous [kp, ki]. Observation: dummy (zero).
    Reward: -DEL (lower Damage Equivalent Load is better).
    """
    def __init__(self):
        super(BladePitchEnv, self).__init__()
        # Action space: [kp, ki], e.g., kp in [0,10], ki in [0,5]
        self.action_space = spaces.Box(low=np.array([0.0, 0.0]), 
                                       high=np.array([10.0, 5.0]), 
                                       dtype=np.float32)
        # Observation space: dummy placeholder (not used meaningfully)
        self.observation_space = spaces.Box(low=-np.inf, high=np.inf, 
                                            shape=(1,), dtype=np.float32)
    
    def reset(self):
        # Return initial observation (dummy state)
        return np.zeros(self.observation_space.shape, dtype=np.float32)
    
    def step(self, action):
        """
        Execute one episode of simulation with given (kp, ki) gains.
        In practice, this would launch OpenFAST (via Python or MATLAB) with these gains,
        then compute the DEL from output loads:contentReference[oaicite:2]{index=2}:contentReference[oaicite:3]{index=3}.
        Here we mock this with a synthetic function.
        """
        kp, ki = action  # unpack action array
        # -- Placeholder for actual simulation: replace this with real OpenFAST call --
        del_value = mock_compute_del(kp, ki)
        # The reward is negative DEL (we want to minimize fatigue load)
        reward = -del_value
        done = True  # episode ends after one simulation
        # Observation remains dummy
        obs = np.zeros(self.observation_space.shape, dtype=np.float32)
        return obs, reward, done, {}

def mock_compute_del(kp, ki):
    """
    Mock DEL computation: a synthetic cost function with a minimum at some (kp, ki).
    In reality, compute DEL from the bending moment time series (e.g., using rainflow counting:contentReference[oaicite:4]{index=4}).
    """
    # Example: pretend optimum at kp=5.0, ki=1.0
    opt_kp, opt_ki = 5.0, 1.0
    # Quadratic bowl plus some variation
    base = (kp - opt_kp)**2 + (ki - opt_ki)**2
    # Add a sinusoidal variation to mimic complexity
    noise = 10.0 * np.sin(0.5 * kp) + 5.0 * np.cos(0.7 * ki)
    # Ensure DEL is positive
    del_value = 100.0 + 10.0 * base + noise
    return del_value

# Example: instantiate environment
env = BladePitchEnv()
obs_dim = env.observation_space.shape[0]
act_dim = env.action_space.shape[0]

import tensorflow as tf
import tensorflow_probability as tfp

# Set random seeds for reproducibility (optional)
tf.random.set_seed(42)
np.random.seed(42)

# Define actor-critic network
class ActorCriticModel(tf.keras.Model):
    def __init__(self, state_dim, action_dim, hidden_sizes=(64,64)):
        super(ActorCriticModel, self).__init__()
        # Common hidden layers
        self.hidden_layers = []
        for h in hidden_sizes:
            self.hidden_layers.append(tf.keras.layers.Dense(h, activation='tanh'))
        # Output layers for mean action and state value
        self.mu = tf.keras.layers.Dense(action_dim, activation=None)
        self.value = tf.keras.layers.Dense(1, activation=None)

    def call(self, x):
        # Forward pass
        for layer in self.hidden_layers:
            x = layer(x)
        return self.mu(x), self.value(x)

# Create the model
model = ActorCriticModel(state_dim=obs_dim, action_dim=act_dim)

# Log-standard deviation for Gaussian policy (initialized to zeros)
log_std = tf.Variable(tf.zeros(act_dim), name="log_std")

# Optimizer
optimizer = tf.keras.optimizers.Adam(learning_rate=1e-3)

# PPO hyperparameters
epochs = 50       # training epochs
batch_size = 20   # episodes per epoch
gamma = 0.99      # discount factor (unused here but set for consistency)
eps_clip = 0.2    # PPO clipping epsilon
c1 = 0.5          # value loss coefficient
c2 = 0.01         # entropy coefficient

for epoch in range(epochs):
    # Collect trajectories (each trajectory is one step here)
    batch_obs, batch_actions, batch_rewards, batch_values, batch_log_probs = [], [], [], [], []
    for ep in range(batch_size):
        obs = env.reset()                            # initial (dummy) state
        obs_input = tf.expand_dims(obs, axis=0)     # make batch dimension
        # Get action distribution from policy
        mu, value = model(obs_input)
        mu = tf.squeeze(mu)     # shape (action_dim,)
        value = tf.squeeze(value)  # shape ()
        # Create Gaussian distribution for actions
        dist = tfp.distributions.MultivariateNormalDiag(
            loc=mu, scale_diag=tf.exp(log_std))
        action = dist.sample()  # sample action
        log_prob = dist.log_prob(action)
        # Step environment
        obs2, reward, done, info = env.step(action.numpy())
        # Store transition
        batch_obs.append(obs)
        batch_actions.append(action.numpy())
        batch_rewards.append(reward)
        batch_values.append(value.numpy())
        batch_log_probs.append(log_prob.numpy())
        # (done is always True after one step)
    
    # Convert lists to tensors
    states = tf.convert_to_tensor(np.array(batch_obs), dtype=tf.float32)
    actions = tf.convert_to_tensor(np.array(batch_actions), dtype=tf.float32)
    old_values = tf.convert_to_tensor(np.array(batch_values), dtype=tf.float32)
    old_log_probs = tf.convert_to_tensor(np.array(batch_log_probs), dtype=tf.float32)
    rewards = np.array(batch_rewards, dtype=np.float32)
    
    # Compute advantages (since each episode is one step, advantage = reward - value)
    returns = rewards  # No bootstrapping since episode ends
    advantages = returns - old_values.numpy()
    advantages = tf.convert_to_tensor(advantages, dtype=tf.float32)

    # Perform one training update using PPO loss
    with tf.GradientTape() as tape:
        # Forward pass for current policy
        mu, value = model(states)
        value = tf.squeeze(value)  # shape (batch,)
        dist = tfp.distributions.MultivariateNormalDiag(
            loc=mu, scale_diag=tf.exp(log_std))
        new_log_probs = dist.log_prob(actions)  # shape (batch,)
        entropy = tf.reduce_mean(dist.entropy())

        # Ratio for clipped objective
        ratio = tf.exp(new_log_probs - old_log_probs)
        clipped_ratio = tf.clip_by_value(ratio, 1 - eps_clip, 1 + eps_clip)
        # Policy loss (take minimum of clipped and unclipped advantage)
        policy_loss = -tf.reduce_mean(tf.minimum(ratio * advantages, clipped_ratio * advantages))
        # Value (critic) loss (MSE)
        value_loss = tf.reduce_mean(tf.square(returns - value))
        # Total PPO loss
        total_loss = policy_loss + c1 * value_loss - c2 * entropy

    # Compute and apply gradients
    params = model.trainable_variables + [log_std]
    grads = tape.gradient(total_loss, params)
    optimizer.apply_gradients(zip(grads, params))
    
    # (Optional) print training progress
    if (epoch+1) % 10 == 0:
        avg_reward = np.mean(rewards)
        print(f"Epoch {epoch+1}/{epochs}, Avg Reward: {avg_reward:.2f}, Loss: {total_loss.numpy():.3f}")
