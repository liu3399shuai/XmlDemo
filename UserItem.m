

#import "UserItem.h"

@implementation UserItem

@synthesize uid = _uid;
@synthesize username = _username;
@synthesize credit = _credit;
@synthesize experience = _experience;
@synthesize friendnum = _friendnum;
@synthesize headimage = _headimage;
@synthesize realname = _realname;

-(void)dealloc
{
    [_uid release];
    [_username release];
    [_credit release];
    [_experience release];
    [_friendnum release];
    [_headimage release];
    [_realname release];
    
    [super dealloc];
}

@end
