Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2217A56933F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiGFUYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiGFUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9B192BE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IY2FE022884;
        Wed, 6 Jul 2022 20:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bmSIBkGRbfR5tB2WWrvtxqgo+G5y/yCBa1K6lDJILL4=;
 b=HOA0Vuy66w9RaLzQ2Ymnbsypd51ne7DFM8UJJU9p0VgrENLEjcQuPMEdYos+6iB99AMA
 E0v6HDJ3cdbxUs4XXIh6aZQ9HpZu14H5F5XENasimhoL5dA8BhDxzMRpb2mJoVCNV+uu
 kqb3dRayDPg1DGuePpxN3oXV4mkiyhUQrtQnVH9CSHnorqlVua+o6lKTxd2xFIE8lvmP
 BYjEx8D8btIm6AQgnMBq5b88eFTVi4+Ms0JPcu8z+oqy9fqYLvuibBgi436qbCJeJ+xw
 VumGdel74fm4mqRLWlaXM2EJxHCU0kIYqHwJMVj+Fe+tewSajduBCXfITQ2AJXuknEA5 tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyk9wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLJfh035194;
        Wed, 6 Jul 2022 20:23:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6cu33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgSbz1vMyuLoaLcEOa1ta3NUlovakqfKTMZmBOK/9YQprR6unrZWVbQ+seUCAtjEDD1a6/0C3KN9gD6lPN/lTeASWW8UqTCvsOavEATYRJHHSlAlbVgOKAGcXU3qlOtnSfBH07oHnC7KHjsBv2YS+QpRty0CQRzGAZkZniV2ZZlUqJ6bTv6f2wpOi6HY2DadjK4nUzc0oUcomsXWcA5jyCWrtEg5M9fF9usp1TlqE5v+HKGjrDJ0ikt9mBM576LyScabpqrVH2pmRl0MAqYVnakjeL9D0wjACoie7NIT6CMvEQjByWFC44HWnkFHLOYLV8ZZdtNRHKtqk2zSw+a0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmSIBkGRbfR5tB2WWrvtxqgo+G5y/yCBa1K6lDJILL4=;
 b=JB9UCwI25UKyj/p7zvsHgObPebbeAU/ZaNdawr6ytD3ezmosqQfw/mXMz7iscVBMg3OlOgpIKW1IzFGjbc37TdXVfzVE24R25OUdrx7QHs2hb62laDBlh7LfvhahDhpElrShbuyXMybuNxgWIdtIobvzymErYaT9IpXtUY+GCY8a9EweaFxXat7CmBXVRbeMbeuPOL2VxTS+MrpvhTo2aL+GmrF7EdaTIaGIFvrQIh5agj1zFIqs64VEq/GIv5Lgtd3znBm8ZwORlwaiGHMb6UXgl6ZmJkG72l+E0CKQyTWE6V+Bi4Adfx8PSb9TeznWMzrEzg6ry8nIHa6ApbSubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmSIBkGRbfR5tB2WWrvtxqgo+G5y/yCBa1K6lDJILL4=;
 b=Vmp5OU1nWGs0mmvXMXB619EPHOr06JfusMRzwfnOl0MctLTZF4P3KRGgm+l9ptupn09iSfJKNe8hcgE+RGed0oS3RIFe0RH0+wpNrZhz31z1Cf/kFWYtvIiX5IjqBp8Ol1DSyyiwHClUVDbSscok05RNg5ARvK88tlwxRvQywX0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:23:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:23:57 +0000
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
Subject: [RFC PATCH v4 2/8] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Wed,  6 Jul 2022 13:23:41 -0700
Message-Id: <20220706202347.95150-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:300:95::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bd81b97-f1e7-4513-fb97-08da5f8d7424
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aohydP3J14VibyZ3ntrTesnH3LH/28H9hN85dZVBJ1PCwh5ji6jl8KNfyBOMpqWwNJeyVZ4itVjrfB9VOwqOI4pCibj7vklSDpcy92eBurrWRL4T9OQEiep2xLxXVAnp8N0MrwuGMNbnkXm6CDzZ7agU0Hw4Y2lhb8s/Vx3XqFs3M1X4nU6F0FHZFFepu9Lq9g0rpqCINZFx+HRWDjMkWiycMGZhrcC4hxrpXwO0Jg25+gD2ueHr9VP5Zt0YWiVM4NtjFxgvOIijsfdQ8SvhdSuq0p+LHW/GKs0KCagK3LCirxA3c0CAFFiEgyRpJUND0rhXyS4I28gcryU3oM68T/pkHLlY7bY3oLkzazpDCNeKjnhFn8A0ne1Ag6xwyyntFtDYMBB167WZ9PJCVItqFaNA00RH6ILbxYzjjKQ5n3J8yyyo74d9JjBrDmw+GBrOk2EA4PTfA4sPe4NsrvlPl2ZjWr+ofOxi39JmqU5EMh2slmFm5NiYsc06D2VxSfAIPvdfoF+8XRyiSOv94R7REYaw8OR26m5f7JwgCKkuotps0EIVMX7S02wQqJYhU3i5BCd8SywmAOXKgXdSl9DQKoh3Pogs6Jr2qf5QbVu5RXtHu0kIj6euCnd7+JBMSzo/F96k0oXC0aYvS58lK5bIen4AKyPo2/ql2vIDufVcWXETa/9sEIm7BkETIwU/ugJRI2Esk68nRB74fq75qB4rJ7Ig/mR2ukIu9v91DZA3k9tajlYlKR9LZDqFKkoCUyA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(30864003)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emNSHOI4AvcQeofb9NZeCGNlSvdnQKPJiU7U57qwCqe5TA2RZkgbUXszNktI?=
 =?us-ascii?Q?vcaKmpw0qph2APML37qApPYgtB4Tb6v1EhTPiMPq9I/88MPeNVCVqqJY63+k?=
 =?us-ascii?Q?Lj1k+FSg0qFK7iJz+zSzFxL8RVDNfu6ysZ0xHfEm1C8WUL0SBiQVEtRW1ldz?=
 =?us-ascii?Q?RWCFiKyVNkHJHDNZ0Jbpw9sObikdu688ajCMe0QRUfzOTpR9iHO5mB3yYIO+?=
 =?us-ascii?Q?VicHEX1S+jvBl8/PerwdH7Ejzbk4IzMOrBuds2EEArM8/ZVAM/2uYLv7297I?=
 =?us-ascii?Q?GBckVLP4D+wbBisb8oTklIvMGFXiYJ7OPufD2fsDrbZG5HUtlgA0vhh1Wj9p?=
 =?us-ascii?Q?ec1sO1fkRI5Bxg7GoT+O5+KpKYRAVnYGU0xsESTHoyvoMwrI7rz1EQzuBAbl?=
 =?us-ascii?Q?pDnA6oGt83VM/Y1W+WgcJ6JZiwhBMATIqZn6kfENlGMn+BcjYtl6xCBSpWxY?=
 =?us-ascii?Q?wR4hmtjVBzeDeceVPKOFeYgnsgc7TVRUxZLoFjE3F4TTOTZAVvlvecHWSf8r?=
 =?us-ascii?Q?D45XyuH732WYIGHoOc5CTGyn/AuWvZMzZzRBG3PKP2LGpOkLJTK2MkrPiSHy?=
 =?us-ascii?Q?rlTLK6CzHvphHVhoEthe5JQK2IMhxyUV4ef6hc7cml713mfX5uazuMLy9xsN?=
 =?us-ascii?Q?3JwBoG1LaBQKkXjibPYrEQOVYa5ET+7KlYlt4oGunxcFCqLXhgVhGowoejcV?=
 =?us-ascii?Q?qeaYfKaCVAr9RzbHpJD8Z7gWZifLp+ja+93T+GXh+HSAFLJvr/Q+GKwSLrGo?=
 =?us-ascii?Q?YaHiQeBOqoky/S4vkcTm2auwZW0YVr1hfwJokIKkyd9y/Lr/vULBX6ytNt/5?=
 =?us-ascii?Q?jGyCLRRhmFl13q0AUwJqu74/J0zbB6gMflyMk9/+k3EUUYhUw8YRDSdraWD4?=
 =?us-ascii?Q?gDPJ8R/FGw+3kKZEYnlfJFMl+raA1sTUWHs8Nua6S7pg2tWstnWFG8FrNy4A?=
 =?us-ascii?Q?Jv7A869v8M5a0HTxoywtGQlvbN5nWS/8l3VDVomRL0XxW56OwwQnGpoFHFCj?=
 =?us-ascii?Q?Unb153inI6ph0G7vNdBbkNY8lK7PyiPZtLDOIjzUFz9Py95/7NAFbJkw2CHr?=
 =?us-ascii?Q?GDOQ/IQFg0r3Z5I7aITy608+hQ/ngDcAhSwjC81IXfTDCe4pVFT1m04LkZCJ?=
 =?us-ascii?Q?h98bE81vhf04aPHZFrAVkfYjLQO4DuyqcCkeU1ZBlJP5yvm+CGqiT/O7Kt4c?=
 =?us-ascii?Q?j1mK4oQdp0gebJpbex7OUB+o0gjSSiZVskuEn1rSA2QkXSsrNShuyIEdumHd?=
 =?us-ascii?Q?4E/GaiF/M5lABOABAFUKboQtgESBqMKTXc8YNacFVY2YQoMEVHzQ44xi5xKa?=
 =?us-ascii?Q?7+XpZYernxwQoBCfXWhHRZTG3NEB2ZSEfUVtxoNk7rVa8E5G/alf8ajsiEbA?=
 =?us-ascii?Q?1DRpYZ8O05YsQcNGFGYvHu9nP60enoBXElyINnyZo9/hsOz96PBKdff/BrPJ?=
 =?us-ascii?Q?KrhabxINb0bk3B70BoeKxB7uYZCtOtnfHjPlofokSzGHhB6gJQRnu686V9fK?=
 =?us-ascii?Q?5zE58ayKcowgcq4dAmSCeL6xWMH+VSczboDLR9tBD5KVTtC18MULXVRnVL0p?=
 =?us-ascii?Q?dMzIGaKLJqSPkOX87GKRbnn4DczCSsq3fQg5dDoONeXBnOrWHiOeMgigKxFr?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd81b97-f1e7-4513-fb97-08da5f8d7424
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:23:57.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMeaDZp03eUIV4UTRS8k4x/ZFCvHAtjjhTJ+nr/lQsT9rswDj4N8vHLeqTeYGtggmRn7fEkBng8APv2Pifs83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: 5s_DF5OJFg_ijNFxLsy9Kzxxk4ukt2h0
X-Proofpoint-ORIG-GUID: 5s_DF5OJFg_ijNFxLsy9Kzxxk4ukt2h0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  However, this has been shown to cause
performance/scaling issues.  Revert the code and go back to only taking
the semaphore in huge_pmd_share during the fault path.

Keep the code that takes i_mmap_rwsem in write mode before calling
try_to_unmap as this is required if huge_pmd_unshare is called.

NOTE: Reverting this code does expose the following race condition.

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse			i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

It is unknown if the above race was ever experienced by a user.  It was
discovered via code inspection when initially addressed.

In subsequent patches, a new synchronization mechanism will be added to
coordinate pmd sharing and eliminate this race.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  2 --
 mm/hugetlb.c         | 77 +++++++-------------------------------------
 mm/rmap.c            |  8 +----
 mm/userfaultfd.c     | 11 ++-----
 4 files changed, 15 insertions(+), 83 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9fa1af39382d..7a9f25fff869 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -499,9 +499,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(folio_mapped(folio))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02cceb7b8cce..c1a0e879e0dc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4738,7 +4738,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	int ret = 0;
@@ -4750,14 +4749,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
@@ -4909,8 +4900,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		i_mmap_unlock_read(mapping);
 	}
 
 	return ret;
@@ -5304,30 +5293,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5495,9 +5463,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5728,11 +5694,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5740,31 +5701,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 
@@ -5832,7 +5782,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			put_page(pagecache_page);
 		}
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
 
@@ -5876,7 +5825,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6716,12 +6664,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -6735,7 +6681,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6765,6 +6711,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6775,7 +6722,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index edc06c52bc82..6593299d3b18 100644
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
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 07d3befc80e4..3225b5f70bd8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -377,14 +377,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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
 
@@ -392,7 +388,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -400,7 +395,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -409,7 +403,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 
 		cond_resched();
 
-- 
2.35.3

