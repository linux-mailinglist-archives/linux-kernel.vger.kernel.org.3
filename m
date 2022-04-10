Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBE4FAB8C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiDJCkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiDJCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D24551D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239FdvW0031973;
        Sun, 10 Apr 2022 02:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=FSkZ381vqEqWfmePG2cYHBbVixRa9cGXw5IfNENUE1s=;
 b=KZnUYxgGcrJ+3cCP1ZheRHXLtQV7oGzmPSU+9qHJce6LvieNbJIrAjeqAKewPZNsgm2M
 Zl/caZYCR0E8cBXD2sdDtZ+sXrtG15Uz3NNEBUQzajN7W4mSJtiOTB+J5Bw9E2+D80Qm
 ZD9IEb5xa+9uwAM296IoMy0G1yRUoHbB7AKybpnimG1O5cGcO2G1kw1mcr1VocVej0L+
 RJePZ75LpTL+XHBqgVGkaka1WeEXT6ZW7NU+MjAOoJJmvVHJ5zTseKNVvM2lvbLnDyaI
 Lgn++mcCdwNQgrCbAGstRZrKM2bXbS90qH6YwYq/9/KH7YrOsTMqObGtZCgsLHDR2CT4 Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd110w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2UhNM024205;
        Sun, 10 Apr 2022 02:37:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0h5gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwXVhiEO87iv0jr2iCeZg9W1mhxfdanAKn4/d/Dm5kLJiJ7K6rcnNgTZAYGYR4uNv0yYg5PgflgzhtyNmx+ZmwuILXaaiicCcZicZJ/X9FLZPfP1VD3gRDBABhsCJjN+DJK2kVRvBfTDPBaaWCZl3cdDk2sla+EZOcTkRy40CDsWyxrhSVpPutAkK0Ui17KWZKATEgngn5cdBfTVQ9hRaoV3XPBAu1rOAGxO0ZzBZ0WhuQtpWZzizKHcVCL8/IkvX/cs6ouJYMvaz/JBWDre1uUcncjuMIb73qrnPV9sOTNFWJ1GliB2+EbySd5kKGkMi4NVJAbFNpfUO+RIqoHVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSkZ381vqEqWfmePG2cYHBbVixRa9cGXw5IfNENUE1s=;
 b=A4u3c9fcK8wkr+lHiDcxAqtBcOwH+JJG1HCCDN3sHGYI+xT2IChDwp3O8HqzLveebNpa0gEyCumMXU9gafjg8WaMun0zbbyHlaxKia8XuMzDzbWz0z0QTIzxFyay/KWhkgfZZ8h+c4/SFY7zXlY13yBuKSBL2YKNNNiFiBKVgzSkpQTcIWUmFRjtSn0ZGQQ2z3kwdRhvOj+7Ft9XjXR8K8M6a17SdsSnJmWs4fkunyb9HcME7Wc/23UoYcyOB+QavqlbEmCpfg1L6s7w9xoGntd/yx9EvYRiN+0v/jCGso73InGzDnnmT7DfYBFH+f6SsY7PZfpxnmmgy4Df+htPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSkZ381vqEqWfmePG2cYHBbVixRa9cGXw5IfNENUE1s=;
 b=p/rIW6euWZtmaWw3rxGYB7H0WIcOlfSM/yGQaAeD0TvhlEdAN6RHK9SkbKm//fY0u4KPnZ8wyJkz9CcSOQJugDFCvdYnE2NmUBswjdTK1o4IHvNGWord7Nu78HP0w9w3ZrWy5tWnobDzyxxEBNyKh6K6+9Mpshfnd98NGetdWwc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:39 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:39 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] kernfs: Change kernfs_notify_list to llist.
Date:   Sun, 10 Apr 2022 12:37:12 +1000
Message-Id: <20220410023719.1752460-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67c7c505-a70d-495d-c02c-08da1a9b144d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238911F0E3A51393DE88BAEB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pksK8kIA0yrY4QJ/3RjtUTBHFpUOtpuwtJSZ3xMNrgxQfGwufnne001lj0XH7LR2lWs9sQnt/JEkl7pM0IkrRMHZCXpMZHd0yZEzB4MNY2/OUsk4rh4cp1to5BRYTzYoordTFt310VsJ2VNCTIA16ktr3qkAcuu6YcFjU1FNEyK2RgwbgZjSGkbZiSvQ1xXe0lrIICd6H24Ex40H8RRq7kn9rfrL4H7L64m3AtxNHTdB8/9wDXmeOWUA223Z1L/C4888mnZLFKHMgNCegiqI62DKnG/kZnzGeaE2asg/FdVX+12Jxe7Tl6eXl8FkeK8qB55F7Qh/8mxL0ZVds4a9h6iJdBY6vL9o9AyjZXSYnAE3QwsKGGZhZAH+vN4lE3rnKI9pZohtdBMpqr81KdJvm9SNvnOsjIuWZWitJ/Z+fa4zmw4bpSa7VgGpdkjndAlo57qeTE5j4bJ3MTZ2Oavq3x13AXOX+r92vyAIwHIEpcEhXKQ4l7C9hOwfi8ftlEarvr9VNNzWcEiIrD3EsIH+OptVhMBD76xGZmLMNybP5V3e4cv9pXeKgdj0zdUJwVRktyrbX0hCIZn8U+qNb4+p43QEgRlw8nRMDe8cyK3ifBogEKpv+hwY0M7OmITA5E7TalLY5U3J967/2je5BiJsDqwhFQTDq6gll+Go8yyCliFzF5oP2Al9SmdSAcb0etebPRcTwuP6ZQD4rUr+0SmEFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoDibE7sPWajhVfJ8rKXot3IqaxuajRwtC17dDr8LP9pXQRD3Mj4HvU+5m0S?=
 =?us-ascii?Q?6qZYCiy5speN/Y6j8gv78z35+dpIJm0MaIvUugv8LsjHW+4xOum7i2h0SK16?=
 =?us-ascii?Q?bgboWwKQkSkPpMPSTW5UADpbnAp7ONQbExomPmLAcT+Pab1emqQXhXsOb7V5?=
 =?us-ascii?Q?mnI288wSoVIcn1xyglu0jU9GpUeYNgD0q03Ito34gnnkLkkl2b2mmsdojVdj?=
 =?us-ascii?Q?MA6XE1BEqveZMeeQcGyZczBPAant9huWhskoXJ59DWH6YTdNCbXuLCCzfq2m?=
 =?us-ascii?Q?Aiihz6gpIbjVOjPSh+hYE6a/GmigoYqYq7P4mB1x59vatqyiMnaczWkBydcx?=
 =?us-ascii?Q?5hOevqiUl/ITNX5NGXcsqICQYndbAhffTozgIouPliC+liJroW+WPPFB+k0O?=
 =?us-ascii?Q?pL82LBIKd3E4ZgBc65bD4uPZTIq342WZhYM7Zy+sPpiRRimq6z267rfAOTBf?=
 =?us-ascii?Q?IbQo/Sa5kjoJ9xlC+AdpkxmdSycFNXSoPrUz55K+/GZ+KIx5Ycqws3ExZErT?=
 =?us-ascii?Q?lF45ePnJfrWnRTKyqR+SB/EzrePI62gLsx9H10Qlgv2vlMoQTwz3Og4onml3?=
 =?us-ascii?Q?OgvAn1/NkLIPTI1+OegCuR4kDPDZBH5TFFVgIqZ8MTOYD9zIK/Rps7/FcKUd?=
 =?us-ascii?Q?Xpxd/yhlkPqiUZrxdDzd0pac1JWpmMUL9Kuw9xI3hWi7n+j7Z/a5T+Z930az?=
 =?us-ascii?Q?FS3tGz6jN/LC6xPNn2l9BcU9EVHNE4AxukSW23LyhQEOJZuUM1MsH4QzCSbD?=
 =?us-ascii?Q?NvEjBYCiunOmxSGjfYvJwL9B1B89lKB4s95MCBxVtwG7CGly9/+m8wnmj3B4?=
 =?us-ascii?Q?X64fBeE5Kb1JAqCM9PzFa3rXlkLkL2B3yvzZ6NCGgpA+v4OTSWqJXchp+qys?=
 =?us-ascii?Q?ouWhjPJFWp+bR7M0Lr1BvZcR6ObF3qvUkRXGmynVLfltpzoh01cNKGJQACVP?=
 =?us-ascii?Q?Zb0IWC7fjAWLGf4hDGBACu4DxJsmlPLKqEjpL4ZSyHFaYtKJwRrNIHdtlOLR?=
 =?us-ascii?Q?Gk0H/zC7c3f0nLDXpq+eOu7i+LVrRkD+HaHfHlU0n+seiG+Q0Nf3iU1a7I4e?=
 =?us-ascii?Q?N/+ALsJoYN8XujGcosyCIaLXe5w3qkog1ge4sSQhV+Ae+00J8Y3MdOtJSHeT?=
 =?us-ascii?Q?2I01okOT52DGruacbpLnpkDGNsqo5CpCCcxk4wSpWrWKmiLlwx+VLoU1JsHr?=
 =?us-ascii?Q?S5bpgiZy0bDJTdT0neSfj6liyM40m0ANeIXHNeB6gC9PEkhICGlN6OwQ4hdC?=
 =?us-ascii?Q?1wmqZscFIihx5uEgHtm/LjqrDsoKYWg+D1YSycZeZMH7aGoShM2jd34l5atI?=
 =?us-ascii?Q?Hr/f5tlaGqOzR6yWbi2U5RhvoaWmcly1aMAlWSm+bwbkraUT/BNWj6Y0IZ95?=
 =?us-ascii?Q?bSWGJiAbUKLgpO9J/ES/1nOKIn1yHAXgGsQc/X4u4K1tVZe5ghxx7kmWQb6w?=
 =?us-ascii?Q?dH+xogZ1IrhN24NAOWvLuWE8oV0q0KsRJh6QRSogTxok+hUwAt+OSV7dqzqW?=
 =?us-ascii?Q?/aeuni8SQgJkH1A6har8RZxfAXIS8nhgOwjCn2+KKIIje+UJl9hIV4DcUrBe?=
 =?us-ascii?Q?pdxclj3F42vVWr2Q7IKh5eeOmSX1oOhuAw3aoI8QpdB2lWK5kZarZkDX5spJ?=
 =?us-ascii?Q?mpvTpgrT0t8HMtSKVZicuMCXeS/JHtN9M548kXcmMYY0TRHr3RX7GnbtTWDs?=
 =?us-ascii?Q?SGo5zzDkuPObIDJhfEG3xTP3aF+GDl/m6+cpcU5iKQRMfcHxX+CzvHbPo7CE?=
 =?us-ascii?Q?JyAq6h3iH/hCYYFHtTPTdD3wrv6zGCw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c7c505-a70d-495d-c02c-08da1a9b144d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:39.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw6jpbu642cG4q6JnycEdf7z1XaHJe/RsgKmF+vbZ9CiSl+eGjMX9sUMa+tqJGP2oh+BNp604T2v/ryUC2HQ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: PwvC6tK5ZNgzD2VYDlhUHqpq2vYKAODq
X-Proofpoint-GUID: PwvC6tK5ZNgzD2VYDlhUHqpq2vYKAODq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Also with this approach we don't check if a kernfs_node is already present
in the kernfs_notify_list i.e whether ->attr.next == NULL but that should
be fine as it will allow serial processing of all events submitted for the
same node while the node was still in event notification list. With earlier
approach as long as a node was in the event notification list i.e ->attr.next
!= NULL the subsequent events were ignored.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 49 ++++++++++++++++++++++--------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bc393dcf4efa..c89220dcfdc1 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -38,18 +38,17 @@ struct kernfs_open_node {
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
 
 static DEFINE_SPINLOCK(kernfs_notify_lock);
-static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
+static LLIST_HEAD(kernfs_notify_list);
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
@@ -846,18 +845,25 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct llist_node *free;
+	struct kernfs_elem_attr *attr;
 repeat:
-	/* pop one off the notify_list */
+	/**
+	 * pop one off the notify_list.
+	 * There can be multiple concurrent work items.
+	 * Use kernfs_notify_lock to synchronize between multipl consumers.
+	 */
 	spin_lock_irq(&kernfs_notify_lock);
-	kn = kernfs_notify_list;
-	if (kn == KERNFS_NOTIFY_EOL) {
+	if (llist_empty(&kernfs_notify_list)) {
 		spin_unlock_irq(&kernfs_notify_lock);
 		return;
 	}
-	kernfs_notify_list = kn->attr.notify_next;
-	kn->attr.notify_next = NULL;
+
+	free = llist_del_first(&kernfs_notify_list);
 	spin_unlock_irq(&kernfs_notify_lock);
 
+	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
+	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
@@ -913,12 +919,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -928,14 +936,9 @@ void kernfs_notify(struct kernfs_node *kn)
 	}
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

