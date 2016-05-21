//
//  UsuarioSessao.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 20/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "UsuarioSessao.h"

@implementation UsuarioSessao

// Instancia do Singleton
static UsuarioSessao *criarInstancia = nil;
@synthesize email = _email;


+(id) instanciar {
    if (!criarInstancia) {
        criarInstancia = [UsuarioSessao new];
    }
    return criarInstancia;
}



-(id) init {
    self = [super init];
    return self;
}

@end
