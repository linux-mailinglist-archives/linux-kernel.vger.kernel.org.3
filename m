Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA984FFB95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiDMQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiDMQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BA066FB8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DFO6kF001710;
        Wed, 13 Apr 2022 16:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=x3g7SBVWBsz4d5J/+85eJ8vNfcpZgP8i1ChIRu799hE=;
 b=h0jeOi1tmbfRuhLm18lxULS2M23QqUleuQg260usdGrThcQIwPo+UT5X/B3pPzzX2ndn
 VhTP4m0y4F7+o3z7Wft4XMRLR5k9SaSeDTPG0gK6lvUhwHIwkG1lQBldKSmSmu5Vwoam
 JL5qd6tGooqCu8ui7qH+0miRV7xsMpgbnOlonANAEY/DQUA5Szh1s/7fE3TiUzBWorW+
 7QTGFdZUEXEROqp06fNk+J44HgDtP7RZgfWw4D9u/I9uadN/dOCoamfqCODy2XLmeU51
 rNG0aec+RgT1Et87lCVo0kxsX7IeC5F6JRH+jj7ifKqjAPrEfK4XPYVUEsSa/hM8Aapc Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2jjcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGRQGP008426;
        Wed, 13 Apr 2022 16:42:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k45r4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/QYNB9oHj5M/zefjoZE6jN5l0giMzJ+zWwb6yLGCmHLATFHYC/WGAWMmxeycMP1YBSiybsiAjbKgX+CGk5fIxraXFkbiCIO0pefoqT30uBOW2vpx7m7w7N7FqwBpy/1MSpQvC9keuWEhS2A38+/A8T/gblsvJ2R74f8SMYig1VVn253LHtBh5x0xPP013n+SI4AQC4KHQEwQ9JaMPs/o6sQFJoZFTNrAR6yM1rQO5vpXv3EWYM7llyHhYngwU+XpW/u/Lwu2tn96+rFYfSPJLDRFxVVkZGGezdIHtFyxNe3603yapcHJLEZa57AHKmzJCrDeSW773JIj9nwpK/Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3g7SBVWBsz4d5J/+85eJ8vNfcpZgP8i1ChIRu799hE=;
 b=csqpB7yaUvV0Gbebq0lTs3wS/gTgISGklyB1uPq6TtBxGAVSG/60aFDEcqqSWXAVSVGzEM6CxPc7GiRa3EuPoVwe0TiwFx0P3vCmmPtn5NC8VX3oU/tQmtmnGOw6LoM4h6oruNxnrmPVaQEhmt/XVzjfIPr3O0y3esg5yrSD8BkLcNGEAHGxekqYziz1bPQCEMvzRA3CdmERP+vx6IFBxExnhoTywKId4U4utz5doZOaql2cmTiU2Tq972zEsKmru4CqQ7/E2BgJSSp+PY2smfyJbiE1mjppPBqatXEALPLO9hemSm+os7VjPbzy1dqubJEPSqrSiiKBS33krdKaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3g7SBVWBsz4d5J/+85eJ8vNfcpZgP8i1ChIRu799hE=;
 b=AI4HJfmVnWQ1C8lG9CPoQVvn27ubxD/0ZuqYaXt+gHkwD+ONd144EawUoqRF+PpDN5SYoiOXbqOXyRnC7H3d2zk898E+wOXgmB/hAZeDso3f20bTfBkA+UZV3sAFzETf8VMlD+QvfZqkycL+HXQu4OuAlShmicF5P0ZJ1FXaU2k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:42:57 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:42:57 +0000
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
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu and memory hotplug
Date:   Wed, 13 Apr 2022 12:42:31 -0400
Message-Id: <20220413164237.20845-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220413164237.20845-1-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7daa0f9e-4da4-4d92-aad3-08da1d6ca9f6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3560C3347B051A227ED25EFA97EC9@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gulJ4lHNdU2CY7y6ZfIIqGZ0GB4hES5xlAagThTyB9712zAXwginTrEUqj8QRFSO9yeCft8jjVuQJq6+dvvVv8rok4jg23imrzP4YY8DdpElhQb+qezFb3kAC07BVS9tDUJoawIqpeNqJJR/tfkM/ojxSERTdaFOfPr2WFB3+GH9kxuYUsAAbGCjOZkhEfJjo8zalkY4H2xw5o9G3gdtc43H06werDbf4LnyVlmGYpAJuktOoiMtI/jIOdy2GGKu2TmWN40XhhKdWACwdpgsgLY8iuU4MvIcRnHRVkTbY9RMMXPuqe9He0upPw/YEslwiZLNULlrC4dV5mzVpV9aBUOn04dYpckzDw7VfbXh5fGvuUce/XyFeZuFTRqdUiRjjikhLneeRT6wpXVWfF7q55Gu3MTRthZl40hZ/hhN3YgCF9mdfvf7cf61F730FPyT52pFes+RXilV8qApRiazyT8BliU8YIJOqKQzc7tyK17dtBlSFDZPtby4UxAX2DGaWdWa4MSGg70GVTlkFZVT+n6vIh9W4i2UQNu3zKLEPDsDpXWb9bAyf3uK312vz+Z7ltgHYC4kOX6ZaEa4/ErUFaPzGM8CuK+AIZARAg4hmAjs4S/lKxhO29ABXZaA0PWOIelBBEG7kO/ioVldvOm4HLIU/+ePD2MTPaJn1MsKzvC+KZIi9Z6exjdtPxPxWw2ts9cpn5KUGRJ5gzGeWjRP+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(83380400001)(38350700002)(66556008)(36756003)(2906002)(2616005)(6512007)(86362001)(52116002)(6506007)(38100700002)(6486002)(508600001)(66476007)(186003)(26005)(107886003)(1076003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXKS5jihoVDRCQrWzmg9Nsw8waiZnW5V7FLn9/VWSav/kvw2+OcwbN+Qbd8x?=
 =?us-ascii?Q?k5vVy5CilDPF8r+JePLjdw6BJPFUerrUX6t2pV1K38hmaFAiNQ3djtkWrXkz?=
 =?us-ascii?Q?/vySC9VWHkUDETmy43+r19+/ddRMTY5pMONzYomU0v3tn3+Q8pS5e6lbaSgV?=
 =?us-ascii?Q?rkC/7Jufj6TYSdGIIu6Y0tihldaGGnIL0FK5qA1FtHYK+B/Mrwr3sFr6z+c5?=
 =?us-ascii?Q?1Zfm/M32fXaEs7HPelA4e96duT9mBNit9CxIGtwq4LYb3l/1QYMI3dey6Ydk?=
 =?us-ascii?Q?VYX4gYVn2LDVvGO3AaHJXVUvh7B3MEiD4kIptzKzZfo0SQudPg7g6dLO9Zx5?=
 =?us-ascii?Q?t16Zlnj239xiMsD56MYaVl+viQQylYys7WG04D/4tqo0ncG9b4W/+GXwgwbt?=
 =?us-ascii?Q?KIRpsllXhakY1URFtSEwXWHvBpLH4LLWJq4jnfUkt2rb+TJ0RC5DnH7FJZR+?=
 =?us-ascii?Q?YtXht/UqageRuqlL7p9efKJyvCrrG+o4iTRE49WGGXAbpXeLVMe4jAJUs1aa?=
 =?us-ascii?Q?w8wHS6DI8ROwsNc+y5M6WSVO1X/g29P5djz4B9nlvan0HU3ZQspz4wcadclK?=
 =?us-ascii?Q?s4zezvcKqDRY3jjkdLBv6cAzoItsBfZgi3gyMB+typUZf7a2Tp8NG28j809M?=
 =?us-ascii?Q?8QgJGt+uS2KVqLJeggqUbwbEyHJu0iYjx5iUAiHJkeQCx4dVajLoVWnZRznG?=
 =?us-ascii?Q?sUDNUyxxkreclU2h68o4/56HxFGKnwFbq6dSBCClExE9SsAPZ8oZedXxEJCU?=
 =?us-ascii?Q?OpyhgGi/vIJulZ5sqRGE1ethykd9b22trTQW0Qi65wg7P0J1ju2gC/Z0vO4t?=
 =?us-ascii?Q?gObfDwqeLjhT7X2i7sQDvF5xr14QsVjtJebDuhBy7fQPdsgTEsfB7mvjt4AS?=
 =?us-ascii?Q?BsKB2Ar3IfgyxAuG9yYwfBQK6SU3BQ2PZsXeWR/bNXedlkaMMgWmbJso3Ux2?=
 =?us-ascii?Q?jepVjjNaWsL5vPaDsihP86IeiBMg9K0q6EI2WSTF/sByfzeYDbZDAOeM/wk2?=
 =?us-ascii?Q?4xz8xK4nNv9NtsfNK9PTdlpt1943eGbgNWHcTkTnZk4d0UwWvRTK1kdFsSwv?=
 =?us-ascii?Q?Nv9nPlHktGgvOMtzSp82QfzO2ahSVthXPqA5KS9xx2ZsQrjXx9k/EG/3rde/?=
 =?us-ascii?Q?zN/se/IQ4lF26lWS6u/aAuQ0OrH/X/NOBbzE+fEZKAuIJEbUEzikNMhtpVNB?=
 =?us-ascii?Q?qOJ7iliLs4n356BjNSdQq9KeNtK6G8ElSKkdxdKlHnDqe8d9kPp0YXkM51cJ?=
 =?us-ascii?Q?2R5BR7xEWMmgNSXndo7fqQ1n0k061x1u6yKptwFByK3kUfoHZrz+9aUwojj6?=
 =?us-ascii?Q?GGWJ380vnxr2a0cp145rI3h/CK7jCwNGgI8NTzqcHy+fcnHHLGEXFCEpd7RB?=
 =?us-ascii?Q?8LECCsZJJOqZBz4Oj8RPj5rICPH7Qyx+0VK/Wl95gOj31kUS2T9I+sv6JRBv?=
 =?us-ascii?Q?TDFaQhTl45/gwgNxNJrnpt7X2MWaTp8XA5AR3XbQZzYKcrkr3H0eSjx//K41?=
 =?us-ascii?Q?sVH1ySU6FcUU8BziGF3FiR4106W0iIcz2XRIWSphOXbdmwMljxN8OA6yE49b?=
 =?us-ascii?Q?CsK2Pu6fC5Q4gQxqp4MZDhwjhANKHVgoj9VAAcZXItaQu6MC7GXnXAz3ANn2?=
 =?us-ascii?Q?dCNjx4oryGikocRv3UYeBIJ6eq5si40PQtn6M4qWHqtWkzmQBQK5YnQLvpqA?=
 =?us-ascii?Q?FX9aQq92O7Fp4JU2bCQiq/5koizcQvPJppS7xrn2/1EbdsRQfo6hCCB4IV9S?=
 =?us-ascii?Q?saXsJZMJIWyS0QkSY23Umdg3v+NMVQU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daa0f9e-4da4-4d92-aad3-08da1d6ca9f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:42:57.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVSccINGLeBnjLfUZGDbTdOPZoOb2SM8NR5bLezd12ucaarxwhv/TyaOzloHMo40nUsUJKi9x70jYBjUHE6lisPSs+qYi0hKyzbo/yEwus0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130085
X-Proofpoint-ORIG-GUID: Snv5fQ201g4woth129-pXydFnZgGdjhO
X-Proofpoint-GUID: Snv5fQ201g4woth129-pXydFnZgGdjhO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.

CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
the elfcorehdr buffer/segment.

This is a preparation for later usage.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..f7b92ee1bcc7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2072,6 +2072,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate a machine with up to 1024
+	  CPUs and up to 1024 memory regions, eg. as represented by the
+	  'System RAM' entries in /proc/iomem.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

