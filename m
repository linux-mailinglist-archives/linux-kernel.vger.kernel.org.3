Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6F5A2D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbiHZRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344520AbiHZRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:37:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882398B2D7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:37:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGVgbS024529;
        Fri, 26 Aug 2022 17:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=K4E02gUt+RcnHfq5+5ZVZjOsIalpNdiRx7DGN+WSaoM=;
 b=Eq4L6izFDb7kS5RTmbaxZkDd63DlEUy7wNtg1mA+8WyO6bXqvNgf3vmVld6qq4lZJk4H
 bGfD1T0FbQ/Q5OMHkUIS91Z3tRkdzxq4v1fEg3zvBIZOurEZSj+6jecq6+7aao68DcsX
 4K9/V+omt/jKJIetKKOtnL+GmsuBdvX+w30ht3Ml3CwjFq++DTYbzTPAkOzeqBewKQI2
 tsPAXjB4C9u923uiUBQ/U9xYQFIUfAZIgNjdlrIudkhI4lGMuIkDDzXtb6ZeRsE3Nqdt
 OVqHWpFiWEYVdrx/HoUcbIjxavmlFLVDVChVlRmomcDHFIKe9dDlz6CH+UbfX1fUcGWR gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvqxvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGm3Xx036237;
        Fri, 26 Aug 2022 17:37:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6pndx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOCzWgWbZqyukFfxrR2By708QbgUn+395vzAEhNAqvyQwyou8KUGQ5Qtkw2vo/ILAP79Gx8urRYivRkGNZqwFdzh9uTqgh7vmgZ23XE0nC2frziSNSp8eti/EdsMCk3iM9UcaPqQgh0I72J6Ia7SngEscoDzytv+Arp2LX5JjHtOIdRN7X9plm2oG+DIhZucEJpAsWtsNtTV21JXOsnsScht2uvYzPiLSznbf1986g4miIxiGtvVI0EtVZvPjLuFhgkBWVzyyBf9Cv5kZ2jwIldaxJdWHx6cEjolfTrE01gjiwiF+ypDRp2TbvsaJjaJvT7NaSdzKlnrm2ZEU8MzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4E02gUt+RcnHfq5+5ZVZjOsIalpNdiRx7DGN+WSaoM=;
 b=E3VcfNi9T0ITp+x0eV/MpGd1hL+IFJtJYA/TjcjKAuPHVFbhnzxyIBDHlNmgo1qx3u56qbzmAviUwJ92QJ1v82QjdvbLSeVIfbWJRy9Hy+Y7l9NJ3foc5pv1CzheiWrQFsh843meoTdc+aF2g34lz/yn0GYyJY5HATW6zOx6BSLzo+hdoGiYeU/ME5TD9S44ZyLcbFAzIuJskRbnbDcDq5eGO99rI2VoIkw3K+HEtmCu5e4lmfrdLIknoDhsOdwwvchhmCBxB8K1cWelRpKx5NWJ3axC+UGdbNcZ7ux8oBr6HmQ1flUcfO05VqmDC3zPKRd9utwJDvrPrMCkA9ivkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4E02gUt+RcnHfq5+5ZVZjOsIalpNdiRx7DGN+WSaoM=;
 b=OYseFer6uWlQ3tVfbNCTeM9UbOvKGrUkIepo5XYzuTp0OZMl8A30M/iGzY3IBd885AWlkykpFNcI7eacBhIF9yUtaw9RWYKsk16zeAzreIPrk4TOnXgLVpXy2faZ3ljJl5C8z6Jtd+vX0QmP5AoAp76eBT2NEF4Y99DQ4wkYaqI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3518.namprd10.prod.outlook.com (2603:10b6:208:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 17:37:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:11 +0000
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
Subject: [PATCH v11 1/7] crash: move crash_prepare_elf64_headers
Date:   Fri, 26 Aug 2022 13:36:58 -0400
Message-Id: <20220826173704.1895-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb55ca67-2d7b-4876-eac6-08da87899b4f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3518:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hc5OOFYqX76ZD73Z0zo+WdBIeC101fpxIhdfwhigWXI5Z+W7ngW2gRTICytWn8NCHawuGMQUq9od9eXbbTrFzTsTboAT9dOgcTzf6OOaPNyv45SBCxJa2BLmumf+T8FAZ/rBeTYDrpo8+TARX7pfQVvK/HK8gF23O9jTxPfNAKq2OaWBx84pop3VEnL/XI38gPKGnPRVQljEK+FxgA7zxRDRueDmAZGp0fB09Ee+zdZxwWMNCeW4RXecQyoqnWadihKOclO4258VDPkr+BLsrBZ9cntRdeyt8xjNgS9FsP35iFKuIwYHnfblIsWbCW751YeEO/eaywq5Y/gWBwlP3pDhHfTyJ6c5QZIgs0WNyGlq3g2rfjptUd8Aj7y9czRlYDkBFhbbK0h3N2QtB4R1+bx5apFf5TrrgNPHXCRdaa8v3DtySo7givd4Q6bRVuDa5LkeNarUTeS4sycW+fYqDqw7biki8fwHwwKk14NzQ3WiWdpuq7Hffu7IREriJ8KHsR4pLdnhzVLgHAFhF6MBtjfe3P53Ic+eULX1e0Pc6AIQsOt4b40Snp49XaGZVzB7UvlMFzypWOktvEnU3jAJiq9naiZZtBKLO+ztfJlE1FfNTR+6xAOjCWBR08Ap6mofrBKdPeK/nKYty2xHhzlcrZfx/hgEr8mBOxtEwGmkvzjKN6obkFAaAUQP8wu9atY0nB2H/1UNUB7WaVWW0YvQ1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(2616005)(83380400001)(186003)(1076003)(66476007)(107886003)(316002)(66556008)(478600001)(66946007)(5660300002)(6506007)(26005)(6666004)(6512007)(41300700001)(4326008)(8676002)(6486002)(36756003)(38100700002)(7416002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHWVc8TJcmnYK23NqUFc0HJlNoQ6J6Cf5D12GXD39CGyPe/kbFyvgeatY69T?=
 =?us-ascii?Q?jeIiHkY6DTQxouMoevv8cWdr78v5cwheeQE0Izs262Dagy10V855scs7UfO5?=
 =?us-ascii?Q?njOc7ZHTTIpBaeRAEXt7YV+iToXQ+a/oNN3GZ11RF3s+idjViTMNmsJNaOz0?=
 =?us-ascii?Q?hlQuxMc8BTXaQHvprX5sIUDwc5lWMB5yXLdmZ+965dWDSImpzuXPJJ7quNJp?=
 =?us-ascii?Q?wVBmIcxuIrSdgLLlI+rM78MteiwsD6EjpCCz437m6WRjhfmImL+f1PJOzUm9?=
 =?us-ascii?Q?SsFc0X55yiufs/ZU+sSII24PTdq2xpER8cQAgIY4zq/ClIeocKESdg/xpJBk?=
 =?us-ascii?Q?QLBpMi0T/KPpY4vbb8slxk2TzcxonzFY8RhyQBMeJw8Ox4F39KZXf3ZeAoRy?=
 =?us-ascii?Q?GVzTs6N+8AKvpYocTCo5zdvzcQGCtStReehloG05kyRuwWbs8q1eNshssoRs?=
 =?us-ascii?Q?E11j4eVOwPnYrhfKYFcsRNJFT+ZOtmGkX+V/LqwLYcb17ztYfpNmQxho/2UJ?=
 =?us-ascii?Q?AEw5d14OgLSW2qBG2KuXS7r3gl1BNSTPc11senvp8y96TLADMMq1BnXmrDqe?=
 =?us-ascii?Q?n0rxMTrUzG6KQgWMDxuIW2O/m27Y5TQM3LjfO8vXhnL6cGPm/A7vMCEVdASs?=
 =?us-ascii?Q?p04K0vLOcvuKKSYqbxCq4GPLE/GO4h8z8PcTEudVX0WOE8ZG94fmkk4Zn1V5?=
 =?us-ascii?Q?YIRXXGtOmYOawEVYPqDPmWcaZPZri7btogJUvfibthwAoe4D/EHyRN9MWM3E?=
 =?us-ascii?Q?h+pqTNwX1MykA8o8fsAO/NRKGqLRlH1K2Ug6ANeOj2riCwhq49L+p2MD9aPA?=
 =?us-ascii?Q?UZojL1noD5PcjENTlRO2RW7Ke8oilpuOCHXzcYXpgTHfYD7wFvzvVJofczA8?=
 =?us-ascii?Q?lONCizomwLIysA3rDXDOcFqBnkeS2i0XGHDsdOnj4A+k0apoJlb59eurGVy6?=
 =?us-ascii?Q?dJFh7KUly3bFECjnOFvXzXz8uQQP/mmXx8UZzwmjBBb2aTySrnL9arBxUQm9?=
 =?us-ascii?Q?T3W5TTJpVdcw862I2PEHyDyEKTwFp/mWlCDInLjjP3NWc6RZ+ngWniHS6340?=
 =?us-ascii?Q?SfjpHfl2cz/ga1eZKUE/PVsLmDaJ6d9Fbe/nhVYEqJbhhYAslpVcvtDKFIEZ?=
 =?us-ascii?Q?Ropopp+AUgl7FX83aglL87KgEcNsenQK5y9BTA5GSxoFTE+C5mvpx4OKRrrV?=
 =?us-ascii?Q?Z/ReuXhna9L83KpAa8OGI+urpO1bhWQYRpC7vHBRcHgdp92BjKOYOr3jf84p?=
 =?us-ascii?Q?EzNX3AXeFjGhfes20GjQ6ofXeAxaobpz1UD2YIaQNBR4kQrT04GQ5P9/fJ9T?=
 =?us-ascii?Q?9rwMFdoYiQ+EUlIXC79dtxR++bnNrlP2HPyA2etEm63nxSQSmGisbcYZL70F?=
 =?us-ascii?Q?RfPrhU9/WFb37cUsaMvfy6L1WCQLC95TLiVteqfLMjiRtnCMUaZDBj1skH54?=
 =?us-ascii?Q?vn/zEQO3kQAPu3lfsBjRLpr/9GMbcYd9+WpmtYBR9ZcarSWXmDp0HX0jT/SN?=
 =?us-ascii?Q?lnGOcSZBrDvmnp2NybVPMy1kMAiRHo/QBBYi3xrdAtq5QwX6VdpvZaNmTkS9?=
 =?us-ascii?Q?24r1U0f/z4U5VgahIOO8usqng7PPBoJz7fc7WtBhL6k6S81NegeiNp6ZNiMS?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb55ca67-2d7b-4876-eac6-08da87899b4f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:11.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql5XhadvG9TGtqNTtO4jIUqz+gBWnmXpQG/h7tivHtBR5gUgshsMJuYmJ2p2kQ7GfIIfvZ96pJVC5ElsvB7JXh/FvQo+LPeDZ8UE6T6xqV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: TYWacUkUzwl7SVHSgjFeZmXxJQwMh3HV
X-Proofpoint-GUID: TYWacUkUzwl7SVHSgjFeZmXxJQwMh3HV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load and kexec_load paths. As
such, need to move this function out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c |  99 -------------------------------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 07b26df453a9..8c8c82386e8d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1d546dc97c50..8017eeb43036 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	mem->nr_ranges++;
 	return 0;
 }
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

