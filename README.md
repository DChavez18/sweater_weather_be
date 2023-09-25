# Sweater Weather BE

**Sweater Weather BE** is a service-oriented architecture designed to assist users in planning road trips by providing essential weather information for their chosen destinations. This backend project caters to the needs of front-end developers by offering a set of APIs that adhere to a predefined JSON contract. While there is currently no front-end application available, the backend has been developed in accordance with wireframes provided by the front-end team, ensuring that it aligns with their requirements.

## Features
- **API Communication:** The front-end team communicates with the back-end team through a set of well-defined APIs.
- **Weather Information:** The application integrates with weather APIs to retrieve and display current and forecasted weather data at user-selected destinations.
- **Real-time Updates:** The weather information is updated in real-time to provide accurate and up-to-date weather forecasts.
- **Data Validation:** To ensure data accuracy and reliability, the back-end team has implemented robust error handling and data validation mechanisms.
- **Collaborative Development:** Close collaboration with the front-end team is maintained to understand and fulfill their requirements effectively.
- **Performance Optimization:** The APIs are optimized for high performance and scalability, capable of handling a large number of concurrent requests.
- **Quality Assurance:** Unit tests are conducted, and code reviews are performed to maintain code quality and identify and fix any bugs or issues.
- **Service-Oriented Architecture** Follows a service-oriented architecture, separating concerns and promoting modularity, making it easier to extend and maintain.

## Technologies
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Testing
- **Framework:** RSpec

## Set Up and Getting Started
To get started with **Sweater Weather BE** follow the instructions below:

1. Fork and Clone the repo
2. Using the terminal install the required dependencies:

  ```bundle install```

3. Set up your database:

  ```rails db:{drop,create,migrate}```

4. Configure API Keys:
  - Go to [Mapquest_API](https://developer.mapquest.com/documentation/geocoding-api/) to sign up for your api key.
  - Go to [Weather_API](https://www.weatherapi.com/) to sign up for your api key.

5. Encrypt Credentials using Rails Credentials

run ```EDITOR=CODE rails credentials:edit ```

This will create two files credentials.yml.enc & master.key and open up decrypted credentials.yml.enc

6. Add your API keys into the file that VS Code will ask you to open.

      WEATHER_API_KEY: <your_weather_api_key_here>

      MAPQUEST_API_KEY: <your_mapquest_api_key_here>

### Test

Run ```bundle exec rspec```

Test should be passing!

### Use

After installation is complete, the endpoints can be used for the front-end application in order to view specified data.


  
