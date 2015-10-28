//
//  SMTSharedNavigationBar.h
//  SMTNavigationBar
//
//  Created by Teffi : github.com/teffi/SMTNavigationBar
//  Copyright (c) 2015 iamsteffi.com
//

//The MIT License (MIT)

//Copyright (c) 2015 Steffi Tan

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LeftAction_BlockSelector)(UIViewController * vc);
typedef void (^RightAction_BlockSelector)(UIViewController * vc);
typedef void (^LeftDefault_BlockSelector)(UIViewController * vc);
@interface SMTSharedNavigationBar : NSObject

@property(strong,readonly)NSMutableDictionary * buttonList;
@property(strong,readonly)NSMutableDictionary * titleList;
@property(strong,readonly)NSMutableDictionary * titleViewList;

@property(nonatomic,strong)UIButton * defaultLeftButton;
@property(nonatomic,strong)UIButton * defaultRightButton;

@property(nonatomic, strong)NSString * defaultTitle;
@property(nonatomic, strong)UIView * defaultTitleView;
@property(nonatomic, strong)UIImage * defaultTitleViewImage;

@property(nonatomic)BOOL willHideBackBtnAlways;
@property(nonatomic)BOOL getLeftSuperBlock;
@property(nonatomic,strong)UIViewController * selfReference;
@property(nonatomic)BOOL defaultLeftPop;
//Holds default block selectors
@property(nonatomic,copy)LeftAction_BlockSelector leftActionBlock;
@property(nonatomic,copy)RightAction_BlockSelector rightActionBlock;
-(void)addToButtonList:(NSString *)key button:(UIButton *)btn;
-(void)addTitleList:(NSString *)key title:(NSString *)title;
-(void)addTitleViewList:(NSString *)key titleView:(UIView *)titleView;

-(void)runLeftActionBlockSelector:(LeftAction_BlockSelector)block;
-(void)runRightActionBlockSelector:(RightAction_BlockSelector)block;

-(void)resetSMTNavigationBar;

+(SMTSharedNavigationBar *)sharedNavigationBar;
@end
