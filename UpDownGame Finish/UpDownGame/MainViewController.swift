//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class MainViewController: UIViewController {
    var updownGame = UpDownGame()
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    @IBOutlet weak var hitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal)
        resetGame()
    }
    
    @IBAction func slideValueChanged(_ sender: UISlider) {
        let integerValue = Int(sender.value)
        sliderValueLabel.text = String(integerValue)
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        let hitValue = Int(slider.value)
        slider.value = Float(hitValue)
        
        updownGame.tryCount += 1
        tryCountLabel.text = "\(updownGame.tryCount) / 5"
        
        switch updownGame.compareValue(with: hitValue) {
        case .Win:
            showAlert(message: "YOU WIN!")
        case .Lose:
            showAlert(message: "YOU LOSE..")
        case .Up:
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        case .Down:
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        resetGame()
    }
    
    func resetGame() {
        hitButton.isEnabled = false
        
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
        tryCountLabel.text = "0 / 5"
  
        updownGame.reset {
            DispatchQueue.main.async {
                self.hitButton.isEnabled = true
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.resetGame()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
