Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D74FAB8B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbiDJCj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbiDJCjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEEC59
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239F0Mgf008887;
        Sun, 10 Apr 2022 02:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=KiXptsX+RHTKfW+8n5zoQKfuxotaFhzA9qhYojfTzlNQQswSPBPLYa3s5dtXhh/93epN
 9uR9iHWOB8ITJ9r4bojvYsVXqrUABpQbIp5qNpu/SKpM/R5FKTn6L7ZoAH8yaqBhmiPe
 KJx6vLfogMW2/ME52pyvBVIbv20NXeoxgABlBLC1DaPZZ9JtXt6gGkee8XMLqRBybVCZ
 WRkU8lyFlyqlvKbiSMu/J8X6BMyPwrfXo+8UTI0vXAbNZXgALABz9nQjbkb52XCqL6mF
 JGMLlBDQ4ZnZcBMfgy9V0QLNujCgIyFNkgMBDX2wjrSkM6F2cV9vwi2IsLVkms3m4ln/ PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x290pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2VFxF034320;
        Sun, 10 Apr 2022 02:37:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0gmt5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afLNwrWnWvuqTxPDYmT1wzo3DMXIENv08IWgBnHTehLHi/ClhO3M85lBb4LdEppvXLxKDdosIASyEaiTGxjfU3nT5AxxXnixk52oJ+u8O1ulhG1d/rRacIgYWwcD8A2TmK+Wkt/VwBv+s76ly1wIUybt9162sVR+Nkxvz91zYN3bX57zQFTjOohbUXIqN1f7AuO3Z+Pe3s6eL069YxieUPpEHYvtU0+cAI1rGaKtvP/LzAjeRUs+4xX7IqrJGcfdX2EECaDaijT6fumtXEG6sGlg4r6wJN32Keht9gBxs7awZ/5kzAyLWPPErfFzplu8H/S+2mUfu7vMBC+q6goBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=RDmRpCbvOzabTXSeNrUotxz9OCdy8biFvRss94Odu74NXlntPRyulyc6pr/UsyNgNuL6kMjhtje9smLVWYPknZDsJcd1L8Xe6QMwtLuVLatk+ajo53lls7kvevWQsZ0F+IoIG8CkA3d5oveilMuIhK0uxVLsnr2FzVrd05uGGFpSm/+JbkxFCQRH74CnVRPALGHlT+zQXCAJZl1eeLy57RzS8xZKB4vyZ6aOSz+jYaLsR2R7o3IoUwlAzh3QqeB2HnkQfkeLWiXkKIyybgTzt+f7THI5m/rSpV7B5QKWPpXw7LL5CQUz/b/Bzi4b8NZs9C+lLlvf0Yu5qXxZ/QDNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI/GmeI6Eq19dSmju4TNY88oGpTTMjcASSUsBMQd4dI=;
 b=D/3E3G5wIwT+m+DxWRbM7lInJN1Jtg1nC4NFxzVB8yR6n262C9zGF1w201fzDT6zBK0Lslye988zRUzBpTGyNLtlQOBYembVEWiCsD9JPCdyKJ9XQIUiiJEs1j4pAUPbDgBnsd3GG6jnPv/h3TOD3zwilYPfJuxOQ7bMw0sw1hU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:35 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:35 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/10] kernfs: Remove reference counting for kernfs_open_node.
Date:   Sun, 10 Apr 2022 12:37:10 +1000
Message-Id: <20220410023719.1752460-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3134378d-ece9-4381-ae61-08da1a9b120c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB123888F605935FC5990873BCB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxytJg89z68BIjCJuBzZy37aLO+PJdsqLUdWa9fIyqX7aF21oya5wA4OXPou6g8xK1hNumzNXCXcuKTOGQfef2LAgmc7Uil32gcEAZ27zGvbgTbzm0ob/d8v/0wp5gwOBdgl7Eo9FpbTFfo6/vAfPrFHb/wBhVYxjXIcvZR6egwSVhuxbcfH+1cyBEROat3vXzpwsBqwxFAvIH/t+wmHXzJEAd9SOZYRGIQlnhsA+wKZYf8OyqZ2qFmqW1n4WfXwSrJPA482kI5+ZkKt9CvjZwu+YzhzZOpXOGKBSlGRLBAOJ/UEGzWeqR6LKpctWZCwsgdY1wE4Pz2k40RxMgXSe6oJiTkPdRPEOIskcGThvheHaDgL5MqrIWHx1IV3rF9/xG93dSt/PpTVkf+sEsGAbc5RrbG770j3NtZdqaMKu4wfrYQagYC1JgJDfA0lpK+PJ74pCCuznPGIXR/YKk+ZDp+M8SOmhYXAYLWoh6ogJXlfOv52pvad4ILEFqUNNt9XrfEwI/8Z30v+FJr81g7dDjmEBj0/6cwRWmA71K//U9Mg4Qg9ncEz7Ai1TnqhbwiYFiQTx6h9R9QGtLJRXb9XJHyqNZZNnmgOQTCWhBZ94Yw47n5MRNGgOxK8iRrARPDqmWDzK2NgMJa4ZkWg46wZ4OQ0F0rcO/4hXGcL8IghAbhmRCAJQZeOQdJzcCY/GRAxVoJdYcPG1s6qh4D9r+gKlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6p+ma4joGRKpPblHEUFIv2rOwSv6z4jykr6DXeKb8ll+phsPVDHI/ku3mWfw?=
 =?us-ascii?Q?5GBgtmpER6f6MpPBLOAHCptgZGJM28EnuIB7vkTE4rXVxBhrU8uYcZea6ehz?=
 =?us-ascii?Q?uj5TChlO8tgWCjoUgZgYWC53gB0rJ9SUIXKa6zPCq0nEF6meju6lZ/GtQJ1f?=
 =?us-ascii?Q?kySwtC6VLgxPOhiWICospI3K5iRsLmzhWPD10PCRITkf909lNAM0iF5vDNmR?=
 =?us-ascii?Q?gpmZGpS5D198YBga55G+1558zW5H5nJPrwUSqVGPh5sPsIGp0RJA9jkrRGs5?=
 =?us-ascii?Q?BbbFc4614v/7wDBPtDOe15b2q5Y8JFdckVFiWt8ABknEqKxCvv7I9cod7SzR?=
 =?us-ascii?Q?953+6SHJkyFgj59GWsF6khBUEsV1gD3CAUZpyyCuB+t9+P/7+Xh0anVwOgRh?=
 =?us-ascii?Q?r7pGeeAPnc3xn2gpT+f2P3IxkGEkJTMfcU0POOr7Yo/63/Tylu3GjjJ/1NE1?=
 =?us-ascii?Q?4tJIaCf3QEjeMHdPJhOT4QAjaoYKcdCBOybA55q3n8YYONUDoE4kBy0En+Qn?=
 =?us-ascii?Q?38IwBzTvcdP3ozeGlK304/4Y5D6D/yJh1dEs+GALA8QC+K1eeLJPTFiawDSC?=
 =?us-ascii?Q?mFD2KknF5jv9VOw0CGQ65HKKi4IyxbDu+rVKJESPG++rm2Gk3cMUHAJOndco?=
 =?us-ascii?Q?nTRjs564cys4EasCewe8tF7P4Rt5kngWgXaje8RJm76aOPYtssuvNKv17Cpx?=
 =?us-ascii?Q?hP6Ju7ATyDJQzIQYDfBCkVX/SUAuDWrVnKxdgaEhr8y2tdsCdEcPD74yCAug?=
 =?us-ascii?Q?olDOSCekdZNfk4kT6Mpo2HMkXwEGjUhl/V4EkMxgrJpQWofkgtPCxzPVW+PJ?=
 =?us-ascii?Q?3vUsTMTi0QNB3hCzYNzzsvjdajOThsKJhtTySZ7CTM5JECx5nxjdioh8/w8J?=
 =?us-ascii?Q?eDLvR8kKrqcpoxNs27+rLJmf/ZwfsNT1qU07xkV3S9bHJX763Nu9LCpUKRom?=
 =?us-ascii?Q?G6M9xr1pB78cizwUWrLqL0vb45SMS4wEip4SOiBicj2AkcInK3AAvd/hzhU9?=
 =?us-ascii?Q?zswkk/EySfvNO/nvi8CvqUVoZXx2xnIj1x/wgz8MERLnqa1vFfqCAfyEoSM8?=
 =?us-ascii?Q?0looanmfyYlUxE8TuY2dxhUkxZd/LBk4sS7hSNKA37oCpNn6iY6s2q5SDPi7?=
 =?us-ascii?Q?fPRsYSHZhmG51xK1AwqjEkBI4pqP1JPBgnQKOTCIENepM6A478jU8w7hLfEM?=
 =?us-ascii?Q?87YEMfC1+pLfEP1lu/Ngsf0zsFO0VhCjpeYtahwERdm/HRBxyfdR+iZjVJBg?=
 =?us-ascii?Q?hZg6hxl6FfPFhux+94+IlV0n193CyZ1d7Xa5uJK0GIHbyuukPGnFwF2PxpYA?=
 =?us-ascii?Q?0WE4s96RSisR7fA4qpTArj0jJd2SgndteHSKsKdiX4vCw/Uoll1YDE9HngCp?=
 =?us-ascii?Q?RXBzXRPU3GpOSv5a/ED3O3++orOKYhbMHS5+Kdb/mQnpuXsTK7ojr6PQQO0x?=
 =?us-ascii?Q?oboBjfz8jf4xE+65Omypx+0NDcnZVzF4ZQ9a7fgEOuk6WZa14DBB8YwufJGU?=
 =?us-ascii?Q?+wJ1J1sZr3J6gVV55VC5EZY+iHLqCgNL69T0OaS8HTog/kP7eCgwdlPpNYp+?=
 =?us-ascii?Q?LK2o2NEYMEku7yvurCsOrBuE2vFBNizyV2lLclZKvauYH8lTYIoHYl6/bLpX?=
 =?us-ascii?Q?h67uN2+++isWr25WF8Lx5Uz3LqtV+Cyw2xbNO2a3UiFr0pcDYy5qWHrRVGhy?=
 =?us-ascii?Q?v3UFz8Ps+QmpuL7GpfwVCot+JgLQ6KtOc8uH5IgQRFxbtLBkBHyg6s1fdMpp?=
 =?us-ascii?Q?A/wWkBQ/SAcikybGAXI4Gu1BHwCrvcA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3134378d-ece9-4381-ae61-08da1a9b120c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:35.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQLyBmoQC6D1TuRf9wmx9sKy6XHyVIKoCMii17uHKEh0Kd10n7rXd8gn8kG9smvUScdrZzrTDdtuDeY7jSx05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: 0ifhU8ik35TUft6en-SInwe0B3AFYT6_
X-Proofpoint-GUID: 0ifhU8ik35TUft6en-SInwe0B3AFYT6_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/kernfs/file.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 88423069407c..aea6968c979e 100644
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
@@ -557,11 +553,12 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 
 /**
  *	kernfs_put_open_node - put kernfs_open_node
- *	@kn: target kernfs_nodet
+ *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
  *
  *	Put @kn->attr.open and unlink @of from the files list.  If
- *	reference count reaches zero, disassociate and free it.
+ *	list of associated open files becomes empty, disassociate and
+ *	free kernfs_open_node.
  *
  *	LOCKING:
  *	None.
@@ -578,7 +575,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	if (of)
 		list_del(&of->list);
 
-	if (atomic_dec_and_test(&on->refcnt))
+	if (list_empty(&on->files))
 		kn->attr.open = NULL;
 	else
 		on = NULL;
@@ -768,15 +765,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
 	on = kn->attr.open;
-	if (on)
-		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
 	if (!on)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
+	if (!kn->attr.open) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -789,8 +786,6 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	}
 
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kernfs_put_open_node(kn, NULL);
 }
 
 /*
-- 
2.30.2

