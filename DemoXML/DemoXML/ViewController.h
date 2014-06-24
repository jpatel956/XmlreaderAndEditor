//
//  ViewController.h
//  DemoXML
//
//  Created by Rajesh Ritesh on 13/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableArray *arrData;
    IBOutlet UITableView *tblData;
    
    NSString *filePath;
}

-(IBAction) addObject:(id)sender;

-(NSMutableArray *)dataFormXMLAtPath:(NSString *)strFilePath;
-(void)createXMLAtPath:(NSString *)strFilePath;


@end
