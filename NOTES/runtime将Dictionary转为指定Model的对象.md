# runtime将Dictionary转为指定Model的对象
在实际开发中，我们经常会需要将服务端传来的数据转化为objective-c内的类来进行使用。使用以下的方法，可以在runtime将字典转化为你所需要的类的对象，让数据操作使用更加方便。

### 实现原理
* 执行完`class_copyPropertyList`方法后，返回model类中**第一个属性指向的内存地址**, 传入propertyCount的指针`&propertyCount`，获取到model类中所有**属性的个数**，注意这里返回的只是所有带`@property`前缀的属性。
* 因为model类中属性指向的内存地址是连续的，通过第一个属性地址+index的方法，获取所有属性的`objc_property_t`
* 再通过调用`property_getName`方法，获取属性的名字。再将获得的属性的名字作为key从字典中获取对应的值，最后通过`[modelObj setValue: forKey:]`为对应的model对象设置属性
* 使用完后将`propertyList`释放

#### PS: 使用完之后一定要将propertyList释放，否则会导致内存泄露！！！

### 代码样例
```objective-c
id setDicToDataModel(NSDictionary *dic, Class dataClass){
    int i;
    unsigned int propertyCount = 0; //记录属性的个数
    objc_property_t *propertyList = class_copyPropertyList(dataClass, &propertyCount); //返回第一个属性地址
    NSMutableArray *propertyNameList = [NSMutableArray array];
    for ( i=0; i < propertyCount; i++ ) {
        //通过指向第一个属性的内存地址+index的方式获取所有的属性objc_property_t对象
        objc_property_t *thisProperty = propertyList + i;
        //获取属性名字
        const char* propertyName = property_getName(thisProperty);
        NSString *string = [NSString stringWithFormat:@"%s",propertyName];
        [propertyNameList addObject:string];
    }
    
    if (propertyNameList.count > 0) {
        id dataModal = nil;
        dataModal = [[dataClass alloc] init];
        [propertyNameList enumerateObjectsUsingBlock:^(NSString* key, NSUInteger idx, BOOL *stop) {
            if (dic[key] && ([dic[key] length] > 0)) {
                //字典中用获得的属性名作为key查找value，如果有则为对应的类对象的对应属性设置value。
                [dataModal setValue:dic[key] forKey:key];
            }
        }];

        //立即释放propertyList指向的内存
        free(propertyList);
        return dataModal;
    }else return nil;
}
```
