Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2734C54A61F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354219AbiFNCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353389AbiFNCP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:15:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268103DA52
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:09:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1CBBT025664;
        Tue, 14 Jun 2022 02:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=N9cVDxq5TpqWNYM9+Z2Y7W5kQBF1X61g07ox915eg4E=;
 b=MAyvkG6pRcD36EAkPWrqZP3oCPWJrIJvL0SBXzrtNFEU+cUhWsyDjCoIeokPeNFDAC4x
 bvB6UOaOHb0D5pA1mbU2OjK1v/1wOeJFZ46KEn4uLEj0xC2OKL145ThSCvnvvNAxFoYY
 kQsV9O9cCGrS67YHLt0opaKFvuLCHDOoxp3atH62UDmDA5QbOHiAudeIyRBqyvqVVEpP
 YiiPVRp8NoLa9PGOy1obum2EHZU5N943rlYlblza24cnSUbNXD/4oLzSjzZCYAqQJVCf
 3N8HRRFVQYkPe5GtKa62+1Dchbkah7ZSs224HKbs3XXtf8uSZQ+R5HAM1Ee1p3Y/bmhq QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9cg8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:09:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E21wTD007179;
        Tue, 14 Jun 2022 02:09:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gph6kg2va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2rmhGqnUjAnKjGZV2HrClXQOdYG7t5fTvxrenPsVcwi8QdV+szMwXxeH2DdAZtX61JLt68E3aO7tKF4nKrojSVcwEjKaoK1L29mDQSYvaOaWiji4JO9kc7VZj6sXcOFwU9BLBe3zV8hHIJZeV9myLll47Zbu12/h6p/f33RjFykltPCcftbhUNZpvkyqPU+3pOiQ4T/AFhN80gGX8XLjP54RSL+vmP+ZZqsHaT1ixSeCppIHsTRQk1jQPUMoYZZw/soFyWkdAv/MB1/bbEJoAD0sHwE6NLKtCC010lu+FxfNYh5aFYZMK1W2UdRIJj/3p3zqoVq5uoZ82ZHQgUTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9cVDxq5TpqWNYM9+Z2Y7W5kQBF1X61g07ox915eg4E=;
 b=dJsjArs2aeH7Abh6EGLF6DHzWPCJaGADR/p24ZZmMXGcAbyzadVWtharlPe8a3tCBq8oInISzfIbGtzAAfc66K7baFQdFyeSoctgMDLVw4fETmhoXMIUgLgEWB5fiQbuOCroARDuUvlM7ZIzgpByxBpbe+cKZb9MiOlWApoMFKXiikoYzkl/SAKd2gdVV1y6oFfccOsjLh2LoRGDFBeeuhssI5PtViNKkg7wd2/y4DqIGEoDVJU/ahRZB/09H0M/Ov5M3Xqtr6yBjPbF00kwM4eOYUWroTqMhS+fjMG1/zdHO3LLGn9e/jRf5rhFX0hat9kma0iZMId+yb3cxmw/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9cVDxq5TpqWNYM9+Z2Y7W5kQBF1X61g07ox915eg4E=;
 b=GLL1DUsUbRGpLO6NnUL0NzLAhKHWthaulUjdhxXsT77R9J6FIQhC2KdVtrOuAE7dMgdwDstkGnQL9k/xIR16rPfpYTI9enOynmn1ohqV2xipI0T1aIPkfMiI9JE6vgAWqraMAJne3W2ObMK64xtE+qSCrhrjnYbztExOu0+5C4w=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:08:58 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 02:08:58 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Tue, 14 Jun 2022 12:08:40 +1000
Message-Id: <20220614020840.546013-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614020840.546013-1-imran.f.khan@oracle.com>
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4725fbd5-8e5c-4747-8c49-08da4daad7d5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398BF1007789F8262DF6AF1B0AA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTadRJbK7xhB4ypq26FxAK9GwZ2v3jnfHvGHMLaveKXC6vl+5g25O9s1JN6o7w9Zw+O3vWO/BiWudXrg54ImaTXUi2Jxqhix3aRBibdZOgf1Q0bIpHDWbjE5HDdmXaqrcnCb9Wjtcg90t63GU8Wg+yhNc2MaPE2ys2Fjx6pHKD2MIHRDgkws6fAaZaUeOtbxiXbCIWzKavXkW3DoQ8pJHgYbZgCvUqmRE9BLexUMAgGS+DX9DVb24E0ZlDQ2631E4h10jE1AUSCcU8X+YiqXOOjJei4Ygl5GiKVxPB8BwyTh703OBpeK7tThBACBzyG6+mJaMw7fZLOd6/UCEfmnpZmiCXBUfGvFkIzufNv5Iv3u+Qd/yYDFgZKpi8zAx2NqGMl346kiTlU3NWaUSNf7z+WT50VSrIJawpK6lrIRaf5uIZ6h2Q2RV8lqHhkwhD06LZjftsbGPABjpmfA0MG+8/oOCna2h0BijrOx2AvXOU9q9OCHfY3O7K1NgL/w4hlNmqtGx+WZAUfRNlKZUb4cBKvWSfcE/B5Pa7o1yyCjDWLww4U3NGVbejnAPASUqngpKRJZHeDa2DcfwLAwx/oVUCdq3vx+r5ic19Kpd5HWKgRxkBZQtYz8GpYD5gPspp6zBGg4+Cx5+cKAxFa6thn/W1W6V8oU9bvumcZua9linxdP2vCLvWgn2WLILF5VcOkdErDMzy6i/9jwMMIlhZdsjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66946007)(1076003)(66476007)(8676002)(4326008)(186003)(5660300002)(2616005)(36756003)(52116002)(6506007)(6666004)(83380400001)(8936002)(26005)(6512007)(86362001)(103116003)(2906002)(38350700002)(6486002)(38100700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jYlDP3DfT96z4Khij80gGog6f+SLZJwYtZqTB1LJLRRBf7phNJZc6Bsy6CQp?=
 =?us-ascii?Q?L79F2J0RZKue+JA+ZL08oAE6CpTmtMvJ9w0Bh5B56Fv+T1MsQM9qUiv79sD9?=
 =?us-ascii?Q?nVJtawBDFbKfGMSkYxjwSlGo/1jkBQE741bqhYzCTFPPJC/8L1fp7xG1ybj0?=
 =?us-ascii?Q?sTCF5wYo6+Md5jCBVNo4BzBkEnqS/AEOjloejb8up3928xOJbogABUUDsqqP?=
 =?us-ascii?Q?ccsJJ1i2c0t2bFt8P35wZq2wCgVN3QZxAPrG2xRPABpdEFkz7rhYDjeDfX2O?=
 =?us-ascii?Q?Fqwyb0ELtxKriyyIFBC/TsmhsJWDx1YPEQbcc2SVWBxMt2+8eACK2c/RfBFc?=
 =?us-ascii?Q?AoWeAxopl8mhNGhtrO9Bt7nl4w51RUIacpU0Qah/fTtK5scLQ0tnAxCiJ+dB?=
 =?us-ascii?Q?+svrljxTq7VflY8h/VTnjCE6GRwe2VlJ2tvEafCjAYFs5l9RyOjRxmtcU9Dw?=
 =?us-ascii?Q?n7Ewhxe0PLf2Mkp2l5XiZcFZwt0aacZMX00nC/LEKpNIQzsT1+PByPEVBCJi?=
 =?us-ascii?Q?RUrLp9QMR/i0iz2r70PGNb0Av1KYtJFHmmBEFyYWqpw/vP0xgFAl5lIDbsCB?=
 =?us-ascii?Q?D+Tufo1iHEX3MwsqAEU9zi5tsIM8ybqpUBi9UeAAw6DeoesnTqwVJMK2wWmX?=
 =?us-ascii?Q?LP2qm9ASt4JEdmmLA2PRxOrKnEEq5x26LMK5X3b+u/XU5TnI5sS+j0FG7cAF?=
 =?us-ascii?Q?e+tbVUB5Jq+6R/rErtrDrn5qF3HKXVQBwIywhNNhQ6VVpRWZ/Nikyds2zI/O?=
 =?us-ascii?Q?j4YBZZdaBuIeVz2C0KbLMfUIjlu4BpEBhF//G6PdhzXBlGRfigl2Oe0/dvIv?=
 =?us-ascii?Q?q6ul3kHbIuzSXG2D5QGRo84jSJO3fPYwk9b5fi0kZnz3ljda4jCwvOZge+Dx?=
 =?us-ascii?Q?IZWFWF5xoHxt1pAi2OQaFaVHt2a2XhYiMJxtbLwy0OZdkaDoPYJgHkVdda66?=
 =?us-ascii?Q?oBUwtQ2tQAGMxFIikYvkma+stVI8TC42I+eNj2IZ79J0rcbBxnXc1+7sB+tA?=
 =?us-ascii?Q?hoUig/9Crcc4c0wRoiqwZrMhdaR5IIaZkRvBDE8yasfVm2Sy3myQAhN7pgY+?=
 =?us-ascii?Q?6deNZeIJMrljZGoKfuNV4sOXqdn+2y9AJwXJekaHjN1J3OD3LaUzjkdWbW99?=
 =?us-ascii?Q?GnR5yblKS6RcyjV6WgsOteIUBQ07of4x5ozoXhuMWXpyP8JjV0pgFUx7sbjf?=
 =?us-ascii?Q?a/m9XjhnGEQRUdhNIJMqNWPTw+qJIexGxjrkXXQXbyFSyfDI0iN6sjjKsjpj?=
 =?us-ascii?Q?iFw7ouUDBbUpJxrFA1XhRwpDiEdYH2gm5duFj7NYb6rJ9YGyTcxZW0hy9yuk?=
 =?us-ascii?Q?8itzIzYioaH4VjvYE92+B6K9h1SPVfrrI04ncFpqPuPn9FTbxMnG/Y4ptKSL?=
 =?us-ascii?Q?j6kQY9ja1CNNDbgVpVxt51M6CaxHvRN5pxjUsa3Pg/vhU54Im6OjbRJ4Ym4O?=
 =?us-ascii?Q?ibDHaovyLtHmAgpID5ylII9CN3DabjjJhCjPZy7Z8v3/a/paAdNXMAoAgi1F?=
 =?us-ascii?Q?g0w36y2pD26xZkQ8MPHykAYObnjotPAIubhJZ2Hu0+doN+DZhGSqJIaV6PRz?=
 =?us-ascii?Q?vgstmNjNCdHx2GLyZaZhYGrjWhuvtUWHud5JcvPOB9Cm/nN2XPjBFvBXnacP?=
 =?us-ascii?Q?p8pX5teu2MUMqBowbog1N+oNYosjWGJRnmbLZ+gXGAFxBHpieC4dtwup5X5z?=
 =?us-ascii?Q?dnra0r3yYXpgYLgQpz8QQNPCst5yo3wp3MY3EqgGfRCxiOVQz1EqTc3Ogo7l?=
 =?us-ascii?Q?8zniLXRkC+vsnzbRbhcCLvzEjLOpiIY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725fbd5-8e5c-4747-8c49-08da4daad7d5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:58.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zHCgTZKlVllN+BLGgybfuv9hI9DzUQ+qYsNQbT4XOfbem2c5kBd+hlaf67rGtGMOStcq83W/AlvLqEu0u3Zfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140007
X-Proofpoint-ORIG-GUID: akbrqYTuX3GBa3-z9UEEixC4_VbDObei
X-Proofpoint-GUID: akbrqYTuX3GBa3-z9UEEixC4_VbDObei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c            | 17 ++---------
 fs/kernfs/kernfs-internal.h |  4 +++
 fs/kernfs/mount.c           | 19 +++++++++++++
 include/linux/kernfs.h      | 57 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 205b5c71f30cb..d821c20c59eaf 100644
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
index eeaa779b929c7..3ae214d02d441 100644
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
index cfa79715fc1a7..d0859f72d2d64 100644
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
index 2dd9c8df0f4f6..13e703f615f79 100644
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

