//
//  PessoaDao.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 09/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Pessoa.h"
#import "Dao.h"

@interface PessoaDao : Dao

+(id) criarInstancia;
- (id) instanciarPessoa;
- (NSArray *) carregaTodasPessoas;
-(BOOL) emailCadastrado: (NSString *) email;
- (Pessoa *) carregarPessoaComEmail: (NSString *)email eSenha: (NSString*) senha;


@end
