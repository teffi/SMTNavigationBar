//
//  UIViewController+SMTNavigationBar.h
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

#import <UIKit/UIKit.h>

typedef void (^LeftAction_BlockSelector)(UIViewController * vc);
typedef void (^RightAction_BlockSelector)(UIViewController * vc);

@interface UIViewController (SMTNavigationBar)

/**
 *  Hides back button
 *
 *  @param willHide BOOL
 *  @param isAlways BOOL - equivalent to default
 */
-(void)willHideBackButton:(BOOL)willHide isAlways:(BOOL)isAlways;

/**
 *  Create UIButtons which you could call anywhere when setting up navigation bar button item.
 *
 *  @param key Button keyname - identifier
 *  @param btn UIButton
 */
-(void)createButtonWithKey:(NSString *)key button:(UIButton *)btn;
/**
 *  Set left bar button item by calling the button you've created.
 *
 *  @param key       NSString : button keyname - identifier
 *  @param isDefault BOOL : Setting to YES will include this on [loadDefaults]
 *  @param isPop     BOOL : YES if the button calls popViewController:Animated
 */

-(void)createTitleWithKey:(NSString *)key title:(NSString *)title;

//-(void)setTitle:(NSString *)title;
-(void)setTitle:(NSString *)title key:(NSString *)key isDefault:(BOOL)isDefault;
/**
 * Set navigation bar title
 *
 * @param title     NSString : title
 * @param key       NSString : key
 * @param isDefault BOOL     : isDefault
 *
 */

-(void)setTitleViewWithImage:(UIImage *)image;
/**
 * Set navigation bar title with image
 *
 * @param image       UIImage : image
 * @param title     NSString : title
 *
 */

-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault isPop:(BOOL)isPop;
/**
 *  Set left bar button item with additional selector block.
 *
 *  @param key       NSString : button keyname - identifier
 *  @param isDefault BOOL : Setting to YES will include this on [loadDefaults]
 *                   NOTE : This includes the block method.
 *  @param block     Add your own selector methods on the button target. 
 *                   Block returns an reference to the current view controller.
 */
-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(LeftAction_BlockSelector)block;
/**
 *  Set right bar button item with additional selector block.
 *
 *  @param key       NSString : button keyname - identifier
 *  @param isDefault BOOL : Setting to YES will include this on [loadDefaults]
 */
-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault;
/**
 *  Set right bar button item with additional selector block.
 *
 *  @param key       NSString : button keyname - identifier
 *  @param isDefault BOOL : Setting to YES will include this on [loadDefaults]
 *                   NOTE : This includes the block method.
 *  @param block     Add your own selector methods on the button target.
 *                   Block returns an reference to the current view controller.
 */
-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(RightAction_BlockSelector)block;
/**
 *  Loads all defaults
 */
-(void)loadDefaults;
/**
 *  Reset values
 */
-(void)resetSMTNavigationBar;
/**
 *  IMPORTANT: Updates self reference to the current presenting controller.
 *            - Controller loses self reference when presented coming from a POP.
 */
-(void)updateSelfReference;

/**
 *  Run the block methods declared prior
 */
-(void)runLeftSuperBlock;


/**
 *  Run the block methods declared prior
 */
-(void)runRightSuperBlock;

/**
 *  Remove all items from the bar
 */
-(void)clearSMTNavigationBar;
@end
