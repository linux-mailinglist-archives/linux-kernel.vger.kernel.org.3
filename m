Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6408F52574C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiELVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiELVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971E46B15
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKxvoM003160;
        Thu, 12 May 2022 21:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QLs36Q1Qcx4n4mRFw5Fd2cWy19xda10jP4sdu0LvfXk=;
 b=OFAcpuTX4kJ2NCzEOlK/vOGghs8rxHCDZPjGV55kwc30czV0Y5jMWGo332v+XK0Prin9
 sygerLvbo3myx7y60DkmUsvOXIkbMv1U7tG8fqOH0qoeVtiWJzhlpLM4sob5ZI6zLEVy
 a9/2W5grQBNPNhHyUzeFP2kQ2EsIKhqQ8OnM6QheBZHf6xzX5v4D8G6dtSRNDIJUtIY+
 9EEpMAusOunROgTZXZCOEApT76u/7SxU1MNZaegA9X68hlmA3Md9w6yglHDKomPmGvUW
 VeyDhNjlyciNHzHAAPSFDGFWD1uAHcq0n0VadXAQDj3rEyF36sJzDdpPEk86i1C+KCLz rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04n2ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLfXCD004665;
        Thu, 12 May 2022 21:47:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf75ab20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr1nrSXdqVP+TgMgwyTeE7YsnNildKY5jYvuSTzJTJhissJH8G2P5+2CNKRXMkLbQ+AwAhFqfCPTR1YY4XbZN6f4vqrdmqsSU7r9MhyCfeTiGQhaEcVeC1hmGTxoqUjNrt9YSi1e7hPhxYh9sS6aggh3ujd/BT+OMIpowsUuRFvtxyVpxSbfHosWVvPc+j4gf8lpFHlCswL6KOdi1FjkV3kpRzZXKK5aAVe2eOsiElq5ghbe2r0Tcqjq3ayFWMN+B9r1bbevfI3tjVjOoPQdBZww72qaHw8pz5vbB68wYeXngqFTkGqVPEOK9wUUyIpvWgUjwnyleJIpye9BvDzAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLs36Q1Qcx4n4mRFw5Fd2cWy19xda10jP4sdu0LvfXk=;
 b=QVfsJciQncGUKEgVsk15g4I2x+RFSpTteu/bM7bRkbEQGfZNqLBNcddWKSFatQnfO2m+nQJf5iBFHfPs+QQmpi0THWe7/O1lN8AKRNKJ0AyaBsFa8qXiPlDNNmX0cN2dj2XX98VKaIZQcLBqIDzJR5NMxW9xlK2FWkiAOcMJUAdZb2xgr6i/iKk8GTi7TbVhOcHicahl1G0CS7onKBvfJVu0mjJmTztxOQLoK9RgOgdxG0qYhVxEnkHO4vxdQjCcnC9qNvPzoC57/j73PkIKaQkcheLw1XeAGibngADBa7vBsCHBigK6Lov9OdvZ7YdcL6goxNHGMfKQFkxp94I5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLs36Q1Qcx4n4mRFw5Fd2cWy19xda10jP4sdu0LvfXk=;
 b=T2emFE+zeqFwsKf3WlgSw7qwTb/d5Q++em44wFzKyn+Ca8lGrILlPfH/3TBvjMS4YThoQhDbG0VZjfYI1zDfdMk3V1N7oZ5y4yMx74wEh3F89jH7JQ4V8s5kuSgwtORytV/U61NcLAgHKvsQd89Yhtpcayk6sjpghxjvKIlHsvs=
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
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 7/8] vhost: move worker thread fields to new struct
Date:   Thu, 12 May 2022 16:47:03 -0500
Message-Id: <20220512214704.104472-8-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6d33631-9315-4555-75a1-08da3460faaf
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3311333B99E9D5485D5E902DF1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L46ssvgXgSRRdcQKAqDHyuXwKAQQOXg5uHpOsw/FhY52BiO8IQK6cECsU68yOHYhhQ2mA39+UXgE6JKQWxa6RHioIGAhfPds6R97XYJ4Wsf32Tvhfd39Dby2td1WBbQXUYo3rMOS5PpVHl7ro+/i9KSWi1EiPK0K0lITWzFkzUO07dY5heCBrCGwjpBISZK7p4JwQW3oTgnUe6Iu7zIzv1JPoZ0cqNNRXhQvd5QB/yg6JGJaZJtViv+zJclMKFAQkmKsqtKA1PF9e7RAjIrxAwxU4sKrB3Iux04d1FIuqT8FizYcva3OsfM0IzE0QFzbl/i6e3qAM2PyH2tCxM8KGJCtU64C5IUoiQMWlkcjyBEPOUucnVNiaDfiPrvbgyjrugsQjnFliXddKp7KOQU+2vx7XmBj1KBTHqn5nlZjXuEnO321pGCagNIAnVxv6IAaIRzOIUiGlv2T5BKqKqYOUwv5NAP9s76bwULplljZZrUdQ2HsJX+bk13cCOwA34HOS/hgvw1cPVW65mQyDUfOdso7YOG558mnJOA+doeY/naPqifES8RLMZiPnaf6CJ++Y/zSz0PXnkf+q7bzvlL7/nCp0W5eZEXZDQavIEAfi4Bn/xU/dOvJEi/HVl9bRkWKhGRM74Ctoblm9KbN4ts1jf73/FSb7/4Lc2LDr4eQUROnzbXVtWqZygQdoZuaWLmDCLEb4/gdtKeDRKlumRwD4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(7416002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(54906003)(38100700002)(83380400001)(8936002)(2616005)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHIyi34Jldp3YFFnZTbyb4jlP7NHarh+gSsMePzBD5Xch5uAWqsHvYk/UI4w?=
 =?us-ascii?Q?tOq2fzkH/ihR8IjqghG/Eonfiw7fH9xR3tEXSdn2/mHUGwRP6SGadWLRTXul?=
 =?us-ascii?Q?ORGQwIlngJhtfwm6TTm8Rp2Ray4tB8ZZBWuoj4NYQYkAv+z0aI2MyUBER8VI?=
 =?us-ascii?Q?47JO9LNKyWs1kI+9nxvSdVSkYe7Wcv3rWAVD8VoXmk12OMVzRrBqYrAg41d1?=
 =?us-ascii?Q?PWSUpaBeJcviuAimh2YiOJ8keYaomieG1UsZ+UYxTLXbJzXH0HXl7xe+tiGl?=
 =?us-ascii?Q?qwg61QM+0Lz4Rp9cQ2zSVRlRkz3Khu4POgCY270HECj+zxn9y3WaSW46+9kg?=
 =?us-ascii?Q?WEERrMB3Biqc+uSZ5zzoBRfkH9vjiKYuDmEMRXpbGok2jlAkYuiVervkuSLo?=
 =?us-ascii?Q?PV9B4MqfXHzG8peCn0WZbrmGxO3rVRhx0wv8dyELFUbn18w0Y8jRNu4YgT4P?=
 =?us-ascii?Q?8xpKglT6qqzPzt4IbFHq6erQdI2BId1hc9U8b3P6FqXNvpGt509KlISt/6nz?=
 =?us-ascii?Q?MZgPbli4TEHcjkxlbN1rD8f+5+qbysFcbqXAZjexIzjDWkA8TFbNAjL/j4Uh?=
 =?us-ascii?Q?ciX2Rcqw3P0iGJZaSzTgVYd/OHpQt7uX1mqzThkom6XdwRcdMr2fXbE2HlaQ?=
 =?us-ascii?Q?3+hjG0GdPhr4bqNQJFF02ud9OZW2GoK5EYbC4uPaC3C01Gat2ak0ju1Q4tJu?=
 =?us-ascii?Q?mCDFxiW1V6+qiiXNLUCqtj53J1BXXm+dicfQsgUf5Ca+ysPAWSrAprdaeZpJ?=
 =?us-ascii?Q?vBVIFZM0qYEU2Sa9Dbp0jP0E11Xxpbe1FlD7fHJU9kRArBWw13YOgtgpFDlC?=
 =?us-ascii?Q?BR7sw+wy1RHyHqugWHPgYcH7IkMdtzr0pQOE2qJmxNQCj/f/03sAOvoZnJ7C?=
 =?us-ascii?Q?nXgVjAfZ3VQIwpQqO7+sqfRBGwJqb5Kv/fQrjTFmFSlbjVDAb9a9m7cGRJCe?=
 =?us-ascii?Q?vNs5/HwX+hUr7JNGNlXTKJhudD72r/4vWp/G+koqDg1cODhQt7+uKBr9xHL+?=
 =?us-ascii?Q?ZfWZJWk4DA9o/NedOHbe8xzZoqR58TF4MdBdGrsRARLqWc5eT4w3o4njkq53?=
 =?us-ascii?Q?I94prgVOlqscUf8zPhi1OzxOmfF6HIRRh63mYhbEp0LnicItIRoH/x6EWZ5I?=
 =?us-ascii?Q?zHyTWCL1JdkM6zkIUw0Sl8gWJQ7SqVcqUPUMu5ZG7I9HoQ3xUbVqmHRY4pAc?=
 =?us-ascii?Q?gNiAmxU0KI9gICCmudJCB8Pa+xnQZAy4EEO4dY5/aK+T55MOLuDSC/C7RbSq?=
 =?us-ascii?Q?85XQ2ZO+AX0E8WQWBYS1tiWwBRKHHZCHHvzOVQs+QW4XWq2zMLMdy/zBV0Oz?=
 =?us-ascii?Q?V5ms+vhBEzGKq5eYXrZQvPhkg0lispVyv6vUd28judkBNLjkMpQQ9ZgKplr8?=
 =?us-ascii?Q?BBGIhYPsrQ96yrReFx9/pN4VutrtMcLaoNw1oRYN13toInBw4CugdKyo6HYH?=
 =?us-ascii?Q?7bhx0cJNi+nB9BtTEEXlFpFUyWY44WsZtVRCuVEBRuFr9bmzfBgZNn1Fl6Do?=
 =?us-ascii?Q?HVGorWQlhEkRUchnHbvGleG/dYNy2joqL8KnHilL6ph5wEL2MGxgzxkTgj0Y?=
 =?us-ascii?Q?pV0sSRFdVInl/Gf9ZHwDcyr2MoU0p1nOK6fsev08fNJwiqkalzQuksz9PGT5?=
 =?us-ascii?Q?zxDkVyoLlGxr+Tc2iJoamaopzUAHWRsFEpmj0l3Y5kR0Qu0xs9Zwxx8v84eb?=
 =?us-ascii?Q?92UcVrIvq8Srt7c2pGFuZxLKO9ObRrZRGlsnUccuyaYXLvjOQAOrckKMBmPL?=
 =?us-ascii?Q?3MDal1+saRUoCqNvRu4UB1YGx3dOVCo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d33631-9315-4555-75a1-08da3460faaf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:15.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BpF+sP6d+jRHGzukQ5KQF6w7beKhmn5J25i9k9EFiy14zESX8zQjkYXnb/mDjKyv6kwMvazMRHGwZp2ynp3VqupNfRttWDmGtSyjWNpUAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: eTqxO3wu-gGRDD-ATF2w3EyCT4WlHly7
X-Proofpoint-ORIG-GUID: eTqxO3wu-gGRDD-ATF2w3EyCT4WlHly7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index d02173fb290c..8fd8aff2201c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
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
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
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
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
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
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
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
index 638bb640d6b4..102ce25e4e13 100644
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
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

