Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5F4EF9E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiDASdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349069AbiDASd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE91DD3FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FoiBx017617;
        Fri, 1 Apr 2022 18:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Sq4LnpA8rJJ60MRt65qso6AWVzETDf9LTfkpJWBz5IQ=;
 b=pDcm7cwXa1smFfjaoppb1F8rs9nkSnOYDONZY2Bg9KWJC6QoLqSgDt/G84pySJQCmeTh
 9Rs9Mb6z5dWGte2Qy15s7bHpaN3R9pEJkx1hINJYwpMfvasa0rvmfDp6icw0pD86U/7/
 Cu/IJO2fuzlh/Z2PBhxqAl4CX+vXFJgk7kObMeA81FmyEBgYY1+furQTzhttVxKZHYfS
 uVnltOHsZ8r9IFY/33SWFYbPfTHk2QBZAAp/gVmx2TlH7dXey88BKA/oCbXrLE8wRuQF
 hRHOpc2gd7uSbZjkgGxZrQtfe2H53IpXdln6oUjfVFJUd7o1mnJzG0jcSPSUWWCn7IcA Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231ICBu7036072;
        Fri, 1 Apr 2022 18:31:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg9gutd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWj828ADyI62llGZ9T9m9wG1Y3YmPIQO6q+XqGN29Nd5QQ8vbn/rS+8NPE/f41WWSqos2vLiFJ/obIAS2hGdV2D5c+o/rY4FOQGx23P/165YKTriXb2heircCwRsWZV6t2+E33d3mK/H/J6pk/AmxOD2kfk9upQiuSXOZ+AK4ThlQZma/utqPtgIWCzflRbTiGPr5UxSHwp8Dl11HEMz+KoKfVRqpaE+m9YrlO59OimkJLUU//VZs3q0bKFYSVzmN3fP1z5QsgVqYuhOSLDOb1Z9Py3dYAloTahqi71xIXPdA6EDMgrxbiVSpzSjwEryiQmE71dtdPsGxfgCuYE/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq4LnpA8rJJ60MRt65qso6AWVzETDf9LTfkpJWBz5IQ=;
 b=G/LEHl09h6hzdfcNS8NfxiZwOtaZ3mGndj/lBxCwZCpE7D1rq7pzKc6RoW+NzJqWD3m4mChqXcAVThARaJQh5riw0gdkNDC40qx4CDqSZSSpnIYExYJTxdhRCONaSOnH64jBwRaFulK3RB0zgKsWFqoTYrXu/XX179NyLO4/IOArCoYIi3DKb2ZNM88IlIwyxNiu7fRPwqZKJphO3GCtxQg+mVLtCnVS0n0hanx6MB+IGxAweXNK8H749sp2zIRdaLiLVD0WL6eJvCwyh4jlCNBSf45zx5wFCUJlxYacTvkqRH6ajA5zTh0mzsGSKFa6yzpbRM7L9G8j/ChJPPYGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq4LnpA8rJJ60MRt65qso6AWVzETDf9LTfkpJWBz5IQ=;
 b=xcmaGaJgCqU1V+JvfRubEbBhPB3sgLRth/Rhghg8xv6eGJQ6ORX0L/z1ttXXTL5PwfucDu5UjpAbozsQsZICfG6g8wyh/EV2w7vJJnTb5Cd2JKskECgfnTY9/FZ12bVT9cS0fVFy8atK0XKFR17UgTeRs0m0zL5H2iTWqPJGqBw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:31:15 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:15 +0000
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
Subject: [PATCH v6 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load
Date:   Fri,  1 Apr 2022 14:30:39 -0400
Message-Id: <20220401183040.1624-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4beec254-5b0f-401b-5504-08da140dce44
X-MS-TrafficTypeDiagnostic: BN8PR10MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3268E943C655B1281C7A542D97E09@BN8PR10MB3268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xwzU6Im8IMiiys0rhQiut0y/0ffh0JXFcTKxCeMcaY2fVMxy8dfMdkzrV3ThW/+iWOh9WR4iaPv5PENr3nRha53oa45pT8FCd4VzBtkEQFX35FiTASDVlXxuRr5y8RRZRMmM1AGqAIXOBTghLhk/Uywp6wRWd2JYdz+wXeuAzOuBF12g++kL60xO+RXu6G9pFA0jwnNKtw/eWLrnCHdOEchqaAmAJzoGWNofkiN1Hmy8TrzmRJkvIRRVa6TGF5pLZ9K5adfyqJRrW7LmQl612aGbfVGewcw9hluKsZlqboa4ADty+NATYzKNuTQhI6814Oi/E7aSamRBnd52QMvRu0LUfnivBvRL5ypGWjJjFqkAJlzXHt5kv8RuioxSXvI2SFXyQyqDsNutOz1TxVaa8oX4l/IDCv3QhYQy50xqV8Jr7hDIi04pa1kXCIYm8iRAs84GXcGoP4QTjakNBiG8Am8kh3eoLZ+vL6RkqBxzxxpy6uTEQRX1s4/4EX8jEwVmjaLKNFYFTQqqbBqt/HOBYABuWpCBVbPeuvmfLXcvr1UwQzirOESiT/Y1VA1YvsPkGJGL50HMrXBCv5bIrR1n4yo8yubr1kLsDoH7bqRER74TQ0JeMznIvCP8mYphkwYRQNtlxtwATSfQDgTsoyi9QKE/CbToyeDyODmnhSiy6XCCOho+Uc5KyBzcdfgSzFoxtdLrgAkCw9uOOyuhn9HLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(86362001)(186003)(66556008)(83380400001)(26005)(107886003)(316002)(8676002)(66946007)(4326008)(66476007)(36756003)(6512007)(6486002)(508600001)(7416002)(38350700002)(38100700002)(6506007)(52116002)(2616005)(2906002)(5660300002)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cz4QBRxPQyfBHbWqRuJE828Ro8InJ7RMw+FLF8d67TZrK9xnWXcThM/FhLP2?=
 =?us-ascii?Q?DmLliUzFmn+XCBdyeWMfhCAP95jelBDBJNSM41bA/Ppe3zTzPBpUM/fOqBls?=
 =?us-ascii?Q?df9arDwsBY89nxohYq6ndqDsl/hdG5jBua+sYHfkIQjU/F9KYDeYJVYRBl/P?=
 =?us-ascii?Q?xETkJ31fSb1fLRwh5KyJjgRn1vSblnoVrh222N8YknV+MLfg0VRih3VPavrE?=
 =?us-ascii?Q?ywiiC6YqiEOQSi5kfedDoPayNbtEr4JuBKidmxOnyKqAY7j2fYqOyFmkJ23d?=
 =?us-ascii?Q?ZIJw4qWPaPiCFtXe0TvhN/E03ixbdIxlKyuBZNME2B9TN4N4bZBwOM6ZLCOg?=
 =?us-ascii?Q?Pmjtbk1ebrNaJ86HnEWipDmEYXaRtrqSWnXf/1LhsWiW4EG9xoLmFM+AE4Yj?=
 =?us-ascii?Q?QPL7OOa3P0GZCMUSK32SyFc8wLKpwapxRXzZwYgzw8O7uGDOeU+JJzuzUdCn?=
 =?us-ascii?Q?CdIISwBk6b44iIDz96I/jIEoKEoBw+BBks8qecFK1VmPr1MKJDCXlD9iz6Az?=
 =?us-ascii?Q?4dn3eFHUUMeHqAKq4y311MFBU2BSGycWGPFSR4gi6wiXE+OxyEA3IAhrTwnp?=
 =?us-ascii?Q?VmSonN+0atayvMy9gNmv9SOilgmlhgkfpA5hEyyLauBXYRGxyqL95WLlbnMf?=
 =?us-ascii?Q?phagm0pXwlHnsfkKL6ks75Cm+Wu2IR/3ErkWBPFMySgikCIoD7x1oRTacBqO?=
 =?us-ascii?Q?grr9go2LvZqcB1N+rZoWR9HqOm3cEcojUIFUxlD0juG3xx3iAojJZn4d2EY6?=
 =?us-ascii?Q?hkvtzzzOuWh2Xn1JKdF44kRYZRz+KFR/PyUOdF8Syd1TjEyRmHA802t5vKwd?=
 =?us-ascii?Q?37de9mmkxPLEl7tZzz04MKkeb+nBRtdvKKhcZa+jiucR/L1RZOnHXMDKq8eL?=
 =?us-ascii?Q?zdNJJRf1blmxshGgSHLu90T/DNbU+OL0Hd2p7veK9R2nYtZ6hfKf/z73zOOr?=
 =?us-ascii?Q?T5wZX1xDxGktDhaF/+teG3unm6FGOUTU14+ub77QGO/rfgy7mERhvTMIMutx?=
 =?us-ascii?Q?5tCcJ3enuo+pRBgzdV0xIfLJMwl1+etX/vcjKREsM/ZeNDjUaqb8K97RGuX3?=
 =?us-ascii?Q?VOrmXUKB9AmS382HnTVNqaXuaHu/ETvNsypxj/kmL4RBtnbcTEpu3m71e7vL?=
 =?us-ascii?Q?CfspCTys1+CapzVk9y9KRR/iNKsPla8lFWhsghqK4L9k9kAXfDd9VJ/omG3R?=
 =?us-ascii?Q?6XN7yqZvb3wNU7ROYQonqnHVKqm7ogk2h4xcpvUKKxMc6kkc6Mc5PeJ0PnI7?=
 =?us-ascii?Q?HAHLIVQjfFystLgEGHw6d5SjZGYPTJaCbaWbr1+ufSijSbMiPG29kZMsPr7K?=
 =?us-ascii?Q?S+78ZVist++ZR+cyxout7R2usE1Gd2xsNXk1M7A8v7tRO6ck7XeVVTP+gx3z?=
 =?us-ascii?Q?r/OSySHwApfdyIBnytePJ2sILmWSyRrqCs5L42YmIM5+A0hNvxMkMpACk7W5?=
 =?us-ascii?Q?vcPt/ny7RnzCH6gMCcpwVMDpQSXezgxVxbZOI5sfxuKbYIbjWGW+kwDhydqj?=
 =?us-ascii?Q?HdMc1WDER86uLs0JQ2bfpkQq0oYTxK1mVaS2NqoUrLIkwSP0+0fjPLnife/e?=
 =?us-ascii?Q?Khlfpa3zN23Cbj5LK8tDoId8869JPHPiwfa5b2PKHLHGiHWKbEvXaIOl1TMk?=
 =?us-ascii?Q?68Wf6GWgSBJgko/asQqO2XRU1RxiPpU+XCl1rHqTt1TsBHWi8jzCp8YwrYIr?=
 =?us-ascii?Q?+qKcOGiSB7Tc0i/E2JnJL3DujfCDNM6Yk2uBxOYSW4JGPY/mp/+Tf6Ckw2aX?=
 =?us-ascii?Q?8wrTBAWewJxQEG5kPDrpl6S+Otzhp2Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beec254-5b0f-401b-5504-08da140dce44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:15.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/IfjeiM+Wfovmo9NIkCV5+My7XSuyhQufgI9ltSSdUl9TGBFmQ/TtcYa8s7vNNYOrXM+dIIsn32i4ckXtuvv3imsqp88Jpw6xG7wJ7Q7ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: m3dsh_8CjWhH2auIMpJ8NgQ14vXHUKMF
X-Proofpoint-GUID: m3dsh_8CjWhH2auIMpJ8NgQ14vXHUKMF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

With this change, crash hotplug for kexec_file_load syscall
is supported. When loading the crash kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 118 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9db41cce8d97..101c030ac038 100644
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
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
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
@@ -413,3 +424,110 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
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
+ * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @a: first parameter dependent upon hp_action
+ * @b: first parameter dependent upon hp_action
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
+ * to permit a growing number of resources. See
+ * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ *
+ */
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
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
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

