package models

import "gorm.io/gorm"

type Weather struct {
	gorm.Model
	City string
	Lat  float64
	Lon  float64
}

func SeedWeatherData(db *gorm.DB) {
	locations := []Weather{
		{City: "Warsaw", Lat: 52.2297, Lon: 21.0122},
		{City: "Krakow", Lat: 50.0647, Lon: 19.9450},
		{City: "Wroclaw", Lat: 51.1079, Lon: 17.0385},
		{City: "Gdansk", Lat: 54.3520, Lon: 18.6466},
		{City: "Poznan", Lat: 52.4084, Lon: 16.9342},
		{City: "Lodz", Lat: 51.7592, Lon: 19.4560},
		{City: "Szczecin", Lat: 53.4289, Lon: 14.5530},
		{City: "Bydgoszcz", Lat: 53.1235, Lon: 18.0084},
		{City: "Lublin", Lat: 51.2465, Lon: 22.5687},
		{City: "Katowice", Lat: 50.2649, Lon: 19.0238},
	}

	for _, location := range locations {
		var count int64
		db.Model(&Weather{}).Where("city = ?", location.City).Count(&count)
		if count == 0 {
			db.Create(&location)
		}
	}
}
