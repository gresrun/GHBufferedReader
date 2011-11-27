//
//  GHBufferedReader.h
//  GHBufferedReader
//
//  Created by Greg Haines on 11/26/11.
//

#import <Foundation/Foundation.h>

@interface GHBufferedReader : NSObject {
    NSFileHandle *_fileHandle;
    NSData *_lineDelimiterData;
    NSMutableData *_lineBuffer;
    NSUInteger _chunkSize;
}

- (id)initWithFileHandle:(NSFileHandle *)aHandle;
- (id)initWithFileHandle:(NSFileHandle *)aHandle withLineDelimiter:(NSString *)lineEnd;
- (NSString *)readLine;
#if NS_BLOCKS_AVAILABLE
- (void)enumerateLinesUsingBlock:(void(^)(NSString *, BOOL *))block;
#endif

@end

