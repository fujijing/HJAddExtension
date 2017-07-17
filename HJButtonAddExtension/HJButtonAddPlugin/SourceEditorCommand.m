//
//  SourceEditorCommand.m
//  HJButtonAddPlugin
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "HJAddButtonCode.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    NSString *identifier = invocation.commandIdentifier;
    if ([identifier hasPrefix:@"Jing.HJButtonAddExtension"]) {
        [HJAddButtonCode addButtonCodeWithInvocation:invocation];
    }
    completionHandler(nil);
}

@end
