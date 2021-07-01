package util;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
/**
 * 发邮件工具类
 */
public final class MailUtils {
    private static final String USER = "3534367535@qq.com"; // 发件人称号，同邮箱地址
    private static final String PASSWORD = "rriwobjfvsmwdadc"; // 如果是qq邮箱可以使户端授权码，或者登录密码

    /**
     *
     * @param to 收件人邮箱
     * @param text 邮件正文
     * @param title 标题
     */
    /* 发送验证信息的邮件 */
    public static boolean sendMail(String to, String text, String title){
        try {
            final Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.host", "smtp.qq.com");

            // 发件人的账号
            props.put("mail.user", USER);
            //发件人的密码
            props.put("mail.password", PASSWORD);

            // 构建授权信息，用于进行SMTP进行身份验证
            Authenticator authenticator = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    // 用户名、密码
                    String userName = props.getProperty("mail.user");
                    String password = props.getProperty("mail.password");
                    return new PasswordAuthentication(userName, password);
                }
            };
            // 使用环境属性和授权信息，创建邮件会话
            Session mailSession = Session.getInstance(props, authenticator);
            // 创建邮件消息
            MimeMessage message = new MimeMessage(mailSession);
            // 设置发件人
            String username = props.getProperty("mail.user");
            InternetAddress form = new InternetAddress(username);
            message.setFrom(form);

            // 设置收件人
            InternetAddress toAddress = new InternetAddress(to);
            message.setRecipient(Message.RecipientType.TO, toAddress);

            // 设置邮件标题
            message.setSubject(title);

            // 设置邮件的内容体
            //message.setContent(text, "text/html;charset=UTF-8");


            // 5. 创建图片"节点"
            MimeBodyPart image = new MimeBodyPart();
            String filePath="D:\\Software\\IdeaProjects\\PPL\\out\\artifacts\\Pdd_war_exploded\\imgRaspberry\\";
            // 读取本地文件
            DataHandler dh = new DataHandler(new FileDataSource(filePath+text));
            // 将图片数据添加到"节点"
            image.setDataHandler(dh);
            // 为"节点"设置一个唯一编号（在文本"节点"将引用该ID）
            image.setContentID("mailTestPic");

            // 6. 创建文本"节点"
            MimeBodyPart texts = new MimeBodyPart();
            // 这里添加图片的方式是将整个图片包含到邮件内容中, 实际上也可以以 http 链接的形式添加网络图片
            texts.setContent("【优购商城】您的仓库异常检测已被关闭，请确认操作安全！<br/><div style=\"color: red;font-size: 20px\">监控关闭前最后一次记录：</div><br/><a href='http://blog.piplong.cn'><img src='cid:mailTestPic'/></a>", "text/html;charset=UTF-8");

            // 7. （文本+图片）设置 文本 和 图片"节点"的关系（将 文本 和 图片"节点"合成一个混合"节点"）
            MimeMultipart mm_text_image = new MimeMultipart();
            mm_text_image.addBodyPart(texts);
            mm_text_image.addBodyPart(image);
            mm_text_image.setSubType("related");    // 关联关系

            // 8. 将 文本+图片 的混合"节点"封装成一个普通"节点"
            // 最终添加到邮件的 Content 是由多个 BodyPart 组成的 Multipart, 所以我们需要的是 BodyPart,
            // 上面的 mailTestPic 并非 BodyPart, 所有要把 mm_text_image 封装成一个 BodyPart
            MimeBodyPart text_image = new MimeBodyPart();
            text_image.setContent(mm_text_image);

            // 9. 创建附件"节点"
            //MimeBodyPart attachment = new MimeBodyPart();
            // 读取本地文件
            //DataHandler dh2 = new DataHandler(new FileDataSource("C:\\Users\\10796\\Desktop\\学习通作业\\English.docx"));
            // 将附件数据添加到"节点"
            //attachment.setDataHandler(dh2);
            // 设置附件的文件名（需要编码）
            //attachment.setFileName(MimeUtility.encodeText(dh2.getName()));

            // 10. 设置（文本+图片）和 附件 的关系（合成一个大的混合"节点" / Multipart ）
            MimeMultipart mm = new MimeMultipart();
            mm.addBodyPart(text_image);
            //mm.addBodyPart(attachment);     // 如果有多个附件，可以创建多个多次添加
            mm.setSubType("mixed");         // 混合关系
            message.setContent(mm);
            // 发送邮件

            Transport.send(message);
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) throws Exception { // 做测试用
        MailUtils.sendMail("1079654850@qq.com","abnormal001.jpg","测试邮件");
        System.out.println("发送成功");
    }



}
