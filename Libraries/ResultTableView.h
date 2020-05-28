//
//  ResultTableView.h
//  BarcodeReaderManager
//
//  Created by Bob on 2020/5/26.
//  Copyright © 2020 Facebook. All rights reserved.
//

#ifndef ResultTableView_h
#define ResultTableView_h

#import <UIKit/UIKit.h>
#import "BarcodeReaderManagerViewController.h"

@interface ResultTableView : UITableViewController<UITableViewDelegate>

@property (strong, nonatomic) UITableView *barcodeTableView;
@property (strong, nonatomic) BarcodeReaderManagerViewController *mainView;

@end
#endif /* ResultTableView_h */
