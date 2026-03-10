/**
 * 示例名称：列表组件
 * 语法模块：第2.3节 - CJFrontend 列表
 * 难度：intermediate
 * 
 * 本示例演示：
 * - List 列表组件
 * - LazyForEach 懒加载
 * - ListItem 列表项
 * - DataSource 数据源
 */
import cjmp.ui.*
import std.collection.ArrayList

// 数据模型
class Book {
    public var name: String
    
    public init(name: String) {
        this.name = name
    }
}

// 数据源
class BookDataSource <: DataSource<Book> {
    private var data_: ArrayList<Book> = ArrayList<Book>()
    private var listenerOp: Option<DataChangeListener> = None
    
    public init() {
        for (i in 0..50) {
            data_.add(Book("book ${i}"))
        }
    }
    
    public func totalCount(): Int64 {
        return data_.size
    }
    
    public func getData(index: Int64): Book {
        return data_[index]
    }
    
    public func onRegisterDataChangeListener(listener: DataChangeListener): Unit {
        listenerOp = listener
    }
    
    public func onUnregisterDataChangeListener(listener: DataChangeListener): Unit {
        listenerOp = None
    }
}

@Entry
class ListExample {
    private var dataSourcebook: BookDataSource = BookDataSource()
    
    func build() {
        Column {
            List(space: 10, initialIndex: 0) {
                LazyForEach(dataSourcebook, itemGeneratorFunc: { book: Book, idx: Int64 =>
                    ListItem() {
                        Row {
                            Text(book.name)
                                .width(100.percent)
                                .height(40)
                                .fontSize(16)
                                .textAlign(TextAlign.Center)
                        }
                        .backgroundColor(0xF0F0F0)
                        .borderRadius(8)
                    }
                })
            }
            .width(100.percent)
            .height(100.percent)
        }
    }
}
