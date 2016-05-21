//
//  AbstractViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 20/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProdutoBusiness.h"

@interface AbstractViewController : UIViewController

@property ProdutoBusiness *produtoBusiness;
-(void) alterarBagdeCarrinho;

@end
