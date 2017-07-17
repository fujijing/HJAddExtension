//
//  HJAddButtonCode.m
//  HJButtonAddExtension
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import "HJAddButtonCode.h"
#import "NSString+Extension.h"

#define BtnFormat @"- (%@ *)%@ {\n    if (_%@ == nil) {\n        _%@ = [%@ buttonWithType:<#(UIButtonType)#>];\n    }\n    return _%@;\n}"
#define TableFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> style:<#(UITableViewStyle)#>];\n    }\n    return _%@;\n}"
#define CollectionFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] initWithFrame:<#(CGRect)#> collectionViewLayout:<#(nonnull UICollectionViewLayout *)#>];\n    }\n    return _%@;\n}"
#define CommonFormat @"- (%@ *)%@{\n    if (_%@ == nil) {\n        _%@ = [[%@ alloc] init];\n    }\n    return _%@;\n}"

#define MasonryFormat @"    [_%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n        make.top.mas_equalTo(0);\n        make.left.mas_equalTo(0);\n        make.right.mas_equalTo(0);\n        make.height.mas_equalTo(0);\n    }];"

@implementation HJAddButtonCode

+ (void)addButtonCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    for (XCSourceTextRange *rang in invocation.buffer.selections) {
        NSInteger startLine = rang.start.line;
        NSInteger endLine = rang.end.line;
        NSInteger lineCount = invocation.buffer.lines.count;
        
        NSMutableArray *nameArr = [NSMutableArray array];
        NSMutableArray *containtsArr = [NSMutableArray array];
        for (NSInteger i = startLine; i <= endLine; i++) {
            NSString *string = invocation.buffer.lines[i];
            
            if ([string isEqualToString:@"\n"] || ![string containsString:@";"]) {
                continue;
            }
            
            // 去掉空格
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            // 获取类名
            NSString *classNameStr = nil;
            if ([string containsString:@")"]) {
                classNameStr = [string stringBetweenLeftStr:@")" andRightStr:@"*"];
            } else {
                classNameStr = [string stringBetweenLeftStr:nil andRightStr:@"*"];
            }
            
            // 获取属性名或者变量名
            NSString *propertyNameStr = [string stringBetweenLeftStr:@"*" andRightStr:@";"];
            
            //
            NSArray *formatArr = [self stringForClassName:classNameStr andPropertyName:propertyNameStr];
            [nameArr addObject:formatArr];
            
            // 获取布局
            NSArray *conArr = [self constraintsForPropertyName:propertyNameStr];
            [containtsArr addObject:conArr];
        }
        
        //输出到文件
        for (NSInteger i = 0; i < lineCount; i ++) {
            NSString *lineStr = invocation.buffer.lines[i];
            if ([lineStr containsString:@"#pragma mark - Get"]) {
                for (NSInteger j = i + 1; j < nameArr.count + i + 1; j ++) {
                    NSArray *formatArr = [nameArr objectAtIndex:nameArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <formatArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:formatArr[z] atIndex:i + 1  + z];
                    }
                }
//                break;
            }
            if ([lineStr containsString:@"#pragma mark - M"]) {
                for (NSInteger j = i + 1; j < containtsArr.count + i + 1; j ++) {
                    NSArray *cArr = [containtsArr objectAtIndex:containtsArr.count - j - 1  + (i + 1 )];
                    for (int z = 0; z <cArr.count ; z ++) {
                        [invocation.buffer.lines insertObject:cArr[z] atIndex:i + 1 + z];
                    }
                }
            }
        }
        
    }
}


+ (NSArray *)stringForClassName:(NSString *)className andPropertyName:(NSString *)propertyName{
    NSString *str = @"";
    if ([className containsString:@"Button"]) {
        str = [NSString stringWithFormat:BtnFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }else if ([className containsString:@"TableView"]){
        str = [NSString stringWithFormat:TableFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }else if ([className containsString:@"CollectionView"]){
        str = [NSString stringWithFormat:CollectionFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }else{
        str = [NSString stringWithFormat:CommonFormat,className,propertyName,propertyName,propertyName,className,propertyName];
    }
    NSArray *formaterArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@"\n"];
    
    return formaterArr;
}

+ (NSArray *)constraintsForPropertyName:(NSString *)propertyName {
    NSString *str = [NSString stringWithFormat:MasonryFormat,propertyName];
    NSArray *conArr = [[str componentsSeparatedByString:@"\n"] arrayByAddingObject:@"\n"];
    return conArr;
}













@end
