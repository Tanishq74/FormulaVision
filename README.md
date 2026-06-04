# FormulaVision: F1 Race Time Prediction

FormulaVision is a machine learning project that predicts Formula 1 race outcomes for the 2025 season by leveraging historical data, qualifying performance, team telemetry, and live weather conditions.

## Project Overview

This repository develops predictive models using Gradient Boosting Regressors. The model progresses through consecutive calendar iterations, starting with qualifying-only predictions and evolving to incorporate historical sector averages, weather constraints, team performance indexes, and track-specific layouts.

## Key Features

- **FastF1 API Integration**: Automated retrieval of historical race logs, telemetry data, and lap times.
- **Iterative ML Models**: Feature engineering layers added race-by-race, incorporating:
  - Qualifying performance
  - Sector times
  - Driver wet-performance coefficients
  - Live meteorological telemetry
  - Season standings and constructor points index
- **Robust API Integration**: Resilience mechanisms to fall back gracefully on missing OpenWeatherMap API details.

## Repository Structure

- `prediction1.py` to `prediction8.py`: Successive scripts for race-specific models (e.g., Australia, China, Japan, Bahrain, Saudi Arabia, Miami, Imola, Monaco).
- `prediction2_nochange.py` & `prediction2_olddrivers.py`: Baseline model variations.
- `requirements.txt`: Unified Python package dependency declaration.
- `db/init_db.sql`: Database schema configuration for historical telemetry data storage.
- `tests/check_db_connection.py`: Postgres connection validation scripts.

## Installation and Setup

### Prerequisites

Python 3.9+ is recommended. 

### Step 1: Clone and Set Up Virtual Environment

```bash
git clone https://github.com/Tanishq74/FormulaVision.git
cd FormulaVision
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install psycopg2-binary
```

### Step 2: Configure Environment Variables

Create a `.env` file in the root directory based on the `.env.example` file:

```bash
cp .env.example .env
```

Add your OpenWeatherMap API key:
```env
OPENWEATHER_API_KEY=your_api_key_here
```

## Running Predictions

To execute a prediction model for a specific race (e.g., Monaco GP model):

```bash
python prediction8.py
```

### Sample Output Format

```
Predicted 2025 Monaco GP Winner

   Driver  PredictedRaceTime (s)
6     LEC              78.439039
1     NOR              78.504472
2     PIA              78.524145
8     HAM              78.570802
...

Model Error (MAE): 0.67 seconds

Predicted Podium:
P1: LEC
P2: NOR
P3: PIA
```

## Model Evaluation

The model uses Mean Absolute Error (MAE) as the primary evaluation metric. Gradient Boosting models are tuned with different estimators and learning rates depending on the dataset characteristics of each track.

## License

This project is licensed under the MIT License.
