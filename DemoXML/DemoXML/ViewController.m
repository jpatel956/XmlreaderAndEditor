//
//  ViewController.m
//  DemoXML
//
//  Created by Rajesh Ritesh on 13/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "XMLReader.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"temp.xml"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"temp" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    [string writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:nil];

    arrData = [self dataFormXMLAtPath:filePath];
    [tblData reloadData];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cellIdentifire";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifire];
    }
    
    NSMutableDictionary *dic = [arrData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic valueForKey:@"Name"];
    cell.detailTextLabel.text = [dic valueForKey:@"SurName"];    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [arrData removeObjectAtIndex:indexPath.row];
    [self createXMLAtPath:filePath];
    [tblData reloadData];
}



-(IBAction) addObject:(id)sender
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"Name %d",[arrData count]+1] forKey:@"Name"];
    [dic setObject:[NSString stringWithFormat:@"SurName %d",[arrData count]+1] forKey:@"SurName"];
    [arrData addObject:dic];
    [self createXMLAtPath:filePath];
    
    [tblData reloadData];
}

-(void)createXMLAtPath:(NSString *)strFilePath
{
    NSString *str = @"<Team>";
    
    for (int i = 0 ; i < [arrData count]; i++) 
    {
        NSMutableDictionary *dic = [arrData objectAtIndex:i];
        
        NSString *str1 = [dic valueForKey:@"Name"];
        NSString *str2 = [dic valueForKey:@"SurName"];
        str = [NSString stringWithFormat:@"%@<Player><Name>%@</Name><SurName>%@</SurName></Player>",str,str1,str2];
    }
    
    str = [NSString stringWithFormat:@"%@</Team>",str];
    [str writeToFile:strFilePath atomically:TRUE encoding:NSUTF8StringEncoding error:nil];
}

-(NSMutableArray *)dataFormXMLAtPath:(NSString *)strFilePath
{
    NSMutableArray *arrDataNew = [[NSMutableArray alloc] init];
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:strFilePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [XMLReader dictionaryForXMLString:string error:nil];
    
    NSMutableArray *arrTemp = [[dic valueForKey:@"Team"] valueForKey:@"Player"];
    
    if ([arrTemp isKindOfClass:[NSDictionary class]])
    {
        arrTemp = [NSMutableArray arrayWithObject:arrTemp];
    }
    
    for (int i = 0;i < [arrTemp count]; i++)
    {
        NSMutableDictionary *dicTemp = [arrTemp objectAtIndex:i];
        
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
        [dicData setObject:[[dicTemp valueForKey:@"Name"] valueForKey:@"text"] forKey:@"Name"];
        [dicData setObject:[[dicTemp valueForKey:@"SurName"] valueForKey:@"text"] forKey:@"SurName"];        
        [arrDataNew addObject:dicData];
    }
    
    return arrDataNew;
}


@end

