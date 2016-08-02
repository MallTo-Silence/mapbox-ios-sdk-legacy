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

static CGFloat const KRMMapSourceMinZoom = 1;
static CGFloat const KRMMapSourceMaxZoom = 5;
static CGFloat const kRMMapSourceSize = 256;
static RMSphericalTrapezium const kRMMapSourceBoundingBox = {.southWest = {-90, -180.0}, .northEast = {90, 180.0}};

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
        _tileProjection = [[RMFractalTileProjection alloc] initFromProjection:[self projection]
                                                               tileSideLength:kRMMapSourceSize
                                                                      maxZoom:KRMMapSourceMaxZoom
                                                                      minZoom:KRMMapSourceMinZoom];
        
        self.cacheable = NO;
        self.opaque = YES;
    }
    return self;
}


- (NSUInteger)tileSideLength{
    
    return _tileProjection.tileSideLength;
}

- (void)cancelAllDownloads{
    
    // no-op
}

- (BOOL)tileSourceHasTile:(RMTile)tile{
    
    return YES;
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
    
    //    NSBundle *resource = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Mapbox" ofType:@"bundle"]];
    //
    //    return [UIImage imageWithContentsOfFile: [resource pathForResource:@"LoadingTile6" ofType:@"png"]];
    
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
    
    return kRMMapSourceBoundingBox;
}

- (void)didReceiveMemoryWarning{
    
    NSLog(@"*** didReceiveMemoryWarning in %@", [self class]);
}

@end
