//
//  LoginTVC.m
//  linphone
//
//  Created by Norayr Harutyunyan on 3/25/17.
//
//

#import "LoginTVC.h"
#import "LogOutVC.h"
#import "PhoneMainView.h"

@interface LoginTVC () <UITextFieldDelegate> {
    int nexTag;
}


@property (weak, nonatomic) IBOutlet UIImageView *providerImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *saveCredentialsSwitch;

@end

@implementation LoginTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    nexTag = 0;

    [self setupUI];
    
    self.emailTextField.text = @"111";
    self.passwordTextField.text = @"abcd12";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationUpdate:) name:kLinphoneRegistrationUpdate object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupUI {
    [self setGuestures];
    [self addDelegateMethods];
    [self setupSwitchUI];
}

- (void) setGuestures {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void) dismissKeyboard {
    [self.view endEditing:true];
}

- (void) addDelegateMethods {
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void) setupSwitchUI {
    UIColor *onColor = [UIColor colorWithRed:56.0/255.0 green:197.0/255.0 blue:1.0 alpha:1.0];
    UIColor *offColor = [UIColor colorWithRed:150.0/255.0 green:161.0/255.0 blue:173.0/255.0 alpha:1.0];
    
    self.saveCredentialsSwitch.onTintColor = onColor;
    self.saveCredentialsSwitch.tintColor = offColor;
    self.saveCredentialsSwitch.layer.cornerRadius = 16.0;
    self.saveCredentialsSwitch.backgroundColor = offColor;
}

- (IBAction)onButtonBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)onButtonLogin:(id)sender {
  
    
    NSString *errorMessage = nil;
    if ([self.emailTextField.text length] == 0) {
        errorMessage = NSLocalizedString(@"Enter your username", nil);
    } else if ([self.passwordTextField.text length] == 0) {
        errorMessage = NSLocalizedString(@"Enter your password", nil);
    }
    
    if (errorMessage != nil) {
        UIAlertView *error = nil;
        error = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil)
                                           message:errorMessage
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"Continue", nil)
                                 otherButtonTitles:nil];
        [error show];
    } else {
        linphone_core_clear_all_auth_info([LinphoneManager getLc]);
        linphone_core_clear_proxy_config([LinphoneManager getLc]);
        LinphoneProxyConfig *proxyCfg = linphone_core_create_proxy_config([LinphoneManager getLc]);
        linphone_proxy_config_set_server_addr(proxyCfg, "192.168.0.50:5060");
        
        /*default domain is supposed to be preset from linphonerc*/
        NSString *identity = [NSString stringWithFormat:@"sip:%@@%@", self.emailTextField.text, @"192.168.0.50:5060"];
        linphone_proxy_config_set_identity(proxyCfg, [identity UTF8String]);
        LinphoneAuthInfo *auth_info = linphone_auth_info_new([self.emailTextField.text UTF8String], [self.emailTextField.text UTF8String], [self.passwordTextField.text UTF8String], NULL, NULL, linphone_proxy_config_get_domain(proxyCfg));
        linphone_core_add_auth_info([LinphoneManager getLc], auth_info);
        linphone_core_add_proxy_config([LinphoneManager getLc], proxyCfg);
        linphone_core_set_default_proxy_config([LinphoneManager getLc], proxyCfg);
        // reload address book to prepend proxy config domain to contacts' phone number
    };
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return true;
}

- (void)registrationUpdate:(NSNotification *)notif {
    LinphoneRegistrationState state = [[notif.userInfo objectForKey:@"state"] intValue];
    if (state == LinphoneRegistrationFailed && [UIApplication sharedApplication].applicationState != UIApplicationStateBackground) {
        UIAlertController *errView = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Registration failure", nil)
                                                                         message:[notif.userInfo objectForKey:@"message"]
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Continue", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [errView addAction:defaultAction];
        [self presentViewController:errView animated:YES completion:nil];
    } else if (state == LinphoneRegistrationOk && [UIApplication sharedApplication].applicationState != UIApplicationStateBackground) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LogOut" bundle:nil];
        LogOutVC *logOutVC = (LogOutVC*)storyboard.instantiateInitialViewController;
        [self.navigationController pushViewController:logOutVC animated:true];
        PhoneMainView.instance.currentController = logOutVC;
    }
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
