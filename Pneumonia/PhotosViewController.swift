//
//  SecondViewController.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 5/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import UIKit
import Photos

struct ScanResult {
    let confidence: Double
    let label: String
    let image: UIImage
}

class PhotosViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {

    private let pickerController = UIImagePickerController()

    private var images: [ScanResult] = []
    private let model = p_neumonia1()

    private var needsAddBlurEffect = true

    override func loadView() {
        super.loadView()

        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickImageAction))

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        navigationController?.navigationBar.setTransparent()


        let scan = ScanResult(
            confidence: 1.1,
            label: "Normal",
            image: #imageLiteral(resourceName: "bosque")
        )

//        self.images.insert(scan, at: 0)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if needsAddBlurEffect {
            let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: UIApplication.shared.statusBarFrame.height))
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = statusBarView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            statusBarView.addSubview(blurEffectView)
            view.addSubview(statusBarView)

            needsAddBlurEffect = false
        }
    }


    @objc private func pickImageAction() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        defer {
            picker.dismiss(animated: true, completion: nil)
        }

        guard let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            return
        }
        guard let buffer = image.toPixelBuffer() else {
            return
        }

        do {
            let prediction = try model.prediction(image: buffer)
            let probability = prediction.classLabelProbs[prediction.classLabel] ?? 0

            let scan = ScanResult(
                confidence: probability,
                label: prediction.classLabel,
                image: image
            )

            self.images.insert(scan, at: 0)
            self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        } catch {
            print("Error", error)
        }

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeue(cell: ScanResultCollectionViewCell.self, for: indexPath)!
        cell.scan = images[indexPath.row]
        return cell
    }


}

