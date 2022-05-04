Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CD519C56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiEDJzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347791AbiEDJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8E27CC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2448dCZ1026258;
        Wed, 4 May 2022 09:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=gU6wVOYeq0L0zGpJVKU9iFYpmtKC2utA9UkY3KV16+0MgE32GZAk2xuRMhoH+Ie4Ukij
 exB4vTB7TRxJl6vvaJOmKIfy0pIrWVarvKvrgjpJl7y+iQmLV89DEL9ZsVcQCQUvUP2s
 JZO5XqVIsLGqsEEcY1BazHJwHipl0PgI+KOOWm139JHKTumEHo0iu5rVXhh1UQ8HUWnC
 GtXB8+nELGeCqrJ96KHXuNJUXZDu/y776XhyKllenfqPmPPxmcGKAs61Bk5AKkUZhLDu
 6MGNcMvTGXY62as7P7nYJoRMGIIMbfJ7AHeYAJbWLOVSqPzt/ov5InDpy6oDrzECvawI +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7uyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449iodH015629;
        Wed, 4 May 2022 09:51:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj37tbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2HXyKzNf+POlFosJMsvgdyOo1v1L3lnqLUPKPmVYU0oROmL18g0HRx3pMBkvr8XSAFXYNsi9ViehDXs7+el4YO5/x212X+u/sbVhPmTBgNn5cH3jA2P2QzRfqV269C6biJXOwDKMNSlnDKFnkHmoBbLnxETRWD8C/W/jXiXh+Rey/OkVVAsIBpNdPSZkr1C0pCSDKv3XLD8ZCKyt55n/qoD6+ylOjn80EKSHQASlYSBMmOXZ0K5oVfLkUrr3WIvWGjQrajUNXj2r/nuL2dCVQdNo2Z/gOh73dT9Ffu2KOxmfTYQPsUW7Onq6c9oohZhamC3GUY6jEQbgkCJfnHZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=QOJWXv1NItbeMawGDJCf/INPvDUjdkEgwtTiJ/X0d2HwnwAo9YsBpTBW7frEO1qbBwhKPGw9eshfB/jvILLXLUHIv6/KSrl9WL0iqOpCHl0bZClm+GuDEiiSdJ4mEFuy30voBbPju6OzkaBUysOWofO7GGisBvIHoxpFOWhoHxf4FzCZnmZzIGJH6ZNhoum/65dhr7r/ntzXKxrFAFwDvuRcajCgcC0L4q8tywGyFl8RW0EUY/R4J41Z8xFzsICikPUuiOE+KTIXsrTy5AIB/tv5+ZzzEqGU0M6Fxcpm2zvKnZOLO9ZQ2f4MfBw1SNUuACaA12HrNBLpJ4rcUPtR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=M8nLTRWmcLlbo6A0fF8Ve/rsDTI1EB5syXcGYU4nHbSB6BIFJXOVCGlOUuLrl4VJaXoVy6d/AUulfazomX0zhfLMWLJwD5MxpTt3l0hH2HyjDW3i/9ARlg9tPTCws5nv7qdWPVn5y+P6FZND8g4tvghx/tuNwAnCvDnUYSVW9hI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 09:51:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:47 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Wed,  4 May 2022 19:51:22 +1000
Message-Id: <20220504095123.295859-5-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee53f7d7-bd85-41f7-adfe-08da2db3b44d
X-MS-TrafficTypeDiagnostic: BLAPR10MB4899:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48992C0DD2F025A7527B266EB0C39@BLAPR10MB4899.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hjSBeR5nFGIyYTctKJpNgIX/Lg9YU+n7spX9quexnAqOTYMbtnC/PrdIU7R2UUkAydprkrY+0Zm7t3ILZIUpBX8tg7pH2UfxWoAA3kLbvpTISV03DjCxloP52A1FmxZyTa4jGTFQhbgqd3X/w+1EFYSJCYbNgUPQyuofp+zFB1KZwT+BdKq9P7R6bESzcrusypziCzUNLNGwaEeoYEAC5S/ClQ4pIQ2RifHqSdkFyvziCrdwnCzzpCBPJT4hTRUCuGOdjrOo9mG56wSFAN2sroEj3xp5WIKqsl4iZStvyVlQO3LIYKWloZpcNNyp4mSjWCipKkGRPGXstMZ3MMgTLnzMcpB6qRAprHQ6AO4NLgV55pQwGtR0a9RvkzSyTH+l+isrdnWb0Ete3bHjf4OORuLpAtOYZpXa8HIJ7KzKj5I7ZSWRY1ODa43hGNLo82k71O3kYdDBy7mNXPGIurwYBgqDEdv0IhliGicMcIMWzfEiqiwFMZty6f64+zuIBd5brGI31mNc+OEOqWiTI4ZVeEkUu3s1H6mpm/wIKqM8QP4S9Vk8TsOao0MS13mMmrSkGjUMFPKyEpZJCnIn6J/KAGFXcoq7FdrMWuLF0KrIoNzJrblgKJ47/hPbz8rjaagjgnHr5r+mZ01yS45Upbct/jPKm4TqiUC4m8FMBNjtUD9itYsaWBN0ZEr0JoIViKkk6T8RIPlrSqNlG7bmgO0OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(26005)(316002)(66476007)(6512007)(52116002)(86362001)(66556008)(8676002)(4326008)(186003)(1076003)(2616005)(6666004)(36756003)(6486002)(38350700002)(508600001)(38100700002)(6506007)(2906002)(103116003)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cbr7Bc5zNhZW2rhTIY/VMv4QArgfjQY4oTTS8CcAl43dPHD5/eqmR7H69p8t?=
 =?us-ascii?Q?cHnxgQU+DpEM5dzEKoHDjK5dxnfo4TgQ/Yknzws3l5JAwGC1p7ww38q/4usd?=
 =?us-ascii?Q?KSx9R/GBjz4R81+w0js1fUn+DqvuysGITQ1v1YF16WG0Fi6MLjFxLfCfx14K?=
 =?us-ascii?Q?jVLA9NHSXPkSGU7wGPxX/vQ8zKPfXhj6hs4Q6zznyvCPzFj/0v7WJqJ8gIph?=
 =?us-ascii?Q?Jq5JGcMY26UV1/DfphCSNYpaj3P1ihU03YBKG8pK5OjeHbt8m8EkweLcrUjU?=
 =?us-ascii?Q?K5WjVsUHOhrvhKPDevu4PwRjqGF6uthd+en8i2aodz7bxoH7JnjERc8+1mdi?=
 =?us-ascii?Q?8ZpVyT0hWcJLLuG1ocbC3QyDF4j+Z2bZP8TXsoNc84jeobG8MQDjvf6UxoPv?=
 =?us-ascii?Q?5XHp33efeLC6mALTWiS6LpzhWnuzerv5IbzV8jwW9/kUXSms25jjUIsVrc+F?=
 =?us-ascii?Q?n/M8AAirCbjShUyNXzJWnoGPEApq3LnNnjsRnXhBQHhJKTvHXCKGMkaeb0iE?=
 =?us-ascii?Q?jFlRFP9blcFCSDXggb6T8djwiJ/PU1PL7ozBn2PThMe7Cuqtu5d1qouZC8kM?=
 =?us-ascii?Q?lD2TU9k2ZspJTB4x71gXKxzs4s5wSAdnRGPWUDIjYgKzmT4ZRyKx3ynbuJkS?=
 =?us-ascii?Q?17qTQhiQoN2zN7T1l5bDvV3/6XQ61cD3FfWm2JcrscpoxzS4lFpcvN25Ujtw?=
 =?us-ascii?Q?dgjcQS1ZVWZXnL6WkQsI81kZSaKHGHmypmcKmaMQtr3Vpcv0l2wsyyxt351y?=
 =?us-ascii?Q?zo4n/WMH91CKYhqr/fZSFALCoWy+8O4qkBkhlmQSqAxq6lr6NkqVJTNmEcgB?=
 =?us-ascii?Q?Kj0rKHj6Lv8+Wya0F/C/V/j1pl76hN6thp0CHtq+ivcVwzJiPxxWddiuWVVT?=
 =?us-ascii?Q?xfLRuO41cII9TvB9B61KJtljP73hsbI1BzS2lo9xxX8vZm1s0EYY3+17QVZg?=
 =?us-ascii?Q?CKeOb6cHNIzNS8mQ/N5zGOF4Pn87M+DGQDsgkw3Z54ekHZ0WgRjJ3wy/yX+B?=
 =?us-ascii?Q?I9Vyku8o7gPXCIXCLmFk/gvYt1K2m+MSC4bAxpKvpQBUSpu7f+7stsvh0FaJ?=
 =?us-ascii?Q?Ig1D14Qba/wj6p+U1/ju7LfWZF/U1oaJT5ge7mEvQKI9tZe8OQENxfz+ud+u?=
 =?us-ascii?Q?zItBQ5GWiyTyx88enNwg7GPFmmcDKtk7iiOZDyWpv+iYdAKYNh9W3oX+Vomd?=
 =?us-ascii?Q?RfOdftRQ4Q4+L9AhcY45jUa/fEkoK+nPcBPWhvZ9P1QVCD+5zVyTs/SZpmpJ?=
 =?us-ascii?Q?GRgXXNE2YTxqMi9MxZpzzZFR9cvVaHThALo0RBKnzs59I+MnVtPzOIzTWryI?=
 =?us-ascii?Q?wHOxlpa8IF8nBvNGd1v1tgW7Z8uoXzlG8tudM28NX011jkIKBR5JhEpdNmgo?=
 =?us-ascii?Q?OiX7EcNMMfPVQeQoclbD+bCb1LU1wJgFN8oLFJpdj2IfTNm6OBkuHpOL7UKL?=
 =?us-ascii?Q?lek92Jo7hhCFFYoSplFGRIgGPl8WE+VhAYc5lIFK7OmU0pBLjcDHCXu2fUE/?=
 =?us-ascii?Q?GZ4EhtLCxiGfx7XgWNSaUUXu6XRqw7V3cOkTs1L2R/oexh2mW9MvYyXFntDa?=
 =?us-ascii?Q?80HN+XBK60yL/KRs7Os6RBTCYjpu33IBPAetJmCwY/Ix0R1K/wQnH5eRaViY?=
 =?us-ascii?Q?fSbP1vKlcjmR5HgW21Z9rzZZrRAEEk5AlfKGbQtI6wQy7VDNU3QM1nBLMutK?=
 =?us-ascii?Q?GttuGNyCpXAkBzgk6O7LpEb7Z830UV4MVs0fxgLt1H9KUGdF6B+D0RAkXajP?=
 =?us-ascii?Q?Bo+Ka+NwxTepm6t6jMYiRn5S7YBeykc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee53f7d7-bd85-41f7-adfe-08da2db3b44d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:47.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e05CNKefdqLrTBbtQK1qoSHuOc+4pQ8eNiVDByqPnLBeRZb4e9PHrFXijrc01AeddwlCAgljTx070mkZmrT9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=998 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040065
X-Proofpoint-GUID: Wbg31iDQgwKpsMCWszaMTtYTIdbgVyjX
X-Proofpoint-ORIG-GUID: Wbg31iDQgwKpsMCWszaMTtYTIdbgVyjX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 50 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 96c8493003b6..7a60074ec0a0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -49,6 +49,22 @@ struct kernfs_open_node {
 
 static LLIST_HEAD(kernfs_notify_list);
 
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 /*
  * Raw deref RCU protected kn->attr.open.
  * The caller guarantees that @on will not vanish in the middle of this
@@ -67,7 +83,7 @@ static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
 static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-					 lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 /*
@@ -78,7 +94,7 @@ static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn
 static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				      lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -551,19 +567,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_on_protected(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return 0;
 	} else {
 		/* not there, initialize a new one */
 		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
 		if (!new_on) {
-			mutex_unlock(&kernfs_open_file_mutex);
+			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
 		atomic_set(&new_on->event, 1);
@@ -572,7 +589,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -594,12 +611,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -611,7 +629,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -753,7 +771,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -770,11 +788,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 	}
 
 	kernfs_unlink_open_file(kn, of);
@@ -789,6 +808,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -804,10 +824,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_check_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -821,7 +841,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

