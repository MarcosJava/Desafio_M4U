//
//  PessoaDao.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 09/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "PessoaDao.h"

@implementation PessoaDao

// Instancia do Singleton
static PessoaDao *criarInstancia = nil;

/***
    CONSTRUTOR Singleton
 ***/
+(id) criarInstancia {
    
    if(criarInstancia == nil) {
        criarInstancia = [PessoaDao new];
    }
    return criarInstancia;
}


-(id) init {
    self = [super init];
    return self;
}


-(id) instanciarPessoa {
    Pessoa *pessoa = [NSEntityDescription insertNewObjectForEntityForName:@"Pessoa" inManagedObjectContext:super.managedObjectContext];
    NSError *error;
    if (![super.managedObjectContext save:&error]) {
        NSLog(@"Erro ao instancia nova pessoa: %@", [error localizedDescription]);
    }
    
    return pessoa;
}


-(NSArray *) carregaTodasPessoas {
    
    //Cria uma busca
    NSFetchRequest *buscaPessoas = [NSFetchRequest fetchRequestWithEntityName:@"Pessoa"];
    
    //Cria uma ordenacao
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"email" ascending:YES];
    
    NSError *error = nil;

    
    //Coloca a ordenacao na busca
    buscaPessoas.sortDescriptors = @[ordenarPorNome];
    
    //Joga o resultado no Array
    NSArray *resultados = [super.managedObjectContext executeFetchRequest:buscaPessoas error:nil];
    
    if (!resultados) {
        NSLog(@"Error : %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    } else {
        return resultados;
    }
}

-(BOOL) emailCadastrado: (NSString *) email {
    NSFetchRequest * busca = [NSFetchRequest fetchRequestWithEntityName:@"Pessoa"];
    NSPredicate *consulta = [NSPredicate predicateWithFormat:@"email == %@", email];
    [busca setPredicate:consulta];
    
    
    NSError *error = nil;
    
    NSArray *resultado = [super.managedObjectContext executeFetchRequest:busca error:&error];
    if (!resultado) {
        NSLog(@"Error : %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    } else if (resultado.count > 1) { //Pq o email atual já fica pre cadastrado.
        return YES;
    } else if (resultado.count == 0) {
        return NO;
    }
    return NO;
}

- (Pessoa *) carregarPessoaComEmail: (NSString *)email eSenha: (NSString*) senha {
    
    NSFetchRequest * busca = [NSFetchRequest fetchRequestWithEntityName:@"Pessoa"];
    NSPredicate *consulta = [NSPredicate predicateWithFormat:@"email == %@ AND senha == %@", email, senha];
    [busca setPredicate:consulta];
    
    
    NSError *error = nil;
    
    NSArray *resultado = [super.managedObjectContext executeFetchRequest:busca error:&error];
    
    if (!resultado) {
        NSLog(@"Error : %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
        
    } else if (resultado.count > 0) { //Pq o email atual já fica pre cadastrado.
        return [resultado objectAtIndex:0];
    } else if (resultado.count == 0) {
        return nil;
    }
    return nil;
}

- (Pessoa *) carregarPessoaComEmail: (NSString *)email {
    
    NSFetchRequest * busca = [NSFetchRequest fetchRequestWithEntityName:@"Pessoa"];
    NSPredicate *consulta = [NSPredicate predicateWithFormat:@"email == %@", email];
    [busca setPredicate:consulta];
    
    
    NSError *error = nil;
    
    NSArray *resultado = [super.managedObjectContext executeFetchRequest:busca error:&error];
    
    if (!resultado) {
        NSLog(@"Error : %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
        
    } else if (resultado.count > 0) { //Pq o email atual já fica pre cadastrado.
        return [resultado objectAtIndex:0];
    } else if (resultado.count == 0) {
        return nil;
    }
    return nil;
}




@end
