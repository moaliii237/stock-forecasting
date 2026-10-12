# Stock time series forecasting on NASDAQ-100 (ASML)

This is my individual project for Year 1 Block D (2024-25). I worked with ASML stock
data and the wider NASDAQ-100 set and tried to predict the price and the next-day
direction in many different ways. The point was to go through the full chain: clean the
time series, check if it is stationary, then forecast it with classic statistics, with
machine learning, and with neural networks. Every model is compared against a simple
naive baseline so I can see if it actually adds anything.

Author: Mohammadali Jaberi (244437). I am the only author. All the code and the answers
are in one notebook: `stock_forecasting.ipynb`. The notebook
is the BUAS template and I filled in the code and wrote the analysis for tasks 4.1 and 4.2.

## What it does

The notebook is split in two big tasks.

Task 4.1 is the classic time series part:

- Load ASML minute data and daily data, resample the minute data to hourly with the mean.
- Handle the calendar: find missing workdays, forward fill the gaps so the series is continuous.
- Build features like daily percentage change, monthly change and a 30-day rolling mean.
- Plot ASML against NASDAQ-100, crude oil and gold, and look at the correlation matrix.
- Run a seasonal decomposition (additive, period 90 for a quarterly cycle).
- Test stationarity with the Augmented Dickey-Fuller test, then difference the series.
- Forecast with four methods: naive, 30-day rolling average, a fixed ARIMA(2,1,2),
  auto_arima for tuning, and a rolling one-step ARIMA that retrains every day.

Task 4.2 is the machine learning part on the same ASML data:

- Regression of the close price from lag features plus exogenous data (linear, Lasso, random forest).
- Classification of next-day up/down movement (logistic regression, logistic with L1, random forest, XGBoost).
- Clustering of all 100 NASDAQ tickers by return and volatility (KMeans, hierarchical, DBSCAN for outliers).
- Neural networks for the price: an MLP and a 30-day-window LSTM.

## How it works and why I did it this way

**Stationarity.** I ran ADF on the raw ASML close price and got a p-value of about 0.82,
so it is clearly non-stationary (the price has a trend). After one round of differencing
with `.diff()` the p-value dropped to about 1.8e-26, so the differenced series is stationary.
That is why the d in ARIMA(p,d,q) is 1.

**Choosing the exogenous data.** From the line plots and the correlation matrix, crude oil
had the strongest link to ASML (Pearson correlation about 0.96). NASDAQ-100 and gold were
positive but weaker. So when I built the ML features I added the previous day's VIX (from
the macro indicators file) and the previous day's crude oil price as extra inputs next to
the ASML lags. I shift these by one day on purpose so I am only using information that was
already known before the day I predict.

**Forecasting baselines vs ARIMA.** The naive forecast (predict today equals yesterday)
was already strong, RMSE about 12.88. The 30-day rolling average was worse (RMSE 38.16)
because it lags behind real moves. The fixed ARIMA(2,1,2), trained once up to end of 2022
and then forecasting all of 2023, did badly (RMSE 125.43). auto_arima also picked (2,1,2)
as the best order, so my manual order was fine, the problem was the setup. I realised the
comparison was not fair: the naive model always sees the most recent day, but the static
ARIMA was frozen on old data. So I built a rolling one-step ARIMA(2,1,2) that refits on all
history before each single day and predicts one step ahead. That brought the RMSE down to
about 12.59, close to the naive model, which makes sense because over one day the best
guess really is close to yesterday's price.

**Regression.** I made 5 lag features (close price shifted 1 to 5 days) and joined the
shifted VIX and oil. Train/test split is 80/20 with `shuffle=False` so I never train on
future data. I scaled with StandardScaler for the linear models. Linear regression and
Lasso (alpha 0.1) were the best with RMSE around 20.4 and R2 around 0.977. Random forest
was much worse (RMSE 61.3, R2 0.79). My read is that the relationship here is mostly linear
and dominated by the most recent lag, so the tree model overcomplicated it.

**Classification.** Target is whether the price goes up the next day. The classes are
roughly balanced (about 55% up), so that 55% is the baseline to beat. None of the models
beat it by much, which is honest for a daily direction problem: logistic with L1 (C=70,
liblinear) got about 0.56 accuracy, plain logistic and random forest about 0.52, and
XGBoost about 0.49. Predicting next-day direction from price alone is close to a coin flip,
and the results show that.

**Clustering.** I looped over every ticker CSV, computed mean daily return and volatility
per stock, scaled them, then clustered. I used the elbow method on inertia and picked k=4
for KMeans. Hierarchical clustering with Ward linkage and Euclidean distance also used 4
clusters and gave a similar split. For anomalies I used DBSCAN (eps 0.5, min_samples 5),
which flagged APP and AXON as outliers (label -1) because their return and volatility
numbers are far outside the normal range of the other stocks.

**Neural networks.** Both models predict the ASML close. I scaled with MinMaxScaler but
fit the scaler only on the first 80% (training part) so the test data does not leak into
the scaling. The MLP is three dense layers (64, 128, 256, relu) into a linear output,
trained for 500 epochs with Adam and MSE loss, and reached RMSE about 21.3. The LSTM uses
a 30-day sliding window (each sample is the last 30 days, reshaped to (samples, 30, 1)),
three stacked LSTM layers (64, 128, 256) into a dense output, Adam with learning rate
0.0001, 100 epochs, with a ModelCheckpoint saving the best model on validation loss. The
LSTM did a bit better (RMSE about 20.8, MAE 13.8) than the MLP (RMSE 21.3, MAE 14.8),
which fits the idea that the sequence structure helps.

## Tech stack

Python 3.10. Libraries: pandas and numpy for data, matplotlib and seaborn for plots,
statsmodels for ADF, seasonal decomposition and ARIMA, pmdarima for auto_arima,
scikit-learn for the regression, classification, clustering and metrics, XGBoost for the
boosted classifier, and TensorFlow/Keras for the MLP and LSTM. yfinance is imported in the
rolling forecast section. Everything runs in a Jupyter notebook.

## Results summary

Forecasting (ASML close, RMSE, lower is better):

| Model | RMSE |
| --- | --- |
| Naive (yesterday) | 12.88 |
| 30-day rolling average | 38.16 |
| ARIMA(2,1,2) static | 125.43 |
| Rolling one-step ARIMA(2,1,2) | 12.59 |

Regression (RMSE / R2):

| Model | RMSE | R2 |
| --- | --- | --- |
| Naive | 20.56 | 0.9765 |
| Linear regression | 20.39 | 0.9769 |
| Lasso (alpha 0.1) | 20.37 | 0.9769 |
| Random forest (100 trees) | 61.28 | 0.7910 |

Classification accuracy (baseline, always predict up, is about 0.55):

| Model | Accuracy |
| --- | --- |
| Logistic regression | 0.52 |
| Logistic regression L1 (C=70) | 0.56 |
| Random forest (100 trees, depth 12) | 0.52 |
| XGBoost (100 trees, lr 0.5, depth 14) | 0.49 |

Neural networks (RMSE / MAE): MLP 21.34 / 14.83, LSTM 20.83 / 13.79.

Honest limitations: the daily direction classification does not really beat the naive
baseline, so I would not trade on it. The price forecasts look good on RMSE and R2 but
that is mostly because the price is highly autocorrelated, the model is basically learning
that tomorrow is close to today. The rolling ARIMA is slow because it refits every single
day. I only have one full random seed per model, so I did not measure run-to-run variance.

## How to run

1. Make a Python 3.10 environment and install the packages:
   ```
   pip install -r requirements.txt
   ```
2. Put the data and image folders next to the notebook. The code reads CSVs from a
   `Data_TS_Template/` folder (for example `ASML.csv`, `ASML_minute_data.csv`,
   `NASDAQ100.csv`, `CrudeOil.csv`, `MacroEconomicIndicators.csv`, plus one CSV per ticker
   for the clustering) and reference figures from `Images_TS_Template/`. These folders are
   the BUAS course data and are not included in this repo, so you have to add them yourself.
3. Open `stock_forecasting.ipynb` in Jupyter and run the cells
   from top to bottom. The LSTM training (100 epochs) is the slowest part and is much
   faster with a GPU, but it runs on CPU too.

## Key files

- `stock_forecasting.ipynb` - the full analysis, all code and answers.
- `requirements.txt` - the Python packages.
- `Data_TS_Template/`, `Images_TS_Template/` - data and reference figures, not committed.
