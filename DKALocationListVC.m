

#import "DKALocationListVC.h"
#import "DKASpringyCollectionViewFlowLayout.h"
#import "DKAHelper.h"
#import "Defines.h"
#import <FactualSDK/FactualQuery.h>
@interface DKALocationListVC ()
{
    FactualQueryResult *queryData;
}
@end

@implementation DKALocationListVC

static NSString *CellIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    DKASpringyCollectionViewFlowLayout *layout = [[DKASpringyCollectionViewFlowLayout alloc] init];
    //layout.headerReferenceSize = CGSizeMake(320, 44);
    [self.collectionView setCollectionViewLayout:layout];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    

    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatedLocation) name:DKALocationMuchUpdated object:nil];


    
}

-(void)updatedLocation
{
    CLLocation *loc = [[DKAHelper sharedInstance] currentLocation];

    [[DKAHelper sharedInstance] doQueryWithLocation:loc completion:^(FactualQueryResult *data, NSError *error) {
        
        queryData = data;
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource Methods



-(void)configureCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{

    
    
    FactualRow* row = [queryData.rows objectAtIndex:indexPath.row];
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:1001];
    lbl.text = [row valueForName:@"name"];
    
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FactualRow* row = [queryData.rows objectAtIndex:indexPath.row];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(7, 5, 306, 1000)];
    lbl.font = [UIFont systemFontOfSize:LOCATIONLISTFONTSIZE];
    lbl.numberOfLines = 0;
    lbl.lineBreakMode = NSLineBreakByWordWrapping;

    lbl.text = [row valueForName:@"name"];
    //NSLog(@"%@", NSStringFromCGSize(CGSizeMake(320, [[DKAHelper sharedInstance] getLabelSize:lbl fontSize:LOCATIONLISTFONTSIZE] + 12)));
    return CGSizeMake(320, [[DKAHelper sharedInstance] getLabelSize:lbl fontSize:LOCATIONLISTFONTSIZE] + 12);
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return queryData.rows.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*- (UICollectionReusableView*)collectionView: (UICollectionView*)cv
          viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{

    SearchHeaderView *headerView = [cv dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeaderViewRoot" forIndexPath:indexPath];
    
    return headerView;
}*/


@end
