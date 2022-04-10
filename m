Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33474FAB8F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiDJCkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbiDJCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:40:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F6418361
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239F70Lt028689;
        Sun, 10 Apr 2022 02:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=NE865zc2G8x8jy0Jq2ZC3sS4abXHbV/sCkLxsasbllc=;
 b=SnDHv2yltkTfSPPUqy54Ly3gfrWKU9KDmKgS7sn+wxH4t30Rndk62Q+Iq4jCW1ZO1+Ko
 PnjLpJokl033S3jr6RywkVSbR9jHi2hkeo/+UIm1+pXqClBz3lfFYbC3brwN1t7aFtCQ
 k5n+Ulh0fpmPMh6QlenTshncfunICIkeNdXVEGjyzwt/g/HpgNTkdvnwxY4Wfjh/AIsK
 DKFxJf7D1MFT3RhMn+Qqr5AJnZSGmBxOyM80QVKcUfm6PLw00H/iMN5j9C8T3MIoy5hm
 W7rR160t8xQs4/0yiE1Wny3l1dkoxiL3qppJ0Sgyx7UZtYYGlQbnoIChMEhR7wjOq07G IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs0yr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2Uw16023458;
        Sun, 10 Apr 2022 02:37:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k092gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmOdRyaCBHN3GyLyXXFBqFHcn5q2H/SlPs/5jSk3rxzVanZ25tE8PPUpqwKS1+9/nGaceNjfaEu7kHwqVwOVy1tVFaROlYpcT7sZq50bAAbiooZL2OsPurvD0XkDakyQ0FfQvqyQr5AAZDItLr/c368O7GD6lH6IEKYhdtANC78OooGNd4nNvgnFoyzeXKb5dvYWL97J3BY956KgoJJOb0xBiMn4V6o8sq53FRqybb1YNebVOKycn72oLcJ/4K6Kp/M0ehfIVCleMZ7zq81Rrc8vEuvONyKQC6T6JJXxYmgvjPlMj/eGIeMbuKLapu0TJveBEFfGu+xs/xOOB6s2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE865zc2G8x8jy0Jq2ZC3sS4abXHbV/sCkLxsasbllc=;
 b=B8ziJUnxuKIpRlFb1UXpG/qAzlVx0toSCvEyjxV7y9k/kgt8WXsR4ABHWGF4hqF/ZQoq7v09aL+8jhlcRAO7+FtCoetYhaWG64JPvb3Hog2tqhVrPQXoglFq3O/uTA0IMbNb0nvBhqrxID3GnzWShuuonWMitieZuD2nkY5q0YrqU0r2RovBMPWvBwWEh3e5m7atuoTb7Y+qR2kJzB2BsPyuaZLYaa4YR+2wsBLVjMIT2b4vr2y/8Ueq8b3+5xpZBKpYikoj5ZP2oR9HkyCWD+zul4YHmyCDKV47kEDGNOs6Xu1qPGcOrV7m1vUpQ5nSD+GMKDhEGuyzaBmQwRUyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE865zc2G8x8jy0Jq2ZC3sS4abXHbV/sCkLxsasbllc=;
 b=Sgd85Vkc+VoTNGPbSm5PZASTPD4eaMx5SFlcXjPK2ejI8ZBKp35XtOTtDm9yKYcsp1+l2ubjTGfojraukTembvhaMKL/DHMW5fIv4186fjgZaLRF10l1xkXjG8IDyd06pAzGFhxLwxI7WT7EKtZdLaFGBcpXMUJngt05Un4Ite4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:44 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:44 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/10] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Sun, 10 Apr 2022 12:37:15 +1000
Message-Id: <20220410023719.1752460-7-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb08536c-20d7-48fa-faf4-08da1a9b17b8
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238BC554550926C969B80BFB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+dS+SSQ9vRYmjsDMjRBSdgohPEp2CEgtf2KTKPnlSyu/Jg4nA0JfMsvBtC/6coDowFSwKN7hAZsXgIUNHGLOzvH/65H6iLVpsdoaDeKNKhPlKCgMRdm9jlavlsBDBCewNHvcT2dx0VUvgrDUTmelBBz43n2viPdb0KHKv7MQRr4Ub2WIV5doQ/q1sj330HJME3cms9OiO3guJcSgCxq3x5mHL8KMDuZ07nlVuVhkBhjw0gyOVbzKOGtd5NQrLRJFU6Xz3JNiHK7fkKRPVPXDRoQXJw2Nlqo8xSc3niCFjaH9AWo1ZQs4cNKJBUqISvdHJnJ/ZdKFEUu4JGmT/7fOnWuOuPYmSNEYZYrXIDZBTdy44Pv4XtNSgHOwl67spGi5loHcWydkLDtdSl7/m0xGVVgq3pknNaqH9IqOhVq7LYx6L9Qr8TfqVlAYffrlS2mEYvvphpXSeQkaNChj7AoQ7yNhdtzD7P+zAN9FyQI7O4Lq7PdHiPGZF7ckDofduTqEsqpKpAecykCiElrTfKQSYul1TmK+4DZcpITuuvX7g2jbhy/iI3lUUHZDawI0rV6z1zhBo6rHuylojwiSB56Ho6N4uSc1y2IBM+QyUMZDrQmJj8xs/GWYaOSzPNnJWCwG7PDpiyCiIVqllHlDpdFFacSw37P+N13ee3sctNMIhdXPjJjrALAaHZrKAqMbIGSHwNGNrBa88Tx65fdonPyZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8IZqy40+OQSheB9CfZtqt5UpyCRvviqecURbZKp0si21zKeRvDvbfhVYUHO?=
 =?us-ascii?Q?cIihD6qx6/uEGr32vgutswKdbjIp06L6JxrEvI8xrZJuiyecwCuKx5J7kVYF?=
 =?us-ascii?Q?JOXry5bO4UxY/8QrqDpU3zoaf6MjNwM3rfkxIFNI6V1oju83NCAspCOii6H4?=
 =?us-ascii?Q?uS9QBWxsYkc5yufsy1jfQckMLsSez0bl0jJYLhRVUbilyr41J0Q7g1KKl21A?=
 =?us-ascii?Q?HHE1Fo1NmcgjlnWNX0/7cvVADcKHgJQWwmJcZV8OXBH5TlRTUhKY8Yl1d4uA?=
 =?us-ascii?Q?A4i5n27ME+MrO3Ji/MaVr/OoRlLkQfL3tLcYI//+eBB/zcxblkwUwgJaDNK6?=
 =?us-ascii?Q?LgXLy9UcliZ3WvD+wAhgx8j+VjzlRYGgKdvppsvHk1pHgqwHcENLpzZk3E+4?=
 =?us-ascii?Q?wB1TunEI0Qln2x3KPtmRlIRMxF3uBXUO7H0mRquM81oTtdo2XZ0PHROOFYvw?=
 =?us-ascii?Q?uecxzno7s1bTxH3/gIg+htqp6KUUX3WsS9o+nEqERcEzfMl6W5JMeKJiCS/F?=
 =?us-ascii?Q?yam6niiGEeZcpvg9EBbG56qr8hkU9dkTaAzqMi8UVs5B0FJrkfvkKZuegdFm?=
 =?us-ascii?Q?bkjNxkAn3WpUxbcFq7/hu6r6lmuiU3UbZzL4tuougb68KVFavcASXt+Ew/vg?=
 =?us-ascii?Q?Uc0UtalF8G81diByTT3UI1uPS/GCdSpg7lB7Z2i4vtPo7MKtsQFmAvDbeA+t?=
 =?us-ascii?Q?JP+2yyGkAh+oHsAK6mYwDcPJVkXxpE2QmSot4+ydSsJjGmP65lc1Y5j/JnAd?=
 =?us-ascii?Q?mXjjmvgHqhbYJB77JBFsqxMsO3XhMU7lhyurFNUCiOyK3nDJM09Hi/6HOTGI?=
 =?us-ascii?Q?nWn7dlYJOMjQ74IMvxiFPTdfLbwbsZ9Hni+t+WO5Q72DWX2Y+ZZsBFBNIK++?=
 =?us-ascii?Q?N8MpBI9JfzhHyeW1tprXxYFF1alfuHIEnmg5tXSIIKsqGFrBXxHu2Z+6++kR?=
 =?us-ascii?Q?U6Ew8mzGfkMXFnZxh3vgiiEvDeUSsDnOQB+nL99wrZo9v6onT8vpY0OCxMFw?=
 =?us-ascii?Q?9wRnAESg3Gtu3Y1RMc6Uf7FR88eNR9wSJaf6y/Mwy6vHLORHlRQ3UTQzuajI?=
 =?us-ascii?Q?6TksMmWUL7+kSYeTcA27fjKnDDzbkI5xEoalX+bhE+JxzqOHKVr1/JWAnNHA?=
 =?us-ascii?Q?ravaicFs59K/yZb2lBsravKBpe/PfCBJ93KNbc1stb1rKP2QqQEG6oLNDHCW?=
 =?us-ascii?Q?HrQ3ptKcX6+J7w9Sd1D+DqD3hEiz0IFZcD5R7/vvr1EfWoWI00rCqOir9dub?=
 =?us-ascii?Q?FFBs3eS+op89ZXfmZFJ5gKXhqGjHc8fE4oOwG2mFkXLyapqd2DytDACuPNTz?=
 =?us-ascii?Q?NyUX4M2CaoTgRePo1zJvK1RRz02uU7krZ/p/0xRE4JgjY+XDS9BmBpSw95G+?=
 =?us-ascii?Q?Api11Xov16BvBxLaAJ/Yl4FLHqp/bYG6HPoIMeCCgPslddHpQyJ72BcvZV+a?=
 =?us-ascii?Q?UGqyETUohiDWIKvSJmTuV6BWKh763cR404gaftt2O2WZawoxWYHwt14MTZTI?=
 =?us-ascii?Q?7+r4CemjyugD+3Ud+ZP5+7gTOMelgSVc7US29j5bpH0rP5kRF3I8sxy/klf6?=
 =?us-ascii?Q?0xJev3UKR6vdZslzRF4i0yrIH4mdAHp1m6huw7IT8weBASCCxrjIr/HKqLSH?=
 =?us-ascii?Q?aJdOXmvSS36eCJ3tJYjHvczN3tu62Auy2/LNjCYEmPM6kMmenWYnxw8PILUH?=
 =?us-ascii?Q?kDfE3s5VPt374tw5MBLMp8zYEzHtG7ZbrCh+fytUw7L4WN2e/zbBTdbgWNC/?=
 =?us-ascii?Q?GXYjWs5q5Y/X6Zc+pUi1+jQMuNglJzU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb08536c-20d7-48fa-faf4-08da1a9b17b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:44.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ4winJfthGmoY/4fBxVFj40V3/8Fc049mCWWTN2a4gOJ6V473jJ3w//6e/O8QpWT54NeuZbGqGEW375f/CaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: yD9k-EHD2wxibmQdxwcLkxTTeYSUtLqx
X-Proofpoint-GUID: yD9k-EHD2wxibmQdxwcLkxTTeYSUtLqx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
operations across kernfs and since most of these operations don't impact
kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
to list of kernfs_super_info.
This helps in reducing contention around kernfs_rwsem and also allows
operations that change/access list of kernfs_super_info to proceed without
contending for kernfs_rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 1 +
 fs/kernfs/file.c            | 2 ++
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 8 ++++----
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 61a8edc4ba8b..17b438498c0b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -917,6 +917,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
+	init_rwsem(&root->supers_rwsem);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 0946ab341ce4..0bffe5d0f510 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -890,6 +890,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
 
+	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -925,6 +926,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 		iput(inode);
 	}
+	up_write(&root->supers_rwsem);
 
 	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c..82c6b16645bc 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore     supers_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index a64a04efc9be..1ac36b2a89ab 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -347,9 +347,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		down_write(&root->supers_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		up_write(&root->supers_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -376,9 +376,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->supers_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->supers_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
-- 
2.30.2

