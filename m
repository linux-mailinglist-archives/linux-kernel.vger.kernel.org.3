Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D3525741
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358872AbiELVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349163AbiELVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC71C136
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLVQPh003190;
        Thu, 12 May 2022 21:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PhxBc1rJQiw9gN/G1oiVMh2AyYPgCWgGSR6RgsYJ+2U=;
 b=yRkdZjx5urL+WrT0arNywb289kVxqJdzO52GSp0UJVQTVkdeMp/Wgv9eXdG0c4LCY/rm
 ICdslv2oYOhkguYX250vQfj2mXkkwdb1W3GNQ22a7vAbE7wo6tSL5FNAT2ACG4n9e7eS
 vR1561WD3n+hZoSXSHNiJVjU6qsTLsGMHA4qm06c/0IfUZTK63mSZpgXUOsGWDJKJlZN
 I5jrQKyuyEgSV90VQY+Fd+e2wziKtle8mM/cUv/MgYF9zRk1UBeXOyiYqL6hlat72EIH
 vZ3wwSck7dqUKvq+vpa1g2Mbv/sE3UZYOyjEzH0mDUJD+5j7VCF8LnR8ZLnbP29coq+L vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04n2hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgHmV004478;
        Thu, 12 May 2022 21:47:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0Ys2Xb9cDEDFb3avEdWVNX3iUmeLByVoqYuxJB5Ph5JPyjTRmnWnfWZUYgPxAg+tlfheoYJftnuNHQwHnmI7v4hXOClARNcPsVHI1NAYV+rMbA40NmdPPfCso+J2DGOcbCJ9Sn96zBvMrIenJ8mpJ8LrfpVYsoX4/13iHkV8u39RI5h6B34ZUCZiAMHOjIb74W3kWtXp1e5am2uOtD1mAQ72XGbBN/dEIEroHn86QjfyiB7a2L5+upraCCJ5JZC16onTmy8lJ1M7NTp6Ce4OVKJniccqpQWDV63hVk2MyoreZVJ8jqZB1PQebwW4ftngYRuDqyypZaNrNiiipT/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhxBc1rJQiw9gN/G1oiVMh2AyYPgCWgGSR6RgsYJ+2U=;
 b=bu+sxKdGDCoqtKp2ckKJ8Z9w0nNkJKwkKYfBO/EiSu0XX7JT1b6GxULNWwwg4JCFO2Sz9saOg+MqsEXvKTOmghSPDYwenIbvNQFOkgIuKZ/dS/XeZTUOauZJoJyCHom3d96kTvxUxvuxcR/BCWxJwZSanaZ/h1RtklgDCMVGFsJdRter841ilTMN6hcqzKK9RWmFPhn9telKOsMaTor1u9cF9xdAfBQUGwXPa5hd1xs6AkLnaKKovixw4P5ttzCrMFHim+OyqLF07Fhf/NaVbq+JCgi3p5BcoXJvD5QqRxrKe93qvPfaT0FrmNjse1uwc3bn6f62FidqpWFqFl0wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhxBc1rJQiw9gN/G1oiVMh2AyYPgCWgGSR6RgsYJ+2U=;
 b=cveaa33Bjpj25FWg6So5WQNlojf3hMznKZpVdpRrRGXgsn9h1V1gfn/T/MnRRPZDBnxOuzSQ7MNJqemIjnRdod2St5OSO5394SSXi9W1c3ourYbfGn6y7gm6vyowtSj16Xn97lPMatUfsoVJmySSwYBc9UL4sIsn2xpPOw0ubkU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:16 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V9 8/8] vhost: use vhost_tasks for worker threads
Date:   Thu, 12 May 2022 16:47:04 -0500
Message-Id: <20220512214704.104472-9-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: b221d043-811b-4d26-4a47-08da3460fb05
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB33115A34E15F9A31309D5C29F1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZA3dMhKaaf7yb/VoHYsjma91i2gAm1Mjs7mUyM2rk2aMYJ/5eT7e1WWCzzEiYYJmj5gpzZVekHKNmQyml/KsQ+xKGYQ7ujPD4uREfmcd7bUzflv5xil/pEBUiAm1W1khDPborKx42/QIg3ra11AhSfye1AGzVPVkEKW9FX9UCdjbpxxOt4WZdno+AZ3NvF7T1x00pYu62z6ORa7qJE3jCgj9laFy+zUXDJ/DFYlr8p/NwGO5ggnH4kBYCsZ/3JWYOMk1ii31Ol/CF4c0MVyx+9zBF1m8vy0SZa+jtSEhVVnv9m3yKK+zIA9iCqsz5vNUwXBME31R7mq1TsChVevxyfCPk+ftRRC96pfnVrk4U4SCFx6Z+OlcTGOM8r7bzPyimlmtK2B2kuf3m6FKv0qPRm8ltbemD6KTOZXdDPaX7PSs+IvRZ8cMB3dAGc33lksnBZOHfxN25+vny/u6M3SaKfpOFSbUOT5dEGafXTEWi0SseeYLSQDg+QMFiwLHfdhiqVQyyNJQh0dxKcx1XOtWaG3Ulhp4iqzwaMxU/786CbesTXbUeJ9rHfjceZ2C1+XOSSk6NICwEvuN5LQzUdnTfLjawUo432W8BZdtfjlR9PunxFCrQzuCuZM2s9wAuTTuuScPD/dF/ubvNKMixCTI3Y3xFMmhUTsgrXgMudHiaNUhvZTB3MPi+Isw1z7LdMpVSxBJGjiUWplXeT8mtqMcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(38100700002)(83380400001)(8936002)(2616005)(107886003)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzgrNs4bTpGxMy5cTa82l8B8IQjl3bLWcYSaUtZg/E/DWxgpy8PzA8j46X2O?=
 =?us-ascii?Q?5yniLm0gcSpmpaFIQT1ntEfQU63sg+7JH1G1X2wEGKUjHwoIvUZNeMQ44kog?=
 =?us-ascii?Q?vzqvOOlEihE6WMLkzHEorcspIG4XLOm3NN883yKlSIKofJMhKyoU2ttPE8p3?=
 =?us-ascii?Q?t8MG8MEUl8gfzMi1SOOPYyAbd87iIDv9gg7/jG56WY2oxkPlR4oC7fvnocbW?=
 =?us-ascii?Q?4l37Y5PM4d5CbVCaIdpsyJKjTmJiiT/0ArhqaETZT+uK0etcV+7syb1rI/Hr?=
 =?us-ascii?Q?M/TcNA1lOVM4oXe5bxs0E6Kysm1saOn24EhM3VaBfMatj6BzyW7d3yclZIEj?=
 =?us-ascii?Q?os7k7TZOuEBMXSvOdh3+lz1xIzIX6LwGW4hKfyzNAOIXY+FrHcVWqXgALItf?=
 =?us-ascii?Q?E7dwpYx9iLKLTzneTZk5AEYJ08WPUUFa+VAaRS3MXnF0dg9crrW3ndtd2GXC?=
 =?us-ascii?Q?J7JcOHImfAIUqvWtNJx5JjPPAOl/00VRbRizDau1aj4OOOz3p9O1kWTwUuCp?=
 =?us-ascii?Q?zu2ATWiiniWMdberBwCAsZV9C7ZEdg7ylJIr2IHq7ciX+oBcp/TsSY3hBUon?=
 =?us-ascii?Q?HEwVSvgenpkICjgiHFBabIgvImjBS+B9zQfTdr1giWbJyIYXe4xK5RuO86H9?=
 =?us-ascii?Q?an4+lTRY8JKt+q5kLUZ+yCL+1kga9XLhGAFKjY7sOsMLIGga54eD+crAu+s7?=
 =?us-ascii?Q?EwROTYWfudLFLY0jUcQjFWQeRRFp5689uHQBEXdiMXA953zvoIfzpbFb2Y9/?=
 =?us-ascii?Q?pu0niQ42Tuw2mHjbryS6Flg3pL0lk2fB8QZ/na8b9YVnr5/wdgK7TW1vulc6?=
 =?us-ascii?Q?fMj0G+djCAxg7BCsh4ld3mNM3+KIMzyA3bt+S0fzhC5EBB8vPRysVLC2QuQY?=
 =?us-ascii?Q?H9pmhSwp76BpQf6Esog1iN+QBSBqtzs16VVj0U7l8JeaNIMIDji6ee+KZz9b?=
 =?us-ascii?Q?CepmB3RHEkTAafSudACxZAQKtmlV2/S3fS8UuSKrNNyGTXu33ZU3GJriIdt4?=
 =?us-ascii?Q?fU+PXMkkQexhsmYCaX45oVvKLJfu88Pzeoc5ULYjdn7idS0b90e00onNVnue?=
 =?us-ascii?Q?0DCC6gN78NO2TN62WVr+jDhJLz3gLmq9VE6oCvGRSo94inbdZZ5pxYgJYk5m?=
 =?us-ascii?Q?TZBPZEHTPGWq+qxX1NMUHjK1zelxAlaQgNPOlbdx6QuoK0Ag0ux4BPEcZy3Z?=
 =?us-ascii?Q?gq277YclI8rqpCk1ZtN7O32w2S1A3yBphtsEIgebTbEzp9DWJX514sQ6O07e?=
 =?us-ascii?Q?7eyCL9t22mtbhRXSQSPhAR//DKmZEukUS8ARU/wduYcrqOdtyClpstzDAWUo?=
 =?us-ascii?Q?JgZWGPrq39m1V08GZ1OZBKi+8od9fhIfyj7AQuRA9F6LPmG5JieQHPxNjIpV?=
 =?us-ascii?Q?27+mlnq4qysv++5QCTqK0eZCzt6OLNvStR4v9ODecbhVDY9TnXwkuhvcDUAq?=
 =?us-ascii?Q?Qkfe+1vSTY6sl4Yk5qda3OPVZw+QYU/RZ4/mZ60MNY7mba0UBLc01c9dcVM2?=
 =?us-ascii?Q?mQgn4yexJ/vwy2NOzpAIiYVSskouv/ACDCgrmTTtr6IAXC9SILb8/IpxzX2A?=
 =?us-ascii?Q?v0OWgw0wYI4xsaydZexMBGM5dymWBfVqrNvPuMTRhqWPj2Pnv3fBiwDrUzJ9?=
 =?us-ascii?Q?b5R2W+pclaRpQEiFMqi9piZZQZP9KdTAooeefPqo7dxesoa7NHzGSDhdaVSp?=
 =?us-ascii?Q?trHhFutx1rW3+5YB3awXcmthxLDeYUaWzYvr5GjK1U5ZMID4yFxTI6UXR0fR?=
 =?us-ascii?Q?S6hNeHOtwRtcBNXZoLJYaOLmQMnnMks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b221d043-811b-4d26-4a47-08da3460fb05
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:16.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REPuQQe+LrszgtWVk0OugwXP2BFHaBlP0ztd89g1F0XPYSl5QqBcldk3s36ANY44RsEGKwC7U9xDLsQnhl2LVPZvT3DUEsv46FNPvTdBLkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: xpBpUX27dObnk1Rg162DUViyjC0jsJSN
X-Proofpoint-ORIG-GUID: xpBpUX27dObnk1Rg162DUViyjC0jsJSN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8fd8aff2201c..91180c0e2b77 100644
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
@@ -264,7 +264,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->task);
+		wake_up_process(dev->worker->vtsk->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -344,17 +344,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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
@@ -376,7 +373,7 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
+
 	return 0;
 }
 
@@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
-	vhost_work_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -588,14 +560,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
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
@@ -603,27 +575,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
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
index 102ce25e4e13..c9f391326dd5 100644
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

