//
//  ComprarArtesViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ComprarArtesViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ComprarArtesViewController ()

@end

@implementation ComprarArtesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self iniciarCabecalho];
    [self iniciarLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***
 Monta o NavigationBar , com titulo e buttonItem.
 ***/
-(void) iniciarCabecalho {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    barButtonItem.title = @"Logout";
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}


-(void) iniciarLoading {
    NSString *url = @"http://bit.ly/livroios-500px";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _elementos = responseObject[@"photos"];
        [self mostraMensagem: [NSString stringWithFormat:@"%lu imagens encontradas" , (unsigned long)_elementos.count]];
        
        if (_elementos.count > 0) {
            //Monta o Objeto
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self mostraMensagem:[NSString stringWithFormat:@"Erro: %@",[error localizedDescription]]];
    }];

}


-(void) logout {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void) mostraMensagem:(NSString *) message {
    NSLog(@"%@", message);
}

-(UIImageView *) carregaImagemRemota: (int) indice {
    
    NSDictionary *item = _elementos[indice];
    NSDictionary *imageInfo = item[@"images"][0];
    NSString *url = imageInfo[@"url"];
    
    NSLog(@"Carregando a URL : %@", url);
    
    UIImageView *img = _imagens[indice];
    img.contentMode = UIViewContentModeScaleAspectFill;
    [img setImageWithURL:[NSURL URLWithString:url]];
    return img;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;//_elementos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CellCompraArte *cell = [[CellCompraArte alloc]init];
//    static NSString *CelulaCache = @"CellCompraArtes";
//    cell = [self.tableView dequeueReusableCellWithIdentifier:CelulaCache];
//    
//    if (cell) {
//        cell = [[CellCompraArte alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CelulaCache];
//    }
//    
//
//
//
//    cell.imagem = [self arredondarFoto:cell.imagem];
    
    static NSString *simpleTableIdentifier = @"CellCompraArtes";
    
    CellCompraArte *cell = (CellCompraArte *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellCompraArtes" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    int r = arc4random_uniform(74);
    NSString *valor = [[NSString alloc]initWithFormat:@"%d", r];
    
    cell.nomeArte.text = @"Marcos";
    cell.valorArte.text = valor;
    
    UIImageView *imagem = [UIImageView new];
    imagem.image = [UIImage imageNamed:@"bug.png"];
    
    cell.imagem.image = imagem.image;

    return cell;
}

/**
 
 Arredondar Foto
 */
-(UIImageView*) arredondarFoto: (UIImageView*)imageView{
    CGRect frame = [imageView frame];
    frame.size.width = 50;
    frame.size.height = 50;
    [imageView setFrame:frame];
    
    imageView.layer.cornerRadius = 25;
    imageView.layer.masksToBounds = YES;
    
    return imageView;
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Chegou aqui");
}


@end
