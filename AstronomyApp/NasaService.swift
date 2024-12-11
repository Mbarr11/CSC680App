
import Foundation

struct NasaService {
    
    func fetchNEOS(onLinesReturned callback: @escaping ([NeoElement]) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=2024-11-27&api_key=mjNsZcG3tUR2n28FKI1YFvXgvytFInCdVsElLGA0") else {
            print("Url invalid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data error")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(NasaFeedResponse.self, from: data)
                let neos = response.near_earth_objects.flatMap { $0.value }
                callback(neos)
            } catch {
                print("NEO decoding error")
            }
        }.resume()
    }
    
    func fetchMarsRover(onLinesReturned callback: @escaping (Photo?) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=mast&api_key=mjNsZcG3tUR2n28FKI1YFvXgvytFInCdVsElLGA0")
            else {
            print("Url invalid")
                return
            }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data error")
                return
            }
            let decoder = JSONDecoder()
            
            do{
                let marsRoverElement = try decoder.decode(MarsRoverElement.self, from: data)
                let randomPhoto = marsRoverElement.photos.randomElement()
                callback(randomPhoto)
            }catch{
                print(error)
            }
        }.resume()
    }
}

