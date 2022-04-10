Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270C94FAB90
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbiDJCk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiDJCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:40:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E120BFA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239F4v1R029741;
        Sun, 10 Apr 2022 02:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=CY/y9L7LrcOra1Drfru3ZKfpj+S97x8rwFLWbZSFtzs=;
 b=rjPlEELNYP9/m3iFJ0kCTEfrNiykuNLP8op9exZQ2+s7nrQDuC0w/+bkr3oX4KHqv86o
 JgKEG/TiQrMENq98Ha+LMCRx/GQ8lVCFIOn+fq6xngDsybOUNxr60etVuu6QX3spXzZP
 jgbLY4EOnMNg+4AOf2tgGlGk9gp4LblanJ/23VCJg9hkq8kGw0VHR2KlIRuxOEXD5Pkl
 IKlS1nKbqkieTL0cvyvcQOZwb+O8LTBZtB9rEY7D8vfg+Qzu/AU/zZ9iROWGk25VgOYw
 IqOLdsawfu2FXu5/uVtaNJBzhdYmFA0ztj+sZsR5Gsdq5LC1nJyVUVws1DgQnNJZXZ3F pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd1110-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2VrdH034017;
        Sun, 10 Apr 2022 02:37:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k13bft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPPRfrHVN4kpOOrTELYtkdJLfmFfaB9Tt1Fq34UG3dd2LzBOd0JgheI1hXbaZqtW57sEyEFzsH/ALiPZoboqspSizoO5RRyxIjZeqZG76HXhPXWrZBxhJWvlnfB4gYNvjiWbMlFGCXszDOyJMRrJdEb4H2vEHVUEdkw43a0q/fB5XRR4pyLUUvgn69C/Kz2b0HgTqNxotX9AfzTh3mOVZazFS0lk6ZEFVy+f14x14D8YbOM1WEdqwye3Q/buYKJSeFyYNfyMv04HktqYWbTeCGMHvNFQSRyTB5yJNQDmT5aN/maMnyTGqMdSryPIq3sc+CKNjOxEZRu2cbhycMYRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY/y9L7LrcOra1Drfru3ZKfpj+S97x8rwFLWbZSFtzs=;
 b=D5ZiA6jzGM0LK2kje8n+f3MVJ/aWRJkk2nJXBQkqAIkXsemJmRCn5TAP8NWbeQ5y8X7rZbyv7wqUv3RoeaCcsTXfAaxK56oUeiTFefjt8x6iGQ/mR1r/eaYEY01g1TbOFGc7BYwYLp1CNlHG2b/QVZ9kshTORkHbjTVOn6JJRbhL+wSB44te8Q7R+ac0hzpppgDn1ngvVJysfxZTozV+gZnN3oXXtOQNn1v5DWXub/u+bZ3+WVqsebZXZ6qSzQGotu0axU4eEFxY9it8PrvNALyacTimTW19WPmUG47v6UFEUw5ytyXNd8manssfQlicctj86Ljh/9694eeT3xuiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY/y9L7LrcOra1Drfru3ZKfpj+S97x8rwFLWbZSFtzs=;
 b=bj2eMX+p1/2xRsNBrrTyRLDAbW65Wh/4Pq0WouqFeMH+654X/qyVSRui2dRr8RM+nFGqnVJeX+h9Q8Ihx8UYdYCjAdi5ZGrB++eJaOYXVN7k4v/QItoioGlWa5FatSFqIalo4AE1dys7bDG979W+3Mxxu0cZYb3LAbIUoDpigKU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:46 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/10] kernfs: Change kernfs_rename_lock into a read-write lock.
Date:   Sun, 10 Apr 2022 12:37:16 +1000
Message-Id: <20220410023719.1752460-8-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 008d125e-a24c-4cd3-3173-08da1a9b18bf
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238485C3BCD0DE666DD33D7B0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JntIhHrfMrYfQ0f+MNVeb17/LM7lW1mUi1t5FSsBepT/J8AeCCj2zpQkjr5iKUnuvpEXoD5crgQZYk+n8qE4qLxYzgRz0CBkO5VkNGmxLsUDwIAkYa8NzU1YQgqyDyr35mbFlbnPhTEowqGIBbUeksol8505ZpDgBlN9CVS5zs3Edf0iME1aQqFKXOPcCSvjuQg7CabKyF0sV4kI0/b7wh6CZ9IUU0hJZc5L+uZRnb3RLkimMVvVh0vU2wSfwOk2xEs0rKNvFIrZRzkovdRv+dodzDVnqAM6gmDDQ6HzlsKbyRxN7LzIw473+kBewwWyerzGTd3dSeGGUDhPx2ktVj1hRcT1hrF6GVvBtJtKk7763qNLx8WdGIM3NV5vtHB57OOt4N+DkP5d75mqsPM9WJQ/xeP7bN2GIjUKFxQvOwINembqgww9C/2T1vTqi1ZpHU8H/FL4PQwBPB/LYkk9msla8yfgd5XKHcraJGyWhFgKjtmZszDUIN8RrU0RPkVDWEOrraLbTAZBkVcf/6uQNmOalJgPUP9Hc7+hWeLroD2A2HWPbsK+8ljlzW2bHKkIdWGr721+etVqSX/EKDiw9Rulwa/p4kueoDmnvsIYU2pyF8DEMooUXXAUSQMRh6185cipj5z6Xj6iHx6/iJvRt2joWAiUIyUWOmLxkNttELG94fRRVKUuShpXZcb/dWif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQ7Jl2wmVRUVKb2G/gx/449cGvqKNV/q7b5npICieQxhQGWzAxO7WBiPU9rB?=
 =?us-ascii?Q?NEfa0LMMxDosC42dRVBWj6kRkEhv8TG4ur+q4Y36oGEStG3mp8t2i9CXKW7g?=
 =?us-ascii?Q?iVfXzhP+Oh6qGp3UjTtrOlgM0tgXs3CSqrw69fdSD4y6Ms0T+4+aN668mFUQ?=
 =?us-ascii?Q?NqGNb6BQRA0n0Bs2RaabTSRVpCJ7isPAPPzfjlYa0HjE6lmmK5reyjhb++AI?=
 =?us-ascii?Q?lWobtrpIlpxCNjq7HoNjTviLDgYX2WSPns9FD1fl8vwsAFsGbRMfTe2WhFY7?=
 =?us-ascii?Q?R492qpkFCBmNbGoRu3WNyvya5eyz4qkDZL/j8VjazrNw8KTK6AaqZ5F3NdV0?=
 =?us-ascii?Q?CS8QCH/sx9TNz0fk5hdlSZeVWpu5+cuX8zdJswGwGKLucymImXrv2zxwptAC?=
 =?us-ascii?Q?v+vpTJqQ1jsxJtSMmfApfJe2rMn8I4mhOTw8Me9UXzIrWKo168Bl8yqUCzjL?=
 =?us-ascii?Q?TgXP2hPdwYBbVCxQF+pU+73uNVybwToxsbC8nGS07Ezv9y0L6kyYlz0mnDHw?=
 =?us-ascii?Q?aaVcQLHTmX+cikauas3ZyZ/DupCogvSeXaqWg3pv6BbPAduYvJ1siAVnYBen?=
 =?us-ascii?Q?6NeGlXL4ztuMx9T+bC5GvkimUAcDbbbXoqeXdTJ++0Z5CQ1Rm8PhOQcYx7zd?=
 =?us-ascii?Q?cuHk4qCX/dGcIG5TWQYZJAZput87GCPUve2K2plbHisT9pKKl4Di8bZgoJDH?=
 =?us-ascii?Q?pjIr6lFeIl9WzUk6yjTB3Zj7B3LGML/a0D12yiRcAJghnk6hivzIqLPwKALi?=
 =?us-ascii?Q?tRsuSabZA1b1N34tJryPRYrhgsAGb33IXD1seCr/Xdghdsc05X4vO9cAhfNo?=
 =?us-ascii?Q?dW5c6TUxHrbkNoYEjCs/289zhYEomkJCUEg6LkID/I1WrOeIX/oFKfvjwuXs?=
 =?us-ascii?Q?rhv1Zw62Zo2IQduvwti8DzikUDxC4UzZNI5eKSOfU8gx+nNN0pxz+jBNyZTg?=
 =?us-ascii?Q?mu8RCg43FwAhrvwQCavxAckXyjAk2GUSw4G2y/kpYDXoxdzqyqrS9ZAKUJ76?=
 =?us-ascii?Q?b+Ycw8u97TbN/qb4fBwSAT4npTo0G6jktWLLFCB+dpsqQk2VOAoqlcqAHr+Y?=
 =?us-ascii?Q?oeUU5eD1Sv1PiexmHL4P7pyPo0Gb+VZmlM4jNhW1VBXOJZ5vBxDMvs21xwFz?=
 =?us-ascii?Q?ux+hjl9q+8h3cxKqnxcp0Stf6s7AvJ1qcGeGI+1FpQg75/pq75QtQIz0w/Oz?=
 =?us-ascii?Q?1lzp6Kjxcpy/Dlkex6nBeoW+X2h3zd/BglEL4NifchDuEdGPFLKA1zpwjTC6?=
 =?us-ascii?Q?nQU+395kMqbjy4sbUOXtP5DrysRvYTAn1sAhbSvLl7IejMEyRlxR+Gkr5fv0?=
 =?us-ascii?Q?ACsZfcJYHilnMzFPoojy60QvOj24tJ7Ay150E7yR9mAXlLy/xlteOQkgBVcq?=
 =?us-ascii?Q?jT7w6yjLffxq9kyPwtZAeFxc4LbYNj3VvvrHSoF+HRS5S7V6yttwRR/W2N1d?=
 =?us-ascii?Q?RCEIU8SYw0nQtoTSpsfcpQJCfgQIrl9WcWkxyozlcG+CUyDgLzB/qvBRMcFf?=
 =?us-ascii?Q?i+QA7eaLYLxaAxudlFpFxSXOTe4ujARkvMhUJpzUtQdqYDLe826uNNTyfGDS?=
 =?us-ascii?Q?UmwPA6MGV048Zt1kqq0+TElHbhLdjgzY6+FZh5XECQygWTEe0gl6TObC3Hbn?=
 =?us-ascii?Q?tgO7uWiZT5h8Pe68txmrkQwfqJ8Sk/zZhBC0QZnnGfiKubTH0KpTT4Fq2zAJ?=
 =?us-ascii?Q?ZgdZ9lF3Cmj3ddTKCb4qQX994bUKf3AYkNbTGtFIWp1tDA42ckVYlCH8L2fK?=
 =?us-ascii?Q?09zNa2TZ+s0jP0hGKa93C1HYIju4d0s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008d125e-a24c-4cd3-3173-08da1a9b18bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:46.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAdMZKuwHV64e4pjwYNKB654e3rTbeHFNbjZxlhceufC3F6GWw6RezlbXMWgy09oI5wmdhDjcprTjaaH0Zaecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: bdOGdnNfZvs_eG_uuecm9uXmU3pkXxgo
X-Proofpoint-GUID: bdOGdnNfZvs_eG_uuecm9uXmU3pkXxgo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs_rename_lock protects a node's ->parent and ->name and its current users
can be easily divided into readers or writers of ->parent and ->name.
kernfs_rename_lock also protects a static buffer (kernfs_pr_cont_buf) which
is used to hold read attributes (name, path etc.) of a kernfs_node and we
can maintain this functionality by accessing this buffer under write_lock.
So change kernfs_rename_lock into a read-write lock for better scalability.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 17b438498c0b..8e8c8b2c350d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
@@ -184,9 +184,9 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_name_locked(kn, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 
@@ -212,9 +212,9 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
@@ -229,12 +229,12 @@ void pr_cont_kernfs_name(struct kernfs_node *kn)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	write_lock_irqsave(&kernfs_rename_lock, flags);
 
 	kernfs_name_locked(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
 	pr_cont("%s", kernfs_pr_cont_buf);
 
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	write_unlock_irqrestore(&kernfs_rename_lock, flags);
 }
 
 /**
@@ -248,7 +248,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	unsigned long flags;
 	int sz;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	write_lock_irqsave(&kernfs_rename_lock, flags);
 
 	sz = kernfs_path_from_node_locked(kn, NULL, kernfs_pr_cont_buf,
 					  sizeof(kernfs_pr_cont_buf));
@@ -265,7 +265,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	pr_cont("%s", kernfs_pr_cont_buf);
 
 out:
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	write_unlock_irqrestore(&kernfs_rename_lock, flags);
 }
 
 /**
@@ -280,10 +280,10 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	parent = kn->parent;
 	kernfs_get(parent);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return parent;
 }
@@ -824,12 +824,12 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
-	spin_lock_irq(&kernfs_rename_lock);
+	write_lock_irq(&kernfs_rename_lock);
 
 	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
 	if (len >= sizeof(kernfs_pr_cont_buf)) {
-		spin_unlock_irq(&kernfs_rename_lock);
+		write_unlock_irq(&kernfs_rename_lock);
 		return NULL;
 	}
 
@@ -841,7 +841,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 		parent = kernfs_find_ns(parent, name, ns);
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	write_unlock_irq(&kernfs_rename_lock);
 
 	return parent;
 }
@@ -1635,7 +1635,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_get(new_parent);
 
 	/* rename_lock protects ->parent and ->name accessors */
-	spin_lock_irq(&kernfs_rename_lock);
+	write_lock_irq(&kernfs_rename_lock);
 
 	old_parent = kn->parent;
 	kn->parent = new_parent;
@@ -1646,7 +1646,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		kn->name = new_name;
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	write_unlock_irq(&kernfs_rename_lock);
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
 	kernfs_link_sibling(kn);
-- 
2.30.2

