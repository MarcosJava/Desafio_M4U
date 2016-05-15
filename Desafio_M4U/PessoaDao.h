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

@interface PessoaDao : NSObject
+(id) criarInstancia;
- (id) instanciarPessoa;
- (NSArray *) carregaTodasPessoas;
-(BOOL) emailCadastrado: (NSString *) email;
- (Pessoa *) carregarPessoaComEmail: (NSString *)email eSenha: (NSString*) senha;


//PARTE DO CORE DATA
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
