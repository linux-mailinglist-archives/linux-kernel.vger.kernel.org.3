Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EABF4F6CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiDFVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiDFVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E559141DBD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236IdjVt006371;
        Wed, 6 Apr 2022 20:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=FoxNRpKRVHv0Q/z/jeADjpdbyfaiyWRRZB/mt6jB2kE=;
 b=eO5eNuPSqtY7loC/II2+KUwfRJYG6T+MjHDH+jOGyzYucKGi3uVeHolex5GHyElK783E
 8lL+SjBQD1hf7U7+cAqkdTGeQ9lmnJc4P0D9fVzW15tZNSKLWFmTIz897cWefNvIUBRe
 NAyZN4e8M+9Lm1MlLT4tlQvlovULijLncGAilURwbdRPonDkCGo6al97t/R3HXkIY47y
 UKY8JEvmh78BBDjNSUcUz2MGRGZCsrefuhjVymERYnwNoOevvCMn3Rst9VuJoMnkBkjY
 aPIilSbwgX4zZ7tWGivnKSgCWvgzw8t4BUJ7YBaPtkB4Wy1MbU+59XkHV3Gj1vK1BCM0 /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31j6tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KlLPO001934;
        Wed, 6 Apr 2022 20:48:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uw2k83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyhv7qhZ6Om6yJn+R9o5jyZYNPl5eTgj6CA9IkIBSrrNE5RLyl0OhaWgmkYT3kSnAZdGbSKGPEbqIdxLPaL3WIfH4BWCsxeN6S9iPapEXnGIXLzJ/WW89F2a1vsc9+hEvmAImMKSNL1IJrTLDynRpNKvxTHx1cVcJeRPOKH5oytqnvXpGhnn6yDJv8XeBQmSES76CK6PYlFIWk6PlLF/ARBYlOsPq+2AUR1XISm99twg2Pi3S0Sl/WN1wk7cUlO39C0xrMEi9BRyZ4ec4pYX6YTvVBk7rF0EQuGMVkvtrbcQ1sZx2xN+jxFjhYU/oLZHyi1q+kOjUu1RTx76tYdD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoxNRpKRVHv0Q/z/jeADjpdbyfaiyWRRZB/mt6jB2kE=;
 b=CeJ/QDLIrKVwoN3rkvK0s+hqmFnJzO1bdNpYSika6TMOIpjxaS1zzbwEPjN3PyouP5UG7C75UrDBspQpgWBSNsDrFiyilhebfAyutVBa13esgyuZAgqK5ZCv/lRJ3axzYxeU11CHCpmVWwqlTdzALmifMHzGz3Xu+zQF4so2iA6ZLycCqQOHzY7n/4y5whphl8dEFKjDHGFwTZf/NIyecfCrOIvXwyPeYmpGVTjhHvhfrnYgAgxpkdQRPEDOX2o9gOUMzYFWQ6k0+y9tGdWXM7uvEhBvU8paQEP+Ff3/KTfY8O60wsZMI6uB3cvUDvEHVmvkct6JdqneZW1/g368OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoxNRpKRVHv0Q/z/jeADjpdbyfaiyWRRZB/mt6jB2kE=;
 b=cvF7SliWhwCcFApQ4BlJeiW/gWoXlAtDDrJ9Jgd+inf5pLTFC1IaNy+b5RrEpcwgOjCkAaCoUFc2Hh030ZHn2TMEIdn9aI2dKIE7kzHJNrsb4B+X2hv7fJ7LrsfU4ueOa645MYQ6MScYj711KskFp7YaOVvr9DDRPZpzHld5kWE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3362.namprd10.prod.outlook.com (2603:10b6:408:cf::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
Subject: [RFC PATCH 2/5] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Wed,  6 Apr 2022 13:48:20 -0700
Message-Id: <20220406204823.46548-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406204823.46548-1-mike.kravetz@oracle.com>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9743ff7-97d1-4164-430f-08da180ed508
X-MS-TrafficTypeDiagnostic: BN8PR10MB3362:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3362562EC901B5FED3CC5DC6E2E79@BN8PR10MB3362.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAji66pHyJWJ+j1zQsTDqIaIHOtD2IZBNstFfz07CGvO3GtzRz3DXzHxT1cdlM0UKlq5AW3HduDRu/8eFJ6Y+bg0vRjxILNoQVBbmEI5yYx3yodPlRdeD+fXfLT6oNp3vngVt6D9ZHfTWRDw/2EaP+rfAZtRCwrkNwKWmPKZFD4/iJbLcDtCdQwJt0CTFjamKbksjnP15ytBnPV3Tw/FI1xL4p/2H5VSlSepyNWiPJ9LRMEJbCqHvWYbcswl7ha83zlvluQL7W5BZVOhqib3azmXJt94qU0JZPTanXpx332cTnqa/DyO1L819A3IOov+lcjKHNKn1aIZBd+tElmNTTCATHOzwwwvL/U0hF70zMegeAS3vMjUYgecVn0WZ31H8JqPNkL50ErBPCSXt2w2V4bMqhFxPB017RfwDCewNWV8mUOa78XHShHlhnsccJOc+zBbXsgvHf//K97mgmdUIVtKkwhr667woNEK8HUhXlJYWK1o3sJ7m9ebKQ6yZWLuDz+VxF2Aawya/3sXOJSNHFuOCQjG8F/WzApimTOPcPo7ZxLbvcErk0dPdESNkA39nesm+sVbDl+iShdFSb/GX0faP2pcdO+F3cnsEXs/KzysWpF79x3Xrykw4RTfMlU80Ub4qJL3LAHR3lyl5HVyfq0r1ToAtB4mtGqQINuvleJac8VFMxM22f74oCTDzilyNnBJKMoM0WQqdz13JGuwPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(38100700002)(66476007)(86362001)(66556008)(66946007)(83380400001)(8676002)(6486002)(38350700002)(508600001)(186003)(26005)(4326008)(6506007)(54906003)(316002)(1076003)(6512007)(44832011)(2616005)(107886003)(5660300002)(36756003)(8936002)(30864003)(7416002)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jnvwk5YYjfdbwDgSwFmkd+ilPTG3VTFHAgNVbX3I1RtEzjzC0hrmfWVcrrbU?=
 =?us-ascii?Q?9sLr6MaRO8lMdqDymR0xPtbLl+GsNtN84CArAy+3g8jXdasPEmR0wMsU6c6o?=
 =?us-ascii?Q?tUHVAMBTTbuXN7+euhKB7H/DTF9XSH3mAGihb8/J6JEgds4AIR5vwM9v8lwG?=
 =?us-ascii?Q?HiwFcqGs052y0eH/JJIfiVVO9G6p+he/y9ppGH6/m5SZeLj0lNTIWa+la6Fi?=
 =?us-ascii?Q?Z/TxhwG/IrbbjAPXW5X74sw+QTV/NYhtdVwPBNfJpUxqUhDrnPtWRyUlT7oW?=
 =?us-ascii?Q?caxdJaJoVxArkLfGVKc+23cKSZ9SQiX01z8W7UZQkG98pVoof2tpDCnjdBWU?=
 =?us-ascii?Q?8eJMWNXxHAYEKPQ9XkfAjKCPY6YpZMS91SBUoE2aRo/18aUgiY5cTGKF9ffa?=
 =?us-ascii?Q?HZ9S+KT2mcbPEb8uvRfrvI/qIhOYAGsP5SYzeSmppuEpnrFa2YGwgMRPvoeJ?=
 =?us-ascii?Q?HSiFb/31YK8FXPA8bbz57NGms9RIsS0+H0RRd8cKxi4q8NOjtQk/az83Aosh?=
 =?us-ascii?Q?gZgx3ulgfBhKLasAXfDRGrWKrtzbJdgLrnXSlKeGsvo37Cvmf+7GvkMfzQMG?=
 =?us-ascii?Q?AA278H7oWXO7PHbuuldcZP7j1Y22sHdcRYl9rqht5zJVLGLsUJcj+olrGOZ+?=
 =?us-ascii?Q?aYci9+e6z4mlw+jalzhYGnwHjRanJ2dv1J6AzXjs+WAigjwHH9CWKbS3+I42?=
 =?us-ascii?Q?HPom6037nWTjQfciLw48J3HvPjgGNXfblls4tW2Nd1mR7+QG8lRiyPq9yXQW?=
 =?us-ascii?Q?nsNNmzOKNVtBURO9EwUDVviANQzCgWGQZBPAe9IPpit8ziMxz6EUUp+8ZZqK?=
 =?us-ascii?Q?fz1yyd9wUsxsu8KGPztG9EnTkcLaumTMctlixBcpB3s/lxiPeZve0CGdD5EA?=
 =?us-ascii?Q?OlVgDTYfAfkQQggZKMC8nEwifxe5Gugxt0ZsRfVDAZEHarQwhEd5/jNktQeO?=
 =?us-ascii?Q?K0+3eew5liLsXPVHOG8sgsyHrNtJYAfkcpHz0/cxVEAmEdyCPD5lEaX2TNMT?=
 =?us-ascii?Q?v5TtIphu61hHtDMA2JYXvTqED3Q2Q/aDmpImpqkfCdI3+cNQYlPuq5qoNWFf?=
 =?us-ascii?Q?VHvp+wrBdwK+kI/LfYnIjPtkeyi6tYWoz9Cxi0hA6KRmiTw7RckQP/5Y+GF6?=
 =?us-ascii?Q?fHy30RgB2I+b3DizmH7mnSooEhgBo3dTOEW8Yl+mpWU30h1wNRVH/v8XUskh?=
 =?us-ascii?Q?a88c0SJIPC6D0rKNFZSvDYBQfJ3qHIZiRKynvd//8c+mPmlS9Ddw8I1sQMmI?=
 =?us-ascii?Q?vyTCsC27eVA2+FjYT4vRbjvCRBVEiidiXTUC0oDtPyrNS/H9BAPnJXHgH+MU?=
 =?us-ascii?Q?HkqXJsMSm5+d/QpaR7gUSwYVwYsTdKJ3qITzZXLJ1OXKqpScLIeoMj2S++Ib?=
 =?us-ascii?Q?HNwvwYgeVAabLR9FaxTlB4h0lgOqrBdjFIu/Ks+UgTen1Y9X8RaH++nMd5wJ?=
 =?us-ascii?Q?lHQxkQwERuAADMeLvCbFNksGEe7sAZft/dTrZ7TyOUdO9ALTO2h6BNI+GgeJ?=
 =?us-ascii?Q?KR/u8Tx9X1SheiIw2+WN3JE5olUh3MiBJjiHsKVnfSu6Ozww+la/cnly4Mov?=
 =?us-ascii?Q?KtvQRNx1id0wd3vwsop6nb1yd1MnAkQDqc/B6gbp4InxC/CezkQe6oJg2z3O?=
 =?us-ascii?Q?bVhY1C1fXkUkSZwife9/edJoRhEAk6jbsjUt+dYSN8bc3Pz3CJr3lqnAPHd+?=
 =?us-ascii?Q?WzxWn/pQCym3TPuMiFCFVnprvb3RZ0T8NlqjYCRCAkdtPg5We9++9XPiNOe1?=
 =?us-ascii?Q?oM/IjXwSsg7NK3+Q2TBwHP82+xLW9EA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9743ff7-97d1-4164-430f-08da180ed508
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:41.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkfAK9teU1XIaIr10K8n7juSbMYICNtrhfJpu4r+r3CUanYBFfN0oEBDaJ/rL74dNPNd38E39Lz+xo+3ndUsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060103
X-Proofpoint-GUID: I8oDeKK31fE3ydY756g5Ckkff73NDzh7
X-Proofpoint-ORIG-GUID: I8oDeKK31fE3ydY756g5Ckkff73NDzh7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  However, this has been shown to cause
performance/scaling issues.  Revert the code and go back to the method
of only taking the semaphore in huge_pmd_share.

Keep the code that takes i_mmap_rwsem in write mode before calling
try_to_unmap as this is required if huge_pmd_unshare is called.

In a subsequent patch, code will be added to detect when a pmd was
'unshared' during fault processing and deal with that.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  2 --
 mm/hugetlb.c         | 76 +++++++-------------------------------------
 mm/rmap.c            | 14 +-------
 mm/userfaultfd.c     | 11 ++-----
 4 files changed, 15 insertions(+), 88 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e50de48c7707..56cd75b6cfc0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -504,9 +504,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 398b7742cc63..8fa2386bf7c0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4701,7 +4701,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
@@ -4710,14 +4709,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
@@ -4844,8 +4835,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
-	else
-		i_mmap_unlock_read(mapping);
 
 	return ret;
 }
@@ -5189,30 +5178,9 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
-			struct address_space *mapping = vma->vm_file->f_mapping;
-			pgoff_t idx;
-			u32 hash;
-
 			put_page(old_page);
 			BUG_ON(huge_pte_none(pte));
-			/*
-			 * Drop hugetlb_fault_mutex and i_mmap_rwsem before
-			 * unmapping.  unmapping needs to hold i_mmap_rwsem
-			 * in write mode.  Dropping i_mmap_rwsem in read mode
-			 * here is OK as COW mappings do not interact with
-			 * PMD sharing.
-			 *
-			 * Reacquire both after unmap operation.
-			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
-			hash = hugetlb_fault_mutex_hash(mapping, idx);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-
 			unmap_ref_private(mm, vma, old_page, haddr);
-
-			i_mmap_lock_read(mapping);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5366,9 +5334,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5590,11 +5556,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
@@ -5602,31 +5563,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+	} else {
+		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+		if (!ptep)
+			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something has changed.
-	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
-		i_mmap_unlock_read(mapping);
-		return VM_FAULT_OOM;
-	}
+	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -5714,7 +5664,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6475,12 +6424,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner.
- *
- * This routine must be called with i_mmap_rwsem held in at least read mode if
- * sharing is possible.  For hugetlbfs, this prevents removal of any page
- * table entries associated with the address space.  This is important as we
- * are setting up sharing based on existing page table entries (mappings).
+ * code much cleaner. pmd allocation is essential for the shared case because
+ * pud has to be populated inside the same i_mmap_rwsem section - otherwise
+ * racing tasks could either miss the sharing (see huge_pte_offset) or select a
+ * bad pmd for sharing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
@@ -6494,7 +6441,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6524,6 +6471,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6534,7 +6482,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..206e7d3efdb1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -23,10 +23,9 @@
  * inode->i_rwsem	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
- *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
+ *       page->flags PG_locked (lock_page)
  *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *           mapping->i_mmap_rwsem
- *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
  *                 swap_lock (in swap_duplicate, swap_info_get)
@@ -45,11 +44,6 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
- *
- * * hugetlbfs PageHuge() pages take locks in this order:
- *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *             page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
@@ -1495,12 +1489,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		address = pvmw.address;
 
 		if (PageHuge(page) && !PageAnon(page)) {
-			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 */
-			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
 				/*
 				 * huge_pmd_unshare unmapped an entire PMD
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0780c2a57ff1..81e299edbc1a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -351,14 +351,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * Serialize via hugetlb_fault_mutex.
 		 */
-		mapping = dst_vma->vm_file->f_mapping;
-		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
+		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -366,7 +362,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -374,7 +369,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		    !huge_pte_none(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -382,7 +376,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       dst_addr, src_addr, mode, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 
 		cond_resched();
 
-- 
2.35.1

