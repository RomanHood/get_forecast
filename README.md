# Get Forecasts by Address

This service accepts an address from a user and fetches the current temperature plus the 7-day forecast for high and low temperatures.

### Development Setup
#### Pre-requisites
- Ruby 3.0.0 or higher
- Rails 7.0.4

From the repo root run:
```
bundle install
```

followed by

```
rails dev:cache
```
to enable caching while running the service locally.

#### Database
There is no application database for this project. This project exclusively uses 3rd party integrations to retrieve its data and so there is no database migration step.

#### Tests
After intalling the dependencies you should run the test suites to get and overview of features and behavior.
```
rspec -f d
```

This project employs the popular Service-Object pattern and can be seen in `app/services/*`

### API Integrations
This service relies on 
- Google's Maps API, and
- the NOAA GFS (HRRR) Forecast API provided by https://open-meteo.com/.
This service is confiured to use a personal API Key for Google's Maps API. If you with to change this to your personal Google Maps API Key you will have to run
```
bin/rails credentials:edit
```
and override the value with a new key. **Note:** Make sure your `$EDITOR` environment variable is set.




