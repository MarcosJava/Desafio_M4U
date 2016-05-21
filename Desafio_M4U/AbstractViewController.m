//
//  AbstractViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 20/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractViewController ()

@end

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) alterarBagdeCarrinho {
    _produtoBusiness = [ProdutoBusiness new];
    NSInteger qtd = [_produtoBusiness qtdeCarrinho];
    if (qtd == 0) {
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
    } else {
        NSString *qtdString = [[NSString alloc]initWithFormat:@"%ld" ,(long)qtd];
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:qtdString];
    }
}

@end
