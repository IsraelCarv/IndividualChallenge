//
//  Api.swift
//  api
//
//  Created by Israel Carvalho on 18/10/22.
//

import Foundation
import UIKit

struct Peixe2 {
    let scientificName: String // cria a variavel name do tipo string
    let species: String // cria a variavel species do tipo string
    let habitat: String?
    let img: UIImage
    
}

struct Peixe: Decodable { // Torna a função decodavel
    let scientificName: String // cria a variavel name do tipo string
    let species: String // cria a variavel species do tipo string
    let habitat: String?
    let img: [Imagem]
    
    enum CodingKeys: String, CodingKey { // configura qual nome a chave do json vai ter no seu codigo
        case species = "Species Name" // "Species Name"é o nome na api
        case scientificName = "Scientific Name"
        case habitat = "Habitat"
        case img = "Image Gallery"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.species = try container.decode(String.self, forKey: .species)
        self.scientificName = try container.decode(String.self, forKey: .scientificName)
        self.habitat = try container.decodeIfPresent(String.self, forKey: .habitat)
        
        // MARK: TODO tratamento de erros em swift (Error handling Swift
        // Image Gallery = [ {}, {}, ... ]
        if let imgs = try? container.decodeIfPresent([Imagem].self, forKey: .img) {
            self.img = imgs
        } else
        // Image Gallery = {}
        if let singleImg = try? container.decodeIfPresent(Imagem.self, forKey: .img) {
            self.img = [ singleImg ]
            // Image Gallery = null
        } else {
            self.img = []
        }
    }
    
    struct Imagem: Decodable {
        let src: String
    }
    
}

class APIpeixe {
    
    public var peixesGlobal: [Peixe] = []
    
    func allfish(completion: @escaping ([Peixe]) -> Void) {
        let url = URL(string: "https://www.fishwatch.gov/api/species")! // GET
        
        let task = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in
                
                if let error = error {
                    print("Error", error)
                    return
                }
                
                do {
                    let peixes: [Peixe] = try JSONDecoder().decode([Peixe].self, from: data!)
                    
                    completion(peixes)
                    
                    print(peixes.count)
                    print(peixes[0])
                    self.peixesGlobal = peixes // passa a informação pra variavel local
                    
                    //                    for peixe in peixes {
                    //                        if let imagem = peixe.img.randomElement() {
                    //                            // baixar a url e transformar numa imagem
                    //                            let url = URL(string: imagem.src)!
                    //
                    //                            // fazer requisicao pra essa URL pra pegar o data da imagem
                    //
                    //                            // transformar o data em UIImage :D
                    //                        }
                    //     }
                    
                } catch {
                    print("🤡", error)
                }
            }
        )
        
        task.resume()
        
    }
    
}






        
        
