//
//  PessoaBusiness.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 10/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PessoaDao.h"
#import "Pessoa.h"
#import "Constants.h"

@interface PessoaBusiness : NSObject

@property (strong, nonatomic) PessoaDao *pessoaDao;

-(NSString *) savarPessoa: (Pessoa *) pessoa;
-(void) carregarPessoas;
-(Pessoa *) instanciaPessoa;
- (BOOL) validarEmail:(NSString*) email eComSenha:(NSString*) senha;

@end
