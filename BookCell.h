//
//  BookCell.h
//  XmlDemo
//
//  Created by mac on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserItem.h"

@interface BookCell : UITableViewCell
{
@private
    UserItem *item;
}

@property (nonatomic,retain) IBOutlet UIImageView *headImgview;
@property (nonatomic,retain) IBOutlet UILabel *userLable;
@property (nonatomic,retain) IBOutlet UILabel *realLable;
@property (nonatomic,retain) IBOutlet UILabel *uidLable;
@property (nonatomic,retain) IBOutlet UILabel *creadLable;

-(void)getValuesFromItem:(UserItem *)newItem;

@end
