Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1066E54A9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350054AbiFNHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiFNHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:04:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4227FF6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:04:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1MonJ025280;
        Tue, 14 Jun 2022 07:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=btQThpfR7zsWYmnPqUVcJdnmvjwhHEoj9zDkG06cBeY=;
 b=RvsJtUyiRVBTmgBKCXP5CVhYmyzbiGILxHda8BJspnuGLSlng3EcM8b0ZETFCvdsy1UD
 dV+QacyQetA5ja68f+ABloNA+gwX2x/lK78lwYTPjt2D0CKIRoopZfHm7V3/eJdlViaE
 2+1dolQa2iHwD3ZjAbcDgkffUltPogExTtEqvY6Uywxyjjl0joH4FPaP1hqqHtazWkTv
 ckfDFsynVsRIiYxa42WDfDhnAguyMRRuWTWaU+LVsP3sB/i7MYiztouyY3eev6pSL1AR
 kr1flVMR0OQII+TnX6O2ITBcsf+HD4Bw7O8EN5/tNtRf0YLIDZo1IN5BfhmFQ4Pj2oQh RA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0d0ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E6tXIh012502;
        Tue, 14 Jun 2022 07:04:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpn7j8phd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqpun1h/5a6OSxueq+kMwIS5TnSb6imS7KfmnB9frIcJBZB95iwSHrxUsi6le+nhOGLymts1kY+i8osHTuht5VCYWixc6xWmj6VE7Liwz/flzXsjB6WsH6fQiUNHANTlprc3lbxsFhrTTPvKeKa+zZcUq0+LQPG7QZGeumROhhrk1kuypuJEdU95iFNSDcv2B6Sa2Zco9ToWCtCYnFTb5s7skYxfbRMXAlt1NoUblP5QJ18HDwswpc46Hz2nVT7imI2oWTbi0BHnjmsgL678x9KuxQFTyeoYjV3DKyrIuwkODS7juwAlCW9ksYbH73WOIUxSZOLfz3uwenU52U08nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btQThpfR7zsWYmnPqUVcJdnmvjwhHEoj9zDkG06cBeY=;
 b=XjanbJZgywhMw43fCccAtwzbPvpB2H/gMR7k2lhkbBL5ftC3F+GsS8nMEYLjlsTeSISrorvdgUrU8+qub+bpkIuQWZADC2dMFUYhF+iS91DaY9NwRSb37a9RCQVDmrWXoGwHcRHLQ3clnfhOMf1NzgyUsXIjyomlLAtEDau/2qEtzmZa14AliCET4sulGQBGRy54Bh87jSYBg9m4h+n2fXa5hqQCCY4G4FY4SM3x1neOlfxfMlvYBc89uQPwG6vVlOQ8Azn1tyujzOLcnLYkM/4uK7cRiVDM9oJLP12ukPP0m/Wwz7X4dRuIS8QPQ53S2pyCMhUF7skuuQdOFNi9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btQThpfR7zsWYmnPqUVcJdnmvjwhHEoj9zDkG06cBeY=;
 b=m1M17dx78NvQ558ozTJq44cqG1+/gYb0u8pBY9jkWEeCJLlASiD9eRk+A1nvEaO27re/QOfPfWy0kthaKDubBcJBR7aWXEqJcThP0QSc9vxm5+bxk2uVnkkM1WpJH9Bs9o5cNrgXXQHQNm4ZLwWhZG02vET96hpXgfhpoyqNKnY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM8PR10MB5414.namprd10.prod.outlook.com (2603:10b6:8:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:04:02 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:04:02 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Tue, 14 Jun 2022 17:03:44 +1000
Message-Id: <20220614070346.810168-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcd2e510-a5cf-4f33-65fd-08da4dd40fd7
X-MS-TrafficTypeDiagnostic: DM8PR10MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5414CD8DE65F5A7306812557B0AA9@DM8PR10MB5414.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9Qe4RUAm2UqwEsRDBtiv+JsumSRzwh904EKNGjMOuvQMTFjlRx1ZzXE+V6agoDssJco/9nrApoOD03ficpj6Ft5KtrTrwo4MBvZX6yCi3pwVcm7F2LACejjX966zWgtMICJrDYVf0KqK4rdea/9NgAV0jZWSZONbOkxSLCN+zw09aLnYxTJBTOxSCOY40lIr75cEWuNP9y52JQ0fcjQVMwgfl5BWmjnLvWaGPv5qrpOdiDEu0ETqyVYcSTlbuAD4S35E+Emq7mnky0fdL05txNxqxfMcEEDcCglHTUnSEoUmrzvBk6YGVyFAeCZ1S8kJDzeu3s+lV4qm8vbJQisUQnSUilptfA1OCzuvk6wnp1k6OmOh0IWCGqJ+DUv9eb/Ov3DIUrj/Y8z+LEcZYUhJ026qIza8tBg2wLYHME99jbiQdfbmR0H6xsuz6iiWuR0C47expna55ZguQvQsACIGc16TnhVD613FKHKa4ADguOPzRtGuc2W+uDIR/e3/ek3dgwCrh40ECBcdinYuruOiy4y+hUcy1ujBm0ixfJZl/IdRLMNJW+UxJxEn9SnKSA2GLQtw9gMh3d5wLUSeJex+eHygGTFQy1hD80h2aA4cd4OXDLz194ky2xnEUSpQTLRUnJWjpPHoAt4RczJRBJUqzSJPFcY03ker5XVksNzjxYcWu+rBMBD5DqGpK32u2wz9HBTgOW8s/LNRNxULkoSTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(186003)(2906002)(8936002)(38350700002)(6506007)(83380400001)(103116003)(508600001)(4326008)(1076003)(316002)(66476007)(6666004)(38100700002)(26005)(6512007)(52116002)(5660300002)(66946007)(66556008)(36756003)(8676002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TCE1BIHR5EClhxY3dotPW6eOPaRrqoJ8o2vqz5LqXWQGfci39u3Rclhe7efg?=
 =?us-ascii?Q?Mph+jISHAjuDebSzmsU8GffeaB1L+6cS6dl2Ypqaiie1u8VoZozUMdJg+4EO?=
 =?us-ascii?Q?r7o58YTuVjvYkA8aRNfDjvOwqHfw+mk6GFel9QYtsY9wUwwxLm6BqFspNRhU?=
 =?us-ascii?Q?nkpI2YolhhYep8sQqzSbHO73L40IQ0oCn5AUSKTv40cjf7l0tBGYgKiAjhPc?=
 =?us-ascii?Q?zgPTNAqQGWsPROOyeyxRL3zcg7Z+LprfHfyW1FCmRbPIdOmM3SuM7QztvZdp?=
 =?us-ascii?Q?g9+jf1HQ0xIzOmbQ1kTRMXO2ojcFQdQ3zWssE+TRLaNWvuTYVswYJCZvsGgj?=
 =?us-ascii?Q?4iTjRn7flnpKvZ1jpAi3lCxUQVKZwfayaRtn8jPgNxCeY3pHdKx4Y9BzOX2h?=
 =?us-ascii?Q?q3TxhkvIkHVhbMdZYDjeDJNoI/4DGxhdyNCGw6YxA/rhoM03D9GcWTjpGZCb?=
 =?us-ascii?Q?vTwiVHxh5CTLD1MXjyO4AfG4q449a+qBFI7IteR3L2Xne+yeTe12XTjcUSkB?=
 =?us-ascii?Q?Itg/fGLl2p/no/DZQvjXO2MHgkGqfQaPLypdVgWFMJYdXuWTioYh/cE+Lqa/?=
 =?us-ascii?Q?y/3Sxg25p/U7l/P9MncKdQ3MzlmWburhqx2DLpuUN8dXPS5F5pVCVBiMWCW/?=
 =?us-ascii?Q?vflyade4XbRsVOHq65aJbvrp1onr+pgHQBC8JLGDmNwjueM9JIw7vZPy62iA?=
 =?us-ascii?Q?CHklJzeBgSq8idZMZPy5GmEFBXQBj1arBqQDXiqPV8BkYP1cHzGZV0y99dWS?=
 =?us-ascii?Q?SJDCBO6EqvZwyNsjvcm8M+CuYs2KCKGyr4r8hWP3jKVGW+1Masn61/JJ9BEP?=
 =?us-ascii?Q?hOlsTonxnOe/k5i1nLOIKBl68wUaltHZzuGliEcmOznLUZhuSC7C/HQZ1LxD?=
 =?us-ascii?Q?Eins3QfbmJFoxf9aH4AjIkpPhNzbjYOzQBjupyR9nNXkdtoaHuFFuXTreZWF?=
 =?us-ascii?Q?/2LV9Q0QhtZIvV4xx1SmIRiR63AeQLugxxdF313KQ31+WxGzy203wg7TMv3r?=
 =?us-ascii?Q?qw69lPbeLluIhzEOoUKCCI0JAND+fKkg5wS59w9Nr1hQlc9m4vHuyz5vC7Kr?=
 =?us-ascii?Q?C02WQQbb0bmaeyKqxsBVgxudlvCxDmIE1J/KaJGJojDNBOEhgPCZHl+8R5Ns?=
 =?us-ascii?Q?tKNBkX+vCR8XV0fv8RLlMWZRD9sIN8fxqLZyezeroplhxmf9bnr2cjAh3HZB?=
 =?us-ascii?Q?bQGgHlDK0FOCHd5GJ63eqom8h/3rjCUqyKmwBb4ga0xFfamxBE5bngo5xbr+?=
 =?us-ascii?Q?gTtCtgYvAsYt8mtM4g3qrIeTBytUZelPoI9NVraBSVYuBz9PamCmd7yDmD2G?=
 =?us-ascii?Q?9weDtIgYcw1OUvo02cbYh6jhg9Khn/PimdFjGmn+r+ZH3Xuqg/3on6buKjAu?=
 =?us-ascii?Q?7lU33K2dKIUGzLmqfKLqb0a3/zBzUBXraQinp2NTuNHTfIcz/bM33as3imqY?=
 =?us-ascii?Q?cBU2hdGiKWKRjNd5GYWt/mEOyiY7bu251eOxE/GTFqHvQhPQcp9eTg3f+iSy?=
 =?us-ascii?Q?nT83fWOwSNrT3OGzgmN9SYjzDo4Tw28frvW6cmVNLb38fH9GxqKXQBaFCze7?=
 =?us-ascii?Q?ujOy13PDw5FCWhlkYqbiPYA6ahKiNDFz2c0RyHstsw9mPrP+M8eNR4WZNqwV?=
 =?us-ascii?Q?7PAaDG2xWXgmnSo3iUAu+AwQcdaRqgLnm3Ep7LGpJeu79EeV4uOc2+r+qIUZ?=
 =?us-ascii?Q?YLYKYvHI35F5cczGgsQ3wkvGFpQTt3EwgZgP8iGra7vNBQtpQRzMBaN2nSGr?=
 =?us-ascii?Q?xJch8/0RB72agx+YNoyMnA5UYvYUJss=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd2e510-a5cf-4f33-65fd-08da4dd40fd7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:04:02.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UfKuSYMec/z+d9YYW4r81QImWSheljNKqi/jijhGyAk5NGAADnM+obc2ZXvTW1RmXSNSEj54ZJIOCuSyv01ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140026
X-Proofpoint-GUID: RoLB98GU4eylunY7S6Wclguv99Ww2gss
X-Proofpoint-ORIG-GUID: RoLB98GU4eylunY7S6Wclguv99Ww2gss
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
index da70f00a59c17..77aeb0b6f992b 100644
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
@@ -903,18 +901,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -970,12 +966,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
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
@@ -986,14 +984,9 @@ void kernfs_notify(struct kernfs_node *kn)
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

