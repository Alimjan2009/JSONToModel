//
//  ModelTool.m
//  JSONToModel
//
//  Created by Alimjan on 15/11/19.
//  Copyright © 2015年 Alimjan. All rights reserved.
//

#import "ModelTool.h"

@implementation ModelTool
/**
 *  Get the header file of model
 *
 *  @param dic       the dictionary nead to convert
 *  @param modelName the class name of model
 *
 *  @return content of file
 */
+(NSMutableString*)doHParse:(NSDictionary*)dic modelName:(NSString*)modelName{
    return [self doHParse:dic key:modelName modelName:modelName];
}
/**
 *  Get the m file of model
 *
 *  @param dic       the dictionary nead to convert
 *  @param modelName the class name of model
 *
 *  @return content of file
 */
+(NSMutableString*)doMParse:(NSDictionary*)dic modelName:(NSString*)modelName{
    NSMutableString *mstr = [self doMParse:dic key:modelName modelName:modelName];
    [mstr insertString:[NSString stringWithFormat:@"\n#import \"%@.h\"\n",modelName] atIndex:0];
    return mstr;
}
+(NSMutableString*)doHParse:(NSDictionary*)dic key:(NSString*)cName modelName:(NSString*)modelName{
    NSMutableString *mStr = [NSMutableString new];
    [mStr appendString:[NSString stringWithFormat:@"\n@interface %@ : NSObject\n",[[cName camelFromUnderline ]firstCharUpper]]];
    for (NSString *key in [dic allKeys]) {
        if (([[dic objectForKey:key] isKindOfClass:[NSString class]])&&![key isEqualToString:@"description"]) {
            [mStr appendString:[NSString stringWithFormat:@"@property (copy, nonatomic) NSString *%@;\n",key]];
        }else if ([[dic objectForKey:key] isKindOfClass:[NSNumber class]]){
            [mStr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) NSNumber *%@;\n",key]];
        }
        else if ([[dic objectForKey:key] isKindOfClass:[NSDictionary class]]){
            [mStr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) %@%@ *%@;\n",modelName,[[key camelFromUnderline ]firstCharUpper],key]];
            [mStr insertString:[self doHParse:[dic objectForKey:key] key:[NSString stringWithFormat:@"%@%@",modelName,[[key camelFromUnderline ]firstCharUpper]]  modelName:modelName] atIndex:0];
        }else if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]&&([[[dic objectForKey:key]objectAtIndex:0] isKindOfClass:[NSDictionary class]])){
            [mStr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;\n",key]];
            [mStr insertString:[self doHParse:[[dic objectForKey:key]objectAtIndex:0] key:[NSString stringWithFormat:@"%@%@",modelName,[[key camelFromUnderline ]firstCharUpper]] modelName:modelName] atIndex:0];
        }else if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]){
            [mStr appendString:[NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;\n",key]];
        }
    }
    [mStr appendString:@"\n@end\n"];
    return mStr;
}

+(NSMutableString*)doMParse:(NSDictionary*)dic key:(NSString*)cName modelName:(NSString*)modelName{
    NSMutableString *mStr = [NSMutableString new];
    NSMutableString *mForArr = [NSMutableString new];
    BOOL addedArrayInfo=NO;
    [mForArr appendString:@"+ (NSDictionary *)objectClassInArray\n{\n        return @{"];
    [mStr appendString:[NSString stringWithFormat:@"\n@implementation %@ : NSObject\n",[[cName camelFromUnderline ]firstCharUpper]]];
    for (NSString *key in [dic allKeys]) {
        
        if ([[dic objectForKey:key] isKindOfClass:[NSString class]]) {
            
        }else if ([[dic objectForKey:key] isKindOfClass:[NSNumber class]]){
            
        }
        else if ([[dic objectForKey:key] isKindOfClass:[NSDictionary class]]){
            [mStr insertString:[self doMParse:[dic objectForKey:key] key:[NSString stringWithFormat:@"%@%@",modelName,[[key camelFromUnderline ]firstCharUpper]] modelName:modelName] atIndex:0];
            
        }
        else if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]&&([[[dic objectForKey:key]objectAtIndex:0] isKindOfClass:[NSDictionary class]])){
            [mStr insertString:[self doMParse:[[dic objectForKey:key]objectAtIndex:0] key:[NSString stringWithFormat:@"%@%@",modelName,[[key camelFromUnderline ]firstCharUpper]] modelName:modelName] atIndex:0];
            if (addedArrayInfo==YES) {
                [mForArr appendString:@","];
            }
            
            [mForArr appendFormat:@"\n\t\t\t@\"%@\":@\"%@\"",key,[[[NSString stringWithFormat:@"%@%@",modelName,[[key camelFromUnderline ]firstCharUpper]] camelFromUnderline ]firstCharUpper]];
            addedArrayInfo = YES;
        }else if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]){
        }
    }
    [mForArr appendString:@"\n\t\t};\n}"];
    [mStr appendFormat:@"\n%@\n@end\n",mForArr];
    return mStr;
}

@end
