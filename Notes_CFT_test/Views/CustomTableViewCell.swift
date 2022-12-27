//U-N00B-or-Bot

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "customCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(note: Note){
        var content = self.defaultContentConfiguration()
        var name = note.text
        if note.text!.count > 20 {
            let drop = note.text!.count - 20
            name = String(note.text!.dropLast(drop)) + "..."
        }
        content.text = name
        self.contentConfiguration = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
