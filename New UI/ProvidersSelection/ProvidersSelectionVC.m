//
//  ProvidersSelectionVC.m
//  linphone
//
//  Created by Norayr Harutyunyan on 3/25/17.
//
//

#import "ProvidersSelectionVC.h"
#import "LoginTVC.h"

@interface ProvidersSelectionVC () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *providersList;
}

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProvidersSelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self setupUI];
    [self setupDelegateMethods];
    [self setupDataSource];
}

- (void) setupUI {
    [self setupNextButton];
    [self enableNextButton:false];
}

- (void) setupDelegateMethods {
    [self setupTableViewDelegateMethods];
}

- (void) setupTableViewDelegateMethods {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void) setupNextButton {
    self.nextButton.layer.cornerRadius = self.nextButton.frame.size.width / 2.0;
}

- (void) enableNextButton:(BOOL)enable {
    [self.nextButton setEnabled:enable];

    if (enable) {
        self.nextButton.backgroundColor = [UIColor colorWithRed:56.0/255.0 green:197.0/255.0 blue:1.0 alpha:1.0];
    } else {
        self.nextButton.backgroundColor = [UIColor colorWithRed:208.0/255.0 green:211.0/255.0 blue:224.0/255.0 alpha:1.0];
    }
}

- (void) setupDataSource {
    providersList = [[NSArray alloc] initWithObjects:@"Globalgig", @"Telmex", @"Brasilfone", @"BrightLink", @"TSI Corp", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonNext:(id)sender {
    LoginTVC *loginVC = (LoginTVC*)[UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
    loginVC.providerName = @"Telmex";
    [self.navigationController pushViewController:loginVC animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return providersList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...

    cell.textLabel.text = providersList[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:197.0/255.0 blue:1.0 alpha:1.0];
    [self enableNextButton:true];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor blackColor];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
