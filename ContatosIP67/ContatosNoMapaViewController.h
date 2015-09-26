//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios5436 on 19/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContatoDao.h"
#import "Contato.h"

@interface ContatosNoMapaViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property CLLocationManager *manager;
@property (nonatomic, weak) NSMutableArray *contatos;
@property ContatoDao* dao;

@end
