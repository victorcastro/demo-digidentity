import SwiftUI

struct CatalogDetailView: View {
    @StateObject private var viewModel: CatalogDetailViewModel

    init(viewModel: CatalogDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                CatalogImageView(
                    url: viewModel.state.item.imageURL,
                    size: 220
                )
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 14) {
                    Text(viewModel.state.item.text)
                        .font(.title2.weight(.semibold))

                    LabeledContent("ID", value: viewModel.state.item.id)
                    LabeledContent(
                        "Confidence",
                        value: viewModel.state.item.confidence.formatted(.number.precision(.fractionLength(2)))
                    )
                }
                .textSelection(.enabled)
            }
            .padding()
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Item Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
