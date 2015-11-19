# JSONToModel

 convert json string to  objective-c model for MJExtenstion




# Usage
Replace strJSON with your json string .  After running project, you can see .h and .m file content in the log window.

# Example 
<img width="550" alt="vscodereadme" align="middle"  src="img.gif">
1. json string is

 
```json
{
    "weather": [
        {
            "names": "china",
            "data": [
                "2℃",
                "-2℃",
                "1℃",
                "11℃",
                "-1℃",
                "1℃"
            ],
            "times": [
                10,
                11,
                12,
                13,
                14,
                15
            ]
        },
        {
            "names": "america",
            "data": [
                "2℃",
                "-12℃",
                "11℃",
                "0℃",
                "-1℃",
                "1℃"
            ],
            "times": [
                10,
                11,
                12,
                13,
                14,
                15
            ]
        }
    ]
}

2. After Running the project, you cat get 
.h file is 
```objc
@interface WeatherModelWeather : NSObject
@property (copy, nonatomic) NSString *names;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *times;

@end

@interface WeatherModel : NSObject
@property (strong, nonatomic) NSArray *weather;

@end

```

.m file is 
```objc
#import "WeatherModel.h"

@implementation WeatherModelWeather : NSObject

+ (NSDictionary *)objectClassInArray
{
        return @{
		};
}
@end

@implementation WeatherModel : NSObject

+ (NSDictionary *)objectClassInArray
{
        return @{
			@"weather":@"WeatherModelWeather"
		};
}
@end

```



