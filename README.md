[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/28-zJh4-)

# Block D - Time Series (my individual work)

This is my individual time series part for Year 1 Block D (2024-25). Author: Mohammadali Jaberi (244437).

The main file is the notebook `TimeSeries_Template Mohammadali Jaberi 244437.ipynb`. It is the BUAS
template and I filled in the code and the answers for tasks 4.1 and 4.2. I worked with ASML stock data
and other NASDAQ-100 data. What I did, in order:

- Task 4.1: loading and cleaning the time series, resampling, filling missing workdays, plotting,
  seasonal decomposition, ADF stationarity test, and forecasting with naive, rolling mean and ARIMA.
- Task 4.2: machine learning on the same data, regression (linear, Lasso, random forest),
  classification of up/down movement (logistic regression, random forest, XGBoost), clustering of
  NASDAQ-100 companies (KMeans, hierarchical, DBSCAN for anomalies), and neural networks (MLP and LSTM).

What I found: the price is non-stationary, after one differencing it becomes stationary. For forecasting,
the rolling (walk-forward) ARIMA was the best because it sees the newest data each step. For regression
the linear models worked best. For the deep models the LSTM beat the MLP.

How to run it:

1. Make a Python environment and install the packages: `pip install -r requirements.txt`
2. Put the `Data_TS_Template` and `Images_TS_Template` folders next to the notebook (they hold the CSV
   data and the reference figures). They are not in this repo.
3. Open the notebook in Jupyter and run the cells from top to bottom.

The text below is the original assignment brief from BUAS.

## Project - Uncovering Market Intelligence: A NASDAQ-100 Data Challenge

In this block, you will be working with __Move Tickers__, an innovative SaaS company that specialises in delivering real-time financial market updates and interactive data visualisation tools. They are expanding into the wealth management space, focusing on developing advanced trading strategies, including high-frequency trading and algorithmic models. Their goal is to leverage data and machine learning to uncover hidden patterns in the stock market and gain a competitive edge.

As data scientists collaborating with __Move Tickers__, your role is to help them analyse financial data, build predictive models, and develop trading strategies that are both effective and data-driven. You will explore time series forecasting, classification, clustering, and anomaly detection, and evaluate the performance of different strategies through backtesting. Additionally, __Move Tickers__ is looking for practical solutions, such as dashboards for market monitoring or alert systems that notify users when key events happen.

Throughout this project, you are encouraged to ask critical questions, propose new insights, and validate your findings with solid analysis. Whether you focus on stock price prediction, market correlations, or strategy optimisation, your work should aim to provide clear recommendations and actionable insights that __Move Tickers__ can integrate into their platform. And remember—quality and accuracy matter more than quantity!

👉 Before you get started, take some time to visit the [Move Tickers company page](https://adsai.buas.nl/Study%20Content/Stock%20Market/Client.html). There, you’ll find additional background information, their current initiatives, and the specific questions they are looking to answer. Understanding their mission and priorities will help you align your analysis with their real-world needs and deliver solutions that add real value.

For your project in this block, you will have access to a rich set of financial data already prepared for you. You are encouraged to select the data that is most relevant to your project goals. You may also enhance your analysis by adding external datasets if you believe they provide additional value. If you plan to do so, make sure to first discuss it with your mentor. You can focus on a single company or explore multiple ones, depending on the scope of your analysis and the strategy you wish to develop.

The datasets provided cover a wide range of financial and economic indicators, including:

- **NASDAQ-100 Minute Data:** Minute-by-minute stock prices over the last 10 years, ideal for short-term or high-frequency trading analysis.
- **NASDAQ-100 Daily Data:** Daily stock prices over the last 10 years, useful for mid- and long-term trend analysis.
- **NASDAQ-100 Index Data:** Tracks the overall index performance and broader market trends.
- **Top 10 Global Stock Indices:** Provides insights into international market movements.
- **Exchange Rates and Macroeconomic Indicators:** Key factors such as GDP growth, inflation, interest rates, and market volatility (VIX) to help contextualise financial trends.
- **Commodity Prices:** Crude oil and gold prices to assess their impact on market behaviour.

👉 To better understand the details of each dataset, its structure, and its potential applications, please visit the  [Data Overview Page](https://adsai.buas.nl/Study%20Content/Stock%20Market/1.%20Project%20Data%20Overview%20and%20Guidance.html). Familiarising yourself with the available data will help you make informed decisions about which datasets to use and how to apply them effectively in your project.
