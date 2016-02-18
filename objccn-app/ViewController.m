//
//  ViewController.m
//  objccn-app
//
//  Created by Moch Xiao on 2/18/16.
//  Copyright © 2016 Moch. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

NSString *const kShowDetailSegue = @"ShowDetail";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowDetailSegue]) {
        DetailViewController *detail = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        detail.bundleFileName = self.data[indexPath.section][@"sectionArticles"][indexPath.row][@"articleLocation"];;
    }
}

#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data[section][@"sectionArticles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    cell.textLabel.text = self.data[indexPath.section][@"sectionArticles"][indexPath.row][@"articleTitle"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.data[section][@"sectionTitle"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kShowDetailSegue sender:self];
}

#pragma mark - 

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        if ([_tableView respondsToSelector:@selector(layoutMargins)]) {
            _tableView.layoutMargins = UIEdgeInsetsZero;
        }
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
            view;
        });
    }
    return _tableView;
}

- (NSArray *)data {
    if (!_data) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"objccn" ofType:@"json"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
        _data = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:nil];
    }

    return _data;
}

@end
