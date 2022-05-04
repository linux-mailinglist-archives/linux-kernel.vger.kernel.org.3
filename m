Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CD519C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbiEDJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiEDJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FD27B2F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2448qP0C026110;
        Wed, 4 May 2022 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=F/S43S1G2f1y/B+jIrVqbDcNA1FpthwZZEurJ0fk4SNM2DVbhcL1pJQKZ3uRfRIKKT6N
 olU8kdYa6xoVO8YVO/1oOlaGheFzSb3DrceXTOFvQCQc1VtXV74JQ3OxtRCC4ioxKB+i
 2pPOho7D489Zz77WH68SLWYPOojG6H0SvXlMzfoCxJdW1mPwJK/1UEoWgMNxwKywoUbH
 sq3PjYjfzykKrGzmgi09iRNQ6tpkeX20bd2oMfSN24V3/TJWn8tnZO4nALg0osd/FPj+
 tur8tjH1Z/sSs8+BlsgJqnD6AlkNm9aYTRqQOzNRQxybZybqS7AgNzvGhNwW1pHOB81K AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7uyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2449iolm015704;
        Wed, 4 May 2022 09:51:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj37taw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 09:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+SG5uM4OqmrhAcPGt8oYCR0VPUCaOB5YimlBVo5FAX4b9uhsXcTX3cArgmPLHJLW4Mk2oFuFA/U/EKxnHbGi4JPbkEN606FJYo7jvf3TN148gVFaysrDlDexePIlGAWtswTrvJCKp90D2/epIMGP4tJcwpVMYwRTYYEMFhK35K9tmEGrOS4+A5TSvztIQBrjBoZW/x72Nw4yRFNjI/T7TlAxuzep0By6wEYto7wZqHYPc1Ak28lePVIFdPqmzxk2Dpnv3URRxnR1YcWW98WuePDeG1bCjCakElsD4B9KtmIFWfzCrR0yOdjJyENhy+VeO9uGt+Hg5E41h+ORpLL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=OzqOFx4Mx9DZWH4ZqXiRW/SnUIxX+1OvjVFFqrY3DqKRS0bmVYDC7fyhXZKIWTLCqZTPRpwvqoqGL3rCptp5tCnDN8TAj8Y7D5Ksn9dzArYcVugJIfUMVncllW/rxsyWPk3DbMvOWxGDvtluqD/inzet3r+VEEsirRPRvenqcDCgCKmcpLFWKsbSCcgwXl9AJ8Q1BuLfaZroMSPufi3z/0bRBWocp6pD75WcCJXrtii6kmOAFUmliVjGjoNjI8BjY444kjlY7/w501oWLcQZtlGpdG2mmdgHGj5MauidkVDG+GtrDqpkxHzVJm9rif6isGSD+JdCFIaQMLbxG9HKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OkcfwQVEoQcLOHcE1BNDaBawN3QOSQ7/Fx8akMzMYA=;
 b=MOizWancv7+G3vAtT3PM02t2pLd3HOBWyMKqIt/tXVibgKV2/SefMNeD8VhW5sZrgLUjhUKJmji7GirCKctMTwaT0KqjsKC9sjSuQrdep9YdAaZS3856QMve7TAR1sM9z/KnC40GoOHXdUI+21gUg7N5UC0ijO4iguu4fVJOZIk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2316.namprd10.prod.outlook.com (2603:10b6:4:2d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Wed, 4 May
 2022 09:51:45 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 09:51:45 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] kernfs: Change kernfs_notify_list to llist.
Date:   Wed,  4 May 2022 19:51:21 +1000
Message-Id: <20220504095123.295859-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504095123.295859-1-imran.f.khan@oracle.com>
References: <20220504095123.295859-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0203.ausprd01.prod.outlook.com
 (2603:10c6:10:16::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f910664f-7ae4-419c-5864-08da2db3b299
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2316:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2316068488F5C1F4BF456383B0C39@DM5PR1001MB2316.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrcYIkJsHHF0S02LPuAM5WylHKZvPL8Z1X+JTAUaB2vx21rJL4yqHjtdQDDHBFMgStqQZ2s/6ajIV4od817WxiWnsvs8lCKm9rwWjTtLnMD5mnnlNnynq6cTn6r2Wq93V7p0YOvWjULBEkHehHLkIzE8LZjFXGsF4eV9ZgFoE26u1f0/M/FAG0bM0b9KGn/yORXLnhld+Af+FkjPBulJugGkp21hYutoc6jWyEwie2TSifhi0H/r84kcPbtFlACS9ip02ch9bcA0C2XcRL3nYV1l6dqtIAQE2HdyjSX7mAaBbpnE5CsqIQlCYIN9UwnsGkuhzWkQcP3RpDIIKoYoR3WodV+4wNygBnRTXdPn8aXCd1aqA7MnacgRC6vJVvh7CGG8G0Kb2IUHzuTU7FNQ8LZ3ebGMvNBcPVLeeiXfLc08a6e7zrQgqfh/7SvcN/SreG8QF6KD+M3A0OeUhJYj/CziMkTLzkA9H3qMsO4X3nax9Dy7mw3KWjBJMZ0O5qjsOcPBH2ggG9ppqmu0w5n6PPT0mUzuKXjGnIdpsBtyavJDQVLKBt1i0a/BxCjeQqFCQqVnuQUFbkV4qxDBJa/TvDlc5tARg8M6HU1OlEvt0ObQXW6AJ+IFDknpdjV3REdy61UX/B60dsqXCqPuwNolWC4mby9CQJTMRDu55Uc2FqG3WWqEvGOUnL0dRodSpoQBuoJt+NRj9oY58TwweIf4LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(2906002)(38100700002)(38350700002)(8936002)(186003)(36756003)(83380400001)(8676002)(6666004)(66476007)(66556008)(5660300002)(26005)(66946007)(1076003)(6512007)(2616005)(508600001)(52116002)(86362001)(103116003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Da6H45pP5nE2pEh7pS1By4muGmPUyp7JGZSMvoV9f1tBUd7vBEn1StRn9CI?=
 =?us-ascii?Q?1LFERD1Lvd9No2ggV1P6szW28Stit0I2rwsDYqn8gwU1K7XY0joXtXU5Gb+l?=
 =?us-ascii?Q?uVQzV+0aKTp/q9CTfThm3e97DcfaMtEVfNiDXqYSiqKtGKXkXVbsjY9/vSQx?=
 =?us-ascii?Q?fncbk4aT9y9ESwOTcifGR1nWFKJkpMPd1hS/XgkKOfTkGPpQL5MZQ5ZWxyLQ?=
 =?us-ascii?Q?xzoWAX5fFpie8IhLGjlzY0n266Dq8Q/MsGii8lhnFKrY2QzvsLBjeaDb5OgV?=
 =?us-ascii?Q?irSqZFxbEw9COT8HOp1O702mmq4n7d692uK5Qekf+A8HB0hUZqWRXPOSd6Qb?=
 =?us-ascii?Q?zMj8R1z5CyGjMtyYmq5AlkYrD2hjKxNSv+XXNnMglBeBd6SxhEpWmDwtrAlI?=
 =?us-ascii?Q?TIf9wkimIEHw2dpqGHX5Lw+Q7taSzENQG/eycV1TZMlDBRm1dnju00uOteTr?=
 =?us-ascii?Q?db3uDr70ttQxZm/JnyDCHUAQ2ioHrU5IQ1xXLCpB2xiv0j17K4kPDHL1J/1k?=
 =?us-ascii?Q?SdCtU55hjDWYblnDUb08lewS9ai7eklXWGHRm7mwn0YCahu9u66VrdHOHqI4?=
 =?us-ascii?Q?qcZoYn5dSVvHnM6ZTC5/ZZtglN55vGYhGjubuJmQztIbo/UFkXQqRXC5mTBh?=
 =?us-ascii?Q?BYxQfVncFAwcRJDpaZ9lRv+gmPKqoD8wLoE1Bd9Pii16YbgeSMvgSPz0FqhT?=
 =?us-ascii?Q?NQb3ZVZWPDzuV1eZLrnAYOEQxQrZK8Tw71rvsaumzxiTyXT6cMWTdehb6KH5?=
 =?us-ascii?Q?iBJFNZUl6CR9FQvVT1QocMqaKqjIm6ZMqACODf4DSdD+H5wFCoeRVj2EvGvr?=
 =?us-ascii?Q?BbkVhVzxmVIEHeAVRYx0mU4tZlpZtYKH/P9lGgAo22f42FtvaYxO0s0D3m9y?=
 =?us-ascii?Q?CbkwwIXEivuhUbFEwiGSq65sQgaLMNEQf4uQ1dmT5gAnMAHGIQjX2Wt2vkNj?=
 =?us-ascii?Q?dg3QgPH8auyvRuaC9X/IA2RVvhXQya+VUvfGzUNqtqvL7sQCEoGSqk3AlWn6?=
 =?us-ascii?Q?Zfmmf6l3Nilma2F19LaswEymNT8HU6O6kqpAp2tsUpPScT52CrD9QXGlhSdw?=
 =?us-ascii?Q?zgGTGa8EJSAWP0oiXOgpM3ZCR1UtwqxOadAcevt0eGSUCQx9Sh3s2eAwukFy?=
 =?us-ascii?Q?QUk8YtQV9YZO2SU4lMy+D0tYv3C8YDI3wD59VJLebZod7ntfFHkQJTH/Az/h?=
 =?us-ascii?Q?euiGQvvRP035XK9obI1sdFlV7Ik3EGAo7CRjnOo8lVLDQLeFpgC8fxJuq0UL?=
 =?us-ascii?Q?aDcF2sswwp180H/NbH6RK1fgmwPfio9bGnSIZji7922p6oSBBgteczgil86i?=
 =?us-ascii?Q?FNFDcESvT+N1WFCOqNeq4SYmCDyDfWrWDrknjCia23FQ1/UUGOTaoW7yrG4F?=
 =?us-ascii?Q?/77tdo/jybluNM0welrz/sNruejEA0r80NrF72OWWUV1qTyhxra1nMfyzqNd?=
 =?us-ascii?Q?LVZPVGdr5IVezbp5xw3ZpUBlZHgLxoIuDmWqlB3fTFAn/8F6fyGGjxl3hU8f?=
 =?us-ascii?Q?EiW6oj6h8fNildSlayHdl/3TuSoWcAfHbJrkK4EDotq5ucwJ43w85l9PyP9D?=
 =?us-ascii?Q?3d+DTB0H2GD8Oh2xOaVquO7D3DrT0tHD7V0cqp+TvUvkRm53uIH54mMQiVQl?=
 =?us-ascii?Q?0wuK2KFzrZrNVqPsoa82J//v2ZqjjmjB5KEVKVnP8iQGwv79PZtTonC0gQTL?=
 =?us-ascii?Q?qfTtDClnwDQpWPMtqhgWuPqjauFX6xlrVJX6bC2ESXl97cGmetK24uOd2eOk?=
 =?us-ascii?Q?/gckga/wUgnHojrFKLPHJPnTuNYv+5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f910664f-7ae4-419c-5864-08da2db3b299
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:44.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nL7ehQf1COOrTXze4bR4JksQwnGoEJzjZXKaUn4tWczHgS7J62BfFtB6NafMCu7jOVQ6Gc4olNLtK2NLrDGPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_03:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040065
X-Proofpoint-GUID: EbI5eLTggQ0xkRjxhvaGBcTbh90qeo2U
X-Proofpoint-ORIG-GUID: EbI5eLTggQ0xkRjxhvaGBcTbh90qeo2U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

