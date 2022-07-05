Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3DA567833
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiGEULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGEUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:10:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD719192BF;
        Tue,  5 Jul 2022 13:10:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265Jn1qX001416;
        Tue, 5 Jul 2022 20:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=g6fYCjPVMf9rzmSn4wKHMIAAiJ1afNlIgW7YNkIIxok=;
 b=fCWgCQdbnNSGAm5h5ax2KTujap9iR9bMgtZaw9FMXxrzIdwccWE/+UWIM+81WsBxHqRc
 JRLUAjDe2Gapf+X+5oqMNz61FNGQ84zsmkCXiQW7k45OaMHJdclL5GcTOaHqswMYHlCF
 m+pgedcjYoC6rfGFcO883fea2+BOGigi+pMiikKSauQkPQBUsWK76x6kOagbMMsf9HsV
 si/nQmTVB5g9Mf1H5HkemPhne7t7GdqUI50SxHTCy5sbi/SDZ5bfCAhios4/0u0ySLtk
 KT3+Lh0BtD/BmzBy4dU7sHmcDR+jrK69I4L/9NJ1bd+qs7iPM6K6RTCmCQP1eykp1HWt mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyr3fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:10:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265K5vpl035934;
        Tue, 5 Jul 2022 20:10:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ude15de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 20:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUtnZaIHLyRMczMacTqjd8MSZnz4UiJWV+0md34AsDEvmbZuWcX8S+S9Eyu8KWzH+wN6ashrHZtiZUvlxYRpWovPBUS2zmLvYBikpl6vj1RBNLlmnKBtPLUtGhPY3A5PYV2i/3lWJp0dbbJuKDCd1/LKkaUyQ/eTAWU8bQAWemZOqqS8Dl3f0Mb1b0ztNBQ+0tuV8DIWln6+hhWM8ZVgBFc0Yr+WZaEcGW+0hZwXWq+0XkAmt067GiRnBZzB+eKmWd9GTzkHuR7hKRLH/2g73VFoD3Un2gFYW/z7GkHB3VM2fNCEnQ4eYJjPnmjqrsNIkeRaXZdPjM5lZsIUgIObwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6fYCjPVMf9rzmSn4wKHMIAAiJ1afNlIgW7YNkIIxok=;
 b=NNd1OPPJEs5QvPMColU+5EKMOYfxmATKvOCXw/3uwQebczeUwOLwJa0dpzdddQ2ow1Zw0GDQS3k7Nfngv3I6+jYCcYOUvoYhDUKOo/w0DcBD+i4YO75Ai3KpGqXzwMVl1W+jJcS5aY295ocDK0yxEqLcKPELRFwshAXNbOrsOma6IaILbZFcrZ4hyo3u0Spe7rs+Ky2LPIrF/hbw74duI6z1o9J+yWscwx5+zEwsq16xY8jxS23YnlQYz/qSB8VvK841WjLNr2/IzISoOMkJl5R0/aoWttOI1zshgNBE6nL31HGvrk0QLuAHUuWR65ardMDs1+okqyED/tUuT8OGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6fYCjPVMf9rzmSn4wKHMIAAiJ1afNlIgW7YNkIIxok=;
 b=oufuRQOOo7LIbDcmXaPXmzly5cz805o8nsvJ63h4K6M5S43eEM3+TClTMvMrUEmpiUJ+0st8IEWveQXBbUg/XXWP6jDrKjp3FQD9Np+UCurQA/MQnDV6c59pJJiK7EFoR/Ptrd+tsrCpfbLalo+eSmZN8CSRcJmA4W7n14uRdC8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 20:10:38 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 20:10:38 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: [PATCH] Revert "kernfs: Change kernfs_notify_list to llist."
Date:   Wed,  6 Jul 2022 06:10:26 +1000
Message-Id: <20220705201026.2487665-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365a9ab8-e2fe-4318-3598-08da5ec26db7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUaNJr2EivH9E93ZICSAVZ4M6rM+ChXFDds5WLlsnK7VBCzq29wRrpvzgmhKcot4aIWwSVT3DHr6DW0ZzNsqxE1Hv2ffq6e2koxEKuG3HwEIp7AgwuvVTW70yeJIdHdf+zrOs2puFzD8LSQpCS0KSZDVai2ux6Q2yH8EzX5eCbFrnMuuIaDZbWwkDL4hQPJUlYvN7+hxvbnBApXf5PkAHJFhrgjPusutaDrMJ8d/HfOmCj/pt7BpY4b95UXN95MFL1HPtEfm7yQLLwkjeHiS286ztVFyXVtM36wP6GbV9fRrROaifMc07tzK+MbZWQb38oRESFYm00IV9EUrU1PIE0lAd7BfHidDjWRnz2kDnewPY2OO/xYKTx0RVJmqQmUlatxwpiPvcBM+vyv/kDcjGSySMJYxSE65QXW4iWwkTZR//xRidV3aYqzAeAwcE3MxfmxBlXM739zg5Ro/rSpSlRqokBXAAr9LJ08mYExUBkKIHz9X1FSiqNHUXUDwjopgv4ByqfekNdVsRl4yPJ1YKHXsXG+hBCtCmbbbW0w5eZkq74D0OXGXzDEELf8HxOYcn7zUcisfQMShhwiqROtITmMg84sGZgA220J/inmsu5AQFU+HWAS/N4gilCS1Y1T9zvqwuX84tCfkEymLoqeimSqGVwKjO1k661ywuALfFwxXAfmbx0Yf0XRBSsrVH7aJypzr+qfHLb2nV1QY9y8Gpls32mm5aCs+Gcv7C5ZMj+UGoRi65AXRTS1m3kgjtQ+TrIh/3BQas/c7vCrZt3FucCiK9srVbNzoEQ0rzESvE1tCddeL49FYBGwiitJjiopO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(7416002)(478600001)(5660300002)(8936002)(103116003)(6486002)(52116002)(6506007)(86362001)(26005)(6512007)(41300700001)(2906002)(6666004)(38100700002)(38350700002)(2616005)(186003)(1076003)(83380400001)(66946007)(66556008)(66476007)(36756003)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YpC4V+cboh8PZU9/V8+NLpeDg1QV+c7x9zDy+96lcxlTCqVnyxSQV86r6sQW?=
 =?us-ascii?Q?HT7ovffak2nul3D7O65ZqzauydsDRkZWHkKP7sh6nx7kHSIdSHIJywTHMTpX?=
 =?us-ascii?Q?cU3/vlnY/XnkFdpvsprewPBDI3QfdstuZ7HDO2oA5EZxQySv+12kKlBp3Mcu?=
 =?us-ascii?Q?XKVNgN1pY85TL90zO5HTwN58ATTfKOhkUEITBJG2ufDFgyLr1CjfeR7FkyOS?=
 =?us-ascii?Q?HMD+2nEC4mgXxoK1KXHDTrgSe86XhPbiYUwV8f/+FmodaQlB7BlXy/mdOYV8?=
 =?us-ascii?Q?J6oRWHfd49E7ra+el+ZAWCQ3JIIXqYaDNUPOaHQIcMYTfVwOR3QuxYdPHFoV?=
 =?us-ascii?Q?WUYH8/2i1pFpGVbXGVVIMQn2l2AGG1Gxk/ohgPTFslhjUSGb2ASBFeYdR12A?=
 =?us-ascii?Q?AKH2OiMFdwRNJTxA9DRfI4lMsLNDXNuw3WweG6g/CTUS1XOZ3oYtmmcGMYHj?=
 =?us-ascii?Q?72NZCj2jjLKJzwHPO5J78iGQvrRsVv7CEWFgXbVOQBcY48QubYHMWA9H4zjf?=
 =?us-ascii?Q?nNvhJcEeuGxgklcvU22GXmkGjphIyN90VN96jVogWQhgz7+9b1P3v8fRkHl2?=
 =?us-ascii?Q?N6ee2u9S1lQ713TzdaxR8wx/At+awTRhZryEhVAL8D7QvBAmz0Ykw2c3nEHx?=
 =?us-ascii?Q?/XuQ0lQtz4F4tpNimTeooFKz9MXGVXxybEhQdO/t+vuXNlKpG+Bgwi3KAFvb?=
 =?us-ascii?Q?mksbsrwyKrBFBv2UDTUV/oMHRIpbKIikgEVwYwhnNmRWAYRvW5OD+JgYyt6S?=
 =?us-ascii?Q?cwxWWrBcE5AU1zeHAnaTuNElV4Iob8XPNIHgWjgI/KL5pGrCFIQdbJO4k3YL?=
 =?us-ascii?Q?K56dNfSHcK45/EiMD9JLeX7asEC38Cbix4CYocqi7ixXFsSIK+/kWlPVIpeY?=
 =?us-ascii?Q?ZpbKqoYTHaRbFonaLKe2QQA2AIU+KGCTEeY4NH/HHU1Yfq/uftIriP3zwnW2?=
 =?us-ascii?Q?aLDU20fINoK3Ol6RWTUy5HnzmBMQ3JuguRiHJhPqCtG7eV0ibESq+FYTd3N9?=
 =?us-ascii?Q?X6jP782d3mERP/9S5htlKhfgEOexHqLtHVILs3cl5KNCESQSdimgDXTa52zu?=
 =?us-ascii?Q?ZU6cS0yyxy4CI05SwJn9UgP1rEcHrOo0LO3ZTbQipDCbLC0tODq/yk83yn31?=
 =?us-ascii?Q?VzBBcmF5S0K629XDGak0nscYQEwzJkaZYxiKMIx/4tcUbi2SKriEeOiXQQXY?=
 =?us-ascii?Q?yz1Q1J55F9Em7pA2iGAMoI7OBn2F0cu0h7KN4acjTjevGN8gofXq9n7ymtr5?=
 =?us-ascii?Q?kG/HPTL0FgGPHyopXnxWh/eHwwpwJxYNBRbqoGlsAdVJSeIjruihYRrBuLHC?=
 =?us-ascii?Q?ee2b8oE+9paEwUZXoXBsx0RLb82zQX9fXmrh0zpLBSMCVeb0SQE1vKqgk114?=
 =?us-ascii?Q?skwLXslukBzDXV0AozoC995wix6G+qQdkI4BPngRXvo6MVfPGXmyAeBLVtAj?=
 =?us-ascii?Q?o+FnLzblMKEh9Hv4TyFeM8AvJhn/miec6g0PJKOIKgYv1nQYemLy6dvgKlxB?=
 =?us-ascii?Q?SfJ/B1Q5XUezOMIcqRdf/CYXiWH2K22+cQ+ndTnIxIeKaQRdrwiAjbN3tQJ0?=
 =?us-ascii?Q?yAOzBqOh/BzPBlxtaLLQ0Pd13gyuuqA8UthgNQUkJHsWHic/IS58ImFbg/jM?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365a9ab8-e2fe-4318-3598-08da5ec26db7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 20:10:38.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4Bm3d7kc9vS4OZXF++UtgMM+ERrVXq7zeo6olWRqIuDQj0bJsu7PvhfVzdaWkyBB1uOVB0Syi6+bgpx4g9PwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_18:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050087
X-Proofpoint-ORIG-GUID: tLSc0nKqBqY-T5CkykVzIFh15uF2EozF
X-Proofpoint-GUID: tLSc0nKqBqY-T5CkykVzIFh15uF2EozF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b8f35fa1188b84035c59d4842826c4e93a1b1c9f.

This is causing regression due to same kernfs_node getting
added multiple times in kernfs_notify_list so revert it until
safe way of using llist in this context is found.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Michael Walle <michael@walle.cc>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++++++++------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bb933221b4bae..baff4b1d40c76 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -25,16 +25,18 @@ struct kernfs_open_node {
 	struct list_head	files; /* goes through kernfs_open_file.list */
 };
 
-/**
- * attribute_to_node - get kernfs_node object corresponding to a kernfs attribute
- * @ptr:	&struct kernfs_elem_attr
- * @type:	struct kernfs_node
- * @member:	name of member (i.e attr)
+/*
+ * kernfs_notify() may be called from any context and bounces notifications
+ * through a work item.  To minimize space overhead in kernfs_node, the
+ * pending queue is implemented as a singly linked list of kernfs_nodes.
+ * The list is terminated with the self pointer so that whether a
+ * kernfs_node is on the list or not can be determined by testing the next
+ * pointer for NULL.
  */
-#define attribute_to_node(ptr, type, member)	\
-	container_of(ptr, type, member)
+#define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
 
-static LLIST_HEAD(kernfs_notify_list);
+static DEFINE_SPINLOCK(kernfs_notify_lock);
+static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
@@ -909,16 +911,18 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
-	struct llist_node *free;
-	struct kernfs_elem_attr *attr;
 repeat:
 	/* pop one off the notify_list */
-	free = llist_del_first(&kernfs_notify_list);
-	if (free == NULL)
+	spin_lock_irq(&kernfs_notify_lock);
+	kn = kernfs_notify_list;
+	if (kn == KERNFS_NOTIFY_EOL) {
+		spin_unlock_irq(&kernfs_notify_lock);
 		return;
+	}
+	kernfs_notify_list = kn->attr.notify_next;
+	kn->attr.notify_next = NULL;
+	spin_unlock_irq(&kernfs_notify_lock);
 
-	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
-	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
@@ -974,14 +978,12 @@ static void kernfs_notify_workfn(struct work_struct *work)
 void kernfs_notify(struct kernfs_node *kn)
 {
 	static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
+	unsigned long flags;
 	struct kernfs_open_node *on;
 
 	if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
 		return;
 
-	/* Because we are using llist for kernfs_notify_list */
-	WARN_ON_ONCE(in_nmi());
-
 	/* kick poll immediately */
 	rcu_read_lock();
 	on = rcu_dereference(kn->attr.open);
@@ -992,9 +994,14 @@ void kernfs_notify(struct kernfs_node *kn)
 	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
-	kernfs_get(kn);
-	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
-	schedule_work(&kernfs_notify_work);
+	spin_lock_irqsave(&kernfs_notify_lock, flags);
+	if (!kn->attr.notify_next) {
+		kernfs_get(kn);
+		kn->attr.notify_next = kernfs_notify_list;
+		kernfs_notify_list = kn;
+		schedule_work(&kernfs_notify_work);
+	}
+	spin_unlock_irqrestore(&kernfs_notify_lock, flags);
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 13e703f615f79..367044d7708c6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -173,7 +173,7 @@ struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
 	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
-	struct llist_node	notify_next;	/* for kernfs_notify() */
+	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
 
 /*

base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
-- 
2.30.2

