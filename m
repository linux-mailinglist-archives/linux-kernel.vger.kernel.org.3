Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4201853F100
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiFFUwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiFFUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:51:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE8A76E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:42:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256IH5p6010190;
        Mon, 6 Jun 2022 20:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5msmGPhnYMpzXeIEVJ2L1ZIQB+VFf1s7vKE0VKeA+bU=;
 b=cYWtv5AQMwE4FfKlHDzfVxAKC7qlHXnZnnA0KgaFVKGaRxKsfRoa+rL6ChPlZpSAHUxa
 twJmnBiknV/VraZ4i2ZRTIaXX9CCrQxemKF1tq6/CSqc8RFT0mDdGnqwuzwGteMkVThQ
 WTW7X1H/KLyJ6yhVUG2TWNYi54xneUm1g/9seoxIOMPTxmgQa4n7rFTUIZAN5XMIIRUE
 TeKLYmibsDW31WZKf7S1HNPZ8JvgfdPeGY70SoXrLm2HnVACx9xXkbcacmKGYyYtItLX
 vhIdZMpFs+docj5W11uHw315U9vHs6O1XLAiRnppgtSYSqD+uYZyOg4PheX872JDQBpv CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtfya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFBbK001327;
        Mon, 6 Jun 2022 20:38:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu91cum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF6NHWn7Yw4jNnwkGPf0zw9AAI6jW+r9KUCmOfxx0E3x+TCAD8z60UzffhB5MoD4hapMhlrB9zCowFyJmBiT4/qf2Ns9vOc/Q5mvQhTR24xIv5Lr7r3kAWE4uOGiejFI0wn1O16/LwtpCv6dKgL9O3kPHss6KfAFkkPjYWY+QDrUKMRSGU6ruBeOsJcosymz0BfKRyfceLuRlUqJp+9zsrZTeQw13sX46rna645SUTKZP2spcfFC3vIUvIt5wiuqB3sH/qU1EmwNsEeklAWcK2IECTCv/6q78IjJ+9U/U7LPXAoWDi0ANER9bnAdr/qy3PktS+w7BpLQfz8nC3gxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5msmGPhnYMpzXeIEVJ2L1ZIQB+VFf1s7vKE0VKeA+bU=;
 b=Qds31ICh0CgIOG7l6WjsXzr1C/gJxdl8/tFsBpjAPWE6/DC0NUvNkMJd7t034uBPAq8K/EaWLqoA/HZl2fahHcica4WkaFUja0f7Q8ThWOiHTJ2vMg0XeugepDCHq43dn6fAiNOD/SLt2sNJphOyEyKnFp898WB/3zQlUb0X1SDSNb5lggmXQq/loZ7SwY00mbzoq2KIjxtbPtKvgl3XSkhhhJl2cR2mRoLr3XarCXXo1xXmacHROAdPF9K7f16R17Ne1ImdWC7j1R5+VG3+SlBI/G447O69NIJeR3WoAZin4R6NeHyW7KrBzOuvNi1lDtiK5/4tdVrc6SOVxl/JtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5msmGPhnYMpzXeIEVJ2L1ZIQB+VFf1s7vKE0VKeA+bU=;
 b=fsZ8L/SRA7Cqa9nXATo3nh/qqiBxRmEJzY3rCQc4ctB0W70cH0OppbEzDSHlG/8/3HU2itnSzCMXUnZO9mEJHSga4M4uRA6smoYxNKb4GNlAnOMykdJjysYM94KhDoGIv1hjf/cGGvWMp/5bUmfbp4//KedeL20bFC+VFSFGAdA=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:40 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:40 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 14/21] x86/clear_page: add clear_pages_incoherent()
Date:   Mon,  6 Jun 2022 20:37:18 +0000
Message-Id: <20220606203725.1313715-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700ea80c-dcf1-48e0-d256-08da47fc89ec
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB27346C668977DEC7C77E084ACEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkHUdo+6QvnZeOboqCop7CpzCaQl4JIr4UOoKECe+B/xgP6SAkbhm7n+ZQLeAig/nOlb/7E+kbvmAv4osVxP2f+nxdQBDsChp41kNF6/xgo6CvjA29YIpOzpN3ghVu8SP/hb5Hdn3fdY2aL1G+/yrxWfuBR2DcHwsUBwqy62jaHz1QG5OXeTdEPMY6lI0VkHDcdM4XjyS3wDqNp5I44EKhH8s0nOMxXldteDjk7gxOL8NMcl8Q5s184HmWqQnRLax3k23cn4wjSEimmz0d4tO+UAKqUe+J1vwkuJmZpv/5Q8w1kcVDh6+dAb4isIu9Nu1apN+NjBNavwHDGilkfWaf+BO+m826W5UcR7l6UKqfn11SuCHqAnwSyKyzqBjTDVRCVcfz6sKxVQUymokWMnjRnDAwCgudUFV/tLrnqq24pYYPS5Y/YK2Td2ZEGjZKB+ja67M9yshlt5YpZ/IH2E3gDBAY+DahjdK+/TkbPtFTo3PC/xplrxalxT1FVJGCGuhdCec0LQG/rjf9bn4CsqAFjBqn6xH/vWkDxcqc/uNL3lh7EeX6pHge6BioVYHQyddngqVmmBvKwWUKcMT8dADI4N1BmMqy1DINJYcDGl9YkkNQK3VmdnCzVI6OMHApbH63c2DT33rGcfpAjP8+Zg9n+vUrvYaqYOQBIuzHEXPYdwz0jkLskvXuw7vGuIckk+fB84TbJ76RE/t3853sOXCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TUNT//ISlVbLVcWbXI9kQSaU1mig1mW4CthFRIKhVltPigKe71+ialwW5TK?=
 =?us-ascii?Q?0VDIIwtX80KxJLdJaup9u6SpzCHGkODbXVnrUvvSyd6Lpjz4VviTRY5A0z1Z?=
 =?us-ascii?Q?U36c5X2s17JJOxLLpWVaVfYTDfTn5YtoitMWHMZa+GzY8jBKu2BUfhPN6+Ks?=
 =?us-ascii?Q?s9INQcsAmR3dhLym8Zcwm/SH0wKR6Yxoq9Dlw3h4rqLE4cvlaft7VBqBIne1?=
 =?us-ascii?Q?S/8j5l54qb5FfiNnNE7QVebHrJyHiZTy+dkPV4BPXiSaM5ftOIlV5nIKm1yQ?=
 =?us-ascii?Q?5ilKCR63P4eK7EBx0y6i9AI9kd24+3I1IPS9QCg7Y8UnIimWbIryoMJIPI4n?=
 =?us-ascii?Q?+Gbem/LApPMTSfGBBbDYEV/VvpQiq6bwBACyP5T5P1yxazcjKLNjPongGbbQ?=
 =?us-ascii?Q?j7xj5UpKZjXKgAg4y04La5dWNzwo9Qa4Cj4cxv2lUaGXOKuOB06agyeVtcz0?=
 =?us-ascii?Q?85tdhj/87PblnC7vv/sR+1zd7ECjGQvEWqcbMnupUiVTsFzFUtW5F2jfcLeX?=
 =?us-ascii?Q?88W0vZAKqcqdz3dYKKqsql4dzECZlVfGg5tFHHE6AvySDz/f4MHGv+hGzJX9?=
 =?us-ascii?Q?GZCjWKVnAr2Gu1G+fcgBDJ4C2oy7HMpE88o2mJcDTeUjLQq2DkkZzf2y2JNG?=
 =?us-ascii?Q?o1/dq2gfOpqLJgmnBuQSyfR3tP3Pzs0D/pbkrLdN+0Tac30U1SqLz21KcuIu?=
 =?us-ascii?Q?XkU1kjsSRh7y8FNhVOFY7CtGWAr+nrZtYVFQZXL84aN5kbq7blcdlNabG8Ob?=
 =?us-ascii?Q?TAWk0EvJjzdkEJ4M7s8/kFWEGUfIW3oqRaoryhxH3iQEvoAKLYZzBpGV8s37?=
 =?us-ascii?Q?/B91P6qCEcp/JuoeafsBkJdwjwhiyQqMJWS2KbitN7e/UFG/12nKqKa51j/k?=
 =?us-ascii?Q?clZCGJBD3l1M+jUl2DP2ovqC4GIcpgCLl4r+4xEBSC+EKgf/xFp2HiJeYF27?=
 =?us-ascii?Q?EcFjPJVSwki5FjKIMAsTMLzERd8pyU7tn0/mDLQzficfHnk4sFoQrEPD/hcv?=
 =?us-ascii?Q?KSTgtbF8SGE/sAMYZPmQts9OcAGHY0dIKthk2kvncy1HAorJI1PX2D3A8ZTX?=
 =?us-ascii?Q?RC1j7OBN9TZfXN0ZoeNYloOsHJenyu05RsaiqUhg2U5ERFRfHndxHPX7AbeQ?=
 =?us-ascii?Q?Pbq+NzbSRqXZWNnIc0Y9xrDCkwAgF1r2hIIeKx1aTuC/TaPr2Pvd8KmCBKTM?=
 =?us-ascii?Q?rCyULVOkDEsnj8FVeK82EqXZhLIXu/YkA6PcUByvHMB4qrWCKcW5m09O67A/?=
 =?us-ascii?Q?QRB/g+JviODs0Yql0Xbal6IpN9JF5lvc3z2aWnFdcIMl4syY/oMcj0UNuwKy?=
 =?us-ascii?Q?r0tVWBRm2rOMzhhWJ8MzolSb05xMHyj2mX7djsIM8HbFV5SiPn9my5PGmL2b?=
 =?us-ascii?Q?1AQaTJriU6hGO0KsfL9HWQ2S8m8NL8sI+QKoX+QHMefynzD9UDRhA747n08j?=
 =?us-ascii?Q?BLf3R2lmuIiHdzYaTtJQHOIClfAZEViqP/ewn2czsBiVewjpcARiqXA8INvg?=
 =?us-ascii?Q?CJb18SD3+782yHoQTtD95kVo3W04jaeV+q1S+asQuGs9xI5Qfl8laHK0xakS?=
 =?us-ascii?Q?LiWTCg9hKeecdU44vKieWXDjpQHkcpSSF80lVNefVHeOX2lATdykjIgdGK47?=
 =?us-ascii?Q?4ot+hc7+8l91BYBpp3upbsGxpF7aDO0ttHI1n7ALEy5FzLqvwe2bsPAcka4e?=
 =?us-ascii?Q?PSwibsv7i5D9qqxm9/b9spcWU7OUETE56uXnO+y/hYHV7LK0+q831C2GmEkY?=
 =?us-ascii?Q?W1le8Tu00cyjnGpVBYmLHDlOtkqe0G0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ea80c-dcf1-48e0-d256-08da47fc89ec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:39.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr5OVaZkqmZfCzObBwp9zC0UUXsCZVstX6w6IiJ33eg5W2MczgQOBSQBl9kIeq2SkOQn78jMYisyPKcQTVpVWBSn54ZgNr3rGvwZFQiX24I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: mgRmUiLOFcvQLp-U8vHLaSwJPE3wULpV
X-Proofpoint-ORIG-GUID: mgRmUiLOFcvQLp-U8vHLaSwJPE3wULpV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose incoherent clearing primitives (clear_pages_movnt(),
clear_pages_clzero()) as alternatives via clear_pages_incoherent().

Fallback to clear_pages() if, X86_FEATURE_MOVNT_SLOW is set and
the CPU does not have X86_FEATURE_CLZERO.

Both these primitives use weakly-ordered stores. To ensure that
callers don't mix accesses to different types of address_spaces,
annotate clear_user_pages_incoherent(), and clear_pages_incoherent()
as taking __incoherent pointers as arguments.

Also add clear_page_make_coherent() which provides the necessary
store fence to make access to these __incoherent regions safe.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page.h    | 13 +++++++++++++
 arch/x86/include/asm/page_64.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 045eaab08f43..8fc6cc6759b9 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -40,6 +40,19 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
 	clear_page(page);
 }
 
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT /* x86_64 */
+/*
+ * clear_pages_incoherent: valid on only __incoherent memory regions.
+ */
+static inline void clear_user_pages_incoherent(__incoherent void *page,
+					       unsigned long vaddr,
+					       struct page *pg,
+					       unsigned int npages)
+{
+	clear_pages_incoherent(page, npages);
+}
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT */
+
 static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 				  struct page *topage)
 {
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index e8d4698fda65..78417f63f522 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -69,6 +69,40 @@ static inline void clear_pages(void *page, unsigned int npages)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#define __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT
+/*
+ * clear_pages_incoherent: only allowed on __incoherent memory regions.
+ */
+static inline void clear_pages_incoherent(__incoherent void *page,
+					  unsigned int npages)
+{
+	alternative_call_2(clear_pages_movnt,
+			   clear_pages, X86_FEATURE_MOVNT_SLOW,
+			   clear_pages_clzero, X86_FEATURE_CLZERO,
+			   "=D" (page), "S" ((unsigned long) npages),
+			   "0" (page)
+			   : "cc", "memory", "rax", "rcx");
+}
+
+/*
+ * clear_page_make_coherent: execute the necessary store fence
+ * after which __incoherent regions can be safely accessed.
+ */
+static inline void clear_page_make_coherent(void)
+{
+	/*
+	 * Keep the sfence for oldinstr and clzero separate to guard against
+	 * the possibility that a CPU has both X86_FEATURE_MOVNT_SLOW and
+	 * X86_FEATURE_CLZERO.
+	 *
+	 * The alternatives need to be in the same order as the ones
+	 * in clear_pages_incoherent().
+	 */
+	alternative_2("sfence",
+		      "", X86_FEATURE_MOVNT_SLOW,
+		      "sfence", X86_FEATURE_CLZERO);
+}
+
 void copy_page(void *to, void *from);
 
 #ifdef CONFIG_X86_5LEVEL
-- 
2.31.1

