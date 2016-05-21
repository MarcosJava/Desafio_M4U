//
//  ComprarArtesViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "CellCompraArte.h"
#import "ComprarArtesViewController.h"
#import "CarrinhoAddViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ComprarArtesViewController ()

@end

@implementation ComprarArtesViewController

static NSString *url = @"http://bit.ly/livroios-500px";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.produtoBusiness = [ProdutoBusiness new];
    self.tableView.delegate = self;
    _semInternet = NO;
    
    [self createPushRefresh];
    [self iniciarCabecalho];
    [self iniciarLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/***
 Monta o NavigationBar , com titulo e buttonItem.
 ***/
-(void) iniciarCabecalho {
    
    self.navigationItem.title = @"Comprar Artes";
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    barButtonItem.title = @"Logout";
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

/***
 Leitura do JSON
 ***/
-(void) iniciarLoading {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _elementos = responseObject[@"photos"];
        NSLog(@"%@", [NSString stringWithFormat:@"%lu imagens encontradas" , (unsigned long)_elementos.count]);
        
        if (_elementos.count > 0) {
           // _imagens = [NSMutableArray new];
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
         NSLog(@"%@",[NSString stringWithFormat:@"Erro: %@ e codigo %ld",[error localizedDescription], (long)[error code]]);
        
        if (error.code == -1009) {
            _semInternet = YES;
        }
        
    }];

}


/***
    Configura o Push Refresh
 ***/
- (void) createPushRefresh{
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Atualizando ;)"];
    [self.tableView addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}


/***
 Executa o push refresh
 ***/
- (void)refreshTable {
    //TODO: refresh your data
    [self iniciarLoading];
    [self.refresh endRefreshing];
}



/***
 SAI DO SISTEMA
 ***/
-(void) logout {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


/***
 CARREGA A IMAGEM REMOTA, APENAS A IMAGEM.
 ***/
-(void) carregaImagemRemota: (CellCompraArte*) cell eIndexRow:(NSInteger) indice {
    
    __weak CellCompraArte *weakCell = cell;
    
    Produto *produto = [self.produtoBusiness buscarProdutoComIndice:indice];
    NSString *valor = [[NSString alloc]initWithFormat:@"VALOR: R$ %0.2f", produto.valor];
    
    weakCell.nomeArte.text = produto.nome;
    weakCell.valorArte.text = valor;

    if (!_semInternet) {
        NSDictionary *item = _elementos[indice];
        NSDictionary *imageInfo = item[@"images"][0];
        NSString *urlImagem = imageInfo[@"url"];
        NSURL *urlRequest = [NSURL URLWithString:urlImagem];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlRequest];
        UIImage *placeholderImage = [UIImage imageNamed:@"photos"];
        
        [cell.imagemArte setImageWithURLRequest:request
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            
                                            weakCell.imagemArte.image = image;
                                            [weakCell setNeedsLayout];
                                            
                                        } failure:nil];
    }
    
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.produtoBusiness qtdeProduto];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellCompraArte";
    CellCompraArte *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CellCompraArte alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [self carregaImagemRemota:cell eIndexRow:indexPath.row];
    
    [self arredondarFoto:cell.imagemArte];
    return cell;
}


-(void) arredondarFoto: (UIImageView*)imageView{
    CGRect frame = [imageView frame];
    frame.size.width = 50;
    frame.size.height = 50;
    [imageView setFrame:frame];
    
    imageView.layer.cornerRadius = 25;
    imageView.layer.masksToBounds = YES;
    
}


/*** 
 Toque na tela
 ***/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.produtoSelecionado = indexPath;

    [self iniciaAddCarrinho];
    
    //Acabando a animacao do toque
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) iniciaAddCarrinho {
    
    if (self.produtoSelecionado) {
        CarrinhoAddViewController *addCarrinho = [[CarrinhoAddViewController alloc] initWithNibName:@"CarrinhoAddViewController" bundle:nil];
        
        addCarrinho.delegate = self;
        addCarrinho.produto = [self.produtoBusiness buscarProdutoComIndice: self.produtoSelecionado.row];
        if (!_semInternet) {
            CellCompraArte *cell = [self.tableView cellForRowAtIndexPath:_produtoSelecionado];
            addCarrinho.imagemCarregada = cell.imagemArte.image;
        }
        [self.navigationController pushViewController:addCarrinho animated:YES];
        //[self presentViewController:addCarrinho animated:YES completion:nil];
    }
}


/***
    DELEGATE DO CARRINHO ADD
 ***/
- (void)adicionadoAoCarrinho:(BOOL)adicionado oProduto:(Produto *)produto {
    
    if (adicionado) {
        [self.produtoBusiness addProdutoNoCarrinho:produto];
        [super alterarBagdeCarrinho];
    }
    
}


@end
