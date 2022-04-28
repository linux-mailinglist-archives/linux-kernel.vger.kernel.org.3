Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2DF512B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbiD1F61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbiD1F6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C27C273
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:54:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S2gEI8015530;
        Thu, 28 Apr 2022 05:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=NYUqU2H+Hyl+Y5Q2QXyluITx0VTEcn5KVonecGouIAzNaYi1xSVN4IGXYrB9jK1XvM8F
 xWdRzDSXFFuCkeqFr550KECsbGvngMpDtaPPMNV1qwYqeVJgtAwYFYk6q/kwsKN8yGEC
 QbtVU1aqpkYDMrYpuGGn8x6amdDvZdSELPS+hCV+isiyjTGh5wDVOLTkO1annCD6Bg2K
 rLOJOcBO6R8/2LSsfYhhOoI2X46tao5Ch79v+Lt+dSJldGHOhB+n1ClNmKBKEUwQiXZX
 jkM0yReBvZEPg/OSgVido/Ga8WsOhKp64NmaZl3UEEmY7lG2dzjzedR+WIfvxfjyZQnz EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9atvx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5kABF029716;
        Thu, 28 Apr 2022 05:54:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w60aww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDA0Bz6Ku4bho2GBGPjh5/vHBgWgjSU3VTYn2AwTRSwTvj9DY9Aw10pp3vEJX6BX/HH66U0a+wAsl/Tj5iW2I4tjcVndtAM+q/K53R4llif7kbpdgjHLxp3JIkLr4W/cVT8oEqP6mg5XmMYGScSFvAxf1q57c3n22NsUWYmECAs6p6ZzJK0vmYu8AYORV0gy3iBkkkAF1kYkBsHZ7kdcAPCMlVgawsL5ueziAbs5bZjVQtDLfdeXaKqllWXsln9FLw6lDAXtZZKa5q6Y/xRmf2XzRQxZ7br36dUp6HrNh3PCr1pzNrMzJ9gsM3UH3LZgz1HjN9e/TBEYpb7xvpjXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=RlX0pdiszpnA4nmvTEY+D58m0KHhLfOx9FUnc8nXwEVeZLt3BAxiqlFgnbn1r1evSnXEiGV1VHLwtJSkQQzn+7rI/zOsEE9jNQSoygsltXLYhDqrFErJ8LmXYQXyIU3LVfC45yTLIWa0RBIfMof+BZSA3As02pZSMNBbVGLpJicv35xnt7ruNPZbr5qmnD7VPGc3EPNrBG6/Ttkem3CYpssJVZNt3jaMVR2Js+i4JpnmoKfhjEpdkbxl2CUIe9bFVSqbTixQH6xG9HTfCm/LhsrgT2XycLFO0jr+5YZMz2yw8w50vK8dQBUwO7cJWXQqvWpwl9MDjemzU3KSfidhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=y024ULWJWFFgYrMEaNlIn7gArDnvIZRnB9lhqc5OzjUpfnnDo+HRORoKrBqssk4nelF7l8u9fofD+Em4QyBzKknascOzK/CeBtgZzGtU0WFx0U7a9UFRRljDd5nvZJ6nm8VkGe507LlZvlUAx0sbxOb2rDJ9FNhmydHb7qhklbs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:49 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:49 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kernfs: Change kernfs_notify_list to llist.
Date:   Thu, 28 Apr 2022 15:54:29 +1000
Message-Id: <20220428055431.3826852-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428055431.3826852-1-imran.f.khan@oracle.com>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4149e507-cd2e-412b-1dd7-08da28db9b48
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1789170BD1ECAB6556545097B0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxa2b0NKT2jtdpJat6Di9/D74Zt9WGrUumNBFDShEV8472Cf5ZR5QsQZOGlUe8IT2KiQ2O5B4DOVi/siMwaSRFWrkZ7+2Ts/JtaAuHcxjy9CDiojdQYW0Uc6t1i2FQwX2U3h4TSoewlqHdRhevM7Vrt6whho8wUkQElSBlV1oACGMhsYM5VEak6m5EzXtTUoS+ezsBgFlBSYg75nL1Z+tJLCV5yCGF+BamrpYrflcef7hMXljNJk89IWxnwtZAf8G5FnZsgcje8XD2sEK+z6Ff150PPz6wXrtpOznAWaOM9IsqbCSUGze6OsF+Pwia0JzP78B1e3oUhzJyvp5wDFKv1eKvlM0FlZ+PSis2Abgno7a9uzrWy6eSSQiIA7dcHVoNnHYLmD8UWIyuWhFWZMLhqWhAi0P0tRur1EjiAfzBeElkbYYF4jphjDNS79bYMHh379e6MsxpJ5SB5KEmTY1cX85s0Syf/kUL6NhL6W+EDoVYt62YA3ixxtu/hZ5LlUdVWtpduUL5JLd34Cnx1oUjADT3PjiklTzaF1GvqLhB/GrUn+3bGdQdFJw8qKPKoTwALHE0H2X7KjtdPSh7jAKyeHw/2dWv5rtpAmEucgCXDYWGBWJ0C9rRBbSHcX0ipHizLsLC3mT+YfiSIfC1DX+jcRRRvTkcGM09xh/OBjU3p33YL0iyiA0X9MzxxHUVBpnRoiRi/4Q0IONIO+3rk+eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfKnpUzBaDSfbx+TPaJQ/RgVAriqz/pCwNmHUtL/GAtV494+P+xnr2U50LSM?=
 =?us-ascii?Q?odnzrSyEsWtunYmvzjVCx99diLyWNRS+7z2T/Oa3a1yuVnXGgtWG6aYIgiy6?=
 =?us-ascii?Q?9vehqA/LXHuJI3IFEAJgXF4Q2abt7hqI5PMsov3TjOUfa+CcwXpwzX1kYi8o?=
 =?us-ascii?Q?88HdaSqqOTdyDHNQmYbVLWL4EJyD+UhmlVJUpCblyZOUNR80cpk8SCFKWoCg?=
 =?us-ascii?Q?18OBZGT76D5QRvRGBNEYT+/Fi5t9N1VpFpAhotRMnNNFFl+hsi1FtRVQLWlM?=
 =?us-ascii?Q?Vf+xe9vclAhwJQhsyBEBaYBkhkfKS/rIks0myDp/biHIF5GNLkp3GS6o3Mrj?=
 =?us-ascii?Q?dX0jyJ2FJaDUW05JTuVWrKd6fu+M+9Tw5E2jjIZ2udPOG2mdFgz5Rx84xmqp?=
 =?us-ascii?Q?TtEUIg5yRnXmandZSLytnKS5OfAt8Is5RgxsLafJo1TmAwCM2ur3lBsiJagT?=
 =?us-ascii?Q?DjeIaAw6ckZXnF+6qyNKciIK8zOTOdspWLzpN2lfqu4E5b4l5izrTz6fcXXO?=
 =?us-ascii?Q?WVkE5A72kcpuvCCjZDzRK9Lp3MIzKdgCbWzGdG9v84TN6b6agZYZqgriCv4h?=
 =?us-ascii?Q?O1PIl1TLE9c8JhSaHSdkwtsZND7Lm5ayG1x/YR3EPbB01CGoSUIrEUx83R3V?=
 =?us-ascii?Q?kqv3fL+tdFXnyU3dZTfY5S8QntU2V7GAAI6aqPA4RA9DrSzwm8ZseiD+AIyH?=
 =?us-ascii?Q?YxLnq9MCG0jQ+XD5bfn6D2dCAvCWsJQxmQALYPbKmyZxUSarHD3Z7bWDCwkc?=
 =?us-ascii?Q?WhD+o4SJXGDgi1Rn4IrhPvmEv1KpmxjaOLBuuHzC8zY2NEueeJmrz+Fl4YT0?=
 =?us-ascii?Q?yE417sMc/8pp3K5XA0L5ONRwtoPlTozp9M7L3FeA6KpvYrJj0uSJdev0yRjo?=
 =?us-ascii?Q?Oh/V1efxr7ukUz3fzOjbJxssU1Fp78A5egTH62Zir6BFdKWrJN+SxqpvoRZ1?=
 =?us-ascii?Q?JC9FUqiyU9ub0Hd4BIIn1NyDXK8LuMZS4TFQ+0NRC6e+pkTzszHmyFhqWeKv?=
 =?us-ascii?Q?rSSEIzaZcN5HW8ZdlFAZBx1X8W2oteMdNo5M7ve3pAzlMJATX0RRI456rBC7?=
 =?us-ascii?Q?sNb5CXIPgl1SEY0JvIt1Zr4to+bTxZEV1ltIwDYN1T5FEUY+n+RGfdhqZ8Vp?=
 =?us-ascii?Q?l3PePbjGMRUXNuzAl8ugT5myzscl67DxSo+8nieaFamKS84UNxfCDHKnPN7F?=
 =?us-ascii?Q?DI1rUtjdWEmU93Atg8YY8Tbjvcuawf530C3dN+sBY9N235V918JCrPT0/EUP?=
 =?us-ascii?Q?zLNqKd61YuhafdLG+s0wWa8PMQ2y/zpob5p43w/Urm/HE066ijauPxEGmhCQ?=
 =?us-ascii?Q?SRDyHRXo7VKJzGcFottFDvGX9JWA8QGF/AlVkAT5L0OITOvXxZNelQ1YdliK?=
 =?us-ascii?Q?Byj3jXT4mgo7KzMUr+0MC6M/uf7WlnbOIFpCNTvv3mf8762NsFIZ7sBd3+Cv?=
 =?us-ascii?Q?r3A6kVOaz6aDXTRCXPNJo2UO6hqRJY+oEGGHsS0dZF3NoDcVXDIJdOf3MRBC?=
 =?us-ascii?Q?ELX1BzP3WTu2wlHjfQZLUwMXrsorwSrcN+O3jbJpgQmsXW4904g5ZyFwwzS1?=
 =?us-ascii?Q?J8LsolYTkDI7WcvmYt11/M2AVuPlf33jWY1GaKZBoaC7QNG65Jc74rmGYQsR?=
 =?us-ascii?Q?zfFO5Zx+k74p3lNDpd/DFptd6bayTHmIi7ucQuHpRTmNQ8/kn0rIrRyg0yaQ?=
 =?us-ascii?Q?Wur1YALl9WpIrxrrO0o5N0VcMV0OYPcVkRPZeNQomiSwiLe+2wrHeB88E5gn?=
 =?us-ascii?Q?x4t0sqPB04fjN+P6KTshpTDD0wyKkXg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4149e507-cd2e-412b-1dd7-08da28db9b48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:49.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkzsaGMlNaXCL0jdgAPXgfYSUA2uktKkAJlQmrqtivcvZzSs0dme8Y8YnamBy9C89wyZ8ZBm6Tc+dEMxJVH93A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280035
X-Proofpoint-ORIG-GUID: upHP8-1U7KmGUEWVmrFw_2SfCnzhIKW_
X-Proofpoint-GUID: upHP8-1U7KmGUEWVmrFw_2SfCnzhIKW_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present kernfs_notify_list is implemented as a singly linked
list of kernfs_node(s), where last element points to itself and
value of ->attr.next tells if node is present on the list or not.
Both addition and deletion to list happen under kernfs_notify_lock.

Change kernfs_notify_list to llist so that addition to list can heppen
locklessly. We still need kernfs_notify_lock for consumers (kernfs_notify\
_workfn) because there can be multiple concurrent work items.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 36bff71ab263..96c8493003b6 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -38,18 +38,16 @@ struct kernfs_open_node {
 	struct list_head	files; /* goes through kernfs_open_file.list */
 };
 
-/*
- * kernfs_notify() may be called from any context and bounces notifications
- * through a work item.  To minimize space overhead in kernfs_node, the
- * pending queue is implemented as a singly linked list of kernfs_nodes.
- * The list is terminated with the self pointer so that whether a
- * kernfs_node is on the list or not can be determined by testing the next
- * pointer for NULL.
+/**
+ * attribute_to_node - get kernfs_node object corresponding to a kernfs attribute
+ * @ptr:	&struct kernfs_elem_attr
+ * @type:	struct kernfs_node
+ * @member:	name of member (i.e attr)
  */
-#define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
+#define attribute_to_node(ptr, type, member)	\
+	container_of(ptr, type, member)
 
-static DEFINE_SPINLOCK(kernfs_notify_lock);
-static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
+static LLIST_HEAD(kernfs_notify_list);
 
 /*
  * Raw deref RCU protected kn->attr.open.
@@ -876,18 +874,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct llist_node *free;
+	struct kernfs_elem_attr *attr;
 repeat:
 	/* pop one off the notify_list */
-	spin_lock_irq(&kernfs_notify_lock);
-	kn = kernfs_notify_list;
-	if (kn == KERNFS_NOTIFY_EOL) {
-		spin_unlock_irq(&kernfs_notify_lock);
+	free = llist_del_first(&kernfs_notify_list);
+	if (free == NULL)
 		return;
-	}
-	kernfs_notify_list = kn->attr.notify_next;
-	kn->attr.notify_next = NULL;
-	spin_unlock_irq(&kernfs_notify_lock);
 
+	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
+	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
@@ -943,12 +939,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
 void kernfs_notify(struct kernfs_node *kn)
 {
 	static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
-	unsigned long flags;
 	struct kernfs_open_node *on;
 
 	if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
 		return;
 
+	/* Because we are using llist for kernfs_notify_list */
+	WARN_ON_ONCE(in_nmi());
+
 	/* kick poll immediately */
 	rcu_read_lock();
 	on = rcu_dereference(kn->attr.open);
@@ -959,14 +957,9 @@ void kernfs_notify(struct kernfs_node *kn)
 	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
-	spin_lock_irqsave(&kernfs_notify_lock, flags);
-	if (!kn->attr.notify_next) {
-		kernfs_get(kn);
-		kn->attr.notify_next = kernfs_notify_list;
-		kernfs_notify_list = kn;
-		schedule_work(&kernfs_notify_work);
-	}
-	spin_unlock_irqrestore(&kernfs_notify_lock, flags);
+	kernfs_get(kn);
+	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+	schedule_work(&kernfs_notify_work);
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 13f54f078a52..2dd9c8df0f4f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -116,7 +116,7 @@ struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
 	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
-	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
+	struct llist_node	notify_next;	/* for kernfs_notify() */
 };
 
 /*
-- 
2.30.2

