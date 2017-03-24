//
//  WasherSaverView.m
//  WasherSaver
//
//  Created by Julian Bleecker on 9/2/16.
//  Copyright © 2016 Julian Bleecker. All rights reserved.
//

#import "WasherSaverView.h"

@implementation WasherSaverView

NSDate  *_date;


- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/2.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

//- (void)drawRect:(NSRect)rect
//{
//
//    [super drawRect:rect];
////    [self drawBackground];
////    [self drawTimeLabel];
//
//}

- (void) drawBackground
{
    NSColor *color = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:.5];
    [color set];
    
    [NSBezierPath fillRect:[self bounds]];
}

- (void) drawTimeLabel
{
    NSDateFormatter *time_format = [[NSDateFormatter alloc] init];
    
    [time_format setDateFormat:@"HH· mm· ss"];
    
    NSString *time = [time_format stringFromDate:_date];
    
    NSMutableDictionary *str_attributes = [[NSMutableDictionary alloc] init];
    
    [str_attributes setValue:[NSColor colorWithCalibratedWhite:1 alpha:1] forKey:NSForegroundColorAttributeName];
    
    [str_attributes setValue:[NSFont fontWithName:@"Century Gothic" size:[self height] / 6] forKey:NSFontAttributeName];
    
    NSSize str_size = [time sizeWithAttributes:str_attributes];
    NSColor *color = [NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:1];
    [color set];
    [time drawAtPoint:NSMakePoint([self width] / 2 - str_size.width / 2, [self height] / 2 - str_size.height / 2) withAttributes:str_attributes];
}





- (void)animateOneFrame
{
    //[self setNeedsDisplay:true];
    NSBezierPath *path;
    NSRect rect;
    NSSize size;
    NSColor *color;
    float red = 0.0, green = 0.0, blue = 0.0, alpha = 1.0;
    
    size = [self bounds].size;
    
    if (SSRandomIntBetween( 0, 2 ) == 0) {
        return;
    }
    
    int step_x = SSRandomIntBetween(0,size.width/180);
    int r = 1+step_x*180;//arc4random_uniform( size.width/90 );
    int step_y = SSRandomIntBetween(0,size.height/180);
    
    //NSLog(@"origin.x=%f origin.y=%f", rect.origin.x, rect.origin.y);
    int w = SSRandomIntBetween(0,2);

    if(w <= 1) {
        rect.origin.x = r - 90/2;
        rect.origin.y = (step_y*180 - 90/2);
        rect.size = NSMakeSize(90,90);
        path = [NSBezierPath bezierPathWithOvalInRect:rect];
        [path setLineWidth:40];

        
    } else if (w == 2){
        rect.origin.x = r - 110/2;
        rect.origin.y = (step_y*180 - 110/2);
        rect.size = NSMakeSize(110, 110);
        path = [NSBezierPath bezierPathWithOvalInRect:rect];
        [path setLineWidth:20];
        
        
        color = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1];
        [color set];
        
        rect.size = NSMakeSize(150.0, 150.0);
        rect.origin.x = r - 150/2;
        rect.origin.y = (step_y*180 - 150/2);
        
        [NSBezierPath fillRect:rect];
    } else if (w == 3) {
        rect.origin.x = r - 90/2;
        rect.origin.y = (step_y*180 - 90/2);
        rect.size = NSMakeSize(90,90);
        CGFloat fontSize = 48;
        NSMutableParagraphStyle *centredStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [centredStyle setAlignment:NSCenterTextAlignment];
        
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSFont fontWithName:@"OMATA NUMBERS" size:fontSize], NSFontAttributeName,
                                        [NSColor greenColor], NSForegroundColorAttributeName,
                                        centredStyle, NSParagraphStyleAttributeName,
                                        nil];
        NSString *theText = @"0123456789";
        
        // position text on screen
        //NSRect boundingRect = [theText boundingRectWithSize:rect.size options:0 attributes:textAttributes];
        NSPoint point = NSMakePoint(rect.origin.x, rect.origin.y);
        [[NSColor colorWithRed:1.0 green:.05 blue:.5 alpha:1] set];
        [theText drawAtPoint: point withAttributes: textAttributes];
    }
    

    int c = SSRandomIntBetween(0,3);
    if(c == 0) {
        red = 240.0/255.0;//SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
        green = 75.0/255.0;//SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
        blue = 55.0/255.0;//SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
        
    }
    if(c == 1) {
        red = 210.0/255.0;
        green = 255.0/255.0;
        blue = 66.0/255.0;
    }
    if(c == 2 || c == 3) {
        red = 0.0;
        green = 0.0;
        blue = 0.0;
        color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
        [color set];
        rect.size = NSMakeSize(150.0, 150.0);
        rect.origin.x = r - 150/2;
        rect.origin.y = (step_y*180 - 150/2);
        [NSBezierPath fillRect:rect];
        return;
        //[path setLineWidth:50];
    }
    
    alpha = 1.0;//SSRandomFloatBetween( 0.0, 255.0 ) / 255.0;
    color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
    
    [color set];
    // And finally draw it
    [path stroke];

    
    return;
}


- (float) width
{
    return [self bounds].size.width;
}

- (float) height
{
    return [self bounds].size.height;
}


- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
