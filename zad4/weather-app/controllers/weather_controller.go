package controllers

import (
	"encoding/json"
	"net/http"
	"time"
	"weather-app/models"
	"weather-app/proxy"

	"gorm.io/gorm"
)

func GetWeatherHandler(db *gorm.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		city := r.URL.Query().Get("city")
		if city == "" {
			http.Error(w, "Missing city param", http.StatusBadRequest)
			return
		}

		var location models.Weather
		if err := db.First(&location, "city = ?", city).Error; err != nil {
			http.Error(w, "City not found", http.StatusNotFound)
			return
		}

		weather, err := proxy.GetWeatherData(location.Lat, location.Lon)
		if err != nil {
			http.Error(w, "Failed to get weather", http.StatusInternalServerError)
			return
		}

		log := models.WeatherLog{
			City:        city,
			Temperature: weather.Temperature,
			WindSpeed:   weather.WindSpeed,
			Timestamp:   time.Now(),
		}
		db.Create(&log)

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(weather)
	}
}
