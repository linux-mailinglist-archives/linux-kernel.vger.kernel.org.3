Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB451C85C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383279AbiEESvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382606AbiEESut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62E2E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245HnBqx026132;
        Thu, 5 May 2022 18:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VVgeFYJ738A58ivO53ECuv4mR1k1En2fwpOG0omofRU=;
 b=oV0xMwwFWrjJrqMKby7AY0msv5OkCcei+Vi2dC3qJntdotu4NgPsWRDv2Xhu/sv12yD/
 LIlfejOj+CsZuuz5eRUJfGcelIi+U6QSwQM2nTgIceZDqR2JOufHfWHbirOFhndRkTbR
 uvEaX8xs0xkOTOFhcu1hb5AFSWdDqgZuvTLDJX/FAsvx3iABepm37DCC7cARWvssIL3p
 9J009upk3mnL6WScmvJSUxmWgcMetnggdgM2X65I0XPcdF/Sw0FXv5Lvlmqe0iYlTSCY
 Ei1PlSbTT3MO2JTlUytJKRkuZe0oFB65VFZz5/AHaXuH0eggBFzXqjdZYsbEGkDw78X+ Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcc099-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Ijb5j016775;
        Thu, 5 May 2022 18:46:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusah5r9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDdeD2AJYea2Uy3DQtYL0xp8pEKZCMRcqBGyBpoE3BQA6KwLNITF7UWHE+nbf9ARnCKa9H/GTL08FK9DopJ0mxmIcJZDfp8yXazD/QnJr+ihNwK5X5IZfo5L1R0OZ8IcPTzgk/mG63Ax8B+2eWOIkE69UHzBDKq/PG8nlivntmc2TNkoNKB8kQwGfWOcttXea/7RbhXmLt4OEarhD0S9dM413SSPmyq+uYAks1con0JQVmzJH59AVqcweSq/qJ8IfDXGE0hFiCX2P6ywKNkIrCnD7v+VB9APLJK4ecSTHBQnIJJxwzES0KmW8jHOBXPtam1WonyNS0YRFOCmgs65NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVgeFYJ738A58ivO53ECuv4mR1k1En2fwpOG0omofRU=;
 b=Q09XMukzLAk282BlRCgVLsVW+fhfzsz02ydW010vZ4R/fMFPxLmTdsJvnEOy8QICNtltUfNSZpGW8I10bXzcCTXK+ehXXg2e6z59SGecfD3LtQ6RP2xD9LOu0/sKoGmGnnSmbCtOIHch6XJuPLCnxmtEcHQi86dajhMhyrNj80KM8/37XlsnHV2s4OtY9nYXERUpKue/J6Yro6KpBrKKV+NToFrCWV4KzV5D99nB6OAJwwItVHvhRdY4h5L6oyTceB5R+7MUMcDz8ZIQ8t7fDqn93QHLYwWqqgFoqUGWkspvw5x9XIGWpi9EYAV6zY0xPpzz9fGbGzSq4sMzEj3Iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVgeFYJ738A58ivO53ECuv4mR1k1En2fwpOG0omofRU=;
 b=L0Rf46H3/GltrfwomFPjnlBtf11yTTCfpgisN8x9worPOxN/+4RVVR5hdcYtaOZcr1S/xAWGrU9gqYHzeZblYNXkqdRZtliD3Jf2yg+10WPROUdO9+63459TEN5pVDmGtMqH0RIUis5gL07K1mex6LBCDxJ1vz4ZKZDCtAvgX5o=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:37 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:37 +0000
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
Subject: [PATCH v8 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Thu,  5 May 2022 14:46:01 -0400
Message-Id: <20220505184603.1548-6-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49932902-769f-46c2-8296-08da2ec79580
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1875ED87910276917E84C29497C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkR/ZA8x4o13EmBbABSgiRv0aY7y/N/yFiG/1/YgSpHr4r9Dm0l/xaOQlqPKooD5L9YdwXz6eU37V55QkX6lxQyj2miClDnnE3RA+MNz6CLwMwWD7Ls83NLB7uN/K8FQaFg1Vl4p9X94ZHQrfyCYPSs9Jndr8EkCo1jv1RMGyfK+teU3EENIvFwOa/nNproCy3HEzepQtqIEPd7NQADLSjaO1plZoAcfo7b4M4HZ1Kfyg0OoVyoBEFSzWB//1w+3iomfo4erre/FxioCVDb493hJNv0wNZoHslao26MSNOe7kvO+ORptiOV8RvogXVgeoLpUnQdOrje9shCkngaQ3DThWtRo4SAEddnWSbJZb873sG2Wiio9Y0SHkn9jIsTCsDqpIEaTVBkn3PEheDc+4TyjCyfjt6uACceO7CebfMoEM8zF5ZEjOIuRgG5W2+3/o96gbC9M3df3S9dnZNl42egbVUmlcjYuLr4Lk6+fGlXTy/Z4GSCxH4AAT032N3ge1FsNajsqqcrReJGGe5vVUj7HPw0aUgurJv1yWkzbgOKtfJAa2JotlDLdzAZL2ytp7npv2bockhYtW42uINAeC+JvOkp1r2pUQElagALXKz2EG2yme9F1isjOMoj4IkzJbuQn+gsZOkQvlPn6vLMNE8ixLPj5ymmqYRuw6v3s+9mNRiDJGDiZHqrXrnZCdABedg924MkhYB3laU5iYnKBww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(83380400001)(26005)(66946007)(4326008)(66556008)(66476007)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(6486002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UeD5JPhm2mHOWEnpACiHrKZvtHSsTq0ruR2Zgc3SmRsv9OKQG2rdTLGeo4V6?=
 =?us-ascii?Q?Par83DAa4H0JLqgwvDMwbzLgcNJjfIixBz3coOuapER/iRoJsYbErdR9eaZl?=
 =?us-ascii?Q?LE19vqSIYVSdChFi7zhXn+v1VlEN8XZyNpvouX+UTsz8j+xRtXFLGVHTUrPB?=
 =?us-ascii?Q?lcn86Ygr42+QdJ9h6DEDSlTS2VQ8CbfKbX4E4UB+nkXXZBgnjMw/hu2t2zzY?=
 =?us-ascii?Q?ZX8/KRWJAYWcsKXyeeYdLCMahnFqmaJ1D+5b6v1ALBr7ai2La3HFael4namC?=
 =?us-ascii?Q?KYGFwYGXZon6wRHX56vXozsr1b5APij/MeDnMIRJ5n0hqGoMob131cS54Cvx?=
 =?us-ascii?Q?alEIeetuWtRgy/PAKjDEee2yBGQDiojbh4h+4S5pYhH/VRImpWqVzrumQpJb?=
 =?us-ascii?Q?FNU12Mp4/cAtHePghvRgvChzr0u+d2K/vZJEUvBl5E6z6Q9dGoKZzmQVUfP2?=
 =?us-ascii?Q?rvOA/DlcusZCkEhExea35DKhIXnj7QfHfCGqxKZkqCb/j1eJvRk6FT4XFzl0?=
 =?us-ascii?Q?GmrbCyfkaWvpIBn7xlg013FKF6HVQ8WfjrFg24l/bzlbtfZA6djrg5ct0dY6?=
 =?us-ascii?Q?Kic+vHwfViVY5rcT4Ob14m8Tf7rGY6kNTo6sD3WhJVTzxBdWtDz68CwEyzHx?=
 =?us-ascii?Q?e+4tUHFjrp0YLqHF/JyqCpOFjweO/E81W9DLlrIZlJJfMT5duFgw+LfBriKx?=
 =?us-ascii?Q?yjm6ffPJZt+uY+9C/T9MyfNZlwyREtQwtnFmXxhVuwv663KEujynvRWKgEmq?=
 =?us-ascii?Q?RgHG4VwFAhvr3ZwX0rK5+oldWdn+Sp+Stj0+2k/ZYpz9YvLm+TujFgUIsTFW?=
 =?us-ascii?Q?1RFGYWmjZdi5TibISsjwr/8O8kyM+0+CSKAXzWBDcy/CIgVFVJsHKszGpg6d?=
 =?us-ascii?Q?9H+P8JEXmie1iVbyr225tJ+f6Jx49cNEGgT/p7m4Zefh9DCtP1v9+6sUY9T1?=
 =?us-ascii?Q?PajNERDbLysAMyBWxdzH5Grp6YvgDsuvnHEtUsnBTAhESOmA88+H6UPLDkbz?=
 =?us-ascii?Q?AwproK10foAeqbnLGbmMpQG4NOLPyhkBPipeGQVRrGouJ+ykZ1votVpUHGzp?=
 =?us-ascii?Q?fZxFtrTCbKVxnVGg8Vbjk5x+tjWBZDI8hIxJu9CciXglXtrINtWziQjHl61F?=
 =?us-ascii?Q?/LZa9s//Z+DLsyKuk8fclB06wC1C69VKx9IA9oBKPhhKuHjKNuoYBP9YiuAQ?=
 =?us-ascii?Q?jGDB6GxnumLUb3dj9Bo9JgGgh+saPuKaQUxOrLvufTEVIrPthY2SPsB8YOdW?=
 =?us-ascii?Q?n3FP9RPqwj/QxXu4ArX47oI6DzfwQd5GWKANN9Iv2Xh/rW7DE/faTfwxEpx/?=
 =?us-ascii?Q?b7PDrkRyKn7U3TeUmewwgbffZePd0w3mPGp9YrE7ioWNhOyCV4CtSwBp22Ty?=
 =?us-ascii?Q?5LElXw5o5VdfxcFon+e9KoqKcEV7L+8u1/kahyXMfzMuKGU/w5ziZ8G8h9wH?=
 =?us-ascii?Q?f72IeDd5mrxjHxwmz37q1EEjd83IP/mhRSZ/MZWKQYZ/5+d6YNqR3JENfkKT?=
 =?us-ascii?Q?/dRKPnb/I2LtpXM+rIJtliCN92rsg6aFUH02hQwsGPtI/f3qg7OxsEfanUvG?=
 =?us-ascii?Q?5pL8uDPXkFuwEFIlKhcyoQntVHcRf7jrl9AY/wOpbwJ1caEtaoHUTVxCoVxo?=
 =?us-ascii?Q?JguR4n46hihGnrpyiBehlvGjqt4f/RSTxdO7eNUvhVwfZzcrFYI4ICI42SzO?=
 =?us-ascii?Q?Xwyvm3xs40piJ6hb9oUiSrgZZIlbQJrXX9dJCoMtylWuXdMJdKoqrtwck1jf?=
 =?us-ascii?Q?6CFFZoCwQvc40fhpvZt0jXzun/wrA+0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49932902-769f-46c2-8296-08da2ec79580
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:36.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDgX+9CMFiGjfWIYFhZXYVZN4TJFj4a+YZ1e94+VjAR/Bu2FFXPqyzUP1lNVp2GOW/1mh0A/hppENgWztm6tWBR7NbnRU/RLmHhG7GvJGIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050126
X-Proofpoint-GUID: AHL9hnmK6xv3v0-tqBe7B7Z7O8uFJ1RK
X-Proofpoint-ORIG-GUID: AHL9hnmK6xv3v0-tqBe7B7Z7O8uFJ1RK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 10 ++++++++++
 kernel/kexec_file.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f197af50def6..7ba43f058d82 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -520,6 +520,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 		/* Flag to differentiate between normal load and hotplug */
 		kexec_crash_image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index aacdf93c3507..d68e5769b428 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0

