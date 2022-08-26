Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753635A2D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbiHZRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiHZRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:37:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88665264
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:37:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGkWLB026688;
        Fri, 26 Aug 2022 17:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=SSI02Kvjz2DuO1lgXWrrogCUjF8aRiFXD+Uo5LMbfUs=;
 b=Kh79aQQ9181bPPV9rnnvYbvKTkDnDjQcBMn0e87uJSG9xIzE+AG8eRn5xPiPe0zRBU/w
 v38N1DeSMfr1o89QWox5CYVovO5iKomKWHQc2cAgoakRVYbd1ly0M3W+AkkF34lmK/hM
 l8TfMmAXl4nQCDLjjXYHRf68qfGBOGqcodli5gdwfCCrw51AImv1fcv9u1qBf47xpQFp
 KLzC58H+MqJgRPlgLvyavmdZyb/D2lw9GlibNy24Ux23Xgk4yQRIM4vzEB8UNMjAqPaI
 P5IBF/FX9RnMlkLmdlsVSxJzejQANAPMwa5mInQ3lRP7vtYDODK39L2nERkcLnmZniZH aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww7p2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGTqlj029855;
        Fri, 26 Aug 2022 17:37:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5r401b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYDeXKV7ZMO6vDRJNo8EeBINBiajWE3bzcpxX5wU9VCPM0r7f3zikHB24b3Ykdz8m2MfayCRldzsLCK2D0Oxj/X2iJ2Rp9X0v4rb7CJJ/mX73GyQPFU6zbf0SrCwiA9NXraAynfjTFagc50/JKZQpJ3D0MISXCWiPeh6ls8Zj3jU2UPn15jtELuVO7c/wq1oZcuIm3gXWOkFOKc7L+V148npjVIyCLeLB53jl5e4U3B+j7ybhmEmCdC8eVTBtGcXrNQGJlYt0ZR2lLy3eUKGb6Jirtio4bM4S7vO7TMXIXX/9obBoanJAKzWwCyoy5hakR4a6GmInuudWdM5AUhgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSI02Kvjz2DuO1lgXWrrogCUjF8aRiFXD+Uo5LMbfUs=;
 b=eWfO24DphHbpZPjlQj6YSUAY8FBZF/K7szKP6dquzbCiGaiGTehG1/AO8rBBFUx6LkFjp1o4oRkbebJPZoy5oSZ402GgIU/p7oIMy6NAFfBQiqhzbQiKiEoZF5gKVSg6EqhdU5mnIL7GieSIeuHFYFv/cF+G3rhAYmz7LP8MoSTcIa3wXAxkERRudYs+GPHyajFAYYhgG0ycwe5TRY6u4cxfthYW5SZ81BeLIGIvnp8nFZX8aR39JdPGVq8ykxU+Bd2FFzMsJgbMNcB8ra83v+AuF9mLBII9M8l5wYjOEEcPBAR31MUs1k/qaNh2XksAL+OQ1pohhuZuricnqzBBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSI02Kvjz2DuO1lgXWrrogCUjF8aRiFXD+Uo5LMbfUs=;
 b=OhqOeZeFNLuOmVXi2vRUb+OXgmKsLZz2lytwZ2JK7D5zjpoCp2JZco2ak/MjhKUvlV5l+vU9sIAzpQwzHPUIJvtECFXmnefQV8P/eUwXPfp2A38MYThwzJPBoOIld/hSfHp+ltsNTiRtpqvzXiYcsPu14o1N/rYHc0cHhmDya/Y=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 17:37:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:14 +0000
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
Subject: [PATCH v11 2/7] crash: prototype change for crash_prepare_elf64_headers
Date:   Fri, 26 Aug 2022 13:36:59 -0400
Message-Id: <20220826173704.1895-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c2d612-e870-492e-74bc-08da87899cde
X-MS-TrafficTypeDiagnostic: DM4PR10MB6231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5T89YZPZOq6LDhTritJe7WHU/3D8HbskqrtOrbQDgEhtK7mmpZP4vq4goEcVFq0MKimgZfdFrIalqextYl0A/g0XZGAS6AZGqatp0dwYg+z8n2YwN93SNOUtfzuZgZ8efGO5dc0OODN/SdItyyMYYlFy4PWjTdeo106Tm0+NS6ore+0wB8unRP9d39gfkXkxKqXNIONYHm4khpJOgZS9hzf9HErpfQO+d5xhb8Vs1JaRFJnHK+bnFIbGICdcsdLlBAmVWHT62CVHq65d8aUNLMRJ3jDyux2NCnHwsxTqRK8AcI94zAvGL+P8e48tWawc3p808GBm0NC/+WFgURdtYdxfa4gDJ7OxI8nD9/ql1TFYcrh8WYjspH6tAF9dwwW2iXhkjhIKY28Dqmop7pFN/xe77Qvq6HMYvdGo381WxRjzAmPo6FKShEVkN6t2RHgePethaM02aRdP0IzaOHtJfK629tAiSL0cgJT/JLS8DsH+tJrrmaYK4J9afAAqqlOwKv5VBYUguKzjTXL7tAUlotOaIfFYDsRjTmrTijxi1ayk/hxK/tJPlJnzQAjk5ncg7Hz8X6wiY/OUamP/KB/vA8Vvc+TlX57GOlwCDBw2Jcu1EgO5eKc8KYc/78DlB5wQm4gNBf62d5O5qD07/cehIJTszynD3L2UMnO+Y+VilgGA+5zMVI37djqkvQHCH7QcfigV/J74ai7Gw7SAR68bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(396003)(346002)(36756003)(5660300002)(86362001)(66476007)(2616005)(6666004)(316002)(4326008)(66556008)(66946007)(8676002)(8936002)(83380400001)(7416002)(2906002)(478600001)(38100700002)(6486002)(26005)(41300700001)(6512007)(107886003)(186003)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5khCiGiMoIzt5S8wLgnTKUOwKWV471WPRfVCjDRj/ksvcgEQVvYI4+/18XA?=
 =?us-ascii?Q?N5g7L/YKk8Fb9h2MyRuz6l2FCqiOBsa9ELusL92UnCqFFi4VOI2ZkEMwFD7k?=
 =?us-ascii?Q?7dl7A7r3JLp7zZxxVXVJ1TNCHwDk9CjmYJ82UyiUnZGtwLtsmIbKPoUjH4Wd?=
 =?us-ascii?Q?qIgfN1hEaMS5G/p9Egj8M2tS4JeiiArUOQHAezD4NZg4To73uZGopqrnQNVE?=
 =?us-ascii?Q?Rw3AGhZFH+HkrPNItQnkVTkRze1X+eRWJmtZHBcs60ILDbNX7ZCd9a5J/ipV?=
 =?us-ascii?Q?taZQQfR5Pwb11IvqjpwSnINpDFaCpxC49T7Ng6xl7qaU7SZfxqqPjmaUvDSf?=
 =?us-ascii?Q?xq2Z2VgObH4DV6PdgLnDbqCeF6zs2i+oUyVLzsYI35awzgTYUfg1vFrIWjwj?=
 =?us-ascii?Q?mXyMrPdlU7YPk7Cixh3JKwTAO6/WXjvQ9e7hTk0T7rwgCXOg2eEM0qBgY5HD?=
 =?us-ascii?Q?MpXEgcSVpVePwO7yY+1vepjtQhizShu7wuAjxVYZBKL9t7yrLRQ9zJJ5Uv+M?=
 =?us-ascii?Q?6+pyA/hqtq6ub7T2vmnqQIb+oVA7Mssdtr4VEsPDtDYrTp99KKP1ng7Q1Qup?=
 =?us-ascii?Q?rdUbb2ct74UWCEkY6XVv8YoSrhoDHcrAjk+UigHvcTbvcUmHoDCxnuD9Zo8t?=
 =?us-ascii?Q?PiEL/c/rvgpxTy0OU4y0avB/64EHwI72I3E3R4a2kXl8ulC+d9H17QVrfKnZ?=
 =?us-ascii?Q?BW+wbCiWQvfQuq1qMMYI57fBwNbEwe0z0055I44EhddEiwO1ZBCiUJG92DPl?=
 =?us-ascii?Q?OtCO7zsEbtMiziWAIc9cBfOnPMhNqfu31DrBdIo/he6StThRTykF2NPss2ja?=
 =?us-ascii?Q?d++fy2ZBel1DldyJ1+aEpLGJTfTLWmYTRiihWvEwbQj88U6e+xYSKfGzu3cv?=
 =?us-ascii?Q?P3+sOPh1Tlqybunth1siI7QiNJI81DUYgQJI7wksVpiFUwuhU8b/X0ZUQqNQ?=
 =?us-ascii?Q?XPA+Y0FxznHTa0XtgMxSn2gJwMZ4LeiVBizatx/461zhLbh7Jo3hvemJJSCk?=
 =?us-ascii?Q?sCu4ADzqJLck26lrp3Tm6wpNafjULDHSmodspxlRPHPCnTF5AFFIUws69KL4?=
 =?us-ascii?Q?8BBs2MbvOEw/rOW0oWWEs2b8joEK7QpWTkoHlp9JizOyzWtcYDrwXdkMtKq+?=
 =?us-ascii?Q?TzbddZX9JUHsQ9ZY/IJLEHOUiHJhNJIxtbWJeI2mkmXW5nRHO4XnxwdF0ti+?=
 =?us-ascii?Q?yg3MBPFHxh4/GEsQP0SsjQFWI+p+BKl8kKrHqHcgFfbqlQMJ78ChpIJPkk9g?=
 =?us-ascii?Q?yNsWe7z/pSTJyBD1csgqADFY3D5oojNkUh4UlS8T5o6pZdrEvNr9JVRd0tL5?=
 =?us-ascii?Q?Px0s16u5xE4QlyFiWouFauo0G3NcYGPF8R9SHc0orngc1alf2anScr9IXOwn?=
 =?us-ascii?Q?2wlJ3ORyAcYySSp7zJ6TT4HX80DPND4DhxxZwWYR65BB0x+KSA+pbk/A8LVZ?=
 =?us-ascii?Q?2F69D50b/WYrddFuKUb8V8xqyzmp0J/axLJAg7kKQQWHKoyauuz9frMkyx8F?=
 =?us-ascii?Q?fbFkKbM+urqLnOz5+t2hg5ZroxQguD8oiVlJV1MuQQFtkvSQrfx7Tdwi5vVh?=
 =?us-ascii?Q?w+gkFCH8LsKwEPfgy12o8XaIeExyCDixNj+BZMr4vemJ/7JeUAioSfUcvXfc?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c2d612-e870-492e-74bc-08da87899cde
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:14.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6OkQBM3/J77g4ITjoVwRfpOlPSdXaiqZYAgJJ7L26t4+p8GQ9LPvRv9WMk0quwQnGGa1yRG3Tw0QY6Alpag7Fgw81q+lRQ6JL5A6p0bRHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260070
X-Proofpoint-GUID: QB6vjJea_W6vRM4IpRELhIr1yYt-MpHC
X-Proofpoint-ORIG-GUID: QB6vjJea_W6vRM4IpRELhIr1yYt-MpHC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/riscv/kernel/elf_kexec.c          | 7 ++++---
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..7f5f8243928e 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 349a781cea0b..a0af9966a8f0 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -798,7 +798,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..ffde73228108 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -118,7 +118,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -140,7 +141,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -212,7 +213,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9ceb93c176a6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 13e6c4b58f07..4eefa631e0ae 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -253,8 +253,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8c8c82386e8d..0f8aa659cca4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -315,8 +315,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1

