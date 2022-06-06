Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92F853F074
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiFFUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiFFUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:45:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD944C5E47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:40:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Ivt8D017195;
        Mon, 6 Jun 2022 20:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=V4OQngUJPfD/jfIBUdHLpS1gprSeJlR6H2KU3mtWXFc=;
 b=t70D2vlaOiAXE2XYjLpUxt7PBHv3/BosecBuYFnQhpF5dv0gnq5YMjxWB9hnDmPnwUd5
 7zzgJNXIcm3xFpnmYUVl1P12g8aq4Y0e3lapmMK22WeaJtgR3BWUriHyqKY4mM0+a+B0
 lfrTC0xlmi4k6XKDm7++/bf5GuxS6MPQuz6MvLORRAkb+xzznZDWXU8eJ48SJP3gg5t2
 9d4qohtjAeOd3rUiGqr/FXSg4f7K4fG9XVTNrjFeboTVm9N7pjAfX+Wa72ujshgWyTDZ
 Hp5jUtHZkoEFhsnrsvL9mW4L4p55sHQpzVBN17Scswwu8ZEJ/Qo0Q/OuOPpWeAoLZW/j OA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtfrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGV1h035820;
        Mon, 6 Jun 2022 20:38:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1vep0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk0Ovu7PTODKSXg3TicoN0t3hFXeS7fd6L+QOhGsstLtrUFxIZvViJ2J9+xRecgQIeN0DS4PXBSKiTMWDwM+YLls6+HukeXKGTv7VxKY2xyvHA18vx7dP+dlkr9wrm1i2qXCG2gaw5fzw169b0cBadNm1xtCpEPWpNXsNI+1Ug40O7HoDMLIn/RY9SVChLh3c5vceqE2+ASkuwREGzoVy6O8okdfdGCwp1okyr8poKZGMGdQkVmf/sEaiwR7+fgiXMeb6yqGkcjedPcXyse3AhTowi9LCcIJ7kGWS2sHBPtnpIBMHHig5vmFQoXJG7wqXyy16aqnEth4JAR2+4BV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4OQngUJPfD/jfIBUdHLpS1gprSeJlR6H2KU3mtWXFc=;
 b=Ac55vMHkV8VeO0dOtdfFsPXxOOpV5ne2gADNfMLa2GE5VtPXfP1m1RXTMGkViLGCvRvmUmvpFInj/CuAnueWSjOSWV7Wg5yGvc0B8FxwVudkqixHTrxip4xJvYTyqYy9v/1hlm854Svw++lLu6eZYDrOgaZmNc8H3+WEG0/pF3O3E+FvptaTDsOeNgu8O9+9Nppvhwa/NPXJSTiFUSB7Ly4VNSCN/dBgqFxZONjtizORxUmId1Z2IpnXyubUlNGbiAgEyAlcMEO6NnE+GU6Bym86z8fMuF4AiqAD2mpOoYDdixn8KQ9Yxytir9IRIig41o85STkcAJe7B9gy/hYJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4OQngUJPfD/jfIBUdHLpS1gprSeJlR6H2KU3mtWXFc=;
 b=k3jDP/I+YiEGjcjBkMvzn5I6xpGfUHIkbnGhCzZOsO8u/yNxSCtv0im0zK8QzpcofCiFe/4YHW9XHBuSa4FfOvRkl7gI/+gA+fS0hUd9rKcJJDI/ozPP+GKVn3e5lReZEPNG14LV2XGfb0R69pOUFbC46N/oxLt4qtJX2bFkpLM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:05 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:05 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 10/21] x86/asm: add clear_pages_clzero()
Date:   Mon,  6 Jun 2022 20:37:14 +0000
Message-Id: <20220606203725.1313715-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be1ccfdc-dd40-45d8-af12-08da47fc752c
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB25962BDFF619F1445493FC26CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O89qAp7iVFwQtpgejyUMmrXbbiE4zkSCUSWwJX3S4kdXqyS2ctwdn+SGbQkDPH9Vc/5L2kb5w2A2TvF5qQXjPs+lyVrzMn1OLvG3N7N6TZnRE0g5nK9mRXBqrwQlGYk0xdhKQVDUPf3eGFlfNDnqeGF0IyTx+OprPvtiyl8RKxMj/GA5NyH4iZmO0MY4M23SXngI3bOOysbtOEajtew2xVL+HpKM+uiI9c1/TNDXZWGg23rR4mqr8e3g45lGW7uIGaeRmY8O/+AaPH44ZNwXYlxp0YJn2GI7P2CKZpABIkiT035fSJpAqDL3cJ7LxwrwOmWjI6nd8/FouEyobDz4vgUyE4IJFNM/1nsL/7jayUtjAiYOTNmJkRYpjRxd/eXPwBn43+bCc3J0U/m9eskue4x9SlkLOSMN/0f5gAkTLgNa8FmyGYLiRt333XyX/v+iAcFBru+lfeYtJ0kxVhy+8t2xsgUpo3g3qxUD8dwoZ2IMgpRoiHPqy9ZA0JBnqa4TebLQjoByrz3mVTkkB7dfLMMLN5aG1nim4xBJ5j/nYtrrgKTABtI1GHVjjlLSUvM/fNePCIJ7XmfJOmZvaLH/G6d325wdFJ0YBv7s/7arP+0f440nU0ni5C4aLMBMDEKlwVm+lRr6esEhdOtR/EUjjUPbwi224v8wgF91THusgTpjm1XkTmqDZVsFw/FQ5Qi5J716waWbIOAR7XFhfxV3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVBAT0yY6X9AH+HLUCnHahEdIsaxDmR/AGINUVDVBENUyY4fx+q91HOZCT72?=
 =?us-ascii?Q?J0l4ZkHVIjd8Kh9QUCtc/1WvNXYg7NLYc0pHCNKx+/icSA7Oemku4WGhA5DP?=
 =?us-ascii?Q?0CK11dez8BrVzGUawyZHEE8plyIkuwZpAu2Le9zMo7UWhQzMMtlZRZeUc9dt?=
 =?us-ascii?Q?svIApn1IdLhCNxgdZGqyy1U+CCFDl5pAi7wubohgCzSwNonFGtyaQHichNPo?=
 =?us-ascii?Q?ErNh6lTbE3jnJZgDE8vAKAqz6vteDtV/qrlRoNFo6y2nIGW1aGlTya/ah8WB?=
 =?us-ascii?Q?n1bvmEiWc200L/kkYIjFmvmIt/peLAVlGrLAyQEuvxxXf5mlDWTybemSP+cp?=
 =?us-ascii?Q?p3K8GEnyTFCaDd1rdJ6u5vrQuiT3mKPR2t84XQnqE7UWrUCPGVDXUw5JT3Kw?=
 =?us-ascii?Q?BCvVCyQwgvoHpOVIcH8vRgTzVDlAxDveKN2Y95u7CaTNq+ulepVGoDUu6KZM?=
 =?us-ascii?Q?8nEscrxXjFCHd5KJR4kHQtrUucv9h8jdhREgT1RRMcb1Jkl1VsZb3uGBm7bE?=
 =?us-ascii?Q?DT9FynYCJ1gYl9wlRQyTArrjjpFKK1IS2WycYxBaOQQ0Hs+oM67f0zHgYvWW?=
 =?us-ascii?Q?HTDcEvsb80iAhR7eZimQ8I413bjC2O0Zcw542BwyEpTqMG8F6o1PBL3BuFv7?=
 =?us-ascii?Q?22BwhVtcgzM10x9xnEPeXHzmU1LPIBi3XGhjCO95ph1eDPpzr11A+U2PPpHv?=
 =?us-ascii?Q?u83g5KVT3iB/T6J7TQ4pnVX/YHoHyhjf1zu4ail47AdsEm2oGSLOm1lkk9S1?=
 =?us-ascii?Q?epPXU8riv/nvgKpBK2vvgWW8OYkj0ZCVUPo/V0S9P8xR3ngofiEjKFIzvwuv?=
 =?us-ascii?Q?waAALQc8msZyHaMafbIFWYtcTUstuzkk1FeJ848F0fxXjElEk1zw2TP5uXau?=
 =?us-ascii?Q?kN86aHpOw2S8gfyjCJli7Vytu/05gi2XJe+x7OaCMrqGTmzNgGaMKmqItUIi?=
 =?us-ascii?Q?ljSSOoJfdLrDZxmoAHl+D/St/7TXAshMb70g+LsBY4vFtHiu1DfN1lFBxwJH?=
 =?us-ascii?Q?CG22HSyHPgSRVNYnJc9SneDe2gJoEGNUgFxaEAcyuWsa98d9ZekLPcQ8XM1f?=
 =?us-ascii?Q?GlNx0y9WYwaVyjeosgn4hvuP2f3Lpkw0toRk0cDiPqv3frAMFsub4yoiwOWK?=
 =?us-ascii?Q?CMbiXlDXsa63NRNc5PM8C4Xg999N0nn4QXbY8XP/ztBlTATFZk8Az4xYFkjV?=
 =?us-ascii?Q?0nhfef0GMU47QWX4r9UfStzXxf9ffLA2hGjmH/4CoEqxYSaVrV5OasWcgFCL?=
 =?us-ascii?Q?2fxvOZ5JPOhMVVadoH9cact2TbnVKKKmGuhWgMs5bOtEwowl82KNOhqDJaPh?=
 =?us-ascii?Q?jCDygf04OGNCgMwFZJdK/6hPhVcCh2/BenuVa3ax8939WLKCPSSQkuHWKibX?=
 =?us-ascii?Q?/gMZKMbOjgGnASZIWCaueEGfBBVuKlFX7FXFcue4cYdPAi4o/Io+FAJG1c54?=
 =?us-ascii?Q?g0wRuG/Ns+mIXNwtioloL3gGh/swHzFefQW3XrVtWuMqAMHOANmDgzufo3XS?=
 =?us-ascii?Q?6+ZgXif6JZw+/U823N/L06ud6n7lmD1jOdo3GlpImri7StWiblxdGHTemWnK?=
 =?us-ascii?Q?3rdNzbUG8tEr+NkzlNWtfel5eBz9T4unMWG6k1O/lVw39HUO/VqCdbnGpHNS?=
 =?us-ascii?Q?+xs3PsGMncHIObe9thl14lOpXK9nB8WL5WK5dv/ownx7YtL1ttPy2c3jqO8u?=
 =?us-ascii?Q?bUgrM8ymOWmK3c7lWHp/OkyVYtOsjZSAf/F63qyvmLjrSYYqzP4Z9TCYYsYo?=
 =?us-ascii?Q?qY9dCtsY2Qjo/MMnF8iNx8izhy6Q/zQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1ccfdc-dd40-45d8-af12-08da47fc752c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:05.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTfZpQyXi4kGQkBQ2pSxGoFLvNaTxZPceFK9/L2GDb1WXHBZwIPJxkN8MReB2ffrl/IAf+A3Sgr4FhTAWVIFLZUM96gEnGRiXLs6k11hNbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: -PXLBj47JlhPQ80ioHpcofYKmtgt8nqQ
X-Proofpoint-ORIG-GUID: -PXLBj47JlhPQ80ioHpcofYKmtgt8nqQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear_pages_clzero(), which uses CLZERO as the clearing primitive.
CLZERO skips the memory hierarchy, so this provides a non-polluting
implementation of clear_page(). Available if X86_FEATURE_CLZERO is set.

CLZERO, from the AMD architecture guide (Vol 3, Rev 3.30):
 "Clears the cache line specified by the logical address in rAX by
  writing a zero to every byte in the line. The instruction uses an
  implied non temporal memory type, similar to a streaming store, and
  uses the write combining protocol to minimize cache pollution.

  CLZERO is weakly-ordered with respect to other instructions that
  operate on memory. Software should use an SFENCE or stronger to
  enforce memory ordering of CLZERO with respect to other store
  instructions.

  The CLZERO instruction executes at any privilege level. CLZERO
  performs all the segmentation and paging checks that a store of
  the specified cache line would perform."

The use-case is similar to clear_page_movnt(), except that
clear_pages_clzero() is expected to be more performant.

Cc: jon.grimm@amd.com
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h |  1 +
 arch/x86/lib/clear_page_64.S   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 3affc4ecb8da..e8d4698fda65 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -56,6 +56,7 @@ void clear_pages_orig(void *page, unsigned long npages);
 void clear_pages_rep(void *page, unsigned long npages);
 void clear_pages_erms(void *page, unsigned long npages);
 void clear_pages_movnt(void *page, unsigned long npages);
+void clear_pages_clzero(void *page, unsigned long npages);
 
 #define __HAVE_ARCH_CLEAR_USER_PAGES
 static inline void clear_pages(void *page, unsigned int npages)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 83d14f1c9f57..00203103cf77 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -79,3 +79,22 @@ SYM_FUNC_START(clear_pages_movnt)
 	ja      .Lstart
 	RET
 SYM_FUNC_END(clear_pages_movnt)
+
+/*
+ * Zero a page using clzero (On AMD, with CPU_FEATURE_CLZERO.)
+ *
+ * Caller needs to issue a sfence at the end.
+ */
+SYM_FUNC_START(clear_pages_clzero)
+	movq	%rdi,%rax
+	movq	%rsi,%rcx
+	shlq    $PAGE_SHIFT, %rcx
+
+	.p2align 4
+.Liter:
+	clzero
+	addq    $0x40, %rax
+	subl    $0x40, %ecx
+	ja      .Liter
+	RET
+SYM_FUNC_END(clear_pages_clzero)
-- 
2.31.1

