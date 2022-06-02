Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201853B3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiFBGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiFBGjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:39:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48929C128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:39:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2526Hx3k001846;
        Thu, 2 Jun 2022 06:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UxIYfUMvr/J7q4ABiB5tYZRWOTo71XmD91Jlc8nERYI=;
 b=EYyIEXxQkBn+hMzblMOAcpSoF0QQeQFyQj/1MkxPc4KL4gJYBwlmipnvxL4O/wO9Wsvg
 PP3JdS/Knrt+Wk8kyO51WY13iqTND6Xw5srmCcPgAaIJFHHdW0BUqwMF79JGs9A3kNMe
 h2WrMhFwuW0IqtDYuDQqisWODTBKz4N7LLE4zNI31QVM58RYF7/fsSte40LlbX6WS8XC
 jo6Hd3/psFTFVvWzt56t1kR8m4X79i1KsqEGcpT2YwYnXbdUFfLvcltt5Z8hQIAaK/oS
 3o8xIuCi9K2qL4aHbFEoRGdQqMyNbfNpBGFRhtls0rWVqA6bHJMkWBXnCHn+Wzroddo4 ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahskwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2526KAFM001123;
        Thu, 2 Jun 2022 06:39:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p4krau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjtqFf7zbjbST1ikhOBxN4jUTzl8GVX9wRonet4M71L7IRsQxKYCSjP+a41c9QlgfHwyWv5p1YXAJsZ42bR2SjW+n27n3zetOQIWHdxKYKzS7ucTzIqfIv1G42CDcShTDL9bYffD1yjbF063PIFRfR642Y+PZ972KZQfHOfhNft/X8JMrBdbQu6lswsHGHCM2trYkveFw27HNNI5nZPD88hMRjWcA1ze+z3R3FOdGdqNLPrJ27p9FBCjj101Z58d7rX5JwRUHyhlKxBmQYIEmrmv57C557U1f5DjEcLJzW5dVR+rVduLyl8NNe16GX5vaVxLYgzxu5OeE6N3uaGx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxIYfUMvr/J7q4ABiB5tYZRWOTo71XmD91Jlc8nERYI=;
 b=mpwDmImwvjrZCq+tUAFdFYkw+O8mBXruMY+OHdN8qeEOV/1rSIZsqYSGkaSHEBrvT/vwozGqFhNngb96o/U+D6GFIh6I6yVpaHLfZOVXsIChQIQiIOA8/uIu/AcU8RvUKDkpn/S+58A3pmTj+G4oM73FnZAbabWPE1pNhadL/v6ZYoMY49ARFUYwwsKSRtA3t6zT+kZPHYWCf9jRZbnDyMvymDMkuWRjfIRz2dZptmdZYzklMzSttAAf7gV/snlFajFI3C0XV+OCGD065HDyabpgGJpxGVR6n5iiYnJgEEaKz+XTyVWo974ORm6bzxG510hq9ms6qJ+BttnqIQ3c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxIYfUMvr/J7q4ABiB5tYZRWOTo71XmD91Jlc8nERYI=;
 b=ket1CPf81rK2Ne9V6SjD1KVB3P5lVFUizRBnhMc3t65Ow2KKTZ7ClwsTh8mJIi2YE1F/k7eFmoRfYGz545EHZ2wvmEg1KzkZnUePVYwYZD+9ojtdAKwQkVd9Q2q2sPWDrjWz8m/OwpdN1EuIthDQhlQdO/4cuCVV6kvSXgLW7Bw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:39:23 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:39:23 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Date:   Thu,  2 Jun 2022 16:39:04 +1000
Message-Id: <20220602063907.136569-2-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d745bc9-929b-4789-39a6-08da4462a158
X-MS-TrafficTypeDiagnostic: PH0PR10MB5845:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5845382A76C134D4DA830D7AB0DE9@PH0PR10MB5845.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZLSUV/NW9S+r8NQAbP1BryjHT77VuBpSc4rhuegSUk5MxP1QjfALao1SFtMibXYnllHG+XeJAFG6p0+dhe2DYrQUUMY5abQPFzHyiHiokHgZoUC6egpP948LcqtCUiBVtoOH1yj2oTDO2gQ6lkBCjYyGJiZGnsV2g0mJO0kXl/bvIa35SytBQXRQv/qyUVOk9JFOYh2wpBQNRxtbtdNJvATAFogeMfBkdGlHGCA7O4ag/PIdHJEm2uBbr5TIAqRuxBvFOvjR+6VstW9vmmtn8JTvS4tt0Fjv1ZdjbuOVcdy5QiHVzrhCdOnoo/JUnGmlE3pUzTA9FxLq1nSKLjCJiHbenBWtaYWTFlFk3Chr/w0CfrV3h5bn5QxkRzZbzn3baTV3509vjbHQrtDltDv/s4C5rLKwGLCZOuJUTRTom5glDYbeyUnMbmoaL+ETcp6TPRYUuOA+pfXCoWGSYJuyD0wrtwhwSzWxmVhIRejV615VF6VlVfZK8earYfvgW1Rd6fc43L75ZHm34wZUJx8jylAxcyPgh+ZzXEw2hS9uKZRRzMprif/IgOgDP4qFRfyDRYe4yUYjfChzLuCbuAR6SZ/qoaDGGaq+6f2vDC7g63tXP9Kih+3vGGdGdOBu24LPnyd7MOs23alRQSpKJETIn5KZHKcZTT1OOb/sHAnx3Ppy504eeJPMVevStkZasaeoIKklYXNVS945BsE/9tlSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(38100700002)(1076003)(2616005)(5660300002)(103116003)(36756003)(8936002)(2906002)(4326008)(66946007)(86362001)(6486002)(66476007)(8676002)(6506007)(6666004)(6512007)(66556008)(52116002)(26005)(38350700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/i6g7+j2QheIor6aHW5BQJws7guGTd0nEbiUHnvm1rU6zen8V2uZrPshutR?=
 =?us-ascii?Q?+MvrqR2nuD2AdpGvwufDBDlDGt648Wpfnbp4OZcxNd99PJH/mBjrLcDlQq3t?=
 =?us-ascii?Q?oxMji6HB7NkdQHybQm8gh4zj9W5mWNrlc+JAWZPtlJKAczCK2pOGRIWOYhr1?=
 =?us-ascii?Q?vpUBSkopqaAU6aLMnIdS5qB24Z0vIQ/kRRCAoHRfsIh4cbUfJ7g92cAmnJYg?=
 =?us-ascii?Q?YRfE2fYyB1zcwDRf3BdHl/xcYga8oZieOupMF2xgVTGwMGrI2z9nKG/7yDia?=
 =?us-ascii?Q?IqDPuCarSQWmr9vp2OhDEBpFBKBDkd126+VvrMSl8UvnbmKCCoq2K71XXNp1?=
 =?us-ascii?Q?3jUnGtmgy64BUrlJIkVsu/+bvJKNfOEiF+C3F9/+Eakvzpk9A4/s1uJW1xJ2?=
 =?us-ascii?Q?hBHISdtciiF+PFgI8UZ1u5vbHi0/nluv/T0J8xHwKer3f1KDqElpDFPS/JZA?=
 =?us-ascii?Q?bPHAtLGoQ9TlUY76/PJWr5r7m41ZTsh4MsQIxtEjbJFKnIzlt+6m0pIuee5p?=
 =?us-ascii?Q?d4p4Pxg20z2wVYyhIR/dlD9chrv2EDrPzZnZguOJkMpCwOh1KTzRMckH7Iua?=
 =?us-ascii?Q?kSh74Y6ajCVwruWqmjiLYH6E05jtj87XjMclhvK9Pe+6w26a3XavBrM9AhhL?=
 =?us-ascii?Q?sDNU9NZEzqXZO7RsMtYtI0TrnLDW/f18HY8uhG7Aeon/GTpheosusdocMBnj?=
 =?us-ascii?Q?lHLy4VPzghdTMRazRA+cuFcycAYyLVPmYzoLBBBFUJ90ni9p9cxS28MEIKb8?=
 =?us-ascii?Q?SU+7Xyi4lJwURdqfQRoFMwfFiCzFiiCg1E38LHp7IbMiYKfloOBL1BTr32o8?=
 =?us-ascii?Q?A0bIZaHGfVCUZtl3eNn5oitDKWAmJkNqo+Ai4JjJbkYlVcjIkcrZZqS+6FKh?=
 =?us-ascii?Q?fCOZy3BOWaznZK/yimfrOzsMgDcyNl+AmESlP21Fr7CUIeMsCSlBM9g1zmzt?=
 =?us-ascii?Q?bx2UVOmF9MfXCY4BPlN7L8kG6MSPSbTkjkpaZoDBHTZI1Sy4L6Au0pcwnd87?=
 =?us-ascii?Q?+xJOYuSg/RLe9PO1h/k6niDsRsjdgN+xekcDap8EtYITaBZu1FpyO0jH684Y?=
 =?us-ascii?Q?nBaMiwH2P5pZHgQRi6IqUl+pKdbenYb1H8si5OEUqGuUvMtaN4ivBSzm7Vei?=
 =?us-ascii?Q?41TTZDqjTNjnsaf2T9RuIeRIkr+8HxNwaZmSD1fAZnzhsJ6p+/YMLGLvN3yK?=
 =?us-ascii?Q?cYUtX27nilhBPZuBog9cUdhU+ZD6sHFGdL+6u4Hw2p5/39s7gjemyihqqEuA?=
 =?us-ascii?Q?SNfTacT/BZwb3v7Zmi91eWCNyrlPHoA0ECvl9dsL7nj48gdHfWaHEO7CXqC6?=
 =?us-ascii?Q?L4aov3pB8QYgTobBF6dgxeSfxHQ0bCLWzGpwkP8Epzm4d2HKi2cZkdQamSEp?=
 =?us-ascii?Q?J1igoj7i+RvDs0CC9hKD9xABzwUeP9gZWi8qcGBWL1Yy7RdpaMSkxO80AbKs?=
 =?us-ascii?Q?4EuQRmaGgqtUcN4y0yedaguVnuHi0SBoK3SO9Wk3aGde83+CLthycB4WsdYO?=
 =?us-ascii?Q?zD8mP0IBw29vZv1Tvo5Biz6SEvbfTHAU4wbmAOo1iObnDHP75CFt8WeOBnGB?=
 =?us-ascii?Q?SlLT6xX5janTiiTcCgpMEWxpeU2PT8ku0iWl1h9IAlJHB9VPor9NKZ6+gNra?=
 =?us-ascii?Q?8vfgocvML/jmfkEBpGO/YlSmZlCEKJCPR6vDBgUVqddQXgs8OOwFOKT/C8oX?=
 =?us-ascii?Q?CBQTPdSvqXhgt6NDwmgID+J5sb0sgPPmLJvQlf3hzsWA5X6xvwxuKRXvHkMF?=
 =?us-ascii?Q?YlbFZJ2XDUXaSnuT1UFUbwy9OGZPrw4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d745bc9-929b-4789-39a6-08da4462a158
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:39:23.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUV7yx+bE/XTawP/IL8JqB/NhGN9eJ2I3FI07yvri0MnF7ZZkHudlSayOEJe1Tn6G1ndcO79o4xdGpgqtyDsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_01:2022-06-01,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020024
X-Proofpoint-ORIG-GUID: OddiBEL0kSJZqGgKsB5Cpk6l7cxXIPwT
X-Proofpoint-GUID: OddiBEL0kSJZqGgKsB5Cpk6l7cxXIPwT
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
 fs/kernfs/file.c       | 172 ++++++++++++++++++++++++++++++-----------
 include/linux/kernfs.h |   2 +-
 2 files changed, 127 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879..63f1a8f3efb6 100644
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
@@ -51,6 +51,77 @@ struct kernfs_open_node {
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
+ * This should ONLY be used by readers of ->attr.open and caller needs
+ * to make sure that @of->list is not empty.
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
+ * Fetch and return ->attr.open of @kn when caller(writer) holds
+ * kernfs_open_file_mutex.
+ *
+ * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
+ * the current updater (caller) is holding this mutex, other updaters will not
+ * be able to change ->attr.open and this means that we can safely deref
+ * ->attr.open outside RCU read-side critical section.
+ *
+ * This should ONLY be used by updaters of ->attr.open and caller needs to make
+ * sure that kernfs_open_file_mutex is held.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_protected(kn->attr.open,
+				lockdep_is_held(&kernfs_open_file_mutex));
+}
+
+/**
+ * kernfs_check_open_node_protected - Get kernfs_open_node corresponding to @kn
+ *
+ * @kn: target kernfs_node.
+ *
+ * Fetch and return ->attr.open of @kn when caller(reader) holds
+ * kernfs_open_file_mutex.
+ *
+ * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
+ * the current reader (caller) is holding this mutex, updaters will not be
+ * able to change ->attr.open and this means that we can safely deref
+ * ->attr.open outside RCU read-side critical section.
+ *
+ * This should ONLY be used by readers of ->attr.open and caller needs to make
+ * sure that kernfs_open_file_mutex is held.
+ */
+static struct kernfs_open_node *
+kernfs_check_open_node_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->attr.open,
+				      lockdep_is_held(&kernfs_open_file_mutex));
+}
+
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
 	return ((struct seq_file *)file->private_data)->private;
@@ -156,8 +227,12 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
+
+	if (!on)
+		return -EINVAL;
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	of->event = atomic_read(&on->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +255,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +277,15 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -519,36 +603,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -567,24 +644,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -774,17 +852,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * check under kernfs_open_file_mutex will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
-	if (!kn->attr.open)
+	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = kernfs_check_open_node_protected(kn);
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
 
-	on = kn->attr.open;
-
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
@@ -815,7 +892,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
+
+	if (!on)
+		return EPOLLERR;
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +1002,13 @@ void kernfs_notify(struct kernfs_node *kn)
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
index e2ae15a6225e..13f54f078a52 100644
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

