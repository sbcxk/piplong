package Animal;

//定义宠物的父类
public class Animal {
    // 姓名
    private String name;
    // 年龄
    private int age;
    // 毛色
    private String color;

    // 有参构造 无参构造
    public Animal() {}

    public Animal(String name,int age,String color) {
        this.name = name;
        this.age = age;
        this.color = color;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void eat() {
        System.out.println("醒醒，8要睡了,菜要凉了");
    }
    @Override
    public String toString() {
        return "Animal{" +
                "name='" + name + '\'' +
                ", age=" + age +
                ", color='" + color + '\'' +
                '}';
    }
}

