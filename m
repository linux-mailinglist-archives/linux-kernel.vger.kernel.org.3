Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3553B3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiFBGjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiFBGjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:39:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CD2A1412
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:39:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2526Nmiv001753;
        Thu, 2 Jun 2022 06:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bl60fQmGMwt5ZLhB73rldYocSX3/75s4t4xJYNn5IVo=;
 b=iv/VmSMvtxNgnNuIXkpIWxg2lKuIDK0UarT3MOrktUJPYREPNv7y4XJj9adMnHTNpLda
 kFxB48Dd0FBghETnpQTGNuiZtga/tAlKsvqpV7b/9t0aoADKJZeVi7OUhbLLekeCQhq+
 pTvwaR9IYB+IX3umzrUMDkFNR3fG1906l8PvrKvfSn8DWdUexKt9+ryChF3ikq2UMIC6
 IfkJBqcDBJXoQ6GemHKnqVIyDQt2bVwkYcwNCa6Mwg1FUPK9A3k6bP40kpqUsnNPs7g2
 DsCDYBNrwOe9U2qHbyPAlUuCfgv9U4i/EeHMkxJMD5hj/ti+IzlkjpiIkLW9mB+jJ66Z Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcausnr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2526M5ZF039572;
        Thu, 2 Jun 2022 06:39:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hutb75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 06:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvWZr6XJP/dw4ELZZBhkTUcYk5YZvkYSioy7kksGoQpVgEsYlfQr9TtIbx5WuDlcSI+pP+NidT6H2s+Kchq0+I2tq4/Jn1QCGF3EgFJCG665wlaW5xMBwTOk8yRrU3AG6aNflozLt2s8yx/6Jd8p1koUBTTpxDPMcM08VRBUwFDDyWa59GIop8u7oCSBQuZI4JYJefJm8RmoLhE/MzFLt0JGQD+9jBeYzAtYJ7qhEktjqCi+esEmHACssAfDZS/URwBAKiGoAG8G0FTC2dBWBAYWHw3sJHvr1GNCTa64tntzFfvx/0+COW6vKvRGyK5g7aScK1Bfk6RgEvM5iw6sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl60fQmGMwt5ZLhB73rldYocSX3/75s4t4xJYNn5IVo=;
 b=DaP7AX+LvuNna1WgAn+Fb8iiGnNwv4qq+pq5VGY/+g3sEUqWK4UhGvjuKmz3xL0QBfGIIbHHeietF6SYJ9L3fU7fk8JRMtc0CQH/XWZhUeOHzr+jCBzpQGDvNeQuxxmhj3Ap8is4EkQb20n7LoyZe5xTay0oQSAOiWSsJUOaCifQKO/U5y0OsGIF9jmID/PHGxt7QAvUrV+7JSqPBXO5e5FVw0IQ3Gqf2YticaqVr9/P2rKN5yXKE4vDx0IrTYMza5bCblckstCneejlHTi+S3RJa6H3IsOK9sKbrdd9OnsPkILn5D9UNgju8ZcOb9snhSWFd3ALx4Hhd0R5iWBTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl60fQmGMwt5ZLhB73rldYocSX3/75s4t4xJYNn5IVo=;
 b=AZEV31hYNvppcKagqE+5SWJb1B/TgvfKRe5NLxNtE4b/4Om58aq0lI4Yf2frxllQnl7QlFTw2pV3D28pZj5dFb89a/MY+rqEvp9oNcyB9UMw4txml4escvmWA/fTEjSRXn8ZRE23G6BrLH5vUNCbPnx9bg4FYDdq418rXL3SEYg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:39:25 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:39:25 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Thu,  2 Jun 2022 16:39:05 +1000
Message-Id: <20220602063907.136569-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 975cfaab-bb2e-427e-3d7e-08da4462a2c0
X-MS-TrafficTypeDiagnostic: PH0PR10MB5845:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB584561AD4C8F0CD8D2031C20B0DE9@PH0PR10MB5845.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPP0MgusXJCfrqtfQrIl8Gn3gL7Px+MajRO4rxlgrr0CTH9KVHRYv3pKPM68bXWVC4lQn+oHjBhvl43kNCpx6bNDYUmTdQWZnVuwNsPoCgIVbPmylwHO/iLdt4C+d6iYUWL+6+LAb8yA/XbUchLBjEXLjp5P7PQQAZS8CDMNvwdqGjFkQ/1MOlFLnjrPymFs37WRBn/HtjIkK99dv/0dBzEQu5i59KKu0ZjyRrXT0t1WGOuOKfxAGhCTT7hu9QdE2SDzL7rOyd4tT1XevUj6yAfekkZff8Xjhh8KpLbSlXHOuilBQc5KhJSIWOLtNL4o68bsq5F5gt4pJCkz0FKhHC9cdF3ng4JDAA5Dol+WnC9uxyB83qDSXOcYwzZL4e8RtejgFNu3JRDzMLSbbEIUpNphWpQ+45ZiUyMf4SXsd0tp12ComVkwPk9rL1FXnWDJfikaOzwmKPTq6KhBq0nKTU1CqDlXIucl4zIYWMuWqlZ3YmAEgebisEvqOi6QQdelPZNPXCtazLjL9hBlVVxi8MU0EAREtHdGN6+K9nQLfPBsvuzxbS7W5ze+aZ5ivXIf9Z8E8tULnJWs19IMX2QsGAetcqHvOYWVUpEALRnMIcP6xLvmJ48Iki+g9X1h9IAwH+q0oh87saM4rm1JYm2KOPkl6q74ilYtyFBwmbOF4Qk1Rz7sLSaFKf7I1Q0ra/lvw74UGpDnQOEORcscQBlWTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(38100700002)(1076003)(2616005)(5660300002)(103116003)(36756003)(8936002)(2906002)(4326008)(66946007)(86362001)(6486002)(66476007)(8676002)(6506007)(6666004)(6512007)(66556008)(52116002)(26005)(38350700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7wHkL/XWqs8BDNql3F40cwrsIjpEx3RTrs1GT+4glF1c6/c1xaXAZ+o64kx/?=
 =?us-ascii?Q?I+XYF11MX92ceyQ0M2zbgSnBf0uyzRFQ6slseTc7mIqeM7VdcCVxLXQA69p4?=
 =?us-ascii?Q?qaFONBsmF3nUadMfszNh0FJgZQMQ7slP8azbh3ZtVK6TAF+xUpZ5z9BPxXHe?=
 =?us-ascii?Q?Kre9nG/zEZn8Uzpg48qnAV47qrVrdQAcfwKpe23wYENcbCaOWjWR5uFu1zDP?=
 =?us-ascii?Q?zzqFhvJWZYwd7qeVTeLa31ly97jz+CsB9/2qesLcO1c6UYL7khUakJpS80md?=
 =?us-ascii?Q?VQae6IQ/ihETwh8wv0LKDah2CduJgdEx0GDS1p/xbyvbffLnqXQ6RCYG2wGo?=
 =?us-ascii?Q?FknMgZRbEMF2rvbJRzkdkGBN3zgBmTTi7EmicDSJKDwMTV7gn5gcUPorEkJu?=
 =?us-ascii?Q?XMyfsph7yzz29aqoPqbNSD2E+fBU1JodObAQhevQBQPxoq0TCSWg2RipB3z+?=
 =?us-ascii?Q?AYDLqNE84INS0DgDbL+Etpi63pq1nBdm+XUKzlaN4/S/5g5FED1Ae8WFmJOh?=
 =?us-ascii?Q?G2w/2ZOPuztsRrQziKkpPR9BhlF43FI1oggv6/4fd3zBsfwvPqiS+lB/5j2s?=
 =?us-ascii?Q?rFa4nwl9Kl344dDSARQISbcZglD6QviO+GnG9Qr1/fu7FaydKtfLkvi9LZ6k?=
 =?us-ascii?Q?Gu2u7b50vBUzQUH4ggLzpBN8wrQAXuxeQ3urTOzTPv5Jk8wUOu3/xIDuDRXB?=
 =?us-ascii?Q?XLZnilK6Qm9Uhn2t29D3sKHq7Zs0lWkP2fZ4kBY0L98kZBUiPH9Ka+YKW5tD?=
 =?us-ascii?Q?qZT8NcexhjQS85kLU72I0EsFNnuWHAmfwQHjLdaATGpOLfEwxQSZXaLk4tbz?=
 =?us-ascii?Q?WSJ0SZ1rGepzXOzVs5VAWF5gb5ORTM/tLMG+abLt4rjnNSkTq9aMBAY6EHPy?=
 =?us-ascii?Q?NiwAd5T2XGYF98/HKqJO80aZokMbccti+unhFHp8KwdvjvPX69c/TDl6i7j/?=
 =?us-ascii?Q?TqSU1hr/vdJDlhUTDyiQ5KQAfOMckIO5IUndyW28G/wvsB2UEzdNhA20gs93?=
 =?us-ascii?Q?7zR8hUsM51RpmSl1Ij+5liFP+2w6zqlubYweYH39UP58tcBtfECG6E1wFg3d?=
 =?us-ascii?Q?bcn2QSUUPqSGraOsYvYE8BvhU16MoqGRXfVl3E3eItpYbnK2LlzEG848QQnq?=
 =?us-ascii?Q?lU37jwWcumbJzmjv2QKzulYQYjvlazoQZ/+hAayLSJgeGrVEURgAPF7TCD/x?=
 =?us-ascii?Q?QBngQ99+7XIww0XQmmUdFuCiPMbHfkUUXBWwZmdJx1dSNwQFaVejrQ40/n8e?=
 =?us-ascii?Q?XID+plhm1lf6drojjkMAMclt7QPE4ApMFapZ6EiZCalFbh5W5bQDNHlNqrnc?=
 =?us-ascii?Q?EaG67y1WpoTL5voDsv3pZDOqJmxM0V7SR/MSbrhnQFRJuDkan1K09ZoozdZx?=
 =?us-ascii?Q?pt8knzEcRsxARY6UydMvMGNQ8J9Qf6yq0ZEm/EsXllmWSyn1ZKmiYYgMGntS?=
 =?us-ascii?Q?d3/RjC89GdaH/yIFJ6K6WnnOVG0lVqTpQOkJXgXALIHP4YPU6nWs+xXiTMLX?=
 =?us-ascii?Q?QlDdLWOMPJW2tYPBw2muJ/cER+dnLea5N51/2dUOeQpMwSepIdpWQiTFAHgZ?=
 =?us-ascii?Q?KUFw4rv8923milcTr9PPgyy//UJXyD7UuQO0oYQgjKCYYtV58L1twVsu+jhg?=
 =?us-ascii?Q?n3Rp3gvRh9HOyan0XvLJ+ot8C7XjTjdP0mz3XCDc6EAPywTP+VVbLWcl4Xzd?=
 =?us-ascii?Q?5Gog7qizkOftf6zzYMVMw7h+TZB8sLss7e+Rry0ZV5MjZ5xBE/In2DjaFY4Q?=
 =?us-ascii?Q?ik8Mt9CZTk1E9fP8cv2Ag9dCWk/IOyY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975cfaab-bb2e-427e-3d7e-08da4462a2c0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:39:25.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Tfjb0aGVphkKsxuW2dxlq/H67d7Qn9U7Bi0q3TPb3vrbc8kVlv4XsqZo1V8ZAm+T5+9oMaJVY+h6WgrmTzb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_01:2022-06-01,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020024
X-Proofpoint-ORIG-GUID: g7ncAuIb5h74LUzEv8SsMQiguc4qsphs
X-Proofpoint-GUID: g7ncAuIb5h74LUzEv8SsMQiguc4qsphs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 63f1a8f3efb6..b21c8e3b6a8d 100644
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
 
 /**
  * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
@@ -928,18 +926,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -995,12 +991,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -1011,14 +1009,9 @@ void kernfs_notify(struct kernfs_node *kn)
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

