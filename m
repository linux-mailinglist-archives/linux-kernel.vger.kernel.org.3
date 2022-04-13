Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEE4FFB96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiDMQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiDMQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2167D2D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DFqIXv028053;
        Wed, 13 Apr 2022 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jSI0Q4XRc8yQsgj8DRvg9GQS6O5v8SmKpNQ/Sgo04+o=;
 b=T2RbFeA+/GbRkyI8oZcHIMNa1ZGDOpLUDkWp5FfG5F6OofSxLsAer8jN4P0mKYCQuKhV
 dyotNwXJvE+Udh0gH+z5PwXMp4rUm9YPGmcvxOcIA822BgurwZ7wR3XkT83+pg6L22v5
 To4r+hjhPZsn8mMm1YLxQqmi1SWPHotxJGsC7DuCx9vL9jLCdOyrRHWkhx9KOo4Q5XRz
 Qdef5UG9KP/h7Hk6oZtuBQpDsVB/Tk0EJPgszmpn8dTCCZ+7xeInWJ+gOiLMlc2VLEr3
 k8SMgK8KxsaV0UiWHTnlFMkWH8aXS0Yvysle5VaVmCMsYAYqEnJiq7w+IEFabhZbKMUf Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a256a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGRRIX008545;
        Wed, 13 Apr 2022 16:43:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k45r6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8/xUh5dA9zqrDLmTkBjBx3Jnk65TmF/4rFzO8UkiVD+M15Pdo7sjkqxwRUF9ccPJ8uM0IVlkWsYgThZBlJICFGRBO0xiUh5mp2vRRbzoDRWbZfGt56knCgD3OZm+W1UafsEH5epDDIsuvLp6ut+/rp85326dSS8Q9dz1aJBjKxWLNQQtKQ9iORInJcOUfTTH08kxVw0a8LYbtXw6u7+3nQcwM0iMvv+Bn8uUh8FSkN8OSfqevCFn1vF+znE6Ng7qWuVqlU8pwarWfnceNUx9lrrtKGj2GKrS2pkT8IJNQBKCuHOyoXmfa2UxwfVE9YiFvnqv13dbzyuO0mog+rFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSI0Q4XRc8yQsgj8DRvg9GQS6O5v8SmKpNQ/Sgo04+o=;
 b=OCk+KcgypCZ170VK+z9IYB3NFbQohukoqrR+VqbJ6ikRgRxJmHJg9mTSUlu/KEmefL81yM1ezaw/GY1t0ZScVbXlP8DYzLq1knDpnlBlLmsXA291RIp/bnspv7iHxX/telccLPQDkzdg6fErXN3U/7quXnBdKj9e+nctLXEkNF10aH5RDz8/n319F6VRn1/KpOcJ6dwYeRNnRSDiYBnUhw6QRAVjcszZ0bWh31EE/fLxVebT4s7e/LJvXtXKHr0gT8y7oOsxaeapgI+4OoBM7kLbnVkbwFzbtBHFAjiiH0HNJJDU2aJEr977Sox+wUaiMCxfoD9wuytgmJc/Db0mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSI0Q4XRc8yQsgj8DRvg9GQS6O5v8SmKpNQ/Sgo04+o=;
 b=W44PgHcZdqvfFnC7sB9EYjAnUMv0P2sqLiMyPgVbYT5Nxpz97ojLWXsRgNAihKTeYmqEl/+x3ZmXS137IVsd7scfSJQRUwsfeJNN+APvJ7SifX5hMd5IaVffg7bpGadAL6+g8WUhK4i/p3eXvOSDlD5Ci8yQywmhmR8l45g0peE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3562.namprd10.prod.outlook.com (2603:10b6:5:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:03 +0000
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
Subject: [PATCH v7 4/8] crash: add generic infrastructure for crash hotplug support
Date:   Wed, 13 Apr 2022 12:42:33 -0400
Message-Id: <20220413164237.20845-5-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31beb45f-5de0-4479-5a94-08da1d6cad5d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3562:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3562BEB5DD112301A00272E497EC9@DM6PR10MB3562.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVpRbwj4Xjqynb4a44EAPzrBJWgxp3/oQCI+XKMZq3QCEL3IDexze18QTJalT0K8ggwJrqC9C2mTtS1Oyr9RsWumMmYrUl9NEx+MmsPAvLpg9TKISb0VW3be7ZqMDAsS8wYn08RUgH6kFIT/jRr7+tpGCbEVyuaL80MqHzlfZaOcA8DgB77YyRkYmRv5i2LW0WojbYzGfflJ7ttUCWc91zIaWGlATMKqKwz86Ats4qAGB1dVN4YMWbPGG6DKtnBRd+vRnX96SleWdZbPkkKi2tHjhG9sutDBCxI4creYWH/ajXtpOSOfis3DT7E9wRFCR4MRCvus15j2LAaWvav2Z6s3uODHpmTrhgJT41NjsXJQ7PCMUfnQul19QrZAtfoa4WatU029RNcRKoIaklSbaefFl/iVstYQkYZG5N4YOtLOUsKk02SmDKImgwIHcBpG6yXfqzK9qdC9ocCVPicj1HA4kv/2UqNXbonCRpfb65gOlnqV4nkIUtgjwE6HpfEgEkeQ5/0IXNWtJlof9IFPV/j8uKErjsnNnfzGz3KmCav5yXmiD0VQeKD5jZQ5zRXhcpjOefaN4+D3yeBllf9TfICHYFGfvoJeR6D++DoMPjhg/100YJqK9/ESezGl2wk+T/nVeeY+zvQ3rfyFMEHwpOFQbeuHQm2Dm0i1nKrdZpM+yn9PGg7GapfHe1rT9U48JQVAnfGXybfywb+xHog06CbR1mocqNcyaVqJsr3EgFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(86362001)(66476007)(66946007)(1076003)(66556008)(8676002)(8936002)(7416002)(52116002)(2906002)(6512007)(38100700002)(38350700002)(6666004)(6506007)(508600001)(316002)(5660300002)(2616005)(83380400001)(107886003)(36756003)(186003)(26005)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01zzCYtahWLx3XJNuErZr0S2kr9v89NJjMWdqOtVdBlNokMX4nSairloNBz0?=
 =?us-ascii?Q?fK1nsXDih8skgWjx730ynWDV4VF1gt05qGFXMo2F9lL2HVO1UrnfWHyMs2Vr?=
 =?us-ascii?Q?eLmK4Yynbgdyej4jzbds+yEZCbpL6yVgj9863yLDOuLYcGgpa47HQQvbRiqS?=
 =?us-ascii?Q?iuRPhiGrhGmb4g+YTMNtAqxDm19j1cpPnYXLxJAvpVehwZhtjDRTaOhOf3AM?=
 =?us-ascii?Q?U5EHRWGO0Awl4xtmUoDlXYR5H5tzyYDwVuKqgf9Qol7qDRea8kCFgK1ZDila?=
 =?us-ascii?Q?4b/pnHpdXbva5JdSqgKNBuzyoHOa7qxZurptCXlu3Q+NSSwTSw83LHjg3iGz?=
 =?us-ascii?Q?xREARWqo8RVAJ3NgX+Jx7lps1KUyrV5agxGpKiuRfEn7Bxz408LJHLWRG+MK?=
 =?us-ascii?Q?npW897BNGtYe8PCd956gSDQu+tpx/M7qg5TuVkYzdPlOE3H1/FHF4ERSBF1f?=
 =?us-ascii?Q?ewKZj5W82EtBIkflIAlxTWAuurTpp3bm6noKQMg+vU/kO/yUonLhw/sVXkdH?=
 =?us-ascii?Q?EBiCUrtMctrphBc/7ui/CSV7ZLC2+QjIos0KDuay1A1p60O55mpnqplSXmGa?=
 =?us-ascii?Q?z/UkJyh71L24H96K3yqHC2rFLGTpdp8YMjtVFDWikV5/gSgYmahV6Xcbk2Y2?=
 =?us-ascii?Q?SgdfU/ZKdJCtn1aezRLaujcWl1LwFfRYLrvmUFNwVpRPal2LOmlFPPhSeh7t?=
 =?us-ascii?Q?nYs2I1u2fqeUdppoeWUbJy00ViBBmsN9V9IsolsTL8NjYJEfZ2RmRQNtkv9t?=
 =?us-ascii?Q?+OzCEbHSmCJYkgmAYoicpCoi1RE1x0ayj48oKQ9jpKTDLeGsYPU40kDLuxdW?=
 =?us-ascii?Q?MIMeAXhLk/2a9reQIFEFC5A+mxp7gsmQ1owSV77ouPLaj5PZJm/wctjUdXB5?=
 =?us-ascii?Q?mt6LXkLhgyLeVCkZVg3KbK2k9447Q4vsPMyIUC89xklYPvzLD1JqBXbbK0Dl?=
 =?us-ascii?Q?2mo5ufheiOS+GZKMEgtFewK+HZzRh7v6r5c5bESpflnf+E4KcImESPjK48l3?=
 =?us-ascii?Q?rwvHmJVNyLmsqxTSgY3kKYjDMOv1ukXQmjfsQu5u+NcSSm/oWy06haOhgzzn?=
 =?us-ascii?Q?v1UKSZ7Dc406T3+VkKEQ+uOViBk+4aLsv+0RT0oNg69uFiNnuI7nmuODOVdt?=
 =?us-ascii?Q?LXjas41u3S6wFgx86P/9/QbqDtQCgpzHybsuZxEVq+hcMu0lSwIkbi7VpeSK?=
 =?us-ascii?Q?IRazFKQjX+IBkBtrtOa6DUACWk8cyD3T/VRYP9VF9ISmVxcPZMXDYeDW/2MU?=
 =?us-ascii?Q?CEYiXr62pgrvLvMde+WLOJJI7Ip/h1q17qJ8h08O1SBxe0mUDLOPLIK6R1I+?=
 =?us-ascii?Q?RPnb8siIUfT7rKc+yilTS6OS+uxnfkPVcb+xxS0pPVm4iUi/cnF7OxKh8e1t?=
 =?us-ascii?Q?BKBjrnrkdtjgXF2v6XHMqzOJvaEdwC7oCa8bP4kSIhWtsVEkFTLe9AsIf54y?=
 =?us-ascii?Q?u2jYFqBzNOV7x0AhTv3S3gRkZrJJ2ORr6LZ73B/j8M8wwWhwgbEMUpSvrCER?=
 =?us-ascii?Q?dERuB/NGdWzugMif9WGElYhIxKvCwbIvyDSJ3cFRhYPEsTTIONqwFj5A3o+W?=
 =?us-ascii?Q?Lz3iqlkBkgvUpf/F+kQOdtqHqhk2r6w11EmMCiw/d4D52TXVF77nlSE26KS6?=
 =?us-ascii?Q?CHrpwyFVILwUXzuiJkBHrjJ0NaQnbpXbNECv7T7c0LlCaCQN+BoWG4paLQuh?=
 =?us-ascii?Q?CkjtgxiYpd3ddHsfhoeBVI6YSi88cJAxrByXbvy57+e+laE22Xp9JLHIHI8Q?=
 =?us-ascii?Q?qLxjHEvoP4MI1wuumUS+ZhmexhVHbEY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31beb45f-5de0-4479-5a94-08da1d6cad5d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:03.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSk7JvTvqscS+HGZnTyjE8UDtCG33r4yZViltMdtGmbCdBiLnjxagddN4xKD/uSCM1ZVuoQrveK5BYLfP8m8cz5qQeBeysoaDH+VwI2fDQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130085
X-Proofpoint-GUID: BxdjslT_-LHJECkwZGGYGBaR23IghPun
X-Proofpoint-ORIG-GUID: BxdjslT_-LHJECkwZGGYGBaR23IghPun
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon CPU and memory changes, a generic crash_hotplug_handler()
dispatches the hot plug/unplug event to the architecture specific
arch_crash_hotplug_handler(). During the process, the kexec_mutex
is held.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and ofline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifier then call crash_hotplug_handler()
to handle the hot plug/unplug event.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  16 +++++++
 kernel/crash_core.c   | 101 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f93f2591fc1e..02daff1f47dd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,6 +306,13 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
@@ -322,6 +329,15 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned int cpu);
+#define KEXEC_CRASH_HP_REMOVE_CPU   0
+#define KEXEC_CRASH_HP_ADD_CPU      1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
+#define KEXEC_CRASH_HP_ADD_MEMORY   3
+#endif /* CONFIG_CRASH_HOTPLUG */
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..ecf746243ab2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,12 +9,17 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
 #include <crypto/sha1.h>
 
+#include "kexec_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void __weak arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned int cpu)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_hotplug_handler(unsigned int hp_action,
+	unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
+
+		/* No longer handling a hotplug event */
+		kexec_crash_image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_memhp_notifier(struct notifier_block *nb,
+	unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+
+	switch (val) {
+	case MEM_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
+		break;
+
+	case MEM_OFFLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY, -1U);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+#endif
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	register_memory_notifier(&crash_memhp_nb);
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"crash/cpuhp",
+				crash_cpuhp_online, crash_cpuhp_offline);
+#endif
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

