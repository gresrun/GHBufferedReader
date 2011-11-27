#import <Foundation/Foundation.h>

@interface GHBufferedReader : NSObject {
    NSFileHandle *_fileHandle;
    NSData *_lineDelimiterData;
    NSMutableData *_lineBuffer;
    NSUInteger _chunkSize;
}

- (id)initWithFileHandle:(NSFileHandle *)aHandle;
- (NSString *)readLine;
#if NS_BLOCKS_AVAILABLE
- (void)enumerateLinesUsingBlock:(void(^)(NSString *, BOOL *))block;
#endif

@end

