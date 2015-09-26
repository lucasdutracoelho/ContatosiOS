//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"



@implementation FormularioContatoViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.dao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain
                                     target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.contato){
        self.navigationItem.title = @"Alterar";
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc]
                                      initWithTitle
                                      :@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
        
        
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        
        if(self.contato.foto){
            [self.botaoAdicionaImagem setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.botaoAdicionaImagem setTitle:nil forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pegaDadosDoFormulario{
    if(!self.contato){
        self.contato = [self.dao novoContato];
    }
    if([self.botaoAdicionaImagem backgroundImageForState:UIControlStateNormal]){
        self.contato.foto = [self.botaoAdicionaImagem backgroundImageForState:UIControlStateNormal];
    }
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    
    //NSLog(@"Contato:  %@", contato);
    
}

-(void) criaContato {
    [self pegaDadosDoFormulario];
    [self.dao adicionaContato:self.contato];
    
    if(self.delegate){
        [self.delegate contatoAdicionado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)atualizaContato{
    [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //camera disponivel
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"Escolha a foto do Contato"
                                delegate:self
                                cancelButtonTitle:@"Cancelar"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        [sheet showInView:self];
    }else{
        //usar biblioteca
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoAdicionaImagem setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [self.botaoAdicionaImagem setTitle:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(IBAction)buscarCoordenadas:(UIButton*)sender{
    [self.loading startAnimating];
    sender.hidden = YES;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:
     ^(NSArray *resultados, NSError *error) {
         if(error == nil && [resultados count] > 0){
             CLPlacemark *resultado = resultados[0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }else{
             NSLog(@"Erro: %@ Resultados: %@", error , resultados);
         }
         [self.loading stopAnimating];
         sender.hidden = NO;
     }];
}



@end
