import GoogleMobileAds

extension PreviewCaptureViewController {
    
    // MARK: Google Ads Full View
    func setGadFullView() {
        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        #if DEBUG
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        #else
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-8093774413708674/2864844631")
        #endif
        
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("действие после рекламы")
        interstitial = createAndLoadInterstitial() // перезагрузка рекламного банера
        showControllerShare()
    }
}
