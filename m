Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8B51C86F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384790AbiEESvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384729AbiEESuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80E1084
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Gc9ZW032436;
        Thu, 5 May 2022 18:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ByeK+PTtK6w9jsyLSSnAXxEdALiqHPxBeidY5M+5xHQ=;
 b=P6oFHJ+fgvfc5SWFnJgXU3rSSsMNl0wOgGI2smuOLZWgu7bj/C0MAnuj0IOm/KO0oIRs
 U1iQ08YLdxX++x8D3sRhVwnOcSqovZQoie2nX/WUNJ9Lj7d6lNMEVN/kmmOe4ksgHNd4
 fsoBwJrFsw0kpm059xWUJBMmYz73BD+DvdMIE/n9ekzPolquahQ1d3i6khbH1HzRXZOC
 S0WxzdLADla8c2FnZULor0WrFumDHJOa36aW+KXiMxSnitfbxPP4fA1Kq+a8fOCwp0vv
 r907qzMcYhzQMOlGGyc8LKlTE8lTi227qYoHXmXqkdA5/IiHQumi0VUYvgisN0E0lHhg sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0auwgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245IkdQH002992;
        Thu, 5 May 2022 18:46:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus8yet0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4oj6mSnxb7EPRKfDy+IwYg/zb8LOrAGkN8b7wd6vHMffIHIgrhXPJ+eYdwyMf5YBKOKkwKCf1bu+bLFw6axXPKy46PWAyeXOirIM2tuXvMao/8vzZb1me67QTcOchv98syDz1m+AnDrzIxZKeLWMEb+C03OTPaQyazBBuPp8foBK1hVU6q0bhzKi4g4bTFEF8qKxPys/DF1YyYrda3NYsCQf4T646j8DtO5acVBW/VlT+uZceq65pOg0rLKS6e/SPaWZKbIJ0CaBRFkOQ+jpyWrj/RD6G/3jp9Zpc6VZ+0qLWSqUGeAM1GyWfh61rf7uwSpIkcBl9ubudHlKS5YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByeK+PTtK6w9jsyLSSnAXxEdALiqHPxBeidY5M+5xHQ=;
 b=kGcJKdBys+twRy/2+5fZzmseidmLCekUjLM1AnRge5oGeTpAiVnFZApX1SBQZqtK7ZyFhQs3ZJ1gj23RfTmYJ1X3dz38kHyHJX/A3TIWV1Dl0/Ww88AIyTkrTrEmIfYHH2OfiNdreq8iSf6XJutBkw7Pj5mVifH0y81Xm2UklDqfAK/0ftqCbflvqiaIBE2QzLWTiHrK0TSVD0evxzAnwz5L8J7LNRa6t0RLFCp+SbS2Oo5pnc9wmT1AKGtkUr50HGOTbOE0Fr4uVYlSBFwLVzymrr8ClnyjBT9cRFVSUWIorbU3pd4qDmLv7Y7T9TPqy2y8/P5amzgP4PJmG0zmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByeK+PTtK6w9jsyLSSnAXxEdALiqHPxBeidY5M+5xHQ=;
 b=YX1Q5+hzodYHRnk+I3AvPltCYIK5I6MUF6m8eowNVr085vS9OSqSX3fzJPx4F9vNs8e8MzVWMt/HVKjamr2iGRM8ir0lwEOMQFEo0AV1pgt9FmeGeJxVs4FFRiQQUNFzLikx+vW88woou7s4tpgffRmPxMYXgfKUvimDn3UNZAU=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BYAPR10MB2469.namprd10.prod.outlook.com (2603:10b6:a02:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:39 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:39 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v8 6/7] x86/crash: Add x86 crash hotplug support for kexec_file_load
Date:   Thu,  5 May 2022 14:46:02 -0400
Message-Id: <20220505184603.1548-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd07c57-18d4-4c0c-9948-08da2ec796e3
X-MS-TrafficTypeDiagnostic: BYAPR10MB2469:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2469CA4815471717AD1FC73297C29@BYAPR10MB2469.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+FO9YatZnf9vz5TeKaEjo/Gu8CbHA2smaM0pmEjzidCyXPZ3fJpR45C4h5qviTT/wiWgdRRvGkxourJc/h4Oak6QNgs9Ha6V3o/DAFt/x40s63YOeLrnxmRYlqzCwy+QbwslkfiY6weE29on8YwbDI8AeS01vNhmHJ80OK6HYjcksedVvPepRxHKX+FW6n7I9reaGFZM3zbpJeqfruirQsBmS0xE00u+IPuNIC1oqob5jzaKPZKK39jmfmg72YRVRTC2ZxerE94foVDYmfKoSnAkLlnTNUreJNrJWtvP5HqRGVVzpq8qGHA0tUedVdPm0Rroy6IEB4lvj8t9vRzfBo0qFC08aINWFnhxXaBLplAzVz9e10EyNmGVadv/5PQKmcS1k6H/MADRXftKRS9nFnVZNaw9Plu6Xq8Yz2g5gL1xoq41fOdYR+oqRXGO5CnnTxTUJbPwpKRJeguk3OlU9NH9GZo9Njf5jx2PtEXPOJbVYjrPsylyfY5x2x6E9DqpPxDIJd6pAaJP67p87K+SNAV6G149348uexXLx1SpMsjSHT0/QCP0tddfCQvotWKj6jLqsxmszMvKBGJLXdM9dNhi1RnPsxq7R1OWQQpC3STTKB90IvtIaDPzXuKVyCIMrvumhyGbM9S46KdSAvIi9PWuH2sxgYW1EBMlG36RZZ0bFJKQDgEhRGqL+jtkSSbotwvo5m11c1bXJT+Edpsdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(316002)(36756003)(8676002)(4326008)(66946007)(66476007)(66556008)(7416002)(26005)(6512007)(52116002)(2906002)(5660300002)(83380400001)(86362001)(2616005)(6486002)(186003)(8936002)(107886003)(508600001)(6506007)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wYFQpNsOw1Aa9LK/SmKQDcGOSsbTcQH5g1bmWnHMk4UBW7Kpq5s1RlIA8Gi?=
 =?us-ascii?Q?3y2qoZ0YFOoE26VH19yrkrBYHrvq/b93PzcJ9p5z4ZFzeTMi8tDure5GkTXj?=
 =?us-ascii?Q?6tdK8mwMceWEfAsn9h2htns965mkdOkhfpTUwrme+Aw6BsaHH+eKmEF8ENp8?=
 =?us-ascii?Q?tFsYC1ddJuK0Lp0QMPq0/sLPIuiMUlmAhZRI9sG25BsPUh+QLg/MCpweebrT?=
 =?us-ascii?Q?RD00eWL9PECZbGUBomF33TlFuEquQsbI1Pn+djhtG4+CpAJSHW2I1M4X5+xf?=
 =?us-ascii?Q?lK8ciDAd6jkAqXC8RzgF0F4LHNJmJQvEdUdoCUM9T5Kp97Ye4Qku3SzARNC/?=
 =?us-ascii?Q?vbVxG5RjOZU+MFXme57Yxr8VZk0wRyQvUSfrXuU7ZuZLufKzOLQre8JhfFBg?=
 =?us-ascii?Q?A0/ypBgpZJp5uCTnT+QIa+FSssHL4px0y7dMDK7KRD1reMRi6h8FhvSB4LHp?=
 =?us-ascii?Q?DTX7hOvSo7Jn/oUbXEZgLJ9VEZliYFNhAeaIcgVoO9K+hvKyIb/cIyOvRaBr?=
 =?us-ascii?Q?KP7suUgw40LwXjn6gkpADuft4IwAFgzznulmMiNEAo1Kk/p/puxJdbjeZp4L?=
 =?us-ascii?Q?6+pTLlp9Lv3C4E9GxIyL1D7jOw0RCObXGlJHAF6pjIG4lOoQbdG7M90Gshti?=
 =?us-ascii?Q?p6MwQvRpoSFMFB10ys+jQpibopRtG2Jz3/ZZoYLSjotime7zh0ho7vu6c2gT?=
 =?us-ascii?Q?E1JJkVF9h7odeMqS6LWgD9Yp/Qj1QFYNPr4ArFmwWWzhT7AZ1AHR6hgbSNng?=
 =?us-ascii?Q?zaUtkM5t/wM3QZqGqagO7ytyqLZYanx7qWvvtWiJ0UuLOGAm+Gwgvj+OMXhg?=
 =?us-ascii?Q?/PnqeeC27k6qHrs9NEAWkYyA4by+OvM3Q9NueoIUSBxF2z0gHNMrdVa9SomA?=
 =?us-ascii?Q?OFoFNgSpsuiXVjxpRrofBmE0eQZMrpQI0ptJnHifCynl+1TGkdWiXo9dy03A?=
 =?us-ascii?Q?up7woE7HTsVynT1KjgMCze3AJ0P9Nfy9S+1RsfYlXbOzARx4eaBDidGcDL6O?=
 =?us-ascii?Q?asy8U1JD8NWGZ6M4mng8kjw+2GjsaHwkB1uUuKtT05xq2MQKp4J7y89LbZcQ?=
 =?us-ascii?Q?T79fb1nzUPiywVVmk0m6PhOu/7jIX8GkEdA/UpS2ZczyEnd3oi0TuJopoUVx?=
 =?us-ascii?Q?vi37cUn1ZEWEBo1QQofo6GOy+B7mNl1tzE4Cm4ZOzA6OHLkHMGxLqBv4n5nB?=
 =?us-ascii?Q?FCSwevLapHGdKQJp2l6dTAVkx+n78PprGtJREOFPxpfOd8J08La6kogmgkmI?=
 =?us-ascii?Q?jdFaos4uTQioUGndWMm2hah6G2aWX9ym/5Mnr4mP6y+y9LOeFnR6dRSqUaFa?=
 =?us-ascii?Q?2tXndYvAOKb43vDY802iZSTzr7yj1QDr1Nlx+nbs4hwI9oCFOUYPH6S8YYbj?=
 =?us-ascii?Q?0xEAfE4X5WhbK4CiTb+EYlcut9d6bjur7yVRtXkji0aXLlN/OfAkWNgsZ/ZZ?=
 =?us-ascii?Q?t4MahEBjECXoDBTI2cWhQfY418TQewm+tmtFVxev4fOz1Z23ZEBjvaoI/z8L?=
 =?us-ascii?Q?ktyXq12oQbrVLLhDOio2oSEVW5yKrEB8hWTIFpz4nigwwe41GGW7ht5AiqbP?=
 =?us-ascii?Q?7f76VXYIEhcGA5BPalPcBpvG4PeRHTZzytolcNokIVxkg7E3bZSxJ2y2HGTb?=
 =?us-ascii?Q?m/5Y0BO95aZdQ1jdyRidPFNZDyDGH0yUZ2SUyaSCsvnagVV3/hW2o7MuRFUE?=
 =?us-ascii?Q?7yS5f9oqreE/ZsGvn+yQSxdIpD1F+Pbu5KVYXxlBdwGL2wDIdaY8xOnKDf6p?=
 =?us-ascii?Q?w1pDFgtXKbf88If+gp78ECerEvLzcsM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd07c57-18d4-4c0c-9948-08da2ec796e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:39.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3feqtw+PcEvtnRxWU6Hin27eAB4ffpRKPpnHjSWn2GdaOk7yvuWSL9rXSdbO18fkiOZ5IQz9ZJFPZqfKoYE19fL7UCZP2PK5N6YR9Msv/5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2469
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050126
X-Proofpoint-GUID: nft_t-J2T20zOZs-UgGkdKHy2xGi5cLL
X-Proofpoint-ORIG-GUID: nft_t-J2T20zOZs-UgGkdKHy2xGi5cLL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

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
is supported. When loading the crash kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig        |  11 ++++
 arch/x86/kernel/crash.c | 117 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..bf1201fe6981 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2072,6 +2072,17 @@ config CRASH_DUMP
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
index 9db41cce8d97..951ef365f0a7 100644
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
@@ -413,3 +424,109 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+static void *map_crash_pages(unsigned long paddr, unsigned long size)
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
+static void unmap_crash_pages(void **ptr)
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
+	if (!image->elfcorehdr_index_valid) {
+		pr_err("crash hp: unable to locate elfcorehdr segment");
+		goto out;
+	}
+
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
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.27.0

