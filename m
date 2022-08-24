Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0B5A00EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiHXSBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiHXSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:00:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303369F5D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:59:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkcR6007213;
        Wed, 24 Aug 2022 17:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=86V0o8EjtPizUkP7ckO7SCMiRdZbs1RSaDWcJarlHC4=;
 b=wl4aamfqsDo9TbB4SZSUh6evC6mBxlYsao0a3XRRVECg2x432l6KP8tO0EG1U+DSr3oz
 rU1bydrlQ3eT2sit24NIVOrfzQUeX5wkXkV7t8L4BZrntKOXE4lc7lrZ+8f2SK18jxwO
 J3lFGWFHDTqbqk56HtXVdTH/tnWdb018atAAwmYo16VO4s50GpaZJsc8nUlT5Z5auvhd
 dYU2ohazFgXFppjYPYLOfis0zf3QgeMQYKwQNE2fNjpZHraMRfs4XFCtV7EmUfTREWDj
 C39nXq9xIgRDJnuN90gmGLqW+aybanY/JvRQPhTD1UM1uYR0ul4nnXTqjo4COH3yFxTN lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nyapgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OGuJTu008242;
        Wed, 24 Aug 2022 17:58:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7akm5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxNn8L9hQnYrANd+j0Y4x+ionV3qY6ctkRf9n2obZq+sA9ASfmzywRic7HsfIfq5ZKRz8yVO+p9UsGdgq4C72sKtIMd1dIhzwjgdLAzGJhOTmmOnB52AgjSbY83JMSAS+VazkyiRwCAFb92XecwIDsyuGGh5eH+MhrB3iPjSa4O9+rWo3EgeEOQHdmIfasXIRLOUSgQQ4IqwxhIlcXvyyWKNkehZZvujFpDCreQgQ0EdIvBYpigrJO90HACIOvJ/vMZHMkbFz4QDmdaNOix/2gVjtM6nb0j+45a1t7jrsabO/zq0w+ICT/ngmGDa6FBsxfZDCHosS0qKLZ6Usm6vDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86V0o8EjtPizUkP7ckO7SCMiRdZbs1RSaDWcJarlHC4=;
 b=PverUZo0TRlOjNnczJ5Ugxd2LtzVAL5cNdxu7GV2HBEKanlUQYRAsb7r9K4PAnYAAT82ocH251mwISp05qo/o9T7tvQFR3R9esEmvCyFWIBjot4RpO4MEbG8wdroR4VF+Q/HZmuePpcOKtR7hXBm8KH9gf23lXeN2MuLXDNznNLgNeA36CG6DJSHLXcSEVp3Int0GoTRt8ckpv42grQPbhIvmF6+dMkGEAH/r6JEs6QpDIbdUK9aVBKZ1k1KHOIqoMuAU+p6AeeyOYUUV5CbHSUV8fPmVG5u3fB4mR+YLahULOehQTeQEnGUljqB2U+UmOy0/wnywoTv5RkfLq18Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86V0o8EjtPizUkP7ckO7SCMiRdZbs1RSaDWcJarlHC4=;
 b=t303mTzXID7QtuNQrzdUYpbxON1hLXMg8WhCtu8ZE73GVDYx9zdzimM7JZ31nbneuqy/TzGPsxXVtx5QfjPhWe/wUR+dYYjmD21gUXQ9+ZCrEsZAcYPOnWNk8smrqN8OhTJFg1A2nVhgnADQrqMcWym1HmdfDgF9puPRUdRDMXU=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM5PR1001MB2251.namprd10.prod.outlook.com (2603:10b6:4:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 17:58:10 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
Subject: [PATCH 2/8] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Wed, 24 Aug 2022 10:57:51 -0700
Message-Id: <20220824175757.20590-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5076828-2b29-4627-0168-08da85fa34eb
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXozgBxmEbhpsgOQchKZixjk3h7m7IxgxCpii/d0cvn/0sJMUGJcOTLuRikhzqfQtDyOQCtr919ABs3As601BLj8ZmuOwzH7Q0kfx8XnqKxux27B3TsZwPit3YGdnoM7dE0Xh8sBX4Uxk3uzogZ7EIo0e3XMXQpojKBURzsGDSzeuqOopJkWpBIwkDwfAsNu78tipiGv43K1svMVEzXGFePwpkkMtqevJge0kdqdkhcPOBjZshGrY/OVoxMWU7Xei7qY2+xxUqUwX3m9I86r3hszCioJrSI545MUEHGELVNXSqbFDnMZSk1netmW237fWE4S6r0g9o+tvZgzFv0G8XSnowoLa+OfM7n52HlWZv5/DXcGjE27+GWmwpPN/hq/bGRkgA60meNXrfEJ4ZWqVAljCPs1iKKybZB0MVJHJKF0dBtvwzYF4q3U4XLKo0xZ/VIWJaYS9z2tdHzVn4h37EVB1nn+D8Y/md6iedc/c9M8Ykb6RR/4+HmjcllpT0vNUhqCfvgfMr9g6womhDqloaq3bkShTlH5T/GJUCZrh392pQq4dSZAGsnLv6OhgO7mA8PjBxPwA2LHwLRjgZ3wKUdgUvdoNF3M4d/MGFHDEz5etGXREEWOvR9peXjxaVE+QOr5p917B/xEyZslkGEWGSW6gsE2vSDmCGSHGC5hwETFyov32Nrhm/rBwIEgGjeV8UO/mfBVk5KZu5Q/3s+dOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(44832011)(2616005)(186003)(38100700002)(54906003)(83380400001)(1076003)(66946007)(86362001)(8676002)(66476007)(66556008)(316002)(478600001)(4326008)(41300700001)(6486002)(36756003)(7416002)(8936002)(5660300002)(6666004)(6506007)(30864003)(6512007)(26005)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fX7OiTm0JHTHFQEsvXpLSJrzQWfR/lKcgM7JIiziZXYMnXYhIADjTgH8JjCt?=
 =?us-ascii?Q?sK9/0u1MGyXbxpicrJjqQQlstxA93ZM/m2uLn3SAyHqptQ1mANYTVe4gg5f1?=
 =?us-ascii?Q?kSASjG6XieNBgD+JlOPahZ+UzQlKTmkGsffCb3J4iummqCoCS+C80AT3l/2o?=
 =?us-ascii?Q?MKwSM7KKdZh27ONECAJh6LAqnnRptpMPO88q17qBEHIClJuxNeyY1H+sxZUi?=
 =?us-ascii?Q?E1puyt5NdHetdtRMWhRUpyFocVzywoMZ+uXdulTR74fAoUgl+OzViDIcIkIi?=
 =?us-ascii?Q?Kb38Fr8SufC+6E/jMtKGHIWW+G3S8iKwRU2jj9uLSmvH7+F7KNHju+GTGJhd?=
 =?us-ascii?Q?8lI0rBLA23QBXsVj4wlZjI47/lRUgTpsrTI9uFj4KSAFgsFqWsgrh+QFj7wz?=
 =?us-ascii?Q?a4zFtogeRTKphatBsIDFjin4sT4U0J6xoK/6S1mdjXoHrAYRaQEQgTfPVSKY?=
 =?us-ascii?Q?/i2J5lAwTA1auqWEcdM1d75n1192ktQkOVfpcWqx01j2bYoBcKdG8cY4XA4D?=
 =?us-ascii?Q?ugALQnJka1l4U8Fcn2RFIZO1cTA8/xxWxCCrz+0FVOv6EkXNdta6wHxuEVrB?=
 =?us-ascii?Q?TPiQkvuitvzcjfJj15EKYG2BLNmoAzzP2Hvu3f+1M5si2Ox0ncel1irZKCzs?=
 =?us-ascii?Q?30BwRJlHcqxWYNLUw+X+YQCR8x734Q03urwcpJegsete+Mt9BauZwJXvG8Tm?=
 =?us-ascii?Q?QjzsQUumbcZi7P6fNymvkB6vGNRpDTViDCgNl6ouH+in4xdD4tflLWPTZJ9m?=
 =?us-ascii?Q?URX4ktE7k/UE4FQePoFl1dDVhN5crq6wH9kDnTTIqJ7Gbg3SeDFeXhjU6Qqu?=
 =?us-ascii?Q?hrQbmOXN6Gay4yPSQvzTNSL8ciwc0e479BdJdyAi5X/lCNqagl0YbKcii0v6?=
 =?us-ascii?Q?sY7zrWFQ59SdiwLG10qz2LXkZzJ/HOlfZJvqQq+n0L4EtzzuPP/nA1xIgnpE?=
 =?us-ascii?Q?TVS18YFJTZ3bwD0F2v1mVp1LMiAhM0YNCrSJdnCNe5ioThWsFO+18OPuho4y?=
 =?us-ascii?Q?+HJY12GQCNeTL4iyYhz0atlUy/09DUTI3IOnoI/lzX7L2ZEZ9TjWrfq/ON5r?=
 =?us-ascii?Q?AuAimWHmRDnafFsBTdOAnB6O/leqbcRnT2EZWh0340ASh7+ZYy+ItcwBCKce?=
 =?us-ascii?Q?GrOtPb9DUnNAydnNnoVA7WmRrvy+0uD6YCpQTD7yz+ni35pv0WPDrh0fv7X0?=
 =?us-ascii?Q?fRAdVh6XSXx8Bbsc8vyz2feJ4WspQrTdJmHoFL3XZ0UfrPnbk+OcxgcBc2Ca?=
 =?us-ascii?Q?iK1mmlC6JpoT5FTKg2qCZT0oliOWgH+eMHMA8T3E+KsEdUOcGmzIxEB59tZv?=
 =?us-ascii?Q?3imQWiDU5TVKRm3UV7+SDr1QScfdHbSkWa5ymlhJJ4SjmPJeZ4CAe89LD4Pc?=
 =?us-ascii?Q?0W8NaSMk8aRSCyRYDtKncJVS6mDHPRZ2icRVu0Yw52OylkUGGzXIfIy2aOea?=
 =?us-ascii?Q?THqdp5VgQ5+uPZwkldfeVNaGpxz1/wMftbMWjI9RaiRXf47gPPZYIkDPLri3?=
 =?us-ascii?Q?9U32kteM7Q+IsAWNpxLRGNXMC7rlIz8b8PqeDKfwolKxq0+AtrL85SJngBMC?=
 =?us-ascii?Q?JxarYyYTn1/XDbwDrazEHGoeU2IGRsmNF2ErJkVrhtuqDWK2MFqpCuS6FySm?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5076828-2b29-4627-0168-08da85fa34eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:10.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8ueKKMJNCrJcgTMz3sR9Pi6K/ZIfddVA7fDAqnHyRinAl/0F52NWsdOERDOnjvcbb2Z+fj44Qn3Ps0Vy9+Xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: h9ZIU6WFqNdJUOFCw4Jj6cXNsoqRNSub
X-Proofpoint-GUID: h9ZIU6WFqNdJUOFCw4Jj6cXNsoqRNSub
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
index a32031e751d1..dfb735a91bbb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -467,9 +467,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(folio_mapped(folio))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70bc7f867bc0..95c6f9a5bbf0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4770,7 +4770,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	int ret = 0;
@@ -4782,14 +4781,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4937,8 +4928,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		i_mmap_unlock_read(mapping);
 	}
 
 	return ret;
@@ -5347,30 +5336,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5538,9 +5506,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5772,11 +5738,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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
@@ -5784,31 +5745,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 
@@ -5873,7 +5823,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			put_page(pagecache_page);
 		}
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
 
@@ -5917,7 +5866,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6758,12 +6706,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -6777,7 +6723,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6807,6 +6753,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6817,7 +6764,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index 7dc6d77ae865..ad9c97c6445c 100644
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
index 7327b2573f7c..7707f2664adb 100644
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
2.37.1

