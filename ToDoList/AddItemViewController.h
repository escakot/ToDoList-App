//
//  AddItemViewController.h
//  ToDoList
//
//  Created by Errol Cheong on 2017-06-21.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddItemViewControllerDelegate <NSObject>

- (void) didSaveNewTodo:(NSString *)todoText;

@end

@interface AddItemViewController : UIViewController

@property (nonatomic, strong) id <AddItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;


@end
