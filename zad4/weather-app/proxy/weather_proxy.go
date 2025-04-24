package proxy

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type OpenMeteoResponse struct {
	CurrentWeather struct {
		Temperature float64 `json:"temperature"`
		WindSpeed   float64 `json:"windspeed"`
	} `json:"current_weather"`
}

type WeatherData struct {
	Temperature float64 `json:"temperature"`
	WindSpeed   float64 `json:"windspeed"`
}

func GetWeatherData(lat, lon float64) (*WeatherData, error) {
	url := fmt.Sprintf("https://api.open-meteo.com/v1/forecast?latitude=%f&longitude=%f&current_weather=true", lat, lon)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result OpenMeteoResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, err
	}

	return &WeatherData{
		Temperature: result.CurrentWeather.Temperature,
		WindSpeed:   result.CurrentWeather.WindSpeed,
	}, nil
}
