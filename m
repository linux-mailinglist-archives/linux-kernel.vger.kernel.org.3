Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8492153F106
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiFFUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFFUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:50:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC415802
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:41:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JqXN6009827;
        Mon, 6 Jun 2022 20:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QCSv9wnBM6566kGvcpjLE6r0FswLPnX6HxMKaM9sTGo=;
 b=z0GBVLX8NQiOUYuuTmUeHVm97mCUehinjq881jRw4dNaHqsOs9JhOJsjEvM5pzl7b/OG
 URlbjLqA8DKXcDI7lj0VptHJxy+54ZEf6voC6kMxuNkk3rTGArgypxE013pKw4/H2544
 ynNuJzpuHfrT0DeFl4b1i/afUEPrQyOWiBgRDHuqtfHoKGzq1hzfrYs/2tvWRzj0KUQb
 J5ML/cJZfjIgezDahDtebpHIYqtkhxWrKvusA2XloeEWIFxAbgTB8kXhfW8UnBB4tLXr
 lOrthJYzzafVoR/k0VINvv4Sd77wuYFovBhpBfEn/s8Lti1NSs8uv3/8dnxWhFE6l+aS 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtfw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFw5L001423;
        Mon, 6 Jun 2022 20:38:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu20r8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHbYh3wx0IpZPNb+dn2qHQmIfkahLHjKBjSF7eTL2rNsK940s4w6I7KO3YN5iXMuJU2MAEpoKwxVL0PtlaLR/xRXM6KM1SrdHXyTHNNQYB8V/xeQ/p2dUAUZwrmm9yTGBiVxfpc4IvEWHc4LKzWgWEMBBzzJcKzdMaw5FeCSDfi64UAQOha7/N/VG79oGkK0UFDQTBHQlBdU3XmYFfhya2CXPeMOP3f1Sl0ihbZ+dRYhPIe3PbfNUpuZhO5fPVst+VkdlUn/MLiqgUsRQAN+oO7HzlsUaQHDuIHv5Pqzfvg2lWmdDCwJXPDg7AchfXX4+6hpIWx51fQGiLZCZcibDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCSv9wnBM6566kGvcpjLE6r0FswLPnX6HxMKaM9sTGo=;
 b=PewCIefgFMVXL+FWIqetLf1DhRHj7JqeeNM7tbJroYQmKgwyFZuIaFUhX9AstliwEH/qbZwFZB68r8xCOqqj7UqfQORtV3FVVvmolAx138NcXfaNDnaCvvHDxFNOyp6Nu9iCgobNuBEaGuqwqydAP0rvzvWwp2xGg8mePs55bl3YBdo6vv8eJfqN2WIzOpH3U7KsiB9P3L27ooepuFt1t7v/ue4ypEyzEY9ARWWHmHua458zYKlc62JgpLMtmcxW0dESjs2YLuESwTkJ7vkrVUZGd79eLq0DcyDH1bloxGkdznDz0f40yWQQlp3PDHp8kAtxHV2la94DG5sd8XeXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCSv9wnBM6566kGvcpjLE6r0FswLPnX6HxMKaM9sTGo=;
 b=OWG1T7UNpXjvNArSeyR05xiarpaWLmY6bJslmpoOC8GOk6MaCwvimDRlSmeIL7N6a8ziJ1OxFuq8SF7Ahg1D9nIvtXKf/FCHgSzk5BNtLC0Ry42AG/qT3Z97t/K9zqJReBYl1kKK7hd5Z7iSaEOxetsfhMsqq+m1fRxRbVVEblM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:20 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:20 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 11/21] x86/cpuid: add X86_FEATURE_MOVNT_SLOW
Date:   Mon,  6 Jun 2022 20:37:15 +0000
Message-Id: <20220606203725.1313715-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ac21b89-53d4-4d3b-8157-08da47fc7df1
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2596144B5DC4D1DC25A903B6CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+cmf01KNkOgAF7D0ZmwCc5R+yXM/e3vX84PjhYsnqd/np8a4jGL0zgC6pjgxuO/k8z9whCyYsk2v3SjJbw3TkNVCowI1WKPE6RfA55mb1vU+lYFG/eEyC1xja0x4+W0hU9sjoTSQvqJmKN2B9mzNa4qh+xFvTntKA78nuIGQXWk/R4LRM7hEjZlKjAG+YhsFfE4acIKyrSGYbyeBLQRnLPmqkglkbXTTtvvA/GWqXy5qECITcNQMPamWfNE1yVR8ki0IOosf8waaGQhWtXMYYdg+pD12T6xS9zYYMq9zTLxsooAqXxdQ6s8gA8EKMook+iNqHGMz+M6Y3yzBHdfIBbEOszxARlinCz+gYCH4F/2rb6rEpMwHBVTEerkJ8xMsoTwXDX9C3nqKaWTWyYnydOb5F5NMcz9cIphiiTrY0OO0o5swXvUyc10IC5l7lq1ElNlqqcD0QqU0Vo53a1Wreozz3xR2IbDcHcYpsU0rVTxQleotQYmb756yKyXk4Vd15O5sz/8DO+3mIooi2+LJ6iC0+uAIoA7ZWfsJQERRDl7W/TzyyJ7j9RxMJdJzhqqr3PJUsxR04D/ZAjfEP9/3whKcmPLV2VXAI0klEhGiIFjso+QPkaNIQ1mI988B+tDBMIdJYiHjd/jDcMRiAbT3EKLejz74XFgDz5Wfu5RcuxW6LATx46gkT99mI+CgRBOwvEcGtK2flFZS78x/eyW4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/3cWwFpJYC7TQfsJeJD4sPvPRNkMRxHwIl5zk7Uwgb+Wuh8Jc/CtWXJgcV6?=
 =?us-ascii?Q?uk9ZQ/xPkwRM9Dz1SnR/IXEjRiR6d3BQ80fwxKtaUgWc0vCfitbLwlbrKbvm?=
 =?us-ascii?Q?3sISbuWeeAAXbW+YheykXEvpE8ywpvSt2At5vLuntrYYizqpl8Apd9nYGsiO?=
 =?us-ascii?Q?86IWbkk7X2sit1nQ2ducl3tRaX2DHSD01ay+1rOM7CfB5BDVqjGk/bowhTS8?=
 =?us-ascii?Q?EM+MjO04c55LKRx1d98GI0rfLhrWvwrxZCpn/hyD8eRxHdSEGfHaVp2flLrZ?=
 =?us-ascii?Q?pHtaxJJPhqttafKh+t3LbU6ZW/m9FYtPqHe/A3icg46/2mxjvm/7i+RfCF3W?=
 =?us-ascii?Q?M4LkDpbe/yu5DFxTiiuziygAwhLAju2ohhWXwnp2ui5zMkrfoFSGJ5orqaeD?=
 =?us-ascii?Q?DFTRuLrX3uxQsA1TxMHITrfXiRLnMGur5M4T4cWEmieNTzKiO4GZFU7UPYlp?=
 =?us-ascii?Q?IxAIgWqf1WsFRKK7GOqt6VjRgCGq+3Fqp1WMfRvv5l0s6b6eaOCik8MPYzqi?=
 =?us-ascii?Q?I4RUiOXuSspCKgsWG8E/vZyBQFe9lv8eABJYgitN7DRGeeLicRMZNJkraZCn?=
 =?us-ascii?Q?T0OxxkLDMdkZS1v4R7kyNT6ZDXmzxW6pcP3zOdHgS/3XUW1honMh4uHmURSB?=
 =?us-ascii?Q?bpaIa0GZB0+EZjFVqLQzxrRYHAXiusF6B43QCIobNqfGhSifnNlA0s447Xck?=
 =?us-ascii?Q?4sy7+UFhEOevO0TP6D65tBs4J1m141jCb8AUdKEA6gBe8lzCZT/WdWczWqtd?=
 =?us-ascii?Q?cV/l7T9ghV9u6/pcBMVZNB7kUFenDG3S2+esYRwT4EwfbBWG2hTklEbHf1P+?=
 =?us-ascii?Q?lWQQOY1vZUoCYBhQ8UXcfMid9cYuNjrKOju1oLnleDhqVLjxTPpJLnQVNZO0?=
 =?us-ascii?Q?MW/+rglbUcVDlnz7IYAuVEBpch/AD/m+U8KvRfxfC6BBoT+ND5Dhqw8aWMVV?=
 =?us-ascii?Q?1ge8nlrvnMLDUSKwSIG6Q+DGpsjaZJ9564DwqGmdDhPRe/002B983V0bCaSu?=
 =?us-ascii?Q?Ym1pKZXuMrYICP+WMQIPBoqLjLgP88ntzFBnzbnsV3qxPrXrAij8aCEE6WsL?=
 =?us-ascii?Q?I4HS6Ppv0mvH0I+76sfq4ys6PD6C5BPoGtfepFKenOXlMO99BoM27Tzw6/wu?=
 =?us-ascii?Q?LYPTK1HSYgAtxEe3YT3taozeIs5XF3WcGc5auRJfIGMauL9J5nnrUM71gLPg?=
 =?us-ascii?Q?aqMYlsfyRg+2jMUR8606ijAg7tmBcyRAlKYXd1JbZRN8jzJFLa/89mBsvevK?=
 =?us-ascii?Q?Sdbs7NG9KCHcqp/BF9yO2Pr6+54niEnBKdxOrJs40QyzUyAWfSzBqIyMLiNn?=
 =?us-ascii?Q?pBgUa71hkpqB3IN2SHuLd/qG6TaSmMlBamjjzHwA5YiXu8a23cterRk9xuIS?=
 =?us-ascii?Q?czg4ZHFX3rB71wCUl1HHjYawRK6MsjUXV4eUP+/APoMT9g3eUtHDH8eMDZ0O?=
 =?us-ascii?Q?pk3LQ4Qqo+NJCvMfbj0MOEKgni1NWalXZYvaXFnrZ+YmEeR/ZtFpz9+Zq7Oz?=
 =?us-ascii?Q?8/q8eLYEtOY79mdVPVKYekPzFCI+q9JF2lP36pdh9b3JNZ+esWLymWtVmv2A?=
 =?us-ascii?Q?NE3tfC9i2zQoBbbvA9hKu5q7tgFeWmhfCx3QbXR3Zn6TJVGbgu670DgIiVwV?=
 =?us-ascii?Q?8KwfDpc0Mkn/mMF7GT1KaQ9JONwh/yf3YmNTGlH5oAwE6aXFxdo8CXIVsrmm?=
 =?us-ascii?Q?8kpsHneCF1FQu5ZuZ3APWQe6TXOGUecf1sB7v/Hhxv7rmQAOvdb+hxAILGw9?=
 =?us-ascii?Q?a5CEtWa/OWzF3du9SMHgEhkTWEDcK2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac21b89-53d4-4d3b-8157-08da47fc7df1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:19.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PAQkE8ZPn5tzPRPquZNoFLVv1xNnsd9zkaaBwGPrKmhgULu19uWUJ5m75w0DNYZN8MoFy9GcYIn6edQDj4OPHVW5gc01SKBprBAULrl31I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-GUID: jy1ErhQ04z4lTQxqVzK7vvvoIdNHbNrX
X-Proofpoint-ORIG-GUID: jy1ErhQ04z4lTQxqVzK7vvvoIdNHbNrX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86_FEATURE_MOVNT_SLOW denotes that clear_pages_movnti() is slower for
bulk page clearing (defined as LLC-sized or larger) than the standard
cached clear_page() idiom.

Microarchs where this is true would set this via check_movnt_quirks().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/amd.c          |  2 ++
 arch/x86/kernel/cpu/bugs.c         | 16 ++++++++++++++++
 arch/x86/kernel/cpu/cpu.h          |  2 ++
 arch/x86/kernel/cpu/intel.c        |  2 ++
 5 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 393f2bbb5e3a..824bdb1d0da1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -296,6 +296,7 @@
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
 #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
 #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
+#define X86_FEATURE_MOVNT_SLOW		(11*32+10) /* MOVNT is slow. (see check_movnt_quirks()) */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0c0b09796ced..a5fe1420388d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -891,6 +891,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (c->x86 >= 0x10)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
+	check_movnt_quirks(c);
+
 	/* get apicid instead of initial apic id from cpuid */
 	c->apicid = hard_smp_processor_id();
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d879a6c93609..16e293654d34 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -85,6 +85,22 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
  */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
+/*
+ * check_movnt_quirks() sets X86_FEATURE_MOVNT_SLOW for uarchs where
+ * clear_pages_movnti() is slower for bulk page clearing than the standard
+ * cached clear_page() idiom (typically rep-stosb/rep-stosq.)
+ *
+ * (Bulk clearing defined as LLC-sized or larger.)
+ *
+ * x86_64 only since clear_pages_movnti() is only defined there.
+ */
+void check_movnt_quirks(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_64
+
+#endif
+}
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 2a8e584fc991..f53f07bf706f 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -83,4 +83,6 @@ extern void update_srbds_msr(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
+void check_movnt_quirks(struct cpuinfo_x86 *c);
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..f0dc9b97dc8f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -701,6 +701,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 	if (c->x86 == 6)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+
+	check_movnt_quirks(c);
 #else
 	/*
 	 * Names for the Pentium II/Celeron processors
-- 
2.31.1

