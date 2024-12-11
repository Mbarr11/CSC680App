//
//  ContentView.swift
//  AstronomyApp
//
//  Created by Marco B on 10/25/24.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                MarsRoverView()
                    .tabItem {
                        Label("Mars Rover", systemImage: "photo")
                    }
                
            NEOListView()
                .tabItem {
                    Label("NEOs", systemImage: "list.bullet")
                }
        }
    }
}


struct NEOListView: View {
    @State
    private var neoElements: [NeoElement] = [] // State variable to hold the fetched NEO //data

    var body: some View {
        NavigationView {
            List(neoElements, id: \.id) { neo in
                VStack(alignment: .leading) {
                    Text(neo.name)
                        .font(.headline)
                    Text("Hazardous: \(neo.is_potentially_hazardous_asteroid ? "Yes" : "No")")
                        .font(.subheadline)
                        .foregroundColor(neo.is_potentially_hazardous_asteroid ? .red : .green)
                    Text("Magnitude: \(neo.absolute_magnitude_h)")
                        .font(.subheadline)
                }
                .padding(.vertical, 5)
            }
            .navigationBarTitle("Near-Earth Objects", displayMode: .inline)
        }
        .onAppear {
            let service = NasaService()
            service.fetchNEOS { lines in
                DispatchQueue.main.async {
                    self.neoElements = lines // Update the list on the main thread
                }
            }
        }
    }
}


struct MarsRoverView: View {
    @State
    private var photo: Photo? = nil

    var body: some View {
        VStack {
            if let photo = photo {
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: photo.img_src)) { loadingState in
                        switch loadingState {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        case .failure:
                            Text("Image did not load")
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxHeight: 700)

                    Text("ID: \(photo.id)")
                    Text("Earth Date: \(photo.earth_date)")
                    Text("Camera: \(photo.camera.full_name)")
                    Text("Rover: \(photo.rover.name)")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .onAppear {
            let service = NasaService()
            service.fetchMarsRover { marsLines in
                DispatchQueue.main.async {
                    self.photo = marsLines
                }
            }
        }
    }
}





