Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355654A237
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiFMWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbiFMWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:44:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403931239
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:44:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdWY9004212;
        Mon, 13 Jun 2022 22:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IqYiYFqLO7HqMHooEsPe+Omg0Dk22wn+Y3xfUWyr+pU=;
 b=FV+7aNdPGQ0/+iwfuo+gZGEhDsLPZ9WlPsQL9n+nQpQu8w2hjmvcgJ6SL3p6vzTPVGRA
 CcQT/UMoRf1JdI9GSb71tMPYux9xdCkUdsRY3X1LzyxE8Ow7W/0sdrVG2O1ArUPxfjm4
 NqLGAtWFAdmE7a+mr7j2F7ledw9EuBFLRTpl+xMLyFyHmhytX0ypElSwImK9dqmYSUVt
 uOgaAh2HRT+WJ16Flt9eo3XCMxNdRdqEBkmLjI3LJjjx0sd2QevELg0euKy95hMan2gF
 gzv686Rgrx4Fw37Ghqsj/1es3iQX4tq8bHkTXRdRjCvB7jT3H7yIxnaoY9FgzI2hsDsH 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mcsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMeY3M035873;
        Mon, 13 Jun 2022 22:43:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe86g4w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMcdK1FNLZRtiVEEIjFmmUfLXDaFiiF22mjhu7/pdPeyRrAYKof8ZXTQIAc2MTIDN99SRRcBhZ/iG4Mr45cVPkAnsfuaaOloMtnyBFRSVq8E9/BEyvzSrIf347sgcy9aaTaDes4znFdulNAgs3cI62EbquDg1Ej37O5/1ADQlRcFEYl4uZOK+Lt2zBQkH3rU0PehaSfx3B7RzVp62UmeohGyMmUBQpINHFVVqbWX/YzjJv4xhCsd234Z3ZTyAN8UHpcdI98f/9WjGjxquVCIy+cB/rnrRnqMhK8oG6Sfh7naQUqfkxdgVkmcuW0ewPuwJVLODpVxi+0vI3zRssMmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqYiYFqLO7HqMHooEsPe+Omg0Dk22wn+Y3xfUWyr+pU=;
 b=fgTATUk/1SdHs7J9m1GqItLVY1UeHEx4eXSx9FQ8hUVVw63wNVpV+4f8LVG7mzj4WRfgGQJ25Mf/RCaxteLeBKpET15Ean9I7g7Vu+EiiUPBAp1yQDzfggHgxFKfiBF7u+/ZhxsAHTSkb/BUqYhqc8OObZYI2hlXR3/tGpesViTNfi8yFJsq8XnaM7n0+2ApW2iGGozPmUrHR75k/RshC05L07vX/2ejVyCYqGi6HQ1+9jdSmnl+TzRI8RzeNeiBYAZMGL6CRq3Li7Z/c+byp/u2O/xJ11N0LlhFdsHKcnfD3+y6CA3yJS3So2vIZbKeE8VMDJTNAUdwrgjA4uaW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqYiYFqLO7HqMHooEsPe+Omg0Dk22wn+Y3xfUWyr+pU=;
 b=D87YGynoIvoqHVWCF8/RMT747vVmWvlrtvUV90CWwj5v6hMy43MfuGEPfNhdaAUNl/fCJmD6dU5Iyqig3yfNHZ/HeiO8WCGudCGG+bCM3ZjqWk+9p5cGYiv7ntwfBpL2AT286HAVMSR5U8ZMuBGyuuKzBCZP8jshtI2wPXUEFCg=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:08 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:08 +0000
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
Subject: [PATCH v9 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Mon, 13 Jun 2022 18:42:36 -0400
Message-Id: <20220613224240.79400-4-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85cc932f-a0a9-4784-2197-08da4d8e1678
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3824202086614CFD5A553FE897AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXJs5FndtmCTu3EOzJeyuZPEsa6wG5/WRiGMXxFJBTOF9Eh3d0J+seVnvM5Xq8mtI1tEo1XnGIgAWLGsK43NR23TgZZD2R42RtGKRyy+aIGLJX/ywsIV61KQVYzYKsOC5bfERR4nIXxtbm8whoZ6ZGvWPwox6IlTp43ezDMnvz+08pJF+afxLIhCLk96hCcqj9Hzm8yslLr+SN8FNhfhemyaZNvR4veYnvavK8p9Pju5w1obseObXxKDQzd5CaY6b4w2aeWM5ze0279elG3U6ux+JWRdxfoGJxbT1hXkTwrcAxuzTsZjyKSlkF0+EIqE0XpkgJfPYOIW/UMbFYOIP+dsSkP4Z6ghkumF5Wv/B4NRbJthTGZd0qRbkD3O1Ly+0kQP0ZA5syUACHwF+eLBDShW2a6UlJlJTHtc20xGxsddxauunthNbrAGjXF7HYDP99xYvUgYgI3wLMGhRtL9s3azFkY4pZ0drc0JaZs7JvQP56Rd9dkQbuDzN5pNhQ37+jo0gp6087xoHTW41/LXF2rp1WLdqTCukxAQXuSLnoFUyiI0MSVaZdgVChAba5z4z3rbNLvgaGHbBH/tppXkqR5hkLlr9siVufrWkCDpizCYpxGiidFzpRROcL9R3kgcpiiYZpkbQtH7b2H+UlcQ56UtFJFdoJEGYtbu9r7Ceo7ueu6PImC1YQcCKBQZH/q4c5XJmSxDhX+RdkLqpkOHhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ip6FUCAvsLTT7iE3y6WK2Z5OCy0Ky2Kwccj6ztxQkz5Ffzzx4mTIoJ5z9tYK?=
 =?us-ascii?Q?1B1sUCtf4N1ezHCu4RZ7nOxtoaEol0RyvZH5pF0jh3pB0I1+2DI0Ej0F6/MU?=
 =?us-ascii?Q?GMp3nDqQihD7gMA8DKllQcdm+GgTt66xPTC5VcicNFoK0PjkgdnZJ8KX+GG6?=
 =?us-ascii?Q?gZPHnciwGbW7K+lgSwm+tGO3+yyY2P1kwNzBGqoRvbuNkQ51RofPqsNuNmfg?=
 =?us-ascii?Q?YfdE84kvi3X+dFgkN8OOkEoOEmcL8e5xiQLTL8ATiXxOe617N415R9nCi2Hb?=
 =?us-ascii?Q?0oRLehfVphkh9AyyPohbD7Dw/OMYev53KBsuR82iOUpIA26LDMjGYBlNCjRJ?=
 =?us-ascii?Q?yShx1zwa5sD6IeaadWAKiZDCdh2sjpG+FdMXjX0zfAKVfIDnGn2MFhsNeB3a?=
 =?us-ascii?Q?z6J2ZczGc6xO0wMcHZLDwrLm2MVFf3Of7UnLwXmAvSg1hbuIwtxs/2YhQQik?=
 =?us-ascii?Q?rX89IZUKs24mCRJ2A3OkoM1rcYfXV+WTqT2CvbSIhl7h8zph1kwVrB6/9gAu?=
 =?us-ascii?Q?byWF6RPyQWYIGr33aVx1u+vLtpFtVQgFbDNXNFeOKrVu2lVXMuC61baeyKC+?=
 =?us-ascii?Q?KJnq0i3R6hopGOJFqJoUWzyGi7BAZVh3v8jJCQUYKdLlRUaLWHzgmJRf3/5u?=
 =?us-ascii?Q?M47CCSrUZE28ICAnVim4UfPwBVU0yl4owJ0tWucMAQ0ubTSP1MpeRdHVEb0G?=
 =?us-ascii?Q?1unY6Q9spWvsVBEG5tV7Xo8DBIzlrVIrHL0X2BcGAru4kXv8C4ct29DPvTKj?=
 =?us-ascii?Q?HZoMPFwT/AHxpjkXeyOYJ2TwTig/JGuWwgB3X9Ys2OBsgjTLc1XkRX3PTD2s?=
 =?us-ascii?Q?nAVj7x8dAeMhuxgOQXjsCBIr4QZUuAredlaZr0WVZUMTDzg9VKYPm8wLx/3S?=
 =?us-ascii?Q?F8y3DIt9T5MwTDzzABWKdsi9xJ3tKtjFBSX3NlgdY78AwUibGkMklTd+vXrF?=
 =?us-ascii?Q?6/aZu4OZuMXxjsJ5ppaVRPyfAprrSRh/X0A3vTPWcbaMVJ8yBDW+1hnx/gGv?=
 =?us-ascii?Q?hXKjROPPwHD4yF038VosKncBdPGH9ctuFbfrtuu4yRC1bRFLQBFvVSWPbl/H?=
 =?us-ascii?Q?RRLGT3GBGbudQeHLGrulKL85F1ratFd8lDICKnrJJWpeacZgyPbWiwY40eJu?=
 =?us-ascii?Q?4ocFEzkq+l9Gjo/owqoUXo2aB8SnC7TGHQWGJ+BqTqFsvEY5Hc1fFot0Wa1R?=
 =?us-ascii?Q?mnQnniM+O30QkJ0rvegTr8qtQIakan7Uiz7Tate0OPlO0OOsaZ16VP2PPkN6?=
 =?us-ascii?Q?U0nzwHinRh+E/VhhK49Zle5cnSe9SvCIDPwJHLGOO/UyL7gEM83u7kaWVm3A?=
 =?us-ascii?Q?t78UPdliOid/UwGo6Xl6WatbNeI/TTAAC8RZ7vVlLGRqtPZ09FRaaCCOvKtX?=
 =?us-ascii?Q?c5bZSGSC9wVwKcfGWTHWQKvosowGhqHfhQxhgEx3uduanpsY+OPRbO8zjR/x?=
 =?us-ascii?Q?T0QQwAWHJTW3eLaQknQQ28jePSKEuBkXPXHMjEYvytt5JLdp8qLm5tb/rE7Z?=
 =?us-ascii?Q?HavNwe7fSN9uldEWbzF+wALwPzCXZDX8odFobhtcKKNADMm+yfPSNilrJ6rj?=
 =?us-ascii?Q?3DKJQF/Yf6Tg+qO79GEuLZwQU3eBdQ2243GFqF4Cvk3FQkLYWAeu5SrUuWNb?=
 =?us-ascii?Q?gF42fVmZF0Nj5+T+uPus2rNuPWsDTJMpb04XKux1nhq07H4LeDiVN5hvxMln?=
 =?us-ascii?Q?1lByn2PWqbEWwZw/tYXgncmV9Ma+tqz6eF7Fa7zzuBTpg7sp/UiTFR84D1XW?=
 =?us-ascii?Q?IzOuulhCV5mAxq9InrhOTKZ5xneYLMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc932f-a0a9-4784-2197-08da4d8e1678
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:08.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roQ2NzgMz09hg5SycjLmduLNFyoR9DA28uUSgGSC1ovsnSfmEdZMoEtHcDwQDYuGqWs/lp2YwsNhW4Kjo/vTmUaNWNGvUeBhaSTWBr9Vd/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: v0aYDuCkWYOV7mZMZfAyLQjvFhZjnmP0
X-Proofpoint-ORIG-GUID: v0aYDuCkWYOV7mZMZfAyLQjvFhZjnmP0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/crash_core.h |  12 ++++
 include/linux/kexec.h      |   7 +++
 kernel/crash_core.c        | 124 +++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..564534820db9 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,16 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
+void arch_unmap_crash_pages(void **ptr);
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
+									unsigned int cpu);
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f93f2591fc1e..f9b13882debf 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -308,6 +308,13 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 59ad87a7e40d..84eb10a4241f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,12 +10,16 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
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
@@ -590,3 +594,123 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+void __weak arch_crash_handle_hotplug_event(struct kimage *image,
+							unsigned int hp_action, unsigned int cpu)
+{
+	WARN_ONCE(1, "crash hotplug handler not implemented");
+}
+
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	mutex_lock(&kexec_mutex);
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		struct kimage *image = kexec_crash_image;
+
+		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
+
+		/*
+		 * When the struct kimage is alloced, it is wiped to zero, so
+		 * the elfcorehdr_index_valid defaults to false. Find the
+		 * segment containing the elfcorehdr, if not already found.
+		 * This works for both the kexec_load and kexec_file_load paths.
+		 */
+		if (!image->elfcorehdr_index_valid) {
+			unsigned char *ptr;
+			unsigned long mem, memsz;
+			unsigned int n;
+
+			for (n = 0; n < image->nr_segments; n++) {
+				mem = image->segment[n].mem;
+				memsz = image->segment[n].memsz;
+				ptr = arch_map_crash_pages(mem, memsz);
+				if (ptr) {
+					/* The segment containing elfcorehdr */
+					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+						image->elfcorehdr_index = (int)n;
+						image->elfcorehdr_index_valid = true;
+					}
+				}
+				arch_unmap_crash_pages((void **)&ptr);
+			}
+		}
+
+		if (!image->elfcorehdr_index_valid) {
+			pr_err("crash hp: unable to locate elfcorehdr segment");
+			goto out;
+		}
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_handle_hotplug_event(image, hp_action, cpu);
+
+		/* No longer handling a hotplug event */
+		image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+out:
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
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.31.1

