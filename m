Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F04EF9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351142AbiDASdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347972AbiDASd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0F1DE6F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231G1jvX018556;
        Fri, 1 Apr 2022 18:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yWoNHKRVjZwGw+zcyx9KdD6XOXygZk4oKNadM3igd3Q=;
 b=TcM18WpsPwHCvswwU/6BDBohVbcGkPBBhk2+wuBOUs7cVdCtuzcuuJEm2SneJRbWKgHO
 mavApsUPyAYsrNAo7TJEiGwOhNidSf/7S0JIF5leP+FSC3eC/cObIJnzOivGQoLAqE+E
 LbicdtzTHKOkFlJJDg6bqHiZo1UZzi+0QNN4x7Sf22xBfxNvX3lqbr1IpwMgRP8+iFWt
 O3y4bpKPS8XkWGyULbvNiA4L/UCyx4hwU5DqodIE6mm4UBsVuteChnLlesdD6DxV86WU
 F6t5WB53UEwWKKrQb3NXiM65f+HWogdmgBdevU1qAfURBkpHTD2BCEqvohLfaoFDzaCW 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0qs2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBOmF011959;
        Fri, 1 Apr 2022 18:31:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOX0gWbJUWqBqm+UtUKiK8O3AeUby50PVQljjgO4vnhUw0p4DH3MccaopWCExfcMN+ylz9/Le/TlKNTc7yhYzaQDHwCiwgRYU0fvHWfLzkUADG8Rw4ewlfZdOyZ0ULUs4ithGyQV9QqW1UD6qz9vCbV4G+f2uoMKkjMyxprh4w2HKh0EXo4SkAXD5a0uELNnDW5bysQcvkYwzh7HqT9pm/0KZ1BhO87H9QGsBgxLEDvqt3xB41KKH7JhozVKTLL4CohAJanzgT4XzBYnNgaPBgBorckQQM1Y4Lyij4shI0Mx10HQL0jtf1QX+YvGsUdl3e4fNfA4r2oauAJ6ABKOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWoNHKRVjZwGw+zcyx9KdD6XOXygZk4oKNadM3igd3Q=;
 b=ZyrCFC6RejEo1mXBBEd1x3JqCz0j+gGVffPQvISMx9EtaINkfHk7+AXlC995CAngIrlb/QuyFtlqOAt0f4sEsiGHoDpOLzw+jvW3j43bOd+oZiyojZwBjoOS3dP3tHMQ++Hl6KY/kR9FkEQ0OJjVp834ejJGKreiFkOw4gSIphNggR351ZKQxCu0FRAdRrsjmXkTlsM6+bJ0ZBCYv3PgR+bQkKd/plxcdTE2poDil6m80+N5eCZ3PmulvpWudpKnIhej0MLhD5ukpE5cMK+calsUzcTT/bEMF0pVt17h9P0lcfqE2DRlqTVYBiGLcvqH1iqSmAKPKjVpzM+QSUk0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWoNHKRVjZwGw+zcyx9KdD6XOXygZk4oKNadM3igd3Q=;
 b=DZCJKhF2scxZL/pjfsAKlz1dwcYz4hL+Wmrw/pn5tiRu1DBvG59XNxYZsweR0BDQgwnQCojbdNqMbaTh7JO1HF70zxqdz/xM7/4OcIOQKVFOw6Ji5/FSG1S+wZnB4ebrb+VoY50M9Jhc2BVBNjHI29JwDq+4Hd++eoBUO2F+ekU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:31:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:07 +0000
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
Subject: [PATCH v6 4/8] crash: add generic infrastructure for crash hotplug support
Date:   Fri,  1 Apr 2022 14:30:36 -0400
Message-Id: <20220401183040.1624-5-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a43a745f-75ff-4f11-538f-08da140dc97c
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5502EC49283DDB7895D7926497E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC+jH6T4rD8OhYxfY+60leEc2lfh7YvykWWkooBhc+CCeJcpSZDgTtsTvXZ1L51oFfU1N1sgNT8ulB8dJGhxrSuvS4rfZFyAYiffPf8SDktDeF7IKNZsv3ZFp9iHnDmTv3j/i82j9LmAIzefRmS/UoLIMxbjzr75CiQfQPP3QC5p+mD+pp3pKyJS0WAmaxIWry8T6L4VJNNsf7J1SMr38tJar1KhRsX1xm7Z0h7EapJQXWttGghKkXu/SQiU61Z85Cq/1ugniq4Dji6T0ksr46La5AYS208Slj+nrhzn4LdiKD7E9MFReCohkpDl8hbpoHrlBztBdkDi3vsx9Dbfd1dePe8Hbcvg7B36f0zM137K87pbLDy1EtcVfYQA1wjquKS2hKgIn40Vj46Aa6fJYRpTWUkqEyFmKsu/X3lZsqmO58x21PxLNe1BgFZ+58jK/IPsvBAN5L62exf9JNmdJZBvB8H32AEnRYL/JDFllkyTbIEGa0ptqw7jZfdcJH1hE6L1uz9QSXeh0WyqPxB1V21Lfi3Rvhm1NZTqkkL/9fspcTIEk0sblSBJPIYqUo9P844xMVgxAbWBlkcnx6e3gLffp324j07mW+SH2SVdOb6a3Q1qwfYasUbf5VjeJqh85Tzl/flh9/xY701lSlseJAREf+EhBAPwP7jg+lHmJjRVXJz0PvzieTggl8IL/SIITh++ii2brahTpKvfsDJuxA9AhvPMnItJXEeIRg0L82M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(38350700002)(8936002)(38100700002)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyRTQPCrDVGefcwOOWxHy0QUGlg2eYgJkjpPl/sM7ME0FYZt7567mSk/jrNY?=
 =?us-ascii?Q?xhsoCr50KAxlSlXzuCQNHRw1Tx/q1cAgWCNaiMNZFAXIR5b4lalEb8n9mYu7?=
 =?us-ascii?Q?pBw0nN/jNl4I1zPi2vlHNB1ZeiAvazqHc7ZyzT2vp8NN2D0qej4qOOdYeH2t?=
 =?us-ascii?Q?o7doGGM93itWu5vXw5OijGKMV20bbsLePD7GBZd/kTT2bZvMMDOXG8CZVo4W?=
 =?us-ascii?Q?cwUmgqRfFnoQ+obzayaiioX9JMjbvBAizZfkanH2/bUMemzAyNK/ScB7Qb16?=
 =?us-ascii?Q?cvIeJspTC8pI7QO1RVp2QsoSZLYPzUFZdZ9gndC3K5VlNTHcXV2muTL8TwBC?=
 =?us-ascii?Q?PKM4WUyXno91ePQklies5Xu32QuVslVrIAN6A+TgVTe6KvFQVthNs9Rxi1LD?=
 =?us-ascii?Q?HtfHabNzWkB34t43ba2UJug6M8hisi0w0GUcvDoM1ZUcVU85ZVZ2fVFq3oBZ?=
 =?us-ascii?Q?0CBQs0v2D06pJSR74L9JESppJwlhwn33FUJzfWvGNop1O4xgQq+tLg98haVc?=
 =?us-ascii?Q?q84rfZMTJM7YhYLZV6lYQlzj048e93T6gWUtjbvLwRIg5Fck6LrmvSyFGKRe?=
 =?us-ascii?Q?/EChWHLAH0xPq5PdnOSMItg7TJuBb8bfryyPuqtz3l2upQ3yP8UzKc0h6YiL?=
 =?us-ascii?Q?9/dsTPRK9FlRoa2ByFKkyfiZMkczwQb9tAikD4suGHIofZnYsZOC8r7Dm39W?=
 =?us-ascii?Q?fuOpl6Q1VvDVFdwBTvICzma9eR89xudUwqzBrSs1wTnvhaiv88K9OGeHU97W?=
 =?us-ascii?Q?H0NIlLNCJ2WIpMWI2PbR8WVWqKA1CzdW4Gikk2jJUXoDat1a1zigGe1liNEc?=
 =?us-ascii?Q?VBlswVTiCBJt6BCTdxkla0g3FglSOvteBd2sBb+ZUAYKnBx2LRxNTpP2Rdfz?=
 =?us-ascii?Q?Y+Mk4h5b4rAgrYVvduULoXxlQjzy1w3jJtcfKPqFr9dZC5GyLgHnndk4v4UU?=
 =?us-ascii?Q?muqLSYe3mVBqrNQ5YlyVzWPIYW9HcFw2GxyLbz9qC2s8b5QeIaldeiUGmNkL?=
 =?us-ascii?Q?5KufAru/Y7FDDkWzzj5RXSDUW/Aiwni0I1bCLjJWhqV8kv6/TlBxvn0JDpJz?=
 =?us-ascii?Q?8EblC7HpsLxg6KCSo1/Yc8AYCNC8kcxlbNlaBYixvKHIhyPaohM89hiDhhCG?=
 =?us-ascii?Q?u4d8n21Ka71iLwABjpohMd/lQg2H2ynOmqXPusVYZu8guTKuji3OI1TSfPeJ?=
 =?us-ascii?Q?04v4f1QFCqipXM4HKvm78BPlvKMpdXGXGzOn1wcuU89P+5tgsk2pTehZdMr/?=
 =?us-ascii?Q?tv/2QtY8zoe+jzxR4j3wqU3nQSbKORm9bwmt0l3Xde4K+MP2sItV4dMgqy+S?=
 =?us-ascii?Q?foavGjacX3Ktpv+Tf+/E4AuJj2j0Z73ZFLWo8h2dw0QtBOa0oOInw0c2w+C9?=
 =?us-ascii?Q?cnFHxk3zzHzAZKNXmE0MifgDN8cy74CfHxl+Xxc6H0R/EG6HTjhVvd73BXd1?=
 =?us-ascii?Q?egJJ7J6Fzda+pi4QKcA/eew0LHwTj5TjBAaQIYxJhdRYvVFV3+qdmI7MKsnS?=
 =?us-ascii?Q?THoc2itKQRdCoAv+18DOXPLPIZ9c52OUMT0wo0OLpmkTutC9PT33dR+XMwKn?=
 =?us-ascii?Q?bwjmxaByjTNr48zjTFNEW79bOGwIu6xvkodZ0ZwBUzkJ4pT90tddVF9+dfQK?=
 =?us-ascii?Q?dJ6Ub2CVH/fx0zXMD0d2GukIibFZ5qiFZbf+pD42JbNcEC/StOYKVxfl65qd?=
 =?us-ascii?Q?LgnV90o7r7JRDb189TQC1piemzZCuoKStHGIAwxcOL9bbmmt9nF5rLz1Rcq3?=
 =?us-ascii?Q?y76Mt7rif22dd4xy0ps8bXSfjYHwlOA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a745f-75ff-4f11-538f-08da140dc97c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:07.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g31fRlFvUZIyy0Ftq0/vs+i7i3WZGU/opQzjYLamm6ezSez8hAKEXsZUiuPES4lDQtltj+IU1BmYqkifyWGKvn8Sgq8agb1gy5LcUQbYwbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: 5s2GvxdqA1BGYI0bnmkSq8mucEzP9u9s
X-Proofpoint-GUID: 5s2GvxdqA1BGYI0bnmkSq8mucEzP9u9s
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
 kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f93f2591fc1e..40e426cfd795 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,6 +306,13 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	int offlinecpu;
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
+	unsigned int hp_action, unsigned long a, unsigned long b);
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
index 256cf6db573c..76959d440f71 100644
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
@@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void __weak arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_hotplug_handler(unsigned int hp_action,
+	unsigned long a, unsigned long b)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
+			a, b);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
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
+	unsigned long start, end;
+
+	start = mhp->start_pfn << PAGE_SHIFT;
+	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+
+	switch (val) {
+	case MEM_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			start, end-start);
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
+	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
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

