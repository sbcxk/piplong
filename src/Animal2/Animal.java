package Animal2;
//定义养成（跳高）接口
interface Jumpping {
    //跳高功能
    public abstract void jump();
}

//定义抽象类
abstract class Animal {
    //姓名
    private String name;
    //年龄
    private int age;

    public Animal() {}

    public Animal(String name,int age) {
        this.name = name;
        this.age = age;
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

    //吃饭();
    public abstract void eat();

    //睡觉(){}
    public void sleep() {
        System.out.println("睡觉觉了");
    }
}

//具体猫类
class Cat extends Animal {
    public Cat(){}

    public Cat(String name,int age) {
        super(name,age);
    }

    public void eat() {
        System.out.println("猫吃鱼");
    }
}

//具体狗类
class Dog extends Animal {
    public Dog(){}

    public Dog(String name,int age) {
        super(name,age);
    }

    public void eat() {
        System.out.println("狗吃肉");
    }
}

//有跳高功能的猫
class JumpCat extends Cat implements Jumpping {
    public JumpCat() {}

    public JumpCat(String name,int age) {
        super(name,age);
    }

    public void jump() {
        System.out.println("跳高猫");
    }
}

//有跳高功能的狗
class JumpDog extends Dog implements Jumpping {
    public JumpDog() {}

    public JumpDog(String name,int age) {
        super(name,age);
    }

    public void jump() {
        System.out.println("跳高狗");
    }
}

class InterfaceTest {
    public static void main(String[] args) {
        //定义跳高猫并测试操作
        JumpCat jc = new JumpCat();
        jc.setName("哆啦A梦");
        jc.setAge(3);
        System.out.println(jc.getName()+"---"+jc.getAge());
        jc.eat();
        jc.sleep();
        jc.jump();
        System.out.println("-----------------");

        JumpCat jc2 = new JumpCat("加菲猫",2);
        System.out.println(jc2.getName()+"---"+jc2.getAge());
        jc2.eat();
        jc2.sleep();
        jc2.jump();

        System.out.println("---------------分界线------------------------");
        //定义跳高狗并测试操作
        JumpDog jd = new JumpDog();
        jd.setName("旺财");
        jd.setAge(18);
        System.out.println(jd.getName()+"---"+jd.getAge());
        jd.eat();
        jd.sleep();
        jd.jump();
        System.out.println("-----------------");

        JumpDog jd2 = new JumpDog("二哈",6);
        System.out.println(jd2.getName()+"---"+jd2.getAge());
        jd2.eat();
        jd2.sleep();
        jd2.jump();

    }
}