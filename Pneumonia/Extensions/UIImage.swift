//
//  UIImage.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 13/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import UIKit

extension UIImage {

    func toPixelBuffer() -> CVPixelBuffer? {
        guard let image = self.cgImage else { return nil }

        let frameSize = CGSize(width: image.width, height: image.height)

        var pixelBuffer: CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(frameSize.width),
                                         Int(frameSize.height),
                                         kCVPixelFormatType_32BGRA, nil, &pixelBuffer)

        if status != kCVReturnSuccess { return nil }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)


        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))

        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }
}
