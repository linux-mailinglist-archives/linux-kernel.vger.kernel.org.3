Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D854A9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352803AbiFNHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiFNHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:04:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F44220DD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:04:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E72N5I004107;
        Tue, 14 Jun 2022 07:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=SnFRT+9RBSdsMbWgtWy7GtR7gaB+2Xl3FfnHME5XIXA=;
 b=0oJ2Ef5sQ3yuYf4xofhwR4EhH/q+uT6+P3ajeh0l+p8/vq2khUBKrKE29dZi//QvlCOK
 IXu7d++vk/gyDsIbUGPdINQ9u/m3fuLJcpQ+i+kbX6xCu19xUJ4b0RpwbAMH8ZPlnYwX
 ojmGVYJweShY6511Ko7UK0dYM5u8YjsAU7c4kOOmIN9QGAZ/B5SnU8Y22URrZR46zXMC
 Nmm1nEl6nLXSX6RlVKgcLG0bhdsvC23rT7ZbVi5y+9nxKR0jhBKLbeyUdPCwVfn6NFEN
 B9JzcLT7SEWcj8pTGZcT4vXP00Ouk70/sHGaV8u8hKQMY2oSoaayEwX522YIxcKUskKq Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2n1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E6tXIf012502;
        Tue, 14 Jun 2022 07:04:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpn7j8phd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZVIFFetpJhf17qiPnGYkNKJyEelqyM6xJFxjcUm8Ipw+UNIm47Bs+IqFoCC/y/jOCbFHxLMuXXSv7Zrh+oryfsaqaInlljx6pwK12EWfnWumn4D3r91kbi9nkeiJQqqdi6d/5R5BydC1gc8pAoMrG9tbMwbplycePm8XcHY1KsLherjfbKVCuzIoFk1aqCSwoe5z7fTUe+e8dQ7iKYYePAtBxALv5SHbxAfmzgOaL18yGJMFx9wt1cOO4OKp66rv9NOyI8qGpebz5TUsF1HEwIQkOr3Jxe8y2x4mXsJmJVbtvrbTqxhk8C3ECH6KSffuHm4DFwGscf0cVa3zkPb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnFRT+9RBSdsMbWgtWy7GtR7gaB+2Xl3FfnHME5XIXA=;
 b=ZcLd7E5mDljHrmTonoQhLZireT6Cvqp3PJCvr9fNfnqrfhf0O8qbB6Dzq40b1wLVe6bItFLHptGtHmzkmDytpeZvhol9zzEy15iyP0CgOIPTpqA4db2p2EMu+MoFldhkxdilMjsXzIbLVejNxIn3bx2qAAaK+qs8GYjNB31JrMMoICsA1Uzbsfm0dH7kBIQndq/yFeamBOF3Ag5t5meBINyUrL9c7e74EE67WPnbGy0qPsJP+e4QYQDRmeIqRLa1mVdW9wUUl5acylz7I8oDp7b6L11Ccen6ekJULuVvfF+rF/vX+ZkXgyYNSlksH5AguygZTimeyunEdDC/NVkfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnFRT+9RBSdsMbWgtWy7GtR7gaB+2Xl3FfnHME5XIXA=;
 b=JVIcHXF62c8LYCFnDwnhE8sVzEGfmMmDCy6jVwfU3r4/1YpqALEw7bW8mnsF2EmLF4vH0LM+D/tbXavfHcS7yfuHpODsZcuG/AgqFmjtfhvaXL0lOZdePz8lP6pr++CmcaXTVD5jsSVT/Onr5iXeRVWFan0AYeN+curCjWgY+hc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM8PR10MB5414.namprd10.prod.outlook.com (2603:10b6:8:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:04:00 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:04:00 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] kernfs: make ->attr.open RCU protected.
Date:   Tue, 14 Jun 2022 17:03:43 +1000
Message-Id: <20220614070346.810168-2-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5340e65-dd80-475d-1ae5-08da4dd40edd
X-MS-TrafficTypeDiagnostic: DM8PR10MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB541492B9502937B371962038B0AA9@DM8PR10MB5414.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIhc8x2FsPEYimBcNnSZkG4VUYvMb5wssbHdZ+hDpB7HvbtI2ZBN2nZNIfztC+TTAq76/u024RmxqeS9qN6suaeV3TVVBHpJ4NHQlDPDqcJt/DhYCoI2Y9MtyxBz2hWEwQyOoPHREkpiL+nY3IcnaMNd8MOwO5DUifvPpLGn0zRLKiCw2ZNgoMudHUrpY/CLj4OdF7TlWTeGsYHxGo+eDhiTPP4GpIC3QldTiNWyhEa9fo42bEr7RnIhzRATNFU2njuaPizbrNzDPZGoR5CIMgw7D7+PmVVChkWPOAjjYZcb31vLR3uEITI88Tjd6K1tfndJBGBCCK5yw+XshGOoSxK6rWQJBaLYYZBPiflUSQ7dbhxTwXzfAi7QfqcZp9g6PkOu6JlQg+oqEZ+boPxXoa8kbfFS14FIb+MJgxWmeXrseKAGu9m45wGnzLtZs5SqeCMj6IOe/MJ61fwpPC7byuQMdHEkod6wfuQ0My6AsKA7D7cPZKn3PnMhEYo4uK8lFcF435j0oT09h0aB903cJTwYZPXVAXxxF3n9umUTJGbuF5/fuWwk4Ivoa9RJEkwieS0BRA0zcKczh21iR8HlNo6ZG/gF25+9JxwA5oMHyX34eSJB1Mxj/vTFdZItsveu8CcNPD5+7lxuV1nUUC0SoBHfX5AQ4/+/rcN3iVtatas5VlmNS0FISw5EMPMcJjdeDhrm33Ne0neGqAAsk2c12w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(186003)(2906002)(8936002)(38350700002)(6506007)(83380400001)(103116003)(508600001)(4326008)(1076003)(316002)(66476007)(6666004)(38100700002)(26005)(6512007)(52116002)(5660300002)(66946007)(66556008)(36756003)(8676002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIJ9yOyU9OmqMFtp3Xq+oaAaK10WuTlKsN9vi+Rte9L1QLVyjd3m0GM5jCYt?=
 =?us-ascii?Q?lK+KERHpJokkdMhxgH63Q3N1iwxtp2Zb6T14//lsS3mXM4NYqtALa9CcJsLM?=
 =?us-ascii?Q?mPSRaKS0FeOgJbQ2Pxl3NwsHcNuacmTD+bylkq5kJqWC5y13w0AS7UrwNJ75?=
 =?us-ascii?Q?efpYJADC4NSjBgvhMDZWF7yQ/dYPTiMi98WDTDJNa//xeMSGxdf9cRg547k5?=
 =?us-ascii?Q?wb4RW5QJp/FXIllqAyYyzbhvMNIL0edILCqjur7moBjCV8DxlSQdLbknGWBq?=
 =?us-ascii?Q?Q2qEAclC1eLwWNo9KsCUJroRi2WJr2jAXZr+7j1+e04wgsyTiP5DJ6Ez+fO1?=
 =?us-ascii?Q?Z84RDzGaNiweECyaYet7d4jCWPd0pC14hBm3M/F5FFu+SvhVBYvahOb/Bip5?=
 =?us-ascii?Q?sHcm5nOfFI9csFvcrlvOZCuCvBzj966vyaRv81Od/0LkkKs5ObM1vFL8rezc?=
 =?us-ascii?Q?zNl/vx8tcSkt3YG3SDu+jHpSQGOt6NDHX4QTbemx4YP+O9t2BsCP7AaNluon?=
 =?us-ascii?Q?Rkml7GbfU8/UKhQWLsXOJD3iLskmg1B2e3Kwqag8Hp8h/LFXf5GcTivP4zrr?=
 =?us-ascii?Q?6eMjnXj8WlVmXaE8Fttv3zR1bar6XEGeZ9xPKQ+k5Mqa6v3Q7I9/b0NfnoG2?=
 =?us-ascii?Q?UT3tgxwA5SlPwr8ZhVd1VA9vGEX6X5qQJ/dG79JkJsVpqDdnUIRpPrcVWHKS?=
 =?us-ascii?Q?1EbGH/k3Np1yR6SlWdcbdpGjcgHXbZyM6i/p4V90SYeJWxD6rl8Yi65G61ds?=
 =?us-ascii?Q?UPYPhy6lZjUsk0Z2g+I1fAgC8cberj/wdUQdzvv9eYxRWnqGBPlZfLuElU5y?=
 =?us-ascii?Q?3JvpbtLFY3BgczrmJ53G9ssb3ej9PCfYrMv/7YKdMpOVYxZXJR6TNRmfP2cm?=
 =?us-ascii?Q?Xiz3zqKTLwGv0GDBN/+ZPNxgn+zsMoO1OF4w+mO0+XPvo6/NTT4ehzm4V22m?=
 =?us-ascii?Q?7gpSuJ9m7E71VzYJVeb84iHXtX0IWdPPMNGZ+U1vjrR99i+hxzd4L5uuEy+Z?=
 =?us-ascii?Q?CB2ja5WxsKUJMPL1GazswG9iWoqxa55FPDFg0I+IxJV+IVSeCDKIM0znt5yg?=
 =?us-ascii?Q?/UckYHnQVpKqpSZ7ijZGSBiBGrBeQq1vfMoRhvZjmy0/uhLewQq1RX+1mwMU?=
 =?us-ascii?Q?XovGwKLq+txyt2cb9jrAqsUgXel1uP3nA75Ral5AwlIuV8yNvRWZPszgJqGq?=
 =?us-ascii?Q?KD66bzcwfHiH4qfZIrsx1Zf4MfrSA5mP0cbLNtuaYOtU+WVwJD3B4cGJdPoe?=
 =?us-ascii?Q?lRtCxx6nzWapYu+m/gA6tsQJ5dFbOkhBx73cdnqyHwFxQp8tKMiSSGs/9HFm?=
 =?us-ascii?Q?Bjf07s8pAQbDeS/2he4Bh+xPSh6wKws2TqK5ADk6ViVFKQZobg/l1OELE9rE?=
 =?us-ascii?Q?4g63txNUmFaPwvFaynvc7tnajdCukF5Zk1HfQQ6NefeVWB2pC6Uw+79yiJb+?=
 =?us-ascii?Q?GJ9IN8n+Sea4oQuY/vH3lf9/Goj+G0HdpOUuk/VV/BLPb099cz+4ODh684qg?=
 =?us-ascii?Q?UcTQigIQaCntXOEqLp7XE1LmMd8mHn+HMPmThfqWRd27fzLBL8Sz0rpCerc2?=
 =?us-ascii?Q?CdSyHCF/kb3tRITLezUYY/7CTyqS12e9HnZx0NJyCkEW75BxDcYG48rE8rNK?=
 =?us-ascii?Q?HlrLOoRDBv7HeY6nJ4g3hiSL7SQs5qbcVscl45/ugTXcxQcSyPBsTh8Z0Hna?=
 =?us-ascii?Q?D9GdOTgiI3uDP7SY2PuPOMS93DZ8v7Dth/lY9ZCKGFmk+ZhIXt8IQQjULiXL?=
 =?us-ascii?Q?4aRjZ8FgURLiB8/946V8lIhmDoSCjWk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5340e65-dd80-475d-1ae5-08da4dd40edd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:04:00.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p67+Fcoh5zE+qqKB9sPjOMxRq/sH+FdBRbFSDSBTGO1TDjNVZN4gPQVVUIKOwdDQCvDueW8uX/tlHM6nTQ0aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140026
X-Proofpoint-GUID: Qdg1eKIfwdyxj-9NBF1D0n9THYVUe95U
X-Proofpoint-ORIG-GUID: Qdg1eKIfwdyxj-9NBF1D0n9THYVUe95U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of kernfs_open_node->refcnt in the previous patch,
kernfs_open_node_lock can be removed as well by making ->attr.open
RCU protected. kernfs_put_open_node can delegate freeing to ->attr.open
to RCU and other readers of ->attr.open can do so under rcu_read_(un)lock.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 147 ++++++++++++++++++++++++++++-------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879c..da70f00a59c17 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,16 +23,16 @@
  * for each kernfs_node with one or more open files.
  *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
+ * RCU protected.
  *
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.  kernfs_open_files are chained at
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
+	struct rcu_head		rcu_head;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -51,6 +51,52 @@ struct kernfs_open_node {
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
+/**
+ * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
+ *
+ * @of: associated kernfs_open_file instance.
+ * @kn: target kernfs_node.
+ *
+ * Fetch and return ->attr.open of @kn if @of->list is non empty.
+ * If @of->list is not empty we can safely assume that @of is on
+ * @kn->attr.open->files list and this guarantees that @kn->attr.open
+ * will not vanish i.e. dereferencing outside RCU read-side critical
+ * section is safe here.
+ *
+ * The caller needs to make sure that @of->list is not empty.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
+{
+	struct kernfs_open_node *on;
+
+	on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
+
+	return on;
+}
+
+/**
+ * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
+ *
+ * @kn: target kernfs_node.
+ *
+ * Fetch and return ->attr.open of @kn when caller holds the
+ * kernfs_open_file_mutex.
+ *
+ * Update of ->attr.open happens under kernfs_open_file_mutex. So when
+ * the caller guarantees that this mutex is being held, other updaters can't
+ * change ->attr.open and this means that we can safely deref ->attr.open
+ * outside RCU read-side critical section.
+ *
+ * The caller needs to make sure that kernfs_open_file_mutex is held.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->attr.open,
+				lockdep_is_held(&kernfs_open_file_mutex));
+}
+
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
 	return ((struct seq_file *)file->private_data)->private;
@@ -156,8 +202,12 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	if (!on)
+		return -EINVAL;
+
+	of->event = atomic_read(&on->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +230,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +252,15 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	on = kernfs_deref_open_node(of, of->kn);
+	if (!on) {
+		len = -EINVAL;
+		mutex_unlock(&of->mutex);
+		goto out_free;
+	}
+
+	of->event = atomic_read(&on->event);
+
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
 		len = ops->read(of, buf, len, iocb->ki_pos);
@@ -519,36 +578,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
- retry:
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
-
-	if (!kn->attr.open && new_on) {
-		kn->attr.open = new_on;
-		new_on = NULL;
-	}
-
-	on = kn->attr.open;
-	if (on)
-		list_add_tail(&of->list, &on->files);
-
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	on = kernfs_deref_open_node_protected(kn);
 
 	if (on) {
-		kfree(new_on);
+		list_add_tail(&of->list, &on->files);
+		mutex_unlock(&kernfs_open_file_mutex);
 		return 0;
+	} else {
+		/* not there, initialize a new one */
+		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
+		if (!new_on) {
+			mutex_unlock(&kernfs_open_file_mutex);
+			return -ENOMEM;
+		}
+		atomic_set(&new_on->event, 1);
+		init_waitqueue_head(&new_on->poll);
+		INIT_LIST_HEAD(&new_on->files);
+		list_add_tail(&of->list, &new_on->files);
+		rcu_assign_pointer(kn->attr.open, new_on);
 	}
+	mutex_unlock(&kernfs_open_file_mutex);
 
-	/* not there, initialize a new one and retry */
-	new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-	if (!new_on)
-		return -ENOMEM;
-
-	atomic_set(&new_on->event, 1);
-	init_waitqueue_head(&new_on->poll);
-	INIT_LIST_HEAD(&new_on->files);
-	goto retry;
+	return 0;
 }
 
 /**
@@ -567,24 +619,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on = kn->attr.open;
-	unsigned long flags;
+	struct kernfs_open_node *on;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+
+	on = kernfs_deref_open_node_protected(kn);
+	if (!on) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
 
 	if (of)
 		list_del(&of->list);
 
-	if (list_empty(&on->files))
-		kn->attr.open = NULL;
-	else
-		on = NULL;
+	if (list_empty(&on->files)) {
+		rcu_assign_pointer(kn->attr.open, NULL);
+		kfree_rcu(on, rcu_head);
+	}
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kfree(on);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -774,17 +827,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * check under kernfs_open_file_mutex will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
-	if (!kn->attr.open)
+	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = kernfs_deref_open_node_protected(kn);
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
 
-	on = kn->attr.open;
-
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
@@ -815,7 +867,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
+
+	if (!on)
+		return EPOLLERR;
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +977,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
-	on = kn->attr.open;
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e2ae15a6225e8..13f54f078a52a 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -114,7 +114,7 @@ struct kernfs_elem_symlink {
 
 struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
-	struct kernfs_open_node	*open;
+	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
-- 
2.30.2

