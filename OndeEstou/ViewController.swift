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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        setupProject()
        
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
            velocidadeLabel.trailingAnchor.constraint(equalTo: viewOptions.trailingAnchor, constant: -50)
        ])
    }


}

