//
//  ProdutoBusiness.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ProdutoBusiness.h"

@implementation ProdutoBusiness

-(id) init {
    self = [super init];
    if (self) {
        _produtoDao = [ProdutoDao criarInstancia];
    }
    return self;
}

-(id)instanciarProduto{
    return [self.produtoDao instanciarProduto];
}


-(NSString *)addProdutoNoCarrinho:(Produto *)produto {
    
    //Valida o produto
    if (produto) {
        if (!produto.nome) {
            return @"Produto sem nome !";
        }
        if (!produto.valor) {
            return @"produto nao tem valor";
        }
        
        [_produtoDao addProdutoNoCarrinho:produto];
        return @"Produto adicionado no carrinho !";
    
    } else {
        return @"Produto nullo ou inválido !";
    }
    
}

-(void)realizarCompra {
    [_produtoDao esvaziarCarrinho];
}

-(NSInteger)qtdeProduto{
    return [_produtoDao.produtos count] ;
}

-(NSInteger)qtdeCarrinho{
    return [_produtoDao.carrinhos count] ;
}

-(NSArray *)produtos{
    return _produtoDao.produtos;
}

-(NSArray *)carrinhos{
    return _produtoDao.carrinhos;
}

-(Produto *)buscarProdutoComIndice:(NSInteger)indice {
    
    if (indice < [self qtdeProduto]) {
        return [_produtoDao buscarProdutoComIndice: indice];
    }
    
    return nil;
}
-(Produto*) buscarCarrinhoComIndice: (NSInteger) indice{
    if (indice < [self qtdeCarrinho]) {
        return [_produtoDao buscarCarrinhoComIndice: indice];
    }
    
    return nil;
    
}
-(float) valorTotalCarrinho {
    return [_produtoDao valorTotalCarrinho];
}

- (void) removeCarrinhosNoIndice:(NSInteger) indice{
    
    if ([self qtdeCarrinho] >= indice) {
        [_produtoDao removeCarrinhosNoIndice:indice];
    }
}


@end
