
-----

### **The Great Deep Learning Showdown: TensorFlow vs. PyTorch**

*A Practical Comparison for Time-Series Forecasting*

This repository contains the code and results for a comparative study of deep learning frameworks, **TensorFlow** and **PyTorch**, on a time-series forecasting task. The goal of this research was not to crown a definitive winner, but to analyze the practical performance, efficiency, and usability of each library when using fundamental neural network architectures on a specific dataset.

The full analysis and discussion can be found in the accompanying blog post: [Link to your Medium blog post here]

-----

### **Key Findings 💡**

  * **PyTorch's Efficiency:** PyTorch consistently outperformed TensorFlow in both training time and resource usage across all models and hardware.
  * **LSTM's Superiority:** The LSTM model proved to be far more effective and accurate than the simpler MLP for this time-series forecasting task.
  * **Hardware Impact:** The GPU provided a significant speed boost, but its full potential was limited by the small dataset size, highlighting the importance of data volume in GPU-accelerated workloads.

-----

### **Methodology**

This project benchmarked four distinct model configurations:

  - **Models:** Multilayer Perceptron (MLP) and Long Short-Term Memory (LSTM)
  - **Frameworks:** TensorFlow and PyTorch
  - **Hardware:** AMD Ryzen 4000 series CPU and NVIDIA RTX 3050 GPU

**Dataset:**

  - A small, synthetic time-series dataset (\~500 rows) of DC power generation from a solar panel, created using MATLAB.

-----

### **Results & Analysis**

This section presents the key findings from our experiment, summarized with the help of various plots.

#### **Forecasting Accuracy**

The `forecasting_values` plot provides a visual comparison of the model predictions against the actual values. The `MAE` and `RMSE` bar charts offer a quantitative look at the model errors. As seen below, the PyTorch LSTM models achieved the lowest error rates.

#### **Training Time & Efficiency**

Training time is a crucial metric for deep learning projects. The plot below shows that PyTorch was not only faster than TensorFlow on the CPU but also leveraged the GPU's power far more effectively.

#### **Performance vs. Time Trade-off**

This plot is a great summary of our findings, showing that the PyTorch LSTM models achieved the lowest error in the least amount of time, a key indicator of efficiency.

#### **Holistic View: Radar Chart**

The radar chart consolidates performance across multiple metrics—including training time, R², and error metrics—providing a single, comprehensive view of each model's strengths and weaknesses.

-----

### **How to Replicate the Experiment**

Follow these steps to run the code and reproduce the results on your machine.

1.  **Clone the repository:**

    ```
    git clone https://github.com/your-username/your-repository-name.git
    cd your-repository-name
    ```

2.  **Install dependencies:**

    ```
    pip install -r requirements.txt
    ```

    *(Note: You'll need to install TensorFlow and PyTorch separately, depending on your hardware, with GPU support if you have an NVIDIA GPU.)*

3.  **Run the main script:**

    ```
    python your_main_script_name.py
    ```