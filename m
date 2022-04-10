Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2494FAB91
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiDJCks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243425AbiDJCkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:40:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5384ECD5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239MexTI001710;
        Sun, 10 Apr 2022 02:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Z5Ol7w/EPzmU8l38c/lxm08Onuv1cO3WEBJ69b9xmnU=;
 b=horo5eKvBFc36oxCST5ewAG4Pd4ZbuShxGvUpqZvS1ISmTWB01LznmUVEU42NfqsWESG
 9Eez4Tr6+UkuPCU2myjZ1OrTb9Y9+xktdB0SIfdSyBxI4Wk62llrLZ7ZbufTCdEE88Dj
 pIdmwMk7PyPIaouCa/wYN5JgMIvIsOy3Y23Zk9GTAjnblwFNqo0p//MaDrzZJGAqXVJ2
 sEYh7Fn+A4QCNDS2yDhbeF1Y4/gC8mWKwAf6kDdM27HMZ7iT08qY2b2r7DP014CsDTJx
 YaSe6k5izsFQYaBuNrf/jgd3vJVr8wfiifG40JW+AG9ExivadKfSJPi9GRkZk0M+q84v Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x290q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2VFpV034352;
        Sun, 10 Apr 2022 02:37:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0gmus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuGnzKq9eNuFYSIQaEUhRqmoyVWUqEl1bgld4r76lI9bUjqDXP+oPqWruSgmTA9QZJ6m6gvE+9ylSxF8+C+x/d8UnngD0CKIMyLXt6Ov+hkZRKKQ0CdQAKvTWHSF4djX2cc8NFOz+DL2hg3GJvQ1CeD8YQdlYxDtYLNGX53Oygez+pLLwbKOPQ0XKnHulRiiNlsxtWuBoB3LV0/B3pL3LKo3VSgRzrtnvYh4SrZJVdW3aSiWDJTJhRbRXaAWvSaOlaQYiWe5RFTIdjnwu93/NKMxeHeilEU5Wxr6nTvLVC1Iw2GDTq5jU2upF5lXtwTD6vJF0A2jbqLklA2S4bfxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Ol7w/EPzmU8l38c/lxm08Onuv1cO3WEBJ69b9xmnU=;
 b=mjhmPMBuZEuP2WNipNrDpmr4fRBV5zdd1st1tUCxcNu3YcE4In7uzX9/pgynqM3CMqLO6Nwyvj8e+n6SmrGLGzENPRJAzQ8k/YQ5Tg7s8UxKRtqtd7S9TPOToWnqBzv9NEqbluP+BvdigMABK+/yzHX//dUHnqSL6N08ybjVZWA+raCKSboS35YZvFBrUxLlahiXx94ir/7u9DtM53TuXWAvojVW7RYLh2FAaG6JeLzkCNCfIW93nzHHTOQGxkqcvWQrB9FUI+K1jXp/vsn/MotXB5F+otZdKC1kO4qEhwsODwHp/JC3vNI5FpUz0R8IHjIrMc0XjAOKPBDXHhuKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5Ol7w/EPzmU8l38c/lxm08Onuv1cO3WEBJ69b9xmnU=;
 b=Y9F+Ltj3vBxRfx4cMvbIp5+rShVY8QJ/fLFTDUKTucEzbUS5aGx+1YiqG5gwRJNT6gn4uGJXIZx5XIfLq2niF0rgAGr5zeuSiBTPZnZsyL/HdUjQOYqWswolYGMooZEkmnJ4POTJW/tsIDUbWwZbmwLRPFk0qE9Ly5DBHF3CpzM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:48 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/10] kernfs: Introduce interface to access per-fs rwsem.
Date:   Sun, 10 Apr 2022 12:37:17 +1000
Message-Id: <20220410023719.1752460-9-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ac67661-c33e-42d6-fbf3-08da1a9b19e6
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB123868EEE32B2982CD3AF20BB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLkWdEhobpx5wxcJDDEVEM8goNgmzoV6I3QKDU9wKvQEf0y95daPTMMDgo0lo5BHgDfn0FS79sIy0CjEq/hG0VLtfkTYnuffIHqk1HnKYamfmhozxZHPpSyWkump2QHAU8sTum3xqa/daueweWvq+MEIOf/WtS3ieEIv56nIYwpSKcBNuzDAgxdtDqqMqeKAtqdhZHPtxNjw2pUSIS/3+cUWpcS9tRvs6qkiYN6DqPnwdewk83vpHW2K6pFsOME5lqe+YoC7rVd/YM9uIfxmDMuiXNjob8AronxmT1vLzTAIHzv1pTVQfFbuuLzBWdc9OKdbvHsJHBHvZWLR/UCYOp1E37/gMo7VtAuZw4N0rXPQbk76d/FiyPIRG1d+ah7/JLhijXGk0l59wy0s0HfmEnB7Pt3vkQDoaNvptCf4VT7o2cVX9/wRjm5YiBVZUjJjAHhNs9LZZQ9T9bA9Uj9bAWBSL5MAp4yeSGt9dw+V2tphiQ/qYMsiL5CBiJ3yga4ZQ8RA/JbyMPIWlkaYnQ3Jx65sVhPmqz1dgEjyemjHHbO59nhRXiwSbKuw82uMw08MFUkQ7MzCnkJCCk/439Xnd0p6VBky0IaeegU8txurh+rUQHTBAuwsjfZztM/eEaKt+qHcIWUSuEyO09dfwJoetm4JfOgAMYv7FlTKFuReo2OfFRUmiUE6Te0aEqHRVi3p6Xr9XVneZkSedfX0uQWOCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(30864003)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84Y05QvgkH655cZjb/z0nzVLUY+HFiIYNlJUh0qfAzd5UaqWcX2uh8jgiPx2?=
 =?us-ascii?Q?9pWI/06g+5EJuiI3P3exkGT9+Lpw3D1dqSDljLd/M+luj9L6WR6Brr9gHSwD?=
 =?us-ascii?Q?QKIksTE7MVFojCNzCk4TGppANzlUn+BAMCHBPxtiyjVSZptA0pBgrNdWJMsw?=
 =?us-ascii?Q?KNjESMVDmSoVWyMTwAFuQYn3FJL+5RWWHD5/8qlRK+cedA1SsMdgTQzoTdEm?=
 =?us-ascii?Q?fJh7oWA9dfdq349amw13XO5/Qt0WU3LiQ0xFSwD9R108gLMb+1p8YTImjnOH?=
 =?us-ascii?Q?DkGuuwO5WBnozoV6ngvx/Dz5I38nTqSD5uhLRoWawdTpr4A4ccxFTMZRiBbX?=
 =?us-ascii?Q?tOfe17uOjvvmBxGqPF2xJksoEZboEJV8QtEpuvouTePI+WkjNKZYUQiXxRYN?=
 =?us-ascii?Q?yykpkXtKgaCS3bzfhaA3FHrsg8DlHpxhM94XHVosn2dZagxjWW6Bt/ub5mQV?=
 =?us-ascii?Q?mZc/2okeWEBOR/Iy9AqQPZFhpBc8FbvjWTzXsCJpOgQ/h8WCqbRBcMgyUVJx?=
 =?us-ascii?Q?7vrD78W9f4BnI6aaBoFhrDqXEAfdWITZEy1NycSo5X62pkv1EB9An6Imd50H?=
 =?us-ascii?Q?RVkncxl3Op71xv+iqlraz2cOWkxvoTgCGrS6+MtIY9eThzIqB0ycQXldMZbm?=
 =?us-ascii?Q?pg7QTBOklcpCEG28416pTlINsHu1WWM4Bo6E2lPY3Az78yvOtLxpnZfYP1X+?=
 =?us-ascii?Q?c8QPNKgRwp6IgXDe6I/uwNIj7s5Py1YedJvHu3FQjkQq3ctctna8dXO9D8jd?=
 =?us-ascii?Q?PzwTf45t87hfYNo9zJZEHwYXtS3EvDc4purYuXmJVbkNckc5YrVdQNI71muw?=
 =?us-ascii?Q?N+kDjAvN8UBOLgcIfij2tGOSOAmhySLhjTyvlJED5e9AsR+GOlZs3OmMD/Ab?=
 =?us-ascii?Q?SaxDvaFV85ArWjHBsErc/g/bc2HqlkRldd6IcihHeD9/9FJR0ArxenrpOCj0?=
 =?us-ascii?Q?PDHGPlsMqdofpm1jhFO8GUcOYn+fb8AxkrPVO4OJlN6eVI9JU3wJLDWvHJPo?=
 =?us-ascii?Q?fFZ0pNs3GnvHmk5qAT5x+EEOEX0xFbrCh5CvXAikh7DtOCvg+K0OIbpAFTZI?=
 =?us-ascii?Q?zEfC7AueWg0Ob9U2WRxg7pcHU0xg2676fll8HCRRVYUkln1hJXb8PmhqcB0h?=
 =?us-ascii?Q?E7QFm8A/52FQdvMiKkzwJWwopbSdG1W4v+/JN0UY0C/nxXx/Ym8ECk9YR3SY?=
 =?us-ascii?Q?de4WyblH1VGjx6EHiB8z9zN3q3qYtqrKRbEd1YrnSceZjZrT1u/tt+PRz+u6?=
 =?us-ascii?Q?zaO+aZZ0LLxbbqwBY624r1xyU0FzANrCRSUaWtt91VcDskjrrnTqqO8Z8mUU?=
 =?us-ascii?Q?gh/oLsHcvcVxEmDKoCrjg5DROwjbzPqz90XZg7t1KmmLkw0yYvlqgf6pVb14?=
 =?us-ascii?Q?3TomVB0iWdAElldqtK2CGQhJuHUM7QopNMJhdTEvyok2TNtpPTeMQ2052z2h?=
 =?us-ascii?Q?t3aPA75fzktMsZzgaD/3/yoLKpiH4dwfyLqLzyvBlMHDfTehl7JfiFco787c?=
 =?us-ascii?Q?Rt1Zy/Al6QQHPPv37Lfp4jyxhCQwuZjHC9lzpyuOuzMfOfMehq0+FNOcPS0E?=
 =?us-ascii?Q?g0DiZVNKjjjQlFJcjrUFKkNbn/45V+7MgHdwhoyGoNZ/5ob8dcgzWQ29V39u?=
 =?us-ascii?Q?5AL5br+lfF9kVamum3MKgsw+pgsF8EiI5SJBaIRgts1IfvYxEZWsDb2A1W1v?=
 =?us-ascii?Q?uD1GIdLRSdADfm9H7EztxA6+qjLkFlBtZxjaulZ7rbs+29VuegAAwTw3j57q?=
 =?us-ascii?Q?peHiMZ8VratirieId5Dgu2tigyEi2yA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac67661-c33e-42d6-fbf3-08da1a9b19e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:48.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/0cijGhCjdzKi+TqOWiGdnIwceBfjP7rduHg0zglRYg/c5dPAIphtmZXvMYOU8zMPJETmhtkTd8goOPBPaESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: tfWoCSAB7jgH5JSUTCRFRVFGwiCALvlT
X-Proofpoint-GUID: tfWoCSAB7jgH5JSUTCRFRVFGwiCALvlT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

per-fs rwsem is used across kernfs for synchronization purposes.
Having an interface to access it not only avoids code duplication, it
can also help in changing the underlying locking mechanism without needing
to change the lock users. For example next patch modifies this interface
to make use of hashed rwsems in place of per-fs rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 114 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   5 +-
 fs/kernfs/inode.c           |  26 ++++----
 fs/kernfs/kernfs-internal.h |  78 ++++++++++++++++++++++++
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |   6 +-
 6 files changed, 156 insertions(+), 79 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8e8c8b2c350d..f8520d842b39 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -461,10 +461,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	/**
+	 * kn has the same root as its ancestor, so it can be used to get
+	 * per-fs rwsem.
+	 */
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	kernfs_rwsem_assert_held_write(kn);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -483,7 +489,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_down_write(kn);
 }
 
 /**
@@ -718,12 +724,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -754,7 +760,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -768,7 +774,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -789,7 +795,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -821,7 +827,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	write_lock_irq(&kernfs_rename_lock);
@@ -860,12 +866,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -885,12 +891,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -1055,7 +1061,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1071,13 +1077,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			rwsem = kernfs_down_read(parent);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				kernfs_up_read(rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1088,8 +1093,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1108,10 +1112,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 0;
 }
 
@@ -1125,12 +1129,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1141,7 +1144,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1156,7 +1159,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1279,7 +1282,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1314,9 +1317,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1330,14 +1333,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(kn);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1407,11 +1410,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1497,9 +1500,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1527,9 +1530,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			kernfs_up_write(rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			rwsem = kernfs_down_write(kn);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1542,7 +1545,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -1559,7 +1562,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1567,14 +1570,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kn)
 		return 0;
@@ -1593,16 +1595,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1656,7 +1657,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -1727,14 +1728,13 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1751,12 +1751,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		kernfs_up_read(rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		rwsem = kernfs_down_read(parent);
 	}
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 0bffe5d0f510..03700388baa9 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -869,6 +869,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_root *root;
 	struct llist_node *free;
 	struct kernfs_elem_attr *attr;
+	struct rw_semaphore *rwsem;
 repeat:
 	/**
 	 * pop one off the notify_list.
@@ -888,7 +889,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -928,7 +929,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..efe5ae98abf4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -112,14 +112,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -187,14 +186,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return 0;
 }
@@ -277,22 +276,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 82c6b16645bc..0c49cf57f80f 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -165,4 +165,82 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	return &root->kernfs_rwsem;
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * kernfs_down_write() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_write(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_write(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_write - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_write(struct rw_semaphore *rwsem)
+{
+	up_write(rwsem);
+}
+
+/**
+ * kernfs_down_read() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_read(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_read(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_read - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_read(struct rw_semaphore *rwsem)
+{
+	up_read(rwsem);
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1ac36b2a89ab..0e872824b7db 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,9 +237,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
+	struct rw_semaphore *rwsem;
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
@@ -257,9 +257,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	rwsem = kernfs_down_read(info->root->kn);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f..9d4103602554 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return error;
 }
-- 
2.30.2

