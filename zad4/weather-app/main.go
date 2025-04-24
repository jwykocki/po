package main

import (
	"log"
	"net/http"
	"weather-app/controllers"
	"weather-app/models"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

func main() {
	db, err := gorm.Open(sqlite.Open("weather.db"), &gorm.Config{})
	if err != nil {
		log.Fatal("failed to connect to database:", err)
	}

	db.AutoMigrate(&models.Weather{})
	db.AutoMigrate(&models.Weather{}, &models.WeatherLog{})

	models.SeedWeatherData(db)

	http.HandleFunc("/weather", controllers.GetWeatherHandler(db))

	log.Println("Serwer działa na http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
