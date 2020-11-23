//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// View model for the home view
final class HomeViewModel {
    
    // MARK: - Properties
    var currentLocation: String? {
        didSet {
            _ = oldValue
            //as soon as we get the location we're then going to search for the
            //user current location wind speed and temp
            weatherResultsManager.search(endpoint: .weather(currentLocation ?? ""))
        }
    }
    var favouriteLocations = [WeatherRequest]() {
        didSet {
            homeViewTableViewDataSource.favouriteLocations = favouriteLocations.map({ $0.convertToCellData() })
            //update the second section
            updateFavouriteSection()
        }
    }
    var homeViewTableView: UITableView?
    var homeViewTableViewDataSource: HomeViewTableViewDataSource
    private var weatherResultsManager: WeatherResultsManager<WeatherRequest>
    
    // MARK: - Lifecycle methods
    init(homeViewTableViewDataSource: HomeViewTableViewDataSource = HomeViewTableViewDataSource(),
         resultsManager: WeatherResultsManager<WeatherRequest> = WeatherResultsManager<WeatherRequest>()
         ) {
        self.homeViewTableViewDataSource = homeViewTableViewDataSource
        self.weatherResultsManager = resultsManager
    }
    
    func setUp() {
        setUpResultsHandler()
    }
    
    /// Handles the setup of the weather results data handler
    private func setUpResultsHandler() {
        weatherResultsManager.resultsHandler = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                //show the results in a modal
                print(response)
                let cellIndex = IndexPath(row: 0, section: 0)
                DispatchQueue.main.async {
                    self.homeViewTableViewDataSource.currentCellData = response.convertToCellData()
                    self.homeViewTableView?.reloadRows(at: [cellIndex], with: .fade)
                }
                case .failure(let error):
                //TODO: Handle error response
                print(error)
            }
        }
    }
    
    /// Will reload the favourites section of the tableview
    private func updateFavouriteSection() {
        homeViewTableViewDataSource.favouriteLocations = favouriteLocations.map({ $0.convertToCellData()
        })
        let favouriteSection = IndexSet(integer: 1)
        DispatchQueue.main.async {
            self.homeViewTableView?.reloadSections(favouriteSection, with: .fade)
        }
    }
    
    
    /// Initiate a search for weather results
    /// - Parameter city: city to search results for
    func search(for city: String) {
        weatherResultsManager.search(endpoint: .weather(city))
    }
    
}


/// The table view data source for the apps home view table view.
class HomeViewTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK:  Properties
    var notifications: NotificationCenter
    var currentCellData: WeatherCellInfo?
    var favouriteLocations = [WeatherCellInfo]()
    private var locationCellIdentifier = Constants.TableViewIdentifiers.locationCell.id
    private var notSearchedCellIdentifier = Constants.TableViewIdentifiers.notSearchedCell.id
    
    init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notifications = notificationCenter
    }
    
    // MARK: - Table view data souce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return favouriteLocations.isEmpty ? 1 : favouriteLocations.count
        default:
            fatalError("There should only be two sections maximum")
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            return favouriteLocations.isEmpty ? 180 : 120
        default:
            return tableView.estimatedRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier) as? LocationTableViewCell else {
                fatalError("we should have a cell registered")
            }
            cell.backgroundImageView.image = #imageLiteral(resourceName: "mountainImage")
            cell.locationTitleLabel.text = currentCellData?.location
            cell.countryLabel.text = currentCellData?.country
            cell.tempDegreesLabel.text = "\(currentCellData?.temp ?? 0) °C"
            cell.windSpeedLabel.text = "\(currentCellData?.windSpeed ?? 0) mph"
            cell.windDirectionImage.getWindDirectionImage(from: currentCellData?.windDirection ?? 0)
            return cell
            
        case 1:
            if favouriteLocations.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: notSearchedCellIdentifier) else {
                    return UITableViewCell()
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier) as? LocationTableViewCell else {
                    fatalError("we should have a cell registered")
                }
                cell.backgroundImageView.image = #imageLiteral(resourceName: "cityImage")
                cell.locationTitleLabel.text = favouriteLocations[indexPath.row].location
                cell.countryLabel.text = favouriteLocations[indexPath.row].country
                cell.tempDegreesLabel.text = "\(favouriteLocations[indexPath.row].temp) °C"
                cell.windSpeedLabel.text = "\(favouriteLocations[indexPath.row].windSpeed) mph"
                cell.windDirectionImage.getWindDirectionImage(from: favouriteLocations[indexPath.row].windDirection)
                return cell
            }
        default:
            fatalError("There should only be two sections maximum")
        }
    }
    
    // MARK: - Table view delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewSectionHeader.reuseIdentifier) as? HomeTableViewSectionHeader else {
            fatalError("there should be a section header registered for use here")
        }
        switch section {
        case 0:
            sectionHeader.sectionHeaderLabel.text = "Current location"
            let locationImage = UIImage(systemName: "location")
            sectionHeader.sectionImageView.image = locationImage
            
        case 1:
            sectionHeader.sectionHeaderLabel.text = "Favourite locations"
            sectionHeader.sectionImageView.image = UIImage(systemName: "star")
        default:
            break
        }
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            notifications.post(.init(name: .selectedFavouriteDetailsCell,
                                     object: nil,
                                     userInfo: [Constants.NotificationDictKeys.selectedCell.id : indexPath]))

        }
    }
    
    
}
