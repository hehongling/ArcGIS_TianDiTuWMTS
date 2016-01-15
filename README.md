# ArcGIS_TianDiTuWMTS
使用天地图WMTS-基于&lt;ArcGIS Runtime SDK for iOS 10.2.5>   
###### 因公司业务需要使用ArcGIS加载天地图，所以将自己学习ArcGIS过程中写的一些Demo发到GitHub上来，希望大家在使用过程中有什么问题多多交流
##### 使用方法
* 1 建立图层容器（AGSMapView)  

````
    AGSMapView *mapView = [[AGSMapView alloc] initWithFrame:self.view.bounds];
    self.mapView = mapView;
    [self.view addSubview:mapView];
````

* 2 建立并添加图层(TianMapLayer->AGSTiledServiceLayer)  

````  
    NSError *error;
//    矢量地图层
    TianMapLayer *vectorLayer = [[TianMapLayer alloc] initWithType:TianMapTypeVector2000 localServiceURL:nil error:&error];
    [self.mapView addMapLayer:vectorLayer withName:@"Vector2000"];
    
//    中文标注层
    TianMapLayer *annoLayer = [[TianMapLayer alloc] initWithType:TianMapTypeVectorAnnotationChinese2000 localServiceURL:nil error:&error];
    [self.mapView addMapLayer:annoLayer withName:@"VectorAnnotationChinese2000"];
````
* 3 加载完成后显示用户中心

```` 
- (void)mapViewDidLoad:(AGSMapView *)mapView {
    [mapView.locationDisplay startDataSource];
    mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
}
````

<div  align="center">    
<img src="https://github.com/HonglingHe/ArcGIS_TianDiTuWMTS/blob/master/Images/TianMapHefei.png" width = "300" height = "480" alt="示例图片" align=center />
</div>