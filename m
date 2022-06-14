Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7D54A9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352909AbiFNHEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbiFNHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:04:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE27252B0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:04:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0o9KH027265;
        Tue, 14 Jun 2022 07:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=f3cGwwvC9rHiGqS70G11BCfnoztMDwbpLZfF6qsiarI=;
 b=CymPJsby+Cs8ouwChjIS/K5kdNrciDduj2b3p459ft2R07CDUuddxyZHXK9PFgwJEpAg
 BHRbuqBQu+G9OEONbJZPFVKSWBSiwl4z+WDQnBU/iXBj4KNE48eGnWC2+Qyqrx5SrS+s
 yjVx8BrBwgDxA2WYYMERfK9Dn/qof1tS3L9wKooRIXK3P0T6qiqIDYUeCzOSfshPKGtx
 gvgXP8sbYLadUwNlvn7BKHonf8RoBtZllP+oD3XUd0CNL+Nvoim8Yq+dMnsc9cclyJEz
 zUqP+ftaRCPVZQVlMHIsC/gESxyNPajGenU2kB4MtPcm1WEpd8UlB85kKcaQ815uLk38 BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4xf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E6u0t2033151;
        Tue, 14 Jun 2022 07:04:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpngeg731-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te8/Raf1vzFWk4gaEiOsQKQnswUV717VR/0o9FnO4pybG1+nmNAvtUXNGS+W0y5oIHG8S5JHGmGQ32v9r6jEGV0q5aBQjQRbgKI6rFjh2YG8rWIdOR5RpUwMW8s+o6OEytTx9TW/FdgxMhPD6IeY+jIS/I8NEi1QDVJEOc8tec8+xcDSZko0P2t9lOz7sWgNNjH0u4L2ikiFQYJj3gjQcxD6H+7R56Pis1IfIrsg5KzCVS1S0A5z5pO6Q+cDXYN6xZiBrpePZp8VDLG/OJf1ZF5GYBIoSYH0Gs+2FHQxFbw/dhVAguPaApyYzgBjh6GNdketm4NgaAqHQVFnIo0JOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3cGwwvC9rHiGqS70G11BCfnoztMDwbpLZfF6qsiarI=;
 b=lKKLIYj+I/OOS/TwF6WuEQhTq1IMF/o4TiDsBZUGliSHP5aKWSo7o+FjvuA6yx0E7dzBA66pCdllXNIMJl/z+7YzJIck9uaUN3QejkPoZMf5gqk2p6wKvy53dVj57mx0tGEaZ310rP1bvU6p9c0u87+YLBk85HPNsSlcktXh2ADZBCAKZ6k9QnyX+5UIslplfJeoZfnu4DsnRwTF3x1Roc64FYdVsJ4iBHoKUlBCkwm/uBauEXf6CFDqjcf4tH9o+MBKM7Pu0FPXpJARQp8bh3Ek68jsuwDk1SI5wpBBOK4d9tc8dgMGx6wgJ3pZp7T1/lXvI4OHpTgjbSquJzfrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3cGwwvC9rHiGqS70G11BCfnoztMDwbpLZfF6qsiarI=;
 b=aA5pDUg8hNtfVm9Ot3S7YOCRMnm1uu+MJnnyJR5VInnd4/2c1VmVdD1M1yiQ0EGZ9yp8XGLeMiq34rwWeMIipnD4p7T4W4qOO0jeMl1R29UWWELirECc3jM/I6c6LT551r5JJdcJLqnVdfgTe6lOsdEsclLVcECEDb81gcDI0j4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5530.namprd10.prod.outlook.com (2603:10b6:510:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:04:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:04:05 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Tue, 14 Jun 2022 17:03:46 +1000
Message-Id: <20220614070346.810168-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614070346.810168-1-imran.f.khan@oracle.com>
References: <20220614070346.810168-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:1:15::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3546ba-e54e-456d-62dc-08da4dd411cb
X-MS-TrafficTypeDiagnostic: PH0PR10MB5530:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5530A237D7A616B06DF7A918B0AA9@PH0PR10MB5530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynVqDtvzWWwhXvlOr4WmsCI6cPN7MkXmh3ftu8EY7P6NIP/OjFiCIw5Zllk2gZi6PXMKBzU7+ajVb9ab0106dpQ3s0elU0h96Pynt94wLEIbA/oE5P7raOTK+ZvbMQpXbZVDHgpKiF8YSF5PKrXrdlGkSbowkTiEAWajjh3iGDjmfqPPUiz2w9Rp6OvyCD2t005Ue+MNQIyyOUSZW+TvRfrVrKBLADyNJmhlq3E2KAfRJPCMKJc45+9fgELnfPfP65PgJ43NSTInCSpYUWtsexrE4tHlhSrvDGWhOu2ed+wM6AafmSLRt0sdzyW7dTNcYJamMnE0tHSkyT2Kvq2cTHEZ+aJ8iCICX5BB7voJkuUzOYiskzZP4EbjORg4iVX2Khl09AW84AbEbcH/5yugeDilbVmwyOEGusaHHUhRHbEisW0eYNf11apZhMna7C3xRbauL5Wv9nvUXDyUbfkL2mz4YLJajHU31ueB//ab5tOJvsZ+UZt/D2z/SQOkqfWV4DjNfZGYBH7eyUCxxuwzUzCGj+cdk2ro98CdXpgpzbpGMku7PTPPjZ0rxD+WBi7pcq46ZNL4ULKL9MV3nlMXzYeERsTS/d01ixFdaFdQiDinbyCeBvLcO44uMNX48pZp2JiigqGH1prDI9T9Tyq0Wy2AE7BK9PWnyJA4lcwcFi/YbItb4rgRWxBAQUhONjWuXgeA1iHwceP+aFmNDqp2Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(508600001)(6486002)(36756003)(5660300002)(186003)(2906002)(103116003)(66946007)(66476007)(2616005)(316002)(86362001)(1076003)(8676002)(8936002)(4326008)(6506007)(52116002)(26005)(38100700002)(6666004)(38350700002)(6512007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xeFJ4+OnA7D6Rw7+ljnrm+s03TyGs1FpxNrTwsrHrTQDw9PgAh2SY416fiGB?=
 =?us-ascii?Q?G+p2oSGKRdTsJ2PjgIYxkiSwfh/3uuUHWM4ICb7R5LGWOKyGcovubBEoB3l1?=
 =?us-ascii?Q?/xUqEOrYv4NNfyyaSQaX1Wcw3NbME/cBcWdX/6H3MpUrcbodp9zM6Vd6So2M?=
 =?us-ascii?Q?cT8GeCkpsf9xD/EkGmOXdURL/IPqUaIz2ULpez1vPVSpiJgG4fj27LJNqTcA?=
 =?us-ascii?Q?yQ49WB3u5oNhh+V3Iwgg2P25iw9zV4vp/kdxXxioSbwyMojq/4urt/5/IMEd?=
 =?us-ascii?Q?tMa4lvfbPyz42VEe/VJOKMOmf5bktKhC6qzIG/WbIv4Pi7m/Xcs9Jdzg51Bj?=
 =?us-ascii?Q?FjFTu6aLDoR9G/5NT5ZXezuMnGvWYvEwt0dUuC9kFuv/FnNoMdo8UxH6lOMT?=
 =?us-ascii?Q?5Lvg+ish64LqSkH3ByuQfBHRZdcDtHLUO4Gn7gEsr2j8mvxcLYuirzOg/I4F?=
 =?us-ascii?Q?nzblDGAMVK8Zw2hDyjUX09BG4KlzYyoWjUTz059j3OneY4r3rJjIzOeD+hUH?=
 =?us-ascii?Q?SRkFkMEkDjrG6inNPUnstZaqmvn418UGvLdWfOEW1c7WoBtFXof9DqkIvCGJ?=
 =?us-ascii?Q?ykVPKOE99Uv4vJJjGIhKpndNUxMbm0X13aEw8SsPLMBunYEM48/rMe1khPIe?=
 =?us-ascii?Q?gSXDberSENeELAOzviGna+xO9eDrEYoMbN55sbDz5EYJepdTSUgqGH+FbGL/?=
 =?us-ascii?Q?xXoZUbcYiZHYk53kZwAPtN1e/UTKPRIdH+kSAyypcoLJzVDWNSgyPJJra2TV?=
 =?us-ascii?Q?PcwHwkOJ730a1kG8PL93IdYfJSS792QTGTmpdJRF5AAFWhfUzoOk8g+3C9W4?=
 =?us-ascii?Q?j0gKcPJqbwqBOIBvvsDOIMWbKq/rG9jAQHaoi8Wthz+dH0x20KvunZj+xs1g?=
 =?us-ascii?Q?m4JZ/pdv/9vS55ThqRkLBfUuizBlI+zR7GpOcvLF7f8EK2L/5auQ/dGPuXvS?=
 =?us-ascii?Q?jHvBGhdaF/Czi88X/x/a4HIOOuH/3nsNDRbgxPp69FUCdyyRn3Cc2CRSeQ6S?=
 =?us-ascii?Q?TufSJ14caODWb3yUsgb19POk1iWtVuYEyr06Hp0Ie0w+8CHNd0sIhZSYAJUp?=
 =?us-ascii?Q?ytCjFJMhlPueA+eRl8OJLie3qEl2Pc1XE8olNSUABjcXwaMH2LcGN0rkQl78?=
 =?us-ascii?Q?0B1laNJYFN4yKjscxMhg8CgwmUbsQSQJbqOa0gEOS+boVbUtf3rXst6HJ45x?=
 =?us-ascii?Q?/A/c1r6Q+fwF+CTSWDZ0gMuxUqXTxWrL0tE4PDgsWfi1Dr9gl6L3XCszQiDI?=
 =?us-ascii?Q?Ofz83cusW3YsTN31+TdhyGH2jaZuxQb8fZYMNb+twAwEmvN0TBCpXjTmJOC0?=
 =?us-ascii?Q?LCzioFYnqoIQJkBIT9he1tHv+CwWhbvxlL5FryIF9THPBwj9mc3DniRhLdUi?=
 =?us-ascii?Q?XB2F9SvLJTVQf0xSSGlCZlcPU4IWuVN9GRUoZCtrmZvJinKRDKG2hsP92iSz?=
 =?us-ascii?Q?69ITI/jC2bTQsMre/0tSkQSNHIKWsjbrW+oRH/XYXxZja1SB7r6NECklSti6?=
 =?us-ascii?Q?T2vW4NPJ06PO2Sw9pfEwsqxmExOmyZiRGkgFL4b8obx9+pCKc9Mqbu2vrDni?=
 =?us-ascii?Q?7p3fiXd1qL11ntYLCSojXGVo0bTUwbWUf94ev3h4AbBuQ9NT/lyvpX/s2Bn/?=
 =?us-ascii?Q?YaMhZryKfED8RWUjNTrrG9L5HA9hlUmC2S2MeoSmiWcLFT9E/1nBbvC5FE/1?=
 =?us-ascii?Q?rTpvJurFYBqidyrtlFAN+mSNlR9zFhyLhd01LFihM3bYdvRvJre0KhJ+p+8o?=
 =?us-ascii?Q?q2lvLJWwpjijeB4J+oCxlkYCWylzb/Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3546ba-e54e-456d-62dc-08da4dd411cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:04:05.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv7teWZURVavaTebyMhWj4pQW5hMr8iORhO9c75V6xlkubJbR2kcuNeWfsDsEh6LZaxdkidVf2Lxmdfg2HBUDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140026
X-Proofpoint-GUID: v_HaHnp379SkwB76tlc7oZt4yGoHuiAv
X-Proofpoint-ORIG-GUID: v_HaHnp379SkwB76tlc7oZt4yGoHuiAv
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
index 38fb71b2c671e..66bf838cbf9b7 100644
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

