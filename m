Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E153B3C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiFBGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiFBGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:39:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009672A142D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:39:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2526Pv3h021233;
        Thu, 2 Jun 2022 06:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uOb/SSpfVdSHz1Z+PNlXCOer19/Qt50UtIJ4Zu2ET/M=;
 b=luKZBJIXxuKqMqcBLpm+1YiOjOhKzn9oWzu3heYMWhdNcnfs4vGJzznezhd+P/FUT+Mu
 fP1BMWP8uhYs9XsSf5KfnhEL9q/lrzCWB04KkG2kBwZ+t+15cuNysgxzkVDRu2AINwdB
 wyPqB2KEwvgwcdrNAkU1T+vRWQPnu7E4toG8lUFdkelakECejEnTdv93yIwoWohy856/
 6izcn5o6yVyd61oo8CHwY0v96SP2Bggz3FMFRkq715C+bj5KvZk/5eXtbUq41n+3WM0u
 ndmGN3F0+lcBbz3cmz3QYH38jE3FB1Fuq0/nSu2VhX0igZwRQYrphiETXgqi/AmAQfp7 uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm96fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2526KpWs005235;
        Thu, 2 Jun 2022 06:39:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kmccxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne1a7fz4UUL3ZBBhT8bZe0N8bn9hACbWHwxujYaUGSkTqBOQypN+RxqWgueMXmF6IiS4A6tQn2CCdJO82dq7manoiD9wA+vsTpiEVPz2xAmCeiau5BXrMSYB563guukKM6MNtP+jYBphm+jgEuMKnClGJEFcfHDJti9chuNUUbycgKInSsUBxdIxoo6EemS1faHibq9+6Z+dq671A1yUaBUwYSX1L353GtEAgghjXonaDW0ZznBoH8JO+GRE+ZvbpD9k6rD2omRqSfnwrgCiCjCnkTuKwBWIx+9ftfQZ73gbuX8baUQUEhjlxcmFyQqkRSM5O/3rd5WAnAUsqP8GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOb/SSpfVdSHz1Z+PNlXCOer19/Qt50UtIJ4Zu2ET/M=;
 b=PMsm5h02R9Ih6Cnwa8Be1yl24uTHbUXu28Pyc/nH7lFn9F9dXtDK7XhTUAHIsais6a1AZitW02B+GpQrOAt1kkb/LOrKCMBqrqTXzIcbsgvxixV6AG/H65nJ2djXUB9Jk8dJjqQ2Fzfoz4XJuevdqY3tG0V+TMBWexlmFVz8rCQztfTGtslQ01IjS97PW/jQB/ZSkUcXvqQw9ECoC9BxRzhXGJQvItAamJK27lmnQqBa806LTJS3hzqTQMM0hc3pBA3Jwo7OgwAjSTL3vIhcZ9hwjnS814kAQQxdkwZHhFIwxbUM/pPN1PQS/ilc2CcNaQhUgvvqSDg3x5VAKGEFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOb/SSpfVdSHz1Z+PNlXCOer19/Qt50UtIJ4Zu2ET/M=;
 b=YpBsUcx8XlpaYMHURWznloHJpnrFQUyAPV2u3YeYIigr3U84PYoYO/NH3j1MhRYY6vWMoDafqS+Tn1/8Nua+uM/c3SFR59aqA98ff6cPleJO5wqkPyL3xcL2C0A88aWsQ8caR+lgJCiUtmX8eyfuoXZemP/IHmAhOySk5NRURS4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:39:30 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:39:30 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Thu,  2 Jun 2022 16:39:07 +1000
Message-Id: <20220602063907.136569-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602063907.136569-1-imran.f.khan@oracle.com>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f8fdb1-33b1-48b9-f5ad-08da4462a59e
X-MS-TrafficTypeDiagnostic: PH0PR10MB5845:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5845279218A920D5FC9E03B0B0DE9@PH0PR10MB5845.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: es0Y57+mE0PRx6HAMf0iLmwb3Dz7yB2rtENtFr5EDthEvTYQT3HtXSRYDL4Dv2l5/K8dBg0YM4L/X0Tr/rHSbnTRDEf8pJjgdh0hR5aqu8pUDhpjyIgmBvWlJfiVN0uMCWNqe+pvA5rARgZCRA5Ed9Y6EJoxzZwQRWFUoJiYNQew7Dt9+VX7MpFYVJRxLi51H18Z/o1p1qT24cIkuPfRgvDwnjZr/bTBpO3LolTy4rhFD+66V/K552rMbVEDRugUZbbwZyCqCCVIUDZrBcMp3ifxyOJfqeDIXdtQfVKl6BNzPUWRgZmibBYI1fxgM6kWdt4fKb1NWCLPSrraYNHljcIVBiMbHRRfPapK+YmWsKZEztdzmXveH8VZs/NLA81Vmn3WLDCPJUJcTZbWOA+lH5/jpsLsiOLxMpur7JyQMLuHX+bNMiQNT12WHUcqjIC0MdB6Hw6z0U8iZ/dhAmYgQw2gd+MMMIFfPNiOLkRsO/YLjBKCAusBcVX3D2tzkzFinvE7E2QO4t92hqeh0rLFYiXALKgJC9yEb6fx0TAJGyMU0c7BxkaXcS143kPjUB7TsbIDNrlMih7/a6IYMtO6yzeoJeIGOCwRHb2ZQy6XS0Wpy7j2lhSrPrBRPB/Jkgi95qm41dQYO445ZRGv5mxb/Mq2PilLQE906aAkNzUqxLPFSdtcafojLZp5y5oNxWGCtC4lA/3UlyBxLXGSEx/EzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(38100700002)(1076003)(2616005)(5660300002)(103116003)(36756003)(8936002)(2906002)(4326008)(66946007)(86362001)(6486002)(66476007)(8676002)(6506007)(6666004)(6512007)(66556008)(52116002)(26005)(38350700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neqH/diUXa42mJMGrqmqzmgdpjgeIsUaILRx7j4X3ekQ/aiGk8phwBP9V0ds?=
 =?us-ascii?Q?+eYNaidwMEM6wI2AVM6uj8Tg8kqlXvep6gHe8UAzS/Gh/7eEoLDZmHtwZg24?=
 =?us-ascii?Q?F2npzFsQClZXyoFDO0A6bDmiipgxYO8ZuC1RATH2qRZ5XYVhxcjB+sUVRZst?=
 =?us-ascii?Q?FQx+traAOHc1ffkIFwYRwhoxNW7DrkrafHqDRYdLRnzk6FH46PdpkrDiy6CY?=
 =?us-ascii?Q?NASx0pdWrMEcgT/wUtiT0LBJjRWy4rKLjvPLrnikpU0+C9FFdNfPW7piMGTH?=
 =?us-ascii?Q?ga6DspsUFeWxXWAmJmcjYao4RYPQKELpXqIxy6hxM2Uf1kL/2zEnc/Rcvhe/?=
 =?us-ascii?Q?TLW1cj/texunwvneeyqr6Pu1mIHTYJT6/xRK0DbeRrCfLIhMoBPgyGTHUE9r?=
 =?us-ascii?Q?kHAjPo82fyLoTSRyiOhJNvIE1OjO9OVg/Vyd08OPjA+OEw9StIByuI76I31M?=
 =?us-ascii?Q?GrbFDyzSouus0y69fzqevLrTE/GKMxtvpKDSy9UM+KHBXCBjlmzmKwIs9X7b?=
 =?us-ascii?Q?TMUzzhPQJOh0gRLF06Bnx8q8Qi9LFdAJha/7G4suD4gVeWLYo7zYl49R7ndD?=
 =?us-ascii?Q?sueRo+aVEFHB2IdidNqYiM9oetqVTVsPjAoEZpngyAyB/wVNvwIU+z28zNDc?=
 =?us-ascii?Q?IWXkcoUSUnvDCdZTC9JIetB3fqwDkZI+q0D4a8BYQjhAN2IPiRJQfv3zmbab?=
 =?us-ascii?Q?vW+Wl4dp96o4umwnVoDktwtyKOIg+BWqTra5v8YWPcODZ1aqJeTaSOXWsZOo?=
 =?us-ascii?Q?5ISsFQRQRzc1vTOfeerQ4Lr/EU2ziuDsPYNS6HWB1pmtR3SVg//NGfTeE2Qn?=
 =?us-ascii?Q?Nk2ngzMWKTXU0ScdPg6yHPhVMp9+Dd4r01O630L2qZBvqn7T9ivcJ3axmpyO?=
 =?us-ascii?Q?M46D6V8hvhvTnCxsKSAMMEIThCxVTqTxc6e9ghKQ6sQ7C7a9Ln/GynpMqXa0?=
 =?us-ascii?Q?QtU0pveWlRRTJvztMyOMAr1IfdV4qzMhtR9fWday6rZEyfvW6feDG3Wl2VMl?=
 =?us-ascii?Q?A2+Iyl3Hj1vv/r7+tB+BgJFq85kEahWgMviMRAr2e/EFItFgwbzWDcd9HnNR?=
 =?us-ascii?Q?TqAGGZRPCdGHFbekRJo4fgoOXXXjavU5tycb4rTxXDIhe12MzyU3nmnBuC/3?=
 =?us-ascii?Q?0p3IPA5QglHWyyFKtldnh3gmYSzLguoyPfpW6Yl/iDZmcUtt+HLNRDV4xmty?=
 =?us-ascii?Q?hirjclWIwybgdRJLGBN5VJfc/hcEJXjakM8FYlA8JgYcf4Hr0/zAxbNFlqZ2?=
 =?us-ascii?Q?gdpGEzie61V9TEx+h4IkXH+DG+eViyZdZSJMstM/fOA4ayCxfmWQJN20xP0h?=
 =?us-ascii?Q?f+dlcdlkMwArcVzpJWT5SReP6TnT41W6U1dH2aWVA4+EMHSQLrGm92tCb4Tz?=
 =?us-ascii?Q?je1f3NucR9yT8Tv+30pY7t5MvnZ7fKQBvPQSoQTtttwWO1Eb+gtJSdKe4hFU?=
 =?us-ascii?Q?8c2cxOG+LRY8IedWdO9m6qRfUok1dc2U1jxmFdCCK4FpbXAuEop78qc08t7x?=
 =?us-ascii?Q?k1KD/zz3sAyVj5D3K5iviAMFFU9uMiKbGdtREQvH8batSKLPu18uSxi9b2op?=
 =?us-ascii?Q?k53C4dpSVF2rfD3mCcZMP2bgrurXhsm9ZhxdNpr56bh/mt2nibkGmWyG9ghz?=
 =?us-ascii?Q?3hA4sAoLKy5ghGc7HuZVsBkO8bfr6vMdMnFLZ9E8UOgbRrhaK1cawmdToMON?=
 =?us-ascii?Q?RGBXqOtVrZScYTzEDHvIB5FvIaSH4iaMYtfwWOU5hUTh2uwQ6g7R40IvdGSo?=
 =?us-ascii?Q?45TsgEduCSp9Sk/2gkjzP3rcVAHg4M4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f8fdb1-33b1-48b9-f5ad-08da4462a59e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:39:30.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLsF8Cmhnx9A4syYANa6Xkqcxm5S8/RT8pDuRWyhLbMYg3/8Ysfx02v/OjCmqTVOGGwQ2UCHZZRezK+G77BBaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_01:2022-06-01,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020024
X-Proofpoint-GUID: j-JHfHAlThFJeXEcL16yZe4gjSTJdiUx
X-Proofpoint-ORIG-GUID: j-JHfHAlThFJeXEcL16yZe4gjSTJdiUx
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
index d35d01d30fa0..987ef7165acc 100644
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

