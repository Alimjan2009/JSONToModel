//
//  ModelTool.h
//  JSONToModel
//
//  Created by Alimjan on 15/11/19.
//  Copyright © 2015年 Alimjan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface ModelTool : NSObject

/**
 *  Get the header file of model
 *
 *  @param dic       the dictionary nead to convert
 *  @param modelName the class name of model
 *
 *  @return content of file
 */
+(NSMutableString*)doHParse:(NSDictionary*)dic modelName:(NSString*)modelName;

/**
 *  Get the m file of model
 *
 *  @param dic       the dictionary nead to convert
 *  @param modelName the class name of model
 *
 *  @return content of file
 */
+(NSMutableString*)doMParse:(NSDictionary*)dic modelName:(NSString*)modelName;

@end
