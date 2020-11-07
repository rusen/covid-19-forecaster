# Covid-19 Weekly Case Predictor and Data Scraper

## Installation:

```
$ pip install -r requirements.txt
```

## How to run

The notebooks should be run in order. At the end of the last notebook, the predictions are pushed to Google Cloud, if credentials are in place. The Google Cloud credentials file should be placed in a directory, and `GOOGLE_APPLICATION_CREDENTIALS_PATH` environment variable should be set in bash `~/.profile` file, pointing to this file.

The two scripts of interest are `run_weekly.sh`, which should be run on every Monday to make new weekly predictions, and `run_daily.sh`, which should be run on the remaining days of the week to update the country-based responses with updated travel advice.

### Example crontab entries:

Change `<username>` with your username below.
First, open the crontab
```
$ crontab -e
```

Add these two entries to the end of the crontab
```
$ 0 6 * * * mon /home/<username>/git/covid-19-forecaster/run_weekly.sh >> /tmp/weekly_predictions.log 2>£1
$ 0 6 * * * tue,wed,thu,fri,sat,sun /home/<username>/git/covid-19-forecaster/run_daily.sh >> /tmp/daily_predictions.log 2>£1
```

Voila, done. The scripts will be run at 6am in the mornings (GMT 00 time).

## Explanation

Currently, UK and US based advice is generated for every country in the world. They are in: `preds/weekly/<week_identifier>/response-UK.json` and `preds/weekly/<week_identifier>/response-US.json`.

Each country is indexed/represented with its 3-letter country code in the file. Regions are indexed with `<region_name> <country_code>`. You can obtain the region name by trimming the last 4 elements of the index name. Each country/region has the following fields:

### Common: 
- `risk_preds`: 8 numbers between 0-100. 0: 0 cases per 100k per week, 1: 2 cases per 100k, ..., 100: 200 cases (or more) per 100k per week.

### Only for countries:
- `category`: Current risk level. For UK, we have two values. 0 denotes low risk (less than weekly 20 cases per 100k people), and 2 denotes high risk (more than weekly 20 cases per 100k people). UK puts restrictions with high-risk countries. For US, there are three tiers: 0 (Low risk), 1 (Medium risk), 2: (High risk).
- `category_preds`: 8 category predictions according to the category definition of each country. 
- `confidence_preds`: Confidence of the category predictions above. 8 numbers between 0-2. 2 means high confidence, 1 means medium confidence, and 0 means low confidence in these predictions.
- `advice_url`: Official travel advice of the country according to UK or US.
- `summary`: Summary of a country's travel advice by UK or US.

### Only for city/regions:
- `name`: City/region name.
- `country`: Country name.
- `lat`: Latitude.
- `lon`: Longitude.
- `ccode`: 3-letter country code (can be used to index the country data in the same json).
- `graph_name`: Name of the graph file uploaded to the cloud.

The country-wise prediction plots are in `./output/<week_description>/weekly_preds/pred_plots`, as well as Google Cloud.
