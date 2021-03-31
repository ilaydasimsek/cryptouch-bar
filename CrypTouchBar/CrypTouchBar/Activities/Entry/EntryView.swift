//
//  EntryView.swift
//  CrypTouchBar
//
//  Created by İlayda Şimşek on 31.03.2021.
//

import SwiftUI

struct EntryView: View {
    @ObservedObject var viewModel: EntryViewModel
    
    var body: some View {
        Text(viewModel.title)
        Text(viewModel.subtitle)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(viewModel: EntryViewModel())
    }
}
