Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0148C5092F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382905AbiDTWl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382888AbiDTWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2C427D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBjcm019298;
        Wed, 20 Apr 2022 22:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5cxMdQ4mXGkP9K9I6vJCx1ymcLUNpuv5S0xU/KmJNik=;
 b=Cu2aB0UhBi0P5FXkafxRvBYE1QuvIM4m6dr0dP/z6z1u5y38RyQ+9jkZJe/Gh+Kd19JI
 qupe6ryymqiHdU+FXl+YqhwDQ/b8JyqZBtNdYwbEwrxN5Am4kfeyVtOEnLwIzoVxeshD
 ZdQNOyxQKUXVwVMGo3YTmVmRYcemW0QO0HTfwtxkJRtdssBxwRveG/la9goQ8JiP90uW
 8JN11yuhHolezdWBoohZz5n2zxoOoonMxM8B2AB4SskRIOayFmoNoVF8YKBOArmScqvZ
 sTC8+5/3aJxbg40+LGKD3NLXCwbiF+ALy2fm2TouY3axv8N1lT6qV96xBnWa59U2sXcW JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7ct91j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQ58u013168;
        Wed, 20 Apr 2022 22:38:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87vs32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am4SrsTHqvQRD+nXPB531/P2TsSfUFE24Evs5zom1EDHNb1YZOq64N2gu1v1qRVXot+IqjETYzOlAdGBySDFMI90flaa/doDTvmVpqfWbwcpQkpWkkjd4haTeu0rJB6mIoKXVZxO3MwqwktxFBLY9UYV2RJaR+WK7KlWXcj7ZHoSbFUKQ9J40eRqY0dEzuYGm5t+RyB9+d4ry47bSxuz0z7mQYVDHVACPd9jZi2jOYTev35+8FiONbkrGUSgXHvk1Fwpk7dkaCVbY+lkJ8JAupTGO4cGqOnS4vyG8BCPfD8EEk+7I3EsViWCCy3z1aRaQ3nBdyKdl8Z5LW4DW00mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cxMdQ4mXGkP9K9I6vJCx1ymcLUNpuv5S0xU/KmJNik=;
 b=Ga+7+PM6XkCS0pvCV2DBEkk1BGnqLolexVeocH3Hi/W+wzx2OxqZoim/L0p8e+qqm6043RzLDQclOGSPkV9wQsqgLWfrXemvOlrNhH92JYr/PdM0dKrskpYosdtbirnYIWGM4d4qNmG2Lk9an5OOiUt+8RbuzPv0hobrK/FmB5mJdUgreVuuCa5157G2QM3jjl2woLH4zD6ninOqfkO1i9d0rs/ij7nxhJmvEOg/a+bXGWwOaBfLk6XzUPrnjSUeF4bNM7Bx2/1CbJjy7B20fC7e7GbsR88HCN6hPzGu4GPHID1im+cA5MevNKtN2PrH2ZFhxpGNVufLO/1nY5G9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cxMdQ4mXGkP9K9I6vJCx1ymcLUNpuv5S0xU/KmJNik=;
 b=M7rqOD5G0v1OnR4CN3NxlvzHlYpQptMgHz23q3iydINSv/Tn9B/RaZZgDLp9LJu+tM4dacTUth/GewnHm9nYGO8XRVzCQpCGkYIt7QKyL6nPfDp2IIZ7wPK2j19gWqsZHZvqkbk6KyPPrfEBeN337fzUhCGH1ZkWR3HiB9Kum0g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:11 +0000
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
Subject: [RFC PATCH v2 2/6] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Wed, 20 Apr 2022 15:37:49 -0700
Message-Id: <20220420223753.386645-3-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebe4ccce-6f6d-42e0-270e-08da231e7355
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4550306BA713954A7D8234CAE2F59@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFckk5k07Ug5CuWwxoL0cyB8nqTsXG7FeQcJvpyZ1fZA/I8wynv4PFzXIuki7Z9l5dSh2V96j1PVc7S9AWTcrZquk9Ge8hu32OoQUaSQdlKWEvMOeRqlpXNl8F01v1ugx3wzUbjs/f8fOzOWVsKTCjIwzeFgj//ssr8I1h9XLojMmUn+pAe49j7TD1Wbwi9ED53fkihBdwv7QDF4SR09mFFvxCydLcMR0/3CrzfmLToB23PoAfsWhMA8esCAfHfStQZUG5EKfmMnyh57n6b5S5vWkrAeDRm8xTNvRgmeDu5Rjk7skbB+xiI8Uu16qZbdICPIC16ATt3WG/FStuIZzpw66ink+gUSmg78M26B4QKljFff2aUu2VzUTGrMpK7ucCL4C5XFP3DDdBtSALQMEKd4ZY2k0ZXHB7IHPMwKrbhFbIvK2Z4eSGj3PG5whxvJD9Fej4ogeFJzKnDKWoAabI6JlxxNKzGk+BQzKidGwi52E8ZeihZkht4kBy44iGH/0FRfquNXMK0NG4G0ImGZLIEGlynt1rRtexXxXcwhwPDaBw0D0C8wpoBSxwG5p3X18z+9PB+Tow9iHIRwXeUzfNod7SmGaxXp2zVw8beHVY7s9tSEXJKtfjcNKHFuDH/ruNZ3skmGYgUJMZymf+Hq0hOLCsfI3zAh2gd2UBvUBmz1J5wdw1P216CfcR5HXF0PmkmyFY2uWcgBTUcAlOOgSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(508600001)(8936002)(54906003)(86362001)(316002)(30864003)(186003)(52116002)(66556008)(36756003)(83380400001)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(107886003)(4326008)(1076003)(5660300002)(2616005)(6666004)(66476007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKgA8qhDDfd3QVA3ABj+Jiv0qybmCmcsafHHOzKSFw1/yoSdnULmfWVb7IPb?=
 =?us-ascii?Q?BqD5m2J1NREkS4L53Zk0C8FB+nsDtn9k3FZYwIC9PEoN1uFCDCbizBcWTF2/?=
 =?us-ascii?Q?YrR9N+OPkpEQKMIoy9x4xYjLRIxaUurSAAYZOeEHkhNfC87lsmzbQaNOA0uK?=
 =?us-ascii?Q?LwjM5LyEMM4YSf+nVPfxif6YOF3VRAfnY+W0F18fimbu30J+oxFx9WxogjVE?=
 =?us-ascii?Q?wSxTZ96o6IynP8w1e4DOAM8xeOfEz9mglXKOHcfeecU822N6EbOljQj3J6Bk?=
 =?us-ascii?Q?c9IIgLvC1AtC1TChgDomfjsbUPyK3RDXwfAakbnBM4Tlj2jF191nFiZwTRJk?=
 =?us-ascii?Q?Qrp0itLuNFPs2SLYBacsIoT3n7deQyeBptACcXaoPaBIC+AfqlyZu4NEXxN3?=
 =?us-ascii?Q?HRHkOTPzvrpyDD801GTZMeLnL9WqqUybZsxgWekQ+1w2hafjOETQmRqu4R9e?=
 =?us-ascii?Q?bFCDMnmsC/oqgb8ZKVn8EDrP9RrSvMcrt3RVi3sTqeKDHdRtJ6kYHtgyNGOJ?=
 =?us-ascii?Q?uiPXSUYSy7RYfhe/cVXqEuI7wKU0nxhjHUtxB+YH9r9/8ZSbrngihWQXq1X+?=
 =?us-ascii?Q?6KB/+cvFzbyF54f1oFOplQ0wbk5Jkie+aN8cE+5PJO5a/m4wDzfGhETBqYE2?=
 =?us-ascii?Q?RQTKnPnG3o7PyFqT8ghe0bXhneADyBf+cODy/135B255xINtRELFYsD/fTlk?=
 =?us-ascii?Q?19P65+C9cgwLj34d2Zalf3ROek5D7QGj3E9Tiu3gadBELF/eS3y7UF2RTosr?=
 =?us-ascii?Q?1yxZUoFdOAxhQXUZUJr+VkdhR35PMeO5qNx8qYgZkzjSrzZpLFgrqkdzOMN3?=
 =?us-ascii?Q?NdaLYMvFOp6aLx4mGzJlcos2taYUWv4ZozvZ7GJ3eqbeVQqxVEUhHO5i0Qno?=
 =?us-ascii?Q?D3tt67sK5B6DOjBD3fEvD2VQndMd94TULvqM5GIXQrdDBFytmNYdJjoKeaD6?=
 =?us-ascii?Q?MBSNiKjMnFsgDcalR++SsrQ3HtW1NBWKlXFY+BfsboKumbV627Y0esO7Eip5?=
 =?us-ascii?Q?Po4nVlHpTyx8cbiYgG6qoiXIW8AlulI8jaWZXbRFpX0Z0OL3YeM/nkUXxjb5?=
 =?us-ascii?Q?uTJhMHVQvNipEDl/Jj4uvSxcpBp3qpaAIK2vxGvuOIIEblRl5vefUxn8mkNN?=
 =?us-ascii?Q?oCPNpXggfR/JMV0deGBJ0w9rxr5afvCCkLCXVMl9XBA4OPkC1pjMMdWd1f15?=
 =?us-ascii?Q?pnWX04Wf27yjPgMIJGXQyiQPh8289c8CI0l7jtzuXS6Z3LzA5ZutTqRkfb3Z?=
 =?us-ascii?Q?dDZ+cq3A1VoyVvYlRYD2/Kfc25NMpFrY1MJZ5BvjmQZAHoMfOgVfPv/8nqJp?=
 =?us-ascii?Q?goP+pK9Ek5d3MY2UW8ti2pGcPIzUqksDC91/qf4ovzGYk2KJ/COgM0OMimdV?=
 =?us-ascii?Q?oRwHERnC2NRiGVDT1xAjzQwyxoCpYpLBRMjJIfHu5U251zAI/qBZIgh8jx/U?=
 =?us-ascii?Q?hywxwwTF3XJM/fCwiJnEwBCc5uBWn3zhdceG/SuM586W3llVzLrC9Bp/seG/?=
 =?us-ascii?Q?hmKPymbvpkNUR0prGFKkDThWUjpOqLKAY7LN7IIg6So90z97Qa9T+SCRMHbP?=
 =?us-ascii?Q?WWBi1cEDUFsm9b3iaxAG/kU9St1Qew3/9xSPiAZ9DFsNHaaq8189X+xxCztT?=
 =?us-ascii?Q?s6sq9qDn+TNizWQhH1ufHngOIQpR1rl8gqrcYOivb/tUvmHWKtbdIhuTxMKT?=
 =?us-ascii?Q?3IWQYLhsPcfGGRHXVJb4AA3UlxO9HweWvDPHN5sexoHnnPFyQsaoysXFNZsd?=
 =?us-ascii?Q?7S5jQx1ExAMrrSoNvuqj7KcULjIUCDY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe4ccce-6f6d-42e0-270e-08da231e7355
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:11.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIT7sogtaD4CbaAjE8pRR+sdAtURimAZSjaldQfORqtV3Suw9Ao0Iw/oLDq47Ib1yD89pqghTcLxSdevlGTGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-GUID: 9XdZLBvwU_R5rQl7c9-_EgfymiGcW-hB
X-Proofpoint-ORIG-GUID: 9XdZLBvwU_R5rQl7c9-_EgfymiGcW-hB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

FIXME - Check locking in move_huge_pte and caller

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  2 --
 mm/hugetlb.c         | 76 +++++++-------------------------------------
 mm/rmap.c            |  8 +----
 mm/userfaultfd.c     | 11 ++-----
 4 files changed, 15 insertions(+), 82 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1ad76a7ae1cc..80573f0e8d9f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -505,9 +505,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9421d2aeddc0..562ecac0168f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4717,7 +4717,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
@@ -4728,14 +4727,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
 
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
@@ -4878,8 +4869,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		i_mmap_unlock_read(mapping);
 	}
 
 	return ret;
@@ -5255,30 +5244,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5440,9 +5408,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5673,11 +5639,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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
@@ -5685,31 +5646,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 
@@ -5821,7 +5771,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6659,12 +6608,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -6678,7 +6625,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6708,6 +6655,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6718,7 +6666,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index edfe61f95a7f..33c717163112 100644
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
index 4f4892a5f767..1a2cdac18ad7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -374,14 +374,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
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
 
@@ -389,7 +385,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -397,7 +392,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -406,7 +400,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 
 		cond_resched();
 
-- 
2.35.1

