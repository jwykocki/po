package models

import "time"

type WeatherLog struct {
	ID          uint `gorm:"primaryKey"`
	City        string
	Temperature float64
	WindSpeed   float64
	Timestamp   time.Time
}
