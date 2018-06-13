//
//  NSError+Category.m
//  NeoCreation
//
//  Created by wjyx on 2018/5/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSError+Category.h"

@implementation NSError (Category)

- (BOOL)netNotConnect{
	return [self.domain isEqualToString:NSURLErrorDomain] && self.code == -1009;
}

- (NSString *)errorMsg{
	
	NSString *filePath = [NSBundle.mainBundle pathForResource:@"resultCodeDescription" ofType:@"json"];
	if (!filePath) {
		return self.localizedDescription;
	}
	NSURL *fileURL = [NSURL fileURLWithPath:filePath];
	NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
	NSError *error = nil;
	NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
	if(error){
		return self.localizedDescription;
	}
	NSString *resultDesc = [dict valueForKey:[NSString stringWithFormat:@"%d",self.code]];
	return resultDesc?:self.localizedDescription;
	
}

@end
