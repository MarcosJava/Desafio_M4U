//
//  CellCompraArte.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "CellCompraArte.h"

@implementation CellCompraArte

@synthesize nomeArte = _nomeArte;
@synthesize valorArte = _valorArte;
@synthesize imagem = _imagem;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    NSLog(@"Cell !");
    NSLog(_nomeArte.text);

}

@end
