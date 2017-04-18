//
//  ViewController.m
//  WZTouch
//
//  Created by james on 2017/4/18.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import "ViewController.h"
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import "DView.h"

/*
 *屏幕宽度
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

/*
 *屏幕高度
 */
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AView *av=[[AView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    av.backgroundColor= [UIColor blueColor];
    [self.view addSubview:av];
    
    BView *bv=[[BView alloc]initWithFrame:CGRectMake(100, 100,200 , 200)];
    bv.backgroundColor= [UIColor yellowColor];
    [av addSubview:bv];
    
    CView *cv=[[CView alloc]initWithFrame:CGRectMake(100, 350,200 , 200)];
    cv.backgroundColor= [UIColor greenColor];
    [av addSubview:cv];
    
    DView *dv=[[DView alloc]initWithFrame:CGRectMake(30, 30,100 , 100)];
    dv.backgroundColor= [UIColor grayColor];
    [cv addSubview:dv];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
