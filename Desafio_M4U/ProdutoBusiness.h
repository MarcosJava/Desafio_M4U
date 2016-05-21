//
//  ProdutoBusiness.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produto.h"
#import "ProdutoDao.h"

@interface ProdutoBusiness : NSObject

@property ProdutoDao *produtoDao;

-(id)instanciarProduto;

-(NSString*) addProdutoNoCarrinho: (Produto*) produto;
-(void) realizarCompra;
-(NSInteger) qtdeProduto;
-(NSInteger) qtdeCarrinho;
-(NSArray *) produtos;
-(NSArray *) carrinhos;
-(Produto*) buscarProdutoComIndice: (NSInteger) indice;
-(Produto*) buscarCarrinhoComIndice: (NSInteger) indice;
- (void) removeCarrinhosNoIndice:(NSInteger) indice;
-(float) valorTotalCarrinho;


@end
