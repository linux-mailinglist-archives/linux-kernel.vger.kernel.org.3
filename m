Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED85A2DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbiHZRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbiHZRi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:38:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BEDF4F6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:38:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGOg2F006811;
        Fri, 26 Aug 2022 17:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hJR+z5+PKkE9yMIG0msVzK+xiEtugcpwR8U4VtuWpl8=;
 b=RPnush0iy690Sh+o7HpPpd/WyIrDu0z4Na8dWYguk1GnE/hpEXYE107yONk4RR++ecJj
 CQKf9uzT26symYxvWa7n2Wy8IyALNasyOlZfwWKBcsPIXSr7wwdiexTuaQXyWWRbytT8
 YJNeCV8DqlSKpNktNYSqAa5i9QB8298Y0D0Slx+U6eOs9hgWntQkr8uNcz0d2cV0r6L3
 daLhPWe3FIDqiL1/JcwJ+Mu/pzxQi1dPgU+j8ZqB1UAVJfyx7NzTZ6mtvk5lJUSmLxky
 bElJSHChinRCWpeZb3dk+U1YJNPWFqdLfYgWFIx9H+rj8NMIPdxgpKa7sxKHkJmd8bEy YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w2429es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGtEYI018949;
        Fri, 26 Aug 2022 17:37:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59c82s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYVtApUxPV8jC6xa42AZCbLsRxBIgdF2i7WEgyt4kIg29qmlHVZDAulbamtirGmtJO4/V1UyJ543EE3zrGCwQ1JlpPydHQzkm7IRDgzSoHCp8gsI7v9yarTmieMVkhQIUndi6PqfBzk8uzYRnNpZkFcBON+mlgHhM1/ciiBOqGtFU9pa633PBay1WSj3HiqZmFND2iP+2UDggbrKuvKQ3H20ADIn/afrWtPHOZ4u8GQLqMAlZAnG0QwFUrw2vDFf+FZ/NAvASrJKwl/3IwJh29ZgmCve1BWiJ4CIzd/cREgR6Gk+DGuxr4/qchDSq8eAcPFLEOPNsPnTyY3SNDHH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJR+z5+PKkE9yMIG0msVzK+xiEtugcpwR8U4VtuWpl8=;
 b=DQ7/ghAuSuHlGjIw1n7Uizxbi0q3RJaD7fRVcqJr+QR8Ql/LCbsP/kguGZ4KrWjs5yhQcNIkObXUZ+Twxg9mVipNYSKo+nsPqvWV0xPLjfyZfZGIY2EAKpUn1t4K1Oggzl7cyUCcqSyrc7RN/GwwVaLQA/JiieMeWXjngLdK6rjXMncbSx/pLnraivr683ngtVHml+fq9YE6BGKB9ZpKWE0swcwEg8zPGdyFdCP++tV1K7lUW49X4Iy6bBOLREW0BNZPL2FubUQuyvTGcRWTPHKQnGqqQSlbAsgj7Nj7Eiaq0QaiFHRlskYGRGYscYAEZLmRlLQjg+bBQdP8wZhc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJR+z5+PKkE9yMIG0msVzK+xiEtugcpwR8U4VtuWpl8=;
 b=L3BNDh1gHYtYambee5QIdf5kzw+a6TQhzQUSrx/QQE41LueoDf1xPUGBVUgcJdroAVPSU1ddR8RYrQ6ILyy1Xf44LsI7vU0HpBFMt1xuYvmNuKWvimNj2+NEFkLoCNyWhyG1d5ZpfhOsjdRz7BnH7L047q3UtUtKno7Ne9vsxv0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 17:37:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:16 +0000
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
Subject: [PATCH v11 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Fri, 26 Aug 2022 13:37:00 -0400
Message-Id: <20220826173704.1895-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc904859-2f12-443f-acd1-08da87899e7f
X-MS-TrafficTypeDiagnostic: DM4PR10MB6231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efkzO5hUfHTqo8jH6HOoqswrrvrSUO3nBJqDzRrICDTqU7D6XK9oozRQYljjXInS3442+V11ojmEivafGrDX2XsJ4DMmMMgp+JfbscfOE5X6TmRQSvaR8x1LepiwlMDemXHvKzZi5b8EFwEoJbu+RSIEdKy+gW0IBmAepILgtTLRwvVyNxFpIuBg4If8TJKVtC0ZpGq8y8PK679V0YMLmwBWuVxpGIL9zOnBFYSQHWkpAuhXSSlJFjPL27jqLRfF8eI8K6vki+I4/XgZAzDZLy7BPEFWA7gUqiYaRyPl3/5WdeDVnbFQtTAiN4BEmmZvLFb+VtKxSCWpngQVQ4ZoKtOTRYl4IrmZWphcHEk+3VKJ45fgThWIWWFhNNF8M0KbYVeOglPlwOCp1V2LcO4/zsY1mwAT7OuNeEbAj4CbhPYXfGgIT2Tef9cq3FbSR1KinIaXNOGlPt5ForleBgIEf+pwT9Znh5KMR4XDm6A9wVo7NLYG8T0FZj1hf7oVNCq+qXPTnHf/13kCLzNQTz6E7fi9HDs8zxfnyHnDCCOVvgN7MjHntMp6gqCuBLx01qfnT5me3M56wSK4+l9NJjqyyrawX3eeNANVL+PnO4tfkxK3BIcDWQpumaXdyvc0IYW3woLxR2PSxVUMEJjCIrumNspnMH5SoKHj0HbsdFThzC7tXc13IQ5qincodHO4hY3v5iF1BUk1wQfQl+EXIg0DmiQyI/5Y9sIqlEcy1fKR1m5hT+Jw6oEj3I/jYqexwv2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(396003)(346002)(36756003)(5660300002)(86362001)(66476007)(2616005)(6666004)(316002)(4326008)(66556008)(66946007)(8676002)(8936002)(83380400001)(7416002)(2906002)(478600001)(38100700002)(6486002)(26005)(41300700001)(6512007)(107886003)(186003)(6506007)(1076003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XfVYX1MiC1rZ5p9uooRkwk+vRRv5RLCFzVpB6H84Gs5SDZUzripiKg7w2z1M?=
 =?us-ascii?Q?G+zkmS8/4CWDvbUdOmalZ+kY2fkIpFuYhY7fY4NqVWenK1bqi4qH8HIDVhQ0?=
 =?us-ascii?Q?xhh7/bpmlcqXxZNRjA3bnm5Vifjrvc2qmlETJW0uP4yW/8F4FpefOPTp5L2B?=
 =?us-ascii?Q?SDjMmIfvo+1KaUA7GKLnixq5or92rZID5Qzs5sP31gO/vboigU7v6+oHR0yH?=
 =?us-ascii?Q?4jlsqRLVz1C7mnIDdjgqNNmKB8XMAMJKdzs7esZl12CWG5K1Pz39ttL6X7xl?=
 =?us-ascii?Q?/XPK2V/uLRgGq98rsww7PZbEgDOrF15f+ssRn5n47RguvB8LmyIbpdiQg+1f?=
 =?us-ascii?Q?mp8/h4bjN+TqK7dkXCDwMDXhCcxK2+maRPL709kRGforU2UBDBdNBaBxjOWr?=
 =?us-ascii?Q?mjrh6y5w7En7FKtn/5CHIGmBxlEi1SgbceHoOK/l5Uxd12jXVR7cibkmd9Ht?=
 =?us-ascii?Q?McegnASPcnpPk4BQ42SCdSPDCx6ruGrH+EQSKVHv4cQlQld8QvH9Ly0/V2NA?=
 =?us-ascii?Q?Z0u3EBnrW5iIviA1+IVUaEJJYxw9qW8pmzje5a/usu7Ht+OEaY1OEQ+syBkS?=
 =?us-ascii?Q?c11xI7yJiMzSRktaoyltpdG1JvXs+gRGqFqO6ULgd8Cz6SGBL5bms7Zgwp2V?=
 =?us-ascii?Q?Hbxb1t2Z03rXmlMTeQWs+YS2h5Vbnet+8UWkIQP8aCEcABRqDsIUeazYl8Na?=
 =?us-ascii?Q?lxzxmRCx1uh3ZAO5Mg0p5RsNCPAKVTZCndMj4/kiwm8JnkuH/Az0GzlswTH8?=
 =?us-ascii?Q?q2Cr9bA1ALkXUdtAcUl2qI70bo8T3uwgyiN/nnXv4H7FWiwN9xOGPEXbn2pN?=
 =?us-ascii?Q?sR8ZmfM2uFvKhzyNOe4vcmNpJEc2RPuR9XwxnwnnrkZ1nECt/M+yjQ7LB7W9?=
 =?us-ascii?Q?H7boVV545NXgKxRQ2q+YdQvlcONiQmhDN0jGZfqN5SxxzT7RoEET9ir34ttT?=
 =?us-ascii?Q?b9DSvvKKyQOaf3J37WqkWUiHSSb7pyp7DsFzkHcodYoLwLJXocagrNSKyMb3?=
 =?us-ascii?Q?O8UDuwL6wbDlfy4CYgTbQ09ikrfRMlhvhX5TTZjufnR7qBKUR3C/RoZKz47a?=
 =?us-ascii?Q?WIHvJN6bzcjgNyh1ExT3zNyK+swCIlKdy0zvljEYteiaS/sYCouGPLNK0bez?=
 =?us-ascii?Q?2r6O4B8IDGzCMowxv1WzUF3wRtoqwq4Di8uIq9GmBy+jwUO5Sh/4eFr2OuRB?=
 =?us-ascii?Q?IJ+GrQMAS4HJ8MzESeqQsIWuiTw3w6KlzOWMjdAQ6vRMhhEdiQRHF6UPo1m9?=
 =?us-ascii?Q?Cz9GSmB0T1DotRLRWJ4tw5rWhzBu39XtI/9Mr0SefOtQaZWnir0eGkYdgGlz?=
 =?us-ascii?Q?1kzV2PTJoF9TViM+WWZob5t3fa/YD/A0MAYhzjWllG8g+Ace7gR+x17hD1XL?=
 =?us-ascii?Q?GJiWKl+3xefg5UksWVefZ0TQm1o22bog7tOWd7kxL9BdL8xNoL6M1721aU86?=
 =?us-ascii?Q?o9UzCCLEK4JUVGyOkg+/reeDRVYIZcewyAuo0PbiI5ABvAyBm48dx064YiZT?=
 =?us-ascii?Q?ZGw2oeIHEPcJsB4PiF/kaI5XJh3FpR7AWpu7sT1Mx/rt6NEnbwH26qs/aPz+?=
 =?us-ascii?Q?nJCnBh3Wa+CATRd1d8g0iS6wqErcAiIYWagl50e72inHg3L07qmhHps4c/Ms?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc904859-2f12-443f-acd1-08da87899e7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:16.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdGp9DjXFeUemhpjEooraj6CvkXcol7j1S8/MZaWaNHnh5w0NBOrEVYP3bNdFYwcGle465VKkj9bBabP45JQ6lSXxo7GfXRJFC/Z+zVGyg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: xvIVCjmpyOR7dgSEL-Cs2lZTEYA9gbma
X-Proofpoint-GUID: xvIVCjmpyOR7dgSEL-Cs2lZTEYA9gbma
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
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event(). During the
process, the kexec_mutex is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  26 +++++++
 kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..3b99e69b011f 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4eefa631e0ae..9597b41136ec 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -374,6 +374,13 @@ struct kimage {
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
@@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_map_crash_pages
+static inline void *arch_map_crash_pages(unsigned long paddr,
+		unsigned long size)
+{
+	return NULL;
+}
+#endif
+
+#ifndef arch_unmap_crash_pages
+static inline void arch_unmap_crash_pages(void **ptr) { }
+#endif
+
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action)
+{
+}
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 0f8aa659cca4..455150205ded 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -611,3 +614,134 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. The elfcorehdr memory is
+ * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	mutex_lock(&kexec_mutex);
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		struct kimage *image = kexec_crash_image;
+
+		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+			pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
+		else
+			pr_debug("crash hp: hp_action %u", hp_action);
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
+		arch_crash_handle_hotplug_event(image, hp_action);
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

