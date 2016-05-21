//
//  ViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 08/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pessoa.h"
#import "PessoaBusiness.h"
#import "Constants.h"
#import "ComprarArtesViewController.h"
#import "AbstractViewController.h"


@interface ViewController : AbstractViewController


@property (weak, nonatomic) IBOutlet UITextField *emailTx;
- (IBAction)entrarAction:(id)sender;
- (IBAction)emailChange:(id)sender;
- (IBAction)registrar:(id)sender;

@property (nonatomic) BOOL estaCadastrando;
@property (weak, nonatomic) IBOutlet UIButton *entrarBtn;
@property (weak, nonatomic) IBOutlet UIButton *registrarBtn;
@property (weak, nonatomic) IBOutlet UITextField *senhaTx;


@property (strong) Pessoa *pessoa;
@property (strong) PessoaBusiness *pessoaBusiness;

@end

