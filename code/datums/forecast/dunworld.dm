//Dunworld is meant to be wet, leafy, snowy sort of weather. On occasion, ash storms from mountdecap and fireflies.
/datum/forecast/dunworld
	day_weather = list(/datum/particle_weather/rain_gentle = 10, )
	dawn_weather = list(/datum/particle_weather/rain_gentle = 10)
	dusk_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/ashstorm = 100)
	night_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/ashstorm = 4)