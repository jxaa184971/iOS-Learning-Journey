# UIImagePickerController - 相机照片选择器

### UIImagePickerControllerSourceType枚举
```objective-c
typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
    UIImagePickerControllerSourceTypePhotoLibrary,   //图库、相册
    UIImagePickerControllerSourceTypeCamera,   //相机
    UIImagePickerControllerSourceTypeSavedPhotosAlbum //相机胶卷
} __TVOS_PROHIBITED;
```

### 类方法 

用于判断设备是否支持某一数据源：
```objective-c
+ (BOOL)isSourceTypeAvailable:(UIImagePickerControllerSourceType)sourceType;   // returns YES if source is available (i.e. camera present)
```

返回某一数据源支持的媒体类型 public.image(静态图片)、public.movie(视频)
```objective-c
+ (nullable NSArray<NSString *> *)availableMediaTypesForSourceType:(UIImagePickerControllerSourceType)sourceType; // returns array of available media types (i.e. kUTTypeImage)
```

用于判断设备相机是否可用：
```objective-c
+ (BOOL)isCameraDeviceAvailable:(UIImagePickerControllerCameraDevice)cameraDevice   NS_AVAILABLE_IOS(4_0); // returns YES if camera device is available 
```

### 示例
开始拍照
```objective-c
- (void)takePhoto {
    //判断机器是否支持从相机获取照片
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //设置sourceType为相机
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置代理
        picker.delegate = self;
        //拍照后是否支持编辑照片
        picker.allowsEditing = YES;
        // 设置进入相机时使用前置或后置摄像头
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 打开拍照页面
        [self presentViewController:picker animated:YES completion:^{}];
    }
}
```

打开本地相册
```objective-c
- (void)localPhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:^{}];
    }
}
```

代理方法 - 照片选择完成
```objective-c
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *originalImage, *editedImage;    
        //获取编辑后的照片
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //获取原始照片
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];

        //关闭相册界面
        [picker dismissViewControllerAnimated:YES  completion:^{}];
    }
}
```

代理方法 - 取消选择照片
```objective-c
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES  completion:^{}];
}
```

### PS：两个代理方法都必须关闭相册的界面，否则将无法释放。
