Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53F512B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiD1F6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiD1F6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BF267
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:55:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RMRBOs032176;
        Thu, 28 Apr 2022 05:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=gFXllb1u+cOMmS9EqvacHtap/V/6DblKykHlebcPCIY9zzqmxRlPhy9ykqUedvDMAQG6
 HwGjdcSri48gLAcBrgIMfSho1cuR1Qrc7njmVlWXOUj2JH9VAPHifQEpxR9KlnjTVyHK
 Tn1gcmBTG2SxDw+NOCziOddJJmeVc4Bf4AiQp/aPM0ajmr0KL5aunjZi1cscl+W25nVv
 Myccvbo5zCVb1X2VrKRvRFGUO4s/Dw51n9Gx1DaZ+XGJpE/8ZVFwsAJBCs4r5Zp9VOzP
 NlhVcSODBQVhzIqCZiv6IsLjxKtus+pzya7nKpEvKHTQfiBS4Et7D1tr+SKgLum3b73A ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102gr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5kb37033657;
        Thu, 28 Apr 2022 05:54:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn5agh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiT5KMlkJ6qQ/mlhRo/5Lk4XS67cU5bL/1zlYhjimsfklsKQucLE1/WtF8p/VJlYkh8wZSBD32JLVFmwhDuNOg/GtYe1forQ1aWqwaHYdm92ecuyW090CLaJDs3z2ZZY70A7m+V7YJPilumsZAcf2dJEuAc7mEDPg64bPb++LeiFAah+xxEzLHI47uHuo31UQyjSIZOfP1mGVAi5+y3dhN7Jpqv2/76oO0yITZXh3qp9UXW2yCQQQhNaKahJmLngtieDtC2Je1b87m3GjplzMLxH1Yce38at+MejYEcS3mBX3gINQR8pMsIqQ9dkhbMTaopN4zGnp4yBBf2E7YVTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=U9I16kCQRTfJC/aE2Q809IMftU1/nY+nVGA5vDgnD6uEqEWIML4v+BqYMLK7Cyo+P+lJHy1PoODpkTyMPPdjKCTmEk1Dv6bHramCNDEfFkP4CoyBqk2IshZSefVWwU94dZmV9w3uNn5pVwRTaD/PTLqkgdb9ZkeP1Re8syVxLii3lmIOeXY2hHExKDlkcThjoBgrqhSLa3/dE1AUV62NR0NTNNcu5CXkkyeck7jym7tUxUcvh1o+DhEpmKiZJitH8OjsQD99Ou9s1rdV0aTB6D32xy/U2X62BnZx5Y1ygEpyKIxkl5NQXBscGlwTnsQQg3FaRstref4QTejLi5GdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aapRvOZQ687zTXBnoT4JyRmdwm8vA+JE1KLtnpL3jZ8=;
 b=tcVPJVdvDqTJ0gTrQyO8RCmcwm1rH1uMSlcCK7vMAA5xM5NaJOYLxTVZBTrM3e08zNeWOGX9dEuKvEA4JRQrBQrFhCE+BWO2kmcZBHXkzMw9hwku3BP/HZ9xx/Q8dnebyWjUAe/gzw0jZk0iO1+hWzWWYUUn2AqlsMo99+fAoKw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:53 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:53 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Thu, 28 Apr 2022 15:54:31 +1000
Message-Id: <20220428055431.3826852-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428055431.3826852-1-imran.f.khan@oracle.com>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f123612-a594-4ee9-8ed8-08da28db9d6c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1789E436F7CC29951DE7BC57B0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfe+NO0i8VCNHWxW3G72ZWz0gphf7zGjcFM6OR00gEZq5KtlTifTQscYPrUQTshO19ttspNP939hqyb375d6z6QLbyHgti3i1+ZxEDBcSu6r7uf7CsFnUroBKg/qiJ6nGbPSQQ0RMlae4id1FR2POcmrMQcaz3SDDH/fwEFjpUL6ICv74A8wNMQeSMddHVuv8wBpy1qPJSrUPpK8pGpGXaPN5GdfXA4f5PzL81HEf7PxyJm1AyG9/kBl9Yai4VIxyECr0ExcEa0HfpQfFP16smxvmcaoqF5qWSmVEZ5Kcq4J95CHnVeZnC3BYQlXYYJI9ILzv5gGG99jYuoRGsySJlxz3iqXXiCI3YvhrB6ZRHRMYpdCvEQqgVqq4e37nae7uYqY/wafl/bj9/2HzGiaO021qB8kQ924bRKjBjf8u9QkLSXLe8FZY2SoqyMxP2iVNZP8r7T2cynmFKqJAdmaTucBwVyEqGVJ56EQu//Ligh8WvuNqM+f5aowctoFt3Nb/1aO0ytOyPldgl3/4c7u2GMrOED1jPr3Sk8ASIpErCaLzbwv/nw9t8D5Ku08FFm7q5nr/rYvXr8119PbQBn2J6qZIXUK/PHQ91uD/aMGORrNG51ZDlqaUtmNKBk1N6w7yMeOMosb+OyLNj+XFwBtn7gHBAOyJxltNLaE2pT9O4jPWnBvdKV+s6nkKC1YYCjjmTIfi2ecX3BJee2mjzRMNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7eHkxn7bETBz7kfWa4BDgyL1loq2kLVtdDOjWESEVG/CFSL/0MjIHT6hBdA?=
 =?us-ascii?Q?/JzC0ZYUfGQS6upp9hYATO9Iz6Wi20+Jjt7G6cXeTOPr1X6/T+2vu6nVZPPq?=
 =?us-ascii?Q?40eh9PX6dRgyFiCjUpjD+tgeJm3UrdhsJ9PRyy5ckrieVboA/v1Y2gwx4ccT?=
 =?us-ascii?Q?VkMAT2lj2qgOHUvMgG+nvQ/75egfFB96wGyT82G19XNjO8PWjMz/ACRZ7GKk?=
 =?us-ascii?Q?4K5sHXPsbBVpt6Dtla2IEMLvVUBSp4IY0iXwL/naBYT4FuklMi0sZ+eyGI+6?=
 =?us-ascii?Q?nSa0q3jFe7BtgOl9OQkPd3nP0TZCVdmpp1UobVKCgP87RfCvhhxxdk5KODhC?=
 =?us-ascii?Q?TQ1SXTkyMVihzJzFRNO0rcw5fAlbFM9a/A2TMmraqBlzy6RXlfjmFbP6oXSd?=
 =?us-ascii?Q?qnGEhCJ57LOEpS8W1f4EXkN80ADFInik+ARQ2QnVUQ+z77K5+XMRRz3LuwQb?=
 =?us-ascii?Q?btEv3xh2Y06/ihDc2xS6/6H9tM7wGn1WHc55kYGJyekImliLStKxm7AkeQ8l?=
 =?us-ascii?Q?iPpuqSZ2VXRbLKwWdLiSOp3i0hr+Mw9hMnnDUrciIbMBrYvJUtWwEN5EgUnM?=
 =?us-ascii?Q?4fr+oXx3SRH7StQqbTjD3y9kbvvOlsq77U7nSbiAMQGbznYbwt1kF8VJ1h1/?=
 =?us-ascii?Q?SoOyrLTjmPBFEU/LIp1wJpRLKEALFdwdR/8apL6aw3Ak0bikBDe+kp5Ckyyy?=
 =?us-ascii?Q?Cc3dHab1S/3R6KxiMHk2U7AUzEYVaYo2mjNSXU4j4ChMittjwhsu3JWDds3E?=
 =?us-ascii?Q?4mJH207PiL27ntulAvSP6pDubObKvWGreX2AgbgO5j6SD8GFTRHZSfu2Oaq/?=
 =?us-ascii?Q?X60UtR3KpQ+jS1c0kAAkiIyh5v6QAAEONJ1c2XmBHWnQmQdW4dqXBGRW+HNi?=
 =?us-ascii?Q?EXFlYU3kQu6kB3YkgvDkAgTL7aWelwlOQp0TG0JMY6fS7dX9NG4r/Uy1/Bti?=
 =?us-ascii?Q?Lu9eEwN053r0DBN1cWWJXCxmmaiTpRqIqf2PdX2AmfrY+BScG9Dce7RsgBbM?=
 =?us-ascii?Q?XGJjB689DcP1O/xepAK+l9RXh2Zf2U4TqpHu1zkbO4gdny9oBrRZhUup0ibY?=
 =?us-ascii?Q?wyqC6gXwmRAU8OKgKZlQhiDbUesQPcDmnBmyGvfAC6GttZg54YtDlPdufgJK?=
 =?us-ascii?Q?TI1jY0qamVwTNFl32g5JsWt64qUz79r5k5+qOWPg9iSI0VNUUr9UV64kbi2l?=
 =?us-ascii?Q?UvpUpLrbdtVRdxLNb4OxhdjCaCrsBefaSbBmJEWfx7ElSaaGLGYBtOiZJ8kZ?=
 =?us-ascii?Q?IvcNik50DtSG2t1FOBZuo9UaUtZKizfx0mJRY70fQ90vpmfBAhHawgh18B7l?=
 =?us-ascii?Q?PXD9bAiV4LgY7wWLkf+vRq2IEjiJbjOQkAX2nvJh/TuYRvrii0nziiYUpDvv?=
 =?us-ascii?Q?WEDcaxo8kgnctqMUJYRXyUbc2TL7exMp31jjUx/AGjFzuF81JKxaKXiubZ4e?=
 =?us-ascii?Q?GJe4s74lKcmYbAFmh405JX4/Lfem6ghE6KK+PBj69tGRJXc94aZXHb+5AtGt?=
 =?us-ascii?Q?TAk+8QEo0ESGUYeJ8KVjtS0zuT4CtwxUFlw9sOutWvMQUfb5ZwOGp/oYJ8E9?=
 =?us-ascii?Q?4vwtTeZH2tlpTdPvMZeT9rhicK481PDu3FP1aHKly+kpFXcGmwqIhurRDLqd?=
 =?us-ascii?Q?d3qsrutZQGzGzDYDHBZc0aWJT9B4nimQewLXVoB36JN5i8yS8zb8HrM0M9Vt?=
 =?us-ascii?Q?tFGzyk+EDggCoV7vCgkVHMrpmBCjstyhz31SyaAX88c9cxBm35IMIncIiu4F?=
 =?us-ascii?Q?Ambl1l7DNs7LV0hoEtMJ/+IDD88fI98=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f123612-a594-4ee9-8ed8-08da28db9d6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:53.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZTz7n/2cpwjHaxGBelEo/gJifgZfA7+6h8ZZiWheL7Gvt0pysC5cCu5rsraeiFA9Cr0MQyXj/RnDrIUzKQSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280035
X-Proofpoint-ORIG-GUID: ivmp_A-DIYe3L4wpzsfyGgoCDm4ckYSg
X-Proofpoint-GUID: ivmp_A-DIYe3L4wpzsfyGgoCDm4ckYSg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

