//U-N00B-or-Bot

import UIKit

protocol MoveNoteProtocol: AnyObject {
    func changeTableView(text: String, numberOfCell: Int)
}

class NoteDetailViewController: UIViewController {
    
    var note: Note?
    var isNewNote = false
    var notesList: [Note]?
    var currentIndex: Int?
    weak var delegate: MoveNoteProtocol?
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(endEdit(sender:)))
        view.addSubview(textView)
        
        if isNewNote {
            textView.text = "Новая заметка"
        } else {
            textView.text = note?.text
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTextView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNewNote {
            if textView.text.isEmpty || textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return
            }
            let currentNote = Note(text: textView.text)
            notesList?.insert(currentNote, at: 0)
            StorageManager.shared.saveNotes(list: notesList!)
        }
        else {
            if textView.text == note?.text {
                return
            } else {
                delegate?.changeTableView(text: textView.text, numberOfCell: currentIndex!)
                
            }
        }
    }
    
    @objc func endEdit(sender:Any?){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupTextView(){
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
}
