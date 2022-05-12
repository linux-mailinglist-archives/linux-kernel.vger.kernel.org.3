Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB9525742
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358893AbiELVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354943AbiELVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38543EC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CJxkOS010429;
        Thu, 12 May 2022 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wCzJ+fhQFHx8Vjbt3S2LgdprYaZhra/6gCOdfsGEKos=;
 b=f7Rbj/kYo84axy21hWojgBDDW2Z8QgiPUbKPj8vRX87WPPVDzyZ48JlISF3iggZHZgIs
 Q1Thmlzj0/mC1B1oN3fscmS30xrULrCrhtpepMuNwh6lFmhiCoMlz7d7n4RkPrhJf4Xy
 thgEDWxkUlpTTRkDFM0CP8BsU0Cpg1Ke64D3cTf95iRw26yfgHMhE+TrD1xOclyb7FBn
 cajpCGFPwRlQv7fKjEXwpJBF/UUTwwgh/a3pkdxlBvFWDWcU4BiJepNH0du6TDaJ6XdO
 eCmFt/CAGSk2bYO8ATtBemv6d4Z/jRQCgex+Drv2QwcoMeU2XOOEAL0Gc31E9W5e6Xd2 IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cdn01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgIkP004728;
        Thu, 12 May 2022 21:47:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98s9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrEYnAYj8qXtYo+/Gp5IWIcJWKWU5JXTC3IGaeZ0lKCdviGw3sACjyqTeb5aVOP1jjNuMO45uz3ntolT+TIC/g67G7ZKXJdPp2VXe1tvmU3aeNPHb35HFC4vrCGaHvJbNnm0Os0zScXDKTWCcTNRSGDlNlEbsXEhVMQ7ig4ZZhZY/6U2HPmdAO/LeaAzlQ/2o+DTAoxXu2sX+gjwV1HxtcqBE/SftHAuKKWZDNqwaTy4oNxcW3pAXXBI51P8fIA3VkRs4gcUQHrWXOf5PwpYI5u00z/83eZwoUwkUlBugMby+7tS3Fh3uNS/zmlP9yD1hYnAf23ulh6iuC5Xlgm59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCzJ+fhQFHx8Vjbt3S2LgdprYaZhra/6gCOdfsGEKos=;
 b=Gt2uxpZkZGBc0PR1usi18pJlzQfIJcktoRlSBX1h8Osmnw5r0kwLxQE15pOLGYmdSxxVIVrxYm5btMP4wtz3c3scNy/5RqIm0WPNBiVvb9f4U9mCRoUlrUEzKcAabSNkw4B+ZY77TgjLGxR8WtMI97X9o+xcQHnFzglGJiSNeWvaS4d3OwdyZu0tTuPrYptDQ8w7aEyY47etCLRo1ZXkXVYa5DGsKRpCp08jPflcemdV+6B9smU7ZDoF5gBKiau2f+1qnz9Za5Pa4myB3LfpJd6PPj4mY8PizEib2Q/IfxsvlA98FrU8CESf62cD1PsWBGhhqt86y2GDrYTTyGcMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCzJ+fhQFHx8Vjbt3S2LgdprYaZhra/6gCOdfsGEKos=;
 b=ob6L/bxfVzTUT/BZUUdbMmidkPAwhwoecIgvkY7yZAGpBijFQjU1YZvR9SpTIeXT5+43ozkydZjF7VCk2P/xl5To/Rv5j6BIAEo5DLtACcBHPnEja1tDYbeXhFRVe/NAK5xsOMjV1I+P6LyiPrv24/HmeZS5mbtQqm6C9280so8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:15 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:15 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V9 6/8] vhost_task: Allow vhost layer to use copy_process
Date:   Thu, 12 May 2022 16:47:02 -0500
Message-Id: <20220512214704.104472-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
References: <20220512214704.104472-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:4:ae::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9f6409-7565-43f2-659e-08da3460fa5e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3311C16F62A9707E10F7D6F8F1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThhHeaMuE1NbEyzq+vOiv1JRGbiegKWu15nOCNK20qAQ+GCMQe4SUP/By5JH4n/fXL3bNWVkgpxQsnCIfDuu7chm1zzX1tS/i4mjs2YuO56VIoPVs1txIdS74TLXbs2L45w1kAzTSqSPo9r5s1Ckfe1CFCCNXhdhxTMvkODJrAFt1ywjI80mLOe9ussyeogx5bLD0Y+grKru9lzQD/4XsQ55SCZuXGRlSNfI6VCyLYckZFkZSwuoNZD/r1qa7XJP0D2j13+N/YDzpkf3Bnma4Fnxpbs3r79Zi71Z/SI0hgqTX4NW5xsX/ZopBlrjoHv2P4sm01SpXrVXtU5yc9CfQMSzbVqXhNs6FFVbi13E0/n6k/v7RHR0Q+W8ROC2G8G2VUKwE97Uv8yK6uZvEKtYFwtFRdoZv9e9erY3upFqGghZXpp0tauIFPCQ7bD+7E9hmpLE5EL/SvtIYc362mRp1ONuK7zx3ZAym2j4bMFY9rQ4JYAfW8RMWIl+qTkLXJ2v7Thf06biEjtJKqWIGcJhPQUlbjU2+8eeBlqxczoYw4khoIeGd5lyT2KSabRCVprCvT30NdSvIuL2kIWe+C6WYqIrVNX6eKQBAppiv3MEWdX6ZDWQqI2m67icii9mmo+NQNIuSsJmRPqCr6bhCpgfAKjzlpgXD/TkEf5td4tkYspByI5S61m5qPQ/JjqV3ylfgXWngM9Z+V3dIAjUEMYNSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(38100700002)(83380400001)(8936002)(2616005)(107886003)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mey+TXyrgdvoLpPMwWRRiRXnsdULMqp7O+UTdxwqkYfk/9rt0Ca9EwSm/r7V?=
 =?us-ascii?Q?IG+CX6M468PClfJN4O2x4moKkaqXwNggZP5sz4fLqvAXoLI90TCVuc2c3LYR?=
 =?us-ascii?Q?ZWeGbYz9Dxs9vGc5Wc004qySy3aEVdX/VTnUOk4N3UXF7PT2Pgb1k9uj9oxL?=
 =?us-ascii?Q?PAB807nyPP/M7KqYjnuneM7wHRS28/JMislDWH/q63nvLCTRGBZWf/gaVrY4?=
 =?us-ascii?Q?TMSU6vD4qzfuskzUotl/b+Rb+m2pJUvMuCMByhJ5AU7X2OuMPUUr7xzjvMM+?=
 =?us-ascii?Q?mR0j6h0gdF01Dg0dsx+Xxm57DmELL4V2SuKBlZV77tjjdMHBhPSAen5WZLt3?=
 =?us-ascii?Q?UZIj52nDixTpe4MAv2PNNmw39LWNe2p1Gra+6I342BQfe8BHHs89jYybUkJF?=
 =?us-ascii?Q?ZkR6fzpslrUnH2Xz/qHobeJNnYFZjabNowUN5IDDETJ5DhrFmqhqxCPORBjg?=
 =?us-ascii?Q?M6RZKMIIgSytMgkr0Q0J8aH4j2H7lxaTrTF9DWbFJr9jeTl4MO6cYh4Fgjxh?=
 =?us-ascii?Q?zNb6sx6ayMUXag7MrNiPLGmpIeTIVB6NA7eomRneyhQDGEI2NMu3DqSduiql?=
 =?us-ascii?Q?fyS9YMiALitnznCdbXisfq3K7Cq9k4gbZKt0mc0WAN8xcUOnOD5lf712BhCa?=
 =?us-ascii?Q?TxWJFsLjMWGOqvj8l5Q/x6sQZG0v6isUIjyibmV7w0QHBInIwgkqrMvvpML2?=
 =?us-ascii?Q?fg8Z/bH6KKy8Gv4HMvdQkbQj3TUfQ9MKjowQQIEtPwmusB88n4j17ibNgg+b?=
 =?us-ascii?Q?fpbV3EHTrKGFaSH3FYagWAyuVTh6PEAypDjiPjxRQxR0spjREFPO4hVirnbt?=
 =?us-ascii?Q?7hpnKDmyekm6TlHeSrMVWWkyXG0rIPO+QIE7bHzr0Sua94rUWwnc9qy+GXWN?=
 =?us-ascii?Q?lf4xmxnNP4uVEWpdzvWWXrdcMqoZPCoDupjXjqT3YkDlQPE/L+VYpgcjBsO/?=
 =?us-ascii?Q?9zEnr5vXInAl/0tya6FS/G4dLAq6C+M0bc0KU/Kw9zNkASHcDSWWSTXfpUJx?=
 =?us-ascii?Q?3y3m1+Ji1SKoq7VJCZbndR+rGCsitf9FKmHRfrCcYOxfspHei3Bli6++Dz5f?=
 =?us-ascii?Q?DpFJGEt6nqhpfdyxHp79e1iblU3LnU0E+dJk0y/oWY84oRgkfHgGbButMnPZ?=
 =?us-ascii?Q?EXcNIVVX17GZagl8X/TTQ8V+Dsf7nXZYCHW6xvtGSERo9T+wjX7AkXxYm+N5?=
 =?us-ascii?Q?+pt3iLE8+co6CSgo1rPLaNGkYbKXkRf6xEth+sGjGd69JitdNndl0zgvSotP?=
 =?us-ascii?Q?L0G0WEXPqslLUhuuducOZIbXJKjRLcIMPMl46n4F/wYYZ13E3GT2tb6qr6Ar?=
 =?us-ascii?Q?+EW5hzX0+ZDoyxl1dYgoqtpXDGI7LN98LsF85ZMSTbpatr+nqji2OVv8qbdS?=
 =?us-ascii?Q?nzi0s3Gv1pqBLYHXcfBwmx26vzKDuCitzm7MnVxc5/kWoD3rTPuwkMiOSgRT?=
 =?us-ascii?Q?la0/xLt9W2mqV7M9B29qVYrJf/9j+OQiryAnr48Y8l4Tx7BkedYekKpoI4ko?=
 =?us-ascii?Q?fjMNUVLLyEQh53IscLjWTro+T3oCBrGub0h9tglDw3krsHKdMIYS9zChIK9Z?=
 =?us-ascii?Q?MHvkwz0/eSENX7j7EKBEPuvW3IdJaVRKTviuy8p3E4mkrvI20jhUGNgDwD4Y?=
 =?us-ascii?Q?sF4f+q5eRm8vqHe9V+sXAtjhw3GKjhJUlecHehwfuapgeHdlATvBhy1tbHax?=
 =?us-ascii?Q?XC0FCjTVzbCJrK0wXF5j0oSGwfaDgSePsPeVoegtpICUUHZt9thCWfuY0vjC?=
 =?us-ascii?Q?qmcCsM/V+Cdi7KL5Mz9BhNHkYziiUSY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9f6409-7565-43f2-659e-08da3460fa5e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:14.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISeGuq5oXdC0VYUFq9DHiJlOXM9FMAFUxBiQuTcp07DbvuAjMhYJyU9PoL+MToVDoTVHgX6t8p+POX+otwXrWQm3TXhXFL9pNjIagzjjiEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-ORIG-GUID: aJP910P5OPdO0ewXR_FyDNI3XIVs4zwM
X-Proofpoint-GUID: aJP910P5OPdO0ewXR_FyDNI3XIVs4zwM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups, and it bypasses the RLIMIT_NPROC limit which can result
in VMs creating more threads than the admin expected.

This patch adds a new struct vhost_task which can be used instead of
kthreads. They allow the vhost layer to use copy_process and inherit
the userspace process's mm and cgroups, the task is accounted for
under the userspace's nproc count and can be seen in its process tree,
and other features like namespaces work and are inherited by default.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 MAINTAINERS                      |   2 +
 drivers/vhost/Kconfig            |   5 ++
 include/linux/sched/vhost_task.h |  23 ++++++
 kernel/Makefile                  |   1 +
 kernel/vhost_task.c              | 122 +++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 include/linux/sched/vhost_task.h
 create mode 100644 kernel/vhost_task.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..94c77f4a1ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20919,7 +20919,9 @@ L:	virtualization@lists.linux-foundation.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
+F:	kernel/vhost_task.c
 F:	drivers/vhost/
+F:	include/linux/sched/vhost_task.h
 F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h
 
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..b455d9ab6f3d 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -13,9 +13,14 @@ config VHOST_RING
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
 
+config VHOST_TASK
+	bool
+	default n
+
 config VHOST
 	tristate
 	select VHOST_IOTLB
+	select VHOST_TASK
 	help
 	  This option is selected by any driver which needs to access
 	  the core of vhost.
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
new file mode 100644
index 000000000000..50d02a25d37b
--- /dev/null
+++ b/include/linux/sched/vhost_task.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VHOST_TASK_H
+#define _LINUX_VHOST_TASK_H
+
+#include <linux/completion.h>
+
+struct task_struct;
+
+struct vhost_task {
+	int (*fn)(void *data);
+	void *data;
+	struct completion exited;
+	unsigned long flags;
+	struct task_struct *task;
+};
+
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node);
+__printf(2, 3)
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...);
+void vhost_task_stop(struct vhost_task *vtsk);
+bool vhost_task_should_stop(struct vhost_task *vtsk);
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 847a82bfe0e3..7fbf3eb6a86b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,6 +15,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
+obj-$(CONFIG_VHOST_TASK) += vhost_task.o
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace internal ftrace files
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
new file mode 100644
index 000000000000..517dd166bb2b
--- /dev/null
+++ b/kernel/vhost_task.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Oracle Corporation
+ */
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/sched/task.h>
+#include <linux/sched/vhost_task.h>
+#include <linux/sched/signal.h>
+
+enum vhost_task_flags {
+	VHOST_TASK_FLAGS_STOP,
+};
+
+static int vhost_task_fn(void *data)
+{
+	struct vhost_task *vtsk = data;
+	int ret;
+
+	ret = vtsk->fn(vtsk->data);
+	complete(&vtsk->exited);
+	do_exit(ret);
+}
+
+/**
+ * vhost_task_stop - stop a vhost_task
+ * @vtsk: vhost_task to stop
+ *
+ * Callers must call vhost_task_should_stop and return from their worker
+ * function when it returns true;
+ */
+void vhost_task_stop(struct vhost_task *vtsk)
+{
+	pid_t pid = vtsk->task->pid;
+
+	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+	wake_up_process(vtsk->task);
+	/*
+	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
+	 * freeing it below. If userspace crashed or exited without closing,
+	 * then the vhost_task->task could already be marked dead so
+	 * kernel_wait will return early.
+	 */
+	wait_for_completion(&vtsk->exited);
+	/*
+	 * If we are just closing/removing a device and the parent process is
+	 * not exiting then reap the task.
+	 */
+	kernel_wait4(pid, NULL, __WCLONE, NULL);
+	kfree(vtsk);
+}
+EXPORT_SYMBOL_GPL(vhost_task_stop);
+
+/**
+ * vhost_task_should_stop - should the vhost task return from the work function
+ */
+bool vhost_task_should_stop(struct vhost_task *vtsk)
+{
+	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+}
+EXPORT_SYMBOL_GPL(vhost_task_should_stop);
+
+/**
+ * vhost_task_create - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ *
+ * This returns a specialized task for use by the vhost layer or NULL on
+ * failure. The returned task is inactive, and the caller must fire it up
+ * through vhost_task_start().
+ */
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node)
+{
+	struct kernel_clone_args args = {
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.exit_signal	= 0,
+		.worker_flags	= USER_WORKER | USER_WORKER_NO_FILES |
+				  USER_WORKER_SIG_IGN,
+		.fn		= vhost_task_fn,
+	};
+	struct vhost_task *vtsk;
+	struct task_struct *tsk;
+
+	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
+	if (!vtsk)
+		return ERR_PTR(-ENOMEM);
+	init_completion(&vtsk->exited);
+	vtsk->data = arg;
+	vtsk->fn = fn;
+
+	args.fn_arg = vtsk;
+
+	tsk = copy_process(NULL, 0, node, &args);
+	if (IS_ERR(tsk)) {
+		kfree(vtsk);
+		return NULL;
+	}
+
+	vtsk->task = tsk;
+	return vtsk;
+}
+EXPORT_SYMBOL_GPL(vhost_task_create);
+
+/**
+ * vhost_task_start - start a vhost_task created with vhost_task_create
+ * @vtsk: vhost_task to wake up
+ * @namefmt: printf-style format string for the thread name
+ */
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...)
+{
+	char name[TASK_COMM_LEN];
+	va_list args;
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	set_task_comm(vtsk->task, name);
+	va_end(args);
+
+	wake_up_new_task(vtsk->task);
+}
+EXPORT_SYMBOL_GPL(vhost_task_start);
-- 
2.25.1

