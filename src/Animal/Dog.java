package Animal;

//定义狗类
public class Dog extends Animal{
    public Dog() {}

    public Dog(String name,int age,String color) {
        super(name,age,color);
    }

    public void lookDoor() {
        System.out.println("狗看家");
    }

    /*public void eat() {
        System.out.println("狗吃骨头");
    }*/
}
