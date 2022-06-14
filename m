Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADD54A626
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353843AbiFNCW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353438AbiFNCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:15:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4A3DA6F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:09:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0cW6r004207;
        Tue, 14 Jun 2022 02:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=9U886SywQHCDCtftkwq8pGqpEbVahLlNzCzGICxBm3w=;
 b=Joxaj+mVMukpGxWChC6GQYc1Baa/2pb1Y+lfZYFEbHEL7n/segDSN6CQYPGoXaNxCOc1
 LMJn7y1x2n7bpurQkoWu2m5kitJ4d629Q0XOslF2Lov66LyVXsbkOooEXefzcrq1AEkF
 TARA6R79QtwuwTW8xv0/GL2jtL4tU7O+JkTYFtg5vkn/vsJKrWWAdJzgVFsTcXrInrFE
 NRfY9sSZcbKkQysZlnLyHfazmo96Ec//hfB+ZvrVJgIdFjyQpZwSRn+iAdjtafZuC9+S
 9s7oCNSoIQiDMbWKBAvDidCMoDT93SExaQG/pyWu5NoOL22SnlKrTqkpzlNMsijnU1tB qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mmu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:09:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E20I5n025507;
        Tue, 14 Jun 2022 02:08:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgyerbhm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogx5Hm5E4EAeC0MsOvB2AFokQ2lAsr4EoSXvG9xQzQofHCCvzj13mi7L63l6NOBgxJYXMjIDiSMtJb8Kg8Z08H6HezRmUxP5GhqVz1aPUD8xpxPKnvOsgu7eH2EuXyzgWBIuVm4zYlS2QHbMWcBaooCih2dJHjG/jx/BoZHUmnjhAA2UTshsDrdhAZKVvGiKtDg3enb86HRw2aFezQRy46Ajv95prNnd7LnIJvf2rXQsbo3X1j+GJVTQ7xhto2SEGsx3o6YRZlmePA9vQf2XycY6dVo8tMPcHY8i/ZNyR+sUpm9xnUy8uUlzSn2EpStqbseHyV2jAxX27bGOppZbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U886SywQHCDCtftkwq8pGqpEbVahLlNzCzGICxBm3w=;
 b=BdV+UJB24Wcgl3QEueRx5CvZQPE2FqY6f8mfwNnzK+G5oftXdHLAsZ4WxGI+8ZYrBVasoJaFjhNct2PMWLXr+kCFR2E+5UiTpbVCuCmjDzs0B7J5SN01TFCWfWMYcdfn9dVjYgLFUZokhw2xySQut7Jy5ODnq4RFXy4ow2VQO+kRXyMwOJ/iVZk7VifmVoXvwz5/4m/0U3ORVGKdaeghamsZpkkgPcGNTlH9YzTQayLiBkVAXMK8RKFlNTOq+zH1y+F1mlckr9lmTQ0Cfrp9dzyDGvr1AD2aXnczNnHwDep5Z3TfR8YetczEeeZi4GIT4TyOiGQZjNottut/dLdwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U886SywQHCDCtftkwq8pGqpEbVahLlNzCzGICxBm3w=;
 b=MAJR+M1iJIfheYzhUWe7YpM/hlznCGvfAVpbAT93tAqA5X8/RKi+TcvigzxJLSlGa16Q3A14lQHzZa0Q57uNfQhi7MnhlDMQEhSshrSM9QFROlC+fhLjC40M2YQrZc1H0EzBedxeCdZppI1eMtGPXzSgAdgmx/4LhptmQiCARW0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:08:55 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 02:08:55 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Tue, 14 Jun 2022 12:08:38 +1000
Message-Id: <20220614020840.546013-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614020840.546013-1-imran.f.khan@oracle.com>
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06f3ffe3-a5cb-4b92-8a90-08da4daad5f1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398B914559764945DF23FA2B0AA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXirPnmT1JQfHqLrBV/XvVgM92TKmn8S6MoJHLQhKPGPPQ5xnuyjKsoh1VTdNmy5tczPCjdRbMOorT/+mhDwWRTeeYhtSLewi8OweQp7i3MQ0Vt1ZOKesBBB/9H4v4bzTu+DqU2U5W9Z5mk3vWecqsmVwv8dYvz85UmAP9nHhjsmu6VoJ2p/ZuMfFWzapNf/MxnCTYuMW8LS6ZBx/upChBCTtRWyw6dFerq/RaZlK2Jc9AlfCzAs52GZ4iC3YNqfuXtXR7UMznIUd7aXbERiQb0ykbHqk+6B2ahj+3jC0u0Lah8ciy+a2adiFguO77GXLGzhDzyn6OkxZ0EluDa/k0Oiq26fn2Qt0VDGoouXTadGCoNvMTVSZYV4/dKoRi8LyJmW5u7W6y8YF9rUZ8KtVQz4fJrJqbBL0dlEJBXnTclVdBPLkZXTDU/sZGrV+jz4o922+X0gKKILLwTHY/roSZmTz/A5D4EeMXMm7DMEnMvpdb5LBFNYEF0kuRkSizB/QfYQtkJcjHjg0YWeBLXu21o/xadssnYtiMk01ITYijboz4XUioDTnYgeGAnymztkJPfMUWE8Fsy1dL5UyxMeip7TvCqMehJD0gzByJHJfgPz3aN11Oxd5Yaf2v7tHbFAQLcMmP/E8b7Y3iZU/V1A/OVWfLI5jbqkoEPYC8bpm0Q9m9JAERX2BbJkxALX1V2oTWpnc/DLRxZlMBHwQjaQhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66946007)(1076003)(66476007)(8676002)(4326008)(186003)(5660300002)(2616005)(36756003)(52116002)(6506007)(6666004)(83380400001)(8936002)(26005)(6512007)(86362001)(103116003)(2906002)(38350700002)(6486002)(38100700002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+M19bHIGUJbVDThaJ6uZBjROBPDvbk/KTxrdJhAC5py3KUcrJdBOId9ikYFD?=
 =?us-ascii?Q?+VtZ1lP5kWW8v9pOn0t9Fg7lCeSefTaFdmrXh6dITwGdjBJ9lkgbuURgeNSy?=
 =?us-ascii?Q?HOUef+6N83NFFv2QEktAnTj4Vhbbu3JM+++KJ/LTPbWvL37bmKpL8WAv6gfP?=
 =?us-ascii?Q?yZCGA7w4xCbUyDGW5OFepHA0R8XTiyAnLM6SSPhCHd3/3ZGdHaYI9Xa7xePv?=
 =?us-ascii?Q?dcc0uJTicFQjcwQGvv2fAT93mERKo4Pwr5W4hfVzfBEA0TzOizdsTBtLTBHD?=
 =?us-ascii?Q?7rNcymL3uZiFbYIGnqi/XmQjU+Iy6paUsvLkpTFCFDq/XufzK88oSGlErnYa?=
 =?us-ascii?Q?80OH6BN0BGcqu+i/Sk+Jx2TtO4Zjo/jhptRX0u2K/kjxHE8x1wnyYx6+BmiG?=
 =?us-ascii?Q?VVcf/lhGdYsIz/b5SA7yzi5qyBm1p7ED3fFjCqn5jbb1tLloA1r3+yCzPKDr?=
 =?us-ascii?Q?MPrDAubhr8Eyxbq+gJhXEXszezoYpWWKmoeUCQGivAsTr5sIrOua+QxTFAHS?=
 =?us-ascii?Q?gVDLB7D7pjYM4RW+Ft4EqfmC36ub9Vf02nB+lbfYHK2mVJ1ti4zbbF3z6poI?=
 =?us-ascii?Q?8ldfATE8sS/e6BFUWwm/4o8pflNJsUPgAnZHAmciRBD8JpAqriAyn8Pb0//I?=
 =?us-ascii?Q?4yg16vYM/jTh6eP3LUbS2vyfc2MklZ2EnbqzdIBrd49HRP4P8gYy+NSgfH67?=
 =?us-ascii?Q?v0NjgMkKNcqglTE4YTVsTxAkVwQpiGO8zh1C+B3Tu7ICMv4mKol479Wd+7V7?=
 =?us-ascii?Q?G1TYRdXaMpVaMc3L0oQ5dGtS7lmwhZFkNTGbaKqoqWufQf6b5zf2VGpbAcuV?=
 =?us-ascii?Q?W47LtdHozp2onAjkC0PdjgZ0iJNh9JF/qqmTNvnxF0Xhn/CZ+SJsiRpvbtuq?=
 =?us-ascii?Q?Ki6N8ibb37sDnFV+Wq0KlJVtHathi80VchsdRrYZfw8E3GeKZKLOd+gF1BN7?=
 =?us-ascii?Q?zqK68VmNhEfF6Pl7EbV8giPRKWr92Is/88x8XXsP8hjve7HWteILP4L5naon?=
 =?us-ascii?Q?98BYmYwhisBNHVvdMbsLfwDsCYr/KHOomEHlFy0YdgPM7XEBRTDImkJ92U33?=
 =?us-ascii?Q?lHiRo4zRriZtYFusPWtrcy8NGBh4HGXEOpYjnHYIVa62ODL8yZE1OylQ4Vtu?=
 =?us-ascii?Q?uf3c2DPHbDf4zeXL3ZehkjTQXFEIVzSExB8s0MvQKbVVKUSqNfsQ7CD88j0S?=
 =?us-ascii?Q?SJuRZOTneEMgoVpiHXQKPeqi91tDbDnnw8ExBxbMc7rlMUwA7dtlpOrXgFfU?=
 =?us-ascii?Q?T/TcOzWnLBnnon8VDoeFLPSJ8sff4uyjAwK3SZG91J6J0M7lI78gHWJ6VdWi?=
 =?us-ascii?Q?UTIhZSSL6p5vBUndsE46IJU7s/+AVnCSc8YOkYsWFlnZBIRFJiTXcsYa4wo6?=
 =?us-ascii?Q?N0x0fODnEt8ar5BrfGUVXKIArhQGHZYviSRXrylFR4w1TsZHWGnxLJbE4UDi?=
 =?us-ascii?Q?Fh07o7XKS5280RYH0I37HLjtv1eTLuRSQqlfmSVos8E1GMZ5eOwo8lNGgFkR?=
 =?us-ascii?Q?hyFDSyJDih51tcGqbI/hiWyyhfJfNAHzTgOeNlfRRdYDdmd+DuOR4GfFh7lX?=
 =?us-ascii?Q?lcdDHzgRYUxqw2ShpYIkw54lURsGfosS0ONGI+DwrcjsRgYf2ivO9iHx7caO?=
 =?us-ascii?Q?t5vYrdyC6VGDTAe5Lo50jqTrJ2QH0/OhdlCCi6i0+E8uzf+1MQgNwBgVVWZm?=
 =?us-ascii?Q?J9osoZcdMl5uY9c7U+ZatDV0i0nQOMFQxe+kwXOp+pzZRXzJsRtSKV1yykH2?=
 =?us-ascii?Q?KhOHeY+6LSLJ1qsUHeLC2YJ0zze8LgE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f3ffe3-a5cb-4b92-8a90-08da4daad5f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:55.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rls1CQlPAhI11h91bA9Lq+n5GcHMUrb0tg6sK/sAhJG1eOBeX4D/dZZOhGRFL76rGdpY9x7hwT+4UPY3TqxFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140007
X-Proofpoint-GUID: LFyTaHnqSwY8N4F9Lr6YoGO52Kv5aTAD
X-Proofpoint-ORIG-GUID: LFyTaHnqSwY8N4F9Lr6YoGO52Kv5aTAD
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
locklessly.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 42ee5dbe351d3..0cc288dcf51d9 100644
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
@@ -898,18 +896,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -965,12 +961,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -981,14 +979,9 @@ void kernfs_notify(struct kernfs_node *kn)
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
index 13f54f078a52a..2dd9c8df0f4f6 100644
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

