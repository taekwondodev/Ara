//
//  TitleView.swift
//  Deaf
//
//  Created by Davide Galdiero on 29/05/24.
//

import SwiftUI

struct TitleView: View {
    @Binding var audioTitle: String
    @FocusState private var focus: FormFieldFocus?
    
    var body: some View {
        Form{
            TextField("Enter Title", text: $audioTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focus, equals: .title)
                .onSubmit {
                    focus = .category
                }
            
            TextField("Enter Category", text: $audioTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focus, equals: .category)
        }
        .onAppear(perform: {
            focus = .title
        })
    }
    
    enum FormFieldFocus: Hashable{
        case title, category
    }
}
