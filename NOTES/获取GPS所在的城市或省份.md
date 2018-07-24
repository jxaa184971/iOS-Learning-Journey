# 获取GPS所在的城市或省份 - CoreLocation

## info.plist文件
在info.plist中添加`NSLocationWhenInUseUsageDescription`和`NSLocationAlwaysUsageDescription`  

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/96B4CEB0-9B0D-4981-BDC7-8F24C3E4DE3F.png)

#### PS:NSLocationAlwaysUsageDescription提示部分字符串可以不添加  

## 导入头文件：
```objective-c
#import <CoreLocation/CoreLocation.h>
```
#### PS：项目也需要导入CoreLocation库

## ViewController实现CLLocationManagerDelegate
```objective-c
@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
}
```


## 初始化LocationManager及请求GPS位置更新
iOS8以后需要先通过`requestWhenInUseAuthorization`向用户获取权限后再调用`startUpdatingLocation` 
```objective-c
-(void)getDeviceLocation {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 10.0;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            [self.locationManager startUpdatingLocation];
        } else {
            [self.locationManager startUpdatingLocation];
        }
    }
}
```

## 实现CLLocationManagerDelegate方法
定位成功
```objective-c
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //[self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];

    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0]; //获取地理信息数据
            NSString *currentCity = placeMark.administrativeArea; //省份
            if (!currentCity) {
                currentCity = placeMark.locality;  //直辖市
            }
            if (!currentCity) {
                NSLog(@"No location");
            }
            NSLog(@"%@",currentCity); //这就是当前的城市
            NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
    }];
}
```

定位失败
```objective-c
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}
```
