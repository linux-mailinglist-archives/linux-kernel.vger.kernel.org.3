Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD5502C71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiDOPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354917AbiDOPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:19:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A5BD7E7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:16:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F9ZcpI031973;
        Fri, 15 Apr 2022 15:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FDIM6GQ1mYixA3xbWbdG/69vPIAMFa7tEV9HIsPENJs=;
 b=lQsI1LHFsFB+8KsSm/Qd7CyBBKls2ZLu2v6/nObwyCTiJzA1X2Gs6tt01NdU8TBxaEyh
 VEIQVREfAjuU+SFq1wSBVKor1JYwpDFgLU9fRNR97CIbjgWg2acmA2U+ikC2MPB6Bjfm
 Ralpchxc8u85AEEI6+/xOQnqcFMKT5Hpw2PYjh8cVvhmwoqXZiTm5hCCRcmkZjZl+7ql
 Q0Galm7uvkfzy95gMZs10emw3L1hpBKZEvmEgrtoHuU6vS4bMiccHU4T5ao246rSufsC
 7CnD0qLdaaHcvt6e1EvLNxgq3IapQJOLm7b+E3SvLN6G3+4ZsqdkUqsHrXrnkH9/r2mG 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdewe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFCQS3001034;
        Fri, 15 Apr 2022 15:16:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9mrs25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V52LE/jRpRF7Hh5p5O4dGHEbRGz8xidtksKkSP7Bj546l7Ey2x62KsW1oJyB71FNuP9EoHra+gKOrE6xhOuQsrWRi/8IjjWUUSDxjL2sq+QSp9vChXft8eaKMWQfhmznSU7G0LaogrfikILplClRu697OyOTqn7bsT7RfGEmxTYxbSLr2BZ6i/xWcR95MVgmwve01O4Sr1/z09yyKptDn1mC5aXaTk4//O+97t8BMlFyCjI9YWshN708akhE/MMisHwlwrAcKCQD+6ivMfw6QZPoWsPKRs+rmZLP6nIAptXfhwC+OtcOlcdZP3T1AUJW8QJwOYTZdnj3AE/EVJjY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDIM6GQ1mYixA3xbWbdG/69vPIAMFa7tEV9HIsPENJs=;
 b=Dn9LLt2/KyNHkjP8j9CLogscVfCJK6tvxiKlW2JytZR0yp40PD+j5JCx7aB4NfbzQeVyliBO3mBQMK/4avf7MBay8hbQawO+JPg7lmbQkOtkotIZl/Kf2MyHmurrwFcGCU4c9DaWULBhjFIGQmd7QnqU+xuoKsvcRghZAs9YDycXQF5iHTKSN26vSdcd3uMZl6tl78dK0UaXnivqtOjLwsvu8CDgnbG6vOq1GSn05HRxFdJ+N1jaSAt1EXzACe1mp+RxBg+Nwzbze5dqysYe5kGF4IjCy6NKuONCmCKNYkoQqX8nn2gpv6wwpr3B+GMUCrQ8jvNT8l1wp15jjC7Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDIM6GQ1mYixA3xbWbdG/69vPIAMFa7tEV9HIsPENJs=;
 b=g6uWL9EmoPnVMnDMsDDFCG1ymPN0OhYUzQbnxvXmtJet3hglfr1Bo7rY7cmCy/6fbi9fVCvjN3dywiFBA6xG3da0mmnT90QQDJJF5vwDH4iPt2OzP6hAAU3Lq1by1jWTF7G6gv+S0D5uyAJUZkyXUdQBFgFnM7QyqPd9bpAnsGc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 15:16:25 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:16:25 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 1/2] x86: Check return values from early_memremap calls
Date:   Fri, 15 Apr 2022 11:10:00 -0400
Message-Id: <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea248606-f093-4dd7-a338-08da1ef2e855
X-MS-TrafficTypeDiagnostic: PH7PR10MB5854:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5854579009C646A78406D7D9E6EE9@PH7PR10MB5854.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDktOKKRPn+u1E8AIQvSxy31mMV7np3995XvmGBvub/w442OltLnLvHnr1ZiY4QmJxEA2aYtHLBgc4RGvusCIqgYIaJAUa+OrFPLqw7Mt3BWrYW42S4uYXltkShSR5sQjenH3S7UkmzZXGSZabmz9NBHUCG/DtBEoNXi14E0CDXfxSAjaVmjfipms0cR368A7fFVroHUJtGNLr8RUjdDMm3NwGUxZq5aaYGtUL+0STwougXlGEvcqLlQCUdIwSYECvt5Eotv8YwUFRdyx/G2Zyyj3pL/EeMbf7iIWiCApvESDzOqbJ//GBPpcycNyo4vOxR4hYYyrjBr7brx2tca4sW2UlebKbrC+c4SexdwxxnYsBWa+v4MZd1TWc1NM1fHni9DVexHbJIE+/o22to8hpaaCZiNu3TsDldK/hSa67/S2mjwiXMlNsgeMNTWpznWjjiKeDDZ/CB+kkqZI+yNK0YOk+esW5Zg6M8WHVs3pU+JI3wkx02HM2S7Dx/zacyZFNnl2u8bIayZeO39CmXmJMvRlkgbSLDp/uuNvtQ0nTSHFSBxfP/7IV5RPGS83zqsMVEne57jugpL8Vdnztdp0YaTT5IDIZFd6uw1c6SSgXc5dPPytQmHWbjgs1hCts7vPOjkj7pr3I4FKzqSX/PA2YtssbTFoAxuTwcu43AK7+opI3Z+tLGcR6ADQV4Jv3dUtNmji2Jnie9LoqRlFm1Vkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(52116002)(7416002)(6666004)(8936002)(508600001)(44832011)(86362001)(38350700002)(38100700002)(6486002)(2906002)(83380400001)(26005)(6512007)(36756003)(316002)(186003)(4326008)(8676002)(66556008)(66946007)(66476007)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dioGG1Iw4pcVSUWnKTgB/gzkTjd8doMbpbc0ygl26UnFmN3URGoYkNJ2pxWo?=
 =?us-ascii?Q?hjLx6Njw4ykEHLXEvF+cMbAawfaXvz4duMD1IyTRzdv6ELLEcGC4174XLbHc?=
 =?us-ascii?Q?PQ4g2br/jgppchsIe4Ih/q30ry6KcQ+h4guEudH+u/bGCLeU+68TchYb+IwI?=
 =?us-ascii?Q?AhhoSU8jQQkZCUE3bptzVS2tjx2mq6s984e/MJPPkAfwI/+M7UapN92TKy7O?=
 =?us-ascii?Q?19xJs1h//a2FXwLI/2QuNllizvTnCKkPso0hOUiHVZE+nhb++pzRoZkszW4S?=
 =?us-ascii?Q?eMTseoRPTwPVjFYj8ULLl1XwkHW4xGde9X47OqytN4EDn1DQGIJrKp8AXM0H?=
 =?us-ascii?Q?jJ40LrkaXALOqvilaDuOvfqAEExCfCRVAiZv0OhLLVeJ7f81NC2ot3ssjBbx?=
 =?us-ascii?Q?AiqAUbvhIEi2Ge7u0PYxC8z2TC5bJ6IpDtGl9HKkx97qnsHYDWLAXGbRSIAc?=
 =?us-ascii?Q?qTW2jbqRdiyd0ddmZdZV9XEPI6R/Uj5VUBbc3tdJfcjn4QFEIPJ2HyWQ847l?=
 =?us-ascii?Q?dWD3yNjxmiMj361g9+8G7C+qNand+42e5ZqOVkmybodA2nFtoyvatmBymezG?=
 =?us-ascii?Q?dpq/iOEqYtrEYKUJdxUaiSGV6R52U0lrZBCYY5c7xGQOW54qSfHwN51gWhCt?=
 =?us-ascii?Q?OMr7RflKCMqG3n1ZSc8nwlfMOiA73ADhVlQxVFLKuAdnhaeH8fP4XiPGLhzO?=
 =?us-ascii?Q?s3XYFxigrMA05fTAwAApW0cAAKMPABT85fL6XzFgtfcyRjzg4e5MVEeuA+hl?=
 =?us-ascii?Q?ejW/Etnk15RBwVMePlShAh31ULC9t/iQMrU9/rLUdzX3zPNJHp7347vO/E7V?=
 =?us-ascii?Q?Km8ZH+OQRw4fhP4a8fj5OmRMpXupwPE/vV2ohF3J3e9xe/qIPsyST9LAbIhv?=
 =?us-ascii?Q?Niz5TrNRNkzs0Vs/oliwzAjIcM0mRISSWA9cyVsTAFSEXgySluksXu7gDxb9?=
 =?us-ascii?Q?Beb32I+s2qlZVMXcZ4nS9lp56ROgl+j7UJmqmVcWGTkg6Rhw05lZpyHN1xYf?=
 =?us-ascii?Q?Eebct+NKZFbheRiRcpPs6sI54TsTR/5DruWiUJaEVepMqdr9rrOBEj2tOI5B?=
 =?us-ascii?Q?0iZNK2DkmrGD7nFglUJ5knEGoUj5gWAfrcPQksYN7uOD82uX1EfqM7aPGG8n?=
 =?us-ascii?Q?EK0MN8dtYudAl7fBdP9soGToPDD2J0KY/Ona2liKXUDF+m0aiFWGkgVBILKF?=
 =?us-ascii?Q?0YIB447GBPaxYvJu7XgZbTiJv1pZj8Lhbq0wZ0HBHFzYdMPdvMNsMWxckIQh?=
 =?us-ascii?Q?+BZ9G/pY1SXXtyKNB4U8qGLuZV7M1piadB9QETAl646wyUd3zjWi35SX7hkq?=
 =?us-ascii?Q?t5RgCdKuY2eyOFlKtSVhN+iUgClZLZGfcX19GPh5+eC9BiTvtwSvLpZKNh9R?=
 =?us-ascii?Q?46k5cO585F3H4cvB+PjIOm0QRl+3/CXNVBaK0hY/nnuzaEtzZUE7aihKstvk?=
 =?us-ascii?Q?RcQ7Wu4Og1UWh0wHR6uxRBVh/qyB53QPlmDexiJ3naQqkRvDr99GyBBKU/xl?=
 =?us-ascii?Q?QcsmjZict1fyYQlOT8DCKwtVejzaNuXwuH4jD8j/5xVn/t1gEOLSxUPAkq8f?=
 =?us-ascii?Q?7wdOvL9YmIvUe29TI3RCuPh2ejUmjzT4q2BRStZTwvwDqNraPHyd9vww4qhy?=
 =?us-ascii?Q?GlM5NQlNYYaGjhWrlzZfPjMbJzBYE5qA2heBgww2AU+441kw9QzRgHwpC7Ff?=
 =?us-ascii?Q?eqe7/DEa3coNa9nldekv7irnX6dr6rRVwd7LtXX1k+ngAwwvj+nAu+HUEPFR?=
 =?us-ascii?Q?gZSQJ/p+3cHuY+e12tRgWhjAUx00jFQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea248606-f093-4dd7-a338-08da1ef2e855
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:16:25.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3vcLhMsLWXPSNV88tuR+eS7fL7xc3+0Wqn6IHDwgnqehoAemTLO7Z3dht5tqk9fJT8NHlmLfEbJIp6lAMLriI3Ix2QK4HeV9I70LvEst48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150090
X-Proofpoint-ORIG-GUID: VPZYzi9nMeX5QwHHXnsZMvwt44r0p5Y7
X-Proofpoint-GUID: VPZYzi9nMeX5QwHHXnsZMvwt44r0p5Y7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places where early_memremap is called
but the return pointer is not checked for NULL. The call
can result in a NULL being returned so the checks must
be added.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/devicetree.c | 10 ++++++++++
 arch/x86/kernel/e820.c       |  5 +++++
 arch/x86/kernel/jailhouse.c  |  6 ++++++
 arch/x86/kernel/mpparse.c    | 23 +++++++++++++++++++++++
 arch/x86/kernel/setup.c      |  5 +++++
 arch/x86/xen/enlighten_hvm.c |  2 ++
 arch/x86/xen/mmu_pv.c        |  8 ++++++++
 arch/x86/xen/setup.c         |  2 ++
 8 files changed, 61 insertions(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f2..ca23875 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -292,10 +292,20 @@ static void __init x86_flattree_get_config(void)
 	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
 	dt = early_memremap(initial_dtb, map_len);
+	if (!dt) {
+		pr_warn("devicetree: failed to memremap initial dtb\n");
+		return;
+	}
+
 	size = fdt_totalsize(dt);
 	if (map_len < size) {
 		early_memunmap(dt, map_len);
 		dt = early_memremap(initial_dtb, size);
+		if (!dt) {
+			pr_warn("devicetree: failed to memremap initial dtb\n");
+			return;
+		}
+
 		map_len = size;
 	}
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205..f90b883 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -728,6 +728,11 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 	struct setup_data *sdata;
 
 	sdata = early_memremap(phys_addr, data_len);
+	if (!sdata) {
+		pr_warn("e820: failed to memremap extended\n");
+		return;
+	}
+
 	entries = sdata->len / sizeof(*extmap);
 	extmap = (struct boot_e820_entry *)(sdata->data);
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 4eb8f2d..80db0c2 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -221,6 +221,9 @@ static void __init jailhouse_init_platform(void)
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));
+		if (!mapping)
+			panic("Jailhouse: failed to memremap setup_data header\n");
+
 		memcpy(&header, mapping, sizeof(header));
 		early_memunmap(mapping, sizeof(header));
 
@@ -241,6 +244,9 @@ static void __init jailhouse_init_platform(void)
 	setup_data_len = min_t(unsigned long, sizeof(setup_data),
 			       (unsigned long)header.len);
 	mapping = early_memremap(pa_data, setup_data_len);
+	if (!mapping)
+		panic("Jailhouse: failed to memremap setup_data\n");
+
 	memcpy(&setup_data, mapping, setup_data_len);
 	early_memunmap(mapping, setup_data_len);
 
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f..8bac042 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -424,6 +424,9 @@ static unsigned long __init get_mpc_size(unsigned long physptr)
 	unsigned long size;
 
 	mpc = early_memremap(physptr, PAGE_SIZE);
+	if (!mpc)
+		return 0;
+
 	size = mpc->length;
 	early_memunmap(mpc, PAGE_SIZE);
 	apic_printk(APIC_VERBOSE, "  mpc: %lx-%lx\n", physptr, physptr + size);
@@ -437,7 +440,16 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
 	unsigned long size;
 
 	size = get_mpc_size(mpf->physptr);
+	if (!size) {
+		pr_err("MPTABLE: error getting MP table size\n");
+		return -1;
+	}
+
 	mpc = early_memremap(mpf->physptr, size);
+	if (!mpc) {
+		pr_err("MPTABLE: error mapping MP table physptr\n");
+		return -1;
+	}
 
 	/*
 	 * Read the physical hardware table.  Anything here will
@@ -552,6 +564,7 @@ void __init default_get_smp_config(unsigned int early)
 
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
+	/* If get_mpc_size() is 0, memblock_reserve() will just do nothing */
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
 }
 
@@ -567,6 +580,11 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 
 	while (length > 0) {
 		bp = early_memremap(base, length);
+		if (!bp) {
+			pr_err("MPTABLE: error mapping SMP config\n");
+			return 0;
+		}
+
 		mpf = (struct mpf_intel *)bp;
 		if ((*bp == SMP_MAGIC_IDENT) &&
 		    (mpf->length == 1) &&
@@ -864,6 +882,11 @@ static int __init update_mp_table(void)
 		goto do_unmap_mpf;
 
 	size = get_mpc_size(mpf->physptr);
+	if (!size) {
+		pr_err("MPTABLE: error getting MP table size\n");
+		goto do_unmap_mpf;
+	}
+
 	mpc = early_memremap(mpf->physptr, size);
 	if (!mpc) {
 		pr_err("MPTABLE: mpc early_memremap() failed\n");
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c95b9ac..824e901 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -345,6 +345,11 @@ static void __init parse_setup_data(void)
 		u32 data_len, data_type;
 
 		data = early_memremap(pa_data, sizeof(*data));
+		if (!data) {
+			pr_warn("setup: failed to memremap in parse_setup_data\n");
+			return;
+		}
+
 		data_len = data->len + sizeof(struct setup_data);
 		data_type = data->type;
 		pa_next = data->next;
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 517a9d8..6182c5b 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -64,6 +64,8 @@ static void __init reserve_shared_info(void)
 
 	memblock_reserve(pa, PAGE_SIZE);
 	HYPERVISOR_shared_info = early_memremap(pa, PAGE_SIZE);
+	if (!HYPERVISOR_shared_info)
+		panic("xen: failed to memmap hypervisor shared page: 0x%llx\n", pa);
 }
 
 static void __init xen_hvm_init_mem_mapping(void)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 0035486..2aff5c6 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1823,6 +1823,8 @@ static unsigned long __init xen_read_phys_ulong(phys_addr_t addr)
 	unsigned long val;
 
 	vaddr = early_memremap_ro(addr, sizeof(val));
+	if (!vaddr)
+		panic("xen: failed to memmap physical address: 0x%llx\n", addr);
 	val = *vaddr;
 	early_memunmap(vaddr, sizeof(val));
 	return val;
@@ -1918,14 +1920,20 @@ void __init xen_relocate_p2m(void)
 	new_p2m = (unsigned long *)(2 * PGDIR_SIZE);
 	for (idx_pud = 0; idx_pud < n_pud; idx_pud++) {
 		pud = early_memremap(pud_phys, PAGE_SIZE);
+		if (!pud)
+			panic("xen: failed to memmap PUD physical address: 0x%llx\n", pud_phys);
 		clear_page(pud);
 		for (idx_pmd = 0; idx_pmd < min(n_pmd, PTRS_PER_PUD);
 				idx_pmd++) {
 			pmd = early_memremap(pmd_phys, PAGE_SIZE);
+			if (!pmd)
+				panic("xen: failed to memmap PMD physical address: 0x%llx\n", pmd_phys);
 			clear_page(pmd);
 			for (idx_pt = 0; idx_pt < min(n_pt, PTRS_PER_PMD);
 					idx_pt++) {
 				pt = early_memremap(pt_phys, PAGE_SIZE);
+				if (!pt)
+					panic("xen: failed to memmap PT physical address: 0x%llx\n", pt_phys);
 				clear_page(pt);
 				for (idx_pte = 0;
 				     idx_pte < min(n_pte, PTRS_PER_PTE);
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 81aa46f..5e74496 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -685,6 +685,8 @@ static void __init xen_phys_memcpy(phys_addr_t dest, phys_addr_t src,
 		len = min(dest_len, src_len);
 		to = early_memremap(dest - dest_off, dest_len + dest_off);
 		from = early_memremap(src - src_off, src_len + src_off);
+		if (!to || !from)
+			panic("xen: failed to memmap for physical address memcpy\n");
 		memcpy(to, from, len);
 		early_memunmap(to, dest_len + dest_off);
 		early_memunmap(from, src_len + src_off);
-- 
1.8.3.1

