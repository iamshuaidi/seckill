package org.seckill.dao;

import ch.qos.logback.core.net.SyslogOutputStream;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

/**
 * 配置spring和junit整合，junit启动时加载springIOC容器
 */
@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit spring配置文件
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SeckillDaoTest {
    //注入Dao实现类依赖
    @Resource
    private SeckillDao seckillDao;

    @Test
    public void reduceNumber() {
        Date killTime = new Date();
        int updateCount = seckillDao.reduceNumber(1000L,killTime);
        System.out.println("updateCount:" + updateCount);
    }

    @Test
    public void queryById() {
        long id=1001;
        Seckill seckill = seckillDao.queryById(id);
        System.out.println(seckill);
    }

    @Test
    public void queryAll() {
        /**
         * Caused by: org.apache.ibatis.binding.BindingException:
         * Parameter 'offset' not found. Available parameters are [0, 1, param1, param2]
         */
        //java没有保存形参的记录:queryAll(int offet,int limit) ->queryAll(int arg0,int arg1)
        //可以通过@param注解来解决
        List<Seckill> seckillList = seckillDao.queryAll(0,100);
        for (Seckill seckill:seckillList){
            System.out.println(seckill);
        }
    }
}