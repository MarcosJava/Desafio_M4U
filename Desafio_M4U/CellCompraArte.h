//
//  CellCompraArte.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellCompraArte : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imagemArte;

@property (weak, nonatomic) IBOutlet UILabel *nomeArte;
@property (weak, nonatomic) IBOutlet UILabel *valorArte;

@end
