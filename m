Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BE53F062
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiFFUoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiFFUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3D129EE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JgLu8032275;
        Mon, 6 Jun 2022 20:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fYmmVnaSVN/2hFPfnmGyw4rMWEDLHhxpyLeVlQ1iypM=;
 b=luZGfsX8i+CJ/WNZWgKSNMXfrS/9ZkW6BQx8Qs0xBtUYNGl3zOhMGgKwPRff+mAEFQyw
 uRs+aadfyMCiz0057Ar6denNeZkcQomBfnHzXAMxupsEJtwlH6JgxOuim5hPQzKEBZKA
 91IaU38gcftDQa1i1/7oor308PIuVXA0IUP4wgUbSI+frgF1YYPRC+zscCo/IED0xwMG
 ZxSYAqDI2FxxgmOgEfyNZ4QyFGotGmlTGMrDKqhuoGqm2i6mnx+y8ZFlJdJpIO0VMPZ3
 mCHNhYajdEQd/Q2gQzYbl9BXfzPg9IcLeotp9Dt/RWF5uH9II0MUG9oxXYdp7ke+E7Qm Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsc6k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFkOw015917;
        Mon, 6 Jun 2022 20:38:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu80a9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVH+DOxnJ5bIDIJ3NblkxL8DAMRaolvjfuWOwAsiQP1OL4f6ji47lPh6601SMxAY/nZmeB+e9kaQnNwmMbd2npwTfkeFBmD1nxOyT2bkVssF5EnaOL47xEwLjyguaT3VrWh/YgvhcA8XcdU136ORUUv5xLqEAQ/j/JpD9LHtkn6rly9Pl7DkMO0bbO+Bfk3YMSWDfMjTRpOKgg+04YwkbdJmc0Hlm62WkhY9Spmjkkr5w8BgUAL9rb8C49+Td8ICvqQg4KGde1grn3oC+7QfZQ5yOoVAJUzZljjX/nOptlbAFg/glMJjoB3ODo8d3pP96Askeo70YYyctPRwYBvFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYmmVnaSVN/2hFPfnmGyw4rMWEDLHhxpyLeVlQ1iypM=;
 b=W056rwGL4lFJJmBKU9+FiDaieVXcWsv79We/vkfIZM0EA8cs1lUqF90i/AUS2eX3kZNJcLmYZ96QWh5gLoPX33c0BUikbSTeEtqZMyn9y4vQy3YlZWwtp81Ct7FQle66n6Gl8SJ/m1SqDAo9aS3VmhvrU53Wb1bCwxoBK0ikl7P+zoFnlKKBIM8Y1Em5aNCWV8YVDBuVzuyAo/hZzKhkAXDRFPD+WQYyyb9GU3PI7mDGT+BoyxX0v4do7LSGjYtgGfq+KkAxsGE39AecqysVM0RziPoyjFiWJwhgDwe5Im61C3T4AW02GjLbGoEHkUFgeDIcevkXzVWn92+CJiPPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYmmVnaSVN/2hFPfnmGyw4rMWEDLHhxpyLeVlQ1iypM=;
 b=cPQl99u/eJ2elBh8pTo+0AdxBuQ/bxM0B+OwqWGFI32SId/V2rPgMeVhBZpepyrmfDBgtu+fr0z+TBreTqLPGku/C+7MgHB3IkWdXN/iKI9eGbgA9AIiwy2XMl6sZEJWPvOrYUe+Wg+yaDmFC+aTp+wGHsqBRxlcn7+VdVlnIgw=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:45 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:45 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 16/21] x86/clear_page: add arch_clear_page_non_caching_threshold()
Date:   Mon,  6 Jun 2022 20:37:20 +0000
Message-Id: <20220606203725.1313715-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f4a2ea-7de7-4799-5f4b-08da47fc8d07
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2734D915CA5B7E16CA5D53A6CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56A3Iuix3qbn8epfGKllSCn6VCjcOCtUARO3sXsax+xMLk3PQrag0jd4nED33vFeAUSD6KVLvSZ3quaibbDxPMlAabxGqg7RhmoMJCYIouO6huy+lkYO/+qgVB/hQD2362QBE1z+G6zR/HuNkLBcykO8QTD0gs993qhJpoG8Wny/3uPfsOmFoGYgETXNa11lQkej8YlNEDcAXc+1m4iJRk8gjIXzE+enHCoc4PPVjeM2GPlynLUrFQcedsypjqg5mR2d+iPdqxDzDIy05HoJ6VysnxQWT3Ge5l2Ran4dQ/ZSVMsCiWJiEfo5VLUYQWFkdBiOZaJHAEZV5AJGUPaieVj7Eqw6dghMrGsOrF/AXF2nhBo00JxK2CxUMiIWpJOI9urQbBIi+yxUUu8fMjyQeMZ7tND45KYt8jKRIfJEAYRpKs15BhRpUkOpdzoL0cxv2+g/4e1Nk6r9j9mkG2PMFFI4N8x8QVHQRmiToOj9UN0WWNxBDsdMNeYB3LWsnik2aKWC7d9R4QvRTMn1uGWCGtO7yKoXo1cLHft3wLqa1V3TwWPQtx18Txxh4hnfXVbKEO82r6pjpAvFNdBh5Av8sTcGbsCke7VR+QCsyDu0l702ACSsQ8zCvHupTb0KdUs3iHloa1+dabkZ7iqelpAgFvyNd7oVWAz2xZcWnOKB5/y5JYAxYuvc76RXSPC4oyBxBMoSdPiZ7g77UMiDt1PcTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REJDy9VIA8kxa1DNULchMa/g+t59pHpLwzy62XpvUNZEDp+GJvY9Qql5e9CF?=
 =?us-ascii?Q?0kiwh5fXyg8QE0pi4nFxzrygi4xY/QJEagyePlsmIfcSM6wwR5h6KTQZLuEK?=
 =?us-ascii?Q?xyjymsTOHIw+7e/+xhwqnRolT5E6Iakp55YOklVQT4BhQPqycC/F6SchcKEv?=
 =?us-ascii?Q?KFDpy4H3gmjGuaxEHyLwhMozF9XK2qrp6kymWKqAkbuK4Hw+72VkouX06wzS?=
 =?us-ascii?Q?qro0g42ZuzLeAcIH4+ypB16IU4FTuDybsM9h+BCGrHv5akyi6Zab756Dv7Oc?=
 =?us-ascii?Q?/wn7f4eo9usSYgAgpyi4wJk5ydZSjY6tygiflZ4an0s32qv3cTVU6uPy4nc9?=
 =?us-ascii?Q?rSzZhGPvhtUzUH2Myzev7AzTEdl7wleQmV5AFOUFNWVeQlMSYR69ERashcV/?=
 =?us-ascii?Q?9l7utmq/7GQjesrBT4vu8+HqINlEl6WmkYU0VjSkn+jJ8z7bZyVOT19NAoew?=
 =?us-ascii?Q?6Rv/FJ+QKpgZwAAuR8io5xjuTvkjuVelpuGkeWZahWTikc1lFTV0XwwJ7gQb?=
 =?us-ascii?Q?0LtyYm3fT0paN1ZdKYzXdPiHu7UPMdq8ZvABPx2vGgUODC3oDhR807ZkmQC8?=
 =?us-ascii?Q?q4AFYMcE4nXITMLHArZ3Y3tnFPz8tux1hrT3u8BBfnPwPObww1BJUGb5aFB8?=
 =?us-ascii?Q?fYl+wvjVCzxAani6/4cuwm+wsrgZI1gSZfsDprcMfa4bRl3bvEkZ5Z5CsLI5?=
 =?us-ascii?Q?2tdS+oNavrKPxEjwMq5M2MU9LZJopRYeBRs+1O1jhJvNOhyAkLK6ZAMGobTn?=
 =?us-ascii?Q?ZOfqkEDGiM+qgH89b9rLVsIuVherzHOvtcmp7U1xwwtL80iQha9eW14N/TGG?=
 =?us-ascii?Q?nay+Izsz4RIIXckH+LsR+bP8PxBX7u5ZJFm5MLh9F43kGWTf1WJrlT/ERJof?=
 =?us-ascii?Q?v8whyjrsBjHHQqFdsp5ueJ5ND9d8zG2CHea8K635InMWowi/LTtPfXZSajaw?=
 =?us-ascii?Q?KYaEEtsRe59XfMVzu5fYfK26r5WS/UcqFPhvJSCRWyDCBmfVpAfNg1jwUwyG?=
 =?us-ascii?Q?ftaQuCKcpcYs51KskWx2nP9xpVJZFYbfkCDjrqxIq+GLf4vgiXBPkaLUcyGX?=
 =?us-ascii?Q?L73SbxTd5KSgfdrR3ebE3EFiWYkzWGxqGkb5KivmiygctJbrOeN22kp0f2Ce?=
 =?us-ascii?Q?bat/GOdzza/OqGPxtPFHF1w+2fruDLQU7JSuv3S61xgkTZ1qRKzixlUjm5xo?=
 =?us-ascii?Q?7w5pMVlQpiuhSh8+8aw+vOnIEh+LNslu4R4ve7me89jWgNDAZ+e7T3N2UFH7?=
 =?us-ascii?Q?QX/bX0KrQg0N16GiXw1KZUMoO1H8Kfl1jWUIDLSPYezO4uZftUssfjJvEhFP?=
 =?us-ascii?Q?+w0x5S5eDQCyHqW5Neqs8XcUsAil/z5hyrHE0qZXGTvlWIRQkAynqAAJWB/Y?=
 =?us-ascii?Q?V/tX4dkq3u9OdTDMnuxfOw36zQR1N18GvhU7GDTOaIaMCOjSuDgZL95RoYBa?=
 =?us-ascii?Q?+yLBfRK0Ih8rmF9YDiqb4ltYLYeRi+u0N3UTcr3+H4FaPnfqa6spTjIdB3CH?=
 =?us-ascii?Q?YWNm0ZzRrxVqFNTld0PbEqwCcPDPL3MgKotCUfm0/dpkluKb6eJmOoIFxXUT?=
 =?us-ascii?Q?nWhGzbcUvAjQxFu08yKGvD+oecClcQmLOa+cFnmrFwFXf2S8yh8/7lk9Sl+l?=
 =?us-ascii?Q?Ro3/HCVYRIA8fkPAssj6GzXsq5VWoCp3CvD87SBhRPCSRcj6nx2XEyjmgKzj?=
 =?us-ascii?Q?WkTiMAm8ABuqAe+jh/4nFeUo468MW5wFBjuCvBfYHI4AHRfrbUEFhydfgiq3?=
 =?us-ascii?Q?47kGNULE75cAbn/HSiveqOz86j+7jbY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f4a2ea-7de7-4799-5f4b-08da47fc8d07
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:45.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7oe/4j3G9Jq1oDjdG2ks1SYekl4AZxr3KP5aFBtiCeFK2vjLBQ8Ysejy7WcUjK8fmsfkx5Gb418FaPB+sjYYQdpH5lc9nagIYVu2JGWrFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: bFyncl2rKsmgwuWKnXmiTtNg13Gu6Q1D
X-Proofpoint-GUID: bFyncl2rKsmgwuWKnXmiTtNg13Gu6Q1D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arch_clear_page_non_caching_threshold() for a machine specific value
above which clear_page_incoherent() would be used.

The ideal threshold value depends on the CPU model and where the
performance curves for caching and non-caching stores intersect.
A safe value is LLC-size, so we use that of the boot_cpu.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 13 +++++++++++++
 arch/x86/kernel/setup.c          |  6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b2e0dcc4bf..5c6045699e94 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -4,5 +4,6 @@
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
+int cacheinfo_lookup_max_size(int cpu);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index fe98a1465be6..6fb0cb868099 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1034,3 +1034,16 @@ int populate_cache_leaves(unsigned int cpu)
 
 	return 0;
 }
+
+int cacheinfo_lookup_max_size(int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *max_leaf;
+
+	/*
+	 * Assume that cache sizes always increase with level.
+	 */
+	max_leaf = this_leaf + this_cpu_ci->num_leaves - 1;
+	return max_leaf->size;
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 249981bf3d8a..701825a22863 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -50,6 +50,7 @@
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
+#include <asm/cacheinfo.h>
 #include <linux/vmalloc.h>
 
 /*
@@ -1293,3 +1294,8 @@ static int __init register_kernel_offset_dumper(void)
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
+
+unsigned long __init arch_clear_page_non_caching_threshold(void)
+{
+	return cacheinfo_lookup_max_size(0);
+}
-- 
2.31.1

