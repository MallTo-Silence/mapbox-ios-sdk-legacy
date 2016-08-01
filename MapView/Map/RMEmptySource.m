//
//  RMEmptySource.m
//  MapView
//
//  Created by Silence on 16/8/1.
//
//

#import "RMEmptySource.h"
#import "RMTileImage.h"
#import "RMProjection.h"
#import "RMFractalTileProjection.h"

static NSString *const kRMMapSourceKey = @"RMMapSource";

@implementation RMEmptySource{

    RMFractalTileProjection *_tileProjection;
}

@synthesize cacheable = _cacheable,opaque = _opaque;

+ (instancetype)shareEmptySource{
    static RMEmptySource *source;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        source = [[RMEmptySource alloc] init];
    });
    
    return source;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _tileProjection = [[RMFractalTileProjection alloc] initFromProjection:[self projection] tileSideLength:0 maxZoom:0 minZoom:0];
    }
    return self;
}


- (NSUInteger)tileSideLength{
    
    return _tileProjection.tileSideLength;
}

- (void)cancelAllDownloads{
    
}

- (BOOL)tileSourceHasTile:(RMTile)tile{
    return true;
}

- (NSString *)shortAttribution{
    return kRMMapSourceKey;
}

- (NSString *)shortName{
    return kRMMapSourceKey;
}

- (NSString *)longAttribution{
    return kRMMapSourceKey;
}

- (NSString *)longDescription{
    return kRMMapSourceKey;
}

- (NSString *)uniqueTilecacheKey{
    return kRMMapSourceKey;
}

- (id)imageForTile:(RMTile)tile inCache:(RMTileCache *)tileCache{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [[NSNotificationCenter defaultCenter] postNotificationName:RMTileRetrieved object:[NSNumber numberWithUnsignedLongLong:RMTileKey(tile)]];
                   });
    return nil;
}

- (RMFractalTileProjection *)mercatorToTileProjection{
    return _tileProjection;
}


- (RMProjection *)projection{
    return [RMProjection googleProjection];
}

- (float)minZoom{
    return _tileProjection.minZoom;
}

- (float)maxZoom{
    return _tileProjection.maxZoom;
}

- (void)setMinZoom:(float)minZoom{
    [_tileProjection setMinZoom:minZoom];
}

- (void)setMaxZoom:(float)maxZoom{
    [_tileProjection setMaxZoom:maxZoom];
}

- (RMSphericalTrapezium)latitudeLongitudeBoundingBox{
    RMSphericalTrapezium bounds = {
        0.0,
        0.0,
        0.0,
        0.0
    };
    return bounds;
}

- (void)didReceiveMemoryWarning{

    NSLog(@"*** didReceiveMemoryWarning in %@", [self class]);
}

@end
