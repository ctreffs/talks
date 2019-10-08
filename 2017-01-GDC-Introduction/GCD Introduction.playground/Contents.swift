import Dispatch
import UIKit
import PlaygroundSupport

//MARK:- resources
let t_swift: UIImage = #imageLiteral(resourceName: "swift.jpg")
let e_watson: UIImage = #imageLiteral(resourceName: "watson.jpg")
let gcd: UIImage = #imageLiteral(resourceName: "gcd.png")

//MARK:- extensions
public extension UIImage {
	/*func resize(to newSize: CGSize) -> UIImage {
	return self.resize(to: CGRect.init(origin: CGPoint.zero, size: newSize))
	}*/
	
	public func resize(to newRect: CGRect) -> UIImage {
		let newSize: CGSize = CGSize(width: newRect.size.width-newRect.origin.x, height: newRect.size.height-newRect.origin.y)
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
		self.draw(in: newRect)
		let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}
}
public func randomSleep(max seconds: UInt32) {
	let random: UInt32 = UInt32(arc4random_uniform(seconds))
	sleep(random)
}
public func currentQueueName() -> String {
	let name = __dispatch_queue_get_label(nil)
	return String(cString: name, encoding: .utf8) ?? "nil"
}
public func startMeasure() -> TimeInterval {
	let start = NSDate().timeIntervalSince1970
	print("\(currentQueueName()) started")
	return start
}
public func endMeasure(start: TimeInterval) {
	let end = NSDate().timeIntervalSince1970
	let res = end-start
	print("\(currentQueueName()) done after \(res)")
}

//MARK:- Demo - simple image resize

let image2: UIImage = e_watson
let image: UIImage = t_swift
let aspect: CGFloat = image.size.width/image.size.height
let newHeight: Int = 300

let newWidth: Int = Int(CGFloat(newHeight)*aspect)
let rect: CGRect = CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight)

PlaygroundPage.current.needsIndefiniteExecution = true



let queueTransform = DispatchQueue(label: "transform")
let queueNetwork = DispatchQueue(label: "network")
let queue = DispatchQueue(label: "standard")


/*
queueTransform.async {
	print("taylor")
	let smallImage = image2.resize(to: rect)
	DispatchQueue.main.async {
		// needs to be main thread - otherwise black
		
		print("show taylor")
		PlaygroundPage.current.liveView = UIImageView(image: smallImage)
	}
	
}*/












//MARK:- Demo - dispatch group
/*
let group = DispatchGroup.init()

print("before work")

queueTransform.async(group: group) {
	let start = startMeasure()
	
	randomSleep(max: 7)
	
	endMeasure(start: start)
}

queueNetwork.async(group: group) {
	let start = startMeasure()
	
	randomSleep(max: 7)
	
	endMeasure(start: start)
}


group.notify(queue: DispatchQueue.main) {
	//do stuff on the main thread, when everything has finished in the dispatch group
	print("YEAH done - show on main thread")
}

*/











//MARK: - Demo - QoS

var background: Int = 0
var unspecified: Int = 0
var userInitiated: Int = 0
var userInteractive: Int = 0
var utility: Int = 0


let qBackground: DispatchQueue = DispatchQueue(label: "background", qos: .background)
let qUnspecified: DispatchQueue = DispatchQueue(label: "unspecified", qos: .unspecified)
let qUserInitiated: DispatchQueue = DispatchQueue(label: "userInitiated", qos: .userInitiated)
let qUserInteractive: DispatchQueue = DispatchQueue(label: "userInteractive", qos: .userInteractive)
let qUtility: DispatchQueue = DispatchQueue(label: "utility", qos: .utility)


var stop: Bool = false

print("starting QoS Test")
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+10) {
	print("stopping QoS Test")
	stop = true
	
		qBackground.suspend()
		qUserInteractive.suspend()
	print("OoS work done background:\(background) unspecified:\(unspecified) userInitiated:\(userInitiated) userInteractive:\(userInteractive) utility:\(utility)")
	
}

qBackground.async { while ( DispatchQueue.main.sync { !stop }) { background += 1 } }
qUnspecified.async { while (DispatchQueue.main.sync { !stop }) { unspecified += 1 } }
qUserInitiated.async { while (DispatchQueue.main.sync { !stop }) { userInitiated += 1 } }
qUserInteractive.async { while (DispatchQueue.main.sync { !stop }) { userInteractive += 1 } }
qUtility.async { while (DispatchQueue.main.sync { !stop }) { utility += 1 } }
