//
//  Produto.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "Produto.h"

@implementation Produto

@dynamic nome, valor;


-(id) initComNome: (NSString *)nome eComValor: (float) valor {
    
    if(self){
        self.nome = nome;
        self.valor = valor;
    }
    
    return self;
}

@end
