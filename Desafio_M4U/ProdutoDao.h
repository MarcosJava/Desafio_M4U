//
//  ProdutoDao.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Produto.h"
#import "Dao.h"

@interface ProdutoDao : Dao

+(id) criarInstancia;
- (id) instanciarProduto;


@property (strong, readonly) NSMutableArray *produtos;
@property (strong, readonly) NSMutableArray *carrinhos;

-(void) addProdutoNoCarrinho: (Produto *) produto;

-(id) buscarProdutoComIndice: (NSInteger) indice;
-(id) buscarCarrinhoComIndice: (NSInteger) indice;
-(float) valorTotalCarrinho;
- (void) removeCarrinhosNoIndice:(NSInteger) indice;
-(void)esvaziarCarrinho;
@end
