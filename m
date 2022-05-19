Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD652CD01
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiESH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiESH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B6387238
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J5x4XM027473;
        Thu, 19 May 2022 07:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JRIL6/CfQA8Kjswn0c+rGygeg7AQia10G1qLQf+r7zA=;
 b=g8ThFICwIwWzIolpCs5dFd5+YOgkBWBd5NFWUBRD5PtP63mEzHapxU19nd/wwRzrwt2N
 OEFsc8+/KM/pW23nBZTK8cEgDGiR+8NS4ZoGzDHlbaCpqPDgL0hzPB0tAhqJrk3F50/i
 vYx0LV8hC8Y2J7L4I1flCz21+kyn2RZ6J4X+7tmHIWVFuS/ohdT5h9VGn44g3XBnlwXk
 GXUVUxdD5a3OxXE/QUtJnXxwGtoBkxiB6nSFUT05KqPslkDYMaaQsiPCJPOXvJ0eJFmc
 ht4sV/nBWsFR68MAN/h6YWIuAS39jv/hFA6gEUN7H1Mh0r1jH1F55k9oGFdrY+JfVjgb vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sbcry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7F7l5023368;
        Thu, 19 May 2022 07:27:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v50ur8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/FlOPqB5KRHLE5Kxy0Y20POISnHABWN/N+nfKvdwfUtgekWMnfOcR3mGtOdsNOl7hOzF1ffI2FzxwFXT1MkxEd0iok5dm9WnDSVpr/yan4mdcDZ4gqD1/egx+29OBQwBpG3vRKR9jnxo51QX9mk2R3zNFIdMjBSHMjmlh5iKpfsz7G+fspGtyol9p57qZJuwMg4AP4PnBywp4bHpzFI0Ixc5ZErtkUkznEjJUi6+GZTB+buhfIbXAby/zAvhzuBByChatXREZvvjn6HQtH88FTifXNypLQUNCiKGyPZB/dZlw+JSO3k8KJt7BvUgBGwMiDLE2KgIyWv+Tk0HTx36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRIL6/CfQA8Kjswn0c+rGygeg7AQia10G1qLQf+r7zA=;
 b=G4BZJThEhM4KHtLPWV1vV0nlGqP+/sGeaPqiieKeKzIjF3HZvTABbHOTGux9O4eU5G+IAsGyd8NXFmeN5lqR7IuF6SvGahTmX4axXW9SWlJ6hHJJ8WWuO0APZ31hN2apVS/25gle85Buzcp4j/ampR2wH7bvUUBfQH2TPO4aqt0nuMgVnfn4Q92TljwIbkFegKV34ddJs62lmNHh0h6zsRTQ9YSZsplJHubBHqGm6N1ZsoDsEtG9ADC7vKEz5zK16RZG+zQ5oBPWttYW0G6vhP1o/mOf3fZMl0lJoWzj9jGbzn2S2jt79gGLFQnwLjF6+K4xOnQ7poVlvLFhp7yT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRIL6/CfQA8Kjswn0c+rGygeg7AQia10G1qLQf+r7zA=;
 b=vKBjaxHI1+wz2TQHKUiVYi8jUUof3poI7y7O0KnqsS4BuJDRW1BGY4EGguwCqAMyIxzA50sZqPwPma1uYrrqTGNX9WG8KI1ZN1lCKBOFr7SMVc6CfJeZst9Z8IKgKX15MPB0CA8eAQM9PRIEm4we/MpSa9U85/NAoVUh01KVDcE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2154.namprd10.prod.outlook.com (2603:10b6:4:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 07:27:13 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:27:13 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] kernfs: make ->attr.open RCU protected.
Date:   Thu, 19 May 2022 17:26:55 +1000
Message-Id: <20220519072658.736370-2-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 195d5650-ec31-43b5-fb05-08da3968fe1f
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21540B06B8C46C12455DD41CB0D09@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPP+hlC/P3fX7UxwSlnqMF7lfOjr/OwcSaXIiaYM3mlTHlB80YU5jMg8Rcu4NJOOat472esh9rlAywOLlDaxYHj9l3tLBCznxHrTTL4G1mHkof+IdiqaX2cj9rlVPtdLQbV+HFNTZmG1iSUoNqi5KHGNa0sqqhIDWyurqhDyvpwgpeick/C9kpsBVRIi+zG6dWV3bDK9yCfsuJqydJzHSsxTWKTxwTAEEPhtHejsFw86Epn5JY98VKg9U0xnNW5U1BekqMf551UyuuyDxUUm++ltTrDAl1AEhajzG1N5KhUBeS2acAWvcC5j7h/udbkOHZicT268KfDxh/wpaSDR7M5XmcMo8NpC8t0zQoSg4rqiseOFwJqiuVoCSLR/wyiHNMFvflWAf9qGU0JXCYzT/QHn5NiQNuJQKkrzQSngYzOFJkwiv8tI0fCcBkYgAM8Np/iAf4BK3mU4QOTcl0aLeqIkEQgLUFXSawl60iojQdLqQ6EtMfyPhOnbVhzt9k1Ku5pVeeK3rGvojBT61SY0vE7cdhh4FC4RoocxeQOA8FhG1OFX/Pl3t1O3LQ5JrXoxpLoUK0QLeTi3M7viVyjzdOqI6GK8QKcXy5S7bn3KPp3iyEzjCnXfVXoWe99082GREF5j455qlihRdnsQCVskPLD8eLGCICo2TuwMt/c4a7eAUuzkIcpppfTm7SEPxA6kWpLZdV1SHkIecdCnCrQgRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(103116003)(8676002)(83380400001)(86362001)(186003)(66556008)(6666004)(38350700002)(4326008)(66946007)(36756003)(66476007)(38100700002)(1076003)(6486002)(8936002)(2616005)(508600001)(52116002)(2906002)(26005)(6512007)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSg5vDU1Ojwt4wEuB1lJXjClCwUJAkAq6+ScTQximxibKh+T3e4B+BMyW4D3?=
 =?us-ascii?Q?VCDGjCzyb44TNP1WrdEE2/+e9j/dLdqolhSOHmL0I+DLyVA3vamOVdi4h0gY?=
 =?us-ascii?Q?uZjqc4hPhXJAq7n5Wi3UvOYFZtLWB2/qTmV3Rpkzlgwwu1Os9Yf+L7iEqWpd?=
 =?us-ascii?Q?CuW3YpfhpFpqEG9IFyfLi4oEmXMPDb7ak06qsfxShtA3T71LlxkZ9wXlr1Sh?=
 =?us-ascii?Q?K1QbwMr14OhRIuemqviegJ9wVyaRxs1k2G9wii+zqmFQGXDiWoN9nYINsAIY?=
 =?us-ascii?Q?sXT24DBzDctMVtg0GUrJ5X8X2VPj8qPzrXiGu5OT+jlS+KQ6X24uLqhBO8as?=
 =?us-ascii?Q?0dD72Wf2uEzK/0MWbrGv2JeQxx1ASxrd4EpH7PawIG/KawLJlpVp4U/lr/R9?=
 =?us-ascii?Q?WI9/lCBqRoXK3z3PiU3l7zo0o+5QUg/0S8ne07RccDRVPHyv7xxxXhhGiA80?=
 =?us-ascii?Q?+V6gff3oGxfddIQTmkgb2BGnzjrPkYFfZ2u1a4YRTGj+etsM80j5jL3+AJLL?=
 =?us-ascii?Q?U/otk0zv6pGZDPuKZOm8+dx4y60CWGuQyh7TmcFHasl+bl4OfMxD4eg7j1Db?=
 =?us-ascii?Q?kG1+1q4aAh1KlKTJQdJJmhWcMWVx3TGQ0ivdwRm3QrlAexYSRX6fhTxlyIDI?=
 =?us-ascii?Q?am0KjfEWK13rMRTvHCy4gXQzyGlX2VdjA5s1e5X2Gjos3ZJj1hWa9KjLLqg8?=
 =?us-ascii?Q?heOSbm/q8rju1FEq7ElpGmCWRpec6Z5ztZd6XJ3AirpXiVR9Qs3/dgOElPp+?=
 =?us-ascii?Q?J3LS209bpIf/Yu65ph3u66eDdTp9wJAi4Nd52V0hna5p2vPlQKntbg2GLQU/?=
 =?us-ascii?Q?uj8NdLm+XR4fcSBBH8RM2YyzK8kHOY+e0KqVd0x7E7/Zw3Wpv0VnKNI95TCB?=
 =?us-ascii?Q?CS0nQBRYAN1kW8uaOasOqpPDMIu81gJOLSD5fgBEO0kpsefdZiD4NW3JaRUU?=
 =?us-ascii?Q?MpG/LSBoGZtaJ2+6JziNl/sAbAQEZX+QoTXpThzEYl2AS2kCQdtbI8ApgpyH?=
 =?us-ascii?Q?LtX8FPhIjh2F1TVg8QL/6BCL/d1JYd3JIVzQmnHwnjpV889Yv1w57tif/1Rb?=
 =?us-ascii?Q?11QOWB98XqY4IScDmc3fo3F/jdOGjCgA/cXa+0VHFuZGAYsobrRPMCHIhIGw?=
 =?us-ascii?Q?UnEjEICRf3FJ3V/rdpAE73g52aInVzT1OL296fVMqZ/V3Srt6UsJ3Uhcydse?=
 =?us-ascii?Q?phgoekMit2aVs3bpAgEpCoBdusjHpNFnZkt1YBNqVsdAbVXPvieG0d0fg0Nu?=
 =?us-ascii?Q?Oz4Yf6d7duGvdNw6XMilrdnzOsvNGQhE7rA8QQCgoL7zrBpD0+Y56yPiGhJo?=
 =?us-ascii?Q?wo92DlyB1ZkG2Qm8pCehP9qmlTneCrsvBN1eAyHlwkoMat2TDjkbjJ0QEdmJ?=
 =?us-ascii?Q?fvhMeutSvHpCxVd8ELlSABlCXPThZXSd0zIosJtb8diQobQ43O+CUdQWeF1Y?=
 =?us-ascii?Q?coxkXL/R98qYkSdrlq2L7RCslokLEZWyDo8QOJxGR96mwe7+Z7lDXjkNKvX7?=
 =?us-ascii?Q?LifPflcLmUSR92wbyVrw93npZZTHXi9qOg8RCIS2miUPXXk7mcQZ6XZEbQZW?=
 =?us-ascii?Q?ni/mUXKIzFiYSTYs5P0y00UUuOc3oHRRtuqg/NYQ1ke6w7a6fmDOUni7QCMg?=
 =?us-ascii?Q?YZwUEAK8M8LbFyG7F16pMOgYVIT21SZ2+viol7yRkKzkWknPCQTahNJgBS66?=
 =?us-ascii?Q?IvVAw850wdOcN9DdtGGHFrxZmoWmIJU4qCa43eElsy1X1VKFk09qegBMzDsU?=
 =?us-ascii?Q?oCvj6jFWknTNH8zNT6NjsQJ6vzq0hIQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d5650-ec31-43b5-fb05-08da3968fe1f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:27:13.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuHxmUTcWilo0FwdgxrOM8AVrxlhf4KSAzf+8EeiYAMNkfh8ce56dA33C3Vlog57cbftK+gc/5RxRQcgyrRXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190045
X-Proofpoint-GUID: LNPm0jE7gLE-cUmd2nFtDqVDw8edkBoK
X-Proofpoint-ORIG-GUID: LNPm0jE7gLE-cUmd2nFtDqVDw8edkBoK
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
index e3abfa843879..8264e28f9098 100644
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

