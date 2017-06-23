//
//  ViewController.m
//  ToDoList
//
//  Created by Errol Cheong on 2017-06-13.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
#import "AddItemViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate,
    UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ListTableView;

@property (nonatomic, strong) NSMutableArray *todos;

@property (nonatomic, strong) NSIndexPath *itemIndex;

@property (weak, nonatomic) IBOutlet UITextField *listTitleTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todos = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
//    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.listTitleTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   NSString *cellIdentifier = @"ListTableViewCell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *todoText = self.todos[indexPath.row];
    cell.titleLabel.text = todoText;
    return cell;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.listTitleTextField resignFirstResponder];
//    [self.listTitleTextField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"Hello, I was touched: %@", indexPath);
    self.itemIndex = indexPath;
    [self.listTitleTextField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *nav = segue.destinationViewController;
    AddItemViewController *addVC = nav.viewControllers[0];
    addVC.delegate = self;
}

- (void)didSaveNewTodo:(NSString *)todoText{
    [self.todos addObject:todoText];
    [self.ListTableView reloadData];
}

- (IBAction)deleteItem:(id)sender {
//    NSLog(@"%@", self.itemIndex);
//    NSLog(@"%ld", (long)self.itemIndex.row);
    if (self.itemIndex) {
        [self.todos removeObjectAtIndex:[self.itemIndex row]];
        [self.ListTableView reloadData];
    }
    //Fix bug when no todos on list
    self.itemIndex = NULL;
}

@end
