import UIKit

struct Section {
    let header: String
    let rows: [Row]
}

struct Row {
    let title: String
    let container: UINavigationController.Type
}

class ContainerController: UITableViewController {

    let sections: [Section] = [
        Section(header: "Plain", rows: [
            Row(title: "UINavigationController", container: UINavigationController.self)
            ]),
        Section(header: "Themed", rows: [
            Row(title: "DarkNavigationController", container: DarkNavigationController.self),
            Row(title: "MixedNavigationController", container: MixedNavigationController.self)
            ])
    ]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = sections[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = row.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]

        let rootViewController = ViewController.instantiate(identifier: "One")

        let navigationController: UINavigationController = row.container.init()
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: navigationController, action: #selector(UINavigationController.dismissModal))
        navigationController.viewControllers = [rootViewController]

        present(navigationController, animated: true) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
