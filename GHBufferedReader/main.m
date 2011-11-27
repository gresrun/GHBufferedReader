//
//  main.m
//  GHBufferedReader
//
//  Created by Greg Haines on 11/26/11.
//

#import <Foundation/Foundation.h>
#import "GHBufferedReader.h"

int main(int argc, const char *argv[]) {
	@autoreleasepool {
	    GHBufferedReader *reader = [[GHBufferedReader alloc] initWithFileHandle:[NSFileHandle fileHandleWithStandardInput]];
		[reader enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
			printf("%s\n", [line UTF8String]);
		}];
	}
    return 0;
}
