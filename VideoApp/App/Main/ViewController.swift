import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://nl201.cdnsqu.com/s/FHC3c2sQbpDxIzDCao1pFfqUFBQUFBQUFBQUFBUlE4TUJCZm9BRlV6UjFqRT0.ewj4Guz-4g6GSZw9zzCvaOUtiAbyO_aI-k6Iyg/hd_060/Last.Man.Standing.1995.DVO.BDRip.1080p_480.mp4") else {
            return
        }
        
        let controller = VideoController(url)
        controller.modalPresentationStyle = .overFullScreen
        
        navigationController?.present(controller, animated: true)
    }
}
