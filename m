Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6AA54A236
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiFMWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiFMWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:43:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32C3122B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:43:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJXYDl025660;
        Mon, 13 Jun 2022 22:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=G0OcVmMSaT2dR+Q1YyNrKHdWYIMKTxgfk8cCM8JGyz0=;
 b=WdJokZxNz/ztkwUuG2Vkk+n+s5ZPaNMhV3AWIJgLrkIEO5fOH9kgnt3vURbwWfLN0Qmw
 OkvgxT1AtVg2HapHm/HeIZdDB88ZPTNoC4LTm4bNQFdKweAfGvjQIyrUnZxy+vapz9d/
 fIwk/+j0hXiDMJDm0I9AZlBXvtQ3B2XS8F+lczb9NwwwRGjk4czvlntK3JFuaD+MUcRa
 KoZ5qjmwlbW40XdxNq5Pmr9jVpDxcGXivbrp/KUMz2/qL24yjFLEWkYDXK7LprQ94ha2
 gFvd1EiSlxMPva1Ert31KHwINXs/WHHLu73jsulkzB8QVwnTaeAZcbWggbdy2dbsydad nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9c8ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMehql014918;
        Mon, 13 Jun 2022 22:43:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r47h-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEFBU/KQtBq6mXtPXbCk2i7JRvuAENd0EgVTThKXg9Qt5TSXWMIwFAPTW4V1IoyPW9m337cjd7kEnP2BUiBkfL5g3lF2OQWGuvG2R54mIgLbxYhGS9x5jptIz9/Ge+pKjIHfUkA0wuBSm42vVqafvwx4RIcuz2tSH5SC9iZdbRQNZ05qP3eOeGeX2xd41C5RmCYyq5f3eEo8l4F1O7ypSW+lbFuLYXnzLCQmYcBpwYZuS0vrHvVA9iX5CAXP7RL4FmeSZdCzLlpcSNWTqYzVllszb1RF/GEHQWp36b/j3z5LxxhJcezf8Xba+lr9lhxu8wsS47Mg+ajFlW1V0OmUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0OcVmMSaT2dR+Q1YyNrKHdWYIMKTxgfk8cCM8JGyz0=;
 b=Do2PbZLpWFgSJh3e6Hg8KXC2Xnipyd6UjywvD5wMOwvEYAfsre9NLTz5SKD4OKzBYQeg7HDzXZZ/Ih7L7o6qM/c6YpzlIeyX5/jsjOLTqfU0QcvYRML2C3wPqOxGwFmV70khy+Wr3645ppjXYnEWDd6jmAqMLKULnXEPlepLnG8NeH/dktZ41E9cHCkw6Xg4p4dhtqleMgnMcixGwZCnCYgyXkZ7OX1fkJHFdcoWGj5XEu7//+bRW62AFHTXIqo1UvGYD7K1Esg888usENkJIrvHRv/Tww+LlVt+8cDD5YsIEfW+xGG7b3WEKN5UX0KlGBqMD7bbWfOnn8d/fBA/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0OcVmMSaT2dR+Q1YyNrKHdWYIMKTxgfk8cCM8JGyz0=;
 b=UEXZECzlLHvgJNVDLu2wwN2Wsr5FRhKbiSTQHwEW+fOJOolJnQOWVEtF5K9alx102XNhF+xCPKcKn6fDOTYkQu3EIDwqx7ZmlIxbMf3KQIkE2nLggz8tyuxifAV1RHq9zJxB45tSwTh7UrBYt57uQclCtQgDZN/bOzHuKYcabRw=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:18 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:18 +0000
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
Subject: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Date:   Mon, 13 Jun 2022 18:42:40 -0400
Message-Id: <20220613224240.79400-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c859f9-0256-4027-a1f7-08da4d8e1c38
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB382414B53E06BB6647152B0897AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzIzap8uXrQ5DK32avHDJVeHGI7jq+XnV3HUjnzvIIuT4zHD6QwlNpYDAjXd7wkrnuaNolCl7zg6i3CWJGnlpa45cOtRibU7jSDhFlI18HRH02iXqlg8m3wjyjLpOfPaKVzYceuXQQs97h9/YkkSSaKiZ5xO0HGbd7S0PBr3WJH1ZQdvxGKtFA7v5l+XgMF8l+k6ZgMIv3AwlLevf4Mu+iYTLKDeKXRePRgdtNVdIys2HA0Wr0Tw/hI5tUS+2TxJByp5nZ5xkPndfymWJ7iTDKFtwycT4Z4dbf72ipcBezOdxdT3qxWOikUgSYQGRhtSjmdLIkKp0bo9wmpRnroNZ1+XIksQpkjLy9Ri5sMcqwGXZ79Eag2tCrsAQbQ9uOzrBWRlNIR7MYdOFZFFRqKdF3EaTejMs6yExNv1O1DEo6aPVVmvPhNCq3N6nE0eD9eqdp/Yng+hmVtcO+Twp93SRp9sMITej401A+yrq0w+5golwHIPDsg8DO8uFMeSLkjEskeY33Fy2wX+/AZ6p1TYH4Rp+3Ob56FM8/NI30KgkzbNe8YDjaa/FA5ya1vFmHEI5nAmzz4hJTU9nUBIZWma+w9yqf4Gfh2dRQwYOBLjCGjeohhFTmjHmv4OJZXdg5QKET1FVGn245jYPIcN2GTbLbnwVrMvriyms06fJYDoCs4a2CsRk5p491ujIBDCujnS9D3YpKTKhU3cf7UHJWYBJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iKs6xJI867Cnxc1K2EOszhmp2B2Q5/8NJOz0rb6PHKZipQSXLSFtSkAvSkN?=
 =?us-ascii?Q?mMbFbi+bWGglqnL6qzhHTSkIaQ7jKzhcU+NLQd7qNErtqacfksoE/4jy5RGp?=
 =?us-ascii?Q?HGk0bxXPwy8QNBTl8f3rykMU/D8gI5FSZK6cqqst1rcGADHrdvVgKiNIV1bs?=
 =?us-ascii?Q?sF2nN2JLuDKbLJskxl2qskbb2xvCtRMbl1nz9VClazJgYSxI61x1yoxYqrZM?=
 =?us-ascii?Q?G1TjyzYV7Csx/ilkl7XIKD+pq8bFq6nvw4sBagumYa9Y52S8ueRgd5ZvGF7p?=
 =?us-ascii?Q?n8MwtR3bUCwDU+fo7OtDy23bxI0dBv1bG6I+wRVhxErsGs+B/UVaRQoYL2PE?=
 =?us-ascii?Q?wWc+xuAzyVdR9W+j8q142yNX9TxUgYPqt0VJ7EOiJEMHu8g3fN8qT/xOVLSh?=
 =?us-ascii?Q?pufIgmzO2/5GJL0WXViq3JaWHvOYWyMBVwKXUQbVNxxrlkEeWq8QRAkiJ2yF?=
 =?us-ascii?Q?OYvZxkS74zrLdy/aJZw1f917LT+L1EAh5UMJTMMP2+ALLD75gN9FELB2bG/M?=
 =?us-ascii?Q?+HXQNogtvrR/EzagRqScPUdqsCaX3Dqt5JAIAtDIYV36QCBrbD800unRX/Ks?=
 =?us-ascii?Q?5U7xaNhWCqRLlEEPY99md7n4y0vQNNv35lh/cuAINHbtXN3+nwAOpNXg8yRl?=
 =?us-ascii?Q?AWG/qgGaLxFZ8WRtfa9wHYHkIwSHmaCf2PUMQZCok1PzvIaX+wweKoysookE?=
 =?us-ascii?Q?sfG9TWY4wTigz1g/sAdrRPmSASxH8E3gjzg4Ia9ic0dKgfbw/5ydzYc1LVwW?=
 =?us-ascii?Q?h1rg3kv24DmG+0oedo32qDJhBhG+wVexd8okSXOauKc5pD2QCjwVjLCUjOl1?=
 =?us-ascii?Q?Wv427YMzjvCjBcLf8Ib1UMwTXgeNkpUp2qfeSSYhZyZC126116D3AmISregL?=
 =?us-ascii?Q?4qZJ2AL6WK3InNt2wnmxs4gmDW6YqBCgkq3+8/KNgvRoEIZeEByQXmdwgy+c?=
 =?us-ascii?Q?1DVR0z1op6PNsVJiNPCqw9kiMHy76X9lVnarYSzy1+xmfjW4970/6xsMTcOs?=
 =?us-ascii?Q?s6WoH/D8x6GJmy+gPXa13pkaJ4J8KLzK3rfXQ+yCc/ISzevj3QgH2fMVrx15?=
 =?us-ascii?Q?lV0JAhwoEc+uk9u+3TkGBabhlOE/7yhVi8q7JMjGoB8w2leKfK1DgIOK2ALr?=
 =?us-ascii?Q?hUuOmgmKAevBGEPmdZUERjGa1/QN/CkvtBBX23uIN63Mpd/6fl0k4qoDx/SU?=
 =?us-ascii?Q?EitJy2prsxew572M+cwnF8I5s2/cLCwX2ipHsgzF6Jyns0ciSA6El8LCxBGU?=
 =?us-ascii?Q?oNBFbwOsxERl4GuED7Zz6/fv/vdFnj3gZGChzUFVXYxzwBYMwGS3mqMqYkNM?=
 =?us-ascii?Q?4GN4hxvYhS5h2k6OKb8siC4f7YOiUqrb7dig4Y+5BRhTVwh9KQ6SQrxkTQ3+?=
 =?us-ascii?Q?efy06fBIQWdr1reMyGS3A6WcsZ4sUsS8SdtdTbYfc9+hERoSsup0W/zImKdk?=
 =?us-ascii?Q?EwhBpmmCyOSVr/KA3IQ12CjzOVe4gKW9l1uZW15yGzq/O4Gdy9ocNZKYJx7R?=
 =?us-ascii?Q?pM5SmhiST92cRD6Ek+iSsrmsJXkwrydLUtnZaP4OzWMzNW9JKOuwCLRRqjXU?=
 =?us-ascii?Q?pwvQ91Kl36k5eYkP6AjvEkXRDrdRnTNjG0Tye37vrax8TSqyiO2XrYdvbVp3?=
 =?us-ascii?Q?xgsfi+VeDYPxLZ53o8BMpkgPogoxl7zi3KlfPMlgqou887sBFTXe3hwDUT3B?=
 =?us-ascii?Q?VMPeLuoXkq11UmfAslP2PuqOiX32X/NnWIcXWbynipEr4o7g3GWVIkla+yQQ?=
 =?us-ascii?Q?REKIxoj7Tc4czxjxyiJaVWfsHsdb42s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c859f9-0256-4027-a1f7-08da4d8e1c38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:18.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8aXgdMEBARvEZPoTdgMNE2PLiW5escM7pEoNs+edFpDPGZ4q3XlSAJDJBov9rjDLYgEFqp2DdXQ7Ga+x4p40zLJ5t0fXlwnKykwQbszkXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-ORIG-GUID: 5E1ROhIepAPWslxXhXAC_YJIqGXY2xDG
X-Proofpoint-GUID: 5E1ROhIepAPWslxXhXAC_YJIqGXY2xDG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

When loading the crash kernel via kexec_load or kexec_file_load,
the elfcorehdr is identified at run time in
crash_core:handle_hotplug_event().

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and then installed over the top of
the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES configure item.

With this change, crash hotplug for kexec_file_load syscall
is supported. The kexec_load is also supported, but also
requires a corresponding change to userspace kexec-tools.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig        |  11 ++++
 arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6ab8b6..e9eecff3b97d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2082,6 +2082,17 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_MAX_MEMORY_RANGES
+	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	int
+	default 32768
+	help
+	  For the kexec_file_load path, specify the maximum number of
+	  memory regions, eg. as represented by the 'System RAM' entries
+	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
+	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
+	  size to determine the final buffer size.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9db41cce8d97..b9cdf7a0d868 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->elfcorehdr_index = image->nr_segments;
+	image->elfcorehdr_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+int crash_hotplug_support(void) { return 1; }
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+void arch_unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
+ *
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories. The new
+ * elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ *
+ * For hotplug changes to elfcorehdr to work, two conditions are
+ * needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. See the
+ * CONFIG_CRASH_MAX_MEMORY_RANGES description.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ *
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image,
+	unsigned int hp_action, unsigned int cpu)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	/*
+	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
+	 */
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	arch_unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1

