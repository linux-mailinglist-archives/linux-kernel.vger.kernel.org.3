Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2394EF9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351169AbiDASdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiDASda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3421DEC1D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231Frbcl014677;
        Fri, 1 Apr 2022 18:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tdexdjGL5dr3oIys2IHviYcGCNvA3rPE+2+LBqTuZSI=;
 b=LdA0Ckcy5XoZUzZ8EXW5pj8jbJ7ByZ/jzPT3zYi3d90q832LjpNnKPmXc5ASSAmuWTJi
 yfZWWFfay0Jm7vzjcTrPZvVVoq22Cnc4ELLHWjIC2qylJWeDl+K+sPYP57wlRbeN+AMe
 89me6Zcyd4U3GB+xp4aQh52hs9y8V7KsJtY35fwAzCfMtiUvV9TD8bf91A0gEbKCAgUC
 tnCgk8d9lORPbJEWh3m9B5wh1L4JYE3M50ryltfGJSRte/TOln39+iMW8zTXSqJEuPIS
 RHzhg76qfJx+6hAV7TP4THtMZlbcaffKNLVrgftYJNQuoeE5dJ3hNxe8+DnQcFmAFzoe aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cyck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IUWF8031681;
        Fri, 1 Apr 2022 18:31:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s999yqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7O7j2XPxYB9xG85WXytgtZmGNay0sGQ6cde/5+O8+kvfz+BeZUcu+ADQOH8+bgJkkhFaNhg4Nb7dwuKBvIO3fGU0DACkzRvM45nltp5FgWrv097gibjUq4690zzFW+jT6u/qRr8CrEUZiIGi2tbjwj7tXXFt1Q4XNjgcrA/ejCucY0aKKp9Gmd2OrRN6hsAw605oN5no8EApiY4AsdqsL57U36Lo3Oh1zn9q2hYnA45QPpAlHDq0Mdu9AhEWxg22Vf5lif6/4KEvttHqLB3o/RY1cqdiywu2CekvfFS5Iz85auV5iPzVwtpuN8PHlhXJ+d7E6myh7Dy9C/0KZpDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdexdjGL5dr3oIys2IHviYcGCNvA3rPE+2+LBqTuZSI=;
 b=Y5Fr5ILTxygnO4k7jZgWvc+vBFetyx97LauNR0pF+Li0i+KFgedhH6mANZ7+oS3xmYc/SL/DH9+MX32r7Hu0hcl+IXEc3+JeQhXNRl8F5Fd0iUgJrXiHRld7jY6/zShPxVtt2bB5blGHkKEQi0Zw5l6ZH1E2zW8QNdIdcA/swncVOHBXXPiz5RO9c2oPj+j6PEUneTF9tcpImpmr/9anlTDEaaruajVl3/mwtO+2KT/LFB8iCKthgNO5JeO6kxCYMU1WY9waZdV8Ai7lmpLhEGf1kMVWgvns93mbV6PG0+VkFjaCWkVZIpbhaGDCQVEREWqlbR4XkHwI1ydBJQQ77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdexdjGL5dr3oIys2IHviYcGCNvA3rPE+2+LBqTuZSI=;
 b=Or0jzylbqFoTc68S1BGu+5P1reyynRNe6atWvnhAiXAMj/JUoFN85Z18JMku/QXJN7mfB5vxgMBEbnW/umIs2FeW2ilZvCnNS7LJcOhFVdk6WjSo90ZlBmMQQmkWEVE9Ibbm94kAdlc3Re6BXgIOLYMh496jMzP+lDjN9PDGp0Q=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:31:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:18 +0000
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
Subject: [PATCH v6 8/8] x86/crash: Add x86 crash hotplug support for kexec_load
Date:   Fri,  1 Apr 2022 14:30:40 -0400
Message-Id: <20220401183040.1624-9-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: fef5951b-76ec-493a-10cd-08da140dcfe8
X-MS-TrafficTypeDiagnostic: BN8PR10MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB32684292D41F386E6C6D652197E09@BN8PR10MB3268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSq+jEiohBYt8RFvTlty9i20AHz8g/0R0DPwANpT/W/yqtV8O3STMUqfKUZy7VTzo/BildYW8Qcso/y5153+BqHBlrWuj+ZL8q474j/kde6A0QBYnnxYdCrR9zhKZg0KF9nGMgnfbrNZxmVru3WRXALUzQRj/TTEp/bzuOCwF1aTp1+H+PrAFD8o4UHNP5zqawdSkghaKS7fFHdWQdsG/2BAVpjhATXWFcc/dYoK4rh+n5ydMjOd+sdJ89//wkknrJGKKlEC837ZoMl04uQIDisC0XbUQ5ld5pLxrLxo6BPkxXpFrkeiNudlrfmBP8iDkUDLRVkGJc4y5DIzJzKfyR1n4ZyxFlHFUsS4p6K2ie0LpgU9DqMy0tIltfRwvv6T7EyvLcCg+6dk2cfS3jT6Co0y37VBVmgUBAGWzvf2CuEoyoEG3fLGG4boCMtDWzUTwj9NkXL6PCdaLbg2wcZz8fItLIuI7VSh7CDJMAaQHQaPCARTdGO4zucObbE7YIGNZA4oQO2LELO1tBwEDANaE/73fCVXv3IOP+EqN1dI/0JJysHgaNOpiGnk9o1YPyD937RXi2iOmN2cdxGWXHykpUhYMZ+2SGRJhe0bzP0ij1E1xgzIsNA5Q5ZcnN+12L2X4j9HQj/jRWUF+bOSwBIzh2koet/2w9i0EN2uE4bYf/CE35HXPlh711Q8coF9ixOCUoz/2kpnEFVsYJasP9u4wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(86362001)(186003)(66556008)(26005)(107886003)(316002)(8676002)(66946007)(4326008)(66476007)(36756003)(6512007)(6486002)(508600001)(7416002)(38350700002)(38100700002)(6506007)(52116002)(2616005)(2906002)(5660300002)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JkYUBTr0D5sQ6uCUU1CmSBJ0Nwpd2HGfCm6wZ57QgVypE55/6+fXFHiCifzu?=
 =?us-ascii?Q?gEBBwHELBfkhbI2nKaFSapJf/k6SQiNKszuzy6zTOoj1l0Ez223oIhNUtwvc?=
 =?us-ascii?Q?0tSlNS4bLpnVweNitdmboB7UC9LuzbcmVvzZZDlcwLd7bhvsNejpizuP1U4e?=
 =?us-ascii?Q?DvelMNT6NzAaggzTKioovZftMuiacDCEre2liGEyy5rkpVW0TohoD76rC9ws?=
 =?us-ascii?Q?KJ9vJ5ZfmU4YgdV0BRgrIjshK0NFLQgJZTI4wW2CEa7grTVX+mn4RKZGN4Xm?=
 =?us-ascii?Q?l5inR4MbygTlYhB3QpWnc1OMPqldpRkVlMoOsYjnATRsM6QptAtFqI8kKE3e?=
 =?us-ascii?Q?ojj4Ph5QaTTXAdMQHtTTPFK8MfxwMuQpWgkDUUy4zyic70Q8MrdK+MG/bv/O?=
 =?us-ascii?Q?NSwvmjOYEmLA3mPYYKdFewbz4vBqM6nlQ6FB7+4N8gtYG5HTwFBxAjXc6OxV?=
 =?us-ascii?Q?kh18eP0PSCETbzbBmX9UMtpr9sSmRpc62FtU4/EXKdJzWMJW2IAwzWvqPlDz?=
 =?us-ascii?Q?6g5L92jluN6CXOIugj8FVBreBUxMq7Q+X+nlE/Mb6KT+WOVeO0pKIbBf889y?=
 =?us-ascii?Q?5I7u+ALrBObqY9Jd9JGid9anHx+oSeoIvHGD6iskyPfU2SiSJNR/LTXaV9je?=
 =?us-ascii?Q?ddmXRIvTmziKXcHb+D+sOe3salxq3Aal4DxRgTNbGa/P5lyo+sS96DeT/uVg?=
 =?us-ascii?Q?ZfCbrKeyA9pARZNFWxqPIQRCeNY6ssIPbGufdpAU6Z7GasYVDojdrofKrhxF?=
 =?us-ascii?Q?xzaj90YJhpnGIglNgXRqFNMdQPUvwsPb31+wHvQrfhXk3SbGxH85PvQJdwIl?=
 =?us-ascii?Q?Bh/B0Q1SAJ6iyuTY8KBNXks0KDyHaC/Xf4fH/JVOTjoPosj3kBy7I9Rc7f7P?=
 =?us-ascii?Q?+GYi/JRkm9ZH4we3h7FzJKpV/f4xl8DbxfiIUSVubPIs/6k/bFDntmsiWki/?=
 =?us-ascii?Q?xw0YawuzzM64pNE1tCJCkQJh0q93ESfU88oAc8/YzVhktavsC2Icehp1Xsgd?=
 =?us-ascii?Q?cK7HZLwIwUJmRf2czigRoH9+b8vujbVnSMCqG5FXzUPTCFAZd9XGg0gpBFT4?=
 =?us-ascii?Q?fM32MxdPaXDeoln1hrKZygHqiDRb93QGYgv6dV/eD0On12ZYFGCJ/Jbi0oQQ?=
 =?us-ascii?Q?lEyZ0SZSGQIgmWJIm5cAOJW+Hy2knpkvPQkRGkCgXRwRvx4SXUEB/Yw7GeoB?=
 =?us-ascii?Q?0c4fv2h+B/Vm3XRcq1BFttaLO80YBK79Bz7JnVxxAlsoIGdG8pCSoNdBjP/j?=
 =?us-ascii?Q?VsGOqH4+qsdag4cadxdNcQbNHXrUceARQXNohB4jzIOYWZnSX/O66vMaloEX?=
 =?us-ascii?Q?RYb8MEwkD+jF4iLxMr0VUzCPOeKNpGB4fVEXY3VhcnNZIsQe0cdUwgS10tJi?=
 =?us-ascii?Q?f3PDjJzIxxPBst5sNv8DA/sHbR8GzWpLiRPWErZsU+JTbyMzcwQJVqBFAURW?=
 =?us-ascii?Q?HIcXisR3Vm0ebQe1GJUj0IrDk2hLXwWiviYYAZwptyzjRJ688ar0xr4+HTOT?=
 =?us-ascii?Q?52blVJKUY31tlAASuLHCE42/NCJxtS7J4jU6a5ZE2Pse/egHMlDO5QFGQaoT?=
 =?us-ascii?Q?aHUvVkOEHcH+OfPPoR2Vu0Ecq9I48ANPi4kxFtUGV8PVBnxk74TeccyOymiF?=
 =?us-ascii?Q?pzZTIB5FRj2aa85+JsINEBbh4VjKB90uAHJcspgA06TTJgLT7xTauco/ItjT?=
 =?us-ascii?Q?wGjgLYzMJFV4iTyPkMLOwRDxL1QgGYMzXrzVeeTLyUOJELThvKsQUmSLFmZT?=
 =?us-ascii?Q?InkjPh5OFOv1zwmhMz3nEHlewk2PeKA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef5951b-76ec-493a-10cd-08da140dcfe8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:18.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3qkKXadmLxW2sUsyVKIMfFaULqjeZLNUPAuBVVS+EYmIj4nlaAdLCAXlcGfIObWUl3HUPrs3+akVNswJ9uXH9ojJZ53Z/yD4es/ARRfXxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010088
X-Proofpoint-GUID: sKS16nJCOdT7n1InpQgIAcbAJiw3m6GT
X-Proofpoint-ORIG-GUID: sKS16nJCOdT7n1InpQgIAcbAJiw3m6GT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
not already been identified.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 101c030ac038..682f130b83e3 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -486,6 +486,30 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elfcorehdr_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load, if not already
+	 * identified.
+	 */
+	if (!image->elfcorehdr_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+					image->elfcorehdr_index = (int)n;
+					image->elfcorehdr_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	if (!image->elfcorehdr_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
 		goto out;
-- 
2.27.0

