//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios5436 on 19/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (id) init{
    self = [super init];
    if(self) {
        self.navigationItem.title = @"Localização";
        UIImage *imagemTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa"
                                                              image:imagemTabItem
                                                                tag:0];
        self.tabBarItem = tabItem;
        self.dao = [ContatoDao contatoDaoInstance];
        self.contatos = self.dao.contatos;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem = botaoLocalizacao;
    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.mapa addAnnotations:self.contatos];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:self.contatos];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *) [self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }else{
        pino.annotation = annotation;
    }
    
    Contato *contato = (Contato *)annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;
    if(contato.foto){
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }
    return pino;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
