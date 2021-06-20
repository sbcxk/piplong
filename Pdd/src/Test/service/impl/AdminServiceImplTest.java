package Test.service.impl;

import dao.AdminDao;
import dao.impl.AdminDaoImpl;
import domain.Admin;
import junit.framework.TestCase;
import org.junit.Test;

public class AdminServiceImplTest extends TestCase {
    @Test
    public void testLogin() {
        AdminDao dao = new AdminDaoImpl();
        System.out.println(dao.findAdminByUsernameAndPassword("admin", "admin"));
    }
}