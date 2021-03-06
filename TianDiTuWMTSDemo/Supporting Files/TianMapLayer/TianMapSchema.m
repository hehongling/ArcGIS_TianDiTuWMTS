//
//  TianMapSchema.m
//  TianMapLayer
//
//  Created by Henry on 11/22/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import "TianMapSchema.h"

//mecator
#define kURL_VECTOR_MERCATOR @"http://t0.tianditu.com/vec_w/wmts"
#define kURL_VECTOR_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cva_w/wmts"
#define kURL_VECTOR_ANNOTATION_ENGLISH_MERCATOR @"http://t0.tianditu.com/eva_w/wmts"
#define kURL_IMAGE_MERCATOR @"http://t0.tianditu.com/img_w/wmts"
#define kURL_IMAGE_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cia_w/wmts"
#define kURL_IMAGE_ANNOTATION_ENGLISH_MERCATOR @"http://t0.tianditu.com/cia_w/wmts"
#define kURL_TERRAIN_MERCATOR @"http://t0.tianditu.com/ter_w/wmts"
#define kURL_TERRAIN_ANNOTATION_CHINESE_MERCATOR @"http://t0.tianditu.com/cta_w/wmts"

//cgcs2000
#define kURL_VECTOR_2000 @"http://t0.tianditu.com/vec_c/wmts"
#define kURL_VECTOR_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cva_c/wmts"
#define kURL_VECTOR_ANNOTATION_ENGLISH_2000 @"http://t0.tianditu.com/eva_c/wmts"
#define kURL_IMAGE_2000 @"http://t0.tianditu.com/img_c/wmts"
#define kURL_IMAGE_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cia_c/wmts"
#define kURL_IMAGE_ANNOTATION_ENGLISH_2000 @"http://t0.tianditu.com/cia_c/wmts"
#define kURL_TERRAIN_2000 @"http://t0.tianditu.com/ter_c/wmts"
#define kURL_TERRAIN_ANNOTATION_CHINESE_2000 @"http://t0.tianditu.com/cta_c/wmts"

//services
#define kLAYER_NAME_VECTOR @"vec"
#define kLAYER_NAME_VECTOR_ANNOTATION_CHINESE @"cva"
#define kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH @"eva"
#define kLAYER_NAME_IMAGE @"img"
#define kLAYER_NAME_IMAGE_ANNOTATION_CHINESE @"cia"
#define kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH @"eia"
#define kLAYER_NAME_TERRAIN @"ter"
#define kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE @"cta"

//Matrixset
#define kTILE_MATRIX_SET_MERCATOR @"w"
#define kTILE_MATRIX_SET_2000 @"c"

//SRID
#define kSRID_2000 4490
#define kSRID_MERCATOR 102100

#define X_MIN_2000 -180.0
#define Y_MIN_2000 -90.0
#define X_MAX_2000 180.0
#define Y_MAX_2000 90.0

#define X_MIN_MERCATOR -20037508.3427892
#define Y_MIN_MERCATOR -20037508.3427892
#define X_MAX_MERCATOR 20037508.3427892
#define Y_MAX_MERCATOR 20037508.3427892

#define kMIN_ZOOM_LEVEL 0
#define kMAX_ZOOM_LEVEL 16
#define kTILE_WIDTH 256
#define kTILE_HEIGHT 256
#define kDPI 96


@interface TianMapSchema ()

@property (nonatomic, strong, readwrite) AGSSpatialReference *spatialReference;
@property (nonatomic, strong, readwrite) AGSEnvelope *fullEnvelope;
@property (nonatomic, strong, readwrite) AGSTileInfo *tileInfo;
@property (nonatomic, copy, readwrite) NSString *layerName;
@property (nonatomic, copy, readwrite) NSString *tileMatrixSet;

@end

@implementation TianMapSchema

+ (instancetype)schemaWithMapType:(TianMapType)mapType {
    TianMapSchema *schema = [[self alloc] init];
    
    double xMin, yMin, xMax, yMax;
    AGSSpatialReference *sr;
    AGSPoint *origin;
    NSMutableArray *lods;
    
    if (mapType < 8) { //墨卡托
        schema.tileMatrixSet = kTILE_MATRIX_SET_MERCATOR;
        
        xMin = X_MIN_MERCATOR;
        yMin = Y_MIN_MERCATOR;
        xMax = X_MAX_MERCATOR;
        yMax = Y_MAX_MERCATOR;
        sr = [[AGSSpatialReference alloc] initWithWKID:kSRID_MERCATOR];
        origin = [AGSPoint pointWithX:X_MIN_MERCATOR y:Y_MAX_MERCATOR spatialReference:sr];
        lods = [NSMutableArray arrayWithObjects:
                [[AGSLOD alloc] initWithLevel:0 resolution:156543.34701761068 scale:591658710.9091312],
                [[AGSLOD alloc] initWithLevel:1 resolution:78271.51696402048 scale: 2.958293554545656E8],
                [[AGSLOD alloc] initWithLevel:2 resolution:39135.75848201024 scale: 1.479146777272828E8],
                [[AGSLOD alloc] initWithLevel:3 resolution:19567.87924100512 scale: 7.39573388636414E7],
                [[AGSLOD alloc] initWithLevel:4 resolution:9783.93962050256 scale: 3.69786694318207E7],
                [[AGSLOD alloc] initWithLevel:5 resolution:4891.96981025128 scale: 1.848933471591035E7],
                [[AGSLOD alloc] initWithLevel:6 resolution:2445.98490512564 scale: 9244667.357955175],
                [[AGSLOD alloc] initWithLevel:7 resolution:1222.99245256282 scale: 4622333.678977588],
                [[AGSLOD alloc] initWithLevel:8 resolution:611.49622628141 scale: 2311166.839488794],
                [[AGSLOD alloc] initWithLevel:9 resolution:305.748113140705 scale: 1155583.419744397],
                [[AGSLOD alloc] initWithLevel:10 resolution:152.8740565703525 scale: 577791.7098721985],
                [[AGSLOD alloc] initWithLevel:11 resolution:76.43702828517625 scale: 288895.85493609926],
                [[AGSLOD alloc] initWithLevel:12 resolution:38.21851414258813 scale: 144447.92746804963],
                [[AGSLOD alloc] initWithLevel:13 resolution:19.109257071294063 scale: 72223.96373402482],
                [[AGSLOD alloc] initWithLevel:14 resolution:9.554628535647032 scale: 36111.98186701241],
                [[AGSLOD alloc] initWithLevel:15 resolution:4.777314267823516 scale: 18055.990933506204],
                [[AGSLOD alloc] initWithLevel:16 resolution:2.388657133911758 scale:9027.995466753102],
                [[AGSLOD alloc] initWithLevel:17 resolution:1.194328566955879 scale: 4513.997733376551],
                [[AGSLOD alloc] initWithLevel:18 resolution:0.5971642834779395 scale: 2256.998866688275],
                nil];
    } else { // 国标2000
        schema.tileMatrixSet = kTILE_MATRIX_SET_2000;
        
        xMin = X_MIN_2000;
        yMin = Y_MIN_2000;
        xMax = X_MAX_2000;
        yMax = Y_MAX_2000;
        sr = [[AGSSpatialReference alloc] initWithWKID:kSRID_2000];
        origin = [AGSPoint pointWithX:X_MIN_2000 y:Y_MAX_2000 spatialReference:sr];
        lods = [NSMutableArray arrayWithObjects:
                [[AGSLOD alloc] initWithLevel:0 resolution:1.4062499999783 scale:591658710.9],
                [[AGSLOD alloc] initWithLevel:1 resolution:0.7031249999891485 scale: 2.958293554545656E8],
                [[AGSLOD alloc] initWithLevel:2 resolution:0.35156249999999994 scale: 1.479146777272828E8],
                [[AGSLOD alloc] initWithLevel:3 resolution:0.17578124999999997 scale: 7.39573388636414E7],
                [[AGSLOD alloc] initWithLevel:4 resolution:0.08789062500000014 scale: 3.69786694318207E7],
                [[AGSLOD alloc] initWithLevel:5 resolution:0.04394531250000007 scale: 1.848933471591035E7],
                [[AGSLOD alloc] initWithLevel:6 resolution:0.021972656250000007 scale: 9244667.357955175],
                [[AGSLOD alloc] initWithLevel:7 resolution:0.01098632812500002 scale: 4622333.678977588],
                [[AGSLOD alloc] initWithLevel:8 resolution:0.00549316406250001 scale: 2311166.839488794],
                [[AGSLOD alloc] initWithLevel:9 resolution:0.0027465820312500017 scale: 1155583.419744397],
                [[AGSLOD alloc] initWithLevel:10 resolution:0.0013732910156250009 scale: 577791.7098721985],
                [[AGSLOD alloc] initWithLevel:11 resolution:0.000686645507812499 scale: 288895.85493609926],
                [[AGSLOD alloc] initWithLevel:12 resolution:0.0003433227539062495 scale: 144447.92746804963],
                [[AGSLOD alloc] initWithLevel:13 resolution:0.00017166137695312503 scale: 72223.96373402482],
                [[AGSLOD alloc] initWithLevel:14 resolution:0.00008583068847656251 scale: 36111.98186701241],
                [[AGSLOD alloc] initWithLevel:15 resolution:0.000042915344238281406 scale: 18055.990933506204],
                [[AGSLOD alloc] initWithLevel:16 resolution:0.000021457672119140645 scale:9027.995466753102],
                [[AGSLOD alloc] initWithLevel:17 resolution:0.000010728836059570307 scale: 4513.997733376551],
                [[AGSLOD alloc] initWithLevel:18 resolution:0.000005364418029785169 scale: 2256.998866688275],
                nil];
    }
    
    // other params
    switch (mapType) {
        case 0:
            schema.baseUrl= kURL_VECTOR_MERCATOR;
            schema.layerName = kLAYER_NAME_VECTOR;
            break;
        case 1:
            schema.baseUrl= kURL_VECTOR_ANNOTATION_CHINESE_MERCATOR;
            schema.layerName = kLAYER_NAME_VECTOR_ANNOTATION_CHINESE;
            break;
        case 2:
            schema.baseUrl= kURL_VECTOR_ANNOTATION_ENGLISH_MERCATOR;
            schema.layerName = kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH;
            break;
        case 3:
            schema.baseUrl= kURL_IMAGE_MERCATOR;
            schema.layerName = kLAYER_NAME_IMAGE;
            break;
        case 4:
            schema.baseUrl= kURL_IMAGE_ANNOTATION_CHINESE_MERCATOR;
            schema.layerName = kLAYER_NAME_IMAGE_ANNOTATION_CHINESE;
            break;
        case 5:
            schema.baseUrl= kURL_IMAGE_ANNOTATION_ENGLISH_MERCATOR;
            schema.layerName = kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH;
            break;
        case 6:
            schema.baseUrl= kURL_TERRAIN_MERCATOR;
            schema.layerName = kLAYER_NAME_TERRAIN;
            break;
        case 7:
            schema.baseUrl= kURL_TERRAIN_ANNOTATION_CHINESE_MERCATOR;
            schema.layerName = kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE;
            break;
        case 8:
            schema.baseUrl= kURL_VECTOR_2000;
            schema.layerName = kLAYER_NAME_VECTOR;
            break;
        case 9:
            schema.baseUrl= kURL_VECTOR_ANNOTATION_CHINESE_2000;
            schema.layerName = kLAYER_NAME_VECTOR_ANNOTATION_CHINESE;
            break;
        case 10:
            schema.baseUrl= kURL_VECTOR_ANNOTATION_ENGLISH_2000;
            schema.layerName = kLAYER_NAME_VECTOR_ANNOTATION_ENGLISH;
            break;
        case 11:
            schema.baseUrl= kURL_IMAGE_2000;
            schema.layerName = kLAYER_NAME_IMAGE;
            break;
        case 12:
            schema.baseUrl= kURL_IMAGE_ANNOTATION_CHINESE_2000;
            schema.layerName = kLAYER_NAME_IMAGE_ANNOTATION_CHINESE;
            break;
        case 13:
            schema.baseUrl= kURL_IMAGE_ANNOTATION_ENGLISH_2000;
            schema.layerName = kLAYER_NAME_IMAGE_ANNOTATION_ENGLISH;
            break;
        case 14:
            schema.baseUrl= kURL_TERRAIN_2000;
            schema.layerName = kLAYER_NAME_TERRAIN;
            break;
        case 15:
            schema.baseUrl= kURL_TERRAIN_ANNOTATION_CHINESE_2000;
            schema.layerName = kLAYER_NAME_TERRAIN_ANNOTATION_CHINESE;
            break;
        default:
            break;
    }
    
    schema.fullEnvelope = [[AGSEnvelope alloc] initWithXmin:xMin
                                                       ymin:yMin
                                                       xmax:xMax
                                                       ymax:yMax
                                           spatialReference:sr];
    
    schema.tileInfo = [[AGSTileInfo alloc] initWithDpi:kDPI
                                                format:@"PNG"
                                                  lods:[lods copy]
                                                origin:origin
                                      spatialReference:sr
                                              tileSize:CGSizeMake(kTILE_WIDTH, kTILE_HEIGHT)];
    
    return schema;
}

@end
