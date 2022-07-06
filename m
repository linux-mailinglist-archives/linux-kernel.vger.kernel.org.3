Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914B56933C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiGFUY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiGFUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC05175AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IWeMN009665;
        Wed, 6 Jul 2022 20:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Tba8ZDaXK+/Iic7ZWzu0i4uW3zG08BBO8BWQTMPgjPA=;
 b=T1qYSD+YVuvYg2YtGqgQtOypxCwEaguGnUzJi2K9tGRrH5VRm5P+fjH4/XvDQ3lYRPm4
 Fdwet8VlmBYS023MR3GNj8SwKPXIRqIhBRYPG0LHCUCJ21Au2ZtUu6tFLxH8GpsQmlpx
 l0JX8tmWqRHCHXS45I3jGkDo6vFSUewxWa/neTgPIy3zAuMlt+PKxFgkxOc0nJoCqxxI
 VfL2o53m5a+61pPBQ7bgRF+uywXnSq2hOKNjNyWXRj9eTvl1/EY53hZ/lMRdaJaV7tHT
 /FBOIyJ9H/4qqzrqRGXdULm7MMM03ZpbJtCPQwcDra6KsGX99wJ233ldpgrrKPYbvHGW vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyb9ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLTPl036189;
        Wed, 6 Jul 2022 20:24:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8c0wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbpqYd8YJvyJbpFfxOS6iI1WaChNn6BqOrFUOSJBitECD5VTSLKJraF+q+32LOkiFjTji355cgFp8J9SCJQYdd/eSV8/Ee+MgP3FGYIMv4/VWbrLOPwu4aSaCGP7v6TsL9SAp3cVo07oI+dDjpZSlXP5urqnuzXc9i+KELFxzHyOaMH4QGQtHWwOyd3OzADToRLscJopBR9oO6iyGhUJpUNq16Oh4yXQuu34gER4btZjBmBNAhsLUeKqdX77mOHT//uT6Yz2ByStgTn7ILID5W6AASyjR3RQLQeUZdd8mlOZM5m9OFUA9OrjCKRWWB90EVeYliYYB1y3giFuSap3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tba8ZDaXK+/Iic7ZWzu0i4uW3zG08BBO8BWQTMPgjPA=;
 b=CHU8sAs3zu4vJEkTyLbpAj6F/nB9+aay0YBVRnYUlO/nv15ENwj4TZNVizAmOW/5iNPrGqStRHIctUzJBgH6aaE4iLrqD9hZiyFx0XOS0eSwrQnQoxKMLTGdXeBg3o/Y7osNYbQsJ8US3MzwkGeksmCba+aWBbUtfBofmmtcezNkbwYAZFjeK8W6dV4+2+OSOXe59GP5hl2qDF1cDikcmfxQ3qQDGDahVRdNb4s+Bnlt3Auv2qwJshWVDVQk/38UfGWM4CXdmZwefP1gsY0H14ZbclDS7Qie86qRSwD+x9oOcYRPrVJxyn/3cXpJz4ZRfU90PLomYNV7ae+KcAQDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tba8ZDaXK+/Iic7ZWzu0i4uW3zG08BBO8BWQTMPgjPA=;
 b=O0R+gES8DBNTz1h+F69T5GMCcAVX6YADHFUYOM6jmli441SAuTVTAuzv7V2Ihji6p1QdS61neKg8XKu20KuuXi0JjTWlyDbxz8txTx6aEOWqhyVK6dXlraySI72kodcLgJIzOQGSdsBzSC/jdwTG5WJpUpFE+258GB+bFnxy2Ck=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:24:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:00 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v4 3/8] hugetlbfs: move routine remove_huge_page to hugetlb.c
Date:   Wed,  6 Jul 2022 13:23:42 -0700
Message-Id: <20220706202347.95150-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 684123f5-8930-4b8a-f424-08da5f8d7606
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGe0DpcqxMOIQzo3gWbnTCeMM1NbmLNu4MTA7PxUzJ0QVXurLogYkdoU23oDWjhcVPjqR13DpxmxO2l6laDBGUc2ua/J1Nr2cVkhCVEKPpvDpfp+8ECuPg/QizDE2pfY/VD6erzORn5s2GkJr3FHdb8gdse4jYa6jdiJCQvq4GdnCdIJlHMymnSkGZX8d8lb/aBppAaYO5bg8V8zBlUuXUY7zB0JYTQfsOXarR9IhF8f3kh6tubnmAXIxccz4L5tT2k8aPagb927FHuhHMl8PF6pCKuk3tLoAT9CCm8e82Nftu6cLThwDTeRGKxWcu9OM7HsvK+liwiX7n4jLTIFsWgn63Kk47IV0t1AO9INrnzTw527CwbCVc8P4JBsAwpZNVJt1Lx091J9rxHQbaJjwk615e4eZQ/48XaSyb3bmce3JCTGkK4VPelpKMwhq1VA6gDKh2ZWA0URXouaD7SxygxMPaahMT+kXjJWbXgL++DcXsUAJD+sfgnDmFTIsX2RJh59YB6PkTnZzKnlLYHNdE3D64C6OWRIOUcjzGrEak4+uJu2gEPgncl3voHTK1yz2ev1R/Qne5R7ONfhKmC+oyD1hd2R3bxTwoLsdWa+aQeGSFPT4bm99Jcs+KGuiElHxfCaXGfuaw9mzqkEfyl9WlQXiAkhqYY/5tWrae+lnZ3/KvJrZQA3lh4K55GhA4inVDrw7hCL+9HWjlkFSTAkADpiTchLYS7n1BtlEPKtj2hSJlpYgCbsveNfRED8k5yNC1EIC1u8KqJ9qOqwxY0/esqSqG197OSUP4qUbAH37q1Xa8nkg0xVJjOY8hAB3Vjn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+MfF0uZo5bDsHkxzKZcHhHJU/I7vSc5Oz/fKqJ3sIwolJHhxCuE6Y/JAJM0e?=
 =?us-ascii?Q?qOCZMUZJMrteGAk4Z0bEdy6L949Ht0CoPGZfi4wOfuHmHnrUXKvfSOr+0W+q?=
 =?us-ascii?Q?fHltlGWN0TrnKqm3DcRbig91CfvZTcSrqaEbtybfl2hz6bGxR3FnkTkv2INo?=
 =?us-ascii?Q?ZevRa3/bIxsg1fejfKUs9pfH0jFuRZey1za9UnSVBxXCxfY131GZ3k+Kxwcr?=
 =?us-ascii?Q?WxDc4X0qWF3hQW6dXMFoX1cVpT4wGwHHrv8DtGHeyi14TmaZtjXLjZWC0lxI?=
 =?us-ascii?Q?loYYs6GtxtMXcMZIxLDQK/qtWm3OITbhbtuHUdKl24gtlwgK2iQ9Zt9Kadwx?=
 =?us-ascii?Q?L5kN0qTJQdw8Ae5O6shitdWy9IPsdohLQEPIqonwwp1C0QNH2BuPfCxS9L+E?=
 =?us-ascii?Q?V0D6fjagfdEei6K0QbjWq3HC+/mAzRnUdc4vzjUgdUEwhacvHPXMKlfSyl6B?=
 =?us-ascii?Q?dGYDnrEyPhMowhYDmoEXfSbdOc96+sFu4yjJCiNNAH8julcVd5L8wCQnK0R3?=
 =?us-ascii?Q?Kza3u0KXfQk33BtIoXBJIcxVNitG3+xd4oHBXfB3jlVP5wLSeKRcSwA1gmMZ?=
 =?us-ascii?Q?CBKQgYmO2RhcV9Wv9SeK7aQItwBcoAFOxThCwN8ws9yeWBOVUPMrdgzb27LX?=
 =?us-ascii?Q?kHbLgzpZe193PeWKgT+ZyGfPoVlgKoK2iNnRM19wy17gYH2vAuzWPotI3YVw?=
 =?us-ascii?Q?sSdG4u/JTE/moiVXadn+uYGbb21MsrjUVeMhN/XgdjZMFv2chtRZD1auvN+2?=
 =?us-ascii?Q?CW5PAwxNOwoyMDU9zW9ki95mTbCxdZkdbIP3bXldbRBoCgxIRUIlNTXZqUd1?=
 =?us-ascii?Q?EJy83P2TYfR1jZ+KcVNmoOZzLjk3fKGiucOCfKCAoSLkkS3VrkJUGZ89Pxc0?=
 =?us-ascii?Q?eXC7js9zQFsq52rkLLyT1clGMcOjuz1lmDH5EvjsJrv3s9+abDPrNvxnUU04?=
 =?us-ascii?Q?Z1BL/6QOisIwR9OrEK22JDi1DvU/zz4pH3qgNPEKmkYUc4dYCAq/eVXeAdcj?=
 =?us-ascii?Q?AP7fcXbFFW/kSoVCADS1dR/xyfFOv4VVxt25bq5CG95ShlvPgKZGz155FvEl?=
 =?us-ascii?Q?wI2k+hd2wj5GqGjktSi30IqnOHj9wV5DHlUGjUelAY3oRLjnabH0XVXCNht1?=
 =?us-ascii?Q?wTNSrg+elE69wiS8NR1xdPOFNpiiVDQ1JKwPelorI05MuoNCpF3wcZpHtzwz?=
 =?us-ascii?Q?yAIqgZQhxGjuHRw+sxvtwoGfp3+Q5+hp2Y+zdh+MBD6RKAN9k0joKPfP0Kw2?=
 =?us-ascii?Q?wgtyhhP6X0NztPifTdzYiJMLLGxeE6DKuqnRyYkeQsQ90bVaiOB6vhrNPKJm?=
 =?us-ascii?Q?fwydM4FxeENBMKB68nCoP6+8iC1fTpBWHGRGh74D/p87KtlHs/A+4psRd9kn?=
 =?us-ascii?Q?jdNYTKhFBC9a2CDRe7+JZw/I8308lBraWJmYEztRZrmP837hxk7sVsbc9LQI?=
 =?us-ascii?Q?j/BhdXUtdPnijOHiAf4G8IV45n+dmvjLVuf9jOIp8+X7nbWXQUSMclEmIdjI?=
 =?us-ascii?Q?l91VoUjDkMxZ4MRp6Nb8S0BZ9UdXHAzdHRjEGRh42MrQtZU7mEpIIYZw8Th6?=
 =?us-ascii?Q?D+2cnGHbolL2MYTl10m6ghvkMcWatfIS0etTHu167JAQxq9KzrMLDeqFrvOK?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684123f5-8930-4b8a-f424-08da5f8d7606
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:00.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZZht0+swWRZRhO30SKk7rGnR0vzpJDhDgDoUXbiYZHyQcYqxiZ/y+yiJ5emNfBn8RqpGUpzQquHGpYrLpNPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-ORIG-GUID: NWd5dsC_EKr2vcwura-SapuSvW-MrwqT
X-Proofpoint-GUID: NWd5dsC_EKr2vcwura-SapuSvW-MrwqT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for code in hugetlb.c removing pages from the page
cache, move remove_huge_page to hugetlb.c.  For a more descriptive
global name, rename to hugetlb_delete_from_page_cache.  Also,
rename huge_add_to_page_cache to be consistent.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 24 ++++++++----------------
 include/linux/hugetlb.h |  3 ++-
 mm/hugetlb.c            | 15 +++++++++++----
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7a9f25fff869..a878c672cf6d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -396,13 +396,6 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void remove_huge_page(struct page *page)
-{
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
-}
-
 static void
 hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
@@ -510,15 +503,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			folio_lock(folio);
 			/*
 			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * cache BEFORE removing the region/reserve map
+			 * (hugetlb_unreserve_pages).  In rare out of memory
+			 * conditions, removal of the region/reserve map could
+			 * fail. Correspondingly, the subpool and global
+			 * reserve usage count can need to be adjusted.
 			 */
 			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			remove_huge_page(&folio->page);
+			hugetlb_delete_from_page_cache(&folio->page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -755,7 +747,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -1012,7 +1004,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 29c4d0883d36..05c3a293dab2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -665,8 +665,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
+void hugetlb_delete_from_page_cache(struct page *page);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct page *page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c1a0e879e0dc..a9f320c676e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5402,7 +5402,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct folio *folio = page_folio(page);
@@ -5431,6 +5431,13 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 	return 0;
 }
 
+void hugetlb_delete_from_page_cache(struct page *page)
+{
+	ClearPageDirty(page);
+	ClearPageUptodate(page);
+	delete_from_page_cache(page);
+}
+
 static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  struct address_space *mapping,
 						  pgoff_t idx,
@@ -5543,7 +5550,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				put_page(page);
 				if (err == -EEXIST)
@@ -5951,11 +5958,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 		/*
 		 * Serialization between remove_inode_hugepages() and
-		 * huge_add_to_page_cache() below happens through the
+		 * hugetlb_add_to_page_cache() below happens through the
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = huge_add_to_page_cache(page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		page_in_pagecache = true;
-- 
2.35.3

