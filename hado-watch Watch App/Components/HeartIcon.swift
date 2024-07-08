//
//  HeartIcon.swift
//  hado-watch Watch App
//
//  Created by song on 2024/7/8.
//

import SwiftUI

struct HeartIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
 
        path.move(to: CGPoint(x: 0.49616*width, y: 0.89542*height))
        path.addCurve(to: CGPoint(x: 0.48666*width, y: 0.8901*height), control1: CGPoint(x: 0.49477*width, y: 0.89542*height), control2: CGPoint(x: 0.4916*width, y: 0.89365*height))
        path.addCurve(to: CGPoint(x: 0.33791*width, y: 0.769*height), control1: CGPoint(x: 0.43473*width, y: 0.85308*height), control2: CGPoint(x: 0.38515*width, y: 0.81271*height))
        path.addCurve(to: CGPoint(x: 0.21169*width, y: 0.63198*height), control1: CGPoint(x: 0.29067*width, y: 0.72529*height), control2: CGPoint(x: 0.2486*width, y: 0.67961*height))
        path.addCurve(to: CGPoint(x: 0.12417*width, y: 0.48678*height), control1: CGPoint(x: 0.17478*width, y: 0.58434*height), control2: CGPoint(x: 0.14561*width, y: 0.53594*height))
        path.addCurve(to: CGPoint(x: 0.09202*width, y: 0.3411*height), control1: CGPoint(x: 0.10274*width, y: 0.43762*height), control2: CGPoint(x: 0.09202*width, y: 0.38906*height))
        path.addCurve(to: CGPoint(x: 0.11764*width, y: 0.22099*height), control1: CGPoint(x: 0.09202*width, y: 0.29531*height), control2: CGPoint(x: 0.10056*width, y: 0.25527*height))
        path.addCurve(to: CGPoint(x: 0.18729*width, y: 0.14084*height), control1: CGPoint(x: 0.13472*width, y: 0.18672*height), control2: CGPoint(x: 0.15793*width, y: 0.16*height))
        path.addCurve(to: CGPoint(x: 0.28757*width, y: 0.1121*height), control1: CGPoint(x: 0.21665*width, y: 0.12168*height), control2: CGPoint(x: 0.25008*width, y: 0.1121*height))
        path.addCurve(to: CGPoint(x: 0.36607*width, y: 0.12915*height), control1: CGPoint(x: 0.31787*width, y: 0.1121*height), control2: CGPoint(x: 0.34403*width, y: 0.11778*height))
        path.addCurve(to: CGPoint(x: 0.42233*width, y: 0.17195*height), control1: CGPoint(x: 0.38811*width, y: 0.14052*height), control2: CGPoint(x: 0.40686*width, y: 0.15478*height))
        path.addCurve(to: CGPoint(x: 0.46149*width, y: 0.22335*height), control1: CGPoint(x: 0.43779*width, y: 0.18912*height), control2: CGPoint(x: 0.45085*width, y: 0.20626*height))
        path.addCurve(to: CGPoint(x: 0.47917*width, y: 0.24549*height), control1: CGPoint(x: 0.46816*width, y: 0.2342*height), control2: CGPoint(x: 0.47405*width, y: 0.24158*height))
        path.addCurve(to: CGPoint(x: 0.49616*width, y: 0.25135*height), control1: CGPoint(x: 0.48429*width, y: 0.2494*height), control2: CGPoint(x: 0.48995*width, y: 0.25135*height))
        path.addCurve(to: CGPoint(x: 0.5129*width, y: 0.24524*height), control1: CGPoint(x: 0.5024*width, y: 0.25135*height), control2: CGPoint(x: 0.50798*width, y: 0.24931*height))
        path.addCurve(to: CGPoint(x: 0.53079*width, y: 0.22335*height), control1: CGPoint(x: 0.51781*width, y: 0.24116*height), control2: CGPoint(x: 0.52377*width, y: 0.23387*height))
        path.addCurve(to: CGPoint(x: 0.57099*width, y: 0.1724*height), control1: CGPoint(x: 0.54212*width, y: 0.20656*height), control2: CGPoint(x: 0.55552*width, y: 0.18958*height))
        path.addCurve(to: CGPoint(x: 0.62677*width, y: 0.12937*height), control1: CGPoint(x: 0.58645*width, y: 0.15523*height), control2: CGPoint(x: 0.60504*width, y: 0.14089*height))
        path.addCurve(to: CGPoint(x: 0.70475*width, y: 0.1121*height), control1: CGPoint(x: 0.6485*width, y: 0.11786*height), control2: CGPoint(x: 0.67449*width, y: 0.1121*height))
        path.addCurve(to: CGPoint(x: 0.8053*width, y: 0.14084*height), control1: CGPoint(x: 0.74225*width, y: 0.1121*height), control2: CGPoint(x: 0.77576*width, y: 0.12168*height))
        path.addCurve(to: CGPoint(x: 0.87497*width, y: 0.22099*height), control1: CGPoint(x: 0.83483*width, y: 0.16*height), control2: CGPoint(x: 0.85805*width, y: 0.18672*height))
        path.addCurve(to: CGPoint(x: 0.90035*width, y: 0.3411*height), control1: CGPoint(x: 0.89189*width, y: 0.25527*height), control2: CGPoint(x: 0.90035*width, y: 0.29531*height))
        path.addCurve(to: CGPoint(x: 0.8682*width, y: 0.48678*height), control1: CGPoint(x: 0.90035*width, y: 0.38906*height), control2: CGPoint(x: 0.88964*width, y: 0.43762*height))
        path.addCurve(to: CGPoint(x: 0.78066*width, y: 0.63198*height), control1: CGPoint(x: 0.84676*width, y: 0.53594*height), control2: CGPoint(x: 0.81758*width, y: 0.58434*height))
        path.addCurve(to: CGPoint(x: 0.65442*width, y: 0.769*height), control1: CGPoint(x: 0.74374*width, y: 0.67961*height), control2: CGPoint(x: 0.70165*width, y: 0.72529*height))
        path.addCurve(to: CGPoint(x: 0.50567*width, y: 0.8901*height), control1: CGPoint(x: 0.60718*width, y: 0.81271*height), control2: CGPoint(x: 0.55759*width, y: 0.85308*height))
        path.addCurve(to: CGPoint(x: 0.49616*width, y: 0.89542*height), control1: CGPoint(x: 0.50072*width, y: 0.89365*height), control2: CGPoint(x: 0.49755*width, y: 0.89542*height))
        path.closeSubpath()
        return path
    }
}


#Preview {
    HeartIcon()
}
