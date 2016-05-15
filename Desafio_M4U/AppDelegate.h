//
//  AppDelegate.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 08/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PessoaDao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property PessoaDao *pessoaDao;


@end

