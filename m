Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBDB57D330
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiGUSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGUST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:19:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0048C8CD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:19:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIF1cU023093;
        Thu, 21 Jul 2022 18:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=X/S6pKNrP4el80tjrrVfONEtmb7Ev2jNsZetiTysuHo=;
 b=tCicLtTsucVTEihYGLK8B8B6GPBTZ9EAWSDsk8XKOSSzCU/+p/4nKMCahGMPvG8XSQ6o
 FNEzWWUztAKxPwcAr+cZsLirEDjcz+HIOcx1PdIVAYSmXMz0uJYg39wnVGtgBFNzLVxe
 G444EMp90LelcpJOvtYGrwzaG7HDlt1otoFAzAowB9Ds6/lf55vE6hSxJ0zpeE6wXEET
 ea3RLzbyk8UtYf2mgac0Vj53dMMhhE3PJia15sYUZmvP51DiaqKUyE0NxjkS/tHn4JWl
 ITEzPgPt0ZvQ14S5ssEKiqeqlPp06RqPV7ZnkgBMiY3NLyEz3b1NXEyygkCbI1EaC2RT Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx15e1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHHd9O010041;
        Thu, 21 Jul 2022 18:18:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gjs37v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSAVYPWvPMb8vB5r7w9tTEqk92Tqqr+0I/HAhEjCrPZ20hR5wAQU+fPIeI1B+Y4EKuZ6wf3bXiQANg3o4RUhYd6TGprMjZ4dQvBz5risYfvgQrhxn7T6DXvjzav10w+RAJNLquUCfY8WY907hHAyRvuTCNdsZDsmO6tzfz6xBWq4M01GoPynY3pBJR1fnb5YQnvqeqKcm+CseGkyPmNH0aTlILei/OzQS5MSAtkNHS+ODmOVkVlKM4J7R9W+PqCnZ1VUzv+N6WyfdzfPq160GJ8vLHfv1xV43wIICQZmReQcT2D2rbfYDMIau4yZywdod8HrjdjppF2HNKcLBTMqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/S6pKNrP4el80tjrrVfONEtmb7Ev2jNsZetiTysuHo=;
 b=eZtjYdnGyR6r+B+IH67bF47PT5HP5G8C/OCi8SKJmFfmktxUcBWWO3k45QQzQbIGYxkNu1Dfi0yveFHz3L/m/hMqRzqi6GTHpb35fBxfJ2RCga50BPupgajzqMjhy2ENnDoE0yJrWTCXfvZ6nodBfQBxXTH43iaIRtfJvsqEF21SKee92v2VG2p/PrRh0ljdUQnZ8v3K099kGGyaHwcivSB/F7RWtuH8HxZTiTEt7VLvmXn97vVbvpa6f8qa5SfioTOErLoOktcoY634v+qP83LGq4Y5ufg6uyADGwQCzw97lqEHPVXgWRpBPNanNJvf4S/K5yIliDlMVR3LXh3uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/S6pKNrP4el80tjrrVfONEtmb7Ev2jNsZetiTysuHo=;
 b=pHeI7HZqaWdDsba5esaquJxZ63F5vDlbyLM+iKNpowMqhHhBVuVikexPMCKprdWwXhfUo7f1Em5oAQG/C+vaNgRUR6jbIWROjoOtp2VZGKOrBy6DGNN8zS6mm/aHPVoY9FmfD5aJwGDgdhMe1d1TE+4dhWdMJNKmYiLpmPL1K44=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB5517.namprd10.prod.outlook.com (2603:10b6:a03:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:29 +0000
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
Subject: [PATCH v10 8/8] x86/crash: Add x86 crash hotplug support
Date:   Thu, 21 Jul 2022 14:17:47 -0400
Message-Id: <20220721181747.1640-9-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3387510d-92e9-4cba-dc94-08da6b456940
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5517:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUDb8suSWYBmcO2fUmybTGgMBlrmuBZ0qt3t1ORh3uyHwQSWfiVyZ19Ni59gxKSVYw+N8S2TzvTBhpo5wyOBielqBFhndn4vLWZ2C+fMGGu3+sCuzGELeU4xSOgBDDysWY1CB6kbaM1A30hqovqVbA3fp/2b44uwJRBUmDJo4b+Od71nwI1i+067IG9sSc/JU7z3s+yXLSbk07tX9L3vBZV796r2r4NZQgtZ8xDinJxi4PGqR2OZIbJbFTq5DTQAYVi/QXQ2SjXR6qxS0d69p+wSuKWFRQvpObm6XzAXwwVzSbv/VJI2TCCfAFTnzyqt1iU/mZ+uOv77w4zVSaMMMwqtr6VQX8dRFxTI+igldCy2o5/0RyWn4DsqMU7Cak/zjMECuZZng4X6hwcC/UyxM6EFFU2TY0zl8hJ6kB8QJwCi3U/UzMxdYkwAoEXOJGrp9ylS6tApFdpfLhFFPcduSx/luMuCR31og99kznPc689fhNtzIPy+fc4eCG60jnzQ+R1PHOfNRJr1MrHl8yJfIH7cf/gca8E1HgIfWDDgXbWe2ZyN5/g+j48zSuxDVm+Tkxl8gyx/DHLC0RQlsIcit8HElLDBh5GK80EiffSTEZ39s7uLJerTJx+JgH1zrfHN+Qc+aEnCdbqgrCN7+5LRUigxfN3//S29OOuwhYZc5ezrc4yGicmTwzWSGu2uog58zBELu7ldZtG2+R0uX1d8MACJpBHQy+Pq5qAVC78gGNHBRfmDfUJgshkt35Q7mGBIH+44DaNL1OztVoJ/aWg3Dq5yAHySdDdoo7jLjHJzFko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(316002)(52116002)(6506007)(6486002)(6666004)(41300700001)(478600001)(2906002)(7416002)(8676002)(66476007)(66556008)(66946007)(4326008)(5660300002)(6512007)(38100700002)(8936002)(1076003)(107886003)(186003)(86362001)(38350700002)(2616005)(36756003)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMHa0vmrrxnM90b21nZxhhI38lZJWk7JXB92VC1njW9u3wLIYq5J1+NXzpGI?=
 =?us-ascii?Q?DQRYhK6KoSGUaIA2GlZmNe7zb912d9HDP+yR8fhzwcIfwcqoMIqh5yHHoNAh?=
 =?us-ascii?Q?2XWgbd+jp2A3UhF6FhCpDtwPlqN5UoEmD/xftwTxbH/eMM7fJm0BncXr+rvK?=
 =?us-ascii?Q?XzjktzkugpO0vYl7f484XvQFZvn9N3Q3j5Gf5zcW7fKC7+IIAgLtlPT2Euli?=
 =?us-ascii?Q?tgHa6UIdYmLLTDSxzzBQNDhbZmny4RE+vdZVbyDfudKLdpYxcDBMn5QAINF2?=
 =?us-ascii?Q?zSWrkL+6gzeP05K7oaZ8jz7lPre6fijLie6s7G+oY2h218GtJ3bBactub0g1?=
 =?us-ascii?Q?qPk8Kl8zUwYjOuAhwRvJeg0mGGljt5R2nalC8VyL5m7UqCcR1/oAe1WQbU0k?=
 =?us-ascii?Q?8W3V7UpWgMZiNVORgBs1bMhs3CF26Xt8fvSc9hrS0aef42x59Nm4UX6TD1L+?=
 =?us-ascii?Q?hiMho9vOAYx0ZG4ZhaCMTf4E/GvsQTxjeNk8XoguKo/sMFF1Ne32yTa//Auv?=
 =?us-ascii?Q?UrWxraTZzB9igc7zX4VPJb7+mbT4xUlTFT3Eqqv6KCUlLIZ4XyYsc41rSKAb?=
 =?us-ascii?Q?QbJwU4f8306PEiXt+3pzsyBSlTK6fmS154SLX0vP5akoWRM475vR3844FjIQ?=
 =?us-ascii?Q?bXbNrSxZB9/PdIyHiTjpN+UEwRMWprhOKJF3hpbovNKid3eBhP31iNrUKC3D?=
 =?us-ascii?Q?F+UEZM741WAgH3O8ofQySo1ON+TVsZvDtozDzAtP3rQXWqFRsi3luS+QEtdK?=
 =?us-ascii?Q?B0jz9uN6cmWrGj91q4PfXXn4A1il59+oWZcnudT8aUWeTB6UXR20xamqOtIu?=
 =?us-ascii?Q?KIjLOmZt2rKbcg3lKcUNQwc9SUfQzYkQe4OVmzSlJ0zud0IeUYDuboRx6KOw?=
 =?us-ascii?Q?zirGp4jvUEHni3lJUjqDKj2ElhA4uPbwm7AY41uhJP5SYnQJaHNxjtcA0UAm?=
 =?us-ascii?Q?afAeEHLHMrGcyGScXizIGdduhDMQDwdu6B1ENVqzcdXNIXy7hBNJ7j30iXvW?=
 =?us-ascii?Q?zYT7wib8P/aGAnrL0G4bSFTxkm1OpalyGJSZ78nxz6dchX0y8aCbr+mEXzT/?=
 =?us-ascii?Q?oTVcBH+wsg63sAVmNO7mkbOVTPGgXqqVgU/CA0x62TfJTQ5kCxfi3y5IZVj0?=
 =?us-ascii?Q?mAVYCfchIsOEQMCX969Vh0abAxT8TmISdmuUVM1sJZ35YDHf434mNEqSW1zD?=
 =?us-ascii?Q?X9QwFxG4jB9vgKxQRA0cc+ac5DxxiSdiuskkbRj9PEq/v/6eVYbRxPgk+2RV?=
 =?us-ascii?Q?9xXuRgIN5TwTqMULHBkxa6sJX70u5j4q2aiR3O75BW5Zt6x2J/vrYoM8mWoG?=
 =?us-ascii?Q?LnlJ/6OmtTXwEJcCd9LoSLc50VrjHnrsQqQZW0LjcbGhmxAtckCIpnHPD6PJ?=
 =?us-ascii?Q?73eJzTpY5ufYsq1L/jhjD18i3+kCCVdp42UupiFn2r6NG0geys9B0Qx8W1rA?=
 =?us-ascii?Q?LwN8wBDI6k2v+s0N37ygxFof/BtrbONZVE/FgLITxsJj9YDWACBnl/yd3pqW?=
 =?us-ascii?Q?TqekHTGesIQWVymsn1EmnIs0lSwpCFN8a2jz+aTY+5gl2RbQSapzebdKjf7e?=
 =?us-ascii?Q?Y/LMSv0fhc1XmaMg3uPu0LTQt1d+WW22PZaDJK5nsvSUkONU011vmtmUmjj9?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3387510d-92e9-4cba-dc94-08da6b456940
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:29.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTXzvYZDQ3DGuyR9XoVeZ+W5+ahKQqbpPwFA5qt+3NE/SsZ9NnOrfOaRGklks9af8ZKVwEnIhl92kyTymCQQRy5cB1WsRMPnjAjAGRjdgIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-GUID: C36tz-4g5glyxp9eensFvMOlOWbS4Icx
X-Proofpoint-ORIG-GUID: C36tz-4g5glyxp9eensFvMOlOWbS4Icx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

When loading the crash kernel via kexec_load or kexec_file_load,
the elfcorehdr is identified at run time in
crash_core:handle_hotplug_event().

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
is supported. The kexec_load is also supported, but also
requires a corresponding change to userspace kexec-tools.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |  11 ++++
 arch/x86/include/asm/crash.h |  20 ++++++
 arch/x86/kernel/crash.c      | 115 +++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e58798f636d4..bb59596c8bea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2065,6 +2065,17 @@ config CRASH_DUMP
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
diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..96051d8e4b45 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -9,4 +9,24 @@ int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
 void crash_smp_send_stop(void);
 
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
+#define arch_map_crash_pages arch_map_crash_pages
+
+void arch_unmap_crash_pages(void **ptr);
+#define arch_unmap_crash_pages arch_unmap_crash_pages
+
+void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action, unsigned int cpu);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+
 #endif /* _ASM_X86_CRASH_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..55dda4fcde6e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -397,7 +398,17 @@ int crash_load_segments(struct kimage *image)
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
@@ -412,3 +423,107 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
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
+		ptr = kmap_local_page(page);
+	}
+
+	return ptr;
+}
+
+void arch_unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap_local(*ptr);
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
+	/*
+	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
+	 */
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
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	arch_unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1

