// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: MotionData.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct MotionData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var roll: Double = 0

  var pitch: Double = 0

  var yaw: Double = 0

  var accX: Double = 0

  var accY: Double = 0

  var accZ: Double = 0

  var armDirection: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension MotionData: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension MotionData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "MotionData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "roll"),
    2: .same(proto: "pitch"),
    3: .same(proto: "yaw"),
    4: .same(proto: "accX"),
    5: .same(proto: "accY"),
    6: .same(proto: "accZ"),
    7: .same(proto: "armDirection"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularDoubleField(value: &self.roll) }()
      case 2: try { try decoder.decodeSingularDoubleField(value: &self.pitch) }()
      case 3: try { try decoder.decodeSingularDoubleField(value: &self.yaw) }()
      case 4: try { try decoder.decodeSingularDoubleField(value: &self.accX) }()
      case 5: try { try decoder.decodeSingularDoubleField(value: &self.accY) }()
      case 6: try { try decoder.decodeSingularDoubleField(value: &self.accZ) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.armDirection) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.roll != 0 {
      try visitor.visitSingularDoubleField(value: self.roll, fieldNumber: 1)
    }
    if self.pitch != 0 {
      try visitor.visitSingularDoubleField(value: self.pitch, fieldNumber: 2)
    }
    if self.yaw != 0 {
      try visitor.visitSingularDoubleField(value: self.yaw, fieldNumber: 3)
    }
    if self.accX != 0 {
      try visitor.visitSingularDoubleField(value: self.accX, fieldNumber: 4)
    }
    if self.accY != 0 {
      try visitor.visitSingularDoubleField(value: self.accY, fieldNumber: 5)
    }
    if self.accZ != 0 {
      try visitor.visitSingularDoubleField(value: self.accZ, fieldNumber: 6)
    }
    if !self.armDirection.isEmpty {
      try visitor.visitSingularStringField(value: self.armDirection, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MotionData, rhs: MotionData) -> Bool {
    if lhs.roll != rhs.roll {return false}
    if lhs.pitch != rhs.pitch {return false}
    if lhs.yaw != rhs.yaw {return false}
    if lhs.accX != rhs.accX {return false}
    if lhs.accY != rhs.accY {return false}
    if lhs.accZ != rhs.accZ {return false}
    if lhs.armDirection != rhs.armDirection {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
