Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D081520697
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiEIVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiEIVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:25:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5382BAE51
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:21:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2498qxHi021122;
        Mon, 9 May 2022 10:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=l86XhvZd5ocwlBFDDNKofPO0d0fmxaJUfkF9jgaUzCM=;
 b=ToGKCTr8Y9wIumeiDnQVD8Z48I1VhQJEeHgyYeSMjch+X1g9oVIpUWF6bQ2wpAg4oaoe
 l7m0/Z18ZFDIbz0KiRGiV/6LpGcNSiUffKVyCIos1t3jgiq5/a+JYbLUYXvd94OWvDUu
 HbNZAOkp6D6DE6jxpNB0pExbgZLie3z5YF5ZBdkaxCMj4mXRx15mRo52yzs7A4zox8lz
 XjDdQ6l8W72ZSRMY8L8yYxGTJkWfovVAjW7TR805Mr5aQfggiLOmBOtZ0SJfM/YSYruo
 OcDDdy0AzgH1ACTqiCwcecIe+w4dBiJK1FcvgJeoVKVFitc4uiZulQZ26tfaVOYQ7De8 qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2b0bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 10:09:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249A73mI038897;
        Mon, 9 May 2022 10:08:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf71c3nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 10:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csS0NW1gOk6nMTJFhswKqh+fnmxXafri1twVYvJQH8OR6j9NjkM8h4pUr9BfQFP0Ts92cXLlb2BezBZJCA/AGfE5cQ2IVg2OLgb3WItWS6Q9Qb9+YgzirJ9bemecnYTX1MsOoqVepDfHj+Rv3Xhbr5ZhPQgfL7IEJw8evDFE3mk5ESGM9EhlSqtFnXUub2wsQ0mJBx4pCRC4Yovd4CmP9LXEB6NNcq64+WPz8Q0ijfdL1c+Mr3X/hLfzpnSEizeaukT9Hmc3uEt5Z6CzjRkiKCP5J88CUzjxAgx2cCr8OgU8jx2WWkqhDIdPjo2pYjRf6rzBlFhpleKKt9V5PlDAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l86XhvZd5ocwlBFDDNKofPO0d0fmxaJUfkF9jgaUzCM=;
 b=Rw5FC3361Gz31gSyAxQz7iPSxrO8DC6QFSnpiadtOQg9z1L9lXuP6cIOYjCI3fPMQkdFPG0+7dLesfx0p/01S7aRbLaMzz7zu/3D9oGIFf8cFStYWs2hZ2i4BCuZ5vUWXxdyMGkf2dBzYn1xfyoXDgaiJpPK50CnQs45qJPvnOVL3tO+3ivuWxxEFTtHO2UGpr5VmsMs5I/3EtptAca+CDSMKXGYVQe1GboCGExtT/mC9NAT+OT+XrdGZJaMAVZ+VXot3trda1SGEHle2rZ7t6gqPvP6qDkRDc8tLwOcGJBJwqANAykb5yypDNnSKxC1XjEYHr4JmX9PV9xHrVvOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l86XhvZd5ocwlBFDDNKofPO0d0fmxaJUfkF9jgaUzCM=;
 b=KbZS/iVBX3ZAYRnY5hWOzBJ0r0XGKKRjRNCRA2qi5EsFCPziOj4Uxu33on+NMh7A5H1cd3J5ViiIHxYf2aFBK2vyz16nrI2Fc1X1HriyTW6bUlEb7PaTmRb6wJdT38omP6i5t6hz1Orah18ztntdk3raFp+IRDBOwhE1BjMUclA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2181.namprd10.prod.outlook.com
 (2603:10b6:910:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 10:08:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 10:08:57 +0000
Date:   Mon, 9 May 2022 13:08:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Amir Goldstein <amir73il@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [amir73il:fsnotify-fixes 2/2] fs/notify/fsnotify.c:540 fsnotify()
 warn: variable dereferenced before check 'dir1' (see line 499)
Message-ID: <202205080346.m0fb3UXK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6adc060b-34a4-4312-91b9-08da31a3edfb
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2181:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2181F06B5D9EBF67E816C4D18EC69@CY4PR1001MB2181.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MhNE3dphf/JyFkwlrNc2Evbw1pcEmmhq+POeME/CM7ZhJBUjQdjnCs38DLX2xDNIQBSNNEUnEDEm3z7afJ8h9u0vGnZtknaOS3mgpKhARjGUYQS02+rHN7RVQwjKXS+pLtQ9vkXCQ5cIMdLafsy66dUqRdiBpXQutOrqXQ/ghE72p375LevmZCRvpYoeOcC5m1LhHSPTmjCHATc5sJ4HuSNck9FNINbuc+E72zggwllfTQQcnmRyDk1GLSM++UHNqyCBAFrKFBZCS5Zld9Qekr05p6bkasQo+ijg8i+uQrB8SUqmhqIzdvKLSfsnISe+d8mNOLdy8aeG5zg8ghRDdggK7yQfQoMPgh4S+MjMmWB+cvHLMIvOYmU3LZKZIx7qtwkx1lGpGrdhOuLpkqz4TPufq5KldhSh92rxcAAzL4t2eDlyBZoCndHjhtCyvdZ27UMI1YJc5QpKAiHIW6zIo9vb202dtp/aEM5tDoPyfoVX2oBjq2aGV98Fp70cq3AWk6Lk21GY4NuEYUyh3UhvMENHt5cY9Ft45jo9IwApsViV1b8yDAs8ImMkjm7lIqQnhEwOjjAJ1o1BHhhI0QDd59eiQYKGuRkWtU3RkCnBoBoVHeUlAXRL1G7Zw8hXHQzbVfyHB8Ed2sp+AG4T1mH7eYnJpYrMk1BDVByplKPgi66nsRytEl9uO2c39tbKpCiYXNsG0akyUjimeUE/rtkRuNNhcRiJMf9fIkOSJtn/ByneoqGSMnto5KpWvo8KKn/XOq9QWLDewl5PfLSdPg3blAlVpMOWhMvEP7epcEYcUNalZ9MZU0TgHPTtRjrLM0RJldD4GaoXVs2QZlhqRHS/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(66476007)(8676002)(66946007)(66556008)(83380400001)(508600001)(186003)(4326008)(6666004)(966005)(86362001)(6486002)(6512007)(9686003)(26005)(316002)(6506007)(52116002)(6916009)(8936002)(4001150100001)(36756003)(2906002)(44832011)(5660300002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXxp/5vw/pAk+j72RZ9H0FrlBJrYvfBBNO+3y1df+hmCc2NcoKnMwFYZLKBo?=
 =?us-ascii?Q?2Jz/Ck1xo66SOTgmr1z/Ljwfu0RuYdVpWF6480FuUFdjV40XBxAue88lhFWw?=
 =?us-ascii?Q?HTOhnPKapksa61d8TREAyBMLNnrfw2yZWaBmQQjwRNmoEY+VB/TVKlBTthL1?=
 =?us-ascii?Q?6jFMdXUYND1S58udTGIvyCfIlm3BpXxUMRn4NvxHfV3iAFBgATnMyR1RwR5T?=
 =?us-ascii?Q?YnfRfWnraqxEgHEo+eNkReyiVcAH6TQZeHSgAZVbVIH8havn8DoEgzijMno8?=
 =?us-ascii?Q?VVo8x9Zk2b5X858+s9LUq0yspJGxyNCR+wcnMquuJsshQNjXwBxgqsS9kW/d?=
 =?us-ascii?Q?u6ziv9r7ApKsVtag5MdZPC5q9r+deaEHlL4qaes5T7OO1zDnxnstQJSrNuId?=
 =?us-ascii?Q?vUj/3vlGEF8YglsTfQWZCkudxNJdks48hHhFoHpZuatg6xk1C241tlNZDYJ3?=
 =?us-ascii?Q?BuEPg0uSnbJFSCnq1T395+np+dVy8jK8AFiQ+1HAHZ5lYJ8W0L9vpesfwBfQ?=
 =?us-ascii?Q?mDdbUm+ElAwovYY5M7kktsqMt8FmJrpchPcU60W6vHuOL1JJasrg0oUIEZpo?=
 =?us-ascii?Q?P5TUBNfTJlNpubfZlTWgHMp90cAQbB7KHq/Pw3kHPf3lcIGeFcnlOi2K1XMp?=
 =?us-ascii?Q?s34IXUd8KPuzyVTMpPnLb9CUr/PJUUVCKUB+9h8j2YCONZb7NxbLQ8TVghSt?=
 =?us-ascii?Q?86jiQfWvcY5IVDpHFnIF35IWqJ8Txx2G8fsxnGGPgxV0QwFwNvwZ6MW8KKqL?=
 =?us-ascii?Q?kMnTOrvzJyX4xi36xDHrcmagQx9uJClJ38g9oUVDYlaEz4Jhj5w/hkxBPAw2?=
 =?us-ascii?Q?qMmiAJ7WHc9MvR8DdwGXk8dGImTWSZfgVbd+J4dlCX42jSZtzsi66QzFXSev?=
 =?us-ascii?Q?UnA3UzU+jEEAOennlk2nZ4BfN37zJVyrwNpP3JKF/Jkcf5EEwQeoZxMbqHxf?=
 =?us-ascii?Q?AimT1FGyMe6rZCumgQPTEKrG+5MefE/Y7bi69UHjiZNYt/7sSoxWNHHzRBfT?=
 =?us-ascii?Q?bd1LFG7wINHYq2WFKlfHlcAb/UKorn6Lo74QQ1jaykqsPP/wiMOAUlqA6iSe?=
 =?us-ascii?Q?gqbztifr3kKkOFs657ncctkwdc+uETcDTdTIuSrM59sW/OpErRPrnZlTh6JK?=
 =?us-ascii?Q?085ZMUz8wNvCBKSC80BsitQ22tkrPHmSMHeiecHmCsRS/qu61yYHMBjaJXV4?=
 =?us-ascii?Q?q075qiMYzLhK4i1s6/K1kvTmAfpWbdJx9RX/m2eukRG0MPw2Q7A+K/u1vusc?=
 =?us-ascii?Q?sA2ec8Tw12DAY8D74J8B6IibhKvs6gHTb94hcgDLVM8cs1nRWZPhvm3aciI3?=
 =?us-ascii?Q?ei7QA60mJBSjDTVEpF9LXd0ZMMNArUmA78ozrfS8m/bxzySy9BuKYpOGcah0?=
 =?us-ascii?Q?TxrCI4jFOrJFCBuI1vUn4wcNjXv83Ni3iPe3GrR8OKI5fRDeKNmaIuZhkJDI?=
 =?us-ascii?Q?wkCZXPowQVVaM6nL3Qt9gGvq6NembciCdIkl/Uz3pCNDLRNQ61R5tDpvu5kJ?=
 =?us-ascii?Q?qhmmXq1pkHjKpLZeZZ8mm2+4RCFxt4gYhnqmRTPKJc2QyJe2GG5iJjQGopOF?=
 =?us-ascii?Q?ee5c0tSHms/9biEJm8+fBhCpssj8s+PGVhGKQTxoxy388rPzo3EWbSWe+JN7?=
 =?us-ascii?Q?WKEVzew0B4tEu9406/fCUypqTyZsIxk9i5spqN028chMi/1NykSZ2ineKzDE?=
 =?us-ascii?Q?TMVhaYElA+4hhOUf/10t1AE7Kyx/ehFc1uubLKQ9s4OuTs2oVp5hamQWX+4r?=
 =?us-ascii?Q?IHDQN6MKZzXSiT4PVA2HBDty/jZB3t0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc060b-34a4-4312-91b9-08da31a3edfb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 10:08:57.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TG7Z+EdZtu3rRJQ83PfQL7vzA0DGS6Da4mP+9neCFdAnzjUn1KcXHVFGvMSoIHxIJ4eRp+lbib1D9Rm2U3PH/AE63ZtF9quIFaNLrUq2pcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2181
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_03:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090058
X-Proofpoint-ORIG-GUID: _cnGH4RUgZ8rOCt_Pv5a6B7WFJpO2ZPW
X-Proofpoint-GUID: _cnGH4RUgZ8rOCt_Pv5a6B7WFJpO2ZPW
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fsnotify-fixes
head:   d25f3ce8da49ce1a3b0a0621f0bf7b1d6ba2dad6
commit: d25f3ce8da49ce1a3b0a0621f0bf7b1d6ba2dad6 [2/2] fsnotify: send FS_RENAME to groups watching the moved inode
config: s390-randconfig-m031-20220508 (https://download.01.org/0day-ci/archive/20220508/202205080346.m0fb3UXK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/notify/fsnotify.c:540 fsnotify() warn: variable dereferenced before check 'dir1' (see line 499)

vim +/dir1 +540 fs/notify/fsnotify.c

40a100d3adc1ad Amir Goldstein          2020-07-22  475  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
40a100d3adc1ad Amir Goldstein          2020-07-22  476  	     const struct qstr *file_name, struct inode *inode, u32 cookie)
90586523eb4b34 Eric Paris              2009-05-21  477  {
b54cecf5e2293d Amir Goldstein          2020-06-07  478  	const struct path *path = fsnotify_data_path(data, data_type);
29335033c574a1 Gabriel Krisman Bertazi 2021-10-25  479  	struct super_block *sb = fsnotify_data_sb(data, data_type);
3427ce71554123 Miklos Szeredi          2017-10-30  480  	struct fsnotify_iter_info iter_info = {};
60f7ed8c7c4d06 Amir Goldstein          2018-09-01  481  	struct mount *mnt = NULL;
d25f3ce8da49ce Amir Goldstein          2022-05-07  482  	struct inode *dir1, *dir2;
e54183fa7047c1 Amir Goldstein          2021-11-29  483  	struct dentry *moved;
d25f3ce8da49ce Amir Goldstein          2022-05-07  484  	int dir1_type = 0;
9385a84d7e1f65 Jan Kara                2016-11-10  485  	int ret = 0;
71d734103edfa2 Mel Gorman              2020-07-08  486  	__u32 test_mask, marks_mask;
90586523eb4b34 Eric Paris              2009-05-21  487  
71d734103edfa2 Mel Gorman              2020-07-08  488  	if (path)
aa93bdc5500cc9 Amir Goldstein          2020-03-19  489  		mnt = real_mount(path->mnt);
3a9fb89f4cd04c Eric Paris              2009-12-17  490  
40a100d3adc1ad Amir Goldstein          2020-07-22  491  	if (!inode) {
40a100d3adc1ad Amir Goldstein          2020-07-22  492  		/* Dirent event - report on TYPE_INODE to dir */
40a100d3adc1ad Amir Goldstein          2020-07-22  493  		inode = dir;
d25f3ce8da49ce Amir Goldstein          2022-05-07  494  	} else if (mask & FS_RENAME) {
d25f3ce8da49ce Amir Goldstein          2022-05-07  495  		/* For FS_RENAME, dir1 is old_dir and dir2 is new_dir */
e54183fa7047c1 Amir Goldstein          2021-11-29  496  		moved = fsnotify_data_dentry(data, data_type);
d25f3ce8da49ce Amir Goldstein          2022-05-07  497  		dir1 = moved->d_parent->d_inode;
d25f3ce8da49ce Amir Goldstein          2022-05-07  498  		dir2 = dir;
d25f3ce8da49ce Amir Goldstein          2022-05-07 @499  		if (dir1->i_fsnotify_marks || dir2->i_fsnotify_marks)
                                                                            ^^^^^^^^^^^^^^^^^^^^^^
Dereference

d25f3ce8da49ce Amir Goldstein          2022-05-07  500  			dir1_type = FSNOTIFY_ITER_TYPE_OLD_DIR;
d25f3ce8da49ce Amir Goldstein          2022-05-07  501  		/*
d25f3ce8da49ce Amir Goldstein          2022-05-07  502  		 * Send FS_RENAME to groups watching the moved inode itself
d25f3ce8da49ce Amir Goldstein          2022-05-07  503  		 * only if the moved inode is a non-dir.
d25f3ce8da49ce Amir Goldstein          2022-05-07  504  		 * Sending FS_RENAME to a moved watched directory would be
d25f3ce8da49ce Amir Goldstein          2022-05-07  505  		 * confusing and FS_MOVE_SELF provided enough information to
d25f3ce8da49ce Amir Goldstein          2022-05-07  506  		 * track the movements of a watched directory.
d25f3ce8da49ce Amir Goldstein          2022-05-07  507  		 */
d25f3ce8da49ce Amir Goldstein          2022-05-07  508  		if (mask & FS_ISDIR)
d25f3ce8da49ce Amir Goldstein          2022-05-07  509  			inode = NULL;
40a100d3adc1ad Amir Goldstein          2020-07-22  510  	} else if (mask & FS_EVENT_ON_CHILD) {
40a100d3adc1ad Amir Goldstein          2020-07-22  511  		/*
fecc4559780d52 Amir Goldstein          2020-12-02  512  		 * Event on child - report on TYPE_PARENT to dir if it is
fecc4559780d52 Amir Goldstein          2020-12-02  513  		 * watching children and on TYPE_INODE to child.
40a100d3adc1ad Amir Goldstein          2020-07-22  514  		 */
d25f3ce8da49ce Amir Goldstein          2022-05-07  515  		dir1 = dir;
d25f3ce8da49ce Amir Goldstein          2022-05-07  516  		dir2 = NULL;
d25f3ce8da49ce Amir Goldstein          2022-05-07  517  		if (dir1->i_fsnotify_marks)
                                                                            ^^^^^^^^^^^^^^^^^^^^^^
Dereference

d25f3ce8da49ce Amir Goldstein          2022-05-07  518  			dir1_type = FSNOTIFY_ITER_TYPE_PARENT;
40a100d3adc1ad Amir Goldstein          2020-07-22  519  	}
497b0c5a7c0688 Amir Goldstein          2020-07-16  520  
7c49b8616460eb Dave Hansen             2015-09-04  521  	/*
7c49b8616460eb Dave Hansen             2015-09-04  522  	 * Optimization: srcu_read_lock() has a memory barrier which can
7c49b8616460eb Dave Hansen             2015-09-04  523  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
7c49b8616460eb Dave Hansen             2015-09-04  524  	 * However, if we do not walk the lists, we do not have to do
7c49b8616460eb Dave Hansen             2015-09-04  525  	 * SRCU because we have no references to any objects and do not
7c49b8616460eb Dave Hansen             2015-09-04  526  	 * need SRCU to keep them "alive".
7c49b8616460eb Dave Hansen             2015-09-04  527  	 */
9b93f33105f5f9 Amir Goldstein          2020-07-16  528  	if (!sb->s_fsnotify_marks &&
497b0c5a7c0688 Amir Goldstein          2020-07-16  529  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
9b93f33105f5f9 Amir Goldstein          2020-07-16  530  	    (!inode || !inode->i_fsnotify_marks) &&
d25f3ce8da49ce Amir Goldstein          2022-05-07  531  	    !dir1_type)
7c49b8616460eb Dave Hansen             2015-09-04  532  		return 0;
71d734103edfa2 Mel Gorman              2020-07-08  533  
9b93f33105f5f9 Amir Goldstein          2020-07-16  534  	marks_mask = sb->s_fsnotify_mask;
71d734103edfa2 Mel Gorman              2020-07-08  535  	if (mnt)
71d734103edfa2 Mel Gorman              2020-07-08  536  		marks_mask |= mnt->mnt_fsnotify_mask;
9b93f33105f5f9 Amir Goldstein          2020-07-16  537  	if (inode)
9b93f33105f5f9 Amir Goldstein          2020-07-16  538  		marks_mask |= inode->i_fsnotify_mask;
d25f3ce8da49ce Amir Goldstein          2022-05-07  539  	if (dir1_type) {
d25f3ce8da49ce Amir Goldstein          2022-05-07 @540  		if (dir1)

If "dir1_type" is set then we have already dereferenced "dir1".  I guess
this unnecessary NULL check is something that probably wouldn't bother
a human reader too much...

d25f3ce8da49ce Amir Goldstein          2022-05-07  541  			marks_mask |= dir1->i_fsnotify_mask;
d25f3ce8da49ce Amir Goldstein          2022-05-07  542  		if (dir2)
d25f3ce8da49ce Amir Goldstein          2022-05-07  543  			marks_mask |= dir2->i_fsnotify_mask;
d25f3ce8da49ce Amir Goldstein          2022-05-07  544  	}
497b0c5a7c0688 Amir Goldstein          2020-07-16  545  
71d734103edfa2 Mel Gorman              2020-07-08  546  
613a807fe7c793 Eric Paris              2010-07-28  547  	/*
04e317ba72d079 Amir Goldstein          2022-02-23  548  	 * If this is a modify event we may need to clear some ignored masks.
04e317ba72d079 Amir Goldstein          2022-02-23  549  	 * In that case, the object with ignored masks will have the FS_MODIFY
04e317ba72d079 Amir Goldstein          2022-02-23  550  	 * event in its mask.
04e317ba72d079 Amir Goldstein          2022-02-23  551  	 * Otherwise, return if none of the marks care about this type of event.
613a807fe7c793 Eric Paris              2010-07-28  552  	 */
71d734103edfa2 Mel Gorman              2020-07-08  553  	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
04e317ba72d079 Amir Goldstein          2022-02-23  554  	if (!(test_mask & marks_mask))
613a807fe7c793 Eric Paris              2010-07-28  555  		return 0;
75c1be487a690d Eric Paris              2010-07-28  556  
9385a84d7e1f65 Jan Kara                2016-11-10  557  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
75c1be487a690d Eric Paris              2010-07-28  558  
1c9007d62bea6f Amir Goldstein          2021-11-29  559  	iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
45a9fb3725d886 Amir Goldstein          2019-01-10  560  		fsnotify_first_mark(&sb->s_fsnotify_marks);
9bdda4e9cf2dce Amir Goldstein          2018-09-01  561  	if (mnt) {
1c9007d62bea6f Amir Goldstein          2021-11-29  562  		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
3427ce71554123 Miklos Szeredi          2017-10-30  563  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
7131485a93679f Eric Paris              2009-12-17  564  	}
9b93f33105f5f9 Amir Goldstein          2020-07-16  565  	if (inode) {
1c9007d62bea6f Amir Goldstein          2021-11-29  566  		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
9b93f33105f5f9 Amir Goldstein          2020-07-16  567  			fsnotify_first_mark(&inode->i_fsnotify_marks);
9b93f33105f5f9 Amir Goldstein          2020-07-16  568  	}
d25f3ce8da49ce Amir Goldstein          2022-05-07  569  	if (dir1_type) {
d25f3ce8da49ce Amir Goldstein          2022-05-07  570  		if (dir1)
d25f3ce8da49ce Amir Goldstein          2022-05-07  571  			iter_info.marks[dir1_type] =
d25f3ce8da49ce Amir Goldstein          2022-05-07  572  				fsnotify_first_mark(&dir1->i_fsnotify_marks);
d25f3ce8da49ce Amir Goldstein          2022-05-07  573  		if (dir2)
d25f3ce8da49ce Amir Goldstein          2022-05-07  574  			iter_info.marks[FSNOTIFY_ITER_TYPE_NEW_DIR] =
d25f3ce8da49ce Amir Goldstein          2022-05-07  575  				fsnotify_first_mark(&dir2->i_fsnotify_marks);
497b0c5a7c0688 Amir Goldstein          2020-07-16  576  	}
75c1be487a690d Eric Paris              2010-07-28  577  
8edc6e1688fc8f Jan Kara                2014-11-13  578  	/*
60f7ed8c7c4d06 Amir Goldstein          2018-09-01  579  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
60f7ed8c7c4d06 Amir Goldstein          2018-09-01  580  	 * ignore masks are properly reflected for mount/sb mark notifications.
8edc6e1688fc8f Jan Kara                2014-11-13  581  	 * That's why this traversal is so complicated...
8edc6e1688fc8f Jan Kara                2014-11-13  582  	 */
d9a6f30bb89309 Amir Goldstein          2018-04-20  583  	while (fsnotify_iter_select_report_types(&iter_info)) {
b54cecf5e2293d Amir Goldstein          2020-06-07  584  		ret = send_to_group(mask, data, data_type, dir, file_name,
b54cecf5e2293d Amir Goldstein          2020-06-07  585  				    cookie, &iter_info);
613a807fe7c793 Eric Paris              2010-07-28  586  
ff8bcbd03da881 Eric Paris              2010-10-28  587  		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
ff8bcbd03da881 Eric Paris              2010-10-28  588  			goto out;
ff8bcbd03da881 Eric Paris              2010-10-28  589  
d9a6f30bb89309 Amir Goldstein          2018-04-20  590  		fsnotify_iter_next(&iter_info);
90586523eb4b34 Eric Paris              2009-05-21  591  	}
ff8bcbd03da881 Eric Paris              2010-10-28  592  	ret = 0;
ff8bcbd03da881 Eric Paris              2010-10-28  593  out:
9385a84d7e1f65 Jan Kara                2016-11-10  594  	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
c4ec54b40d33f8 Eric Paris              2009-12-17  595  
98b5c10d320adf Jean-Christophe Dubois  2010-03-23  596  	return ret;
90586523eb4b34 Eric Paris              2009-05-21  597  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

