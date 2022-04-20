Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188E5092FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382924AbiDTWli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382892AbiDTWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575540E60
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBjcn019298;
        Wed, 20 Apr 2022 22:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=w6u/6HyQfi3PPs41Vtgt27h9MotVJMrw5wXoJwL+fo0=;
 b=lXSdQVQv5nX3bsXKBCX29Do6q+wwdgx3TCM615JRoauTMh2VQLYP+AlqA09L2z9x7NY3
 agM3aRoRsidr2M3hEn8V3B9zMp/3tFm4e8qD17lczhDF1jwhJNxppqMhShkUtxUgvg5X
 OLnsGIgK3ymQqn8wmPL8C/K9+VRjg7yfYSqNgi2sOTd63xTy+VoHPx6pV7s6AYtnT0ap
 1bbL1AMvvvCXT7FgHRsXC6vWJ+N+LmDgpp6AXjvZMvhxI6MmBRvzU7ss8o6Henw4S79I
 7TdkID5njYpkTytsDnf+DmDwl9Evjxo16ZbK+B/6okx7awglh7YIG6HqK2jFrpNiQMiw Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7ct91m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQum9035920;
        Wed, 20 Apr 2022 22:38:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm88dqq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnNciUZ2WcNGPLyGOaSC6LRASxRBhRlWDpZPOJZKGk6bhgWVmeMCYWPaN9g4k8NQxUvVLrplpn/hVdyojbeJsdoceMGKPRGK4QTtXe29mWhvAlkZYYA4m0BqT10mczTnQl+GMvScguOPaeM5BxzAqldnvVZ7I55Vez2fmF3AzjjQDVPrxCmevk0FQXXAi/+RE6thyCq8ZK6kbNhB2Qb+8AcVVxK9eDQofo78Pn56WkRWIc2vztX/N5SakiWNTenQHyjGRM2Jqrgdpy6Uwv7h10O4di3pzcVmx+XW17TykNcSbAJWJ/G1MXRWcE2OMahRVxSUJUuo9VC5uE/RnlgZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6u/6HyQfi3PPs41Vtgt27h9MotVJMrw5wXoJwL+fo0=;
 b=N35NgcqSUCIsAONoF0OLtQ6sjisCOtgpoFjxeKQyQp3j71jzrchjUooj9oNwcuVJRwaCHy+N+G0FTbgPWxGE22z4yeJ1aIqb6Zy+930XhJqOiFiCbDcSRnKtjYORTeCP80kMcJrgx1xp/KVtdKMdmLxyt6N8iEJUZzgeqF/SmaTdtUiw8lQ6cm3f1phE2oJlp9sqLz4MeSGYrSEhwE6m5wfLhVTOcyuavms7yJWmY2LB1yh8dkFTAbGNRbBIyZOTeI/Y65jbgFbe2Z0WWtFwCXHSOXZiIDst7xoi6C/J32cLi5yKXEz+tqbBynDLewwmrFkMS8T4hewUhdnfd6F1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6u/6HyQfi3PPs41Vtgt27h9MotVJMrw5wXoJwL+fo0=;
 b=hlxQykTIWPx56+ljqUHy2AxuPpOSQg2UskrSZ4cUEIIQ/rXkxfd9tjf59BD9TlWkh3Ml86DIoP9xLr0UxQ4jtAogvUJN03hhm8SHddImO0TEDrGXDiGLYXsGKCLZdq3RY8U7K2dS4QgUYACsXHASLhK4yo2rhpzUSDuvhmCLChU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:13 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 3/6] hugetlbfs: move routine remove_huge_page to hugetlb.c
Date:   Wed, 20 Apr 2022 15:37:50 -0700
Message-Id: <20220420223753.386645-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420223753.386645-1-mike.kravetz@oracle.com>
References: <20220420223753.386645-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dea58b18-4c10-4910-5392-08da231e747f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB45509359EABCDB0CAAF09827E2F59@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnvvupijr52GQ8zB/Es6h5yhQvnFCSEo4RcuasukZZqBErGj2b3l6kU1+Gq486a4ugC4iuXtj0Indt0MPEMHkPlSvju3ZUHIA1LTIlxWvRVPCNnsXJNc3+yTbAXE20MBlf05dDfo/WRNOoQ7x35I7H30DWJBlxUs2davCV5Ix+H2747nenGnijcy+nAezjdfc0q8Xko7cLYBpqYwJsFTVnROZ53+jWmgYnKu2Q+1YSfLaUVqf7k3+Hfv5I191vNRpwWZ18qpuKxwwPUs2GRM6FLCD6+mD2S1vRrGKpq/5AFmE8bgko12TIhuROHoNIoaKA0awwiwmp2T65KZQNxZ3w8aFG8IDknqlfyeJMWrMUQ+ncem5D+Zr8HM13C4mr9p2HtSGiyQZLxrzrppgZ84ndZZf58bN7do5OQqxbAL5y0UJVrx6pJqjGGL454yR5S/roDv2gaDIZm/RHwn5K7X3WSzQbPRwSVCiYXCTpSOPuBw1zAGMKrr84LEJnNRtiiYN7OIY7Zj73jAjI95PNPr/hq02tMGd9UqrIPcJUHTvP5MMrO1G8EoEpR1bkpFjAhfA+uUjDKv5ASaD99aJ0pas3fZwuwJunntkKok0eJ27P5P9lQjac7VEZ5KPYFo8CA2OPYZE5rPF6tUQ2yDjNJegUZDpv14BYrBGxV+wglTvKk5PwZORC5FDqX88vGFVDOmx4kwTb6Cc7Grm2u15NqvjH+JQnDitN8l9Ny1CHENQQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(508600001)(8936002)(54906003)(86362001)(316002)(186003)(52116002)(66556008)(36756003)(83380400001)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(107886003)(4326008)(1076003)(5660300002)(2616005)(6666004)(66476007)(7416002)(8676002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vdrScbKEBCLJxai1xjp6P6l6cY8f4ypbBgE2TB7rrxnz0rK3FbVnWxV9x+P?=
 =?us-ascii?Q?QHE/cdHYZ0bhctxPx9GyNfXoaMb0eGIf+ONOJhKMRqs/9GazH7CvJbukpyDm?=
 =?us-ascii?Q?mDGM3xk7QvErFFYcDKd1tk/3P7f1kkEjEZBvFEIYejqpO0W3tj+r5oh7PABm?=
 =?us-ascii?Q?rDcYwqlaaRV8aXCuYDOlYYFx/py+WkXa7dvtxyQEN98WVE3D5B4m3KOoqYh8?=
 =?us-ascii?Q?oHIIgwNSwdJ1WmCXjk747SjUXaggOYMHFn1UMaagCgEU4jn1+HH2zvhLieUa?=
 =?us-ascii?Q?J7t3ZbcxyBodPCvsjLFqlDWLlct4m+rUYYPdFl62SacZ/EQxxCR17hlE1Tjm?=
 =?us-ascii?Q?ExuxMCy8Z3lZFgVxrIoTbqc+1yeS+3KLachTiV1kImsnp4t8dGTldCu9MBeZ?=
 =?us-ascii?Q?XBSIz6HkWBZbJlInlOfqlGhTBF5OhMn6H//ZJ5T6DjhSbIGWXcySy6n/Zrt6?=
 =?us-ascii?Q?Xc7vz7jEbmyiSOzGnL8oevCQyvFDBEYOmDMI6l+WSjLcuq2xu4+si6l+/ruc?=
 =?us-ascii?Q?TfzZBeoGgKsRB7SYovLEPklbxgj/rglPKRAx4NBf3JraDaAw3q14Y6aoa5Qz?=
 =?us-ascii?Q?92RVUSzU4vDm8KpdYP5x9lVSXJj+muTeIpdDGFZAa0e+bTvUB3hZDrue676j?=
 =?us-ascii?Q?40mxXygUAN6U1MNDPANh21vqqB6dY0BGsqxK3mdGevGXNzZ6FOzIesPRIHL4?=
 =?us-ascii?Q?UzPNm8l7d8kD/fav5I8AiP5E45PM+8vnIKbe+rzdTKNscIoM4K3IAJXLHmDe?=
 =?us-ascii?Q?nob0m/0ZWF854dK+KlIy0zu/Q0lp58RlArW+JSOMWz0k9GkRNsSTpKfQlqfN?=
 =?us-ascii?Q?feHNMCWUq+Wks2VyJHbFTImmUbGcviYR9OlxyabnXzPQJyItrb/29FprAWqf?=
 =?us-ascii?Q?quNAZGNnpDPp2VXlW7YWW5OOy4JxbrpqKWrvWbPoGI9Clb2fL8pkNKz4Y0xI?=
 =?us-ascii?Q?RZvc7vDjSUeOmKodYX3GTutYf4mNIt1g8zZvgYHnuIe0of001wCAIT6r1tIo?=
 =?us-ascii?Q?v+2BBrF3s8wLrGUOM5GWYSS1SXcv8fN9kCAcXrwHwyC6f1wmNyuNZxhLgJ3v?=
 =?us-ascii?Q?nWXpQu29tuGgsrgXc6FNL2mASm1CLcAKxp3Pvin26TOfQ8pnQ6g/r1JfIRsI?=
 =?us-ascii?Q?yPbdxhxKgX9+jnt2ezVT+MlPRwRxQhsu4bCjGK4ILwnZffNzyhex1krqpBWn?=
 =?us-ascii?Q?tCLk6KRaq09gyXDbRAK76BgE/2UvnFWdT9n5N09u1TqRrqtaX5/QpX7SeB+Z?=
 =?us-ascii?Q?qQ5Hzz7zx2bQzcghOrFopqbjD7aT/yrLEZDm/Vea//j8IrMoWREfFnPDYN1R?=
 =?us-ascii?Q?skUT0ur4T8INvEfATjX+a/rzuLAt6Ux5qg5aBX8mYCbJaCYSsUclfS7vbvcp?=
 =?us-ascii?Q?8sb/p3MCOVMdyzAoJMaHkxVGMeyft9eN8nfGkKqjcDkHKJHIb18p5F1xRUB2?=
 =?us-ascii?Q?B6uSKynOZYGtfOcyg78ZPt65aQFxyGF8DixrLHDvu6p+dGo/kBs+PUNyGMgZ?=
 =?us-ascii?Q?s9QROHmalK/X1HQXdvA8lf/oAq9EBEnhH6hXb9LTtURz0u/gxV+dgZO29S2b?=
 =?us-ascii?Q?RNJDxU527TTqQ8oC9i69xP37YSf1jbTlt/Wv4tfAYJ6hCDBu0grCNxfBUv5p?=
 =?us-ascii?Q?vebj1u7JxiazTTQ0NjlLultlZiGvnsefXzPhxFZAPLPKirYGqmqHsy0gEXic?=
 =?us-ascii?Q?AVlZsOaGtc9Q9bkHoXZonNiyedISUCpGyvozIXj1xBCdoMvZgN953iTOYnOZ?=
 =?us-ascii?Q?KDjBD8dVouOQwLOCQMPbext4koEYUxs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea58b18-4c10-4910-5392-08da231e747f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:13.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EtJQUQnA9ZMo56/oIN72ehO9nTRENHY94Tmxy4FZ9s5yoOn4gAFtEaZtHyyM3NHzgSz5i5uHk6CFuPvLgkaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=914 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-GUID: tgoo0DFMzdyx9XaILCdJWPJDkC3je82T
X-Proofpoint-ORIG-GUID: tgoo0DFMzdyx9XaILCdJWPJDkC3je82T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
index 80573f0e8d9f..5e4bd2f1705f 100644
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
 		      unsigned long zap_flags)
@@ -516,15 +509,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			lock_page(page);
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
 			VM_BUG_ON(HPageRestoreReserve(page));
-			remove_huge_page(page);
+			hugetlb_delete_from_page_cache(page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -723,7 +715,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -975,7 +967,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5f4a2f69dd3..75f4ff481538 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -655,8 +655,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
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
index 562ecac0168f..d60997462df8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5353,7 +5353,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct inode *inode = mapping->host;
@@ -5376,6 +5376,13 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
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
@@ -5488,7 +5495,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				put_page(page);
 				if (err == -EEXIST)
@@ -5897,11 +5904,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
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
2.35.1

