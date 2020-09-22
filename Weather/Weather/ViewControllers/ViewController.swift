import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchCountryTextField: UITextField!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var myLocationButton: UIButton!
    @IBOutlet weak var temperatureNowLabel: UILabel!
    
    @IBOutlet weak var firstDayWeatherLabel: UILabel!
    @IBOutlet weak var secondDayWeatherLabel: UILabel!
    @IBOutlet weak var thirdDayWeatherLabel: UILabel!
    @IBOutlet weak var fourthDayWeatherLabel: UILabel!
    @IBOutlet weak var fifthDayWeatherLabel: UILabel!
    
    @IBOutlet weak var firstDayTempLabel: UILabel!
    @IBOutlet weak var secondDayTempLabel: UILabel!
    @IBOutlet weak var thirdDayTempLabel: UILabel!
    @IBOutlet weak var fourthDayTempLabel: UILabel!
    @IBOutlet weak var fifthDayTempLabel: UILabel!
    
    @IBOutlet weak var firstDayCloudsLabel: UILabel!
    @IBOutlet weak var secondDayCloudsLabel: UILabel!
    @IBOutlet weak var thirdDayCloudsLabel: UILabel!
    @IBOutlet weak var fourthDayCloudsLabel: UILabel!
    @IBOutlet weak var fifthDayCloudsLabel: UILabel!
    
    @IBOutlet weak var firstDayWindLabel: UILabel!
    @IBOutlet weak var secondDayWindLabel: UILabel!
    @IBOutlet weak var thirdDayWindLabel: UILabel!
    @IBOutlet weak var fourthDayWindLabel: UILabel!
    @IBOutlet weak var fifthDayWindLabel: UILabel!
    
    @IBOutlet weak var firstDayHumLabel: UILabel!
    @IBOutlet weak var secondDayHumLabel: UILabel!
    @IBOutlet weak var thirdDayHumLabel: UILabel!
    @IBOutlet weak var fourthDayHumLabel: UILabel!
    @IBOutlet weak var fifthDayHumLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    private var locationManager: CLLocationManager?
    
    private let kelvin = 273.15
    private let cellID = "cellID"
    private let height: CGFloat = 60
    private let dayInWeight = 5
    
    var dataIsReady: Bool = false
    var weather: weatherCodable! {
        didSet {
            self.weatherTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCountryTextField.delegate = self
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestLocation()
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    @IBAction func myLocationButtonClick(_ sender: Any) {
        locationManager?.requestLocation()
        fatalError()
    }
}
//MARK: TextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let city = textField.text!
        NetworkManager.shared.getWeather(city: city) { (model) in
            if let model = model {
            DispatchQueue.main.async {
                if model != nil {
                    self.dataIsReady = true
                    self.weather = model
                    
                    self.cityLabel.text = model.city.name
                    self.temperatureNowLabel.text = String(Int(model.list[0].main.temp - self.kelvin)) + "C°"
                    
                    self.firstDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[8].dt)
                    self.secondDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[16].dt)
                    self.thirdDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[24].dt)
                    self.fourthDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[32].dt)
                    self.fifthDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[39].dt)
                    
                    self.firstDayTempLabel.text = String(Int(model.list[8].main.temp - self.kelvin)) + "C°"
                    self.secondDayTempLabel.text = String(Int(model.list[16].main.temp - self.kelvin)) + "C°"
                    self.thirdDayTempLabel.text = String(Int(model.list[24].main.temp - self.kelvin)) + "C°"
                    self.fourthDayTempLabel.text = String(Int(model.list[32].main.temp - self.kelvin)) + "C°"
                    self.fifthDayTempLabel.text = String(Int(model.list[39].main.temp - self.kelvin)) + "C°"
                    
                    self.firstDayCloudsLabel.text = String(model.list[8].clouds.all) + "%"
                    self.secondDayCloudsLabel.text = String(model.list[16].clouds.all) + "%"
                    self.thirdDayCloudsLabel.text = String(model.list[24].clouds.all) + "%"
                    self.fourthDayCloudsLabel.text = String(model.list[32].clouds.all) + "%"
                    self.fifthDayCloudsLabel.text = String(model.list[39].clouds.all) + "%"
                    
                    self.firstDayWindLabel.text = String(format: "%.1f", self.weather.list[8].wind.speed) + "m/s"
                    self.secondDayWindLabel.text = String(format: "%.1f", self.weather.list[16].wind.speed) + "m/s"
                    self.thirdDayWindLabel.text = String(format: "%.1f", self.weather.list[24].wind.speed) + "m/s"
                    self.fourthDayWindLabel.text = String(format: "%.1f", self.weather.list[32].wind.speed) + "m/s"
                    self.fifthDayWindLabel.text = String(format: "%.1f", self.weather.list[39].wind.speed) + "m/s"
                    
                    self.firstDayHumLabel.text = String(model.list[8].main.humidity) + "%"
                    self.secondDayHumLabel.text = String(model.list[16].main.humidity) + "%"
                    self.thirdDayHumLabel.text = String(model.list[24].main.humidity) + "%"
                    self.fourthDayHumLabel.text = String(model.list[32].main.humidity) + "%"
                    self.fifthDayHumLabel.text = String(model.list[39].main.humidity) + "%"
                }
                }
            }
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
//MARK: TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataIsReady {
            return (self.weather.list.count / dayInWeight)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: cellID) as! WeatherTableViewCell
        
        cell.timeLabel.text = formateCurrentTimeInterval(date: self.weather.list[indexPath.row].dt)
        cell.temperatureLabel.text = String(Int(self.weather.list[indexPath.row].main.temp - kelvin)) + "C°"
        cell.cloudsLabel.text = String(self.weather.list[indexPath.row].clouds.all) + "%"
        cell.windLabel.text = String(format: "%.1f", self.weather.list[indexPath.row].wind.speed) + "m/s"
        cell.humidityLabel.text = String(self.weather.list[indexPath.row].main.humidity) + "%"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
}
//MARK: LocationManager
extension ViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let recentLocation = locations.last
    guard let cordinates = recentLocation?.coordinate else { return }
    let lat = String(format: "%.8f", cordinates.latitude)
    let lon = String(format: "%.8f", cordinates.longitude)
    NetworkManager.shared.getWeatherInMyLocation(lat: lat, lon: lon) { (model) in
        if let model = model {
            DispatchQueue.main.async {
                if model != nil {
                    self.dataIsReady = true
                    self.weather = model
                    
                    self.cityLabel.text = model.city.name
                    self.temperatureNowLabel.text = String(Int(model.list[0].main.temp - self.kelvin)) + "C°"
                                   
                    self.firstDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[7].dt)
                    self.secondDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[16].dt)
                    self.thirdDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[24].dt)
                    self.fourthDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[32].dt)
                    self.fifthDayWeatherLabel.text = self.formateCurrentDate(date: self.weather.list[39].dt)
                                   
                    self.firstDayTempLabel.text = String(Int(model.list[8].main.temp - self.kelvin)) + "C°"
                    self.secondDayTempLabel.text = String(Int(model.list[16].main.temp - self.kelvin)) + "C°"
                    self.thirdDayTempLabel.text = String(Int(model.list[24].main.temp - self.kelvin)) + "C°"
                    self.fourthDayTempLabel.text = String(Int(model.list[32].main.temp - self.kelvin)) + "C°"
                    self.fifthDayTempLabel.text = String(Int(model.list[39].main.temp - self.kelvin)) + "C°"
                    
                    self.firstDayCloudsLabel.text = String(model.list[8].clouds.all) + "%"
                    self.secondDayCloudsLabel.text = String(model.list[16].clouds.all) + "%"
                    self.thirdDayCloudsLabel.text = String(model.list[24].clouds.all) + "%"
                    self.fourthDayCloudsLabel.text = String(model.list[32].clouds.all) + "%"
                    self.fifthDayCloudsLabel.text = String(model.list[39].clouds.all) + "%"
                    
                    self.firstDayWindLabel.text = String(format: "%.1f", self.weather.list[8].wind.speed) + "m/s"
                    self.secondDayWindLabel.text = String(format: "%.1f", self.weather.list[16].wind.speed) + "m/s"
                    self.thirdDayWindLabel.text = String(format: "%.1f", self.weather.list[24].wind.speed) + "m/s"
                    self.fourthDayWindLabel.text = String(format: "%.1f", self.weather.list[32].wind.speed) + "m/s"
                    self.fifthDayWindLabel.text = String(format: "%.1f", self.weather.list[39].wind.speed) + "m/s"
                    
                    self.firstDayHumLabel.text = String(model.list[8].main.humidity) + "%"
                    self.secondDayHumLabel.text = String(model.list[16].main.humidity) + "%"
                    self.thirdDayHumLabel.text = String(model.list[24].main.humidity) + "%"
                    self.fourthDayHumLabel.text = String(model.list[32].main.humidity) + "%"
                    self.fifthDayHumLabel.text = String(model.list[39].main.humidity) + "%"
                }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}
