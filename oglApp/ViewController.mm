//
//  ViewController.m
//  oglApp
//
//  Created by Simon Jordan on 06/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"
#include "globals.h"
@interface ViewController (){

    
}

@property (strong, nonatomic) EAGLContext * context;


- (void)tearDownGL;

@end

@implementation ViewController

- (void)swipeRight:(UISwipeGestureRecognizer* )UIRecognizer
{
    //NSLog(@"SWIPE RIGHT RECIEVED");
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeRight(true);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeLeft(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeUp(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeDown(false);
}

- (void)swipeLeft:(UISwipeGestureRecognizer* )UIRecognizer
{
   // NSLog(@"SWIPE LEFT RECIEVED");
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeRight(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeLeft(true);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeUp(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeDown(false);
}
- (void)swipeUp:(UISwipeGestureRecognizer* )UIRecognizer
{
    //NSLog(@"SWIPE UP RECIEVED");
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeRight(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeLeft(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeUp(true);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeDown(false);
}
- (void)swipeDown:(UISwipeGestureRecognizer* )UIRecognizer
{
   // NSLog(@"SWIPE DOWN RECIEVED");
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeRight(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeLeft(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeUp(false);
    gameEngine->getGameManager()->getGameSystemManager()->setSwipeDown(true);
}

- (void)longPress:(UILongPressGestureRecognizer*)pressRecognizer
{
    if(pressRecognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"LONG PRESS DETECTED");
    }
    if(pressRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"LONG PRESS ENDED");
    }

}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    gameEngine->getGameManager()->getGameSystemManager()->setIsTouched(true);
    touch = [touches anyObject];
    touchPosition = [[touches anyObject] locationInView:self.view];
    oldLocation = [touch previousLocationInView:self.view];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    gameEngine->getGameManager()->getGameSystemManager()->setIsTouched(false);
}


- (void)viewDidLoad
{
    
    UISwipeGestureRecognizer* UIRecognizer;
    UIRecognizer.numberOfTouchesRequired = 1;
    
    UIRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [UIRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view]addGestureRecognizer:UIRecognizer];
    
    UIRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [UIRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view]addGestureRecognizer:UIRecognizer];
    
    UIRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    [UIRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view]addGestureRecognizer:UIRecognizer];
    
    UIRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    [UIRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view]addGestureRecognizer:UIRecognizer];
    
    UILongPressGestureRecognizer* pressRecognizer;
    pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [[self view]addGestureRecognizer:pressRecognizer];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //start = [NSDate date];
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    gameEngine = new engine();
        
    if(!self.context ||  ![EAGLContext setCurrentContext:self.context])
    {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView * view = (GLKView *)self.view;
    view.context = self.context;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
   
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;

    
    if(gameEngine != NULL)
        gameEngine->init(screenWidth, screenHeight);
    
    gameEngine->getGameManager()->getGameSystemManager()->_pTouch = new class touch(&touchPosition, &isTouchHeld, &isTouched);
}

-(void)update {
    
    gameEngine->update();
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    gameEngine->draw((GLfloat)view.drawableWidth,(GLfloat)view.drawableHeight);
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}

-(void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
}


-(void)dealloc
{
    [self tearDownGL];
    
    if(gameEngine)
        delete gameEngine;
    
    if([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

@end
