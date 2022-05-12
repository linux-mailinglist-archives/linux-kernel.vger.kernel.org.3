Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE9525744
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347149AbiELVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357198AbiELVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B045056
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CJKpeR023549;
        Thu, 12 May 2022 21:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=a0EFwcujhGCU04jZhJ9tZTh4bv5MhcLOv3qTX1+CJJs=;
 b=tUzkge7JHCcCgIR/rbuVoA9lYnThiPSp6AcihSEVbKQyDL3Ud7QJ+7qTj8FgVIBcwcye
 nI3WHEA89TRIoWEklCBhLP6LQUfE57dECaPgoEAE/VsZrWFHr0y7BP8Wwow11UflF9J4
 XqEZxRbCheovArZRBQM8GeKcCRflf09YY+z9bFdkihTh8CBXntQl3xvgEcyZCa9w6Amj
 UGdMn5V2IDdI9agsdXPSRVDwpVKA5ixhHXEW28IyTs0FhoqmUha7wraTcRpfI8lk837J
 2mtJ+MtPKWGGHHsO47kSKQqRcnemHYc91zZ/JqZQSAa6eIodvqgqVafKmRju/8QeWNtu mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsx4a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgIkK004728;
        Thu, 12 May 2022 21:47:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98s9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhKEMI5R7B+aHiKD4eo+CMarLQDdqV/99dqk3OtzKQ8++6QVHJRZ4DgtKBFBRwLHYrkW+c9cWbV3k13vssTT+7LIspqJw9nkdPWLxEconsCSK4sNLbQJED+J842GDatmq3alwJoXdVj03rBgLeg9ghtpsbrZWKV1odGhdpgYQAemfUwv4d2iYzlkchg53Lq37bp2vMt6MfBeWpY54c8xUJuglsx+I8ROyKCJV2fhXfyKq8VeFoM8A5MbGSj0yx/wcDNYNyDcQ6xbbQ69K44KfSE7HK1RrQNMBiPsiw/YEOrfZzPP28dybifCLaLx1dt62iKni4roCV5fens2JTFQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0EFwcujhGCU04jZhJ9tZTh4bv5MhcLOv3qTX1+CJJs=;
 b=NBF7YeRdCC+gMSOGsMKLL9GNkKsawqgwuybM8Pu3FxqyMH7tCieitp/31pRPxYGBeQ/pGr8SVPA3PmvHJi/aL+o+3d5cvUPfSUUWqEESCMBqpWGwIZ6cs9phg8v1s28uT4TtNlXau8EsND8qnEcI+/Uc9hXO5UOaAe4BCHBiqw4i1LN9+CjpvNeq5yVLKC+wTS8eD7E87v4EEAWNPJO3Y1A2RKnuyxBMvURUcjgF5uOdBHgmW7YWy2/3S6SKt+aJbPe8v7hgQ2ePnLcPRaqlxvW8jPmh727bDDB4A4BWvUIPpDkvWz8dCoZiCIEJkTlSve9t8lnDc/35pjQLaE9Ogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0EFwcujhGCU04jZhJ9tZTh4bv5MhcLOv3qTX1+CJJs=;
 b=p5suluTm4KOKesENBVKAXExVX0r4zt3pRnmei+aCaPezSDA4x0zYARV9naC+4nLW66Ea+e+TPl5pjMckgSF4VzmMx6fY4igl4YS1pKnRFmZq4X+HmpZRreVUDP2lFH48c7Ljheot8FkH6oNCJtAxVha2H4H5tJve0BdewGCv1YM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:12 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:12 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 1/8] fork: Make IO worker options flag based
Date:   Thu, 12 May 2022 16:46:57 -0500
Message-Id: <20220512214704.104472-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
References: <20220512214704.104472-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:4:ae::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cbd3e59-6761-4003-9f14-08da3460f8d2
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB33111C37B386D9BDC711C54EF1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ0HvO6X8rUH9gCVjz/ogAdjd9XgSvS4bGdPRDWsoQFD2VP6IBANlhjd4iBWd+WDunhPVoC1bF1qMpWmFds2/gZVuxD+d8LRfFlXl4pV3jjrZWO9p4jEKqYXzt8X9eKH+dkoXnnnVJzrFgMkfenbN/b4JR2RU1SMqRyYI8p2SPq8H07s0JffPAgmRqHpxgqr58L9Z3fnSma9Jg80u1+2X1AtQFWlt7mS+hQZ9dTZDL6mMDD3OKlyIKqglMvH/4rJoFyfTuEzGnKUXox6qIgDpfAxihjIONPhStbvLv9DG5sYDlrNVolk4OY11TSvbJdTqkSUFOfCDGp6HmiW0ZXIMmDftLzR7ytiqBrymyICoOCuQU8KJrScm0jA14kYh/0QEDxXdrqA4jKZJ8lPFPHp43iyE1t+tN6kt+hcz0XPk4++fYE8biLWZqaEsFBEpN2D33dVbSJTm9R6vr1FOW+CU3Ykp+4KXc7QEJFG4XMYYPRpEbr3U8IRytB7HgwBhXsFthW3L7IyUruZn8THmVEsA9zDSO+O5h2lALw5+k25VHT2UWyjlUm18fltLXoliq8BXuBbaPfSNYnJPCNVOdLfoWOMm1A5ALmMcC2yv6JjGNr2Ipz8YuMyf3alMavs/XYUWaIViVVdesk898OIBCyPkTvIuCrF78IZCUQazzwia3BpYSVJSyWxb37Oo1mZzCe7KpWouuIpg+AEsTWmita4rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(7416002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(54906003)(38100700002)(83380400001)(8936002)(2616005)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnjESe9JvHanIITKI8ufoXJIkTlqLz3e0fKDGpjWDnU9EzvuSp02v5A5geYw?=
 =?us-ascii?Q?fnJKzKnKgcR5ozZ1FnqR68cJtMgM0VJQ0anzPjkPDJPZyf+s6vqwrgmgWVBf?=
 =?us-ascii?Q?xGgA2Ner8WHJEOMfsJUkJhOGFWYZxJFPIDsTL7ekV90iIGieD1cl9dzfoLUZ?=
 =?us-ascii?Q?AqoJ/1l3Mo6eecodxFhcvPpx4+QCm+UcKt6SNh/3eHk6rvCFJTaMZNpzZf08?=
 =?us-ascii?Q?1V2b2hz3xqsoOKDDpzb87TEZ2gRz6UeX1Sv+5lGVvUSrHKFsxkJ1f9Lvupmw?=
 =?us-ascii?Q?5SbWTGq+U9XZgXxxajxWEoXMEv6zoCazO2k+nJzAcUPbkMabDsE0g7U5UQpS?=
 =?us-ascii?Q?EjH2n+5uvw4fw1rNm7rzCEb4mJ1DyxDNZuFZYX0WbaYhkMoDxdcye27nIo6y?=
 =?us-ascii?Q?nV8cPE38837KXIWWUhADezPUaeM1RH4LIF9pWriSoPwwzciY5yAvAYIayfAr?=
 =?us-ascii?Q?0jaHYKt1AYBnmIx6EjGJ5O1FZLcFz4NvsGrBnK95yzlty5jdgVGS9kZTi4jG?=
 =?us-ascii?Q?4z3layEYujtc+UH8NcaITIxszrM8+RduClVHrOkrsoKOnJ0bccqUIorWmeB5?=
 =?us-ascii?Q?+NumPEyYZ1n3reL5rsn+BeshjnkVHWzIbG1mSbH1i67oXNiuewfgOVWu06EP?=
 =?us-ascii?Q?ntHpOEnkKVA+SbChEIieRLOsuY3/Bh8XmuPaaS1ZuBZrIDv42cf8Tettg7DJ?=
 =?us-ascii?Q?OwKnfrTXgrvcDU77jGwUurGiwIeJcqi7QHgqKAd42KJDgdy8q97Vmw1JX2e3?=
 =?us-ascii?Q?rMnZ+1eG/UVbzsLqxm7pWmTc8G3tRNu2Phs8utouhSRnIDs2c2zOFCMsMbnq?=
 =?us-ascii?Q?siAO5qSVMU5gx7N+qp78LeWFt9q1fw7aQNXg5anP2dVDvmrTcyP+EiMsatBh?=
 =?us-ascii?Q?/MZzdS5Cl7Q9lst8pAZt037Ex6p6gYwPfeo0NVka+P1nsVjExnfqs1MsO/1p?=
 =?us-ascii?Q?OZGpM3+YAsvMUCjWCwuX0ManzgIfvo4D5hfENgt+a3hAYPMha8JTxxXJi8+v?=
 =?us-ascii?Q?d6MZM7hp8wYF/z0kPvCKpaodaer3/ZEKuBxt9pY3JKb68dyPdf5piPQ/WqVE?=
 =?us-ascii?Q?ES7TclJdofeIX/4xwdw13fWjs+pyCkvTWg7ymLRmwsdyEdORsSWjziLK8T/Z?=
 =?us-ascii?Q?V1LwG1CLhQIcliR6ccCHbZXLTMbUm+y75h0HwjM1yetQNvD7AKvdtthRHTbu?=
 =?us-ascii?Q?fh1HCqG8reP8N57xuLC5dd/wP8giN5asbgn4kmC1vNNMNSPZG2ENuXrk1ZQ2?=
 =?us-ascii?Q?mfH8OwcuMoOBU9eBtqVbWhOaa12B2zFvJARVbLNLzP8EXmlkhHpkiAErAAj6?=
 =?us-ascii?Q?DmzfMNcoarqnKKU1sacSJj42mfCxcBmAhDl0NsO6OapsB84CT9gRvoDSLYWS?=
 =?us-ascii?Q?NwxZG47qg9dH6kXFZZxdm8oO4CF+jJb151aAzTUsBvkDNpfHQiFsMSyKCTLd?=
 =?us-ascii?Q?L0ueMgFrFgPL0X1JTEKU/1f5QUKEEKzyyNZ5wcTeUDd/ciRrCrQSed6d1noC?=
 =?us-ascii?Q?ctBoDXupGlZU9qjWZhb9r64LHGWUaZeFAJQGzoYSk1XWDdPsP57Z4mNHqIPs?=
 =?us-ascii?Q?O6GrbM8Tds/Nl7ZuUQ/LR++XhHt8z6zlPSMQu0weR6tgyUil6UYEMSJgsfAN?=
 =?us-ascii?Q?+4t5nIbRECsNYmxV4pYQHLo35So0GnaobeLZj8gZhwBDeZ8hYJCfvO7Lz2E9?=
 =?us-ascii?Q?efzewCy730MMwzUt2Lu1DjAwWLoYjMzbQ2rOb2drO3GDeHJoTNS8SerVRwuX?=
 =?us-ascii?Q?hVYVObGdtxCZl2N8k9dzhkG9EiL2uXY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd3e59-6761-4003-9f14-08da3460f8d2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:12.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9ph7daGRX8c0hX7eKbx6p/RyIGfjpGeVJ1C5lrVAXlnd7qwzJhmiVir7yLu7CO4zEmbspO9XUefJbjatf8VnnVCkMpLALWRiHOaHAD8NYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=694
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: qy8JzMb1rkoe2dCUtBKNFVHWzyiHjnZ6
X-Proofpoint-ORIG-GUID: qy8JzMb1rkoe2dCUtBKNFVHWzyiHjnZ6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a couple new options to kernel_clone_args for the vhost
layer which is going to work like PF_IO_WORKER but will differ enough that
we will need to add several fields to kernel_clone_args. This patch moves
us to a flags based approach for these types of users.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 505aaf9fe477..b0a9d6c75bcc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define USER_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	int kthread;
 	int idle;
 	int (*fn)(void *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 35aa89ed6cf4..f4f2c88d9a2a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2071,7 +2071,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->io_thread) {
+	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2594,7 +2594,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
-		.io_thread	= 1,
+		.worker_flags	= USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

