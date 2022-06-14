Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FA54A9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352847AbiFNHEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348730AbiFNHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:04:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51782252B0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:04:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1CYSC025268;
        Tue, 14 Jun 2022 07:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gdHLfjg4pPkAcdiHPFHHk4jqZpKS6AtEQrF+Jm8La/8=;
 b=WU1Ed4X79NwmbiCO4zwcHwvCE3zMzllBeKtGelwU5dxeS1JhLirfH2GNo/wyIvHgu1PY
 zgjMZ+2RQ3aPvOTXBQ0WEARdyX4lHbAM/a5QVRV+/GWZZQ06VBCr/Bj10e7bdBmS6bA4
 dY4Ydh0VaYsmxq9ZkgEPMbkC3Dq1T5CXXGaGLYJQjHxb+Z5qAI2jOWzp33fEe0HxCLMs
 Jv4ydAIqqWZZiZXv+uFubxSSEOV2uaWRpyQNlKSHYImj0/U8CAbE062thpl+rsdeb30p
 rTalhQ++7o645zwD33eWDgGuKA86L1fX6EzKDcR850Ixw9w79QtOWxE5FZLiA3X5bYi4 gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0d0fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E6uEZX028696;
        Tue, 14 Jun 2022 07:04:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpngj89ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4zswYycEmBZepZP+fLvz2QXJ8qTSg3/QF+TJFTT2bCSfxzjnEdNfmjucULyp1+5lTeIyvkuDk7K9+x6cr3clfzyZAhYxhebRi/w/lc3CcmV7PdXy53WAY2ZR9M53qiTTu91wA2AZ9mqTVyHso6KHh8NXi4FhDzMkCbbt3pNq7+hQUaro8tEQvKUfAg0G/vWG7ucsjzFbcVQdGRKfTR78dgkSkyh6ok87gXbt9rseZiEL4WvqGUBdcz/saW79+OA8lAnlPlcllepfIB5KBnklN3dK9JAhudo7mapa+1YLZMYYsuFR9/N1XXZ7DF1LarsPKeg1/iTCMLgikDeICvA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdHLfjg4pPkAcdiHPFHHk4jqZpKS6AtEQrF+Jm8La/8=;
 b=eUId9sQZ0x6rVT0sWFm/k1fr3RVm/9UzH+3x6UlwEHuio9ppmZA6hiXWVN7Q/M6JE1I1DgNKugBQJjVbfOEEXAX20VBInWrMLxwQUrfLafWR+JRkbcPFYfrB9XEDEZb7GAmbgaZMeENscrBUPvKhgwV/wPRBjs9E34Vdwopke9CfpQzW1XyfXNf8aB1c2F45Ny5egtApUTpa0FFfb+0k21qYOEb4VCFjT6JUcZnbly5kqWFwqilQB0ZjuhyFrRSCfxih3d1fpxpg3P0OQ+mVwq+rYjYD+iDbouk5AhWDzKXJDg0iR8XbufcrynDvb8nQzpq6WajB+4lPYX3b1MNFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdHLfjg4pPkAcdiHPFHHk4jqZpKS6AtEQrF+Jm8La/8=;
 b=iNiNNDlKkuo+oZUPWHgodHQ3FKzOBoJfSFB5iireu1BnoCWHPuqrXL1k/b5AcP/7xsZeU0zyIV0Z5nMYYZo+3zwvFMkTZqxD+KEStiDepY9edA9+IxMiswY9xXojS79MgQ1r6BS++/VxlpIqe2lpGIV1JWDtU39bvtkEocZvWwI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM8PR10MB5414.namprd10.prod.outlook.com (2603:10b6:8:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:04:04 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:04:03 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Tue, 14 Jun 2022 17:03:45 +1000
Message-Id: <20220614070346.810168-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64b8c0fb-0960-4dfa-e1e2-08da4dd410d0
X-MS-TrafficTypeDiagnostic: DM8PR10MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB54147FDF6FA3CA657984CF10B0AA9@DM8PR10MB5414.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36R6Yt+voPOf/4beI20OaHqdnrir67TkRquLc8GjSte66TJF3s9wqTLMkgp9W78yFpnGMSUBEVot8+MtuDqpRIKS9RSDqX07APl4bc8YRVTfN/Bpl6thyaofDZ4r4JuiEbw5TcholOY7wbuisIB2mtfgM8dC8h0h+v0LYLiY+BA9BY2Z9m+u/7waHiql10ixOi9Qu3dQw13g3xBfFBh1opeD8Cpw/ZseQArIDFhA+bBPGmXt64xe7P9edRo5F6vDm8arUecknS6/0Arko8pBmIzVs1irEqWvf/GYNQiEL+uk4HkHhpH4YtCp1avhX5Ci5MxgRhw2KB0XWAMeSgngR/vKAB1ACHYv6in2GHH5TTCbrEeDMKBZqlcAd9D7HcbsmkXep8iqLp0lIivJ0RuSMNXSVVKKwWrt7aF62Ozin36tW8X7vK2Q9qhXRk8ZGbX7xUucYyPU2c09D9KKDqffrM14ExYPiOq1K6S+zOnj+6QaK+/FJrZax9TvH5nvolw3UuWz7iqAoWv2osRsjQfA3zLeVo+LbM078+x2QNM7sfr9shKkg9qNtEl48NTYdY+9Ix95c0yk/EZk3l5oZV/I95032WEgXyfkPebPeadAg9K7M+qlpGSyqe9u7O/8LBJXUr+iuC/dd621Pw9VPC+vMteEYdL9zA5cB7FxxV/CV91mUs/bUkutHqzT3KrC6eC/5XQeMXj3xzLEHolWWDYVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(186003)(2906002)(8936002)(38350700002)(6506007)(83380400001)(103116003)(508600001)(4326008)(1076003)(316002)(66476007)(6666004)(38100700002)(26005)(6512007)(52116002)(5660300002)(66946007)(66556008)(36756003)(8676002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9KHyY7QCPnHGbjdESyRDNLQ5bLFWRJ72mZtDgiNpB5j4ALaqT5rKZCM6p0j?=
 =?us-ascii?Q?/Vv7MuERp92RccT+itAU+RHx33AsSDJbudOzL0tn17frVcmOUriaHsqo9ErU?=
 =?us-ascii?Q?hWsUNe7H+SiLY0hZxiEM9bYs+Ub5TngYCmrA0eSk1Sa9xi9j99LanCyC49id?=
 =?us-ascii?Q?XbyUSerwBxM701Lt3UyLaEJlA8VTGmj1CMGeDJwqe54zqW6L+ddMQ3mFukX4?=
 =?us-ascii?Q?4OliDKdtJx/U9n6HoxmnGY1oHV3VMaexuD8LaNBMp4SkfpMLzmWPOd5E9wsK?=
 =?us-ascii?Q?Ys58TFfeMimzlQFYTnUrTDtlqrKayptf8bGmJk9icRi+brEHy/hL5RdbJYct?=
 =?us-ascii?Q?qzcKeW3p+Wx9cDDI4hUjlws6Dxm7u9DQJnjQqIYB9vP4/s1qhcu81zaJjYSC?=
 =?us-ascii?Q?BlOfg3T3vxtFF7k34V1mwt9iZ1buWFaLrejf/2d2ZSxcHFcurExGVUZiUQyA?=
 =?us-ascii?Q?T/W7QmZYu1Zlgfs8kBSbhH61c7iEPYwRJgGXHK3BDYiglKZ3jvOYMk9Mw2ww?=
 =?us-ascii?Q?K6+3jL0gPmCC6n2Hlu0rmrIL1St3V8rmyfts+SIU/4zGkEdW4HNAdpfCFWFF?=
 =?us-ascii?Q?k0SjkzkeEeieGy9QGJENCZgfRNhbFDX/6TWj3E6D0bnByJopP+hw9QU85Eq3?=
 =?us-ascii?Q?EZ1q3RXYi6t2lU300Su04JQarQGvv2r9WrjGnWu3HF2MHm4MU+0WELutvcVm?=
 =?us-ascii?Q?yPsZOyI6oi+wm+H3y9TkFYC9YRjBOeh1w4vSDqcx5wuiYnA8rWoiN3/iuchP?=
 =?us-ascii?Q?if/S4tYFovPn51AxCgHlihPulrdtRbNHwvmXnXgdmaxMAbhKap9CRUXn20wl?=
 =?us-ascii?Q?D1upzxHaMr/BRRxEvH8meUdRsHBYApAMMc6hpAtLftPl5lsKCdjDJqmupSNB?=
 =?us-ascii?Q?0t36MgFp0oa8WN5vweJUFzMjwY9EeRUpCTGzIjxz4G34/f/zwuTgBIXhrG/y?=
 =?us-ascii?Q?aAH1Eiq7iSznyKVPpdhIQN2Bm+LXmczsgmqM5IpdRupUQsrWWoVIgncwngCQ?=
 =?us-ascii?Q?pR3R2TxPRE6Zm5Ks+SEcOMuBaUtiro30GZqiAjqRi4aHTkgxFbECM810tDgG?=
 =?us-ascii?Q?Q378F2ZscfUhSfgi1XA0pFuhu1R+Tn31uwYfaE24nQE2FMUmeoEymDwRo2gm?=
 =?us-ascii?Q?paNqqO1qVQEDN45dVv5YrlF+PxA4lJ2Z3RuP68lmA9WChu5GIRsHrp5ewOu8?=
 =?us-ascii?Q?lnZr8M2d+F+K4FMQKRjMx1wgKAPbSp92kob+u/5jT52KsHQsVs3UbPnj2zUJ?=
 =?us-ascii?Q?zg90JxMgS3MzvKdC/h6jxhrpx0VXqjBXUmXdoo7myHkVyp7LzTsQP0dFv3To?=
 =?us-ascii?Q?wHwwz7J77jTdwig7/4vjjo4cJwg++WxG2CdL7O5R2Bi9ZyKjT+ARH9gCLJ1F?=
 =?us-ascii?Q?CPUBMW528yOteYf2+B8cml4xhPNH0Lr9kfuIEEj+P55zgQqzwUobiXheDy16?=
 =?us-ascii?Q?l+pfM1zB2Twhvc3QjXWv0ErHiiQP0gwG+Z+BDZ45/zcrOKWgH6ZELZwjU7eI?=
 =?us-ascii?Q?MDqu2rG/SWn/+D9hdmk+Kc7vXkOI6zodmKhKLT3fjlH0qbMHpL50bmarX55f?=
 =?us-ascii?Q?oP2yupJ0JS0qEtBRtuIV2ATRQoqkzITG8C3+t/ctmZIVJE1LuOL5q+BFOpgB?=
 =?us-ascii?Q?Fe+yJlFryllZINi759RsNm9VZ9zaR/bHSUM2cZkQqpMquZO4P0BPftReR8aR?=
 =?us-ascii?Q?Orv+XoRcTkhEB/I3dtgMLa1ayhgHP9cfShc6DYhVZonrpX1m1fj1FP3SHJ+/?=
 =?us-ascii?Q?zR2TNmg12wCMk9Snk8DWelO+88YGmp4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b8c0fb-0960-4dfa-e1e2-08da4dd410d0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:04:03.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHsaE85xZETepmXNIC9n5Xwf5++Bak+eaKQ+b71V370c7xb+5cPwr877Wnrg7rAuXNkQqN7ISPIqUIzGqAj6qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140026
X-Proofpoint-GUID: B2MuJ0zO4JQGo00jxQMYR4ZRcpPb-C-I
X-Proofpoint-ORIG-GUID: B2MuJ0zO4JQGo00jxQMYR4ZRcpPb-C-I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c | 56 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 77aeb0b6f992b..38fb71b2c671e 100644
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
 /**
  * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
  *
@@ -79,9 +95,9 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
  * @kn: target kernfs_node.
  *
  * Fetch and return ->attr.open of @kn when caller holds the
- * kernfs_open_file_mutex.
+ * kernfs_open_file_mutex_ptr(kn).
  *
- * Update of ->attr.open happens under kernfs_open_file_mutex. So when
+ * Update of ->attr.open happens under kernfs_open_file_mutex_ptr(kn). So when
  * the caller guarantees that this mutex is being held, other updaters can't
  * change ->attr.open and this means that we can safely deref ->attr.open
  * outside RCU read-side critical section.
@@ -92,7 +108,7 @@ static struct kernfs_open_node *
 kernfs_deref_open_node_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				lockdep_is_held(&kernfs_open_file_mutex));
+				lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -575,19 +591,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_protected(kn);
 
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
@@ -596,7 +613,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -618,12 +635,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -635,7 +653,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -773,11 +791,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @kernfs_open_file_mutex_ptr(kn) is enough. @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -794,11 +812,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -813,6 +832,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -822,16 +842,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * ->attr.open at this point of time. This check allows early bail out
 	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
 	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
-	 * check under kernfs_open_file_mutex will ensure bailing out if
+	 * check under kernfs_open_file_mutex_ptr(kn) will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -845,7 +865,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

