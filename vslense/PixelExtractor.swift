//
//  PixelExtractor.swift
//  vslense
//
//  Created by Huy Nguyen on 2/4/16.
//  Copyright © 2016 Huy Nguyen. All rights reserved.
//

import Foundation
import UIKit


class PixelExtractor {
    // taken from http://stackoverflow.com/questions/24049313/
    // and adapted to swift 1.2
    
    let image: CGImage
    let context: CGContextRef
    
    var width: Int {
        get {
            return CGImageGetWidth(image)
        }
    }
    
    var height: Int {
        get {
            return CGImageGetHeight(image)
        }
    }
    
    init(img: CGImage) {
        image = img
        context = PixelExtractor.create_bitmap_context(img)
    }
    
    private class func create_bitmap_context(img: CGImage)->CGContextRef {
        
        // Get image width, height
        let pixelsWide = CGImageGetWidth(img)
        let pixelsHigh = CGImageGetHeight(img)
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        let bitmapBytesPerRow = pixelsWide * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8,
                                            bitmapBytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        CGContextDrawImage(context, rect, img)
        
        return context!
    }
    
    func color_at(x x: Int, y: Int)->UIColor {
        
        assert(0<=x && x<width)
        assert(0<=y && y<height)
        
        let uncasted_data = CGBitmapContextGetData(context)
        let data = UnsafePointer<UInt8>(uncasted_data)
        
        let offset = 4 * (y * width + x)
        
        let alpha = data[offset]
        let red = data[offset+1]
        let green = data[offset+2]
        let blue = data[offset+3]
        
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
        
        return color
    }
}