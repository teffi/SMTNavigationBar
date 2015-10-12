# SMTNavigationBar

SMTNavigationBar simply centralizes your custom navigation bar. Create navigation buttons once and viola you can access it on any of your UIViewControllers. 

## Quick Start
##### Cocoapods - Add in Podfile
```
pod 'SMTNavigationBar'
```

##### Import
```objc
#import "UIViewController+SMTNavigationBar.h"
```

##### Create button
```objc
 UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setTitle:@"left" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

[self createButtonWithKey:@"leftBtn" button:leftBtn];
```
##### Set button in the Navigation Bar
```objc
 [self setLeftBarButtonItemWithKey:@"leftBtn" isDefault:YES isPop:YES];
```

##### After this you can get the configured navigation bar by 
#### Important : Always load defaults on viewWillAppear
```objc
 -(void)viewWillAppear:(BOOL)animated{
    [self loadDefaults];
    }
```

#### Button Target Selectors

##### Using Blocks
```objc
[self setLeftBarButtonItemWithKey:@"leftBtn" isDefault:YES withSelectorBlock:^(UIViewController *vc) {
        //When controller is popped. VC becomes a uinavigationcontroller class.
        if([vc isKindOfClass:[UINavigationController class]]){
            UINavigationController * vcs = (UINavigationController *) vc;
            vc = [vcs viewControllers].lastObject;
        }
     NSLog(@"This is the block method generated on first VC but is now being presented in %@",vc.navigationItem.title);
     }];
```

###### Note:  UIViewController * vc becomes a UINavigationController class if its presented after a pop. In such case use this inside the block
```objc
 if([vc isKindOfClass:[UINavigationController class]]){
            UINavigationController * vcs = (UINavigationController *) vc;
            vc = [vcs viewControllers].lastObject;
        }
```

##### Reusing blocks
```objc
 [self runLeftSuperBlock];
 [self runRightSuperBlock];
```

##### Target Selectors
###### Catch the button control event in their corresponding selectors.
```objc
    -(void)SMTNavigationBarDidTapLeftItem
    -(void)SMTNavigationBarDidTapRightItem
    -(void)SMTNavigationBarDidPop
```

###### See demo project for more detailed implementation

## Version
1.0

### Next Steps

- Titleview customization
- Navigation bar configuration
- Swift counterpart
- Better documentation writeup

### Contributing
Fork, implement, pull request. Let us collaborate!

### Copyright
Copyright (c) 2015 [Steffi Tan](http://iamsteffi.com)  
See MIT-LICENSE for further details.


