Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56CD51C869
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384751AbiEESvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384659AbiEESuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6491030
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245ILr99003197;
        Thu, 5 May 2022 18:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fkYzI4tGrRreafFG3BighWKGefPYoK7WY+ZHmBuphls=;
 b=ctLwFJPqIwbfAbk7wfcRuSIsEnMH4DNAyQFgfBdV7C9VlA80Herk3+DLhIQZZnubk8Xa
 7rXfjVN2STF73g7ckiAUyimJgQZtFWCiVoPQDBYo1S+EzncTwiNaLrZvmTUGL+CzE04b
 ZWCfGx6JZUoWPmZVOLaybSOPksbjc3LNYyG5PjtOKr83HNxrAg8zi1Ngjj5IFK6odUTK
 Q6xFPnwZX55IYkbJFNto6jLIm254L63diQwnKP7tP2hh6xAh8DvLWs2wxaAOZ/LwNgPv
 GOJ17e4ztN0ACt6eDxhHHPVNmurLHuqZ7uzLuVcTZMfxt1c+Eh/QSuSDXFQmVSGK0k6M gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0auwfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Ij0Xp037847;
        Thu, 5 May 2022 18:46:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujb58k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlyWLqXOK1FU/Vnypo/jrYk7SZzKZ4OmDWgRxtC/Wa0Pk+Mx/GzZDOPvLp9mx187ijvD81ltPvPbYxMUYn/nW0/9llDI4Oi7qNVi6awffHxpnlADnfGNogtuElyR1XT/VbjACmTnDeLQz+O7YJZpjM7UcX8eJFlhwZVtfGR9gdgQ+/jcJ+1wu2dOch/ttEV9CFAc1mMWK6cgv+IVmBSyBcYDGyQMINE6yB5uT1Or54R0nr8ziF+YG9NDYoqH1Ji8Pzt56GbqTEPY5/D8Sls8IbDW3uLrnVksiQaGz3v21zzaqVTvMAD+eD29mDht+56utV5Tz36tsYDRSieyEOrKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkYzI4tGrRreafFG3BighWKGefPYoK7WY+ZHmBuphls=;
 b=TapTE60Qxs8WVyoC1L93pVMnHKl/J0A/JHYP+bNkSXA2ehcYqrvwgR+3kSkXtcs9hg6Y+kgUODyW+v3R7HQPPEspfIiBLsXkEifs0vdpc0Q+CTvY07b4kHmaUKXIDQlQLjize1OOslqdhqA0U/7tUPnozy4cH18uPNuvXyyvjwzgsBb/mE/YICpCqlPU+SEI5NaZRYcifSaCR/95WZrb/WmkVk0PduUHCwAm9QquEtbteH+MID5TI8fON+nC+rzFa6Tfe8GVJvnQPDQlXYrrqShiK+FRK/K2H6HAJdTxVMam8jM3pBGI/0xSFSWiLtM+jOsG/fsfbGCXzp/uorthaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkYzI4tGrRreafFG3BighWKGefPYoK7WY+ZHmBuphls=;
 b=BbRjeRcRsiaiPUptLk4IgHxM/47pt0JCpkN0GYbYyjxZs53iQyZkGUGxvNoHp0ckmyr5+xaz3XW6Fkc5+YsCPeK5PCx10O1wja/HHP8h+IMvnLtg9Jg9nVZc371inN5km1Z/NYoY9dRyBYfgPI/4AJSn9o/O5ScOIWU77Zi7GVs=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:32 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:32 +0000
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
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Thu,  5 May 2022 14:45:59 -0400
Message-Id: <20220505184603.1548-4-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a01f51cd-438c-4cd4-5913-08da2ec79283
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB18758DF45A870D131EC6E9AE97C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtPd/vBCcyFsP3bmgq7AfukgwpqjiNXonRfj+KrZMSPqkIE0dsdzMDCS9NUq462jhsDP/O4Dv+gE0KZd59DSHmvVm17TT40RF/iw6PCLduQ0V/RVaavOuuggOSS/cHVaX12op5p+nKxmPloOEoI5IrsWAp4nk1oS9xI5vPBItEMWDWX1bNk3/N2CjR+v1JkWokL59z0NA0iuSk2uSkPlNItFSFQTF0nx62HhDol/h331YwNKJeYkhdEUrW5I3KwL9x7y5YYZIUgK+Gqn3e6EkdamGi7DTbPpKoni4iJ7CK6q+g+kCiiubF392cr2uhX0mXJkGvQELC9jkFfPaFfCHbXBOZUngIA2W8C4df/Y+qD9rPnRfQkBNZiu3FzUPjQIOSxnxx52oiLLle7Xt4cAaSSd7JEbT3WPY1tY+xx2g1BSAWYuD1zZPzPPJQl7I727USbxxLwtAr4Gp5Mia6ioWM1gGAh6aDY+kochpznqC1I1Ln2YTDpNyU/LIaMQf24RojmAyTTPDBedlg6EKxb/lBsMypaQOnAPoz7U3stsXZPVEGevoTHSnv3i9fjBqcHo1Q8wiu8OeIIvSj4yQqZxpr5htZ1+/v11nlYePkoZ3wj607CazvMpc6Zd1IMa4CACGgp9omguMt5rKOLh3Jrxf1l4vupRuL6h9pqJKW3rYO+nEMfLqm2A6yeTtqfRkY/qsuNruKIKoHVY3ZQpqxAIf7mPMiXV5419SdaaQYTkR6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(83380400001)(26005)(66946007)(4326008)(66556008)(66476007)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(6486002)(107886003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JfnBSje1kc1PfGrWxsglT06ciTqdwXfgFapkQimsulsp67Az7OTMlmxzXpK?=
 =?us-ascii?Q?ilhtMIF1NpiW84q5scPevK0ziHKu4QXyE1iTqENhtKQMcSzADFFGZQTtjw6G?=
 =?us-ascii?Q?tgsAyCAhSatS4jMyZuGTlRRd9+dV6eC1Ds39X2bS4UOMyPQdEWL+e3y5rqOn?=
 =?us-ascii?Q?vHiftWFlPO/3v+rUldiDrrVIR1BAh89G2JDUNp655Ms1FbWR5n3Las4Uo3R1?=
 =?us-ascii?Q?WF8zuEk7dLgD+CrpL3PW8kKKiv2NDp/Pb7/J1tfFqOco7dmVdacPEHtKkrSP?=
 =?us-ascii?Q?VYvb7xmzyKo49vONH1OOK6x/HTZBxpcAKBW2xVozOh7x6u7nwK1aRGrJlbIN?=
 =?us-ascii?Q?GPEo8fTanuEGw2tZ8pr+ornZbBUy6+DnzxoNeVV7XpBqpPG/PJUh1oh7M0Tf?=
 =?us-ascii?Q?2ceuFbsu0+HXQsQrPqvV4I6+xZ3Un9SCVYjdrYHGbGhX05kZtB9MG2yzS/Po?=
 =?us-ascii?Q?C1oTN03jTFAYUFTgRow58fzWbXsRjIeCXhUmxMmT69ZkigVTjbXZyJyWCRRb?=
 =?us-ascii?Q?SSnA27B/nhCMlZzhoCtMdAj/9LzOElUNxqfPp8xVY3EU1AgakDK6Jong2nXX?=
 =?us-ascii?Q?dlUVnsBbNAKzHtRgPuxaAWUT5qE+P9epw0AOckDFPT/5rPe30grcBOzOY0c8?=
 =?us-ascii?Q?F0KFXg/nCQpcf/ibqNI7sEs52LgwJNwdzXNRR6MCHL0kWo1egrPkxHboznwi?=
 =?us-ascii?Q?wr7IAOEjl5OT4FyqY2iGmAWXLRKh8QG9goGvRJjQFaHc8oqbGG6W+4HaMJfT?=
 =?us-ascii?Q?gAKKBbPx0pdEK5laskf4WxVHA70YUzCFAziqHcIVyiCm10WRh1r9fm9rHYww?=
 =?us-ascii?Q?BbwWLJhYN9o0dWpIbo0g3K6VqMUOy+YYyqXgFf0SGjBPT3+QiGypWTHRO7yC?=
 =?us-ascii?Q?n4s4iNo/jrhuou3p0zrErZzSgqi8R29OrHPCxIEXqX3b1+s3AfA9yadkUhua?=
 =?us-ascii?Q?tPx/YDn1YBfzXadHXoFyGmLIw9QwraBzqXTsaYgh/JpwU/DgD6KErB4cvwID?=
 =?us-ascii?Q?zLllB95Gjux9ivVDo0/8tj/M5GJ6N3JdlT7hVAHwu+wE0Uf/Dz7X1oaj2mFd?=
 =?us-ascii?Q?ReoCgxN2AhdkfWt5JeJD/YmY3JQ3lqTU6jZhZG+NMKX3q8kvm/lndq2RNkQJ?=
 =?us-ascii?Q?Q4Mazqmboi84L2pXczVjYyLysTnwhQDRoayJsqkMvOJ3bSH/65vRXaYaR7t/?=
 =?us-ascii?Q?QkG3tGrG8abkawtOHDig+NXhK18ETIKQKvAepMqb/JdayNZpxk59op8nPF89?=
 =?us-ascii?Q?ylmFBqBu4CEx+BzNIk5Qq36puaeKlfVuu3NESu7o3rPkKdXgLG0Zb6mA7nIa?=
 =?us-ascii?Q?hJ1frxFNWqEpatJIPwu1atcsK8sCIMNLL+50xLr9rZa7VWhc7u49IacITeLg?=
 =?us-ascii?Q?tdgeI0E8gpQB7TKvSwmo08TyhxxVKr3xk4FKuxRD09cyr58dn9OgunP+ADXh?=
 =?us-ascii?Q?Mr2c0qdbJIznbEphgjTDAc3pnVgLSbvlaMrzAkKpaXYeB0fVHY4EPX+MVOR/?=
 =?us-ascii?Q?nlltbFWFOqZO72WJD4StHqcAFWu/ZZ08qp7rLgNU8PzZwUggHNtQXhhkLixN?=
 =?us-ascii?Q?ArZy7hb5FqF5Ypwvjd+mpK2DlbSddyKn6Ldufy45GJ3Jk+dD9R+I+gdQAhc8?=
 =?us-ascii?Q?9Yrhs4i8DW6gfbfCQSYgo6qSq/c/2WFEJn7f3Sc7iesU7sp0k4g4xTVBz0DV?=
 =?us-ascii?Q?ZMBQ4lUibdM5lPl6RMvQ9YkD6QsGNtl5MFvnc3Ar2XM5SQJWC1xfOG7sdQZ/?=
 =?us-ascii?Q?9/Kv+9oHW+VPK5LUuBYzibDNwuFpp6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01f51cd-438c-4cd4-5913-08da2ec79283
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:32.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7ysODUfQlMTyRDRn0SJ6a74voV7qKSi2u/Xw0LQ8ZrYZ7yRx+xRd0rOLyhNbzIJ3YBXt+J7fDzKi4OaGSffJPdiQ1xh6ZBzVoZU7f/8FQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050126
X-Proofpoint-GUID: dHiZuK2pmXvGnMf77oqsfh459gzkSJhQ
X-Proofpoint-ORIG-GUID: dHiZuK2pmXvGnMf77oqsfh459gzkSJhQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
to handle the hot plug/unplug event. Then handle_hotplug_event()
dispatches the event to the architecture specific
arch_crash_handle_hotplug_event(). During the process, the
kexec_mutex is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h | 10 +++++
 include/linux/kexec.h      |  5 +++
 kernel/crash_core.c        | 92 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a240f84348aa 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,14 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
+									unsigned int cpu);
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f93f2591fc1e..5935bc78ed7f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -308,6 +308,11 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..f197af50def6 100644
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
@@ -491,3 +496,90 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+void __weak arch_crash_handle_hotplug_event(struct kimage *image,
+							unsigned int hp_action, unsigned int cpu)
+{
+	WARN(1, "crash hotplug handler not implemented");
+}
+
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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
+		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
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
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+									"crash/cpuhp",
+									crash_cpuhp_online,
+									crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.27.0

