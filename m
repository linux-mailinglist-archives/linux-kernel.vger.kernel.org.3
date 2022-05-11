Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAE522FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiEKJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiEKJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCD60042
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:52:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8QrAa024470;
        Wed, 11 May 2022 09:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=6E1gBTMkxYHgvMkRLoIkGcvNZJNeFZKDzjzIA9IBXsw=;
 b=nXnJMDBB6JCtWaHHF/V5k3/gGl1vH3c1fZY/04RfwLdXewqmPAkjRRE0OFyzXoFj9ai0
 jensngIUkT/vecm3WSZpBOBppRQcey+6v01HVPeoqWTHZixmxhBqnwgxw83eiUWdScEY
 E/fOdK6J4H6y64KmLw4y4A0S3bsO9+9Sqt8raMEwayrImYcMMCCDuOXHySm5mdk8Z9bG
 TIEob8we9yVEGSN9DFzMtY2+3iVePLPAXzkX31hWBCx8Kqca1QuXRph+R+casKGbMath
 cqT1Y4op4VPSWCBhcUX/yMqr1cYvLkqZT/qIYmOIFbEvVbb6+yEBBgU/faRn3oowHQ2L rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0s7tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9oOaQ028160;
        Wed, 11 May 2022 09:52:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf73w0pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjV4EEaK5LlS/+QBK4iCvnxbb/6MqRk8GcS5Sc7CFlj7uxo0CRTagWppIEQ1VdISNmmdu/hm5UMsMf7nBDxaf/PcfPnRY1Z6aIauzc8C2tqYtRK/dM5xnqpmd1zE9Riu5ACufayaczhiaLzIW8m/zPwlHcKgcf5c1NaJpVb0qxWhtHBeOSmdUcheCLAtpjQ6rnoxoG6UqnNj7HO2IdTzVS1aXv5UtLdLi0TzoyKtuyVNpkSJSCXqAUTC476W4MxT0V23yjpIfsoBKY9NhZDdTSnqTPRoDmjskyqtZv8mJTz6mGopEyx3iPCCzuXRkrZYn5/RelMSNx6sSA0rDBMjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E1gBTMkxYHgvMkRLoIkGcvNZJNeFZKDzjzIA9IBXsw=;
 b=dLu0EkbHiZu/msrstInZ9jFXpbXlPgjR4GNtNLqKtn5vE0rj6ihv2/KF/DE68gilL9JwbfBunz2FGa8MHdQwlD0eLbCfi4EMuB4Ml0dKlzhnXv3fZ8MesuaDp56TXWYDip6x2e2IGZi1cG6Hg7Gbu4QWL6aa6+hsZEUx7I4r9hRpadtjU0E9b8AWOTnagCAs7DqWekxzV1pVEf8Fr8ad0jXY3jC2D/XElVhgnhlWuEYIo/7Vxn0fKMlOl5MFttz1+0707fjaowFpDbXTfjVmeqeGpxxOrHtMOB9QLHZzcFS/728Az8zaV6yqLdsgqGp4HhurN5ytXa1uxva+jVwBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E1gBTMkxYHgvMkRLoIkGcvNZJNeFZKDzjzIA9IBXsw=;
 b=Tr5jppErlcdL4aElTNMJ25XqPZWKPqu4FKdURxTXn+ks+0riKYDGDVEOAM76dhlOLGPYDAfQDuJhf3IkjxHp7mkL/XjSNDFuDQeKRHzOQtBuUR5EZ4c8FjqTsKfg3k0DGwCf584//h3wQMJVOOI5eFAI8YIL19XWH6mlJ82a7SU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 09:52:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:52:17 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Wed, 11 May 2022 19:51:57 +1000
Message-Id: <20220511095157.478522-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511095157.478522-1-imran.f.khan@oracle.com>
References: <20220511095157.478522-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6f727f-4fdb-4a07-1d51-08da3333eef5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4785:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB47850EF1A8DAEA2B323BCC49B0C89@CO1PR10MB4785.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+TMl8rTXLhSeq7tsixMaxo3cLYEVNaf4q1XnErYWcxquI0HVABLGn558rau6TI9SmM3fORaNba8YabiUMTJWftn2i822Mo4hnXFcr6qop9QBgzUAKICY72e0zyipBzvOcU7MOHmxc7GzezbJzBputpFwKJphhcFo/5eMOVB5dGXuW21UeTcXuIWnG5lnEloJcrOym9VCyg4kJXJNSy9vKvhBjCO7d5yHugHpH1JHGcnGIYJ0xd6MQpfErHEpPjS+NOplh4L5SFf8bWcRbYenAZZQfnLlPcuPRCbT8RR4xZj2HRJoKf9n8DVoqEnr+bDioYq1Dc9CPLIa6rX+0gcyi42OjgrBB0OnQWvrBKg3azEq9nRn66S1B1YG/NqSdI5oQiY4wi1MfOi98xtK4vPSGSAU6A36GE2Ns325/tPbI1PD2TARP9CAXtP58kFIs9bvGlM9TFUXPRRt4rn9k4ggL2UU3iy7DIJJdgTql/U8t0i0+EwDVExSZsC1EQ567MzmBARcfDRk0jET2tmR2gpqyTYydJgZhkM1Mg6ZIAnA8T9ZWCg1+ZGKPas4Zg1iNX+FOtPXSIjgkn8AU/4jCtU0cU6i0gKQjHX3SaxDNfNY8694RNqGAEGgdQpnSKpuE3QNCAc7g0ROFkK+nlShFio1Uf+/z0jlKzRg4vn6+gtKylRajU14ung6P8ikQVuBJBWB1KF2JEaVXW8WIcbWQygTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66556008)(2616005)(8676002)(1076003)(66476007)(5660300002)(4326008)(38100700002)(8936002)(316002)(508600001)(36756003)(6486002)(103116003)(6506007)(86362001)(2906002)(83380400001)(26005)(6512007)(186003)(66946007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+VQyOLTFwN0JSDOgkD8HSnIGPmlv7dB/rgaIkbm0IAIry+lyjzlYlus+yaz?=
 =?us-ascii?Q?w/c501x1L/ScJdXsBh0bt6xDDHJlHX7EL3RHsk/+EqsweJQ6xsHVCtfXx4Qg?=
 =?us-ascii?Q?UMHtjBEVbS1ESFmHmuUidQSnM9A7DhcDbrE/TMkpv8aL1xrzm1gCMIVgefQN?=
 =?us-ascii?Q?DWh2K3AcG33v7Rd2gZNQ9Jmkyer/nfF0dI5I90SEm+zOKicLLYvuclS2+wlw?=
 =?us-ascii?Q?/CvmGdVh9YwaMnGE9KQ2WMJTmxWDDXA7kHuHgRjoTNUBmEsKcxv/ORJA5bQi?=
 =?us-ascii?Q?Z5nHo2Yb0HP1ysSbOR8sjlF6/+UiYlIFeSPE4dPjBmRon4Ht4aFFXtihnlqO?=
 =?us-ascii?Q?oJrERAvG+ziNDu950+NHJu2j91FXuTs284P0Q4lWK2XhqBA/XTQgZT6rQTFw?=
 =?us-ascii?Q?RkEACUOfHqwMOUhtryIUY82VVoiOVNYrJWKTXS2dsy/9degVXu+LfL2z1IAY?=
 =?us-ascii?Q?OMC3qF+GvprxTQZCet6MTe6V7A0ivU4VjGjx9Xz2UJTJo1jzlD2P/IPb+YIU?=
 =?us-ascii?Q?0U5Dw3tCFQjtQbT7VlFrvZkE2iFNcPQ9WBx88uCNZYlDiN9XETikPvx5kkfX?=
 =?us-ascii?Q?ObxLEHqwrkA8xH8yRwdWqh6RLNA2+Q5majj2PXZD1oXlnTvCsdlX7jvdCvwU?=
 =?us-ascii?Q?ylSB7lk66JZbm2MzByeg8Xa2/B45jI/w3aPwc3qpLuN+EYWDopMMf4YcOoJZ?=
 =?us-ascii?Q?9b1aqw8+syseIdso6AXJfIiuOcYxS3daQ6r1O6OdsduylPfO+O1ne1qTk2dw?=
 =?us-ascii?Q?Mf6z37TtbyDvsUK/LU9c3VqtjbIUACuEfU/OZJ+OSFJOOKoPvl4t3tnma3OE?=
 =?us-ascii?Q?eAsLU0KJROGbKTrW9Hor7T7WNS0nex81BRfaSFfksi4u1rkQAMA2BM3dpHQ2?=
 =?us-ascii?Q?IcyPzCwtqpkCSWSHw1CCdLp30epEsPScMQKKP/q2kaIlQKXe8kKm+8ZtCG0C?=
 =?us-ascii?Q?BBTeVe/iNAguWcarjwtgWIN9sOSG/mTPDpZJI3+GNLqf7BxrIZFH7+/ng7mE?=
 =?us-ascii?Q?U1IjAP+GFZXxT3zpb8gKLW6wiRmajObF8tU7C0oWKGvMocn7qUY7vEOCA106?=
 =?us-ascii?Q?2V/aWJvY+QHbfTzvCTm3ajxIXqiVQEh4ojET5BQmXzW8soRU4F6QcrwFIF0T?=
 =?us-ascii?Q?5lxcUSXJir1r8ZnnMPvJXCs3ZLm19WO1VMAgA4LYqg76IyzQ1cUkALInXG/3?=
 =?us-ascii?Q?HYnxSQPx8o9/NXC+DqJmnRO9bdUid9dEv72oUCswNIVU+2kEvOYvbA8UYTId?=
 =?us-ascii?Q?c3YLFIOlWj+Ne2TD3ViTEg0EbD9cDQEEhaCMkvIyiGAkPophjyF0sUbwHbXB?=
 =?us-ascii?Q?l1CVIOiG6y+qJZdK6KvxiJKRZ0sIW3Qeed3jri4GG7qZ+pRTZrZXqOHeIBpn?=
 =?us-ascii?Q?9hK7Pn9vyNJQIIpfx7tubpbbKpEf9gsDSt7vNKL5n77SDSAV0+Q/90mV9SNA?=
 =?us-ascii?Q?ePt6ujkOBF/OwamUoNigoyTBRhfEf2WvIDS3Ee84UACr6mh7m2BPH9pLhh/e?=
 =?us-ascii?Q?L5G/PfkujrvMsAf1f+ZfSeekPlZw5AW44Fzyd4u8XpWcQWlzTrUeCMElnAg+?=
 =?us-ascii?Q?6IjDAISzryqQt4IfU3vvrjnQvfOkKbQXMw5oxIkNYXi+N6UgaB60+3OnHGM6?=
 =?us-ascii?Q?lJj6u6Uu/gZYcWaGCxV2VbRK0dLj+NChrcl2FCDxHB0cWOTJ0YF3N2WfquWZ?=
 =?us-ascii?Q?jvkgBKSqvSp5Rg881YRrw2u9N9jQdxOE6gK4EXkrBvKS5w33YMJSj0z0sNSJ?=
 =?us-ascii?Q?InZAlxS2Nq2E/5bfOV+X97I8V/X1e5U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6f727f-4fdb-4a07-1d51-08da3333eef5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:52:17.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu+W6COpFQP8aJDsLuqLZfLVRBBZIkrxQm3by1vOoC5FD4kScmwazC2IXNtKtfwDBZL2NAVAlNB9d+0b9gn/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-ORIG-GUID: ipi3VnwZeP1nj1ARIRKBakRdDVd6Nbd3
X-Proofpoint-GUID: ipi3VnwZeP1nj1ARIRKBakRdDVd6Nbd3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9000c85ce1e1..175c9f53284f 100644
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

