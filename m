Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C088451D206
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389427AbiEFHQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiEFHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:16:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2E66C9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:12:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2464h4J4030007;
        Fri, 6 May 2022 07:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r81zyhV5sDVmSM3UgcWqXh5PlI/pDDWiiCocn8jTqPg=;
 b=yUMjj9pL3HO1box3aS0snLnIMOA7SXaC48ODvYD6c9tRHVPIv8Q/tFWFjD4zXQV4+B1L
 Jo8ETDwwP2QKnp0vlUtizBnjZ3P/u2wKfLGSquNAjEVJcP5vbwlyIgAXH6iqKKF9SApI
 EGzW6WIznf3SoGLvhadxwMF5Yd8rFuuRxlyIIqch6/W4WJfRHPgminpzLZsajB0rPezG
 zFGJymx/uAXUOFfw8L0w99vkC9dstsFU1vlMho1B5HlIksNpY79lL+mZ7/4NMq7U38HJ
 cukHtTFAGT3OVjKwmqKP6ipgqOmT/KKdOig/n3t/5WQv4YZjv35gVwbmC+ILBzMFg1po wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0ncvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:12:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246755vx003046;
        Fri, 6 May 2022 07:12:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujbpye8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ParUXFqy0XGC60SrLexV10rQ+6Ic6dIHbExRlcnws+7q6j5YSr286spzxrRS42fJXKeAXEQGeyazp78Vs+so8vvUh45Obm4MT6+DkVKjoiiOc5LoIXYBxiqtIvXlHBEPxT/uOyTmGBfvSM5y0fh9IJtI2Dz2eE1Q+NCeNyKImDy4k3IqUORdH5t4OGb8y8GkG6DcgP/F41GkaWD7yqaNKE4fxcdzfmBsXVY1eq76FrHazYmMJoozHZcOZ+Hny/+y2stnU53QmHtApFloPId8ZjY9FNhxBepUgoWf838Zt9a2CTOeGNzaIwDSwWpctP6edDbGabnMFrrp2hkcPAVpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r81zyhV5sDVmSM3UgcWqXh5PlI/pDDWiiCocn8jTqPg=;
 b=Gumy46m3xGW/iVBKrVkwu05x1cYMZnL14v7941gFJkLXUolm6K/Yf8PnavHPArQVjbQD7cDzhjmCl1cWvcl5GX1Y9YFDHx8q5/BJdNzyj2nUW9oCq4Pp7XhtILAX0Uzwj2d9N14mA1Yox4tlchwRA2M03nrDywyyk+vTIRUiiNMsa4Hi/B4Jjbmo+ucMCJ55P5My7mEex7NV9ISfxI0sEst5st0lvHBttU6NFjoGVhTk0GMaaOVP33s2XFQ8Yom/I6MEUcakTMDznshhemRiokIimxPD5dY9IFfkS2YG499qkVDR+5gQdlY4fpb8ZVK0QkvV3Ke9HJ860ZIaZcIQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r81zyhV5sDVmSM3UgcWqXh5PlI/pDDWiiCocn8jTqPg=;
 b=D4tfWa/PFriJNPMuM2VmXDh6BE34bUwUSFAQd5DMX0rrRRnYxRSPqVmRpyPpymHrG9y68At57FZHNz5BtzERALMWAdUwMVh6LYYchtL/4LNI6j6PdHWolCsEo6arB08US+ExT/hUqIPgs5r2HWRHgeNeqjJA+h2oFXJ7aHdJPFU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB2022.namprd10.prod.outlook.com
 (2603:10b6:903:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 07:12:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 07:12:30 +0000
Date:   Fri, 6 May 2022 10:12:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Marek Vasut <marex@denx.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:20220430_marex_regmap_add_bulk_read_write_callbacks_into_regmap_config
 1/1] drivers/base/regmap/regmap.c:1842 _regmap_raw_write_impl() error: we
 previously assumed 'map->bus' could be null (see line 1770)
Message-ID: <202205060518.hir67qzc-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85195cec-d74e-4b69-42a3-08da2f2fc8d0
X-MS-TrafficTypeDiagnostic: CY4PR10MB2022:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB2022D31762D5C400063CA2AF8EC59@CY4PR10MB2022.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uYzZbZhyQ/g0q9FErVNhgCc1AFz4dgkgOPMmYNnzSy7jGwzk+SoOF7vSxtXT9aJhgBhZUY+J2KNjGhsNrvmDxZ5HwDSqS4oaf5WGVDhpfTNbxY02olwO//phdZ6U7aJz5vAbkMpK/r9tE9Jrjs+ImiL7C/Z+Pmg5VhqC1a8PHB/Msi/wCmAK4xk+jFXpmC7a8s3R9c7NjG6jHxk63QWIjsRg7xoNoUwOEThbyk762qJZb7eHAYMymoBI3vlKBlWIUXnh5ZQ1P7ed3hP6nDpgcqlTyGdyqYMogQzhngh+rd2juZ8dIRz+zmacNwb6izn9crcAMZvOAgv8YVxTMkTSI1fAWG5qXZKM+6JCYs6lj7QvUGiesStS8Lplc6R2lQEG1Cc3pBJ7vAs/ppciAHIblKC3mU08AGWNlRa24/M84CJaIEtbtEW47B8WuiJbdkVopPbhYeEclUdvV0ByUaRciOiNeIqvhZVt3vg22c/hY9a8fe6XRSCrilf49DefhKbibP77k4hhEv9aIBoAgDSc2DDoVXUz6qdQBN0ycMvzJGhqBXt1QEFoYqnN4fddNASNNy7r99YNcAD53eEqMpS8V2hpFzYfcdacOqePm8d9bcNrJqnip9197J7qbOVtKpFjNylOdfm79atOdYgo7Xs2+inOv4AazMCyzeDAgYWHUxPUeXayZ5c9Fg7F9vwfjjKQKyvKpo7oVXva3PiVhqtzMMyS7A+xZeVDo7hnEjAz2KI818uG+LcxmArVZOBw2RseMmh+hbQEx29wtZ60aAcsLaD1bFUZAggznu2U/VVcusfvAlpj1f9Zu2of1klNUxeyoB3ywTRi7HYxXhjRMD7HmamzDFLkeqtM9mG8gg1D0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(508600001)(5660300002)(6666004)(38100700002)(36756003)(38350700002)(52116002)(8936002)(66946007)(186003)(83380400001)(6512007)(9686003)(26005)(6506007)(6486002)(30864003)(966005)(316002)(44832011)(4001150100001)(2906002)(86362001)(66476007)(1076003)(8676002)(66556008)(4326008)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmSh1uBE6dejF+Zpko/t+ufJr/+GRFFS5nLS9i7too1AjYEg4qtAiDdt1+CS?=
 =?us-ascii?Q?ttPFd+3tlyOeTxMpXMyJ5x9hdkXWvpd9joZ3bRpH/yFmPcyI5eaPAQoa2CwD?=
 =?us-ascii?Q?mNAJQgFfRdpa3NzThN8dtZ/INw+sr3Sp0UED8JsLvhh/T+jOd2Bt1iPFPrsX?=
 =?us-ascii?Q?rAT/7kk5Ln0YaLNMwuWI4DUiOwA3F2rhj8te83n/NtidHTt2jtLCiYYLxyBi?=
 =?us-ascii?Q?YS3xYJtYVWAdckuxAPP8UXkG1KOXgy2WvPY4AZCKo9vzeERoQhAnMzyH8l2k?=
 =?us-ascii?Q?MqVuN9MNW/6DUvetEOWPRbNrFEjhBmuyGHgxbqHj6NJkQlXSBbLMCi6kcT9h?=
 =?us-ascii?Q?BLIbQ6wT/W9SrbkSIEusjc0TFHSTPMTc5xs+juEC9rESneWh4Pr9NChS2ZOA?=
 =?us-ascii?Q?e3gLs+gD6fH2WDTyKdkRD80gjF05O9odKhPkvgmdq2aofs3fMwSiPYQ+Xdd8?=
 =?us-ascii?Q?ovtc9eEJvH1h16BBfV6j4EnuhFB/WUfAwLE+3Bz4EuRB0c9ZQbspOBDCeybQ?=
 =?us-ascii?Q?m0MzFLhIOPO1zOGXBm6vJGk8Fhodoi67kzBd8zQDFD76X/9UDgo62zAmyjIW?=
 =?us-ascii?Q?dMc0WMJsj20jOVYNKVc4WedXTW6XlIhGwf9iIenCcuSW0ML5IGhuZBqIVCI0?=
 =?us-ascii?Q?WRjE6D0EX86SXazLEDZQdl1MRS/ais1prExHoEPqYIrUKIi1BhhzfoH4xpXa?=
 =?us-ascii?Q?f2Xqfqs2hyu7gzqabcdD6Q6Znr/thk7t40vvNrRQKtkmfFHBLlyM05bPRJ4l?=
 =?us-ascii?Q?t5KI73tRoKPWrI7F/wqUPojuXUNL+ZqGYHZF6xplfQGpWMvwyMpMFAGDk30c?=
 =?us-ascii?Q?Fj1pG7aFqvRanqW8NUb7adeg2j05yX+pU+K+LapBLhpUt93gi0BMkNN/DtE/?=
 =?us-ascii?Q?ilaOERpAxLNG5OX8atJkjlJUvuqdM/+/O4UFpfmtVsqcVeoJ0jguZD18Q4SP?=
 =?us-ascii?Q?+WQDctxJaXY0BEiUG0PB91aRQ2/miBjYp7zSiKYZdjc7Bpj68a1XQOPlQjxr?=
 =?us-ascii?Q?LbMpcOtQVrZzSgKpaAmttl9IK9TvzSDeNLpGieUbD0muHROhZ6Np/DxczLiN?=
 =?us-ascii?Q?ayjgOG5NtnzAKE0JilvTzaNJNhwKj7dFJNtVaM+2O0KHrSZ+WwyC7pm08bap?=
 =?us-ascii?Q?cBOegqjIhqsWuO3gY2B8PBfAgmz9oHNnG6GMBHIvo7RW3DZR8t++hW2wrAss?=
 =?us-ascii?Q?CpeJgarLcYvVTCFtBgnwHj5EAwgYdY0SxOSf0nIYTWZbZewFkCbJvw79kdC3?=
 =?us-ascii?Q?ZuKhRvWQZcdcVj37TDmiraR+Juc1+Nn0MH3t2N254vJFQZeMTOUOkJYeXpHk?=
 =?us-ascii?Q?nGG2vBO8KEkU4P1mmN/bVcsqVaYfxIkr57hDeCGpGZrbftWe+N7QIV78fwz7?=
 =?us-ascii?Q?T1PBbUjWUGYSQrGevvr97Us7k76Pb387JdFMYgypGKqmHTarWBRedjNQ3L9b?=
 =?us-ascii?Q?VUvtlEtngQZtZ3hUx+TACdoAowH0y1m2xNeYzPGx+rXMrpgoyD0FQT8Cef9c?=
 =?us-ascii?Q?ykCCHEL/NH+P7y/ppc95Cnb8xi93gBu216ZoxIIyv7mPEhxGQc9VDpy22t4U?=
 =?us-ascii?Q?iiw+EWjIB9LVPb0OGJpYYdY0jOk6ZozPpVAnT465rFIHAMDnyk9pkl1ozvty?=
 =?us-ascii?Q?nK6tHmJhsFATs+tLUcxhpHR9djblq/iKf9nS2NtY/Dtp9gr5pMqbYpBDfVQC?=
 =?us-ascii?Q?PHKSKtl1oIj4F7AkrmwmCYCelDJXVVbbvOZlteUqjgp3+QFHESxwyDSeZqgH?=
 =?us-ascii?Q?025ti19qJGkm+G/4L3PApXsKj+uePf8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85195cec-d74e-4b69-42a3-08da2f2fc8d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:12:30.8531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/SzyQ/D0cTMEgpklfDVDGdfUCab4gkh8Z7xX+slwtyANMGb1isbsAnl1V4RBK6DFgHWfZ3vvht483yJkE9XCnqyjMlhRvzmIQMWX62uAdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2022
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060037
X-Proofpoint-ORIG-GUID: 7f1b1_j1sxbZPkdwGefOP79wQ5yJg5jk
X-Proofpoint-GUID: 7f1b1_j1sxbZPkdwGefOP79wQ5yJg5jk
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git 20220430_marex_regmap_add_bulk_read_write_callbacks_into_regmap_config
head:   d77e745613680c54708470402e2b623dcd769681
commit: d77e745613680c54708470402e2b623dcd769681 [1/1] regmap: Add bulk read/write callbacks into regmap_config
config: m68k-randconfig-m031-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060518.hir67qzc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/base/regmap/regmap.c:1842 _regmap_raw_write_impl() error: we previously assumed 'map->bus' could be null (see line 1770)

vim +1842 drivers/base/regmap/regmap.c

7ef2c6b8689a08 Charles Keepax      2018-02-22  1677  static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
05669b63170771 Dmitry Baryshkov    2020-09-17  1678  				  const void *val, size_t val_len, bool noinc)
b83a313bf25201 Mark Brown          2011-05-11  1679  {
98bc7dfd76407e Mark Brown          2012-10-04  1680  	struct regmap_range_node *range;
0d509f2b112b21 Mark Brown          2013-01-27  1681  	unsigned long flags;
0d509f2b112b21 Mark Brown          2013-01-27  1682  	void *work_val = map->work_buf + map->format.reg_bytes +
0d509f2b112b21 Mark Brown          2013-01-27  1683  		map->format.pad_bytes;
b83a313bf25201 Mark Brown          2011-05-11  1684  	void *buf;
b83a313bf25201 Mark Brown          2011-05-11  1685  	int ret = -ENOTSUPP;
b83a313bf25201 Mark Brown          2011-05-11  1686  	size_t len;
73304781274200 Mark Brown          2011-07-24  1687  	int i;
73304781274200 Mark Brown          2011-07-24  1688  
2e31aab08bad0d Ben Whitten         2020-01-18  1689  	/* Check for unwritable or noinc registers in range
2e31aab08bad0d Ben Whitten         2020-01-18  1690  	 * before we start
2e31aab08bad0d Ben Whitten         2020-01-18  1691  	 */
2e31aab08bad0d Ben Whitten         2020-01-18  1692  	if (!regmap_writeable_noinc(map, reg)) {
2e31aab08bad0d Ben Whitten         2020-01-18  1693  		for (i = 0; i < val_len / map->format.val_bytes; i++) {
2e31aab08bad0d Ben Whitten         2020-01-18  1694  			unsigned int element =
2e31aab08bad0d Ben Whitten         2020-01-18  1695  				reg + regmap_get_offset(map, i);
2e31aab08bad0d Ben Whitten         2020-01-18  1696  			if (!regmap_writeable(map, element) ||
2e31aab08bad0d Ben Whitten         2020-01-18  1697  				regmap_writeable_noinc(map, element))
73304781274200 Mark Brown          2011-07-24  1698  				return -EINVAL;
2e31aab08bad0d Ben Whitten         2020-01-18  1699  		}
2e31aab08bad0d Ben Whitten         2020-01-18  1700  	}
b83a313bf25201 Mark Brown          2011-05-11  1701  
c9157198417076 Laxman Dewangan     2012-02-10  1702  	if (!map->cache_bypass && map->format.parse_val) {
c9157198417076 Laxman Dewangan     2012-02-10  1703  		unsigned int ival;
c9157198417076 Laxman Dewangan     2012-02-10  1704  		int val_bytes = map->format.val_bytes;
c9157198417076 Laxman Dewangan     2012-02-10  1705  		for (i = 0; i < val_len / val_bytes; i++) {
5a08d15602987b Stephen Warren      2013-03-20  1706  			ival = map->format.parse_val(val + (i * val_bytes));
ca747be22fa57b Xiubo Li            2016-01-04  1707  			ret = regcache_write(map,
ca747be22fa57b Xiubo Li            2016-01-04  1708  					     reg + regmap_get_offset(map, i),
f01ee60fffa4dc Stephen Warren      2012-04-09  1709  					     ival);
c9157198417076 Laxman Dewangan     2012-02-10  1710  			if (ret) {
c9157198417076 Laxman Dewangan     2012-02-10  1711  				dev_err(map->dev,
6d04b8ac575c38 Mark Brown          2012-10-26  1712  					"Error in caching of register: %x ret: %d\n",
1852f5ed358147 Jeongtae Park       2021-07-01  1713  					reg + regmap_get_offset(map, i), ret);
c9157198417076 Laxman Dewangan     2012-02-10  1714  				return ret;
c9157198417076 Laxman Dewangan     2012-02-10  1715  			}
c9157198417076 Laxman Dewangan     2012-02-10  1716  		}
c9157198417076 Laxman Dewangan     2012-02-10  1717  		if (map->cache_only) {
c9157198417076 Laxman Dewangan     2012-02-10  1718  			map->cache_dirty = true;
c9157198417076 Laxman Dewangan     2012-02-10  1719  			return 0;
c9157198417076 Laxman Dewangan     2012-02-10  1720  		}
c9157198417076 Laxman Dewangan     2012-02-10  1721  	}
c9157198417076 Laxman Dewangan     2012-02-10  1722  
98bc7dfd76407e Mark Brown          2012-10-04  1723  	range = _regmap_range_lookup(map, reg);
98bc7dfd76407e Mark Brown          2012-10-04  1724  	if (range) {
8a2ceac6617a67 Mark Brown          2012-10-04  1725  		int val_num = val_len / map->format.val_bytes;
8a2ceac6617a67 Mark Brown          2012-10-04  1726  		int win_offset = (reg - range->range_min) % range->window_len;
8a2ceac6617a67 Mark Brown          2012-10-04  1727  		int win_residue = range->window_len - win_offset;
8a2ceac6617a67 Mark Brown          2012-10-04  1728  
8a2ceac6617a67 Mark Brown          2012-10-04  1729  		/* If the write goes beyond the end of the window split it */
8a2ceac6617a67 Mark Brown          2012-10-04  1730  		while (val_num > win_residue) {
1a61cfe3445218 Fabio Estevam       2012-10-25  1731  			dev_dbg(map->dev, "Writing window %d/%zu\n",
8a2ceac6617a67 Mark Brown          2012-10-04  1732  				win_residue, val_len / map->format.val_bytes);
7ef2c6b8689a08 Charles Keepax      2018-02-22  1733  			ret = _regmap_raw_write_impl(map, reg, val,
7ef2c6b8689a08 Charles Keepax      2018-02-22  1734  						     win_residue *
05669b63170771 Dmitry Baryshkov    2020-09-17  1735  						     map->format.val_bytes, noinc);
8a2ceac6617a67 Mark Brown          2012-10-04  1736  			if (ret != 0)
8a2ceac6617a67 Mark Brown          2012-10-04  1737  				return ret;
8a2ceac6617a67 Mark Brown          2012-10-04  1738  
8a2ceac6617a67 Mark Brown          2012-10-04  1739  			reg += win_residue;
8a2ceac6617a67 Mark Brown          2012-10-04  1740  			val_num -= win_residue;
8a2ceac6617a67 Mark Brown          2012-10-04  1741  			val += win_residue * map->format.val_bytes;
8a2ceac6617a67 Mark Brown          2012-10-04  1742  			val_len -= win_residue * map->format.val_bytes;
8a2ceac6617a67 Mark Brown          2012-10-04  1743  
8a2ceac6617a67 Mark Brown          2012-10-04  1744  			win_offset = (reg - range->range_min) %
8a2ceac6617a67 Mark Brown          2012-10-04  1745  				range->window_len;
8a2ceac6617a67 Mark Brown          2012-10-04  1746  			win_residue = range->window_len - win_offset;
8a2ceac6617a67 Mark Brown          2012-10-04  1747  		}
8a2ceac6617a67 Mark Brown          2012-10-04  1748  
05669b63170771 Dmitry Baryshkov    2020-09-17  1749  		ret = _regmap_select_page(map, &reg, range, noinc ? 1 : val_num);
0ff3e62ff119f2 Mark Brown          2012-10-04  1750  		if (ret != 0)
6863ca6227598d Krystian Garbaciak  2012-06-15  1751  			return ret;
98bc7dfd76407e Mark Brown          2012-10-04  1752  	}
6863ca6227598d Krystian Garbaciak  2012-06-15  1753  
0074f3f2b1e43d Colin Foster        2022-03-13  1754  	reg += map->reg_base;
86fc59ef818beb Colin Foster        2022-03-13  1755  	reg >>= map->format.reg_downshift;
d939fb9a78b474 Marc Reilly         2012-03-16  1756  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
f50e38c9966076 Tony Lindgren       2016-09-15  1757  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
f50e38c9966076 Tony Lindgren       2016-09-15  1758  				      map->write_flag_mask);
6f306441e97f8f Lars-Peter Clausen  2011-09-05  1759  
651e013e3ce6c0 Mark Brown          2013-10-08  1760  	/*
651e013e3ce6c0 Mark Brown          2013-10-08  1761  	 * Essentially all I/O mechanisms will be faster with a single
651e013e3ce6c0 Mark Brown          2013-10-08  1762  	 * buffer to write.  Since register syncs often generate raw
651e013e3ce6c0 Mark Brown          2013-10-08  1763  	 * writes of single registers optimise that case.
651e013e3ce6c0 Mark Brown          2013-10-08  1764  	 */
651e013e3ce6c0 Mark Brown          2013-10-08  1765  	if (val != work_val && val_len == map->format.val_bytes) {
651e013e3ce6c0 Mark Brown          2013-10-08  1766  		memcpy(work_val, val, map->format.val_bytes);
651e013e3ce6c0 Mark Brown          2013-10-08  1767  		val = work_val;
651e013e3ce6c0 Mark Brown          2013-10-08  1768  	}
651e013e3ce6c0 Mark Brown          2013-10-08  1769  
d77e745613680c Marek Vasut         2022-04-30 @1770  	if (map->async && map->bus && map->bus->async_write) {
                                                                          ^^^^^^^^
Do we really need to check map->bus?

7e09a979404ed0 Mark Brown          2013-10-07  1771  		struct regmap_async *async;
0d509f2b112b21 Mark Brown          2013-01-27  1772  
c6b570d97c0e77 Philipp Zabel       2015-03-09  1773  		trace_regmap_async_write_start(map, reg, val_len);
fe7d4ccd1d7748 Mark Brown          2013-02-21  1774  
7e09a979404ed0 Mark Brown          2013-10-07  1775  		spin_lock_irqsave(&map->async_lock, flags);
7e09a979404ed0 Mark Brown          2013-10-07  1776  		async = list_first_entry_or_null(&map->async_free,
7e09a979404ed0 Mark Brown          2013-10-07  1777  						 struct regmap_async,
7e09a979404ed0 Mark Brown          2013-10-07  1778  						 list);
7e09a979404ed0 Mark Brown          2013-10-07  1779  		if (async)
7e09a979404ed0 Mark Brown          2013-10-07  1780  			list_del(&async->list);
7e09a979404ed0 Mark Brown          2013-10-07  1781  		spin_unlock_irqrestore(&map->async_lock, flags);
7e09a979404ed0 Mark Brown          2013-10-07  1782  
7e09a979404ed0 Mark Brown          2013-10-07  1783  		if (!async) {
7e09a979404ed0 Mark Brown          2013-10-07  1784  			async = map->bus->async_alloc();
7e09a979404ed0 Mark Brown          2013-10-07  1785  			if (!async)
7e09a979404ed0 Mark Brown          2013-10-07  1786  				return -ENOMEM;
7e09a979404ed0 Mark Brown          2013-10-07  1787  
0d509f2b112b21 Mark Brown          2013-01-27  1788  			async->work_buf = kzalloc(map->format.buf_size,
0d509f2b112b21 Mark Brown          2013-01-27  1789  						  GFP_KERNEL | GFP_DMA);
0d509f2b112b21 Mark Brown          2013-01-27  1790  			if (!async->work_buf) {
0d509f2b112b21 Mark Brown          2013-01-27  1791  				kfree(async);
0d509f2b112b21 Mark Brown          2013-01-27  1792  				return -ENOMEM;
0d509f2b112b21 Mark Brown          2013-01-27  1793  			}
7e09a979404ed0 Mark Brown          2013-10-07  1794  		}
0d509f2b112b21 Mark Brown          2013-01-27  1795  
0d509f2b112b21 Mark Brown          2013-01-27  1796  		async->map = map;
0d509f2b112b21 Mark Brown          2013-01-27  1797  
0d509f2b112b21 Mark Brown          2013-01-27  1798  		/* If the caller supplied the value we can use it safely. */
0d509f2b112b21 Mark Brown          2013-01-27  1799  		memcpy(async->work_buf, map->work_buf, map->format.pad_bytes +
0d509f2b112b21 Mark Brown          2013-01-27  1800  		       map->format.reg_bytes + map->format.val_bytes);
0d509f2b112b21 Mark Brown          2013-01-27  1801  
0d509f2b112b21 Mark Brown          2013-01-27  1802  		spin_lock_irqsave(&map->async_lock, flags);
0d509f2b112b21 Mark Brown          2013-01-27  1803  		list_add_tail(&async->list, &map->async_list);
0d509f2b112b21 Mark Brown          2013-01-27  1804  		spin_unlock_irqrestore(&map->async_lock, flags);
0d509f2b112b21 Mark Brown          2013-01-27  1805  
04c50ccf0dab02 Mark Brown          2013-10-10  1806  		if (val != work_val)
04c50ccf0dab02 Mark Brown          2013-10-10  1807  			ret = map->bus->async_write(map->bus_context,
04c50ccf0dab02 Mark Brown          2013-10-10  1808  						    async->work_buf,
0d509f2b112b21 Mark Brown          2013-01-27  1809  						    map->format.reg_bytes +
0d509f2b112b21 Mark Brown          2013-01-27  1810  						    map->format.pad_bytes,
0d509f2b112b21 Mark Brown          2013-01-27  1811  						    val, val_len, async);
04c50ccf0dab02 Mark Brown          2013-10-10  1812  		else
04c50ccf0dab02 Mark Brown          2013-10-10  1813  			ret = map->bus->async_write(map->bus_context,
04c50ccf0dab02 Mark Brown          2013-10-10  1814  						    async->work_buf,
04c50ccf0dab02 Mark Brown          2013-10-10  1815  						    map->format.reg_bytes +
04c50ccf0dab02 Mark Brown          2013-10-10  1816  						    map->format.pad_bytes +
04c50ccf0dab02 Mark Brown          2013-10-10  1817  						    val_len, NULL, 0, async);
0d509f2b112b21 Mark Brown          2013-01-27  1818  
0d509f2b112b21 Mark Brown          2013-01-27  1819  		if (ret != 0) {
0d509f2b112b21 Mark Brown          2013-01-27  1820  			dev_err(map->dev, "Failed to schedule write: %d\n",
0d509f2b112b21 Mark Brown          2013-01-27  1821  				ret);
0d509f2b112b21 Mark Brown          2013-01-27  1822  
0d509f2b112b21 Mark Brown          2013-01-27  1823  			spin_lock_irqsave(&map->async_lock, flags);
7e09a979404ed0 Mark Brown          2013-10-07  1824  			list_move(&async->list, &map->async_free);
0d509f2b112b21 Mark Brown          2013-01-27  1825  			spin_unlock_irqrestore(&map->async_lock, flags);
0d509f2b112b21 Mark Brown          2013-01-27  1826  		}
f951b6587b94df Mark Brown          2013-03-27  1827  
f951b6587b94df Mark Brown          2013-03-27  1828  		return ret;
0d509f2b112b21 Mark Brown          2013-01-27  1829  	}
0d509f2b112b21 Mark Brown          2013-01-27  1830  
c6b570d97c0e77 Philipp Zabel       2015-03-09  1831  	trace_regmap_hw_write_start(map, reg, val_len / map->format.val_bytes);
fb2736bbaee0e7 Mark Brown          2011-07-24  1832  
2547e201b3693f Mark Brown          2011-07-20  1833  	/* If we're doing a single register write we can probably just
2547e201b3693f Mark Brown          2011-07-20  1834  	 * send the work_buf directly, otherwise try to do a gather
2547e201b3693f Mark Brown          2011-07-20  1835  	 * write.
2547e201b3693f Mark Brown          2011-07-20  1836  	 */
0d509f2b112b21 Mark Brown          2013-01-27  1837  	if (val == work_val)
d77e745613680c Marek Vasut         2022-04-30  1838  		ret = map->write(map->bus_context, map->work_buf,
82159ba8e6ef8c Mark Brown          2012-01-18  1839  				 map->format.reg_bytes +
82159ba8e6ef8c Mark Brown          2012-01-18  1840  				 map->format.pad_bytes +
82159ba8e6ef8c Mark Brown          2012-01-18  1841  				 val_len);
2547e201b3693f Mark Brown          2011-07-20 @1842  	else if (map->bus->gather_write)
                                                                 ^^^^^^^^
It's not checked here

0135bbcc7a0cc0 Stephen Warren      2012-04-04  1843  		ret = map->bus->gather_write(map->bus_context, map->work_buf,
82159ba8e6ef8c Mark Brown          2012-01-18  1844  					     map->format.reg_bytes +
82159ba8e6ef8c Mark Brown          2012-01-18  1845  					     map->format.pad_bytes,
b83a313bf25201 Mark Brown          2011-05-11  1846  					     val, val_len);
db057679de3e9e Srinivas Kandagatla 2019-06-12  1847  	else
db057679de3e9e Srinivas Kandagatla 2019-06-12  1848  		ret = -ENOTSUPP;
b83a313bf25201 Mark Brown          2011-05-11  1849  
2547e201b3693f Mark Brown          2011-07-20  1850  	/* If that didn't work fall back on linearising by hand. */
b83a313bf25201 Mark Brown          2011-05-11  1851  	if (ret == -ENOTSUPP) {
82159ba8e6ef8c Mark Brown          2012-01-18  1852  		len = map->format.reg_bytes + map->format.pad_bytes + val_len;
82159ba8e6ef8c Mark Brown          2012-01-18  1853  		buf = kzalloc(len, GFP_KERNEL);
b83a313bf25201 Mark Brown          2011-05-11  1854  		if (!buf)
b83a313bf25201 Mark Brown          2011-05-11  1855  			return -ENOMEM;
b83a313bf25201 Mark Brown          2011-05-11  1856  
b83a313bf25201 Mark Brown          2011-05-11  1857  		memcpy(buf, map->work_buf, map->format.reg_bytes);
82159ba8e6ef8c Mark Brown          2012-01-18  1858  		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
82159ba8e6ef8c Mark Brown          2012-01-18  1859  		       val, val_len);
d77e745613680c Marek Vasut         2022-04-30  1860  		ret = map->write(map->bus_context, buf, len);
b83a313bf25201 Mark Brown          2011-05-11  1861  
b83a313bf25201 Mark Brown          2011-05-11  1862  		kfree(buf);
815806e39bf6f7 Elaine Zhang        2016-08-18  1863  	} else if (ret != 0 && !map->cache_bypass && map->format.parse_val) {
f0aa1ce6259eb6 Nikita Yushchenko   2016-09-22  1864  		/* regcache_drop_region() takes lock that we already have,
f0aa1ce6259eb6 Nikita Yushchenko   2016-09-22  1865  		 * thus call map->cache_ops->drop() directly
f0aa1ce6259eb6 Nikita Yushchenko   2016-09-22  1866  		 */
f0aa1ce6259eb6 Nikita Yushchenko   2016-09-22  1867  		if (map->cache_ops && map->cache_ops->drop)
f0aa1ce6259eb6 Nikita Yushchenko   2016-09-22  1868  			map->cache_ops->drop(map, reg, reg + 1);
b83a313bf25201 Mark Brown          2011-05-11  1869  	}
b83a313bf25201 Mark Brown          2011-05-11  1870  
c6b570d97c0e77 Philipp Zabel       2015-03-09  1871  	trace_regmap_hw_write_done(map, reg, val_len / map->format.val_bytes);
fb2736bbaee0e7 Mark Brown          2011-07-24  1872  
b83a313bf25201 Mark Brown          2011-05-11  1873  	return ret;
b83a313bf25201 Mark Brown          2011-05-11  1874  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

