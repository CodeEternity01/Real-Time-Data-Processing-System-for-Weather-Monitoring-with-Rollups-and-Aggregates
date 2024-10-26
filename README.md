# Weather Monitoring Application

A Flutter-based real-time weather monitoring system that retrieves, processes, and visualizes weather data from the OpenWeatherMap API. This application provides daily summaries, visualizations, and alerting based on user-configurable thresholds to enhance weather insights for major metro cities in India.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Setup and Installation](#setup-and-installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Rollups and Aggregates](#rollups-and-aggregates)
- [Visualizations](#visualizations)
- [Testing](#testing)
- [GitHub Repository](#github-repository)

## Overview
This application monitors real-time weather conditions using data from the OpenWeatherMap API. It retrieves weather data every few minutes for the major metros in India (Delhi, Mumbai, Chennai, Bangalore, Kolkata, Hyderabad), processes the information, and provides daily summaries. Additionally, it triggers alerts based on user-defined thresholds, such as high temperatures or specific weather conditions.

## Features
1. **Real-Time Data Retrieval**: Retrieves weather data every 5 minutes.
2. **Daily Weather Summaries**:
   - Average, maximum, and minimum temperatures.
   - Dominant weather condition (e.g., Rain, Snow, Clear).
3. **User-Configurable Alerting**:
   - Set temperature or weather condition thresholds.
   - Alerting via console or email notification.
4. **Visualizations**: Daily summaries, historical trends, and alerts.

#Install dependencies:

# Weather Monitoring Application Setup
## Step 1: Install Dependencies Run the following command to get the necessary packages: ```bash flutter pub get ``` ## Step 2: API Key Setup 1. Sign up on [OpenWeatherMap](https://openweathermap.org/) and obtain a free API key. 2. Replace `<'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${'40ce3f067b530f0109a65a11d17f032d'>` in the code with your actual API key. ## Step 3: Run the Application Execute the following command to run the application: ```bash flutter run ``` ## Configuration - **Data Retrieval Interval**: The interval for data retrieval can be configured in the application settings (default: **5 minutes**). - **User-defined Alerts**: Set thresholds for alerts to customize notifications for weather conditions such as temperature limits or specific conditions (e.g., heatwave alerts). ## Usage - Upon launch, the application retrieves weather data every **5 minutes**. ### Daily Summaries At the end of each day, a summary is stored containing: - **Average Temperature** - **Maximum and Minimum Temperatures** - **Dominant Weather Condition** ### Alerts - Alerts trigger if thresholds are breached, with real-time notifications displayed on the console or sent via email (optional). ## Rollups and Aggregates ### Daily Weather Summary Aggregates daily data to provide: - **Average Temperature** - **Maximum and Minimum Temperatures** - **Dominant Weather Condition** based on the most frequent occurrences. ### Alerting Thresholds - Configure temperature or condition thresholds (e.g., alert if temperature > 35°C for two consecutive updates). - Alerts are triggered if conditions are met, with messages displayed in-app. ## Visualizations The application includes visualizations for: - **Daily Summaries**: Displays weather trends over the course of the day. - **Historical Trends**: Track historical data on average temperatures and weather patterns. - **Alerts**: Shows a log of all triggered alerts. ## Testing ### System Setup - Verify that the system starts successfully and connects to the OpenWeatherMap API with a valid API key. ### Data Retrieval - Simulate API calls at the defined interval and confirm data retrieval for each city. - Ensure response parsing correctly interprets each weather parameter. ### Temperature Conversion - Confirm that temperatures convert from Kelvin to Celsius accurately. ### Alert Thresholds - Simulate data exceeding thresholds to ensure alerts trigger as expected.
