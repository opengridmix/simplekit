package org.thrive.sites.core.config;

/**
 * 
 * @author  张代浩
 *
 */
public interface Constants {

	/**   运行模式:开发者或者生产者
	 */
	public static final String MODE_DEVELOP = "DEV";
	public static final String MODE_PRODUCT = "PUB";





    //****************************************************************************************
    //*********系统上下文变量****************************************
    /**
     * 数据-所属公司编码
     */
    public static final String SYS_COMPANY_CODE = "sysCompanyCode";
    public static final String SYS_COMPANY_CODE_TABLE = "sys_company_code";
    /**
     * 数据-所属机构编码
     */
    public static final String SYS_ORG_CODE = "sysOrgCode";
    public static final String SYS_ORG_CODE_TABLE = "sys_org_code";
    /**
     * 数据-系统用户编码（对应登录用户账号）
     */
    public static final String SYS_USER_CODE = "sysUserCode";
    public static final String SYS_USER_CODE_TABLE = "sys_user_code";
    /**
     * 登录用户真实姓名
     */
    public static final String SYS_USER_NAME = "sysUserName";
    public static final String SYS_USER_NAME_TABLE = "sys_user_name";
    /**
     * 系统日期"yyyy-MM-dd"
     */
    public static final String SYS_DATE = "sysDate";
    public static final String SYS_DATE_TABLE = "sys_date";
    /**
     * 系统时间"yyyy-MM-dd HH:mm"
     */
    public static final String SYS_TIME = "sysTime";
    public static final String SYS_TIME_TABLE = "sys_time";
    //*********系统上下文变量****************************************
    //****************************************************************************************


    //****************************************************************************************
    //*********系统建表标准字段****************************************
    /**
     * 创建者登录名称
     */
    public static final String CREATE_BY_TABLE = "create_by";
    public static final String CREATE_BY = "createBy";
    /**
     * 创建用户真是名称
     */
    public static final String CREATE_NAME_TABLE = "create_name";
    public static final String CREATE_NAME = "createName";
    /**
     * 创建日期
     */
    public static final String CREATE_DATE_TABLE = "create_date";
    public static final String CREATE_DATE = "createDate";
    /**
     * 创建日期时间
     */
    public static final String CREATE_TIME_TABLE = "create_time";
    public static final String CREATE_TIME = "createTime";
    /**
     * 更新用户登录名称
     */
    public static final String UPDATE_BY_TABLE = "update_by";
    public static final String UPDATE_BY = "updateBy";
    /**
     * 更新用户真是名称
     */
    public static final String UPDATE_NAME_TABLE = "update_name";
    public static final String UPDATE_NAME = "updateName";
    /**
     * 更新日期
     */
    public static final String UPDATE_DATE = "updateDate";
    public static final String UPDATE_DATE_TABLE = "update_date";
    /**
     * 更新日期时间
     */
    public static final String UPDATE_TIME = "updateTime";
    public static final String UPDATE_TIME_TABLE = "update_time";
    //*********系统建表标准字段****************************************
    //****************************************************************************************
	 
}
