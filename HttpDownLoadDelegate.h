//
//  HttpDownLoadDelegate.h
//  JsomDemo
//
//  Created by mac on 12-12-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HttpDownLoad.h"
@class HttpDownLoad;

@protocol HttpDownLoadDelegate <NSObject>

@required

-(void)downLoadComplete:(HttpDownLoad *)hd;

@end
