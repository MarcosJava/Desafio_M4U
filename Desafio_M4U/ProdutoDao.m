//
//  ProdutoDao.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ProdutoDao.h"

@implementation ProdutoDao

/***
    Singleton
 ***/
static ProdutoDao *instanciaProdutoDao;
+(id) criarInstancia {
    if (!instanciaProdutoDao) {
        instanciaProdutoDao = [[ProdutoDao alloc] init];
    }
    return instanciaProdutoDao;
}


/***
    Construtor que sera instanciado uma unica vez.
    Para nao perder os objetos do array.
 ***/
- (id) init {
    
    self = [super init];
    if (self) {
       
        if ([self primeiraVez]) {
            [self salvaProduto];
        }

        _carrinhos = [NSMutableArray new];
        [self iniciarProdutos];
    }
    return self;
}

-(void) iniciarProdutos {
    _produtos = [[NSMutableArray alloc] initWithArray: [self carregaTodosProdutos]];
}

-(id) instanciarProduto {
    Produto *produto = [NSEntityDescription insertNewObjectForEntityForName:@"Produto" inManagedObjectContext:super.managedObjectContext];
    NSError *error;
    if (![super.managedObjectContext save:&error]) {
        NSLog(@"Erro : %@", [error localizedDescription]);
    }
    
    return produto;
}



-(void) addProdutoNoCarrinho:(Produto *)produto {
    if (produto) {
        [_carrinhos addObject:produto];
    }
}

-(void) prepararProdutoParaSalvar: (NSString*) nome eComValor:(float)valor {
    Produto *p = [self instanciarProduto];
    [p setValue:nome forKey:@"nome"];
    [p setValue:[NSNumber numberWithDouble:valor] forKey:@"valor"];
}



-(void)salvaProduto {
    int r = 0;
    
    for (int i=0; i < 20; i++) {
        r = arc4random_uniform(74);
        r = floorf(r * 100 + 0.5) / 100;
        NSString *nome = [[NSString alloc] initWithFormat:@"Arte do Marcos %d", i];
        [self prepararProdutoParaSalvar:nome  eComValor:r];
    }
    
    [super saveContext];
}

-(void)esvaziarCarrinho {
    _carrinhos = [NSMutableArray new];
}

-(BOOL) primeiraVez{
    
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL primeiraVez = [configuracoes boolForKey:@"dados_inseridos"];
    
    if (!primeiraVez) {
        [configuracoes setBool:YES forKey:@"dados_inseridos"];
        [configuracoes synchronize];
        return YES;
    }
    return NO;
    
}

-(Produto *)buscarProdutoComIndice:(NSInteger)indice {
    return [_produtos objectAtIndex:indice];
}

-(Produto *)buscarCarrinhoComIndice:(NSInteger)indice {
    return [_carrinhos objectAtIndex:indice];
}

-(NSArray *) carregaTodosProdutos {
    
    NSFetchRequest *produtos = [NSFetchRequest fetchRequestWithEntityName:@"Produto"];

    NSError *error = nil;
    
    //Joga o resultado no Array
    NSArray *resultados = [super.managedObjectContext executeFetchRequest:produtos error:nil];
    
    for (Produto *p in resultados) {
        NSLog(@"%@ e %f", p.nome, p.valor);
    }
    
    
    if (!resultados) {
        NSLog(@"Error: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    } else {
        return resultados;
    }
}


- (void) removeCarrinhosNoIndice:(NSInteger) indice{
    [_carrinhos removeObjectAtIndex:indice];
}

-(float) valorTotalCarrinho {
    float soma = 0;
    for (Produto *object in _carrinhos) {
        soma += object.valor;
    }
    return soma;
}

@end
