import Foundation

class LocalEventStorage {
    private let key = "savedEvents"
    
    func save(event: ModelLocalEvent) {
        var events = loadEvents()
        events.append(event)
        
        do {
            let data = try JSONEncoder().encode(events)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Encoding failed")
        }
    }
    
    func loadEvents() -> [ModelLocalEvent] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            let events = try JSONDecoder().decode([ModelLocalEvent].self, from: data)
            return events
        } catch {
            return []
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
