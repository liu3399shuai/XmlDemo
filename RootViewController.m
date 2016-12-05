
#import "RootViewController.h"
#import "GDataXMLNode.h"
#import "UserItem.h"
#import "BookCell.h"

@implementation RootViewController

@synthesize curArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    
    numInPage = 10;
    pageIndex = 1;
    
    httpDownload = [[HttpDownLoad alloc] initWithDelegate:self];
    [httpDownload downloadFromUrl:[NSString stringWithFormat:@"http://192.168.88.8/sns/my/user_list.php?page=%d&number=%d&format=xml",pageIndex,numInPage]];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(40, 415, 80, 30);
    [leftBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(200, 415, 80, 30);
    [rightBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
//    mLoadMore = [[UILabel alloc] initWithFrame:CGRectMake(0, -88, 320, 88)];
//    [mTableView addSubview:mLoadMore];
    // 刷新
    refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -mTableView.frame.size.height, mTableView.frame.size.width, mTableView.frame.size.height)];
    refreshView.delegate = self;
    [refreshView refreshLastUpdatedDate];
    [mTableView addSubview:refreshView];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewDidScroll:scrollView];
    
//    NSLog(@"%f %f",scrollView.contentSize.height,scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y < -70) {
//        mLoadMore.text = @"松开即可刷新";
//        canLoadMore = YES;
//    }else if(scrollView.contentOffset.y<0){
//        mLoadMore.text = @"下拉即可刷新";
//        canLoadMore = NO;
//    }else if(scrollView.contentOffset.y+mTableView.frame.size.height>scrollView.contentSize.height){
//        canLoadMore = YES;
//    }
//    if (canLoadMore) {
//        NSLog(@"加载更多");
//    }
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    isLoading = YES;
    [httpDownload downloadFromUrl:[NSString stringWithFormat:@"http://192.168.88.8/sns/my/user_list.php?page=%d&number=10&format=xml",rand()%20+1]];
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return isLoading;
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}
-(void)back
{
    if (pageIndex == 1) {
        return;
    }
    pageIndex--;
    self.curArray =  [mDataArray subarrayWithRange:NSMakeRange((pageIndex-1)*numInPage, numInPage)];
    mTableView.contentOffset = CGPointMake(0, 0);
    [mTableView reloadData];
}
-(void)next
{
    if (pageIndex == pageCount) {
        return;
    }
    pageIndex++;
    
    if ((pageIndex-1)*numInPage >= [mDataArray count]) {
        [httpDownload downloadFromUrl:[NSString stringWithFormat:@"http://192.168.88.8/sns/my/user_list.php?page=%d&number=%d&format=xml",pageIndex,numInPage]];
    }else{
        self.curArray =  [mDataArray subarrayWithRange:NSMakeRange((pageIndex-1)*numInPage, numInPage)];
        mTableView.contentOffset = CGPointMake(0, 0);
        [mTableView reloadData];
    }
}
-(void)downLoadComplete:(HttpDownLoad *)hd
{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:hd.mData options:0 error:nil];
    if (!doc) {
        return;
    }
    totalcount= [[[[doc nodesForXPath:@"/root/totalcount" error:nil] lastObject] stringValue] intValue];
    pageCount = (totalcount%numInPage == 0)?(totalcount/numInPage):(totalcount/numInPage+1);
    
    NSArray *userArray = [doc nodesForXPath:@"/root/user_list/user" error:nil];
//    NSLog(@"%d %@",[userArray count],userArray);
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *userElement in userArray) {
//        NSLog(@"%@",[userElement stringValue]);
        UserItem *item = [[UserItem alloc] init];
        GDataXMLElement *nameElement = [[userElement elementsForName:@"username"] lastObject];
        item.username = [nameElement stringValue];
        item.uid = [[[userElement elementsForName:@"uid"] lastObject] stringValue];
        item.credit = [[[userElement elementsForName:@"credit"] lastObject] stringValue];
        item.experience = [[[userElement elementsForName:@"experience"] lastObject] stringValue];
        item.friendnum = [[[userElement elementsForName:@"friendnum"] lastObject] stringValue];
        item.headimage = [[[userElement elementsForName:@"headimage"] lastObject] stringValue];
        item.realname = [[[userElement elementsForName:@"realname"] lastObject] stringValue];
        [mDataArray addObject:item];
        [arr addObject:item];
        [item release];
    }
    
    self.curArray = arr;
    mTableView.contentOffset = CGPointMake(0, 0);
    [mTableView reloadData];
    
    isLoading = NO;
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [curArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentify = @"cellName";
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil] lastObject];
    }
    [cell getValuesFromItem:[curArray objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
