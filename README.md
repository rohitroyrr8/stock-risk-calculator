# Stock Risk Calculator

A Python application that calculates portfolio risk and optimal trade volumes using Sharpe's model and linear regression analysis.

## Overview

This tool helps traders and portfolio managers determine optimal trade volumes and risk allocations for a portfolio of stocks. It uses historical price data to calculate stock correlations with a market index (beta) and automatically weights positions based on their risk characteristics.

## Features

- **Regression Analysis**: Calculates beta coefficients and correlation with market index
- **Portfolio Weighting**: Automatically weights stocks based on their beta values
- **Risk Calculation**: Determines risk limits based on user-specified parameters
- **Trade Volume Optimization**: Calculates optimal position sizes for each stock
- **Commission Tracking**: Accounts for trading commissions in risk calculations

## Requirements

- Python 3.x
- pandas
- scipy

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd assesment-script
```

2. Install dependencies:
```bash
pip install -r logic/requirements.txt
```

## Usage

Run the application:
```bash
python main.py
```

The program will prompt you for three parameters:

1. **Balance $**: Your total portfolio balance (must be > 0)
2. **Risk %**: Your desired risk percentage (must be > 0)
3. **Commission %**: Your trading commission percentage (must be > 0)
4. **Index symbol**: The market index to use as reference (e.g., SP500)

## Available Stock Symbols

The following stocks are included in the historical data:
- AAL, AAPL, AMZN, AXP, BP, CMS, CVX, F, GM, GS, HPQ, IBM, JNJ, JPM, KO, MSFT, NRG, ORCL, RHT, SP500, XOM, YHOO

## Output

The application displays a DataFrame with the following columns for each symbol:

| Column | Description |
|--------|-------------|
| b1 | Beta coefficient (stock volatility vs. index) |
| r_value | Correlation coefficient with index |
| weight | Allocated portfolio weight |
| trade_volume | Dollar amount to trade for this stock |
| risk_limit | Maximum acceptable risk for this position |
| commission | Trading commission cost |

## Example

```
Balance $ : 10000
Risk % : 2
Commission % : 0.1
Index symbol : SP500
```

## File Structure

- `main.py` - Main entry point
- `logic/` - Core calculation modules
  - `risk_calculation.py` - Risk calculation and regression analysis
  - `csvutils.py` - CSV file reading utilities
  - `risk_csv.py` - CSV output handling
- `historical-prices/` - Stock historical price data files

## License

Licensed under the Apache License, Version 2.0