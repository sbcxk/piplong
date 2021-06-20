package Animal;

//定义猫类
public class Cat extends Animal{

    public Cat(){}

    public Cat(String name,int age,String color) {
        super(name,age,color);
    }

    public void playGame() {
        System.out.println("猫玩英雄联盟");
    }

    public void eat() {
        System.out.println("猫吃鱼");
    }
}
