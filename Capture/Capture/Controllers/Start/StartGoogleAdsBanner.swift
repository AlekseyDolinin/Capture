import GoogleMobileAds

extension StartViewController {

    func setGadBanner() {

        if let banner = bannerView {
            banner.removeFromSuperview()
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-8093774413708674/9242550722"
        #endif

        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        bannerView.transform = CGAffineTransform(translationX: 0, y: 55)
        self.view.addSubview(bannerView)

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        bannerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        showBannerView()
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        bannerView.isHidden = true
    }

    func hideBannerView() {
        print("hideAds")
        UIView.animate(withDuration: 0.2) {
            self.bannerView.transform = CGAffineTransform(translationX: 0, y: 55)
        }
    }

    func showBannerView() {
        UIView.animate(withDuration: 0.2) {
            self.bannerView.transform = .identity
        }
    }
}
