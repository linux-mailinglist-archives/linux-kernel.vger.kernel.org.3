Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D433257D32F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiGUST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiGUSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788F8C75E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIDuBb013157;
        Thu, 21 Jul 2022 18:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=j7CGjJc8BjCRKzMdNHifMeyWiucuIXD7idUNb89xLQU=;
 b=tKLOQbYotKjWKmrzII2s2YMDR3+v3OBTiLJriM2q/Zb8rbl8U+piCxGT26dPNTI2WI3W
 MUIbPJ6XPaBCfWLs9jo8yalc2jShTYZyy8gE1NJ9i7PY3PR4fjSUr/TSgq/irMOz/2Bi
 xIlmMGnh8whH9Xf22bL/rqVYus++KfpOc6puHBD3AtZuv0ErB5RWvTZehFlNDiFz0bb7
 zO/RG7UOkcfoi+LuTHw9u3ET6CA7pxJ9UUNkkkcJHqkitBe7adwovL6BVD8cSTaUTJzX
 3Wm7Dras5mXjrcRkOmqt1V8F3Le8Bzq1xErqUe6/vgQ2X3u/ERyF97dL/0+fdwhOtfok rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsdb8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LG8mas022180;
        Thu, 21 Jul 2022 18:18:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hu6mg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfZHPPPIT3X7me6PwJWlfkNrDLAyHsuvF24C7LELITlC0gUC6pWoxEF66t4eWNWrzWhzYbKXeM1KxDWTebTQ3LMERs52QEcz60wEA+y//12q7JYiDP5fPeA9xhtzYTB2Tebb79N1S2oOlnAUDsHc+UNIBAw6X9QyM4JQXWAQBdJSYl1RHQIQXo6tWq9Qe1r7JKo1l4HiDwT+NJP0jsbC8qO68K32xGXYy0Wo98ladYMa1kwf5jqQlajVusu6krWZhhugX6cKxE2f0FGH9lKd3RVqKFRdnHG2lK9Z3QlHSBtH0pRb5V+zm2E9FYulVKZEWBVcdZ1Nv2rHf5Gyza62jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7CGjJc8BjCRKzMdNHifMeyWiucuIXD7idUNb89xLQU=;
 b=hlfLzMYzfrtRd7hJJMSzE13TWGoxMvV6k+xJRFJPzNCXSGb892HWG325YMwcJBvact1lrGWwGCQbsnjatbRqs8Ub64zh+oWV1815YS8qKNK0JdGym6uSGZjSZsTxRkg5bkUwSJ9+67GjaRmA+F0rs5UiIdAhmalQgNk/iOcaWxl/Zv63azbD44r8EV/Hd0C2gLABW9mHr4hfJlwmtS3qWWKvsskLypNUyzjDK6vk0swJ6gi36fHO5EOPgmJ9bFDGsgFP3xwtGdnq4uk0JAc9g4B8yKCqm4Nw/0m/oDx7jjSimDVwJZC/py1/nZfYDtVbaf+3GhwYR64khG4/d50tcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7CGjJc8BjCRKzMdNHifMeyWiucuIXD7idUNb89xLQU=;
 b=A2VpdwmGXJ2STIYSB3UrnxlhkseQKzkuGtOBwPvR8NUS59Z/kkuyX7w/Ty/E0NzEq013Lsq24UKNXIN7fswCuhzH2UsnXw21uF1hjcEk51hV65dnEpwAJimAmoMzvmPSQ+O+dDGl4vgAKc+IcWhOwGwC6zEHplBj8yU8x31I40g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:13 +0000
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
Subject: [PATCH v10 2/8] crash: move crash_prepare_elf64_headers
Date:   Thu, 21 Jul 2022 14:17:41 -0400
Message-Id: <20220721181747.1640-3-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a90e72c8-aadd-4956-9a1d-08da6b456020
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3MEZM+drUd5YuOxLP9W8ZJOo5WxWjtRbUWmynueZ3wpbidzGn7//LiftmBgiIOlcsPRSj3/ihHU7XzdgztZamRUwyvaJv9SpiYdF/jq2OlA0/o/pNn7dYsV4Q9k4mvGPktgoo9ZK4vgP8MdZLVVhvuZOt4+pFiREXOCiG9EhJdGXHC8i6D7xS+/esqtonNmGAlSp7z46wlFRHcbZs/7PnGpPpSFdlUa+IePDsJJkQWO5PCkdAEC1iZKWcARZMSy16ZOPdhMycp0j3G18nI1ReiTL/4/bUYg47j2SkxS0s1pmns8+VCXQp0hnx3j0wNI3nT5r+GaGJLF7YgoCAjQAmf3adLPUIUI0/NFRbmsMk68uDqK3UerDBrZxmGJOSPxY8v1+zndER038yCIE54S5kfopBjlilAiK1TKlNZ6svAD+UH6uzSQe/19u2mPrNG+SfsMZtDa72ajVzrZfSHRd/alrAP3TXqkUmEJVSZp00NOuDvI7OnwhqTVHvInCQrlT1zTgPJSnUA647WlsoFtsHjaENMLqYCC8QYEyXuZ9lmg0LrAK/s3Hrkm+wq30J6fOmLwYLoGMHk+bcqozpsxmGWHMQCvqAMWsBkdczWPc79D0F/4bY8iDOXSsbvCaUkW7KHqXbQFgzIwg1JpuE33Swo3iyZZhFq3VuWMu8E97+tyCbbyhho6lXkRprY3YbIZ2Vuwq1MoeqVkfrPbi+k+559EOzgdwBb/Mx1s8UFL9bwZbWhhoDMgFefpAPVEFUyzTdJzwTuCUkkvZtsP698Gddpx82oFNuFSFwUDCobO6ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(83380400001)(316002)(186003)(478600001)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0pt1DJK96vS+dI1xIxHbfc9QWoUVoSED3SkhdoDULPD/uPRMwLqtJ3Ptr0/5?=
 =?us-ascii?Q?x24Ewzj9qm6YKbB4qGPE+AlXUfyKgDfVNQCP0ES7vHCVS1TK8IEfTpTWtZnq?=
 =?us-ascii?Q?30HpqsS+OLD1yt/lTkhIlDdjWiJ90SkXs2OWljmzzmaNfLNyjuG4ze+EMaLi?=
 =?us-ascii?Q?n5LzgvdQAub6d/K3AxAcrOkPYybGySWWjrUi9mheC/eLATRwB9BA5wtsRtE8?=
 =?us-ascii?Q?7nAvdnfxCdG+Wpku6jtjGoQ3xlikXQ8vTk66ax5khROoCcBqc4a99SyRbmry?=
 =?us-ascii?Q?EijXn4QwLHSpjRgfBwiMyyAZjvcucKCBhAhwIsOWcoCbdzlqyQunv6cOhXC1?=
 =?us-ascii?Q?NuLEUVeoqrLktxgqU4IchV1CkAUJ/cCGed3pDk4buoVstJ8UHot4i7S2uA5M?=
 =?us-ascii?Q?FtBvLk9z10So9F+4MM5GfRqVwcSRY/oKwf7H3ifTOsD23EB2GXUq2MXDvbao?=
 =?us-ascii?Q?Ci74576TXfDBDUCVD4tc9cvmQi4cjaeso/GFTlQ9Lsipsw3sRUe5+cJAEABJ?=
 =?us-ascii?Q?zD5F2IeTfom3wSYDK6SRTKuKRypwLlu8HNKfJxWlYn1R91wzFgQQ+v3cicKy?=
 =?us-ascii?Q?lTP7lASvwq0Cz/JOAhF3WWKtxAtC1W0x4hOn83+zRUMwX5gjDQxvs3gT9p0I?=
 =?us-ascii?Q?nwQC+UDAF6YeuJkJjHMpqEXMg1BW205dx8wkWv2Ic4WjA/ZZ0Ev6j8jL4l9p?=
 =?us-ascii?Q?bdhbBYATnznqWbUTAfRFozLeKvSrI1FjLDPpCU91ORDZmWGBDmRnhMq317KC?=
 =?us-ascii?Q?9u+tYLaeDi3y6ranqMkI4DLMzCGTSDbx5ohBSCy/bRTfiTkmYCVDPwfo1Gjy?=
 =?us-ascii?Q?WDhg7vtVtitsf/gzK/GZbiKlNfgBxbLkkU9KYMl5SiJa1xJ2NhOM/X7RSdpS?=
 =?us-ascii?Q?dltKCDtJwBK0sVhs7JfXWNx/yBZ6vMKZ5D860lSif6betdQRC6DbuI5UrKf4?=
 =?us-ascii?Q?vzVTk2DAn8EkG6jR3OTDWdzYyNG36eWrKtUG+6VKGJ0ShrXSkyMAMuSG8MuL?=
 =?us-ascii?Q?XOfNkJGL5HncdQ8XmG+RAZS/ZlYszlf+T+r6usagx9N2mzjQ+cgowzugoC/N?=
 =?us-ascii?Q?to6jazeJbDVGjbiGlvVMaCXs1DGohTP4YGi0tj3Q0C3sbDGoTWCnTPtEnG0R?=
 =?us-ascii?Q?8IjBcA6MMnRbKt5S2mcj+cMaWpoQ7uFmNA7EyNBNq7UfmLwa11AWp/1m925A?=
 =?us-ascii?Q?y+8RcVurkCGbZ80wAT1Lxj+cwq9uGP1hBnszhmVRb/jlKwYBNL2FyieqiKj0?=
 =?us-ascii?Q?9t5/T5qi1GjfiMiLEj6KRwqXydFZKPwf5N7o+oBB6QqOq1DuYSTfZV5WZExk?=
 =?us-ascii?Q?RRlTIFrTAovbHMrLL2IbsswaRHz48clDSV8liUZ7yGrr+9z9FHkGe9j3h3IP?=
 =?us-ascii?Q?SuUIsIlu0hAzQ3E1/9pkosWhTOffXZOIOf0hb3gfhRWn+buABM3iBwtsUtNG?=
 =?us-ascii?Q?8Vw/Cbnxz4hGycUrMdz4dYaBZxMtFk1QNt/axkTnt0CGTqsqv4EEcyHsvq+H?=
 =?us-ascii?Q?SNZDtF8pSinkv0czhEZvtDCa0bN9G4itfTPksoXFBKC8YAFXaES/oXmxzJX9?=
 =?us-ascii?Q?xghKBRWgPRo8pRKP6/HvD1g01NZhOpYy+/ERdCLUqKdW+ds9RA4ZW7qZHu3b?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e72c8-aadd-4956-9a1d-08da6b456020
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:13.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ps8DLZHAvpplPypgDVK1dp1bldHpEL8mxF4mXC2p2vjH+VTAWRsU/aJs5BfRzI0j7EJQARVUFNev76y3v0INpKQJ6000Eh+jMjMGVv7Z98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-GUID: 6x0v36L7GgHgy3kLOQBLCc1H1oQbAPcV
X-Proofpoint-ORIG-GUID: 6x0v36L7GgHgy3kLOQBLCc1H1oQbAPcV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 71122e01623c..cf273fd7c18b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -302,6 +303,105 @@ static int __init parse_crashkernel_dummy(char *arg)
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
index f9261c07b048..fdad056d5938 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1234,102 +1234,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
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

