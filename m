Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54153EF8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiFFUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiFFUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:24:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82416CABA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:24:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Jis0W010073;
        Mon, 6 Jun 2022 20:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=FP0i4KiK6HfUfgeKgIQGku+//s7C/GJB65ZftbQP0Qs=;
 b=oJZJCmtpHa3GWfNtEhCUZC7LndreB3SVqq6DS6vEcWUwx14HAwnjg8fxxu26wcMD9llp
 W7Z/GU8BXtxJ748HwFP48VNBZ9O1P6FA8AlSUCFUxjBnvUNkrRCG8YE3PXebiS9N4DkL
 h1+ME7qRa2lH1JFrhD1DrVUjHBUhGpRkarIb++5JuN2aWAIzQVG2/s/3Qxy2pbnS8uy9
 9PAEhSB5xkuV491T4LtJ/DUtzoxF02jhorGq1gli7P3InhUvi6DoFQi+MnJDbP3Hb2v+
 QlDwB82JyDPnWklsZUJbPuM/LnWCb+yWU5KC9aQ9MVJ3lceG1IwA/nqB7SHnEU5CsFjs TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqm281-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGTaf035671;
        Mon, 6 Jun 2022 20:21:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1v4tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAHhNH/grKRzShckzIBzsnFMw76lSaM22b8/ite5vlpylBDSRfgTvfIiALflE2V2A4mIGkBZU2Sq+62A2mzKoTzn/8Yanaq9HunteDsZCt8cwmq11bHsdiaxc/U1spwcmLMDy6KtXalxBTHaUwC20xAIyd2QotlKHS5axc64w7GNZS3xdxn1oszKahpUQVouAXh/rCj2XgEADrJIcU1xLo3NwuQt9/gyMSU3GnxORRlcz6SVlLZwGmXaGXBK8B6BteO3J9nRIyv+Tkbk4YgJLzMdihpQZPsi0TDl/3nI0TxNLD5JuanomDTtozHYlUlnhO0jlnt4adItKDOv5KIBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP0i4KiK6HfUfgeKgIQGku+//s7C/GJB65ZftbQP0Qs=;
 b=gOj4JDfeGd8ljuNcEiGR1L0cU9Jx2Ipnf9K5bYUm6r+X4dy1WAHTq+Cs3GzSS/yf11gDKslPp/F0RJ5DE7eJ2XU5vcW23nT0m00t6dc+DNrOKVikVTBWgBBVWiX2CDrWBYyfxW31KanzKMZVAPSOen3TNX7FAjLCO931kLs4l+YATLQrYkv/6lcEfsEaa0VVhmoYndJAfmbaXNK140iwjRUvg9D6+PnAaEy/ud8R0wKjiXyiWNrgTuV3hX/N6Oew8hTkdEuR/1IfrkT+1kTkEKg/D2rPG7FfNMLSHa+Jb+/VdejEy0KaAj6dbA5w5LaRyh+g4cQQlNmn7KT9Ru3nZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP0i4KiK6HfUfgeKgIQGku+//s7C/GJB65ZftbQP0Qs=;
 b=WSSZ6hoJJACVvyPzuT+pe+gFMhaIJk0Yp+l8NJjZFEQBL9tOAaXaJmv/G0So0P/5dfdGtLCSdCSZXP+IkcOQR86NaNoTb4UJp4Sge2qGXGFPJ9m8rSVyfoZlVEE2r6bU1RC8cu/4oRVEc+iVRw/3ko9evUNIzoi1NOOxhegjMts=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Mon, 6 Jun 2022 20:21:36 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:21:36 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 01/21] mm, huge-page: reorder arguments to process_huge_page()
Date:   Mon,  6 Jun 2022 20:20:49 +0000
Message-Id: <20220606202109.1306034-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa56c10-06d5-488b-e706-08da47fa27b2
X-MS-TrafficTypeDiagnostic: CY5PR10MB6046:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB6046C9C1F1505702FE7437E2CEA29@CY5PR10MB6046.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usnlB/cSgVyiGz0kmuERZCrrsl1lH3neIz+pVZQsxx/4OmTDkqZkNBI3i1ClRkNPjIXLENswEnj4/5+DBJlwSyw56edrqXpr36XDtVMhkGfQrHeNlLaNBwhlrvC8jLkHbDNz+f8XhM9XXDAtfeqUR7ZcBJqjx8kCl+8VvOYrRTvRiuGOKyZP2NSzpaOd4rDgXDeUVAuTmpstFRxN106iNFP1W/9wUXyibjDR1Zhe0EcSZas5gmliVwFpTmbtBqpTN0oa12A8kdZUb519yxNs6Yir6+XmFerk04trjOQfVNs1to7+71+L8m0DarwsR0xkjj88sc4YigsspQmkzzrTryo2sXpktAlSGoDRA2UihUbIHx7Xvex7b4gsM4sajZbKnibHL3S2XbpVD+lv6ja/jlyzZa7Ib+i+8sWXDi5yN85YHRjjdJWUaYuuNLHaIrPGjgI3N2XlDpz3knzy9KR9u0N+H21Z6wTyrwpWFD8QpZgzgtIbP87DVYvaJY5TCWF1cr/tWfNOSlUj+pqGggORUFHD+HiQrmSWBriooswwm3xf0SIR2R8R1W2Hy/mlFUr+7e65HeSF/U381AI8d9t5NE8ZEg4jJAb9uRzN0w7ntJ/SqZ2fKNCgWV2NswefyU3idN2tWFFIYJ+QjTf/ljKoM7uRi+Md3E4edsXiTbdqhhg6J0e0YJx1+8UhlWTIdCvzYm4H8GeNtj8de5hMb3ywckYQkfvSvhIbmhPUq8e+ZsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(36756003)(103116003)(8936002)(38350700002)(38100700002)(508600001)(6486002)(6666004)(8676002)(4326008)(5660300002)(66946007)(66556008)(66476007)(7416002)(2906002)(316002)(26005)(6512007)(186003)(52116002)(2616005)(107886003)(1076003)(6506007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2Xp7hCRiz46iEXmi2hr1PsoM6r6POf82STVnA+/K2S0psladGvhYoGZgH/x?=
 =?us-ascii?Q?8ekjld0QEQjXnx4FWP61OgujG+QdffuFSve/L1bwFQvkfr+g6fckwA2QT9N2?=
 =?us-ascii?Q?l65EDLSw4kVI1VBOcKB8WAo3QkC4C9F5I08Io0Gde+Yq4TsiU9sXqDZlDUcH?=
 =?us-ascii?Q?LG5ISavgZi75+5uT0+IPokjo3MbUDFaBXeOOd268KSQYmhwjjiwoRBXp7Mbi?=
 =?us-ascii?Q?nD6OvvXhmlO010z0UygsXTDH8bm4hquLY4TeKkzqBIyGMdQKkJCB9juRRx3x?=
 =?us-ascii?Q?2zPfS+Q/jqhbMdTbjtBpHejmyOwK1tAavjTVheEs9cN9qlDFHMKFLft7yTdD?=
 =?us-ascii?Q?U4pBEt0KjusMdAn0eP9n2c3IpNvoUl1dVHtcuysdqWgVDlIGwr8/4Uf/Wr4R?=
 =?us-ascii?Q?WHgJuusIdqgEGMdFQCqJG1p4qi328KSK7nPmIRrIytbny81eYfv5o+dH8rnK?=
 =?us-ascii?Q?XPBc85bH+Dn+RecVnRaa8byTLwnZ/1TLZLfU6z7GF6AVRjjYOtA9VlVSJg8Z?=
 =?us-ascii?Q?6JcjY7mRLgfXHDaYHnRYXAvyMQiTyrrfV3klgeTCPY+wd5g7kX37RtuOcZ0H?=
 =?us-ascii?Q?2rmVf7Oz1bTLZ/38W30zb1JgTcaGltS010Fnt7JE6GSJvIi+yA5lFXys8ydE?=
 =?us-ascii?Q?6AyMHqpBe+3A8HZfA9eba1wQzNXjwXA40HNPSfjda9TNjmpTCWG1C9PQfSSD?=
 =?us-ascii?Q?ILMX4W6zHcQ/xMVTTc7EG6ZKLSfLie6LU4tPn2v7p72y/n07qAvULfb6sc9j?=
 =?us-ascii?Q?DHvKEjd5xXo1eZrn6wbS9Sf+xSQQRs8PF6XfXCcx+enf0tPeMuzpPj6EIzh0?=
 =?us-ascii?Q?dLDxhTZ1P2Kxi34ZtlBfjry1VknxQQM7viGs4niUfsbjliFf4ZazzuhNpBVN?=
 =?us-ascii?Q?+F4p7N8BpvDOmABI8puCSbZ2Ta/rvDiF7S3RoLXM/xqLftTt4LoWAN/sMJJO?=
 =?us-ascii?Q?HqM0H+TBmTjxzAHqaQAfBMWswziV4tQScMq+MDuZj1zHo6k9oDokdf19oodJ?=
 =?us-ascii?Q?lcF65EoHpY4iy130k+CCKafn2ehOfpRToOrLOJYAdoloLs+MC04PYFx8Kw3h?=
 =?us-ascii?Q?9frvcIns8TTGvynrPD43Ph6NgwTFbvnYVPiVk9iUhMUGVMJZ6dM80KI23lKp?=
 =?us-ascii?Q?ozohd7/1fqqA5ev+23JGf5YDbSNNgsqjpnDAmvJI2NU/JTD+D8jswNOSaxKx?=
 =?us-ascii?Q?+vp37CxB16e/tpnjYQprGR6u3tETPO337V9C+i0tWmgIZTR9+jVViVCi1UYa?=
 =?us-ascii?Q?frynHlvBmP1wtOVCAw+RZowVcGbTWMuEUnmD/jtqv4T+Mb6qTe7S0fSzvF28?=
 =?us-ascii?Q?iKiAqRqu4Hzg3sBr4MjxsUUFJnAhuiElsy9kiPL/y6/G9oGi67wB/ceXI4K+?=
 =?us-ascii?Q?nuu0eujhTXlZ1AtKr9fdVKLpJXQS/E5WjTeC6KqP+SYu86YIgT7M98FvKfu9?=
 =?us-ascii?Q?urXOQQ4CYduFK2WEra3siZGPnavAnV4GozQqVKDbUrx+k4UvkyKQ7rVPUJkX?=
 =?us-ascii?Q?9hpjhDlLDiGpiX603Mw2qYYL2cfMNBs2+xU1O1QANxJXj/gk49Oxq6OJ1XGx?=
 =?us-ascii?Q?H1cJV4v9iDIPryERKI8oRt/2s/0GbMlMUhn85b27MeUV5+WPtkVT6aWGxAPp?=
 =?us-ascii?Q?KpgAqu2/UZobds12eXtSYLKKG7L8VtPyCAwoitgcvK5Ld7jtoED36JYrMWOt?=
 =?us-ascii?Q?yd0V8aXTlijNi/KgNntzxMyzkrkrm+/TkU1b3kX9j/3rhHGPPHbRQdYABzjx?=
 =?us-ascii?Q?1HL3SvmK8WYzlxnIkhRvQ3/VBPy29rM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa56c10-06d5-488b-e706-08da47fa27b2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:21:36.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EF+LfLXrk1AFY+NzYpyOU0mNkC5ZdSPq7qqerjhcZl4OR/j2Giq7uX1NorFY7//OVl03YSPpQNikX/Vxo3H+QCPAeKMjg0eLHNFIed169w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: xmSxS7VtaBXprgCiMcIQOlFXOWWwyHAa
X-Proofpoint-ORIG-GUID: xmSxS7VtaBXprgCiMcIQOlFXOWWwyHAa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mechanical change to process_huge_page() to pass subpage clear/copy
args via struct subpage_arg * instead of passing an opaque pointer
around.

No change in generated code.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21dadf03f089..c33aacdaaf11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5562,15 +5562,22 @@ EXPORT_SYMBOL(__might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+
+struct subpage_arg {
+	struct page *dst;
+	struct page *src;
+	struct vm_area_struct *vma;
+};
+
 /*
  * Process all subpages of the specified huge page with the specified
  * operation.  The target subpage will be processed last to keep its
  * cache lines hot.
  */
-static inline void process_huge_page(
+static inline void process_huge_page(struct subpage_arg *sa,
 	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	void (*process_subpage)(unsigned long addr, int idx, void *arg),
-	void *arg)
+	void (*process_subpage)(struct subpage_arg *sa,
+				unsigned long addr, int idx))
 {
 	int i, n, base, l;
 	unsigned long addr = addr_hint &
@@ -5586,7 +5593,7 @@ static inline void process_huge_page(
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
+			process_subpage(sa, addr + i * PAGE_SIZE, i);
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5595,7 +5602,7 @@ static inline void process_huge_page(
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
+			process_subpage(sa, addr + i * PAGE_SIZE, i);
 		}
 	}
 	/*
@@ -5607,9 +5614,9 @@ static inline void process_huge_page(
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		process_subpage(sa, addr + left_idx * PAGE_SIZE, left_idx);
 		cond_resched();
-		process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		process_subpage(sa, addr + right_idx * PAGE_SIZE, right_idx);
 	}
 }
 
@@ -5628,9 +5635,9 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-static void clear_subpage(unsigned long addr, int idx, void *arg)
+static void clear_subpage(struct subpage_arg *sa, unsigned long addr, int idx)
 {
-	struct page *page = arg;
+	struct page *page = sa->dst;
 
 	clear_user_highpage(page + idx, addr);
 }
@@ -5640,13 +5647,18 @@ void clear_huge_page(struct page *page,
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+	struct subpage_arg sa = {
+		.dst = page,
+		.src = NULL,
+		.vma = NULL,
+	};
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
 
-	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
+	process_huge_page(&sa, addr_hint, pages_per_huge_page, clear_subpage);
 }
 
 static void copy_user_gigantic_page(struct page *dst, struct page *src,
@@ -5668,16 +5680,9 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 	}
 }
 
-struct copy_subpage_arg {
-	struct page *dst;
-	struct page *src;
-	struct vm_area_struct *vma;
-};
-
-static void copy_subpage(unsigned long addr, int idx, void *arg)
+static void copy_subpage(struct subpage_arg *copy_arg,
+			 unsigned long addr, int idx)
 {
-	struct copy_subpage_arg *copy_arg = arg;
-
 	copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
 			   addr, copy_arg->vma);
 }
@@ -5688,7 +5693,7 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-	struct copy_subpage_arg arg = {
+	struct subpage_arg sa = {
 		.dst = dst,
 		.src = src,
 		.vma = vma,
@@ -5700,7 +5705,7 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		return;
 	}
 
-	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
+	process_huge_page(&sa, addr_hint, pages_per_huge_page, copy_subpage);
 }
 
 long copy_huge_page_from_user(struct page *dst_page,
-- 
2.31.1

