//
//  ViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 08/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Arredondar botao
    self.entrarBtn.layer.cornerRadius = 5;
    
    self.estaCadastrando = YES;
    
    _pessoaBusiness = [PessoaBusiness new];
    [_pessoaBusiness carregarPessoas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/***
 Valida os dados inserido pelo usuario
 ***/
-(BOOL) dadosInseridosValidos {
    self.emailTx.text = [self.emailTx.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    self.senhaTx.text = [self.senhaTx.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    if (![self emailValido]) {
        [self exibirAlertaComTitulo:@"Atenção" eComMensagem:@"Preencha o email corretamente"];
        return NO;
    }
    
    if ([self.emailTx.text length] == 0) {
        
        [self exibirAlertaComTitulo:@"Atenção" eComMensagem:@"Preencha o email"];
        return NO;
        
    } else if ([self.senhaTx.text length] == 0) {
        [self exibirAlertaComTitulo:@"Atenção" eComMensagem:@"Preencha a senha"];
        return NO;
    }
    
    return YES;
}

/***
 Executa o botao entrar ou cadastrar
 ***/
- (IBAction)entrarAction:(id)sender {
    
    if ([self dadosInseridosValidos]) {

        if (self.estaCadastrando) {
            [self entrarAplicacao];
            
        } else {
            [self cadastrarPessoa];
            
        }
    }
}


/***
 Entra ou Falha
 ***/
- (void) entrarAplicacao {
    
    BOOL validarLogin = [_pessoaBusiness validarEmail:_emailTx.text eComSenha:_senhaTx.text];
    if (validarLogin) {
        [self performSegueWithIdentifier:@"goEntrar" sender:self];
    } else {
        [self exibirAlertaComTitulo:@"Login Inválido" eComMensagem:@"Email ou Senha inválidos"];
    }
    
    [_pessoaBusiness carregarPessoas];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
   
}


-(void) cadastrarPessoa {
    
    if ([self emailValido]) {
        Pessoa *p = [_pessoaBusiness instanciaPessoa];
        p.email = _emailTx.text;
        p.senha = _senhaTx.text;
        NSString *resultado = [_pessoaBusiness savarPessoa: p];
        [self exibirAlertaComTitulo:@"Resultado: " eComMensagem:resultado];
        
        //Apenas limpa se for sucesso.
        if ([resultado isEqualToString:@"Salvo com sucesso !"]) {
            _emailTx.text = @"";
            _senhaTx.text = @"";
        }
        
    } else {
        [self exibirAlertaComTitulo:@"Resultado: " eComMensagem:@"Email inválido"];
    }
    
}


/***
    Quando digita, pega cada digito no email.
 ***/
- (IBAction)emailChange:(id)sender {
    
    //Esconde a senha e so exibe quando o email estiver ok
    if ([self emailValido] && _estaCadastrando) {
        [self ativarSenha];
    
    //Mostra a senha quando estiver no cadastro
    } else if (!_estaCadastrando){
        [self ativarSenha];
        
    } else {
        [self desativarSenha];
    }
}

-(void) desativarSenha {
    self.senhaTx.alpha = 0.2f;
    self.senhaTx.enabled = NO;
}

-(void) ativarSenha {
    self.senhaTx.alpha = 1;
    self.senhaTx.enabled = TRUE;
}

/***
    Ação que muda o cadastrar para o registrar.
 ***/
- (IBAction)registrar:(id)sender {
    
    if (_estaCadastrando){
        self.estaCadastrando = NO;
        [_registrarBtn setTitle:@"Ja sou cadastrado, entrar !" forState:UIControlStateNormal];
        [_entrarBtn setTitle:@"Cadastrar" forState:UIControlStateNormal];
        [self ativarSenha];
        
    } else {
        self.estaCadastrando = YES;
        [_registrarBtn setTitle:@"Registra-se" forState:UIControlStateNormal];
        [_entrarBtn setTitle:@"Entrar" forState:UIControlStateNormal];
        [self desativarSenha];
    }
}

/***
 Valida o regex do email
 ***/
-(BOOL) emailValido{
    
    NSString * email = self.emailTx.text;
    
    if([email length]==0){
        return NO;
    }
    
    NSString *regexPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regexMatches = [regex numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
    
    if (regexMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}



-(void) exibirAlertaComTitulo: (NSString *) titulo eComMensagem: (NSString *) mensagem {
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:titulo message:mensagem preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alerta addAction:ok];
    
    [self presentViewController:alerta animated:YES completion:nil];
}

/***
 Teclado desaparece
 ***/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
