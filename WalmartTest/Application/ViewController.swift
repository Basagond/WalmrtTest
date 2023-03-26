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
    @IBOutlet weak var imageView: UIImageView!
    var alertVC: UIAlertController!

    var viewModel:ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoader()
        viewModel.loadImage()
    }

    private func initialSetUp() {
        viewModel = ViewModel(with: PlanetaryRepository(with: PlanetaryService()), fileManager: LocalFileManager())
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
    
    func localImageLoaded(error: String?) {
        removeLoader()
        DispatchQueue.main.async {
            if let err = error {
                self.errorLabel.isHidden = false
                self.errorLabel.text = err
            } else {
                self.errorLabel.isHidden = true
            }
            self.titleLable.text = self.viewModel.title
            self.explanation.text = self.viewModel.explanation
            if let data = self.viewModel.imageData {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func serverDataSucces() {
        displayData()
    }
    
    private func displayData() {
        DispatchQueue.main.async {
        self.titleLable.text = self.viewModel.title
        self.explanation.text = self.viewModel.explanation
        
        if let model = self.viewModel.dataModel,
            let url = URL(string: model.url),
            let imageData = try? Data(contentsOf: url) {
            model.localData = imageData
            self.viewModel.saveImageToLocal()
            if let image = UIImage(data: imageData) {
                    debugPrint("image downloaded from server...")
                    self.imageView.image = image
                }
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = "Image not available"
        }
        self.removeLoader()
        }
    }
    
    func errorAccored(error: String) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.errorLabel.text = error
            self.removeLoader()
        }
    }
}
