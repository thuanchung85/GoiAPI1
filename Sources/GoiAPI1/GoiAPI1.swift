public enum TrangThai:String
{
    case mot = "1"
    case hai = "2"
    case ba = "3"
}


public struct GoiAPI1 {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public func hamChayThu(){
        let i = 1
        let x = 2
        print("Hello toi tu trong package ne", (i + x))
    }
    
    public func thuChayFor(n:Int){
        let languages = ["Swift", "Java", "Go", "JavaScript"]

        for language in languages {
              print(language)
        }
        
        // iterate from i = 1 to i = 3
        for i in 1...n {
            print(i)
        }
    }
}
