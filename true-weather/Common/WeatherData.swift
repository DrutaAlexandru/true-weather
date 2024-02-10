//
//  WeatherData.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

/// https://open-meteo.com/en/docs/
/// Weather variable documentation
/// WMO Weather interpretation codes (WW)
/// |  Code          |  Description
/// |  0                 | Clear sky
/// |  1, 2, 3         | Mainly clear, partly cloudy, and overcast
/// |  45, 48         | Fog and depositing rime fog
/// |  51, 53, 55   | Drizzle: Light, moderate, and dense intensity
/// |  56, 57         | Freezing Drizzle: Light and dense intensity
/// |  61, 63, 65   | Rain: Slight, moderate and heavy intensity
/// |  66, 67         | Freezing Rain: Light and heavy intensity
/// |  71, 73, 75   | Snow fall: Slight, moderate, and heavy intensity
/// |  77               | Snow grains
/// |  80, 81, 82   | Rain showers: Slight, moderate, and violent
/// |  85, 86         | Snow showers slight and heavy
/// |  95               | Thunderstorm: Slight or moderate
/// |  96, 99         | Thunderstorm with slight and heavy hail

enum WeatherData {
    case clear
    case mainlyClear
    case partialCloudy
    case overcast
    case fog
    case lightDrizzle
    case moderateDrizzle
    case denseDrizzle
    case lightFreezingDrizzle
    case heavyFreezingDrizzle
    case lightRain
    case moderateRain
    case heavyRain
    case freezingLightRain
    case freezingHeavyRain
    case slightSnowFall
    case moderateSnowFall
    case heavySnowFall
    case snowGrains
    case slightRainShowers
    case moderateRainShowers
    case violentRainShowers
    case slightSnowShowers
    case heavySnowShowers
    case thunderstorm
    case slightThunderstorm
    case heavyThunderstorm
    
    init(code: Int) {
        switch code {
        case 1: self = .mainlyClear
        case 2: self = .partialCloudy
        case 3: self = .overcast
        case 45, 48: self = .fog
        case 51: self = .lightDrizzle
        case 53: self = .moderateDrizzle
        case 55: self = .denseDrizzle
        case 56: self = .lightFreezingDrizzle
        case 57: self = .heavyFreezingDrizzle
        case 61: self = .lightRain
        case 63: self = .moderateRain
        case 65: self = . heavyRain
        case 66: self = .freezingLightRain
        case 67: self = .freezingHeavyRain
        case 71: self = .slightSnowFall
        case 73: self = .moderateSnowFall
        case 75: self = .heavySnowFall
        case 77: self = .snowGrains
        case 80: self = .slightRainShowers
        case 81: self = .moderateRainShowers
        case 82: self = .violentRainShowers
        case 85: self = .slightSnowShowers
        case 86: self = .heavySnowShowers
        case 95: self = .thunderstorm
        case 96: self = .slightThunderstorm
        case 99: self = .heavyThunderstorm
        default: self = .clear
        }
    }
    
    var description: String {
        switch self {
        case .clear: "Clear sky"
        case .mainlyClear: "Mainly clear"
        case .partialCloudy: "Partly cloudy"
        case .overcast: "Overcast"
        case .fog: "Fog"
        case .lightDrizzle: "Light Drizzle"
        case .moderateDrizzle: "Drizzle"
        case .denseDrizzle: "Denze Drizzle"
        case .lightFreezingDrizzle: "Light Freezing Drizzle"
        case .heavyFreezingDrizzle: "Heavy Freezing Drizzle"
        case .lightRain: "Slight Rain"
        case .moderateRain: "Rain"
        case .heavyRain: "Heavy Rain"
        case .freezingLightRain: "Freezing Rain"
        case .freezingHeavyRain: "Freezing Heavy Rain"
        case .slightSnowFall: "Slight Snow Fall"
        case .moderateSnowFall: "Snow Fall"
        case .heavySnowFall: "Heavy Snow Fall"
        case .snowGrains: "Snow Grains"
        case .slightRainShowers: "Slight Rain Showers"
        case .moderateRainShowers: "Rain Showers"
        case .violentRainShowers: "Violent Rain Showers"
        case .slightSnowShowers: "Snow Showers"
        case .heavySnowShowers: "Heavy Snow Showers"
        case .thunderstorm: "Thunderstorm"
        case .slightThunderstorm: "Slight Hail Thunderstorm"
        case .heavyThunderstorm: "Heavy Hail Thunderstorm"
        }
    }
    
    var icon: String {
        switch self {
        case .clear: ""
        case .mainlyClear: ""
        case .partialCloudy: ""
        case .overcast: ""
        case .fog: ""
        case .lightDrizzle: ""
        case .moderateDrizzle: ""
        case .denseDrizzle: ""
        case .lightFreezingDrizzle: ""
        case .heavyFreezingDrizzle: ""
        case .lightRain: ""
        case .moderateRain: ""
        case .heavyRain: ""
        case .freezingLightRain: ""
        case .freezingHeavyRain: ""
        case .slightSnowFall: ""
        case .moderateSnowFall: ""
        case .heavySnowFall: ""
        case .snowGrains: ""
        case .slightRainShowers: ""
        case .moderateRainShowers: ""
        case .violentRainShowers: ""
        case .slightSnowShowers: ""
        case .heavySnowShowers: ""
        case .thunderstorm: ""
        case .slightThunderstorm: ""
        case .heavyThunderstorm: ""
        }
    }
    
    var title: String {
        switch self {
        case .clear: return "Fucking love is in the air"
        case .mainlyClear: return "Fucking crystal clear skies"
        case .partialCloudy: return "Clouds can't make up their fucking minds"
        case .overcast: return "Just fucking grey skies"
        case .fog: return "Fcuking foggy as hell"
        case .lightDrizzle: return "Fucking drizzling like a sneeze"
        case .moderateDrizzle: return "Drizzle turning into a fucking shower"
        case .denseDrizzle: return "Drizzle so thick you can fucking taste it"
        case .lightFreezingDrizzle: return "Fucking chilly drizzle"
        case .heavyFreezingDrizzle: return "Drizzle turning into a fucking downpour of ice"
        case .lightRain: return "Just a fucking sprinkle"
        case .moderateRain: return "Rain pouring like a fucking broken faucet"
        case .heavyRain: return "Fucking downpour of biblical proportions"
        case .freezingLightRain: return "Fucking ice cold raindrops"
        case .freezingHeavyRain: return "Torrential fucking rain with a side of frostbite"
        case .slightSnowFall: return "Fcuking snowflakes drifting lazily"
        case .moderateSnowFall: return "Snow falling like a fucking confetti"
        case .heavySnowFall: return "Fcuking blizzard conditions"
        case .snowGrains: return "Tiny snow grains tickling your fucking face"
        case .slightRainShowers: return "Fucking slight rain showers passing by"
        case .moderateRainShowers: return "Rain showers drenching the fucking neighborhood"
        case .violentRainShowers: return "Rain showers hitting like a fucking waterfall"
        case .slightSnowShowers: return "Fucking snow showers sprinkling the ground"
        case .heavySnowShowers: return "Snow showers burying fucking everything in sight"
        case .thunderstorm: return "Thunderstorm brewing up a fucking storm"
        case .slightThunderstorm: return "Slight thunderstorm with a hint of a fucking drama"
        case .heavyThunderstorm: return "Fucking raging thunderstorm"
        }
    }
    
    var subtitle: String {
        switch self {
        case .clear: return "It's sunny for those who didn't get it"
        case .mainlyClear: return "Not a cloud in sight"
        case .partialCloudy: return "Clouds scattered like my thoughts"
        case .overcast: return "No filter needed"
        case .fog: return "Can't see my hand in front of my face"
        case .lightDrizzle: return "Barely enough to wet the pavement"
        case .moderateDrizzle: return "Time to break out the umbrella"
        case .denseDrizzle: return "Bring a towel, it's soaking out there"
        case .lightFreezingDrizzle: return "Watch out for icy patches"
        case .heavyFreezingDrizzle: return "Ice cubes falling from the sky"
        case .lightRain: return "Don't forget your raincoat"
        case .moderateRain: return "Better find some shelter"
        case .heavyRain: return "Stay indoors unless you want to swim"
        case .freezingLightRain: return "Cold and wet, a winning combination"
        case .freezingHeavyRain: return "Hail the size of golf balls"
        case .slightSnowFall: return "Enjoy the winter wonderland"
        case .moderateSnowFall: return "Time to build a snowman"
        case .heavySnowFall: return "Cancel all plans, it's snow day"
        case .snowGrains: return "Feels like sandpaper falling from the sky"
        case .slightRainShowers: return "Umbrella optional"
        case .moderateRainShowers: return "Hope you brought a raincoat"
        case .violentRainShowers: return "Hold onto your hat, it's pouring"
        case .slightSnowShowers: return "Snowflakes gently falling"
        case .heavySnowShowers: return "Snowflakes the size of dinner plates"
        case .thunderstorm: return "Lightning flashing, thunder crashing"
        case .slightThunderstorm: return "Rolling thunder in the distance"
        case .heavyThunderstorm: return "Apocalypse now, with thunder and lightning"
        }
    }
}
