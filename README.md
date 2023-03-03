# Get Weather Forecast by Address

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

This project employs the popular Service-Object pattern and can be seen in `app/services/*`. Each of these Service Objects simply exposes a public `.call` method and does a single responsibility. Service Objects never talk direclty to each other. Rather, their return values are passed along by the concerned entity.

The basic flow is to recieve the user's address input and use it to retrive Latitude and Longitude geocoding info from Google Maps. Once we have figured that out we can pass it along to the Weather Forecast API and get back all kinds of useful info. We pluck the info we're intrested in and return a single response. Response fragments are cached for 30 minutes based on the user's inputs to avoid costly re-retrievals.

### API Integrations
This service relies on 
- Google's Maps API, and
- the NOAA GFS (HRRR) Forecast API provided by https://open-meteo.com/.
This service is confiured to use a personal API Key for Google's Maps API. If you with to change this to your personal Google Maps API Key you will have to run
```
bin/rails credentials:edit
```
and override the value with a new key. **Note:** Make sure your `$EDITOR` environment variable is set.

## Improvements
Many improvements can be made to the product as it exists:
1. UI -- the UI is in a dreadfully minimalistic state with no styling, only bare-bones proof of concept.
2. Error hadnling -- there is no intelligent error handling for when an API request fails or a processing error occurs.
3. Cache keys -- given the variable nature of the allowed input strings, some extra logic could improve cache indexing by checking for zip code *and* other details.
4. WeatherKit API -- and upgrad to using WeatherKit API is certianly in store (my developer account renewal took too long to process and I had to proceed with Plan B). 
