Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA86563625
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiGAOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiGAOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:51:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FB2CDDC;
        Fri,  1 Jul 2022 07:51:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DeBIH010382;
        Fri, 1 Jul 2022 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hMumR/HrcMOZN4C9/gVCfsBY3UUDbSWCrkM9wc8pgP8=;
 b=Wh/YCnWoROsXm/lDYtoCGqOyOUGgCvamYNQOkAhE66/XfQyqZ+VHVo8ffzKXooSMJXZI
 3E9uwb1CYfIb7TfVdGPafv5BU2Hp82wfqO0FHJLQvJQQ/FB9RbYFvwu3VfvZuNuXHjsh
 BDRKrHdd3vuLAOYvDWQXL9KrXigi6oVYzeJnBjq8G+FQhPyT+tC16b2k63UB2/w/uX+y
 TV/HP44jjq2pSowzAj6Ef9n7Ne2oxQ2hf6c9GARk/aUccwD1bsuItOGj3rAVUILeSRau
 eGLf1C2q0FV1XkTw90q/h1jzZUl6CSbqW6q7xAyBDCyLo/W7A/7BsDqrjGuMjl61CMln cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt8a6ywu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 14:51:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261EfbIH029155;
        Fri, 1 Jul 2022 14:51:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4qxn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhIWDsQCxr0CbQd6Fe/qKgvtnKB6OiauXtqHZljYJy67xbQV/iMQoPJYwJ30XeFa7wDnLn2AFOb5WTfn4OgdXGHoWt283Dik1K0gvRJroPM5TrjyMo8ZvwrPTdlkOs8NKmvZPrsarVPKqfaEair+HBNq52SmYmToV/RMaOCyLxUqVYzRbGLOMuhuVF5gt3PLa65wFkWsUQWM7Oy4HPXl0zbgNwHsSIKf0BqiX9a7VT3bg2DIPXhmqAAcL1kR+jAQkkiZLur2navpap/HN8PRxfcw8Shm/mduD30NnSrGX+RY+yXRlmPMguW9cN097WN6FynXAoxzqnFeHKkNAd7JwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMumR/HrcMOZN4C9/gVCfsBY3UUDbSWCrkM9wc8pgP8=;
 b=gVeYfATFXY4lWJ8JIdGySzWi73DbzsqaN3oG49Ch9mT5gfWLxe2PWsyl65VtXchX1oyU8y/hsuQU465vxEghcXjd17cbz3xQaLMhJR7y7jGCgloG5BbBoKqdfdoMvw5WIg0NynQfYOWdMex8ofndu3dxKHwXHPUcZyKJWYMB3xnmK7e/f/6qScN24OmpBwkyMV7nU3nMdZy2K5OXElxhvnA518pfjIZ7fBTVIezhdDcglQwDcXamXfpKUQT/zhG/ad1oNzMbpFjkfkLbkCngfRv8qv7RIzdzFLQHBweRZ6/fasWAAArtobVRRrxFTcL7rwGS6dV59l6SE0EbdK16vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMumR/HrcMOZN4C9/gVCfsBY3UUDbSWCrkM9wc8pgP8=;
 b=EwCv1aSQ9QdyV+NtY9vLuQKwuvIVhnCBSREYspwRrmSinTmYs/E9bvqfCCc5/vARR66NH7V3R559szXOc0UzfpNDH9xhiT/+k8lElNvBP2q/nOrVpEfEGbEq69YTxkioQfiKYODRng0yYUwoU63plYBcIqJVcVPvS0m12B8Y5ls=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 14:51:01 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 14:51:01 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: [PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.
Date:   Sat,  2 Jul 2022 00:50:47 +1000
Message-Id: <20220701145047.2206900-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:e::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1bb9fe5-93e3-4c88-432c-08da5b711d8a
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnCm/fCaQqTlb7e/GxG8GIAK1cu9VSwj2p5iYSmtl60BJk44UApG2mRl2UOQfNcx5fPLWs6uAHWSqppBT0ihuQM1Wb6yGhP1qNYYhSq+UjZWO3QeejMz15o6ipZIMMXnk+Hvwys+yib2mlRf39yl2QV1TyeYSg7CC3j0Tfa3exZrdyTHikwoAZaW/drf7fOklwUwjPb6tgDNuvKifkql/YgWeqMAqSHaqRQ2LMSkRSAgG9XUzBRw8iDJcqCT5uSp/M9u/I0hP6E/m+7/NdDYlhnAPyclGQG+hk4RneW6JAHfMG9fRbHX74rcEDx2GJT8c7qxHGgozuKiVVjilM+hXMWx/R21qJmIkdRM71NF9E8UcNq5KOHMHERBOwV1MnfC2qz938u9zaUhWtnbACOdGS2JbcIsrE/qhdLrVcRWJivg+b4wpQdGRZM5aTu0XfYzo8dgduysq4aq8+A2DP3C+dQ/sNw2lVOlUeUHuOwF3COV9u+7/Hf7mXA0IA4WcQd3hlLfRq114Ut9l7+z1Qx0Ruj+3rEKlWX+mO/NuTw/AbPKHbO+pCvZnDcH7RJNbkVoLAN5gELbcfqRgPXhApeZIIFHXYtfekuLYQ1voz7xRkmB4XVBQAMryF1h/K9s5dQ+l51omgWbW3+Av5Ep17TllgMd+5sqw4Ef//pmKFyRGg6LKvkypmbkVS1mtVY3BOZ3Xdie38CiAytyg8JvWAHFJBTaATtrK96S5SwcMs0+LOd5+026mEsUj/YTdvmeiT3YR8F7rcOeF7cNnxzASqX2e3vZs4YLvhnaVu+xB5bPzweiNZZlTizoFg0pyNTxdNfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(366004)(376002)(478600001)(7416002)(38350700002)(6486002)(66556008)(52116002)(6506007)(1076003)(6512007)(86362001)(26005)(38100700002)(8936002)(2906002)(6666004)(2616005)(36756003)(5660300002)(4326008)(8676002)(316002)(41300700001)(66946007)(103116003)(66476007)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSwP2ltyvAnVUxlyPRpsiPOhYeO5qpStqdwqbpgW347lrSIvRyG4wnJa2jgY?=
 =?us-ascii?Q?KawhAR+kvoux7vsVqM6YRzPytN7vxx7AcAQrCd7g+xaFp1542oOt+lCQz9sg?=
 =?us-ascii?Q?a7XLq5c+h13uurFgGNrn4j3EeCaEl2yDEx/rtuc5d4xq8xvC/+kZMOF+cbE6?=
 =?us-ascii?Q?8K3BqJqygAQrhb4WTyou4PKJ3MVc3xiwLyA84jf1hZG9V+jUjMX85trzB/XI?=
 =?us-ascii?Q?p9NbJTl7PjHEtPCdlecHyJe+kz5RnORy+t5PVXCQooQM2XgdTPoJ/cxCEZcM?=
 =?us-ascii?Q?BP7O0MosOQbRu3pBbPrMjsAinZqJu7lEKdwKqDDoaLx58Cxy1hIx+WowKOSt?=
 =?us-ascii?Q?+OcAyKlrabyGWOFudDYW/CzYwBqyl1WkOWvO4NyUBMwr3hVOsSZ3QqJ7vxTC?=
 =?us-ascii?Q?2bVPZTmigLIISGT5T8UZOFBiCOxfE3vN8GVoa4hCn6u32uCJ4Wx6SfmAHDcq?=
 =?us-ascii?Q?K7tCB/A01a3f0jsnD0RSEr26pq0d50fGr6BTm5ipmWjy+/UPKZLp/6R121MP?=
 =?us-ascii?Q?Js+r61leYp8i869tZoVFt/rLUV6gE7qSAL61nIQmUFny+pyF5za78R2KK3w3?=
 =?us-ascii?Q?ZSsS21gXwZKSYLbnC3QkVe3qa6gzhGIA9hOIKXY4Z51sU3qkhHXogiWTZz/Q?=
 =?us-ascii?Q?Bvl2HJAGdqMRPGyiHp/x9vz/vsHKWGXtv0rn4xP2shdbVXrenX0u1LPB3zKo?=
 =?us-ascii?Q?lt6Q33dunvbrRHxmuhZ8Cw47xECS6UMbQq8TDaFpNikZ/IO63kPoIAvHVC3B?=
 =?us-ascii?Q?6JaKQ47T5sFEvldCfpstt00NNZoRWFLLudp24R7xAW23L0P4VztjVfOKf1P7?=
 =?us-ascii?Q?341FAQROJCSzKqJlEhzNBF7MRt36LC3sW7d9bbEl/3t+a5ndrGFrt5oqy/7w?=
 =?us-ascii?Q?nMuWkBKbH3houpBSZt+ZJox5zCbUN5dYGyODq2Ydg4HNzm4Of1qDj3dtZpvl?=
 =?us-ascii?Q?RyyebFpa9J9ez4fxr9DWH5iGPvMpk1r+56yj7mctCsVFhWNSGGm00g5wXKDx?=
 =?us-ascii?Q?2zlYy9IBJYp/A/HCK0DYw3+aN2ZmqFK1sT2s6O8Rp8fhxMLxCkDgByYFXpZ6?=
 =?us-ascii?Q?zgxwgyBa88gmQGmT3C+8IFIPnjxwr8CHGtrCM5Osio/NoPxEzLpHxTEAyule?=
 =?us-ascii?Q?m8nutmFhqn/0eCsbE/D2qaXGILP/Rsvp2LXQaF3stgJQC6aiKkOiUDHFy5hu?=
 =?us-ascii?Q?tAd/ICjz02a/KyWTWzWYbyK1koXf+PUIzQAttxV/TqCCyxtVtea67R8yOW/C?=
 =?us-ascii?Q?dtB+Nn73Iwkm5NBZd/dlzG7HXqijLFjK3AHNBRgSq3rH/TRlpBj8tu0uf04t?=
 =?us-ascii?Q?kZJVBPpXYsD6rNynNtZWeO6Nld9OS7l46lTqqVAmLT7poQ0c6M1E9PYrOP0v?=
 =?us-ascii?Q?Mgf52Bol6/XMij3zgSqWHE7tbpU43LDExE/eYNfgFj9YUEyjvmtdkE4k+9oF?=
 =?us-ascii?Q?d5Q3Ejnylz1OcUDEN2IOvv1gKm1lsAhNN3eb8kYYs4oqjsYDK2xjb1MKNnee?=
 =?us-ascii?Q?Xrds4VXLHwoHdrspegoM2mtRpdsjJ4mU0C5ekDbmerf+Fx6xLGBFk2BILPhk?=
 =?us-ascii?Q?xh8jzNRnsbwrCs11x6ZNTXB8Ny8ASM4jFJwcMdp6Jf72eVeII5DfUm5J/Ajw?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb9fe5-93e3-4c88-432c-08da5b711d8a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 14:51:01.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7JCMKJ4/7awQJAHzcFJgVFtZwvfyRcatzBTkME80nBfHXBj4aNbnudtp8YZ5pAHzak+dwx56jB0rssm5Xmbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4309
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_07:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010057
X-Proofpoint-ORIG-GUID: HNtnTnVS0ZnqaFdxJGFhspBE53BjSIZY
X-Proofpoint-GUID: HNtnTnVS0ZnqaFdxJGFhspBE53BjSIZY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kick fsnotify only if an event is not already scheduled for target
kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
llist.") changed kernfs_notify_list to a llist.
Prior to this list was a singly linked list, protected by
kernfs_notify_lock. Whenever a kernfs_node was added to the list
its ->attr.notify_next was set to head of the list and upon removal
->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
would only happen if kernfs_node was not already in the list i.e.
if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
kernfs_notify_list to llist.") removed this checking and this was wrong
as it resulted in multiple additions for same kernfs_node.

So far this bug only got reflected with some console related setting.
Nathan found this issue when console was specified both in DT and in
kernel command line and Marek found this issue when earlycon was enabled.

This patch avoids adding an already added kernfs_node into notify list.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bb933221b4bae..e8ec054e11c63 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	if (free == NULL)
 		return;
 
+	free->next = NULL;
 	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
 	kn = attribute_to_node(attr, struct kernfs_node, attr);
 	root = kernfs_root(kn);
@@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
 	rcu_read_unlock();
 
 	/* schedule work to kick fsnotify */
-	kernfs_get(kn);
-	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
-	schedule_work(&kernfs_notify_work);
+	if (kn->attr.notify_next.next != NULL) {
+		kernfs_get(kn);
+		llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+		schedule_work(&kernfs_notify_work);
+	}
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);
 

base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
-- 
2.30.2

