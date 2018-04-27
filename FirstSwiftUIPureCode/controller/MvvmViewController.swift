import UIKit

class MvvmViewController: UIViewController {

    private lazy var mvvmViewModel : MvvmViewModel = {
        let model = MvvmViewModel()
        return model
    }()

    private lazy var mvvmView : MvvmView = {
        let view = MvvmView(viewModel: self.mvvmViewModel)
        view.frame = UIScreen.main.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout=[]

        // Do any additional setup after loading the view.
        self.view.addSubview(mvvmView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
