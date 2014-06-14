//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //@"Latte"
    //, @"Mocha"
    //, @"Cappuccino"
    //, @"Espresso Con Panna"
    //, @"Espresso Macchiato"
    //, @"Americano"
    //, @"Caramel Macchiato"
    //
    [super viewDidLoad];
	// Create the data model
    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    if([_coffeeString isEqualToString:@"0"])
    {
        _pageTitles = @[@"準備一份濃縮咖啡", @"將鮮奶加入濃縮咖啡", @"完成了"];
        _pageImages = @[@"espresso.png", @"pour milk.png",@"Latte.png"];
    }
    else if([_coffeeString isEqualToString:@"1"])
    {
        
         _pageTitles = @[@"準備一份濃縮咖啡", @"將鮮奶加入濃縮咖啡", @"加入巧克力糖漿",@"將發泡鮮奶油倒在濃縮咖啡上", @"完成了!!!"];
        _pageImages = @[ @"espresso.png", @"pour milk.png",@"chocolatesyrup.png", @"WhippedCream.png",@"Mocha.png"];
    }
    else if([_coffeeString isEqualToString:@"2"])
    {
         _pageTitles = @[@"準備一份濃縮咖啡", @"將鮮奶加入濃縮咖啡",@"將牛奶打發", @"倒入咖啡上層", @"完成了"];
        _pageImages = @[@"espresso.png", @"pour milk.png", @"milk foam.png", @"pourfoam.png",@"Cappuccino.png"];
    }
    
    else if([_coffeeString isEqualToString:@"3"])//espresso con panna
    {
        _pageTitles = @[@"準備一份濃縮咖啡",@"將發泡鮮奶油倒在濃縮咖啡上",@"加入焦糖醬", @"完成了"];
        _pageImages = @[@"espresso.png", @"WhippedCream.png", @"camerel sauce.png",@"Espresso Con Panna.png"];
        
    }
    else if([_coffeeString isEqualToString:@"4"])//espresso macchiato
    {
        _pageTitles = @[@"準備一份濃縮咖啡",  @"將牛奶打發倒入咖啡上層", @"完成了"];
        _pageImages = @[@"espresso.png", @"pourfoam.png",@"Espresso Macchiato.png"];
        
    }
    else if([_coffeeString isEqualToString:@"5"])//Americano
    {
        _pageTitles =@[@"準備一份濃縮咖啡", @"用水將杯子裝滿", @"完成了"];
        _pageImages = @[@"espresso.png", @"waterpour.png", @"Americano.png"];
    }
    else if([_coffeeString isEqualToString:@"6"])//caramel macchiato
    {
        _pageTitles = @[@"準備一份濃縮咖啡",@"加入香草醬",  @"加入焦糖醬", @"將牛奶打發倒入咖啡上層", @"完成了"];
        _pageImages = @[@"espresso.png", @"vanila syrup.png", @"camerel sauce.png",@"pourfoam.png",@"Caramel Macchiato.png"];
        
    }
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    //_coffeLabel.text=_coffeeString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
