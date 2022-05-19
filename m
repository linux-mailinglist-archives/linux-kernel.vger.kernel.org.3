Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C352CD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiESH2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiESH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270B8A323
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J63xoA007800;
        Thu, 19 May 2022 07:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=hdcN2DxHu0DQ013HIm/YggatbrfmzDjJg/4IfCBTWbk=;
 b=ktEOJxgdxZh4gTtZrFyZsEjIJ0rHi4DrrH1m0y568syAZqsnbQIe/jbAccyhKGpeZ4s7
 3QJMTlSYIKoqFJmJpCSM/zB5KsQAlobYVsXjRfRuWHrcvqJkJFMwQn0+yZw5HDE7NGVq
 puwQZ2zboYg3xmQ5hwOBXo10CFCI/lRJDgbwCwy0tmnk/DUne56E2lQKMnFJKMwi+qrr
 5YOOQmgHg2h3iB3EdWAyHPtdfr3PHs1BHEK0NFOutlCB+hz4gx7ZrLeg42HirrE4LYoP
 cWbZsuQvkWOOzxjvVwWyCw2G2+mkKnGI8a7IZ6e0UGDkr/TYpGPqXC9f2A1zaslZAJ7i ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucb3aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7G5Aq005601;
        Thu, 19 May 2022 07:27:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v51a8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMqztEP6vUK46uBbJvaAiB+cGTNT2FzCkI5rMybNZ4xqjdahvZ6VgLW4McYDi582hO0znrcc4x/19cEtqdfqxV93SpDInFfOzCkPWHiIQpxjPgGUzn3Uvq5ikAiVY9cljNDNifFE24h6FDnWili9RUkbuWnU498i36BfHs1v+qGWleOwyDGPqZUL0qK+QxYll6i50latZaR/kQyjXfPxu9n4dCiYcQ4GtvVoKIkUfM9FpokvbdGXz6Hw8KC5ZI7UjjEE1JtHWRWW8KLVxMuah8Ub1xvaRcWp+Z2A6LmA7e8+ST/BKVIHoU/6U4doCyEyDpRPmzuc9DTRRibdYB3L8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdcN2DxHu0DQ013HIm/YggatbrfmzDjJg/4IfCBTWbk=;
 b=k69tedihOKYcjYHxvNXLookUAvNX/omN3qM5Jf5xWAAMXXyHySI3guii3mF0X+V5YOGrLIyjMyoBoY4yysYzNpsbcxGeeI9iwJY9eNYvZ+NmLs9iVAZadhbwpDHm0jn4DBUOMWkHJyvMicVs7x1JrzVcF6emblg9Z2xwN6VeK3bK2PMLVVUBT5c5QIGaIluikzEBmEmly+DKHRLrAZjHzQUCHWSSKK6lXY2rqU1dwu79umhG0CCmqivZHkmCM0GGOaNV0U9Ij+vkqFUIU7RDc3y61PHOHD2ZPjnvTz8OFrQPvgCytq1b+Cg/M0aQm4aFUVeWt8iuMPeT5mSZ0uUq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdcN2DxHu0DQ013HIm/YggatbrfmzDjJg/4IfCBTWbk=;
 b=YHHrv7sZzYcvAUSAUmEYaQXN1ZwYp0cUlyt3G4eaPamKEJVQMVqsgl9NBHKdeuF701Qyxn/PkSbMwg93kTygfP6+DXskQlWaW/D68/jI4aC29dymEm2Ru0A24tyDok7rQe0n7ilavA/OfvMiCKNmxCcaZUpCcaNRMVgODrnI0tg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2154.namprd10.prod.outlook.com (2603:10b6:4:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 07:27:14 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:27:14 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] kernfs: Change kernfs_notify_list to llist.
Date:   Thu, 19 May 2022 17:26:56 +1000
Message-Id: <20220519072658.736370-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519072658.736370-1-imran.f.khan@oracle.com>
References: <20220519072658.736370-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::12) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ff5846b-65a3-4395-43f7-08da3968ff1a
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21545B6548D8243E6F9ECAE2B0D09@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCRTObryh9NxDZowpgX1G+Ga6UjJXvdaG04DEsW9omRNIMkHFlSUSrx4gFsswiTYkRBvEmmOoKdvplW7CVDfSKu6VurgEtNY5VeMG6cfkSvqKx1ZnTARZG3howdHkwOxrnSg+k9lC0FBx0FdVgShfKHesUjChA2fDjmfgJIKH7wGsb3ezOB0CNWCxZCzVebbzdz0j7RjOPszmPYNJkep5jItdXBVT6mgV9wc4SF4AS+fWDggoB7lIEx2QoW7Atx31ClR+I5a6yAA1en1v6aihYevVOOSKqp+rUT+RqfUkeq9E7RWhf///Wjy66qxkozXgsGbqA7PJHb4VWEKo+/SRpeBJGnrQDKszDgMajQHWOITjgv1HXZvM1KrH7serCbCLiARa3hqbAcdKcdIi86hF3/ISyHB43RxOlhhYWMu7iELXR4Pw5nQd0GDbTx0KDggpbzbInkmNimBzJvUdB8pU6eTSFO/eE4jMYDtvQhrv9HacGmeEAsedzSty5m9uV5RIkSU1v5fW4CjJVDvZ9SNrNrasm9fwNxWoc3YP0dW/jqnPstOocCuNmEoahlItTo68K1diwocxrwy1LpqxKRwW/p2gN2S3aRNNtZAXIYvwI9Upyv7WY6ZMlNE7GRZcH4ceoVMjNpMHhBGclF8KL8ybfUB4Ym7JnclapKSuYmeAusjD7JyL72OeG1jZ8voSosU73wQ2J6CCM4O7iNhpyUcBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(103116003)(8676002)(83380400001)(86362001)(186003)(66556008)(6666004)(38350700002)(4326008)(66946007)(36756003)(66476007)(38100700002)(1076003)(6486002)(8936002)(2616005)(508600001)(52116002)(2906002)(26005)(6512007)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U58cVmQblJNTd5q2vU/of5ZXY6eVCyU3M056LUlM20K8XEBO+uYx2BPa9iAM?=
 =?us-ascii?Q?plOkuZeDHmzHOQNICMqBynmb5YEYSmWjXtWmyrga3mkxVpXm6nTJYy8ZTphL?=
 =?us-ascii?Q?VDsXMnB2e+kN7dnKSHzGauCY2+zg46jIgZFn+JukfSAny8PNoFZTL/Yr/Lfo?=
 =?us-ascii?Q?hjpzlKfJ9GtOgDa8O5jYe0QqgpctJlTQQPkp6YgJXcwnYMLqfQaCvWvjzDfh?=
 =?us-ascii?Q?EhAKH7vVLTTiF5BwF4AHzoAz/ga93Tyf55mo6qvluEJ1iu72yMRUuukRC58D?=
 =?us-ascii?Q?yGPej3J6THCuEFwqeNxzzppFLr/df4u4Zl/54FC/D5vipN+KTFm2DpETO2S4?=
 =?us-ascii?Q?ZQMWVun4/34pmbv/8RQXBj1vUNFQ0weyZaukvr4kw9ZOECR+6xbDUGmSvYvh?=
 =?us-ascii?Q?OC1EUMV2z4BpOoCHj9EyhLG9aZQtZIXcQ8ozfJzT6R0unBjdLjVM3HZvAcEI?=
 =?us-ascii?Q?UbKwxWGKJPe8XK3j1h5vPU5kaC4ViBxUxn9U+2nq2GObT0WbAzpK8ARwyjhJ?=
 =?us-ascii?Q?YvT51DS7l7B9UKN7oR+Ms5jF0g+OqRMDcMU6LaML/ynjuaRqUul3lQFW5YCx?=
 =?us-ascii?Q?UVyNA/2erSLJ/hoJsAr2BK7Uf80ZGxe9QDNtT7g2e70MFoJPTeLomOVv5Yto?=
 =?us-ascii?Q?HdoUmKjHt7z8ZsdFZVSURQIDd+HIZb/pa9CB9/vZ42iNCraU8qDzN/U8xjbl?=
 =?us-ascii?Q?854OeXZEhqMvMs9OtJkjdYShWYeD1AOL4bwxwIPOLpppRsLI6tca4m0x+25J?=
 =?us-ascii?Q?GhRkL2hN6qCpJ2EcoLdDSHvGfu3fHi2VWeICtikq4mcEK1AzaVJUeL54k4Pb?=
 =?us-ascii?Q?u8RCt5KboqY75y5w6FpCqUGfqaIxBAhZBcqTXABCznykLR0Cp941BHxsj3hG?=
 =?us-ascii?Q?Kts3bDxK3l/dBdjH5/nCBGQ6nUxjVXk3adJo7DOkcw1DoaptWaHzYl2jm5QS?=
 =?us-ascii?Q?xl6bCvT3ekOYoA14KQL2giE60tObHTqh6iLdY3K+lRVvmKkyN7XB9QEQRhAP?=
 =?us-ascii?Q?Zfk/F5/ndj5ESVDtYAXn3RLlI7FK5HUpRo1jtD2e/1zDPirSfd6BxDbJTG/7?=
 =?us-ascii?Q?yWDe3YF+DI9M62jrtWmnvNo+FE8S8mXwUV6U7lp08li9a/mO50wk/iQ4Fwl3?=
 =?us-ascii?Q?PkZ1POCFg71AB0QWvZ1Mg9AYSROzqHJ9f1+UOJHk7xMmTNLFFRw/DBvNGdJx?=
 =?us-ascii?Q?v0z6o77U609hb7Pfby/MVyEJ22ze4CcA8uUtI6Rf0jxhdVA/tMtgV2+LLsza?=
 =?us-ascii?Q?NagAcmX/0TIat2PVvnSvJsaYorZ/stt2xMoWIC/WDT5IKcCaPahwcuHv8IpJ?=
 =?us-ascii?Q?Tv+MiG/Fu3My0QJfmPR5RAmBlXlvPGPCqwM3ew/fcMCEl0Eukl1jZ3ZuImlq?=
 =?us-ascii?Q?Zqfomifv4mIfRru0QZt6Z+akU6pjE5MT3R6wSg7KWFN6OEN9ZfZWbyMogIfW?=
 =?us-ascii?Q?YbFDQHEdwi3ttt0itiDCoVe5uas9w3cnVgK2wfUHCK4y/hobudD1gnrUf5zL?=
 =?us-ascii?Q?CRT/xF68gUSvAHXI7mt2zIiaAEGiLb65DsT8Ruyu59IHifS6wis8UUTvtK5s?=
 =?us-ascii?Q?fyA1zo90msbqMb5P5HMqw3I9+4QXkjgIBAwfNMHvMDo75fiQQRE2qGyduzEr?=
 =?us-ascii?Q?vKrwja+Sp+PiYIqcDA/ZkN6ZbPsXERtU0VyGlOVXq0C63TNTwk3IWj/ksEAy?=
 =?us-ascii?Q?mmcsdBPyPu1o0/BbsnUlocY3HCejVgIUgEDPTEqahs0KyOFLSXX6b68sZ/2Q?=
 =?us-ascii?Q?xH7ailxSJbYoh7pRYbA+oywuStwQMy4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff5846b-65a3-4395-43f7-08da3968ff1a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:27:14.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GagWBv3r9nprIoxwMpj0Ulas2iVcpDqHHRFzA6h45cVQn70eRr6rp0o6jmiCRvQlfnenbUPTNImR6vULT37cAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190045
X-Proofpoint-GUID: F4AmjUkmB3SWdE0AY7av6mXXW0gfJoLA
X-Proofpoint-ORIG-GUID: F4AmjUkmB3SWdE0AY7av6mXXW0gfJoLA
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
index 8264e28f9098..3f883601c5ec 100644
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

