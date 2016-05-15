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
static PessoaDao *createInstance = nil;

/***
    CONSTRUTOR Singleton
 ***/
+(id) criarInstancia {
    
    if(createInstance == nil) {
        createInstance = [PessoaDao new];
    }
    return createInstance;
}


-(id) init {
    self = [super init];
    return self;
}


-(id) instanciarPessoa {
    Pessoa *pessoa = [NSEntityDescription insertNewObjectForEntityForName:@"Pessoa" inManagedObjectContext:self.managedObjectContext];
    NSError *error;
    if (![_managedObjectContext save:&error]) {
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
    NSArray *resultados = [self.managedObjectContext executeFetchRequest:buscaPessoas error:nil];
    
    if (!resultados) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
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
    
    NSArray *resultado = [self.managedObjectContext executeFetchRequest:busca error:&error];
    if (!resultado) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
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
    
    NSArray *resultado = [self.managedObjectContext executeFetchRequest:busca error:&error];
    
    if (!resultado) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
        
    } else if (resultado.count > 0) { //Pq o email atual já fica pre cadastrado.
        return [resultado objectAtIndex:0];
    } else if (resultado.count == 0) {
        return nil;
    }
    return nil;
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.mfelipesp.Desafio_M4U" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Desafio_M4U" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Desafio_M4U.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}




@end
