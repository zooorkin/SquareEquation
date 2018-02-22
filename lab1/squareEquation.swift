import Foundation

// Перечисление возможных результатов решения уравнения
enum Solution{
    case zero
    case one(Double)
    case two(Double, Double)
    case R
}

// Решение линейного уравнения по B, С
private func solveLinearEquation(b: Double, c: Double) -> Solution{
    func calculateRoot(b: Double, c: Double) -> Double{
        return (-c / b)
    }
    let x = calculateRoot(b: b, c: c)
    return .one(x)
}

// Решение квадратного уравнения по A, B, С
private func solveSquareEquation(a: Double, b: Double, c: Double) -> Solution{
    // Вычисление дискриминанта по A, B, C
    func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double{
        return b * b - 4 * a * c
    }
    // Вычисление корня квадратного уравнения по A, B и sqrt(D)
    // Знак sqrt(D) определяет корень (+ для большего, - для меньшего)
    func calculateRoot(a: Double, b: Double, squareRootFromDiscriminant: Double = 0) -> Double{
        return (-b + squareRootFromDiscriminant) / (2 * a)
    }
    
    let Discriminant = calculateDiscriminant(a, b, c)
    
    if Discriminant < 0{
        return .zero
    }else if Discriminant == 0{
        let x = calculateRoot(a: a, b: b)
        return .one(x)
    }else{
        let squareRootFromDiscriminant: Double = sqrt(Discriminant)
        let x1 = calculateRoot(a: a, b: b, squareRootFromDiscriminant: +squareRootFromDiscriminant)
        let x2 = calculateRoot(a: a, b: b, squareRootFromDiscriminant: -squareRootFromDiscriminant)
        return .two(x1, x2)
    }
}

// Определяет тип уравнения и вызывает соответствующую для решения функцию
// В тривиальных случаях возвращает решение
private func detectTypeOfEquation(_ a: Double, _ b: Double, _ c: Double) -> Solution{
    switch (a, b, c) {
    case (0.0, 0.0, 0.0):
        return .R
    case (0.0, 0.0, _):
        return .zero
    case (0.0, _, _):
        return solveLinearEquation(b: b, c: c)
    default:
        return solveSquareEquation(a: a, b: b, c:c)
    }
}

// Класс SquareEquation позволяет получить решение квадратного уравнения
public class SquareEquation{
    // Значенние коэффициентов
    private var a: Double?
    private var b: Double?
    private var c: Double?
    
    // Инициализация через стандартный ввод
    init(){
        while(a == nil || b == nil || c == nil){
            let aString: String?
            let bString: String?
            let cString: String?
            
            print("Введите A")
            aString = readLine()
            
            print("Введите B")
            bString = readLine()
            
            print("Введите C")
            cString = readLine()
            
            a = Double(aString!)
            b = Double(bString!)
            c = Double(cString!)
            
            if a == nil || b == nil || c == nil{
                print("Некорректный ввод\n")
            }
        }
    }
    
    // Инициализация через аргументы
    init(a: Double, b: Double, c: Double){
        self.a = a
        self.b = b
        self.c = c
    }
    
    // Функция возвращающее решение уравнения
    func getStringSolution() -> String{
        let solution = detectTypeOfEquation(a!, b!, c!)

        switch solution{
        case .zero:
            return "Нет решений"
        case .one(let x):
            return "x = \(x)"
        case .two(let x1, let x2):
            return "x1 = \(x1), x2 = \(x2)"
        case .R:
            return "x = R"
        }
    }
}
