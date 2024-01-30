final class NoteEditModuleConfigurator {
    func configure(with note: Note, output: NoteEditModuleOutput) -> NoteEditViewController {
        let presenter = NoteEditPresenter()
        let view = NoteEditViewController()
        let router = NoteEditRouter()
        
        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        
        view.output = presenter
        
        presenter.configureModule(with: note)
        
        return view
    }
}
