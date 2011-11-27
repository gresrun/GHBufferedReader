#import "GHBufferedReader.h"

@implementation GHBufferedReader

- (id)initWithFileHandle:(NSFileHandle *)aHandle {
    if (self = [super init]) {
        _fileHandle = aHandle;
        _lineDelimiterData = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
        _lineBuffer = [[NSMutableData alloc] initWithCapacity:8096];
        _chunkSize = 10;
    }
    return self;
}

- (void)dealloc {
    [_fileHandle closeFile];
}

- (NSString *)readLine {
    NSString *line = nil;
    BOOL shouldReadMore = YES;
    @autoreleasepool {
        while (shouldReadMore) {
            NSRange newLineRange = [_lineBuffer rangeOfData:_lineDelimiterData
                                                    options:(NSDataSearchOptions)NULL
                                                      range:NSMakeRange(0, _lineBuffer.length)];
            if (newLineRange.location != NSNotFound) {
                NSData *lineData = [[_lineBuffer subdataWithRange:NSMakeRange(0, newLineRange.location)] copy];
                line = [[NSString alloc] initWithData:lineData encoding:NSUTF8StringEncoding];
                [_lineBuffer replaceBytesInRange:NSMakeRange(0, lineData.length + _lineDelimiterData.length) withBytes:NULL length:0];
                shouldReadMore = NO;
            }
            if (shouldReadMore) {
                NSData *chunk = [_fileHandle readDataOfLength:_chunkSize];
                if (chunk.length != 0) {
                    [_lineBuffer appendData:chunk];
                } else {
                    shouldReadMore = NO;
                }
            }
        }
    }
    return line;
}

#if NS_BLOCKS_AVAILABLE
- (void)enumerateLinesUsingBlock:(void(^)(NSString *, BOOL *))block {
    NSString *line = nil;
    BOOL stop = NO;
    while (stop == NO && (line = [self readLine])) {
        block(line, &stop);
    }
}
#endif

@end

