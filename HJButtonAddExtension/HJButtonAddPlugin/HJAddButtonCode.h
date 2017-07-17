//
//  HJAddButtonCode.h
//  HJButtonAddExtension
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

@interface HJAddButtonCode : NSObject

/*
 * 添加 button 到对应的文件中
 */

+ (void)addButtonCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
