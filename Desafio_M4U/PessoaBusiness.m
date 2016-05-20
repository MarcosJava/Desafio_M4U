//
//  PessoaBusiness.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 10/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "PessoaBusiness.h"

@implementation PessoaBusiness


-(id) init {
    self = [super self];
    if (self) {
        _pessoaDao = [PessoaDao criarInstancia];
    }
    return self;
}

-(NSString *) savarPessoa: (Pessoa *) pessoa{
    
    if ((pessoa != nil)) {
        if (pessoa.email) {
            
            if ([self emailCadastrado:pessoa.email]) {
                return @"Email já existe entre com outro !!";
            }
            
            if (pessoa.senha.length < 4) {
                return @"A senha deve ter maior que 4 digitos";
            }
            
            if (pessoa.senha) {
                [_pessoaDao saveContext];
                return @"Salvo com sucesso !";
            }
            
        }
        
    }
    return @"Verifique novamente, ocorreu um erro";
}

-(BOOL) emailCadastrado: (NSString *) email {
    return [_pessoaDao emailCadastrado:email];
}

-(Pessoa *) instanciaPessoa {
    return [_pessoaDao instanciarPessoa];
}
-(void) carregarPessoas {
    NSArray *pessoas = [_pessoaDao carregaTodasPessoas];
    for (Pessoa *p in pessoas) {
        NSLog(@"%@", p.email);
        NSLog(@"%@", p.senha);
    }
    
}

- (BOOL) validarEmail:(NSString*) email eComSenha:(NSString*) senha {
    Pessoa *p = [_pessoaDao carregarPessoaComEmail:email eSenha:senha];
    if (p) {
        return YES;
    }
    return NO;
}

@end
