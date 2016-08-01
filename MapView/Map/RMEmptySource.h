//
//  RMEmptySource.h
//  MapView
//
//  Created by Silence on 16/8/1.
//
//

#import "RMTileSource.h"

@interface RMEmptySource : NSObject<RMTileSource>

+ (instancetype)shareEmptySource;

@end
