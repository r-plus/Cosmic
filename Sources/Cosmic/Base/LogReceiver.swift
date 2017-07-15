//
//  LogReceiver.swift
//  cosmic
//
//  Created by Jack Newcombe on 27/03/2017.
//  Copyright © 2017 Jack Newcombe. All rights reserved.
//

import Foundation


/// LogReceiver describes the internal implementation of a Logger object.
///
/// Implementors consume log output, performing transformations on the
/// received messages as needed, and forwarding them to other loggers
/// and reporting services.
///
internal protocol LogReceiver: Logger {
    
    // MARK: Log message receivers
    
    func onReceive(_ message: String, logLevel: LogLevel)
    
}

extension LogReceiver {
    
    
    /// Returns true if this logger is currently being filtered.
    ///
    /// See LogReporter for more details.
    private var isFiltered: Bool {
        return FilterCache.reduce(false) { $0 || $1.isFiltered(logger: self) }
    }
    
    /// Returns true if the log level is equal to or more constraining
    /// than the argument, and the logger is not being filtered
    ///
    /// - Parameter expected: The log level to test
    /// - Returns: A boolean value indicating whether the log level is enabled
    private func enabled(_ expected: LogLevel) -> Bool {
        return (expected.rawValue >= logLevel.rawValue) && !self.isFiltered
    }
    
    
    /// Logs a series of debug messages
    ///
    /// Debug log messages should be aimed at developers and can contain
    /// domain-specific and diagnostic information.
    ///
    /// - Parameter messages: The messages to log
    public func debug(_ message: String) {
        guard enabled(.debug) else { return }
        onReceive(message, logLevel: .debug)
    }
    
    
    /// Logs a series of info messages
    ///
    /// Info log messages should contain high-level information about
    /// application state such as indicating a service starting or 
    /// stopping. 
    ///
    /// Info logs should describe all high-level interactions.
    ///
    /// - Parameter messages: The info messages to log
    public func log(_ message: String) {
        guard enabled(.info) else { return }
        onReceive(message, logLevel: .info)
    }
    
    /// Logs a series of warning messages
    ///
    /// Warning log messages should indicate any non-fatal issues that
    /// occur such as the absence of configuration or validation errors
    ///
    /// - Parameter messages: The warning messages to log
    public func warn(_ message: String) {
        guard enabled(.warn) else { return }
        onReceive(message, logLevel: .warn)
    }
    
    /// Logs a series of error messages
    ///
    /// Error log messages should contain information about any fatal
    /// errors, i.e. errors that halt the execution of the application
    /// whether by runtime exception or blocking further interaction.
    ///
    /// Error logs should generally indicate that a programming error
    /// has occurred (for example, by reaching illegal if/else branches)
    ///
    /// - Parameter messages: The error messages to log
    public func error(_ message: String) {
        guard enabled(.error) else { return }
        onReceive(message, logLevel: .error)
    }
    
    public func format(message: String) -> String {
        return formatters.reduce(message, { $1.format(message: $0) })
    }
}
