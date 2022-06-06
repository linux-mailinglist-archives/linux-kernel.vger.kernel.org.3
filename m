Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411C53F0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiFFUsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiFFUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD4D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:41:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256HqxqK028290;
        Mon, 6 Jun 2022 20:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=RzvU0nEnKpie6gkEUitVhL+sux82w413s8CR0J7uhK0=;
 b=TL+FwDIjew6HgPmAHPVzx8CgcXSMA1Ni5LWfdhBuCyNfaobxTFMoxvtThPk4V7Fj0Y2z
 PJ4d62cJHvIT5cxIjQ1YYqT9eR2KXgcYwSWkdphs6lv0hz1RPs4lVqxVxU2NC4hdfB/J
 YY9yhTAsmqUiXuw3OsVdfB+Veq1EzN0PvkWoXLSUEqnH7ffbBNokIoaW9ubMpjRJOBdK
 i8ZwPNg3IJvXbkDGyWxOmPmPjm35s8AlPTwi+EAkaLD/eKgoWORyaHTR6uB8YMR16ZMk
 vWHPWvH8qsyEL4yQMU3lUVDEQu9zExN+AaBWZ648e4rmRXsqropcGvOvMnhccgfQ+FI4 Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsc6f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGPjv037954;
        Mon, 6 Jun 2022 20:37:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1upy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Levzntp8Qd+GBPAoY1azEitCoQRZV2uw8++30HjvoKvzAkr1KBP2iRe3RTEZtMyMu+nxsZaR8oTTxgBtW4j4BtucXA0FE+T8GS5+AhVDVgTpuL6PtFaywkBbKjfb5BS99WNfdHrqDqo80AEsQtbcX/+c5JHurEyjgF0XP2YQEvxHcVzQFAdcT1LzuN4tsd/A1pqiZq1LXCDzQ5/JlwlOnjnMpOVKrAkhRGFJ3wtTkUiXRLTyQko4L5xYM8C63Ueq2ayazzJg8Dd5SonSLJLUp/KLQtD2ISrCq+0s/ncfYKN5bKqdYwNrWVvpMavGfxqPncC1cldN1Wega1c8x+hxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzvU0nEnKpie6gkEUitVhL+sux82w413s8CR0J7uhK0=;
 b=GDNu+no9m9UhX29pgzm26CemU+Jy1fLGPKEuXao3GW7RtuXtLIEboEEqoNarf0jyAtI8OdPyB8ixidQjw6xl5B6ze7i/aDD3eKPjhDN54wXREhJ6KwCDhDrHyTssty425ZEzHO4jZ1hBxp+tKUaxxMjRAx/gmP+YPdX8YpagW3sbgD3jSLps40TItjmeqMUYS8F8j5vmqWf5LyMLiCE75avctPX8lHEAIJ5RRnzkebeWrTLuwJ6Ac0zSzFeFAoqA5nSdI56zKXfJWc8fNFeTkmRW/zpjyXqJHNnI28okC10WpGjLV6KEhxugQ7cX4K6TasXHmuBGd9YTbPSea5EvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzvU0nEnKpie6gkEUitVhL+sux82w413s8CR0J7uhK0=;
 b=pkIU7uUMdqyvaiUlt3BD9ognBTE0KmdHPL8t6SprrOaE4hr+5VhfEUv0YTLStiz/rtyJUtMNjVBBvrfqOdddTI3RAjXRqO6Z/yk1OWsgZeY73/zA9Cb+RsZdwYj+rH5oBpwoAWsaPul2iKkLS2WCKBcnee5S4dxtGmLSC9GXE7c=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:37:44 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:37:44 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 07/21] x86/asm: add memset_movnti()
Date:   Mon,  6 Jun 2022 20:37:11 +0000
Message-Id: <20220606203725.1313715-3-ankur.a.arora@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49827a37-a8eb-4a11-7508-08da47fc6895
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB25965A7F2423997CEB4E22B2CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CM5+389ZXDsRcSLh12K8bvukDD+a7Z4gikJHyUtZI9LGhVC/bmtqXQA5cK2pS27ajHyrxb5mUmfdQ66VJdYU/bxNpEWXMwhJqCAIVYolqYxKuaokTgu37ihPF/VHGH2RFoCDuMYR4Ff5steC6x0E2XwgUCSUUSwnByouM1FWFzpct95SZLPIsz6cLfiPRMCDFKe7MyAr0c5iH0X+eJkrucNjbMPtmeUNe7lM/GZIruveXGKtqdIJwJEsQO4RHZdPSz32bMme8ITwZZ3xHgwVM3OQlnSqteioi79CJT9Dp6IekCf+5REfKMryKe9CUI1RwfUPat8BwbHxbdXUNTYH0xdShqA1Padqpol67c3fqJt2IZ6PyGD4k6S17cne1hq3RYN8OB3GtHKaxS/n+uXPXXmmh/M/P0Cg6dP2D7eChnLOa96KLy/+Ukdn26X48Wy7R/0j79r2SDaiUDvCoRy7IIOXSWiVH3MQE+rJ/dw5rovMJzeMM/5JB1e/8jorTmGclXbVjm8q/FaopAM3risU2uSAB7bPq2pqhPmY+6G+QGDNhQ8/3vXPHa9Qy0EzMZ21bCQuCVzFW+1kFs2PUEmnppBE97Nbid7U4+ZZPV5ubl0w/+uhH1ycUd8QZNyiaVgZd+ZSqyY7HIfb0zrqjNQFs3X0PZE/nkO+tYU+5UYsONtbBRRwdRz3lzM+xVSL8jlZsJEyIZslr4OqwkWjcx9JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gz2kUE45r+zp3R/qYBjUfVE9yWALT1+phKSOq8XLMHCf5bcwbSwBTrCl8346?=
 =?us-ascii?Q?z5Cop3sALdh8S/sB1Hs2oiDjP4FpnZTPbqA3zKvV8EMhEjTJuXM8GWPd7Wrw?=
 =?us-ascii?Q?KZXI1HDJoFmCK44WmyY+gJ8oqjq71KWbEwXt7PqNO9D1XaZ0Uuo6VtgB88Dw?=
 =?us-ascii?Q?73P/K6+fKBvPG+PQZ3drAukZOGu1DmMCODnHV0kpwfsv1Pjyk+48xTsK7nhu?=
 =?us-ascii?Q?Yp4RlIgEZKkC2AFDJHh0OyGKJQ1KyBeFxBhDZdbpiQ4LVP0PP3qADgu9NhOS?=
 =?us-ascii?Q?6UURIiDYANVQKm07H+qGV6om/nbND+ZVybTfDdG+W42GaFSOXLLUHsJS2Rdx?=
 =?us-ascii?Q?7PoOrlMV9mJs44qIABf7igiBPmj+XIdRFa4NSbbSFxRKowBG1/zj5RMLiAh9?=
 =?us-ascii?Q?qQSq22ZT8ycDvjwUzUNmWDpp9tFbcixkNERsNXbdIirBk+QjaVuBN91Q2EPM?=
 =?us-ascii?Q?MqjcPhNbQp7n24J24hsk2Zb+/CnyTbsPdK23NfLtcV+X54uXfKOpyxa9jZ/j?=
 =?us-ascii?Q?PxLUZT8E97bSs2soDXBBCEgdnefxLU/fZ2ZDtB027FckCnofHQXLnnJ5V9a+?=
 =?us-ascii?Q?Z0FgsQAdfQP5iIXjZVdfvWH5YU0+c5NqcHDTLG+1opfkaWliGRPIwF3G45QX?=
 =?us-ascii?Q?hP5WsllxGGVlzTzGWzhxqa4sEVEkzTmy8E1O5V2xXAkjwHZT/5yBEWgdetSl?=
 =?us-ascii?Q?KvjgMKBXmp2806p7CJh1kFOnGdoQSs34/E0n0Ir7tC7xEW/0QyoAE/1/Oe4w?=
 =?us-ascii?Q?pPjD5D2CtgxAsPWFZFtoENlMh7ulk/XNkFe26nWIbslMbABo/hY56h0rNlr1?=
 =?us-ascii?Q?etjkCKfWYSKFcT4wAYLHdHmBzhqn90y5vkMo/5bpq6dTBRovvnm/jxh9R2C+?=
 =?us-ascii?Q?cQuE90fkrTbf3Ju21z597bHsAagiLfHTvVH19Ye6kGMHsHOhsZctoULP5kMy?=
 =?us-ascii?Q?ymX9FMICHXZj2ed9LaOGuYjVTO8dnMgw01tF+wzB339Dp9o6Dn8+kuORvDWA?=
 =?us-ascii?Q?fS9s8B0xGII6o3Ba+rKyM6paaTxeytJa6EzvnaBGLVZHYYVn9sDd24L9q1U0?=
 =?us-ascii?Q?413lZnUPIdShA1pi5W2UuBB7j4N5ZENb8B7UInKk4Gxl17z6iN3SsZ3s1Y9Z?=
 =?us-ascii?Q?7LwwiriAvpeOG4ADHKicKCisrQWZyuoeMRzyhmjRlWG9/0ulBiiGMeGQwR2x?=
 =?us-ascii?Q?xDTvV3z9munjMkqHYzd+ravgPmyVQT0wwomx2K1+rFTE0jBCAzZh0ePg/sE+?=
 =?us-ascii?Q?tNTBUoBmKrFUt/WXFnBI5PawXmCEcWXHymomEAYeYVUSXkDVCAphCTxcxv/f?=
 =?us-ascii?Q?nYuV03rHOTL6V0Wf8h2KzaP3qTXbKJJ4ZHyuKt2yy+r4lqWNduuX36naFWXW?=
 =?us-ascii?Q?rlgK5qplGWuvl4eu/vtssqhmu081WUWJegkDWpU2N5vXpp5QR3hGAuhH7m6I?=
 =?us-ascii?Q?PAgJnhpn1t4j2P/zhIRSeDtsjwHeZylPifMWGmJbK/1VLbtWsHrXXsvolkns?=
 =?us-ascii?Q?yEh0RXrDTqNj8JQwv7850qlL8xRIGzyiyephnak2IQkGLSVS9d+hzT5d2/Sz?=
 =?us-ascii?Q?R4+UKhWJ16Z9LcozJSZ6DDBIYVk1oAK58TBBopmXtrmhJl9FEgD5itRfcJ72?=
 =?us-ascii?Q?gLKKh1XRLcGWLcMOSwtPUyUnM3BCeZQVWwRQW2PiDAcJNnis8mKMHAjmAcAA?=
 =?us-ascii?Q?oukMnulvyx7vq425u6J0DicDgR1IcDhVyyfhd+TlqCzYzn6ZpTHIYbqqdxeN?=
 =?us-ascii?Q?NetOszvxSJ5DHWppb/K93AtXQW/jDlQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49827a37-a8eb-4a11-7508-08da47fc6895
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:37:43.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uA6Z3qwHbRCum6xEv2e8SqJ3t7vgIBuCCheXqGf38C40c0QPsluwm3FJLD8T9ZvW0r5PyMJBdUONPt+oZPH7oeSJbr/0MC5xPEYG+7z5rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: cX51BN8OkZp2Ovz9-xFCzkdwZQLc8vYE
X-Proofpoint-GUID: cX51BN8OkZp2Ovz9-xFCzkdwZQLc8vYE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MOVNTI based non-caching implementation of memset().

memset_movnti() only needs to differ from memset_orig() in the opcode
used in the inner loop, so move the memset_orig() logic into a macro,
and use that to generate memset_orig() (now memset_movq()) and
memset_movnti().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/lib/memset_64.S | 68 ++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index fc9ffd3ff3b2..307b753ca03a 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -24,7 +24,7 @@ SYM_FUNC_START(__memset)
 	 *
 	 * Otherwise, use original memset function.
 	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
+	ALTERNATIVE_2 "jmp memset_movq", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memset_erms", X86_FEATURE_ERMS
 
 	movq %rdi,%r9
@@ -66,7 +66,8 @@ SYM_FUNC_START_LOCAL(memset_erms)
 	RET
 SYM_FUNC_END(memset_erms)
 
-SYM_FUNC_START_LOCAL(memset_orig)
+.macro MEMSET_MOV OP fence
+SYM_FUNC_START_LOCAL(memset_\OP)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -77,64 +78,71 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	/* align dst */
 	movl  %edi,%r9d
 	andl  $7,%r9d
-	jnz  .Lbad_alignment
-.Lafter_bad_alignment:
+	jnz  .Lbad_alignment_\@
+.Lafter_bad_alignment_\@:
 
 	movq  %rdx,%rcx
 	shrq  $6,%rcx
-	jz	 .Lhandle_tail
+	jz	 .Lhandle_tail_\@
 
 	.p2align 4
-.Lloop_64:
+.Lloop_64_\@:
 	decq  %rcx
-	movq  %rax,(%rdi)
-	movq  %rax,8(%rdi)
-	movq  %rax,16(%rdi)
-	movq  %rax,24(%rdi)
-	movq  %rax,32(%rdi)
-	movq  %rax,40(%rdi)
-	movq  %rax,48(%rdi)
-	movq  %rax,56(%rdi)
+	\OP  %rax,(%rdi)
+	\OP  %rax,8(%rdi)
+	\OP  %rax,16(%rdi)
+	\OP  %rax,24(%rdi)
+	\OP  %rax,32(%rdi)
+	\OP  %rax,40(%rdi)
+	\OP  %rax,48(%rdi)
+	\OP  %rax,56(%rdi)
 	leaq  64(%rdi),%rdi
-	jnz    .Lloop_64
+	jnz    .Lloop_64_\@
 
 	/* Handle tail in loops. The loops should be faster than hard
 	   to predict jump tables. */
 	.p2align 4
-.Lhandle_tail:
+.Lhandle_tail_\@:
 	movl	%edx,%ecx
 	andl    $63&(~7),%ecx
-	jz 		.Lhandle_7
+	jz 	.Lhandle_7_\@
 	shrl	$3,%ecx
 	.p2align 4
-.Lloop_8:
+.Lloop_8_\@:
 	decl   %ecx
-	movq  %rax,(%rdi)
+	\OP  %rax,(%rdi)
 	leaq  8(%rdi),%rdi
-	jnz    .Lloop_8
+	jnz    .Lloop_8_\@
 
-.Lhandle_7:
+.Lhandle_7_\@:
 	andl	$7,%edx
-	jz      .Lende
+	jz      .Lende_\@
 	.p2align 4
-.Lloop_1:
+.Lloop_1_\@:
 	decl    %edx
 	movb 	%al,(%rdi)
 	leaq	1(%rdi),%rdi
-	jnz     .Lloop_1
+	jnz     .Lloop_1_\@
 
-.Lende:
+.Lende_\@:
+	.if \fence
+	sfence
+	.endif
 	movq	%r10,%rax
 	RET
 
-.Lbad_alignment:
+.Lbad_alignment_\@:
 	cmpq $7,%rdx
-	jbe	.Lhandle_7
+	jbe	.Lhandle_7_\@
 	movq %rax,(%rdi)	/* unaligned store */
 	movq $8,%r8
 	subq %r9,%r8
 	addq %r8,%rdi
 	subq %r8,%rdx
-	jmp .Lafter_bad_alignment
-.Lfinal:
-SYM_FUNC_END(memset_orig)
+	jmp .Lafter_bad_alignment_\@
+.Lfinal_\@:
+SYM_FUNC_END(memset_\OP)
+.endm
+
+MEMSET_MOV OP=movq fence=0
+MEMSET_MOV OP=movnti fence=1
-- 
2.31.1

