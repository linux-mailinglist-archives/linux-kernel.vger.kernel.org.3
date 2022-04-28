Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF1512B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiD1F6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiD1F6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B67C270
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:54:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RMFeqt032115;
        Thu, 28 Apr 2022 05:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=/CmSLrqClYIE087SRXM6wfjlNuYfW1h0xiUukTQAZ0E=;
 b=OxBRaCeIo5HECWE4zj1rH45ytE/mhLJ2m6tnLnta0iosYLwk6bWu1u2FYUSHXmYiwR7t
 Cd+PXZG2mySajY/Rap+mliwdwSvBhXjTgECO64XS2isGM3wHxmpy7eWYq4h7cEmM5OBk
 80qpzUjeCp+MaxdvecS83lvEzXXGZvtEkbsUSQB4g3iYoq2wHGvWM9iHljkkM67EJw5i
 4N8Ug+/aur4GSYTH0YwkPqjYkDKuOcuVabAI1KdtSaXeyJ68DBykf+Eb1ifKiBTP15la
 Bqn2v/9D6kZG/ZAKyK1URxBF0G5Cfx1J6AxTkd+yP837k0b2gTJmawGuBQt2FzYG4z6B /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102gqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5jAWA030614;
        Thu, 28 Apr 2022 05:54:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w60tuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzoabQ7SYKczVc66kY7O5FMRnUGnXA4bmZn92poVkMy12pehYc0rJxmDjbnfGDDHYoUF//nkxVf+w5rMKUT/5jqeTArVSL7ZZmqcyunRHEngJZwaa6lRloMEyddqrp/Df8hkcjg5jm8F2mVsg70k7TmJK14fkHI5dd7MB8UHJRZUwWOsdBSxwcgsC1J06I7spfKGKe183aLlHTL1okP7yos5Hue7q4UIZaeavJCVWljpjr28noNlgobEhXrBYsLkBUaMjKvZTrAgFIcriyUnE5FMGqACGVjZ01Z/u8I1oCNV79vpKib81gzRlHaYRrKKntIm1MDcGFnvcrpEO5HiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CmSLrqClYIE087SRXM6wfjlNuYfW1h0xiUukTQAZ0E=;
 b=FGepABEAxoKgIQEDKDstWFZ/SBR4PqBvR+TQ5bffm7ohOya25Ygg83cStKHS5BqdS+saIqQEta+Y0lqFEMr2WUrye1QdjDSpj8z/GUawh3kgziWo2BU7GD0U4bgXYS6ypsncCG1Bpmbg3lOwUpf2XMKOXK7Ts3lAVRx/tZAR1duPB9O9pzln0p4uVxB68sRNO3rg9c7n/20nO5i7JrUoAEI2UibJMcWZgzaGnPxRRYEdkQNJThWhxPSZsuQFBraopY04fiYLXOsfVb8/ZPRWwba6Kw9Amo8mEQTGEyB1AvDLsn4DsSxOFi3DL1iMMQ7oz2rr/rsa/tOI/YC4SDSxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CmSLrqClYIE087SRXM6wfjlNuYfW1h0xiUukTQAZ0E=;
 b=eeZQn8753vnrzc56hpGwH8+Py5lo8aNYhfOvdF0lU9VpUqyQ088sc2d8UDnG44L5RHujOHEqlbpDpDMUHpSW1fJ6pkhO/sF4IdFFAHZtjIs8EJWBVtkEIMgNmT/UjDd1SwWQ34OOaSfICYlwjDKW1bb2061zcVaJkOcWkwOYvDs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:45 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kernfs: Remove reference counting for kernfs_open_node.
Date:   Thu, 28 Apr 2022 15:54:27 +1000
Message-Id: <20220428055431.3826852-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428055431.3826852-1-imran.f.khan@oracle.com>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0a06f9-c705-4434-5e37-08da28db98f6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1789A8821026E8D0FD42D217B0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG2qrDViny44wBdv+NjPVk4sXhOxOcXTygOfrCHfaEPTAnnlsHagixKGvqzNpjqALCiNoMVMI7xFfc0xiC/qpxFUc+KPZE5A/t131Scro7PH0cMLNFXzfTsCiDowMvKbWeo7iCkaO4eBbRg9AcQatDOTgZdOH37jwF2vBal/GQ05Thw2ci8BHfGiMSxUqpyR/Zs+DWV4N9ndtAMpOqgEbB/+rzaqqC6PexWXGXaAfUMBkpTJXcTmzNhk3Hp7nmq2KvokSkHJHKIw5Kr4JoYfw7NDH5kiEkqVjK58lHWLrs8szY5QuiQgQQJWn2lOopPtoYcnaik/Ctp/ptAzMS9FS+E6NmVrAn/sDWzfnnJtdp13qb5L9QTCg5m1fQdzvFI/pfL50v9IHPaZLTGpa9VWMKhlVpSc+RVajLzsXen5tfGCP4A4EAUMf27Gvj/oUKL2T7JJMkuJlaHj89M3ldRED9fmV2GsEasD3x4xUFJ44hdktptcaorLrrmGDzDFQMDQtKYrzN4o/gVab6BcQQdIglJI//OdcSiM1wGWL3QPPh94RIWgpUCJDE3q8CB1yVPxq3iWO9Qn76TjaXiz1h/wwRCwb56BieHA5NSPf9tiG8pMNama1cx0bx66kYny7jbntfEU5cCBCC7v3AEZ2Q+cVbzcJaGFxxJ+mDhnX7n81G2eOV1anIK88UF2YovIzSaC6Cz1PO7khHcGBQFNhvf+Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUcq9j3/tGLNxD/W7po9VHdolRLiPC4NJINvR5eTLaO2Uk2gwevTXwNgokbX?=
 =?us-ascii?Q?+WGaHWl8swbQDs3VVAcbEFkcSAMXPhMp+4GUpRFtn6aDYeSPSZ1wHoKHc/Yj?=
 =?us-ascii?Q?rWoPQb2pDlwLBcdV+SdudFEJlQ/Wqla9/xTjXe11LtXF6ul1d8eGsGyRytVZ?=
 =?us-ascii?Q?PMWbCbuDF9CXLtRslBJ07cQ0I55Qda+dAm56ayYkpIqaFVJZ+JLhy2BmNxiA?=
 =?us-ascii?Q?HdLOTgJcp1ouZ1Qp3XDPEL4nNeJWQobmPwqvlaxkOUskBk0+RD1Cob6T+FIb?=
 =?us-ascii?Q?Ff7XOLTAI3fMQOUGkgAusvOQ8pnPvn9XR1tfGDWGIWNFCOc3Lv9Uvj1dOPXR?=
 =?us-ascii?Q?fdFjAzT4iLLoeUT27KzkjZ6bFJMt2PxpFBiRQ07Muv5nLXp8pjRoS8k2B4iB?=
 =?us-ascii?Q?SgHZoXljIzAAQDgXaRwFVctHU/ZIbsdD8x119YZ48BgXYAjcVLPlJttBeECH?=
 =?us-ascii?Q?zIu98EInytG+7igxcSeDxsoUPyWGtzFBmcXgQeIn0uKriv5BlXfhe+HlAwqa?=
 =?us-ascii?Q?vgJlzoVs/GlBQSrsd+CUCL2Icp9+fRmeQmUQuy1aoqkvQ3GXUXWFXrGimgoY?=
 =?us-ascii?Q?OmOS9TBg1DcAcQUP5RpGD5IKvO5FMk7/0ch3yaaUYM+Pdt/ygkZlT1t6wBN/?=
 =?us-ascii?Q?twMYZp5l48DXoeHee6HC3Atattj9YiayyjOQpgBCQgItBeJ7rBlbgj+pO4UJ?=
 =?us-ascii?Q?TO93wagee+4HDC9ShN2Kg2xwM7rvfJpWWmtebR7sILEsq1X24geExc4bQNOj?=
 =?us-ascii?Q?9jVxcV/34OKywtINTjI6TbtaHhT6wSUxCD33IihCpmJLv9sFmkVa5s8X8/x0?=
 =?us-ascii?Q?Y2NS/JKIi0jysCX3wZxVW/7lCZKfDBb9PqFC+/1Z1RiQPRU7jdqI8X5I7mT5?=
 =?us-ascii?Q?V57TNbQysvhO5WxhjnwyJ0mChJOrDXFvTPVqc3q+2YfvzYiBoFHf1bGUagGI?=
 =?us-ascii?Q?nQ9e7TA7J4+aL0INmnts/oeZcjfEsxcjpTzYGPLJrPHHnti8B2QGSSgDxWXe?=
 =?us-ascii?Q?zAT14V+3Da1a/Iwsh+WTv80fvV6OVE2oxTKqzoEjuYXFQ5hgg4vueVTP/N5K?=
 =?us-ascii?Q?UdPavwX7FlZ9RSC8O1ItcflmuvBv7SMN/3g2IwkawUTVcXNFG9GbbHmeNXZ+?=
 =?us-ascii?Q?HspNWzEG8n/rXeIQX5Bq8VRc4CPzAsw/ABYm0fyearwhQQ2XFn5RWV8TnlPw?=
 =?us-ascii?Q?9+unDrMRu35uTURzAOR0PO6qTIrWUHZCeUlScut2xkLFGJ9yab9po4uL3Mph?=
 =?us-ascii?Q?s/lLpgJFxFXVRIzl8vpSjJf4x26QCC1sPxmGHQcPY/WREJjBJQ+QITbDj5uA?=
 =?us-ascii?Q?2zsBDekr2p9QY7p71pYkwgG/5WDk0bfiZvCgjecRx8TRVF3fGhMKn2D18PIU?=
 =?us-ascii?Q?1bkexNjiSTDZg/gK1vU46dWBZpIJA+YzVV91OC0JVhtMErLn+0PZ2YwYiFFc?=
 =?us-ascii?Q?tN9OWyeFnEhIceUNiYwvuxEyDdx6BzzePG+R25xZYs2NwTK+feNNhFf9lltO?=
 =?us-ascii?Q?8chcswGGCGH2Th5Jr09kCRhuh+4FRunBKcwSduuFz4urVskGTwlMMeSbO8iM?=
 =?us-ascii?Q?pP35iA0Ns6wZySZ6sxIp+67pg2bOj1KXGTFgdjPrNl7lbpscGbJ3G9SkQUey?=
 =?us-ascii?Q?TxteoB7nZLD2bbWLqGOYk/2/a3335UKFMudj6EX/FfR8Jz2Gf/al0WR4Njiz?=
 =?us-ascii?Q?EAjXUYWcoFHlI/7mGzRSUO8eQPGZcdvkIYNoSHb4LLXnAoRkd/CXPj+Pujzs?=
 =?us-ascii?Q?N9AoCUkSXBZnI2JLVJ2JGRlpyu30T74=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0a06f9-c705-4434-5e37-08da28db98f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:45.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVJWso5/4X2/NxY6VnUe7ueZ6DCC4dQYYmOQts/VVg5OeNWY+CSByVL5Ty2lD2FbLWEvQWcxUcWOAVlFjN5GYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280035
X-Proofpoint-ORIG-GUID: DQ1RZSFSzCPejkhH8vEYZmWnJvh75F9Y
X-Proofpoint-GUID: DQ1RZSFSzCPejkhH8vEYZmWnJvh75F9Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decision to free kernfs_open_node object in kernfs_put_open_node can
be taken based on whether kernfs_open_node->files list is empty or not. As
far as kernfs_drain_open_files is concerned it can't overlap with
kernfs_fops_open and hence can check for ->attr.open optimistically
(if ->attr.open is NULL) or under kernfs_open_file_mutex (if it needs to
traverse the ->files list.) Thus kernfs_drain_open_files can work w/o ref
counting involved kernfs_open_node as well.
So remove ->refcnt and modify the above mentioned users accordingly.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 88423069407c..e3abfa843879 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -33,7 +33,6 @@ static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
-	atomic_t		refcnt;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -530,10 +529,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	on = kn->attr.open;
-	if (on) {
-		atomic_inc(&on->refcnt);
+	if (on)
 		list_add_tail(&of->list, &on->files);
-	}
 
 	spin_unlock_irq(&kernfs_open_node_lock);
 	mutex_unlock(&kernfs_open_file_mutex);
@@ -548,7 +545,6 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	if (!new_on)
 		return -ENOMEM;
 
-	atomic_set(&new_on->refcnt, 0);
 	atomic_set(&new_on->event, 1);
 	init_waitqueue_head(&new_on->poll);
 	INIT_LIST_HEAD(&new_on->files);
@@ -556,17 +552,19 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 }
 
 /**
- *	kernfs_put_open_node - put kernfs_open_node
- *	@kn: target kernfs_nodet
+ *	kernfs_unlink_open_file - Unlink @of from @kn.
+ *
+ *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
  *
- *	Put @kn->attr.open and unlink @of from the files list.  If
- *	reference count reaches zero, disassociate and free it.
+ *	Unlink @of from list of @kn's associated open files. If list of
+ *	associated open files becomes empty, disassociate and free
+ *	kernfs_open_node.
  *
  *	LOCKING:
  *	None.
  */
-static void kernfs_put_open_node(struct kernfs_node *kn,
+static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
@@ -578,7 +576,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	if (of)
 		list_del(&of->list);
 
-	if (atomic_dec_and_test(&on->refcnt))
+	if (list_empty(&on->files))
 		kn->attr.open = NULL;
 	else
 		on = NULL;
@@ -706,7 +704,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	return 0;
 
 err_put_node:
-	kernfs_put_open_node(kn, of);
+	kernfs_unlink_open_file(kn, of);
 err_seq_release:
 	seq_release(inode, file);
 err_free:
@@ -752,7 +750,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 		mutex_unlock(&kernfs_open_file_mutex);
 	}
 
-	kernfs_put_open_node(kn, of);
+	kernfs_unlink_open_file(kn, of);
 	seq_release(inode, filp);
 	kfree(of->prealloc_buf);
 	kfree(of);
@@ -768,15 +766,24 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
-	on = kn->attr.open;
-	if (on)
-		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
-	if (!on)
+	/*
+	 * lockless opportunistic check is safe below because no one is adding to
+	 * ->attr.open at this point of time. This check allows early bail out
+	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
+	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
+	 * check under kernfs_open_file_mutex will ensure bailing out if
+	 * ->attr.open became NULL while waiting for the mutex.
+	 */
+	if (!kn->attr.open)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
+	if (!kn->attr.open) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
+
+	on = kn->attr.open;
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -789,8 +796,6 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	}
 
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kernfs_put_open_node(kn, NULL);
 }
 
 /*
-- 
2.30.2

