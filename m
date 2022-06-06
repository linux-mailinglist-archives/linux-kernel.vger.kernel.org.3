Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB153F0A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiFFUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiFFUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F913F1E5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:41:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JKhYm027011;
        Mon, 6 Jun 2022 20:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=KPBhCsdqcunFMUR4wQ/KR9WecNlsalNLN40bYtWiujs=;
 b=cPBNB/88tpFAXXcRDRYKz8WyUNpALq5CLBP3F77M/vk8tIW8RybCzqEgc0uRx7U1ZUhI
 ZS+3HJc1IeASagIy4CDM9c2Q9uDN4WVW/pWUO4ZjW7AYRgLmagHf+Izs75lKBHpDegg5
 TN1AImdzsM3z2IUB/5gx6xB9wXjCT0TMt6QZZo0dwCyy71OEXTn+hUIaqt1gNwsJEI3t
 wolZUKf0tNj6ydjsd/XD2oaZ2HWCo1nYLT59arzhB12KvnKrFe1ZlVh9uoThk+xg28HG
 LdFyIBwjBnVvhvwxjr0ZaAUK3ULNRSA1xrp4AeVBBJZxImE5IYauhHcPKkqVP35wiWN6 qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqm37a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFt6X001285;
        Mon, 6 Jun 2022 20:37:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu20qv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcdekasnLg/gwFnMu3WXDX0SYt6N2AEp9dcietVpJtACkE5PvT0HtAXA2PIxxdD3H1szzJJbKZGjpYImMMogvpvnjjHxTWjOyeloTK56+WYeawBncOxnRZDeoxoJ1GkvdEblVsZrXcMqpezY+cEFpsQ+POkYrqPQ/i3sN8eAYGM7o5qTNi76/XjzUyUSt4hgwCyKyeWNjhvfAPFdntFzDVvT+xOzi+lMgFW0OOn1wfk8hOSe359eQyYGZEB/OgtP4ZRvmShsK6VeLNsBEQb2L4BnXEqYs5AV6DnFbnnMPzkiubFDxByjiK1ILj/V7sLzLp5QBd7troMkoeplPWTcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPBhCsdqcunFMUR4wQ/KR9WecNlsalNLN40bYtWiujs=;
 b=gOi0RMNxJ2x0SQ2SHx08udihDsT6fmKipm5UIrb0Y8nbrwR4b2HQE9Y4SOXTPo+8g3iG+Bto4B1hxqQu5q6jzKw4mro7xsqc0lN7fR1GmTpWjCWjyhvIt1qrKxytDkk8yxLZ2TPMZzXd5QjYwqLYYHXqm3nQ8E1Ddvo2v78iAFSSOR19H8vd/tNWwG0a/FCNL5apCasp6pQmc5FBlvYUCllUWTUmYr+Muyy66aynG4h9nhQsQWdu9z3/35jFesn9dvkw1DTjzAZn8EkL/kvyG2cs8o10uint0M7ZHhEyfL5Wlhwb1DOV4H0xrRQD3dnmKkrAKF1hbR/rYUFaXgbQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPBhCsdqcunFMUR4wQ/KR9WecNlsalNLN40bYtWiujs=;
 b=EubWIW0q+gw05ckGX4dapBJSy8c7qybKFXZjM5r/ihzLyUyoNwc+7F3SzX3wb2DCfWxf3rBL0l5Gc186abhNtXQ7i2sv5626eutqaHt7KV2x+Gt+OyYYexVo0EtMLGbuz77wJ6Vz6OQ8Uv+2M4d7CxMD+xX/PxcDrQXytrM8T/w=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:37:38 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:37:38 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 05/21] mm/huge_page: generalize process_huge_page()
Date:   Mon,  6 Jun 2022 20:37:09 +0000
Message-Id: <20220606203725.1313715-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e0a22b6-78fb-43f2-5a1c-08da47fc652c
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2596DB4E5BEDB831D4E52540CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UYS+12ADzu1QhLVveKhBt3Tx6AvX1ZqxwZWwQGz6ZdEmPpREPkXx2JdCCriz6nfgyrN7YSEam9pYcd6WraGfUr0IJJ4ylJV3WkEjCJC8WFq4oPyWo+xH19o45GaPhTY1T4xnxn4CGdZusPZuEF8FVzyPnk8nDEw0Z8b7sLX0BAXDuZ0BqB8iQwZElnvZ6Ok1GDkWevGemCYRCT6+Jty3jOwq3kY16KbCXP1eY23gPlz7Fp6IcTnCFENfyUDy68gvsPDD9YL+8+0aKSDsU+Mm8WsuvgJYzBvDur1OrTAAs8+3uTsrtJUpqNTcs4qI+wJCRaXjqEj7RNu9AZaSn46S5lHFJlEPErl8HPMuKw+xyfybD4nQtN1FUA4RD3dwF9i5Lu86J1lDka4auXoSrWYs9rBtyw7Ku6sqcPAPD6dJyTWbpBidOKvKqGBhyuYiZL+DXAxuM65BdMvmy+cIbraiaDq+Y6OUu3F89zlya4Z9sQZYv6mYYFVPDeXNQ9etuuZesuQqGEkbkhl9oshQw70KkKzXF5vcMLrDyHG7Z5je1x1fXssn/LHDal/TCPYr7c/zSZtnVwJdF0GNZ5Vp7QkIfwqS/YOKGv/6Hf5H6GUZ8KnqzT7BgWDHMvgs96ZJoCpN+wTpFNosCrpLO/6FJDOyAtuz5vH7cSYB1Nvm9c7X2I/QIP6ZdNpMxbSShhdX1TMCJE3wNuWWSVcjEKQ+2y7cBmFifMB+6HklA1PoEXQ9kM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEynmrX3Gfm9ff/LoNbXirNECG+fb2ioDvJH8gAXvob39soiIx0dvV4R8Z0z?=
 =?us-ascii?Q?dtwLJZIHtNKKvq2O44240sppJ4VEkl01XP0BCBzSfHXe4GrhC+8D+6pQEDJA?=
 =?us-ascii?Q?cd3F6u6XXIstvW0+L6JDq7j0tVjaJcKppS3Y7moOmaGm01OJpXRLusneGjwf?=
 =?us-ascii?Q?bzwkJaGluoKGzp9wbRDUh8uZsW7eCJJdX+idWOy/ab4HWRBN6orRAJmwFyFy?=
 =?us-ascii?Q?1P2DICTaRZexTTDhOx6Nm7d8f+VAOWr8qfvlj0YgAW0jVzT5bd4bpptNTdS0?=
 =?us-ascii?Q?8lmgN2UAj3tYgnEbo9RdBvQfiyUf/I4ARD/Mq1Eg2XtlLGyP/vnjv2qATaVP?=
 =?us-ascii?Q?KNShNHr6TDNqlktDCr+CSr+OvQKC+yy8oRSwoAY0mAGEzPiOlzea7ItW5khd?=
 =?us-ascii?Q?1HHjQZSAg+6qkPNMWpwKc+VJH6Dz7Ig8AotiAv7G6T59ISZB3bnYgTWqh6tU?=
 =?us-ascii?Q?4zlQ7Z+B61/OZx0OQDsYSxgIdkskhqjFkangv1efy3Y3P2ro0UTK92Uql3fn?=
 =?us-ascii?Q?cOY5NptBD/4P2DbOPqKVZdX76PjwGcT55D2o5I+f929w0lk4T7xj1Pw3Km3E?=
 =?us-ascii?Q?i+tI57JkZ+bn8yP4Hzea+x6PxQOwiuZbhyzVyzT3wo1qu2D2hb32J69kznAQ?=
 =?us-ascii?Q?TZ/yc6v6+Ep8oym7++xSMz/Fj2tDO5+860odxN9BHPwQSCgRuTlwnKKbHzN+?=
 =?us-ascii?Q?1/uLDp7S+OiLDQG+eQs5Kh+nDW5cte6IoYqRjhayKnF5DtyNPbQ1BVw2cStz?=
 =?us-ascii?Q?TgGwvkUpK/hDBslZTskO8LCL3dPk04XM3j2gM0qyvkdRYMsUc/dfLjujRNH9?=
 =?us-ascii?Q?Z1WfRQyKphUnAdd8GCRwJst+1gErxJh7s6w3TLHsrKfq9t3yH5EXodGqWglE?=
 =?us-ascii?Q?zyReTxgA6qtDSdimkChfWJtvMqZHTGOSv13/iAmWMIwoEKMfUqwQdv6BD9kl?=
 =?us-ascii?Q?VQIky7mhn3ENKvwTEXKELtgR4yBZeoOqHDKeAMvrCzumFHuW3xUTAxkJkz5Z?=
 =?us-ascii?Q?LAROvTcafQEL+sBh0uZJ+aJHdU1uteWMlexY/VuRyCZCm63fJULc7yQ091aa?=
 =?us-ascii?Q?gFcOR837IY2N/OCJKD7qrPMkp9VzKG3R0Iy76u4laoPNquWO24Cf/GhPFD3u?=
 =?us-ascii?Q?CzfpLpGxs0cJL1mbP82HX8Fvy4Ut/o9MWVyAVntAHtrqM0up/8Iudyxxp5wX?=
 =?us-ascii?Q?oF5h/jSBgW2edsyGTyJwLbRs2OgXD43c3SP9fv6nAifGdKTyi2rM0zgWArK7?=
 =?us-ascii?Q?p4mkdvPjN7E017jptZxlnsHvCr2txzgqtNplWfLwAJHt9tJlAJK6saTCTxxw?=
 =?us-ascii?Q?PFG2qkXWJ2LL32C3fRH7GEjsOdQZZtFTgEPCpRLFxzzEA855cqKOc4+gjE6r?=
 =?us-ascii?Q?L5yLAtH6oHTvOWaDVbghBN8Ir05UXB+3pNgklBavdVa/7dRnxk5eszuPY3LG?=
 =?us-ascii?Q?zQ3VPZxARFWDjE/u87BUCWefJXiQ5NDW55r3fFe6Z8zF2955Em5/bsFWLA2x?=
 =?us-ascii?Q?g3YVEKiP8BsCq2+ks/KUg5Yf/FNnOj5clCHBcAQj5jK6BNbHfCyHDjFSudtt?=
 =?us-ascii?Q?tUw8jg6/lYf+Me2xaBkGS6vEU81LNbwYusylDIhwROdEXkxwynMUKyECOK2V?=
 =?us-ascii?Q?zOXThJbLMTNqJwBzQXDwdUfViA76pCod0uuI3GO0Dg4GlfNc/qHbUn3BrMBu?=
 =?us-ascii?Q?Mpuza6mAag9rof5h0yCaPgpXlb5+GtgwdU85bA/PL3vmN/XiOWW/+5OVccuU?=
 =?us-ascii?Q?a6L2gJsYM/RKZ/LQbGJC4CSFeRtXSmw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a22b6-78fb-43f2-5a1c-08da47fc652c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:37:38.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szp2R5zo01h1H6SbE25XM03gpOmgUnwUVrztP234Rz16w0euAa5EXQ7GGkOeShRz5eSwn8zfEska6qbIHF7BFIE0xgcWM7nR46zgVmDNGOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-GUID: 7TaTm2LlHJTx879NupUrgluiinq3JVqj
X-Proofpoint-ORIG-GUID: 7TaTm2LlHJTx879NupUrgluiinq3JVqj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

process_huge_page() processes subpages left-right, narrowing towards
the direction of the faulting subpage to keep spatially close
cachelines hot.

This is done, however, page-at-a-time. Retain the left-right
narrowing logic while using larger chunks for page regions
farther away from the target, and smaller chunks approaching
the target.

Clearing in large chunks allows for uarch specific optimizations.
Do this, however, only for far away subpages because we don't
care about keeping those cachelines hot.

In addition, while narrowing towards the target, access both the
left and right chunks in the forward direction instead of the
reverse -- x86 string instructions perform better that way.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 86 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fbc7bc70dc3d..04c6bb5d75f6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5592,8 +5592,10 @@ struct subpage_arg {
 	struct page *dst;
 	struct page *src;
 	struct vm_area_struct *vma;
+	int page_unit;
 };
 
+#define NWIDTH 4
 /*
  * Process all subpages of the specified huge page with the specified
  * operation.  The target subpage will be processed last to keep its
@@ -5604,37 +5606,75 @@ static inline void process_huge_page(struct subpage_arg *sa,
 	void (*process_subpages)(struct subpage_arg *sa,
 				 unsigned long base_addr, int lidx, int ridx))
 {
-	int i, n, base, l;
+	int n, lbound, rbound;
+	int remaining, unit = sa->page_unit;
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
+	lbound = 0;
+	rbound = pages_per_huge_page - 1;
+	remaining = pages_per_huge_page;
+
 	/* Process target subpage last to keep its cache lines hot */
 	n = (addr_hint - addr) / PAGE_SIZE;
 
-	if (2 * n <= pages_per_huge_page) {
-		/* If target subpage in first half of huge page */
-		base = 0;
-		l = n;
-		/* Process subpages at the end of huge page */
-		process_subpages(sa, addr, 2*n, pages_per_huge_page-1);
-	} else {
-		/* If target subpage in second half of huge page */
-		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
-		l = pages_per_huge_page - n;
-
-		/* Process subpages at the begin of huge page */
-		process_subpages(sa, addr, 0, base);
-	}
 	/*
-	 * Process remaining subpages in left-right-left-right pattern
-	 * towards the target subpage
+	 * Process subpages in a left-right-left-right pattern towards the
+	 * faulting subpage to keep spatially close cachelines hot.
+	 *
+	 * If the architecture advertises multi-page clearing/copying, use
+	 * the largest extent available, process it in the forward direction,
+	 * while iteratively narrowing as the target gets closer.
+	 *
+	 * Clearing in large chunks allows for uarch specific optimizations.
+	 * Do this, however, only for far away subpages because we don't
+	 * care about keeping those cachelines hot.
+	 *
+	 * In addition, while narrowing towards the target, access both the
+	 * left and right chunks in the forward direction instead of the
+	 * reverse -- x86 string instructions perform better that way.
 	 */
-	for (i = 0; i < l; i++) {
-		int left_idx = base + i;
-		int right_idx = base + 2 * l - 1 - i;
+	while (remaining) {
+		int left_gap = n - lbound;
+		int right_gap = rbound - n;
+		int neighbourhood;
 
-		process_subpages(sa, addr, left_idx, left_idx);
-		process_subpages(sa, addr, right_idx, right_idx);
+		/*
+		 * We want to defer processing of the immediate neighbourhood of
+		 * the target until rest of the huge-page is exhausted.
+		 */
+		neighbourhood = NWIDTH * (left_gap > NWIDTH ||
+					  right_gap > NWIDTH);
+
+		/*
+		 * Width of the remaining region on the left: n - lbound + 1.
+		 * In addition hold an additional neighbourhood region, which is
+		 * non-zero until the left, right gaps have been cleared.
+		 *
+		 * [ddddd....xxxxN
+		 *       ^   |   `---- target
+		 *       `---|-- lbound
+		 *           `------------ left neighbourhood edge
+		 */
+		if ((n - lbound + 1) >= unit + neighbourhood) {
+			process_subpages(sa, addr, lbound, lbound + unit - 1);
+			lbound += unit;
+			remaining -= unit;
+		}
+
+		/*
+		 * Similarly the right:
+		 *               Nxxxx....ddd]
+		 */
+		if ((rbound - n) >= (unit + neighbourhood)) {
+			process_subpages(sa, addr, rbound - unit + 1, rbound);
+			rbound -= unit;
+			remaining -= unit;
+		}
+
+		unit = min(sa->page_unit, unit >> 1);
+		if (unit == 0)
+			unit = 1;
 	}
 }
 
@@ -5687,6 +5727,7 @@ void clear_huge_page(struct page *page,
 		.dst = page,
 		.src = NULL,
 		.vma = NULL,
+		.page_unit = clear_page_unit,
 	};
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
@@ -5741,6 +5782,7 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		.dst = dst,
 		.src = src,
 		.vma = vma,
+		.page_unit = 1,
 	};
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-- 
2.31.1

