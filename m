Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC1550E60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiFTBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiFTBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA5AB1D1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JKACH5013171;
        Mon, 20 Jun 2022 01:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=R3fLhmovGlX74ReigGhVPEWVr7zEEzYeYHsjq/K7XQ4=;
 b=K1CjLA5cw38X3kW6URY6mS4Z2UxJceuleVO+BQxyDJ+3BWpy5x6SUdRTRxtHkn3QQuPr
 f1LCxqEjMAfOkGVX3SapPvzvEGy5L2kSXAwZCU2oFNoDAlsD+NJ36LshcyYDrbj13nUs
 T6e0VhuWZjSlIPz9wqnVU6FYceiJVJJALcu4c5eesqqyZXu7YIK9tOJEFfvqNSKYwotm
 CpqH8hcXmHEBVlJPFf8I5Uuxl32Z+3WQIvzRf/MgDsBUOu7ErhnkPZQhLtjYR1vZk2NR
 7L5WgAjtuinuZDPfSIhBhL+ZCWCvkpeca4pWXc6x1DkgIoaILKKf6aFk9wFSCqXPNwbg BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cj1bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K19qKs038388;
        Mon, 20 Jun 2022 01:14:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbfn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsovWcrUcldjnlvogvvE9yYEn8iu4DDhQLK2tqTVtZgEhG0PB57x1pxj4aiF38J7lKrYSi0zvjKD6ZonwTiHt3Py9QGJ9bv0eWbx6KVI0+kKXFzGljeTHY252Zxqc0932L/R6O14O6mn5GKEyYzsvA2eiGgkOcHftWqWCMbpjYc3SP7lWNUlfsKsMQP/m9ezK24Uc1RKVYB4OINZKcYP9AdE+1Pvkup1PCA2wYrkvJkf+b4t506V++MarKgCsdJ6ZdVF0geJ/G5i/Juwkms1UcZ9i/hQHJOmyhr4trF9O4oKDvz1fQ9f5i7IVmCfGrOFLYVeaJlTa44ALBCYcOCFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3fLhmovGlX74ReigGhVPEWVr7zEEzYeYHsjq/K7XQ4=;
 b=fHBxlt9ArMSkO4N2bt3Td38hkAe0TkfFnbFXCU98LUTkRG44+ip/OawZvhSdgXwDdy4n8RxDoiWp9EcoDZwi5oh7A/H1Iz4zsA5cCyM9HZ7lMS0KHpyn6bFn3yZUqTfWh1jgzVHh+yn6RuGa9aa6jon/OXmCidBnNAKA2kFLWwagu+S6Xb6CX9OuFfGA/gkkGoVaq1Azc+jWQMGFpvmezTvEyxSJ/W3zv8B4hHVfElyJ9jcviPFu8fdcdp7KnPH73SAAjdcIR8HZyzhYid0USejppoxOQyr2LzdZbtxW3IywObOPXGyBspRo6mUCtKXwjiU0U5zWzlNOcSUZtfdVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3fLhmovGlX74ReigGhVPEWVr7zEEzYeYHsjq/K7XQ4=;
 b=QZrqXKmoMPXPvGaoF1FipyzvPG5YY1ZjenmVRPqNFa8LH/wquizUxhSsm/rUXa/wpXSu4En/gE2yiVN0XvMuZ28ZLQKbJeari/lHz9tHPopWI+XAtl14VDdFJfTso01Gp7Z9dRwhIMWqrQbAnOTkJ4WVwHnYj11stb2Dya/k0gc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN6PR10MB1905.namprd10.prod.outlook.com (2603:10b6:404:ff::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 01:14:11 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:11 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v10 6/8] vhost_task: Allow vhost layer to use copy_process
Date:   Sun, 19 Jun 2022 20:13:55 -0500
Message-Id: <20220620011357.10646-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620011357.10646-1-michael.christie@oracle.com>
References: <20220620011357.10646-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:5:bc::27) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8cecb3d-58cd-4504-7994-08da525a2e39
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB190519793FABA71E0A5CEB17F1B09@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nJTL+dlOTIzPUdrdfl/lduPUL9TqcdgfiW3ZQoxuuVWBHgDe7Efxxt55VddM5RLeROP7x+7j7E0L9NUORbCn/e1P1Er3xWlNjK40W2YgIB2x5ASKu2QVyYA+ZEz4xt+cTPVbKghVQhteh7u5XlE23ySxiT8Jwc5aeGob08o8s8ItyG1mwOQuJaWS4HYbfMnRsLTuMTm7vcly9bKiD+BBc3g37n/APASJpsfhBcI4oE7XRPQ6Y6ZOyuMV9XjFhs2i0/3pmsCfp0xv0k+jKKdVn64HlfERyNAhHie/CwfBBsk5EngTd6V2DQcmn825QqeDahkKCHqXFiyi3lXt6NO/f9bo8fxNV7KArS1e3juSi1rG2hKjO8ASaAYZON00OVH+i5kusKTLImAIyp34C7lWrI1a7skPykRpKEmxTsvhE/uKEhBGCfclOQmFr+inL1KVQW2g4l8Yrsk0qPrC1l22da4FrvwGUAz4icTkBFabi1N6aheUSdJhhGkhFV9dEQsxtl4ORrlChglZ425URH8u/LD90NYDPtmqsb5hccFGSjpbxJv6+9TdM4+OaveZqYDg145jmKVVZmdvTmtdBf3CMvCorsWMcFH6kbwFacDHp1usBdVq5336589eOVetYKuEzGx+LUkM6y643IkGcSa0jgYm4RfyPDMpWk9dRue0A+tz4nqFI8ejVr4853Od1I4V6zt1Ryr1b9QULfeZ+3mbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(38100700002)(5660300002)(2616005)(6512007)(2906002)(6506007)(6666004)(38350700002)(26005)(86362001)(52116002)(66946007)(83380400001)(66556008)(36756003)(66476007)(8676002)(4326008)(498600001)(1076003)(6486002)(8936002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZTygz3mVRv8i2NaJiO3GnD/xV9j5cfubP2v4pyhWG/Xook0JPprxa5hyDnW?=
 =?us-ascii?Q?SLBdobRapSwoAK0F09vBjlyv52d6suf9oeavn0jzWm9OztPTWknWT6YV1mj5?=
 =?us-ascii?Q?U1nHBufUJsoIEd4BrlZGPMBke1W2bNswFP2ubTwyC9MBiKlydMqwom+OSCfH?=
 =?us-ascii?Q?epZsTBLX/hBdb4PIeeEAYtqkh1pZ0rH6YCUOCiDNsBs9g5Iqe+BkyD7SNRgA?=
 =?us-ascii?Q?oYQIy7dCWyd+bRA1R0qi435jdBrXarjcOT9jFfbhfOgnmL1l8xBGK+grCEuk?=
 =?us-ascii?Q?+5QICDJLlTPLrocK7mm9ZbqbsDe7DvRtOFeHwjegY/UHj3LGPTalrmmkcw9X?=
 =?us-ascii?Q?7y4tRAeHlW3bnvzJl3Dbe71V+kyaJXh+Qpgu3wiPiwXv1u4TXSbh1Jeu6lL9?=
 =?us-ascii?Q?P0c2gJv5xOTypfU7hnDe8Vk6Eg2QUB3hVY9nDzjKxdIwuNCnucMF2XQYdTSv?=
 =?us-ascii?Q?ss8G3UOQF0ngHole1pQMYLEMksh9/YL9gZS759NPd4lenHyXdogPWO5PL8Iz?=
 =?us-ascii?Q?PqWNlIe4ZOiOhoZULuWkKdaIkEu7vTN4sEUIW5GVsiyMqYcPJYKKiC05Ve7O?=
 =?us-ascii?Q?9hkn6TSu2Xz0ZEeKxMHR50MKtBnfF5nMpDzDtqxWCBwqIavOlF41WwMf++Bz?=
 =?us-ascii?Q?h/NJEhdRyNcg7sF6bIAHRU6KKNMq39/uUw4P5ISwUMZuuxAtiQlEJeVoCaS1?=
 =?us-ascii?Q?GLHEN966FvAfTeWnPWF9A8eaIsrAF5fPZkFHx5atJ56YWh6dZsGyWww5PUXE?=
 =?us-ascii?Q?gQdYrM0FFMbK9MZjQ94am+Gm+lqTUwplRKkHVTg4nPepbcK/D/yg2bXLvXYV?=
 =?us-ascii?Q?5Ls5mopt43kvE/QXHpHomiHx9IV7tus8p7xzngr/E90cPCceZkC7XE9OkojS?=
 =?us-ascii?Q?abadNyTk1tEAWphKCLantW1UJdfZ8bOG+vvjZhDPglmh0xlK4nqldlq69Ou9?=
 =?us-ascii?Q?g5Ez9I/rD01lB9c6hpHV1PS7zeVINVUAQmsvvHcS83KAb+vBENDsL3sJKWSN?=
 =?us-ascii?Q?TV0yPoQVKO9tR64Vj1SN6G6xBCV74S9RCn+hjHSACEh0dgH1jq1A/U0Dg/JD?=
 =?us-ascii?Q?6KoZL1AvR3KzgEv90vxD/zL23W0HHh5IOdpkebjEs1N3lZS3NaHpj5TFqB+W?=
 =?us-ascii?Q?zID0RCuaoD4RY1FYCQPMbsW8e2YwM5Fh85sglKri64tuDuLPazzBwA6SANfv?=
 =?us-ascii?Q?xQlQPZMWpPuy0cORQgs9nYzxbBP2sjtjuog4pYdhpfTAlZww2aO23YyQ8O3i?=
 =?us-ascii?Q?0cjhZhH5GEo5woYHsF2vELgLeYkVKGI/Oiw2bFxehHhH0ljiXsxb++yGOuMe?=
 =?us-ascii?Q?p5iDDz2+ka4j1YaUzhjErnkQbTNhQGipWBY2umcWAOV1fZCeM8HHxLNJjGd7?=
 =?us-ascii?Q?3vTZnHWsjX8c8nm02NkiakRVVk1kictBuWe2yEZCsNR2UEgGearT7blKjThV?=
 =?us-ascii?Q?It9EJgiu8LMpExa6Iyii8b28eSkugmDKryaJ12tLotR9RoOWwfJyOM9nKIVB?=
 =?us-ascii?Q?8yCC2ej1hdHbrJM/POCYvnwUJhGBwpRFFqBLlUtXCBROcnHl7obtcJpaoaF9?=
 =?us-ascii?Q?26fkAPbKlbOXeWZSXDyi+488xtMxfb/c76ybT02+dGznOR3xV8FAOx0ifn5j?=
 =?us-ascii?Q?BKgGe2gQUEOEGjwMVKIhYY5j1Mbvhrq6X+ucf+9J/NxxR9/GXidu9xjsmrdZ?=
 =?us-ascii?Q?HbkpqBRDKDDQ74/omRrp82DUk4XkcEaRfRg3KCim4Z56lTpRlpiGiw1kiH4l?=
 =?us-ascii?Q?n3hMpdwfon8RmxXALhwAjyJ1X7P6aTg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cecb3d-58cd-4504-7994-08da525a2e39
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:10.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKuD8f4X4Vm/NLka7z+ZgjhKZQ4OsO2MYms+RrepVG5q/vY81Jf3AZK5F7W291T5BDaHLy8aLTk8pIluOpCTOoOfGzBb246AAtAmzv8tKho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-GUID: RnuMfabyio46HaR2fQ5CfnNUPAGokDbZ
X-Proofpoint-ORIG-GUID: RnuMfabyio46HaR2fQ5CfnNUPAGokDbZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
index f52543aedd61..8efd697499fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21147,7 +21147,9 @@ L:	virtualization@lists.linux-foundation.org
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
index a7e1f49ab2b3..c00409e526ad 100644
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

