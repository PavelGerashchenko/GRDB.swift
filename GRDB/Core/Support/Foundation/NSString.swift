import Foundation

/// NSString adopts DatabaseValueConvertible
extension NSString : DatabaseValueConvertible {
    
    /// Returns a value that can be stored in the database.
    public var databaseValue: DatabaseValue {
        #if os(Linux)
            return String._unconditionallyBridgeFromObjectiveC(self).databaseValue
        #else
            return (self as String).databaseValue
        #endif
    }
    
    /// Returns an NSString initialized from *dbValue*, if possible.
    public static func fromDatabaseValue(_ dbValue: DatabaseValue) -> Self? {
        guard let string = String.fromDatabaseValue(dbValue) else {
            return nil
        }
        return self.init(string: string)
    }
}
