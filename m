Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB8550E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiFTBOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiFTBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466EAE62
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JEFUO3012858;
        Mon, 20 Jun 2022 01:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WFaY45VwYR6sWK6+fArlPWWBj6ZoOOjrrsZeqeJkdZ8=;
 b=hyPMkTRXkVz45y8eFHfKZ/hKIW5smhBkVrJovW6Eeyago6JdPMD0iaubHkyfm01Ozmpx
 PXcTWBsA1egGByPkgQAq8toUsA7e0RrhkGYSrZ4fPpSM2U6lnn87pTV7WNQxjh49DSuu
 Ehlxlab4ZABbFgUEsdZP68SYVqHJyeKQiAt+rcmLoN9UwuufepVftNNnoRVXjVTw5CcM
 0nNrRTh4IvPvcvBeJzRnTQe9bgfCuy+Ro3oqzuxNaY43J8Q2Os4mz0jnB7OvH8OuNrOB
 aujQuofIMChg0w39+1tEDNZE/RdIudfj0NhnVaOzuzR5X392Bx/PoMlqkdLdGw1Qv4F/ GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78tsxan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K19qKt038388;
        Mon, 20 Jun 2022 01:14:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbfn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5HbYJd9QiRnBXuSaJmJoQfy1OYI3BvcRd2Dl5PXdZUH+Quvjsan2LEN83cr3sExjjVEVtbxS6Cnue2XQ68E9miCWXTba8JQUnufg+Q53NdFR+cBQIMnqx/l09EKxBb48pvlLrEzml5NEnQ030p3NjDRrp3uzjlsr9cVX7DKl1qLoD1aBW1xIQCi9bGyD7sK/3i3sjAp7mwRuYqjSBMpVNRa1eqCDoU6gVyWpQcE2LmNZuFDAk12ddJyJsxhluI1wGQ6y9XyqClVQ8ta+v2IawvhHUHzeVPmEQn9CRj+dX9DU19czzS/QXcsSLV+zKmlz6JD1pvQi9t9JdjP+dA5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFaY45VwYR6sWK6+fArlPWWBj6ZoOOjrrsZeqeJkdZ8=;
 b=OvUx1X/yWleIdqoGJeaaASsPzvvEXDYZsF3LZCExDYzeT4H8oXORT3SqnIccdODVwOc8Y2dBQFg0Qw12jPFIU8Czmj0K8++Cw+F07d828ugWHOI+WQHH66mVzrcE7LjWMqC3/NsiItH8XYFDgR0PaWnTTFH6V2BIppZwDK22+DpB6UswA/EN2GPsqRdS4dbd/sFRhRcU2MxkJF/TMyPc0vsCSgUVFykUgpLQjRAC1SR2MMDbYgOYdZw0WBKoHYRGnXcTHMs8fCpxHTpTXpoxbA+xfQJz1+a+fpZK6HLXQ8UrRpXhLk5kMN5kPqU9gABBLspXEPpEN2KZf6eXwDkdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFaY45VwYR6sWK6+fArlPWWBj6ZoOOjrrsZeqeJkdZ8=;
 b=K8gsqPjkeGyz/Z6MvSj+VQzp8u4EccPHJWkfB0is6xGZUSQiOBj+GmW3JACAislxR0yfViCOY1mkpFfEYDtBSQt4VOIp4oP50XMwPOPDlEfLYHq2GU9j0CmyK1HEvI7wdLoP30byarYLEYbhU1aMLc9NLIQg9Ig92FqB12fGNAo=
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
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 7/8] vhost: move worker thread fields to new struct
Date:   Sun, 19 Jun 2022 20:13:56 -0500
Message-Id: <20220620011357.10646-8-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9a0d4cf-aae2-4c91-fa8f-08da525a2ebe
X-MS-TrafficTypeDiagnostic: BN6PR10MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB19057565F40367DFE92D425CF1B09@BN6PR10MB1905.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MK6u6QQwcPQ7EZzDLxIlndFl6A+61ZL4MazGCYtl6Qnqxdpg9g+F8KCIL8fLL6s89qBLzFvSR1C7Z9aOy1PCc4K8FwN4H/7nZFoJWwMGvuVl/zSKrtImpHsFF4IjNs6GL0iEC24reneG4n2RgbFJVYLu7mPrlpPU9nkvAvjTaRZIxrGkE2JAWSDlapDGHdlWLhqpI0gmcgLf0sgJhpQ5CF5BGHKjGDJoKw4BjWhWI+IKlccxdUBq5TCmAFsbZfPZ9e2uva/Zz4S5atD6YBOB7jR0rkZgqePXr0Xqjb3Hk+W0/qiynFA/jRTm5aQn3LKUUt6yX8Lyi/O2hMASpWIhN0ZgDHPgKZEU1O3yjiPGCEikRgeXZGyn+r3PmGOaHoM+TFZicUaK/DIk/Wf4ikJs4Ab+fgD8gDbxLNO9nGLabWBKv8I7vn72sRLlLVjvPg0v+v1ZhQdHaycgnoC1EyqYVFt3Fla+EIKSbu9gV0TPpgYhXWjHqfLK98n/tzy0zFzxHZZ6PrUMEt1Zg87IJcN9a+MEBfLzf/cNXNbsZm174aaT2LrRUpvw0O1vF0hCYn7szRV/NyNV/3ESpNEqrADykfl1SUqgAGg6mR7RlcBs0RustiPk2EiABqtsgfSHRZcPAgQTN/zoLFFfo0qxWMjRyKu1EqLKRtkqEv3v5/SvyRp3ot/vl8b+ENWK8ljCVLArIiI2q8PhS/Z9sQ/bnsQGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38100700002)(5660300002)(2616005)(7416002)(6512007)(2906002)(6506007)(6666004)(38350700002)(26005)(86362001)(52116002)(66946007)(83380400001)(66556008)(36756003)(66476007)(8676002)(4326008)(498600001)(1076003)(6486002)(8936002)(316002)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPMviPcxXUBYr2V+ltLrt5fk58j3ldrVDr21KWVTIN1c0Z8Ck/vmkY7HW9I+?=
 =?us-ascii?Q?LKLtBA6L9wWz/s+pU3qHZ/SAk1+OHOxszCvjps0b9adWSm1rvx2G22BII2oy?=
 =?us-ascii?Q?yZ5/UARYhIWXwJWAblz7gq56hE473lC2Qb1pi2wbVfJfaPyCuocYuCfIO6+A?=
 =?us-ascii?Q?4HVGCd0lp3zRf7o9S2smXlmyBb85RAtZt/11Avoyky5MOT8j893qncqqZwly?=
 =?us-ascii?Q?nf7jBQwDHsQ1RGJCs9j8CqGKg+/6KYeg7AnB8ie2z596644U3nPNtDzJfFtU?=
 =?us-ascii?Q?1s4K0AqzmjttRm+WGrdtXoXiWxE9HDMh795qPFYF47jdwf4znNfBfHiWGpCF?=
 =?us-ascii?Q?+jHkB7SbY7yE7Mv0D8VlDXVrCGGXlt9au18wljQUpTwO8CPiRH4J2rkzDAQa?=
 =?us-ascii?Q?NWuQUNDPG5GJX7+AkCIUPBmZhUxg0QpISPdGkX3N2tNesaFpcvQibjit1E4u?=
 =?us-ascii?Q?LP1RtD3kEeYxgYAW1hOSgQLefNvLq+ZWR5In1SuCB5XWN2wcQtM7sgJ8uvie?=
 =?us-ascii?Q?S7wRQCClXSv2v8JgP6JvvrqZM/s5lC6raQoKgmTb2NKXQXjkVaQqNNFxKPdf?=
 =?us-ascii?Q?/8Hqu5I2hnX9IlfQZpGPa+j+w12baIll3xPuibWTYSMyjL3smeiPSjdUrkvR?=
 =?us-ascii?Q?WkVSf1hY+NCKmGedLZCO9X+7f6U1OA/aaUOcQXOCqrdBVkRsM4OLi+hrfAf+?=
 =?us-ascii?Q?lfAMw5xelP4HF98ZHb/F092BWNPNLo77N+x2af0rRVvOp4Xy5+lzZW3JXx5z?=
 =?us-ascii?Q?pRhF4LGCm0+ZJcaEcP597c7K1KA4DW+qNw8/KgCo6bV2loGecVZfQaeLYKcy?=
 =?us-ascii?Q?1Fjyr9P3kc7QMgd5DdvM7PcetoRe0wXe5mnLcQwonvvZ03wahEhG5BS+OcFU?=
 =?us-ascii?Q?9cPI/wdhqgl/wCGUcgIbbIy8MCaQFvsyaRW0mMYy2lMNEjzhWmocxKt90EZl?=
 =?us-ascii?Q?1Xr9EOmRJL7rFKOyx3Ces1qJoWaBmVVylFeVRLSsq0++R/buMGlM31cO0Cck?=
 =?us-ascii?Q?3qx6/d0jkxHvFHdxtR4VdJ3jk3j5cXktn0rpO2PF18IWLGf9KLpFwn6s9Gif?=
 =?us-ascii?Q?Gul7mfuN6iOmPnZgeQEzizPxt99HElwsD0McI2w3PlHHbH96CcBPlyHC8XKY?=
 =?us-ascii?Q?Os7xpx6bjYx1bwjqdgVOPnbZnQv3IwyU8hj/eE8wbpWVQylHaZCz/ne/Xuf+?=
 =?us-ascii?Q?iT4CyNYD7/emuas3RuJiGCJTKeS8dEMuDcd0yYofc8kfZhENaiosdenf4PPt?=
 =?us-ascii?Q?q69EusujS9pPPN1uMnftUUgXWnBARxnzxKZ8Ojos8V2o5H0PefryYwNai4Ez?=
 =?us-ascii?Q?n75TJc8NH8qv7bhWIIrVbq3i3NoA7F5MKSrKn0CqyQSRHqM/rywIO8OFviEi?=
 =?us-ascii?Q?YMRp7JvMFai5PXTn3T8In1lyr+SR080udkSOmSMlPXFzRl/7ES7TmfetPgpg?=
 =?us-ascii?Q?yJicTOHITeb0YhNWNc09rUDBxKb91ZeEqUWIWXPg/LBI4O+4pWhIjvoRtuwI?=
 =?us-ascii?Q?2TqnJZ+3w3fKabxC1YGi/wPDAi71iXmdZIkLMUn9I+5THWGNt58n8GyjNmo9?=
 =?us-ascii?Q?2Lq2Vdmk5P2usTLtU8cZOJugOAR3/QyYbS6V9F/etKsf8ix7KlVrvQX3aotn?=
 =?us-ascii?Q?73oQxX7bW5Gffz5wYYuwSjH0Ga3n/IjZMEj4SCZlcbAtnMsfrXAAv+7tYi4O?=
 =?us-ascii?Q?nQol72t03gxLXUt+GpOE+q2Ml6vXI1twTmp35fplOJS+Iq67AFxwbTiWuYOx?=
 =?us-ascii?Q?xVc2x0ISpx2cOmvQt0f+evS87F7IT4s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a0d4cf-aae2-4c91-fa8f-08da525a2ebe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:11.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68jV+6ieihgm7eo5VgaveYJ06oR/PQNzXsdpA00CYeSlxsYwxnQBI7VJp91o5N3YXa4nKC775o/xbq29Y8k6MNip99SpZpALUWxx6PhI/po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-GUID: cmKmpt8Y186bwgMnlii1zYLOE6x2EyOs
X-Proofpoint-ORIG-GUID: cmKmpt8Y186bwgMnlii1zYLOE6x2EyOs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 40097826cff0..4e17ac40c08c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -335,7 +335,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -350,7 +351,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -360,7 +361,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -479,7 +480,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -571,10 +571,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -585,36 +635,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -704,12 +739,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index d9109107af08..2f6beab93784 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -147,8 +154,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -158,7 +164,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

