//
//  ViewController.swift
//  WalmartTest
//
//  Created by Basagond Mugganavar on 25/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var explanation: UITextView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageView: LazyImageView!
    var alertVC: UIAlertController!

    var viewModel:ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadImage()
    }

    private func initialSetUp() {
        viewModel = ViewModel(with: PlanetaryRepository(with: PlanetaryService()))
        viewModel.delegate = self
    }

    func showLoader() {
        alertVC = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating();

        alertVC.view.addSubview(loadingIndicator)
        present(alertVC, animated: true, completion: nil)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            if self.alertVC != nil {
                self.alertVC.dismiss(animated: true)
            }
        }
    }
}


extension ViewController: ListServiveDelegates {
    func localImageLoaded() {
        DispatchQueue.main.async {
            self.titleLable.text = self.viewModel.title
            self.explanation.text = self.viewModel.explanation
            if let data = self.viewModel.imageData {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func serverDataSucces() {
        removeLoader()
        displayData()
    }
    
    private func displayData() {
        DispatchQueue.main.async {
            self.titleLable.text = self.viewModel.title
            self.explanation.text = self.viewModel.explanation
            if let model = self.viewModel.dataModel {
                self.imageView?.loadImage(from: model)
            }
        }
    }
    
    func errorAccored(error: String) {
        removeLoader()
        print(error)
    }
}
