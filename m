Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657F57D32E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiGUSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiGUSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F379EC9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIDuBe013157;
        Thu, 21 Jul 2022 18:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=f+rVUJYklb83MeHY+n4N1syjQ6p7P4VbZlisOjpaAFk=;
 b=wDEj44d7dAGG9UE1NJjnjIoBW4wqtUXRj1lEK9Kt4O2M3uplE5MEZXqAf/DNH6Qbs2Zz
 9Q24QKKWDImLYybHqofkkKd0+r6lbWUGdTKS0REENbNA2psStEJHKo/mcaqK7wqnMs2K
 60nkan8Zt3oXboBjSku03PLonbYHw9czhdM3Jkfs+mFKYQDqXmTQCndcH8VmDlIkmAZx
 PXJ5TRtz6/jQ8ps8wEx0/sM/Pf0GGEzTTSKIMHeEJq3bmvDGelqzBTWAjqLBi00uQRcp
 9x+KBBs+kj93XvybrZXvECfxfwg9RbRGeucXLxV2lEkaNu/jUXG0LQVZ2Haoit7IpPrG GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsdb95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHrGG0007905;
        Thu, 21 Jul 2022 18:18:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k5n709-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+qdeuL2RLEnSWGgpkJoO9OxkygILPQtY0fSeheIScHvrb6vaZwvn5ALjkerQ3Lzf7oDegF5GJQj7FqOMvpypicGchI2mfGgGDEwuOf0L1dDCvhocEmAnlAv7siCFFd1ttZf+K03MoXL7pMfKD6sQ25kn5RKxPSjQbl48g/8WjEv3Xg9Gfb2MuV1AVaTLta2QdRpswqwFhC2StC76/X6dB5/qzUSMr5WHJJiU8uAb4Ce4smpGCVhK5WkFHWrY9zRFHD9xGuIY9YvJJdmeaoCeFUuV5GnzU9KZWoPFkoQZK1NdV5YMaNXU3lmVE7Pf+TMVYZXifiopp5LKeldDA1aOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+rVUJYklb83MeHY+n4N1syjQ6p7P4VbZlisOjpaAFk=;
 b=FpezG+bhf+5zL8oHHL/wMCADAq4Hbh3gXlCOWIjdHbLPsjITHHmPHydSSYk61zSirWzLOK0UneKMJTMIBmHiVmZvQaBkSQ6QTU9jfSl4M9two1dWGNexMQsf9bPBLcIWWCW7AhAx/lFtnz1BEtBULnNYblX8wSJP2GGrM1seeacIae1Pswgf2vgV8mH/Axio7Z3/tFdALTAJg798PFov96FRmNnYraftrBljKVrqOmjqaoovHfgV2WkFX/Vdn4kGB0RKSAOPp89kWcdUzk+Xh0aAZBo+eTuBOhk+9B2onASf5ddMKag5+9JGq1n07k8dVNerTQDpIncgPMsCCIyhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+rVUJYklb83MeHY+n4N1syjQ6p7P4VbZlisOjpaAFk=;
 b=VnuSg9/TsZDRxHrO8CgpZ8BDDyo+PzokpQlli10JbLWlrYRWWIbtaKzCdKhLkcgBfIcC2qRTuAR+OcP7kaTdrpXfSYNzHu4V0thX2qTE8AcVNIciOT+pYw1VFCKXcvuk00HcqKTrpT78ZBAMBNxEM77a4zyE7sdEogOAZab4e9I=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:18 +0000
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
Subject: [PATCH v10 4/8] crash: add generic infrastructure for crash hotplug support
Date:   Thu, 21 Jul 2022 14:17:43 -0400
Message-Id: <20220721181747.1640-5-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 902ad35b-8708-4bc0-bdb4-08da6b456315
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBDatmgvAtKlLFpSK4yKSkzgMsSP5vszu3kGsKkCozJtYWYTnUKuxvE+hym6KXbWI1fD09iU0WmA/bpQ8KJLI+nTpgJ6ORw9HDtc7LZYETNZm2/Yam9GuFHPDP69SQ7FumZ412bLJaANCFOG9dveJ+cNNHNdxHIb+YOg7vINsQ4u8kXs/Uq/LqPy4X0vwo+34ltLhkUHcvX6SPK03LoKLMEhVpXknO8TVCLJ4GwZkm0SCiFyA7/PPfQzzveWPAcrYXVcSJph9aNmjyq04Nm4if3SADs+qNX8hCb5L63kOs9H6Thjsqs7nhLMDD3lBM/JxVmGg7mPjegNZuQmSYKnqJGuG9/ewwVNeAB1pic/cwiYWddW6lQdGaZ6HHO3OuKKm9jjC4QB/zZglE1FDz5MRJFWXFPkVi4FNATD5CTHqjdH6du7pMGlwLdBf0EEHXAkB7t0VwZoc7+zngcjX09K9vujIEdMtoybh43Ol4mVq2lFpn2HYYh1VGUxojsqlQBcNv40P5p9uRXFoL/VffToF5sclXFKcUXVCgIDgtUQ0fcmzgAH6zK0Y2qDt76q+9DEFLDC5DoI3qcyWBY48cQrq1f5rwCzk3eV6Q7tF7SsBL/g8q3K6aTfO/CV1tczFgIlYNoEVKK+CL1rSw/pU3YPFUWRJIH0eUHty3ur+h6e6fpyP/s2lzI+M6Ru+mJPXF4Jt1oP1013NE0oLZsKidZBzzUR0fV+vUAIDEG/Sl3WAf9N3v1QMElGQIuVbaxC98JyUo4LHJHKL++sDEII7W5xPUmWnOzBLAyGn5tvoYYIt41QrFScqx4GwOxyxHpefWw0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(83380400001)(316002)(186003)(478600001)(41300700001)(2616005)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIuLXXdQTtYLjKQU5DXSvTfKxBsrC0TRyicPBAbKZRzA1HBy7WgFwxSLjnef?=
 =?us-ascii?Q?mSqFpKS8Rgto6ZhYBHYYgjvFIqML7CGQnhjutmcOTlfrJ68829cDx+ITLVHJ?=
 =?us-ascii?Q?oqwQFvEv7juxG7uklHnCJJiGyS6cmi1Iz1S/TPYkPwpyGjIQe9PsA14G4bNk?=
 =?us-ascii?Q?I3HMvJ0ptnPKWj8Stkbmwp1aY/3hLtwD0odqlXUfZu/eFzLnY+vUUXxhCOJH?=
 =?us-ascii?Q?jnI0WBjg45PvcO0vH6rr5PpogxeQffBsUe4H+pwkP+nCNKpnPCowYZOD96/M?=
 =?us-ascii?Q?ztJc/7hDcDu2IjCh8PmEXgBDeB8CYsqIEgp4YGZAR9NwFeoOF/IIBlqb2pw0?=
 =?us-ascii?Q?wphrL3OkTHXKCuIXEISTImjeI6TTeG2IpfvwkTx1myq8ArOtHKpgXpNEbpaW?=
 =?us-ascii?Q?0g1gfm0OMJJHMKgZAcRorXlFQxOK/EgfKVLXdJlJJYwPZUI53Lca8MwybNG9?=
 =?us-ascii?Q?NPjtDDCYaFbXbK/Sfj0mPS4QU7+BzaHOuhtbLLZIwtmWKQQcvfaHwLsYwFnK?=
 =?us-ascii?Q?Nltx5uE7Z56H29cdg6jDX4AO8m+s+gcZuAVgTPpm3q0phy8dhepLJSSLfMKX?=
 =?us-ascii?Q?lOW0CAaUROCFOTQQz1X8qfBkMA0SR+azbbmO3p3xuN1f5rAbRuSBqDLC052o?=
 =?us-ascii?Q?6VDd7WrwSckc9Om0iq4dDtlUhDClogLAlkK5pYaYKPrQeQr0DN0cm7Rbluia?=
 =?us-ascii?Q?RWYVIFW13ZslUzuezbqTb5n5NfeOguoEXeuHG3RTIGajsr44MDr9DEcWGJMv?=
 =?us-ascii?Q?hdhNcHHwb9FTTwUuZSpKUgB1thkdW1juIVbFhcDgOMqUmncFDaALGU+gDikY?=
 =?us-ascii?Q?5nJPlliKZCdB/Ff2mhpTMInRmp53VPoVfuWiJhRSjGQ//64kMfyHpJ/CXgvi?=
 =?us-ascii?Q?PqmksJgrllWMIxs3XrVYXB4rsGISbdpnpJKY32vYT4ZAa7Uz5c6Cqd75zP3b?=
 =?us-ascii?Q?Hm5ujll40WALBXpB0V/D76bNYE+7AwiCfTcCjkZFyKYroYYaKpWE3sMFM1fY?=
 =?us-ascii?Q?aii9q8grSkzhfMLpD2ahfnJ6+ADcxm0jF3oDjjdLxBjG8i2My8dc6rUhx9n9?=
 =?us-ascii?Q?UxENAy2V1lGVQtbMbtHiIItGpata6Uvbxbiw3ZVMRJirHRPuGkGAK3Ome863?=
 =?us-ascii?Q?rnjRFHTiFFCCed5fvlt5+4U1PNDRGvlaQ8oDXYcvB+0QSvceWVEXr9pwQmsy?=
 =?us-ascii?Q?INCQIqrgeLBrmHmVwUx1q+RgLmCaU2ipyqtyV7s8bpSBQA1c1689WWeuw3UJ?=
 =?us-ascii?Q?hBb+5wCjkqoa93GVIaZ5fTV8hzvC3CGjt3Copj2mLnBrQQBvipsXbfzxjKvK?=
 =?us-ascii?Q?zJNUNSa5PQuQ777sUq+VvzYSXWS7LWNC4soYRzofE+OvJvj71foGD/gtWQDs?=
 =?us-ascii?Q?+pTRSw0OKZXvahgytY4EXG82YlVlgbBTjWUA5E/bg5Zcx1FE2pq7a5g1RE16?=
 =?us-ascii?Q?3b6fJVpWQsGuSMT+c/KQgqQuGFWZScq7PZMa3e3onO0fLyv14r9YVk009Y9n?=
 =?us-ascii?Q?5Q0pGsau6CWrsAvdVBWl/jVqWubaiELI05YST3yguIUwU7a9lgHMNS6D/+GM?=
 =?us-ascii?Q?i8HGbJWJI0lAlB1qCDUD5aUGym4SXC9kLNIagXm0JAah9YuikwqC5+iEl745?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902ad35b-8708-4bc0-bdb4-08da6b456315
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:18.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XW8DY4wZx/BmFV9hT6CttdCS76oT95OdaAKHUYbtRDWNrFf0ThRQdjlH6mLpCR6MzGwiJpgscufbac2kqfpvpOUx14FAMqRyAptveIdqcsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-GUID: xIz57JN0y6BDx9C9QZ16jpqdlN5psdWo
X-Proofpoint-ORIG-GUID: xIz57JN0y6BDx9C9QZ16jpqdlN5psdWo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/crash_core.h |  24 ++++++++
 include/linux/kexec.h      |   7 +++
 kernel/crash_core.c        | 118 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index cb0f1916fbf5..c9705b6872e7 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -86,4 +86,28 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+#ifndef arch_map_crash_pages
+static inline void *arch_map_crash_pages(unsigned long paddr,
+		unsigned long size)
+{
+	return NULL;
+}
+#endif
+#ifndef arch_unmap_crash_pages
+static inline void arch_unmap_crash_pages(void **ptr) { }
+#endif
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action, unsigned int cpu)
+{
+}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5f4969cf3f4e..7694aa77b92b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -340,6 +340,13 @@ struct kimage {
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
index 212d4dad0ec7..154ef532d45a 100644
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
@@ -587,3 +591,117 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
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

