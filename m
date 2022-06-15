Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60B254BF92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiFOCLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiFOCLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:11:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FC240BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:11:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0SwLt013333;
        Wed, 15 Jun 2022 02:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PDITXdINvrrnnw3RduAKjRK9Ukj2JJpTbDng2hhfGQs=;
 b=uaOYKEijkg0apHA47KRoNHK2sI70NOd+bTZls/bo1pzdX7nsrYEeiaw9Xjlu3XXKVF0F
 986CZ6hpOwQEtHxUte54eN5mmiyUyzWMRxoJXvBtf8osPo2QKoX/h2yrbY7A4ciM7skv
 /N5xIdgv9HlEiXi6y4xZi78ryL9KPVzWIyRHqQRBV+S/F5d06Ru0DhaUwUP20tP+jAJB
 Q++xH7wP65cE2I53dSv7skmkGghtLgkSzzyGSo1yYnNRWkXAHTjC7z5GUEIBY+vqjHFV
 cVF7TRUyUpsBCi4gJ9B/nwJiQdXhlGczgZJFYwf1OB8usdpb9OfC3cHUVS8wL7/Pt7Mb Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktfacw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F29wlT003789;
        Wed, 15 Jun 2022 02:11:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25a1ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVEMOkYm9Unb8NrywnoNIqaCrDrI1Jlj1ylLqw3ASJCCdb9HaLz36b0HYNht2uDOvIxQlXgHle8Ios6PKPcIXQIPv7QADqDAfI0539C6hmotdSbaiFtzmCZhz1LuoYYVgle0W3j29vJXQPevlQitmHTjVAv7G7eUep+gS74Az7DzpREPl9t4z9Q5LRa9FqndYaS5aNaX+DcNmHs0N7fcLU16Z7TgT9zG649PFyyYJRo++pNw+CfTVwzBqdBRa89wJ0yn1WUs9UeDg52V0Sg01EMS8S4PFswYlQ72js+umT33wI1+1dve3iZFJ3WjjRngxZqMyDS4ps+5XFdaMOZNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDITXdINvrrnnw3RduAKjRK9Ukj2JJpTbDng2hhfGQs=;
 b=Hf2bgeKmq9AQ5gRq+nQhg81r8yMXys3+V9xHspnVBTetZdymZAhy82QsUTJ/SHMbim1f5GdvOI369VeSggNAgCanuCnOslxN1AiZGFRgIOtdDo5/dgpyrzT7XstsMA4t9R+p7eqfnRiqI7YOMxnNjpkstIU4jyTF0lT+pFUmGi1PfSt1d9vOZUQugr+W2jEsiBUfHF/OTIYzgROpBHnIKroQ8Klu1tMX6ofAyuriGFNpAl2IDBVbRa1m7RhuYPlkZ6YvMlZaiEcV4AuEn9PCncG6n/3L2xF0Dq82cfiT0au3cu99DKFx5AWWJGf54rB1PPyiXOy106arBsd/OdmvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDITXdINvrrnnw3RduAKjRK9Ukj2JJpTbDng2hhfGQs=;
 b=toz3jHwOe3SQi/AagdfMYMWvKkGU2m+fEUq4+k8QF5x25cm1NFvGkiTCyFwYYu4PCHdbSBy3pgE8QJ9Wm1Lw25tNa+07+rt8RPwNNkxg1d+tpzyC+Dacsox71O+VhK+V6iEw0okc3jKkE4eiu2SxSHti8NxvoF5xFNvy7/22bBQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN7PR10MB2513.namprd10.prod.outlook.com (2603:10b6:406:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 02:11:14 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:11:14 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] kernfs: make ->attr.open RCU protected.
Date:   Wed, 15 Jun 2022 12:10:56 +1000
Message-Id: <20220615021059.862643-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615021059.862643-1-imran.f.khan@oracle.com>
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9ebce8-cc5b-4f75-2772-08da4e74530e
X-MS-TrafficTypeDiagnostic: BN7PR10MB2513:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2513D9E73156EC91F11DEEA5B0AD9@BN7PR10MB2513.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5P26jB67ydFX3qigEICF9OkeNPw12Ot5KsNQmR2NWLftQE32dp6L0/gV//hh+V0TKMyD5Uf/tiuKel3LcQb+W8xdQejcefPZF5yC2WuTHkzN7rTgwPBjrhhtuPzRk4pHlzXGgbgZVltaiAM3xBDy4UOS2hwObyFXqPG3Kw+Ephb93lHc3L0xPTZZMAAV2lhMs+o6tJz57vbUsyN+CRKtOZ8oW7/Nt3u4mz35Am9yqdWPGZcEZcLMuQcezFeLzMiVLdab2NYm56Urj01n+8cSgTUaf9tKYXTr1dZ+dzryk1d8pfx2gp1Fi1WxOKL0+jaM1cJpgdY1OrUC2ZXf71oB+LEaG4eEOfJJpfe5VD7ZnbIwqdW8dqHQY+pwFlRmUZ0fdBtAhMObh3JPb7+x2G/rUZh4cNSTfTWceQn+6nGAUYL1vnWHqNjSpQpo4rMEbrWoyz8sWifrI5sPjIYhpd0Was/KbDDsi/AaTW/rjeWvAaBTqjGW9sH/1ZQzUri+amifcsccQnBzwmQgzJzg1iMI55hCREfqpdGKdsPtMUpqAEAgpg7mWxGslXAi9idUYIZ2q7cU+1CDp0EyQrKD4YHgoC9dInnafLQqJ+piVe4m8r9vL5faaNcBB2NKrvXMGuNzF3557GRR0IkRjPI1nh6UfKkcaQPhdIIemP/QKfttvjEBbnta6UoLwlJdaxN/l4XjOTSu/lPL+8Bj0lfNzGFwzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38350700002)(4326008)(66946007)(6512007)(8676002)(2616005)(66556008)(26005)(66476007)(186003)(86362001)(38100700002)(103116003)(8936002)(6506007)(508600001)(6486002)(83380400001)(5660300002)(36756003)(6666004)(1076003)(316002)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6cbevBVr3h5xs8AS2Q1MEIqaUCa+/vwysjlZ5ibqoXkd+dXHwpFS/orF10O?=
 =?us-ascii?Q?QndkFObjXAiA0JAPUryk3KnNeLtbnb6XeJJpArDIhfNAVOEEMN8Mh5E4FgKD?=
 =?us-ascii?Q?4lbgEofjCTmI6hhJXJz/gYfSwPyXNvaBmeq5SZQ6ddKAQOZBc6aqOKZH9Dwm?=
 =?us-ascii?Q?6VmLJHjLAQjxx/W/K4BpFTX89Z91Z549+9zhMl/A/UQOwjhgjPL7A1spIh1g?=
 =?us-ascii?Q?sVkhheMCfjep6Nd0I9gW8SOz5PH9CxC50JD76G898YO/jDXMHudxlIQBUSP6?=
 =?us-ascii?Q?3fbML/JaUEC0XVDTQUBbpwRi5jyJKe3pO2u6SKhPyACY3/6luAvLJoEMfUWo?=
 =?us-ascii?Q?o0+u8LjwnFmtKD2CuVD6m9w/1xZiJ9yj6Tb+g18XJK33r8mauuA0TaeNLsXP?=
 =?us-ascii?Q?EuLaL2I26Ve7reN3y8IFPOQvBnjiRcw6GpOpRys8VHwQI09Rz/HTZlFsQ7XQ?=
 =?us-ascii?Q?t0w2MjGBj6TQ1rwz4dmlajS37HviJvWM8xjrXhnNl1sY5oxAxloewQV7sA8c?=
 =?us-ascii?Q?b2RP6Dy9g09x2ewI9CSgKQpxxMSZaEN2HL76F2zQ5R3hf5Ggl8PplvCEqDW5?=
 =?us-ascii?Q?2P9wpnLwj5FC9Zp+ulekQr2a7maFA1dUQBSRpmLuaZf31qN7AwxZzy7MpoRf?=
 =?us-ascii?Q?sVeR4wvwuYEKRWj/B1GOJ8rO/kJja+ss6P1iWJWD5/dSOrdMztHrIgk0eF0I?=
 =?us-ascii?Q?feh8fPaNAxbJAxwNys5S3Msq8scxJsOrlG1JgX5BtMv7155hq13uyT0xzbzv?=
 =?us-ascii?Q?M99SWFzN3NgBoP+Gmq0M860cRKEwy5p14T5VvKIXrPNwaXLzJLf5W/jNxUEa?=
 =?us-ascii?Q?y21TGP3P9KmRTfZ61fF//OHbfV8fqwKgiMna/dw7GW0Lasg4t0EV+keLJHKF?=
 =?us-ascii?Q?k1Z8eTUV1uOOv+OPoqtyQ7FW161mJA/h3uEkPP6Edn68grq/1KI8UUkbTwCj?=
 =?us-ascii?Q?iemn4yzyx+RlmhtR0JPyuvOQyXdz6ni2aCsu8vbjbaX/KBcUDR6h/nnEI9Px?=
 =?us-ascii?Q?srVNyS0n/cuAwiTnBHoXy/YJ93d0G5xXe5s9MosI1UddPpQz+RYCzsJc4cUJ?=
 =?us-ascii?Q?di3r5tHD/TfTwxF8P2RX+yi6LA5vQ6t8ypfpCivBgE0J78SUYTclPnm88WFk?=
 =?us-ascii?Q?sqck0QYd7jGXehKAEWOjuvLsPefp4uYZ7rTIPc0eJMbXawycytzx0uvXqVG3?=
 =?us-ascii?Q?iksyWVj/LHOQ5ywVj0CDer7vK22DNIYYo0OUiaXUkzH61qhVdy0t+kRgkWXe?=
 =?us-ascii?Q?qqJztOBA5Z+0kr5j+xAvEfqnMg4p9hnjUW/+gDxrQFK6hXxj/C9AUaSJVic8?=
 =?us-ascii?Q?XBQD6iOgTbq2n4f5E+0oU4GYbtu0oabLwYTuqpUSBh4EctJBbhrjihZCw/UL?=
 =?us-ascii?Q?1AWulhcwcwziOwplYCbrymm5T3eHdojDOIiNASrpidqpvOerBydhuCpSOZ85?=
 =?us-ascii?Q?zodzYyCjNGxBuVz5960NjfkPPqM4Q+pszTf1SVeq+n0u5xGS4WqCW1oaVe54?=
 =?us-ascii?Q?UgzJhpVfXw8kvReAL7kybeWVS43g2UVI7Z7MMN9pyGC7iVe+Mp/RaDAl2Iol?=
 =?us-ascii?Q?CsiZH8gBhEjMqTGiYYEVjkOAEJIBjYrUEqMaayrrbFIqrGin2s9JGrqckw/b?=
 =?us-ascii?Q?s1H74mr1lVXi7DNgXlVdsIzPJHNC5nXXbcOMOR8G5j7+qU3zMKGqhUlVMKJi?=
 =?us-ascii?Q?J7YBmaXRJRF2Dr+uRWhdYH1go9j91+6CrYr3k+rNVoKO23SI/cVSWieLiuJI?=
 =?us-ascii?Q?p/qdWhhLb5qarT+/RJ064i0oWNGOKmM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9ebce8-cc5b-4f75-2772-08da4e74530e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:11:14.5902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGoau7N3IKI3Re2te5rqfdo9MZlQUrgfsJiOzh1TwmA/JBCearEAFlthH3q9IlcLlIgGxkjqkso6MU3jZOqNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_01:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150004
X-Proofpoint-GUID: aNqGSM6TrGcnElp1425NG2BrjeS6tN_n
X-Proofpoint-ORIG-GUID: aNqGSM6TrGcnElp1425NG2BrjeS6tN_n
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
 fs/kernfs/file.c       | 147 ++++++++++++++++++++++++++++-------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879c..706aebcfb8f69 100644
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
@@ -51,6 +51,52 @@ struct kernfs_open_node {
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
+ * The caller needs to make sure that @of->list is not empty.
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
+ * Fetch and return ->attr.open of @kn when caller holds the
+ * kernfs_open_file_mutex.
+ *
+ * Update of ->attr.open happens under kernfs_open_file_mutex. So when
+ * the caller guarantees that this mutex is being held, other updaters can't
+ * change ->attr.open and this means that we can safely deref ->attr.open
+ * outside RCU read-side critical section.
+ *
+ * The caller needs to make sure that kernfs_open_file_mutex is held.
+ */
+static struct kernfs_open_node *
+kernfs_deref_open_node_protected(struct kernfs_node *kn)
+{
+	return rcu_dereference_protected(kn->attr.open,
+				lockdep_is_held(&kernfs_open_file_mutex));
+}
+
 static struct kernfs_open_file *kernfs_of(struct file *file)
 {
 	return ((struct seq_file *)file->private_data)->private;
@@ -156,8 +202,12 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	if (!on)
+		return -EINVAL;
+
+	of->event = atomic_read(&on->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +230,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +252,15 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -519,36 +578,29 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -567,24 +619,25 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
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
@@ -774,17 +827,16 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	 * check under kernfs_open_file_mutex will ensure bailing out if
 	 * ->attr.open became NULL while waiting for the mutex.
 	 */
-	if (!kn->attr.open)
+	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = kernfs_deref_open_node_protected(kn);
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
 
-	on = kn->attr.open;
-
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
@@ -815,7 +867,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
+
+	if (!on)
+		return EPOLLERR;
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -922,13 +977,13 @@ void kernfs_notify(struct kernfs_node *kn)
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
index e2ae15a6225e8..13f54f078a52a 100644
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

