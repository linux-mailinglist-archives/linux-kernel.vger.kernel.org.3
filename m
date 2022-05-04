Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92888519C58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbiEDJ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiEDJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FD27FF4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2449a9Eq026114;
        Wed, 4 May 2022 09:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=gHrEYQp7oT8c3Np1gwixkAJ3bcrIo7+nRe3/vlnp95AyHxDrV/ECq5HYE8kVFCAf9tqh
 2cpjLCgmRjWKwJJ9xq/78UOIKe/89E9vAjMu1+oSHbUO1A03MYoYtnyucFFZYqx+6auJ
 bgPl6d4ZsqxJ1fFMdWOZPdWxBRJj2+NFG7UFtJPv2CBWP3or3mVDeLE3IV0HFOpxp0b1
 9Hilo/YzU+/5R0gn3uzMCOQsOea2kweMM85vRJJWxaX49hFopa8GhI4kFk652JAcZM5V
 Qwljn2pOQaLqAYJShDUPIclu9r1Ev5P8MybvZOeXlx4i5K9bn3C14dby1quPDBb69Ijd tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7uyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449kVg6025215;
        Wed, 4 May 2022 09:51:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9t30d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrRgwkU53bO/B6hDX9NH/8ha91yO/LqZ7MvkaAGUYmKekL+go/9sruFZDRgebKaSKr1aOmwsYOJMpgtgSpHuUO/lYPSn19kEG7DYuCuJ6wuxOvtyGeFTn9cci9+mYTg8ZI4ajrxrmOBD4B1M0g04DNq2vf8thM89rvci1XoJdq0vO5uoTlceVpsISkF04F4pSqXdzkM17Q97d1IARqT9rMGeG8epztCWJHrhDtgehkrFxRyqiArWCTH/zcryfKO2v8vm/ulXL6A5J0dYBN3V4x/XGEeG2mnyBonsgkKu6b1/gi0JXW0leUhOJdcMwVaFz5MDneEkdf5bNDvsF2jEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=W9AZaO3fNCAzhCCLa6PrhskZ6YleVQDT1HjYOITBBTgQ82wVdRLPYlYzM5jVAxAQd68h/Esg4jg3YBz62jBBuGsA+jF6iiLnOat3y7U30p8JKFGa5xBgMkFvAkgxYa476c04t8Bx1jBuRAq9MjtzfUpgyM9Tr+bh6OQSFjcun5QiCc14jhybO62pfZpXWQQuyMIUK+AHG/haqxTuh9Axf1Nmom2hvA9mEoQ8ZJRXD8XYK5JVcrvblyodqQa4Vv9BytNPMnKT3ys10tv5SQFfIIGIrPkf9aNnWiAh/4puF2vP9iKb+hISNuzWe/6lblCp8VzaB/KIaucsDnlR1ep9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=vylleIDlm/Lr12hYUVAavsLI2FcaseSr2VzdO4SXOEg9NFiEbggszm8kYvdaKaJU6nOkIL5nNRYyPKhS6xWrdXPhaL7MsDIYlle5Ek9iBmvB9T9jGO4avEjqtE+T+e+muWBPCfNv99EW/bWnRFq2VnyCkNobU4DGnU422A6uVso=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 09:51:50 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:50 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Wed,  4 May 2022 19:51:23 +1000
Message-Id: <20220504095123.295859-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504095123.295859-1-imran.f.khan@oracle.com>
References: <20220504095123.295859-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0203.ausprd01.prod.outlook.com
 (2603:10c6:10:16::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16505ffa-a799-431f-85b9-08da2db3b5e5
X-MS-TrafficTypeDiagnostic: BLAPR10MB4899:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4899E76F7106A7FCCDA60C45B0C39@BLAPR10MB4899.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUM1HcB36c3KdDcxLWo3265cvcQ+hjF9uhPKvm2t3JLTBgUUxBYg87JfqhTMbX+88wGvQOGz2/UQL28448Ov94d8jwoyjpWi5ehx1tlrVkW7F51Kr4MTziL5Jd8XLcZzPi7C13lDlZHIBVXki7o+HN7bnHsqWd4FJiotX+GzCHxvll69d/e49pZocnBV+xvzG5JAnLvUHgsFFo+9pf7K+vWJWhlD0xcQQTFKZeJyGrtamrmZ6BAKnyf9hU4IUmFEWD+AutAv/un4wygo+j701Z1ME9weEz5XYbVwWut4bVZW1cp41UBge6ZF7esw6lN594pr9o4hRvOjo2L56rRHoXnzxODcJsCtjGXioK/QcPSPUOhWGzzD9gxYAPbAJL3AZ+6ho6qounFH5EJsBwJ2wO8JijjDMZbMVVm1/6NqY/ZTlCaB5wr9ms5LiiKN8I/v5/EIthzaLOQ1k+fT0ykPtomz9dQwoYy2hz6RzKSBFV7KjarJX365qcnhWSJTZc+32TQihe2HkAwO6fGSdYkaViY9LZTUEcd2eCZfHO1yOux5JCzCQKx997bKKj2eHPa7PLKZwfKD+fh998vOjkd1mOJxpp29TKz2h57QbOak4w4kUbj18T2X+vtm0BazbqDGE2dhz24ycmXC7DcBpSlsBc4Quacj70IdSfcGrC9qEXRTt4pZh5L6SA+SRUH+sK2X5FaMSgvPbn3zrEJuUGi+HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(26005)(316002)(66476007)(6512007)(52116002)(86362001)(66556008)(8676002)(4326008)(186003)(1076003)(2616005)(6666004)(36756003)(6486002)(38350700002)(508600001)(38100700002)(6506007)(2906002)(103116003)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuCRMAcC330IPTGmg5XLEp1cq2Ezjk8g+LNz359gAcoyXJJC9V2+2RZfCCYX?=
 =?us-ascii?Q?82Odlmb2+ZtiwG/huOhJxRb8fIPCn7eqK24fDZn/TtWMNA7PqK9bfMqfFiHN?=
 =?us-ascii?Q?stz85/LFEre9jGbJTbW0Ppe8o4jPAG3AodJzyUmASSMxVESY37eh4+ct9Kuc?=
 =?us-ascii?Q?wclC6ubleNh/Wr8cGJz+jFN6yoRSYFE0rNDv84Hty9/HvvVEawKuGe8vzHby?=
 =?us-ascii?Q?buTY0U2Q6f0G40BXlQhy06loixIJ1VC8E+kZE3P6erTSbYbCHSXzI0eOzNgG?=
 =?us-ascii?Q?hjgk10NDJyPUGCaK2DHVXaBIIls8icaCSkuN87iSE8o2PH+e3m6x+EMB4//B?=
 =?us-ascii?Q?243HrzY59F9M6ACLd9mtoJHXyGWf0ATk+VzzBgzEjYOPNBwjvTPsJxxXNq2z?=
 =?us-ascii?Q?wKc171ibECLCBI5lHhAXZ9U4juWRZpGvq05OpqCH7UJWn7gUJ8bcrwCYUdDb?=
 =?us-ascii?Q?Uznk7ZBcrkL2rL50K2kylVKlbAIPTmwIdM/JRadeVZoIfn0elTbPQyuWkEEK?=
 =?us-ascii?Q?7GmGkSWsvvlIAW9sK3b2KPyaMPE7VqSZihSaJGLQ2OoG25qddRhXMIJQgx0X?=
 =?us-ascii?Q?1rPeEuMOdv+A0ba0+fPw8VUgdyURMgtImKNSHcFjMK6W484D1I2cN0m0Fe2R?=
 =?us-ascii?Q?eEGzmTKHdiKIcufC5t1a9ZjkrLdWegyae679zhGJD5eCrWNDifzLTeubqDEZ?=
 =?us-ascii?Q?g11HNjD+6DIHw2gu90Yu3hEM9h42XftzUzOTBudWIqc8YM69z+CYppEtsZBE?=
 =?us-ascii?Q?wvazkfAfWQnQ1zM2C9KSRhNqCyRS3KJBKkciyrNXWWX6tufUzQtaYqXEXtQC?=
 =?us-ascii?Q?8H2ufYnjI+l/K+UwqjeyC3HzeMJKX0qTsPRVh8JnMo8xMJ+Sr0LhYWcs5taQ?=
 =?us-ascii?Q?/Nidc29dWToJEPtgGzdIEtz1VDuS2urN9NdoNfGWSjbA77yy3nK5A8pPaGUC?=
 =?us-ascii?Q?/hOXJJ/h54rqZLkXFOP0TQLCh+uBMoBtlzOhv2MpfKj6LChtgQp14WV+Dm8K?=
 =?us-ascii?Q?xMxmn2mepeMwl9CJy7J5MPh0TpD7SfBS932DCB4WiPrQUv3xxGK0p5ln4Z2l?=
 =?us-ascii?Q?pLLMpJpqS2tlOdQdJL2ROPN+S14kqjqsm3jGPm7qARd1vTb/vh39bGytkdP0?=
 =?us-ascii?Q?7i84WUFobrffjhuONAEOxszIpOlcWUdcm7bGQP2R507WFalvSj6Yy2EXIEJA?=
 =?us-ascii?Q?X6NjJ4k33RzNcCRDQkFDJzXa1Ugutu/pduadY8V7i67Y7Lamc+pxLybhHS/j?=
 =?us-ascii?Q?2TfGM9jUsfxWTGfTQObDxmnJkHi085zhY0xAo+V4aVs5/+As+qQYxh9kN0x2?=
 =?us-ascii?Q?o+SMECRVwgPEao1FtpN0wBBc4aGm/sews4CmB1m0YTxDWja7cnxXN/nLriTf?=
 =?us-ascii?Q?GmDMLAj/uLKoBLTRzzF1W2IsAVlHXEHSvi/md74D9PZNF9G0Gxv/s8BTftc1?=
 =?us-ascii?Q?fSglcAnzV1sscoLJxYloe8jM07OzEcVThRBIFg08fCV0E4ZCIq4s1rK/0nfv?=
 =?us-ascii?Q?eYX4EvEWjqTJ4XJrVP7DwTwTetuNrxt3unpsZ1JKUdOIGcjLRfYLebkEIqdY?=
 =?us-ascii?Q?CprUPYU1ooekH/xzxhMcSLpN63xvSS8U971re14yT2lYipMgo9G0EUnRpu1Y?=
 =?us-ascii?Q?HCtTgoABWQOUqTZPcjDZ09Ti/ajyXojeiEbaISa2E+rwnzI2LtXkHLsRWuzX?=
 =?us-ascii?Q?Qyred7MGTwDKCUFDXnLnOCUWOKNuXslNbQUEfYVpGr2K8NDa3HIUaqtPXnIP?=
 =?us-ascii?Q?RhEhvjFyrDQjooyyLXbEKZjcmxTjAOQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16505ffa-a799-431f-85b9-08da2db3b5e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:50.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddRO4lY2rVuk8Dot9NA387LY8zykC+v0iAqjpXQ12PTgAocqmTOzJJeK0B4J4rdh2Koc66kby6qREHRXPSkuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040065
X-Proofpoint-GUID: bmILUFcD8A7FTwpgaP9BhshWULU0_bAe
X-Proofpoint-ORIG-GUID: bmILUFcD8A7FTwpgaP9BhshWULU0_bAe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single mutex, kernfs_open_file_mutex, protects
the list of kernfs_open_file instances corresponding to a sysfs attribute.
So even if different tasks are opening or closing different sysfs files
they can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed mutexes in place of a single global mutex, can significantly
reduce contention around global mutex and hence can provide better
scalability. Moreover as these hashed mutexes are not part of kernfs_node
objects we will not see any singnificant change in memory utilization of
kernfs based file systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed
mutexes. Use kernfs_node address as hashing key.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 17 ++---------
 fs/kernfs/kernfs-internal.h |  4 +++
 fs/kernfs/mount.c           | 19 +++++++++++++
 include/linux/kernfs.h      | 57 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7a60074ec0a0..946a4a8d7e32 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,19 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * RCU protected.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
- */
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	struct rcu_head		rcu_head;
 	atomic_t		event;
@@ -51,7 +38,9 @@ static LLIST_HEAD(kernfs_notify_list);
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	return &kernfs_open_file_mutex;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx];
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c..3ae214d02d44 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -164,4 +164,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..d0859f72d2d6 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,22 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+static void __init kernfs_mutex_init(void)
+{
+	int count;
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count]);
+}
+
+static void __init kernfs_lock_init(void)
+{
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	kernfs_mutex_init();
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +414,6 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2dd9c8df0f4f..13e703f615f7 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,62 @@ struct kernfs_fs_context;
 struct kernfs_open_node;
 struct kernfs_iattrs;
 
+/*
+ * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
+ * table of locks.
+ * Having a small hash table would impact scalability, since
+ * more and more kernfs_node objects will end up using same lock
+ * and having a very large hash table would waste memory.
+ *
+ * At the moment size of hash table of locks is being set based on
+ * the number of CPUs as follows:
+ *
+ * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
+ *   1                  1                       2
+ *  2-3                 2                       4
+ *  4-7                 4                       16
+ *  8-15                6                       64
+ *  16-31               8                       256
+ *  32 and more         10                      1024
+ *
+ * The above relation between NR_CPU and number of locks is based
+ * on some internal experimentation which involved booting qemu
+ * with different values of smp, performing some sysfs operations
+ * on all CPUs and observing how increase in number of locks impacts
+ * completion time of these sysfs operations on each CPU.
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.
+ *
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_global_locks.open_file_mutex[i].
+ *
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks (e.g. open_file_mutex) and use kernfs_node
+ * object address as hash keys to get the index of these locks.
+ *
+ * Hashed mutexes are safe to use here because operations using these don't
+ * rely on global exclusion.
+ *
+ * In future we intend to replace other global locks with hashed ones as well.
+ * kernfs_global_locks acts as a holder for all such hash tables.
+ */
+struct kernfs_global_locks {
+	struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
-- 
2.30.2

