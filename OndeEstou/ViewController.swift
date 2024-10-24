//
//  ViewController.swift
//  OndeEstou
//
//  Created by João Bueno on 24/10/24.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    var locationManage = CLLocationManager()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigation = UINavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "Onde Estou?")
        navigation.items = [navigationItem]
        
        return navigation
    } ()
    
    private lazy var viewOptions: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Color")
        
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }()
    
    private lazy var velocidadeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Velocidade:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var valorVelocidadeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var longitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Logitude:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var respLongitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var latitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Latitude:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var respLatitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var enderecoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Endereço:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var respEnderecoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.textAlignment = .left
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManage.delegate = self
        locationManage.desiredAccuracy = kCLLocationAccuracyBest
        locationManage.requestWhenInUseAuthorization()
        locationManage.startUpdatingLocation()
        
        setupProject()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            var alertController = UIAlertController(title: "Permissão de localização", message: "Necessario permissão para acesso a sua localização! Por favor habilite.", preferredStyle: .alert)
            
            var acaoConfiguracoes = UIAlertAction(title: "Abrir configurações", style: .default, handler: {(alertaConfiguracao) in
                if let configuracoes = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open( configuracoes as URL)
                }
            })
            var acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func setupProject() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(navigationBar)
        view.addSubview(viewOptions)
        view.addSubview(mapView)
        
        viewOptions.addSubview(velocidadeLabel)
        viewOptions.addSubview(valorVelocidadeLabel)
        viewOptions.addSubview(longitudeLabel)
        viewOptions.addSubview(latitudeLabel)
        viewOptions.addSubview(enderecoLabel)
        viewOptions.addSubview(respLongitudeLabel)
        viewOptions.addSubview(respLatitudeLabel)
        viewOptions.addSubview(respEnderecoLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            viewOptions.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            viewOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewOptions.heightAnchor.constraint(equalToConstant: 200),
            
            mapView.topAnchor.constraint(equalTo: viewOptions.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            velocidadeLabel.topAnchor.constraint(equalTo: viewOptions.topAnchor,constant: 20),
            velocidadeLabel.leadingAnchor.constraint(equalTo: viewOptions.leadingAnchor, constant: 10),
            velocidadeLabel.widthAnchor.constraint(equalToConstant: 120),
            
            valorVelocidadeLabel.topAnchor.constraint(equalTo: velocidadeLabel.bottomAnchor, constant: 10),
            valorVelocidadeLabel.leadingAnchor.constraint(equalTo: viewOptions.leadingAnchor, constant: 10),
            valorVelocidadeLabel.heightAnchor.constraint(equalToConstant: 97),
            valorVelocidadeLabel.widthAnchor.constraint(equalToConstant: 97),
            
            longitudeLabel.topAnchor.constraint(equalTo: viewOptions.topAnchor, constant: 20),
            longitudeLabel.leadingAnchor.constraint(equalTo: velocidadeLabel.trailingAnchor, constant: 20),

            respLongitudeLabel.centerYAnchor.constraint(equalTo: longitudeLabel.centerYAnchor),
            respLongitudeLabel.leadingAnchor.constraint(equalTo: longitudeLabel.trailingAnchor, constant: 10),
            
            latitudeLabel.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 30),
            latitudeLabel.leadingAnchor.constraint(equalTo: valorVelocidadeLabel.trailingAnchor, constant: 43),
            
            respLatitudeLabel.centerYAnchor.constraint(equalTo: latitudeLabel.centerYAnchor),
            respLatitudeLabel.leadingAnchor.constraint(equalTo: latitudeLabel.trailingAnchor, constant: 10),
            
            enderecoLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 30),
            enderecoLabel.leadingAnchor.constraint(equalTo: valorVelocidadeLabel.trailingAnchor, constant: 43),
            
            respEnderecoLabel.centerYAnchor.constraint(equalTo: enderecoLabel.centerYAnchor),
            respEnderecoLabel.leadingAnchor.constraint(equalTo: enderecoLabel.trailingAnchor, constant: 10),
            
        ])
    }
}

extension ViewController: CLLocationManagerDelegate {
    
}

