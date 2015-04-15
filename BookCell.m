//
//  BookCell.m
//  XmlDemo
//
//  Created by mac on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookCell.h"
#import "UIImageView+WebCache.h"


//////


@implementation BookCell

@synthesize  userLable,realLable,creadLable,uidLable,headImgview;

-(void)getValuesFromItem:(UserItem *)newItem
{
    if (item != newItem) {
        [item release];
        item = [newItem retain];
    }
    
    [self.headImgview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.88.8/sns/%@",item.headimage]] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    self.userLable.text = item.username;
    self.uidLable.text = item.uid;
    self.realLable.text = item.realname;
    self.creadLable.text = item.credit;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
