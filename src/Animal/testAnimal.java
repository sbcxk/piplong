package Animal;

public class testAnimal {
    public static void main(String[] args) {
        //测试猫
        //方式1
        Cat c1 = new Cat();
        c1.setName("Tom");
        c1.setAge(3);
        c1.setColor("白色");
        System.out.println("猫的名字是："+c1.getName()+";年龄是："+c1.getAge()+";颜色是："+c1.getColor());
        c1.eat();
        c1.playGame();
        System.out.println("---------------");

        //方式2
        Cat c2 = new Cat("杰瑞",5,"土豪金");
        System.out.println("猫的名字是："+c2.getName()+";年龄是："+c2.getAge()+";颜色是："+c2.getColor());
        c2.eat();
        c2.playGame();
        System.out.println("--------分界线-------");
        //测试狗
        //方式1
        Dog d1 = new Dog();
        d1.setName("Jerry");
        d1.setAge(3);
        d1.setColor("黑色");
        System.out.println("狗的名字是："+d1.getName()+";年龄是："+d1.getAge()+";颜色是："+d1.getColor());
        d1.eat();
        d1.lookDoor();
        System.out.println("---------------");

        //方式2
        Dog d2 = new Dog("杰瑞",5,"土豪金");
        System.out.println("狗的名字是："+d2.getName()+";年龄是："+d2.getAge()+";颜色是："+d2.getColor());
        d2.eat();
        d2.lookDoor();
    }
}
