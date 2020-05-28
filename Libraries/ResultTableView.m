//
//  ResultTableView.m
//  BarcodeReaderManager
//
//  Created by Bob on 2020/5/26.
//  Copyright © 2020 Facebook. All rights reserved.
//


#import "ResultTableView.h"

@interface ResultTableView ()

@end

@implementation ResultTableView

@synthesize barcodeTableView;
@synthesize mainView;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [barcodeTypesTableView setEditing: YES animated: NO];
    barcodeTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self configCellsBackground];
//    barcodeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(mainView != nil && mainView.dbrManager != nil)
        mainView.dbrManager.isPauseFramesComing = YES;
}

- (void) configCellsBackground{
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mainView.textResult count] + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
    }
    UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(10,5,50,40)];
    
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [back addTarget:self action:@selector(onBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton* share = [[UIButton alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-10,5,50,40)];
    [share setTitle:@"Share" forState:UIControlStateNormal];
    [share addTarget:self action:@selector(onShare) forControlEvents:UIControlEventTouchUpInside];
    [share setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:back];
        [self.view addSubview:share];
    });
    if (indexPath.row == 0) {
        cell.backgroundColor = UIColor.darkGrayColor;
    }else if (indexPath.row == 1) {
        cell.backgroundColor = UIColor.whiteColor;
        cell.textLabel.text = [NSString stringWithFormat:@"Total: %lu",(unsigned long)[mainView.textResult count]];
    }else{
        cell.backgroundColor = UIColor.whiteColor;
        cell.textLabel.text = [mainView.textResult objectAtIndex:indexPath.row - 2];
    }
    
    return cell;
}
- (void)onBackClick {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)onShare {
    UIAlertController* alertController = [UIAlertController
                             alertControllerWithTitle:@"Share result(s)"
                             message: nil
                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* srcImgAction = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareSource];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:srcImgAction];
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)shareSource
{
    if(mainView.textResult != nil)
    {
        [self goShare:mainView.textResult];
    }else{
        UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"No Result!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [ac addAction:okAction];
        [self presentViewController:ac animated:true completion:nil ];
    }
}

- (void)goShare:(NSArray*) contents
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:contents applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable   activityType,
                                             BOOL completed,
                                             NSArray * _Nullable returnedItems,
                                             NSError * _Nullable activityError) {
        if (completed) {
            if(contents != nil) {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Share complete!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:true completion:nil];
            }
        }else {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Canceled!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:true completion:nil];
        }
    };
    [self presentViewController:activityVC animated:true completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //where indexPath.row is the selected cell
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //where indexPath.row is the selected cell
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    mainView.dbrManager.isPauseFramesComing = NO;
    self.barcodeTableView = nil;
    [mainView.textResult removeAllObjects];
}

@end


