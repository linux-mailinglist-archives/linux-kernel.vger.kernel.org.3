Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E857D328
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiGUSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGUSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C418C74D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIEmJM025437;
        Thu, 21 Jul 2022 18:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/JvK+SdTxihqtBTQFphlWFKn0sxNjACbR/lXt8fOHbU=;
 b=1Y2Sn1dlUBI4SHbjCKLZ4Hg2Z3j5pyxt+Xuqtoi6d8muEq0pJZhJooi2auVB6uThi5Wb
 ULAMKZKcBzTbng08NhWhACnK56l4ULMeCPhHekRfe4SX4PRTz4T9tYinbDJmcU52VTt9
 orphZ9nzV4xiRsmefGmBCbpmWWzLdfcCDA3CuaTy4izMHhdO2DpT5kgJuBYJ7QR0g2Lo
 G5a8OEOam7FCXFsGR2rHVJaOwoH2X0kOV9qU8JYkHKkY/8PFOfMsB2cfyKy63NoveksH
 goTP8PAOphP+rrq7DUaLwR//JR2BJrPGDek2OPtl/upzr9x44LtgaC2xcVHljZyz38a5 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtndyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LH23f7039182;
        Thu, 21 Jul 2022 18:18:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k70xdh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX2MBOOcGX1M/63C0EDQBnCK+f4Fi3aj6CSnD5xe2gheFw9TeHcz17qsYwH/qeyuwCJpsd5GWCjceKipeV2IgvcQLX0cyOQxrhUVldKj1Fjcj9cJp5PFx1jOE8Njh3OcGmCHYyJ4J/qukIGn/lGb9uFX+Y+GugWq9ICASYfd08dqq8Vr4iY/gZE6m/4iJ04csKvlix8T6jFxPKCK0O/zqLZ84OdgXt4U2zv8CH1t696FJ4krhzIGqo0tRDiYW6QZhwXnq42PXCM9XfsZbcj/O/dPNY6IR+hcM280d5UHDU8mN0ojw5MVLUfg4eXZeQJCLjuRCS6Y/nBOUuAjhHo/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JvK+SdTxihqtBTQFphlWFKn0sxNjACbR/lXt8fOHbU=;
 b=CepQ2ATKo/bnnLRYlVLtw8tz54s9OyRqBnHHFRvaXRtEjEPDqxy1m0N8zIoXzr3w/+oJMuESscA2cB8m9fhVzXrD40uIADZPA/CcebJwdmnyZZhTcw6j+Ay5cZA/nZ8vjF6rDzQYodRcVaulgMo3XYZh3Uivmu+6ZEChiYmX9cKERd8W9nmsqJ2j1nvuoZBuwIeOgezqUCYi2hGmU5kzOZIDkHeQ7UzyaM7eaVW/oPrPuCWQubAt+yQZufQFndl7LV8CYJ4N9FQcnNKsyRj6PsJgZPYpSlDP1Uii6u2aey+oPC1CAf3igJSZ3wuoah05HNZ3knaMParrg2jXjnegwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JvK+SdTxihqtBTQFphlWFKn0sxNjACbR/lXt8fOHbU=;
 b=M2sls0KYaR2CEgV0rqtaUGEc2mPrcOaKEmslbDQFOeLRNcNezhMnvuw7vupsSbmvp7J9TwPRyYofGCG5awPIRqSl1k2XX3NudrJI4X5zBmxywu+4EjOZaoDtQ5pi4tByUs5uFtQVj08JfOVelcCV+yxWqyg56yOfxbApbmtsM4s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 18:18:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:11 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Date:   Thu, 21 Jul 2022 14:17:40 -0400
Message-Id: <20220721181747.1640-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cb171d-e8db-4590-8b62-08da6b455ea5
X-MS-TrafficTypeDiagnostic: CH0PR10MB4890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1dALzPSkhsfSbKZEBxXnuhJqXD/EvKTif1a8gA/v59n2leAFlNBQp8PHDOY8DHfMQKyxzcJ2akHA4AxP8djjkmaQsje6T/9KylmWLOyVVJ/yQWb2NXJczS1jCACpE0o2W/JNz+XspQ0bD+deu7eWEc1EObeuk/5V4pHFeFvCWPBMcE8i78rrAEELOX+fSYHi4ML2MDUhHcB/s7snOTbcrAtSI6jj1lt3XWG3vRUa40gZCUMhB2egEd7rkbyGCLmUmP7LjrPOR9J9rOBrh5vP9Z2FyiCIzGzr8pQ5s6zf/EJ2i6gIa1l3UaPouRBEmulNgJE9JAtGzYKgFO2k5m5Q1N6tBpKGLB72J6lnaOmAud/y7M0rEHzSsXfpEikDheFPTwNiJ63ujHfQpYKlGvkgO9vBCWk42GLoWWDx32hFS9wB7FLWA8JikiofN3Q1N/J4A6pmR62AO/qV2YgCxYpKMzBmf8Zyjjv9yX76iPUErVIMEqPhkBG859kgmFDLN3Rb1+mZKWZkaOmsYeLa+DL03jPhRN+14fK3rB2MApBDznG2/GWNNa7eNPIbR6z3SpiZOS5kl4DSt2oougWwG6mmbslVPstZzFQZ+xlrfR2sEbsnsQNcblQniFW9UYrqBC+svWc9H//f+oEMtafMWZyaD2pM/9HTVwE2CLzK0KyTzdFIQmpoQhxZRFWx9TCAXIYdt7Si/7D3ECp3p0kAUjNnV8MGz/QhvK3EYdse5YUYOXZGLJ+tGi64HFVRXnCsfx4Zap6ZK9YuNlp2LBP+Z3xmZK41yPVfZJIomOvUTD2p1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39860400002)(346002)(38350700002)(6512007)(316002)(8676002)(38100700002)(66556008)(66476007)(66946007)(4326008)(6486002)(41300700001)(1076003)(2906002)(52116002)(86362001)(478600001)(6666004)(83380400001)(7416002)(107886003)(186003)(8936002)(26005)(6506007)(5660300002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mbeLSbBX8vqesed9hxgOPqs439KA+CBRPDjHUQgLeTiSJMxyCg6cezJ2MwH1?=
 =?us-ascii?Q?kEc3UOduN+xq49fobQExBTv48RSV2HHOKfPyNjxAnYD6juLa3Hy3W6JGF3Fu?=
 =?us-ascii?Q?Q4irpmX4FQ2VAA0K3J7KkcPsqUt2EJ9cYfX8HJtUoeNPdyM8Ik5sWaAtyRtn?=
 =?us-ascii?Q?llnZIgPo+1PiPkCf2hoY5d3xwA8fHsEH3IksMXhw5568ioISDr7ONHPvyloI?=
 =?us-ascii?Q?GOfhKWwrcJgldFOFGyksQRX+GVXD6k3xoRmDY9mI9q5uVunInmZl8J7nQ8Vq?=
 =?us-ascii?Q?K35vLT6LXuKBkKT3gQERMoXO51+obSIm+3N13c0tJu0FfrtwBVPxF1r3uMfW?=
 =?us-ascii?Q?EmgnfAjilJXNZdyyCfpKE3aXetZ3N9VpBnbfm7q1TsQDKjg9p41qAfyYUEEy?=
 =?us-ascii?Q?2BwNXoBAIG/k8Gn+QtnjPzFfnRGWhTlXFrKtM72o1oaAjOyyA4eYJjHSUXV4?=
 =?us-ascii?Q?HwE7hcDfWLLzRmOusiQxduhCzlQheHEMdIW4rO4b+RQTqtuxkuZfPRcvHrBV?=
 =?us-ascii?Q?uQWamqQ2yFp31hX4qtCaeq4HSZnFxzjxugkx/OfGo1J9e3xs4RXY3DmDRa1M?=
 =?us-ascii?Q?kvLsNFTHAtsgpXw2ym0S2GHjDaYG2MUY9q3TOhayf7M2xUjOKvdgyIGK1JGi?=
 =?us-ascii?Q?uE8joqDFb/MaVVkZY31q6sHEDsYVd8DIYSWQoSngvIfUzuTdY9SZVT0Nlwmb?=
 =?us-ascii?Q?ehLs8CKKQmlLi7gJtLHpZ45mbJBuDmxKn0IlvYE0Lp914je6hg+wUI6HEd0q?=
 =?us-ascii?Q?0sbVFLvHSBrqBC4AKG6KkepDcCRPdh3XmTXD1t5YyKpjYm2ZntoAUYU36GcN?=
 =?us-ascii?Q?bKxXR0DUDAbYhp6FfoYyh16lcKF+cvuFjj4SUiP4ZRoMGmEUNvIJItxvcqeR?=
 =?us-ascii?Q?uNwcy6utu+98jLhoAazlyJr5aLzR84nYQZbhzwGk8F/pmT4JEw8KmCpOb3C9?=
 =?us-ascii?Q?OikqmwoL1ToWetpEQoeO2nbVGC5/mp4+AIlfVhPsbS5mb/qclMDF7+y+wZgs?=
 =?us-ascii?Q?mMwTreJ8uo4AbPbPG4wbnXNiMxxbyV5gsnmT+GZE4V9mvHWzK2wQtGO6Rlf1?=
 =?us-ascii?Q?6Wwoes1zA0qMxXG9SsI0iR/fr+aVja/F+BtjwPAKLZgH8ukIB99rBpBu5uOf?=
 =?us-ascii?Q?J+ymoz3YpV/cejDeOr9f3M2x5Jy/decAgGsIsG522JhHDYmXpW4pyeCLV+FO?=
 =?us-ascii?Q?CDIieEpoQPZaBOUrHe9VtN9qdOTdzHaOERDBwCuXQYS6fuoU62zawAZiyGKT?=
 =?us-ascii?Q?fICj31yfK5+OtMSCj7RNKidAcV8v6hLrx3txiokHiOMhAXEybnLnCCjJW+b6?=
 =?us-ascii?Q?wVufR2hq7RKTYyHPk6m+A7nAK5qbIVXEcMWh+ugQ/SKNVmXuBBOqPh5+hQIV?=
 =?us-ascii?Q?BZ0saabj/LI1MdZkBYAMZQtQIt91KaIFtK1IpedIAg6YqcrKjPrpHC0tYkmu?=
 =?us-ascii?Q?kTaAXgj5QLHTzCqJKzrAkq6aQcnQyF9Rom/FpWbLyeZZqjUFTX6W9+PtIoiM?=
 =?us-ascii?Q?TD1qQWDQAQBelyuzfr7ELBPxXy3nI6FiRIigyJo3+VdIxIMs0agEvb7ulUhu?=
 =?us-ascii?Q?QaKhP3VVWnldJkVSA07KlZKgmSOvahzHBs6pMA3NlUsKGxMCoNgkhzYCLK0v?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cb171d-e8db-4590-8b62-08da6b455ea5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:11.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQmNzffypYufgaNT1Bu/XMogtxXq1CKdKX3SxwzJHHIKQKdCOnx94YuqpMM1SB/mV2dG4uNgGtlxVloWo0yzjT7QfOl2DpBCGH74yEm3sPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=896 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210074
X-Proofpoint-GUID: tZHN2NTcgqb57tRsoOwO23ootZoL3KV0
X-Proofpoint-ORIG-GUID: tZHN2NTcgqb57tRsoOwO23ootZoL3KV0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of __weak is being eliminated within kexec sources.
The technique uses macros mapped onto inline functions in
order to replace __weak.

This patchset was using __weak and so in order to replace
__weak, this patch introduces arch/*/asm/crash.h, patterned
after how kexec is moving away from __weak and to the macro
definitions.

No functionality changed, yet.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/arm/include/asm/crash.h     | 5 +++++
 arch/arm64/include/asm/crash.h   | 5 +++++
 arch/ia64/include/asm/crash.h    | 5 +++++
 arch/m68k/include/asm/crash.h    | 5 +++++
 arch/mips/include/asm/crash.h    | 5 +++++
 arch/parisc/include/asm/crash.h  | 5 +++++
 arch/powerpc/include/asm/crash.h | 5 +++++
 arch/riscv/include/asm/crash.h   | 5 +++++
 arch/s390/include/asm/crash.h    | 5 +++++
 arch/sh/include/asm/crash.h      | 5 +++++
 include/linux/crash_core.h       | 2 ++
 11 files changed, 52 insertions(+)
 create mode 100644 arch/arm/include/asm/crash.h
 create mode 100644 arch/arm64/include/asm/crash.h
 create mode 100644 arch/ia64/include/asm/crash.h
 create mode 100644 arch/m68k/include/asm/crash.h
 create mode 100644 arch/mips/include/asm/crash.h
 create mode 100644 arch/parisc/include/asm/crash.h
 create mode 100644 arch/powerpc/include/asm/crash.h
 create mode 100644 arch/riscv/include/asm/crash.h
 create mode 100644 arch/s390/include/asm/crash.h
 create mode 100644 arch/sh/include/asm/crash.h

diff --git a/arch/arm/include/asm/crash.h b/arch/arm/include/asm/crash.h
new file mode 100644
index 000000000000..385646957d60
--- /dev/null
+++ b/arch/arm/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_CRASH_H
+#define _ASM_ARM_CRASH_H
+
+#endif /* _ASM_ARM_CRASH_H */
diff --git a/arch/arm64/include/asm/crash.h b/arch/arm64/include/asm/crash.h
new file mode 100644
index 000000000000..ec8870c1ea49
--- /dev/null
+++ b/arch/arm64/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_CRASH_H
+#define _ASM_ARM64_CRASH_H
+
+#endif /* _ASM_ARM64_CRASH_H */
diff --git a/arch/ia64/include/asm/crash.h b/arch/ia64/include/asm/crash.h
new file mode 100644
index 000000000000..02a457cccda3
--- /dev/null
+++ b/arch/ia64/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_IA64_CRASH_H
+#define _ASM_IA64_CRASH_H
+
+#endif /* _ASM_IA64_CRASH_H */
diff --git a/arch/m68k/include/asm/crash.h b/arch/m68k/include/asm/crash.h
new file mode 100644
index 000000000000..ba6e412a1267
--- /dev/null
+++ b/arch/m68k/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_M68K_CRASH_H
+#define _ASM_M68K_CRASH_H
+
+#endif /* _ASM_M68K_CRASH_H */
diff --git a/arch/mips/include/asm/crash.h b/arch/mips/include/asm/crash.h
new file mode 100644
index 000000000000..35872522c574
--- /dev/null
+++ b/arch/mips/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_MIPS_CRASH_H
+#define _ASM_MIPS_CRASH_H
+
+#endif /* _ASM_MIPS_CRASH_H */
diff --git a/arch/parisc/include/asm/crash.h b/arch/parisc/include/asm/crash.h
new file mode 100644
index 000000000000..96833b727179
--- /dev/null
+++ b/arch/parisc/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_PARISC_CRASH_H
+#define _ASM_PARISC_CRASH_H
+
+#endif /* _ASM_PARISC_CRASH_H */
diff --git a/arch/powerpc/include/asm/crash.h b/arch/powerpc/include/asm/crash.h
new file mode 100644
index 000000000000..40ce71e56ac1
--- /dev/null
+++ b/arch/powerpc/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_CRASH_H
+#define _ASM_POWERPC_CRASH_H
+
+#endif /* _ASM_POWERPC_CRASH_H */
diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
new file mode 100644
index 000000000000..24f3aea99707
--- /dev/null
+++ b/arch/riscv/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_CRASH_H
+#define _ASM_RISCV_CRASH_H
+
+#endif /* _ASM_RISCV_CRASH_H */
diff --git a/arch/s390/include/asm/crash.h b/arch/s390/include/asm/crash.h
new file mode 100644
index 000000000000..0db16ad4c75f
--- /dev/null
+++ b/arch/s390/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_CRASH_H
+#define _ASM_S390_CRASH_H
+
+#endif /* _ASM_S390_CRASH_H */
diff --git a/arch/sh/include/asm/crash.h b/arch/sh/include/asm/crash.h
new file mode 100644
index 000000000000..f54e12f88cae
--- /dev/null
+++ b/arch/sh/include/asm/crash.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_SH_CRASH_H
+#define _ASM_SH_CRASH_H
+
+#endif /* _ASM_SH_CRASH_H */
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..cb0f1916fbf5 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -6,6 +6,8 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
+#include <asm/crash.h>
+
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
-- 
2.31.1

