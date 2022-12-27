//U-N00B-or-Bot

import UIKit



class MainViewController: UIViewController{
    
    var notesList = [Note]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let plusBtn = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(createNewNote(sender:)))
        navigationItem.rightBarButtonItem = plusBtn
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Заметки"
        
        fetchNotesList()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesList = StorageManager.shared.fetchNotes()
        tableView.reloadData()
    }
    
    @objc func createNewNote(sender: Any?){
        let noteVC = NoteDetailViewController()
        noteVC.isNewNote = true
        noteVC.notesList = notesList
        show(noteVC, sender: self)
    }
    
    private func setupTableView(){
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    private func fetchNotesList(){
        if  StorageManager.shared.checkNotFirstLaunch(){
            notesList = StorageManager.shared.fetchNotes()
        }
        else {
            StorageManager.shared.setValueForLaunchChecker()
            StorageManager.shared.firstLaunchPrepare()
            notesList = StorageManager.shared.fetchNotes()
        }
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let note = notesList[indexPath.row]
        cell.configure(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.delegate = self
        noteDetailVC.note = notesList[indexPath.row]
        noteDetailVC.currentIndex = indexPath.row
        show(noteDetailVC, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { _, indexPath in
            self.notesList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.saveNotes(list: self.notesList)
        }
        return [deleteAction]
    }
    
}

extension MainViewController: MoveNoteProtocol{
    func changeTableView(text: String, numberOfCell: Int) {
        notesList.remove(at: numberOfCell)
        let note = Note(text: text)
        notesList.insert(note, at: 0)
        StorageManager.shared.saveNotes(list: notesList)
        tableView.reloadData()
    }
}
