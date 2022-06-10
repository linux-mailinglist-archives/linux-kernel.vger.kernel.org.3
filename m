Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A3545C34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbiFJG2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346436AbiFJG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:28:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290A239094
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:28:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A1HKaH015600;
        Fri, 10 Jun 2022 06:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3JOCe5rll9h1etmLNkJw5RVN4Ibwy/GJu+CfeNf0Q9U=;
 b=YzrzhTM5xqRXtHIc9LF9JaY/OUZCFjYvbJSAokXo7U6RMPGQpkU0S3d5jNI4+gs0LH11
 Az0Byklr+Tdi3B5Ivhd15TP86thi8Dzfc6VKWmtghkq6OMuUKhNYGaVWWOJCGccsw0/i
 v9ONHACa0X7sieyFH+IJrpCMzZzK+VAE57gNiQU3/Ib5Ltzgwxvqc8yGdmQeUq3kP+C6
 whWeUVxWWCCIeGSKIqtq60/15Iqvkv9bjjkRFUc2O22kmZ8Xo2my/m8JzHZjqDiAJlHX
 sAX4EZjpNpeuV7HetYijG0WUaZAwBrlrOiw8sjqwRDG/jeLH4RMXXOUCbygcmzwypnXe vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqvrn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 06:28:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25A6PXqh003532;
        Fri, 10 Jun 2022 06:28:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwucmjvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 06:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxOJm6LWqkrTtWa3s/cOnnyk34eQvOC94FfAjoIVUYATASda2Q4IKG/MssRKJc4Lc+tSwxpWGLfsfKAxtkONNinKHpYqk2kq/zsknOZOZbFHCrXTHElEgbbc9jgJvu92fA6cNO4RimHnEJvITvJSqlELCk4wFR1ZkwHk88KHPfgDKbmImxzR4kvQBW3vVYGF89lzm4a23qov9T6eLC6R0nZRDH/T8io9JAhbHXF4NQJkiTT28y2h15xC0yA/JzPwMlK/aEVpgin5YAkmKpejAq60CAptaEOs4xIvnqOEnj+n0wNArV8mPxv68FwW9x0jNisOu6z0Dtx9fDcAGpjQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JOCe5rll9h1etmLNkJw5RVN4Ibwy/GJu+CfeNf0Q9U=;
 b=fmLcDyKkmH4m89pdv/aFQuS8wkep8BBs3ZkEBr7OTdAeryDVad8B+ajduXzRVdhiKNnQGrUf3h7NLYbEPblFSLmXLPp9pMYZCp+IQ0BUUvBwhCANwJbtNCZS8iCWcwYfCwBTgtP4+ItUVAFaRcG08c5eyMoRR8k+K69RG5LhN34dI1Fs16fSfE3K9bjgj7pcDMwQCuexw/b0HwtN54HtJWH1oAbVvJHEIctJxEtedytZ7Pj42iM+ybPYAxTZ0LtVmHE2HKzv9PERmpoKSXnsAHW43hyZiCcv2SBSDe+mJnrPtNrkIZc8U+xPApV7sOXRTCRCdJhUI5CbBSCmzx4AdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JOCe5rll9h1etmLNkJw5RVN4Ibwy/GJu+CfeNf0Q9U=;
 b=omka0Vo+Vg+NC4xPnF9iX94pniZKprN9mzDgJ+4UcRuqM+8Ynx0c3F7KhcnRk0ToRxH/EKBbZ98ZbFW1oqE+q/i43UtfadeHnIpKFV8c6Ffpl5+Rbm0rsRSqETzPWe/bBY2xttU4UzLL0gajoQMSQJjSmBifC7m0JrA3XWzHxSQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3777.namprd10.prod.outlook.com
 (2603:10b6:a03:1b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 10 Jun
 2022 06:28:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 06:28:17 +0000
Date:   Fri, 10 Jun 2022 09:27:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stefan Roesch <shr@fb.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [fdmanana:misc-next 36/71] fs/btrfs/sysfs.c:811
 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'
Message-ID: <202206101159.fXYW8bYv-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b785117a-3f3c-4bd6-07b6-08da4aaa678d
X-MS-TrafficTypeDiagnostic: BY5PR10MB3777:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3777BCC6EEE00FCA19FE42FD8EA69@BY5PR10MB3777.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVRR5iOYAZAeiB4NoHT2NnzRNOa1fC3enmQ4IxRu+lVm6RiBkvdPH5y1Io+PDyyPlTTUxEkk9wdAbsYgscPFAsShRBF8HeMkmJHzsFmA3rFDzBiDpdhdxnH5kbw9iDUSoZgKX4xEVOvyIfNZZDtK1HR7LJfuXXGBGBP5H/ni1DNjbpYCQ02PiJ7UQItBtlQZAR5IjPGwyqW1ysw5xo6eVNmb0Z6XQxpGa7ZNvgKnsshTc6y5Z0fpccK81yoK57GcQ5IxxRZjy5tOODiN7vbRg9sd8XXhH0wi6WVc1U//8IjJHhTMfr9ZDX8jeMflF0lgDd7AHSbZfoEDoqHn1NjzlGqVpQByYcwBDnpucsn2waDOMgM2KhLI/JPT+sRCgftqJxXZtY0YW09UsYpIWdKOQaSa9OHBlbmDpHsiJlM5WAUyug8yVlwsdlg8qXtymVNMhC+LxdwAC1EjaD0hVc7Jmpi6lb3ASHaf06+Ppp+T3uMCUd101aAw8mkTtVPeoQpcwD5/qjJ0h0yVxGRSTwiQAEyZBNUI7jAruUo8rpZweccA2+AoZhwrDKjCADW2qKgqg7NxPUZVLlgVXJaSdUgjQBlexAFVMYZBLUqKHzl8Owin2QPJ0G2ojWjiEdqlWFMMHtg5mV6/zvOkRmoD60dl8Tw1o9xCyZoCd2b/vbvsQgk8SrONapE1lhHQy4STkQ9aJZtQc1b5+N/LcMav19ddpDWoY9QtDIv6tAFUxu3+wYQwVfsHN3qhkGg1+kDSN2CNEVQxvdPvAbWGI59p35OiEVn7Xs1FltvHXfuXJhcv8Nlb2t/s/XrLFJwmpjyLyclSaXXyfC2MgpbfCca6mvhVOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(8676002)(4326008)(66476007)(6916009)(1076003)(66556008)(86362001)(66946007)(186003)(38350700002)(38100700002)(6486002)(2906002)(508600001)(26005)(6512007)(9686003)(52116002)(6506007)(8936002)(6666004)(5660300002)(44832011)(36756003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NcpDmlrL10OU3reJ6eVv6jpzB/FI2YhP8GdwC2v4O72hjVsFuwNouy9SyunF?=
 =?us-ascii?Q?IMzl58YFqX+RNC21XIzgjAp0ksdUBwWG+F62V8q4kVf5zIaiT6NOhqW/9a82?=
 =?us-ascii?Q?u6hf/pw748NOgDOze3Eju+NXLCdt83GdkMfgmmN569HJOwpm+vhf78eZ/wqN?=
 =?us-ascii?Q?QXb0u7Lr5MTIAPNI5dXtjgthb9o5pKiHgQGM4+e9uJJinZGTwFrixupOSnkp?=
 =?us-ascii?Q?Ez8JMDz2OOV+BdArALfrYEqAR3wcKiIi/Lu9AdVZrZGpbbKyAaTa7MBh1r7U?=
 =?us-ascii?Q?s7FTsVBIK0IptPSxif4ZlnB4V+8bCFCi0WxEWAwgLM6qDZOeIqCRw2o7VkXq?=
 =?us-ascii?Q?DJiP1vQEq32NsAa+HOCAQa4hoKc7Y7dzdoyxzHM7IiiG/1OptKb2xpE9Li4u?=
 =?us-ascii?Q?4TtzyyH7McU+HSxkI/cKUTUE1o+WzpZgVEbor2MaQBN5RDPLsSO3qn4hGjgl?=
 =?us-ascii?Q?Oz3ggSesSKLMHpiwh3JqjEyhKy5kjJJER5ZLhzRngXqiEY3Tf98/3a1HpnMD?=
 =?us-ascii?Q?RqqxEdbvrE3qGqZ/11JQm5EL+GmX4WL1mNYj6kTyxT3a/xSGpX9wFdFGuhpz?=
 =?us-ascii?Q?qaJk89rqdSJvtsOlINNW+iQPd2kxXnmrUGLMc/yjZbtj8ICzN/rHMqQQ1U7j?=
 =?us-ascii?Q?6IbQACYzUDY8bDuF0jdsVecrGvUZMBOOPu6U3ULKCp0pRdGiFhEXiG/xOL9G?=
 =?us-ascii?Q?hBQ3M7M7UCiqSgsRGSlXWkNRGuIcK+A9ASOi9WxGMZB1Fr9NsEVICcfVQL0T?=
 =?us-ascii?Q?qaf4ITrKd2GQnkYtKaBs6p5rYi2aPVRm9um4fPaxMc+dFWQpYwQXHxc10Uc2?=
 =?us-ascii?Q?SXv6wPZi2LcVHFOQy9GzuyYPd8SvJtVbH6oIehMC4SYrgQjxtZs+kcSYyWY3?=
 =?us-ascii?Q?15u0z+i9iyCa1g7aYa7MiWYbHQgtT561ZE9dQu3UXiAdWdbgUFby8DjIUZjd?=
 =?us-ascii?Q?GYf0C0WRft2RP6YUBZNuOI56PN5JokLwAyknOKaq8sCQL5j+iNfLXnb1SE6f?=
 =?us-ascii?Q?n7kAzm9Syv+Y9CeHHL/hdWnmIVS8krPm92cyr7L32oHsXsZVk2XR7lCLU1MK?=
 =?us-ascii?Q?ojxeyP3/MAu2iJ5y85BSWlTdyJ0S6DBwCh+7YgNUOHhOKivYiuMSLkxOAwdR?=
 =?us-ascii?Q?vc/nvwgxNQAntKdCf2Nne7iGBy5lM3EImY8xlJnvOMpBa61Exm5Deln08VKL?=
 =?us-ascii?Q?zPRbWgrUzSU9gQHcgNRHrr9qoby2m+24jNYsHz5cDusSDJ9AWlISPOytXNBV?=
 =?us-ascii?Q?2UzhS2WJ+aTQlqyn5wnZM1r5KKf3QMH4xF+P5u565Ny9vwjlgq3J2E6XGYR8?=
 =?us-ascii?Q?odtJD8mZwN+BFlTa4BFCBJ6QJ2KOCNwZ/Iff1s0g9lz1N/K3xc4baWcAuHrc?=
 =?us-ascii?Q?6CgW2xjSYJ2cnoO1L3YDmZHndIKK8mbDXTqb4b5Vb+7/Xai77cZmGNPXpwqB?=
 =?us-ascii?Q?p22uKGMp+FvRV002YvC5pR/4h+61vQSTC2EVGzlWR7WKaW447Gyf5pW/5Lkx?=
 =?us-ascii?Q?MZrspT6PfArbCMCwcRRtyGejhgDruf6fPQ4WQp5hFHETZbDVmIU9p9Can0pN?=
 =?us-ascii?Q?uU/6KHwsvfGhkH5jOmdGiThNouNK4kf9T/XIIH9C9LFVDoxw2RgDu7yALtz/?=
 =?us-ascii?Q?6/m86XH/GpJ+nKvH965/zChDnBCMRMjThp3f2MkWDDCo+SRmqpUDF2jv4E9C?=
 =?us-ascii?Q?Rz1uKOo+MkjeBaagz8HM5Si2a9ditwCp4xyd2f9QvCfNIVm/2Jz149IiS3U9?=
 =?us-ascii?Q?hP2+yNog4DiM1PAI4ZrsaLjwm8GcYB4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b785117a-3f3c-4bd6-07b6-08da4aaa678d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 06:28:16.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gikBn01ohJLFTjilw4YKC6Cdxw9WMb8l/d+UB3Qd/JXNYmWiHI2shqTjmS6/rpYR+axaZ+D1jUdss9ujlNHkV3BEn1jB+PhLBRgIJLtLoi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3777
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-10_02:2022-06-09,2022-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100022
X-Proofpoint-GUID: xZsyz3UoKKEW885_xV6r5xdGjpXOz9B5
X-Proofpoint-ORIG-GUID: xZsyz3UoKKEW885_xV6r5xdGjpXOz9B5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git misc-next
head:   e2a46f3f73fd5aac0241242d535905286a947113
commit: 46e1bce0ac340396474e5f604c2acb6644175854 [36/71] btrfs: sysfs: add force_chunk_alloc trigger to force allocation
config: m68k-randconfig-m031-20220608 (https://download.01.org/0day-ci/archive/20220610/202206101159.fXYW8bYv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/btrfs/sysfs.c:811 btrfs_force_chunk_alloc_store() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +811 fs/btrfs/sysfs.c

46e1bce0ac3403 Stefan Roesch 2022-02-08  782  static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
46e1bce0ac3403 Stefan Roesch 2022-02-08  783  					     struct kobj_attribute *a,
46e1bce0ac3403 Stefan Roesch 2022-02-08  784  					     const char *buf, size_t len)
46e1bce0ac3403 Stefan Roesch 2022-02-08  785  {
46e1bce0ac3403 Stefan Roesch 2022-02-08  786  	struct btrfs_space_info *space_info = to_space_info(kobj);
46e1bce0ac3403 Stefan Roesch 2022-02-08  787  	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
46e1bce0ac3403 Stefan Roesch 2022-02-08  788  	struct btrfs_trans_handle *trans;
46e1bce0ac3403 Stefan Roesch 2022-02-08  789  	bool val;
46e1bce0ac3403 Stefan Roesch 2022-02-08  790  	int ret;
46e1bce0ac3403 Stefan Roesch 2022-02-08  791  
46e1bce0ac3403 Stefan Roesch 2022-02-08  792  	if (!capable(CAP_SYS_ADMIN))
46e1bce0ac3403 Stefan Roesch 2022-02-08  793  		return -EPERM;
46e1bce0ac3403 Stefan Roesch 2022-02-08  794  
46e1bce0ac3403 Stefan Roesch 2022-02-08  795  	if (sb_rdonly(fs_info->sb))
46e1bce0ac3403 Stefan Roesch 2022-02-08  796  		return -EROFS;
46e1bce0ac3403 Stefan Roesch 2022-02-08  797  
46e1bce0ac3403 Stefan Roesch 2022-02-08  798  	ret = kstrtobool(buf, &val);
46e1bce0ac3403 Stefan Roesch 2022-02-08  799  	if (ret)
46e1bce0ac3403 Stefan Roesch 2022-02-08  800  		return ret;
46e1bce0ac3403 Stefan Roesch 2022-02-08  801  
46e1bce0ac3403 Stefan Roesch 2022-02-08  802  	if (!val)
46e1bce0ac3403 Stefan Roesch 2022-02-08  803  		return -EINVAL;
46e1bce0ac3403 Stefan Roesch 2022-02-08  804  
46e1bce0ac3403 Stefan Roesch 2022-02-08  805  	/*
46e1bce0ac3403 Stefan Roesch 2022-02-08  806  	 * This is unsafe to be called from sysfs context and may cause
46e1bce0ac3403 Stefan Roesch 2022-02-08  807  	 * unexpected problems.
46e1bce0ac3403 Stefan Roesch 2022-02-08  808  	 */
46e1bce0ac3403 Stefan Roesch 2022-02-08  809  	trans = btrfs_start_transaction(fs_info->tree_root, 0);
46e1bce0ac3403 Stefan Roesch 2022-02-08  810  	if (!trans)
46e1bce0ac3403 Stefan Roesch 2022-02-08 @811  		return PTR_ERR(trans);

PTR_ERR(NULL) means success.

46e1bce0ac3403 Stefan Roesch 2022-02-08  812  	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
46e1bce0ac3403 Stefan Roesch 2022-02-08  813  	btrfs_end_transaction(trans);
46e1bce0ac3403 Stefan Roesch 2022-02-08  814  
46e1bce0ac3403 Stefan Roesch 2022-02-08  815  	if (ret == 1)
46e1bce0ac3403 Stefan Roesch 2022-02-08  816  		return len;
46e1bce0ac3403 Stefan Roesch 2022-02-08  817  
46e1bce0ac3403 Stefan Roesch 2022-02-08  818  	return -ENOSPC;
46e1bce0ac3403 Stefan Roesch 2022-02-08  819  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

