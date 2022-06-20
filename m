Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF3550E59
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiFTBOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiFTBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F1AE56
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JGMllR018105;
        Mon, 20 Jun 2022 01:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1KRUDfUPo+LLJbbs1Hnq4JIM4YvRLAh2veNYL8Uax/Q=;
 b=PjVKjRz/LxpyoDNgtBOFgt26KiUcr9tK7DRbM3IkdQAcdPkRpEqorAO2BP21A9o4pvbK
 0zba6uRGkKXaAJTjaKrjKWijeHbyapSxziBPbUZFN0jhs7r1n+14jpPv5ztQPIKmF/WG
 E7DhuzRadhPhX8bVNTEEpo+djjNyY4OcFegSvWHD7xf8weYSTYtH0urik5LggRhSE8Ku
 cld7jjmh1FJ7sjncq601/7i3gq4F6k4OAHU37TIDfXPimohfaIbtIblwRGiC9+C46bzo
 FmF01Rh1blragUJO5lB0e1brz/OfFjGrHiG7+J4zYs/ep/joJ5J4T+m+d6r/fUDLD0A4 vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1t12j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K19qKu038388;
        Mon, 20 Jun 2022 01:14:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbfn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUC2rxflk9wlKY7lt60b1wWsSWBk7Hox9hVq+GS6VBRK9g5j4YEN/xwmw94s/MYHUwbXrq4FSB6Y6KVNqYtWKkxNjvk8Ysy4WKkYB+3Qpm5S1t+qgUqnqcfzTToqWgZ7+EeJ4l3hW156kgWZVr9S9bc3sixMu7sAvcJG2mxcclz9ECsJNnbaYrZePPHayWqKSePqEEKu96ZjoWJ+K9gTuO5M1cGgy5gLVk+h9V1y6ITMCVRCIEVdE56QhnTxYbeNMCxIG2umCOwIi0hzYErQAwlJrAYoe59x8ikgsn6z/r9ncTCG86BowvTJvLCfuMkcbS5wgokfCZn25zT5MuKqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KRUDfUPo+LLJbbs1Hnq4JIM4YvRLAh2veNYL8Uax/Q=;
 b=NQ5ACiQdkTqLW45F4POZ1wj2jYbbWCm4RnykfGbLldZQUBR1sPWir1/+cNOHzMNlPiKlmnq91lrbLXJRvvh76Cj6Jjz5D20BEZztXuL4GPVkhwOlENdcs9pKCZg9pXzf1S8UQut17MCuorLSKKmil/7U5GMGXRjqMV4tZl7Qp9L6WkwpYMwsv7q60ZN0/n3ca3g3mlpouNmmhroxtYEZIHYu5gs6kH4ze03kB++y3O9dE5ldXLcaLewD0dLZWmuR51hGxaT4jjiSzOYoF2+Dy/4ICQMlpMBfc1+vv+HQl6bLcQxtdj5DcXstknN5OX2t8GbVcCT993fL4MHrl/SKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KRUDfUPo+LLJbbs1Hnq4JIM4YvRLAh2veNYL8Uax/Q=;
 b=cJ7a8L6sOf8heeptLHVIvvyViEnCnnooyTmizAJjpnaOCxx5TXJvZE06EAhE/TQ4q0RPwpY8VZJztRzFVE3HnOaSf3tpd1ip0TWy2mLVwxOXzZ1WiM6VNRUaiER7QsE7Aa5jZO8MTyvqsHVQRZ88PYg7W2u3nL9RK/Z+arNmns0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN6PR10MB1905.namprd10.prod.outlook.com (2603:10b6:404:ff::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 01:14:12 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:12 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v10 8/8] vhost: use vhost_tasks for worker threads
Date:   Sun, 19 Jun 2022 20:13:57 -0500
Message-Id: <20220620011357.10646-9-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 942dce6c-067e-4349-b6ed-08da525a2f3f
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB19051C5AA9385D76049E31DFF1B09@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMw/0BpiFH76eE+p3FhWaSvHf+jAcj8H954vaXVX3XOMjvPzgTn0yBQDnrPe4st8VOAqxepHzTHZNLEQ0/+2lo6WgXsRyPoJE9jPtwdRzNcyLxVCS2SdoPHUbRMkv2eQ+Xg2MxyxtKzPlKvpn0JmoaIDrFhBvasMKF3dSe+dHPOwNl9J7AweELaPiRSJ+eqgIISzd5pJAeu3f/sWp/ewufz6brm4PuSTXhJZGNZaIxfSRx6Q0D1Df5aelUe8ZFphQNdLcOjTXtRvsE+0hHNgEaAALEyC2PLnhCFmt0omCKqNTtKWYYtyGAUhWwweLZl1DJLonaKlcoBRJY51XbVg9DfKMdmx8Xo72PANPnQm6teUo67Ab4ypj5ixjxS3wzmMwXSbPYdWvGHlTqKOYYDRvnYXr+nEA3fN7ABv12kkCKtQTl16QUTxiqa4sx7VbJn98JSpc9wl16uuLZpJErxoqBMKrziN+6ajQdz7TNZUACJlUuWJ/f/P/h0uVM0LtEtTzOh3jXnPlA8Z3HraZYBD/jlPAH9ehdu15Be5BeqVcHE/5ish4MbuelmnlgCQCFE+WzLAr0fBuiaISpDGVzkWExcDF0ICp2R5xucA3AWdutHtmO8L6UxXYhp/WN8Ob0g8/6VKCx3pZbx0Pp9L+1k8YqTbziXVYoJbGaMEsA1Jz/MFqvDY8xPjHI02BHu60YnVRcNI4bwINEn8kRw5S++cbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(107886003)(38100700002)(5660300002)(2616005)(6512007)(2906002)(6506007)(6666004)(38350700002)(26005)(86362001)(52116002)(66946007)(83380400001)(66556008)(36756003)(66476007)(8676002)(4326008)(498600001)(1076003)(6486002)(8936002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+3u+BZ1H/+i7mJPbhRjWbwlobLeySeuG72J1kn0eD282qpLtLCk3hMnKlNN?=
 =?us-ascii?Q?uZOAGY3oB0SUEGICWvj2151ZdFppfKJbxbh7AnKaFFCQ8ssZk9YhU7HSbA1V?=
 =?us-ascii?Q?287Wa37VMqTrnne2zpYpoBZ4skCvs1DVH275AUrUSAIIUWT7QkrAZsprvxxG?=
 =?us-ascii?Q?E06f9gIfb5RMjb9G/1R3qAd9G0zFmvHVm6jCpYdLylBYjjaeSn6Ir5oOiHLx?=
 =?us-ascii?Q?vDnWoIHQloFC0lLaAuegRCfi359S3Jk6g0yUFkoOobdLZGPFauFqlMegPbME?=
 =?us-ascii?Q?AYscIyFUX4vWDaT2Qmb4qYyegzZf4PD8Om9kxzFmwhNhraaoCkf0uD9spfqq?=
 =?us-ascii?Q?C6Wdm3An9fEyNIBNkBpaCSQ/e+kzdBX21OcTIck6X1ysLNenIWCvmpu0Wg3D?=
 =?us-ascii?Q?IX2FTYnnhjsO6mxz2nUclUwro4Mc7vJXlWVVFhJNFPgKA3FLbQh+zZSfZqtE?=
 =?us-ascii?Q?NYo2djOpG/Cjub/GTrME+OIr/xm0kJMqFix4nR8CMSzStVcqUxDNDoxRbd8h?=
 =?us-ascii?Q?c8Q+KU2Ffq1zsakCZ8mcDHzUKOX6KA4Mdh63ideY9fe9bZQGzG+VNzRoury1?=
 =?us-ascii?Q?mytZsSqgZktZBZ9l2v+S45lTsSv9ZF6tZfYihhEwiHEE2WP+m3kMuFem93rV?=
 =?us-ascii?Q?EPIkfEOTNPi2YLkTTY4bIoqIyfOZENXGAj1z72rIrQTEYymP9EtDUS0CaMSu?=
 =?us-ascii?Q?bgncQD/IKuDV5+0DJsxCgYLs4YRhSOgKcB8b7Fv8tsw1ganIvbAEn77MT12j?=
 =?us-ascii?Q?tpshJyav1pNfF4SA55gAET6dUeXXzvFF0xVzzczH+esgrKY7QebnZGOqjvbw?=
 =?us-ascii?Q?e3bPElAtsF3Q+DvSh/6+XuDg6ziEW1mpPoH1kXkQXv2pxO/iprBNxrBbBqFo?=
 =?us-ascii?Q?t1poWa0Tdy1hpFVFHV0EbsQP83m/03bs2cIIgX5LeFW9NPfQ8E4RZUFbgSc0?=
 =?us-ascii?Q?B5Vamg1xbUhl+ODa1a+AGb1yODWjYhGXNvanPoNpwD/MDjOzdYmcNG9bUyRB?=
 =?us-ascii?Q?iaDPeLpuLaLsNj8WlsQ1cT8LjEl5QGTF5IJ6KriYbEHU5jrEG8DgtK2XLbe7?=
 =?us-ascii?Q?ATqD7yWrmvv0htBG8JzaN2hslpZB0zE1RBF18jBXQdcLfcKtDqkwPgEiYY4U?=
 =?us-ascii?Q?Vb21TrK67dh8Aip4dRv+gkjVM5xkCn+McQ08h9T3qdtNwSsSOhz6DOi1IxfF?=
 =?us-ascii?Q?J8qu1pjxx8PhHukHKCoD8orWeAmbrzrrNHw3iyDIGBvHNzBppbgg+UFsJrgE?=
 =?us-ascii?Q?0Y23HmM7PSUB2XXpsns83LeuvVEVEZkvV5UdR4TthsDcAi0+POI0+unKgMbv?=
 =?us-ascii?Q?p5TRtK6yjc/28hmyZWIc28LS2I97zeMdrk0MmGqnxEkWf+n1jAhEatZD6/2u?=
 =?us-ascii?Q?ZoEEN8opqX1hg6DruWuTTss/QqcPhoEkKtRWAe+9W8Vz8c/U6dlF15nhk/7i?=
 =?us-ascii?Q?hvsaTB+1D09cTtMYliUdNe8hvmdPHUo8QVXvq3vzPqT2xLA+Y8RMKGduPUjw?=
 =?us-ascii?Q?4AlhR9ASWAOdtvU8Xv2+/aQsfMGUKrGwmOVD+3jkjaWLkjF2P666WMRN0xws?=
 =?us-ascii?Q?fzM9iIA+DHRB27Bd1jBENzuiumJUz20oi7u+sjWOa5vP1QfXKoojadQPhgL0?=
 =?us-ascii?Q?/BRDoWt0QZemoTf5cdZVL0k7xnr2A9JWcZNpU/sVouibSXM2nfB792BwOr/j?=
 =?us-ascii?Q?exSDSCVrAtU6hVvJGnDexYVXIhiyeBtlFAa0s7vKeXIoAiAjCfGlWoDpuMjZ?=
 =?us-ascii?Q?ej48sLpf+jXpvtjV1iLpx2GXOSU0NyA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942dce6c-067e-4349-b6ed-08da525a2f3f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:12.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3NrBvaM0Hs3RWwDnO8Cn+bdl6YVRNiSsz4YZykMyKCAXtPcI/ZIDrLDdK4dBLswLmFaYlyVvnVz8NAHEBXLeqb0DuP/H1mM7NLh6PevM14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-GUID: 4IZbkA0yqHA1OUFwCJBoutuj_Q5TbWH_
X-Proofpoint-ORIG-GUID: 4IZbkA0yqHA1OUFwCJBoutuj_Q5TbWH_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in the wrong RLIMITs
being checked, so while tools like libvirt try to control the number of
threads based on the nproc rlimit setting we can end up creating more
threads than the user wanted.

This patch has us use the vhost_task helpers which will inherit its
values/checks from the thread that owns the device similar to if we did
a clone in userspace. The vhost threads will now be counted in the nproc
rlimits. And we get features like cgroups and mm sharing automatically,
so we can remove those calls.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4e17ac40c08c..c6aa0a45357d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,11 +22,11 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/vhost_task.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/nospec.h>
 #include <linux/kcov.h>
@@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->task);
+		wake_up_process(dev->worker->vtsk->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -336,17 +336,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (vhost_task_should_stop(worker->vtsk)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -368,7 +365,7 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
+
 	return 0;
 }
 
@@ -509,31 +506,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -580,14 +552,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_task_stop(worker->vtsk);
 	kfree(worker);
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct task_struct *task;
+	struct vhost_task *vtsk;
 	int ret;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
@@ -595,27 +567,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
-	if (IS_ERR(task)) {
-		ret = PTR_ERR(task);
+	vtsk = vhost_task_create(vhost_worker, worker, NUMA_NO_NODE);
+	if (!vtsk) {
+		ret = -ENOMEM;
 		goto free_worker;
 	}
 
-	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 2f6beab93784..3af59c65025e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -16,6 +16,7 @@
 #include <linux/irqbypass.h>
 
 struct vhost_work;
+struct vhost_task;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 
 #define VHOST_WORK_QUEUED 1
@@ -26,9 +27,8 @@ struct vhost_work {
 };
 
 struct vhost_worker {
-	struct task_struct	*task;
+	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
 };
 
-- 
2.25.1

