//
//  GetRatingUseCase.swift
//  Application
//
//  Created by Gustavo Araujo Santos on 20/05/22.
//

import Infrastructure
import Domain

public protocol GetRatingUseCaseProtocol {
    func execute(breweryId: String) -> Result<Rating, Error>
}

public class GetRatingUseCase: GetRatingUseCaseProtocol {

    private let database: DatabaseProtocol

    // MARK: - Initialization

    public init(database: DatabaseProtocol = CoreDataBase.shared) {
        self.database = database
    }

    // MARK: - Public methods

    public func execute(breweryId: String) -> Result<Rating, Error> {
        let result = database.getSpecificRatingByBreweryId(id: breweryId)

        switch result {
        case .success(let rating):
            return . success(rating)
        case .failure(let error):
            if error as? DatabaseError == DatabaseError.notContainRating {
                return .failure(ProjectError.handleGetRatingError)
            }
            return .failure(error)
        }
    }
}
