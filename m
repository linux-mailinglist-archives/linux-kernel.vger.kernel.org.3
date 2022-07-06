Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E951569343
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGFUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiGFUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:25:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C3E240B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IZWQf022841;
        Wed, 6 Jul 2022 20:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Kvao4cEn24XXr8ivJV7kKIfMYHovdXbmTJsGSiAGhtA=;
 b=TkDW1t9BHJt6FAWQvup3M1x9VRuLC6at9Q3G22rizX0C9ydD8EUGnPRbdSk5xnBz5KTa
 pTajYEP5g+GyC47qgCoIxWE2XlQk2HsLQtoasbFlprmRN/QgjB6glec+qShxKmG8FPk6
 ml2vp6j9eYM6UlDluk758kWCm8i9f1D8tWV4pQBG2O5n6Cz2xCwtkd9Ihzubpd4pVoHX
 ws4lBQdqsefmmCNnIpDIfFJ/LceRTw3iEty8mtlQeD6AFgygWKNUIqOIlAQvHZNH8F+n
 DNKqnR2XFMdF1iIBWhneXKtoOtW2ZuOSpA1Lj57BFRKt5DDfjoy+9lkv4j9+11vVNhDy dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyk9x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLT5N023114;
        Wed, 6 Jul 2022 20:24:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud63wa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZdNvTYaWQ0lBT6P8dfJdr9RSwkAxAkFuePgqAdb9NvZi4eD6N+B6onVVy4WmL6P+ipraeYDoQdWiv++iDGObRCcDZ7CNvZdnZ10Hjg0N1EPaUy2qlGzp2GIAIc+IQfGZGJRly732drjtZX2tuMGt/ykEXwUuxoW2lKWZU4DiI9Srow0snMeXaejo522kfr46aGBmw+jb18Y4rIrd0ArOkU2dCa6AP7bv7MIQ8gj/shflj5WYvNIMxcR5615P8KKAWWxbaY33uSCPwF1cY26VJFwJKNh3VVzIY25fg38sKI2GD0WbXt02hT9EXLOiFaRVeSEvmCLg/ZXJqYkwi2TmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvao4cEn24XXr8ivJV7kKIfMYHovdXbmTJsGSiAGhtA=;
 b=IKhwOdOSnKpD5jr7puVYTBCMHmPs7u0+BrugoJtzq+v68GK/Kn3MIj4tvH/aRo+mH4lYC6jMo++2uw018j1XHZ/+AJk3xtPhkdhBCcv1blN2+P3snbLnlokZ5AGgLN6MzItqNIQQaWVIEf9zPHdo/GIGgqMcfjQCMvWLwLWua9iTdnnIE4HlWiZHJkSUldn3QVmH5DqhaatXb3mWBtsbTS2BeUxP+47mmDMR18+T0Fb/FpLP4JmSAJcugiJdoGBt4GzlIp2Hbh0l5Cv3j3kT5Hra/wyqxR2G/unBV85JpTl4wNQXu28HugoIHqkp3ZlXN9wyjwSw/3FKvQsPfNahVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvao4cEn24XXr8ivJV7kKIfMYHovdXbmTJsGSiAGhtA=;
 b=zczk3SVOiGJVlJlSYvn2gJlJkhDHxkdQ7POY8vBjzlb9Bv4Xo6OeYQ5h/jV//wWS/6bZHvtK+JcasDbW3XE8rtwBZqxSoWWZSf0/ycKD5UpinIbyVzMsbdqu0YGQFiHpE+/oyqX1mKhSIwT9IlhMQXEnzCHrskNZm+oj/ANPjFM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2847.namprd10.prod.outlook.com (2603:10b6:805:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 20:24:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:12 +0000
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
Subject: [RFC PATCH v4 8/8] hugetlb: use new vma_lock for pmd sharing synchronization
Date:   Wed,  6 Jul 2022 13:23:47 -0700
Message-Id: <20220706202347.95150-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:303:b6::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f920a3e-0e24-463b-4591-08da5f8d7d35
X-MS-TrafficTypeDiagnostic: SN6PR10MB2847:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYt59aYAkipYi4MCU/vEpojZCXRCXLqEu++Nmv6WlOqlrU1us5xWNHcjFwnaCvtgShY5VtDFIQ0844b0Vy0+pQWRvfMzk1SLRFX1RwXhO1pPltnV6whLeZM4KVVhqv8Gi2nMF5aloX8RAsGKQttDkqiJ0eahp5tewocw56fvrG1FEAu49JhL6p+OZaweT3S+FJlHHl35+PR2JMRPdBSE4nsgQ0MhVf3fG4vklNGo1K1INdvAdj+bHr91y9XEN9l6N29qQBAoA/unA1I1iWQy5VfEn6eNz4so4EF2vrZ/Nzb+N6za4CrZzVHD18BfPNZgk2I4RxubCKzk6DrSJ7Decw9IML5zQKBwAdaVx0eSece+bXApdQUzqdcpHsMpw0CXJ45TBJIjkb10U5zPdEUxqS1dZ96YMbschfFLWqTyVAmzwgZbmubHDn3GTsOxWIPTt5IEOVKuVVMP6JRxQsS7g9+wpLEbR3YSfzqDqIFCG/2QSqBIexHYhUzwGRqwbn9ecuqyhn4HIyVoBAEqdHeyBTrrwa4fFzjKk8xHdJRpOOdqcJFJNGv8pUxKn5nOGamAGnxqWWJ0b4EUb6i3JkB02FTotAy/o6fVI28QyllMCftyDQzBx4/2b289w3P659iX5+xNa8I7muRR22M3Od9xhpu9gtDngsa3UP15bESYEkC1t32Spz0ldNTRiLZM4rp8G6KgMBtTMnL2VV/bvUWGQJsNb0bxoFyuKaKBKiTQSxJPD/m0FaV8NvQHeOBPuSVK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(39860400002)(346002)(136003)(7416002)(478600001)(8936002)(5660300002)(6506007)(2906002)(66476007)(41300700001)(30864003)(6666004)(8676002)(4326008)(66556008)(38100700002)(54906003)(44832011)(36756003)(26005)(186003)(6486002)(6512007)(86362001)(1076003)(2616005)(107886003)(83380400001)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mf9ac1QN80DJYyoNmGBGg/1niC0hTbpbjOkPlkyjlOSTsM1Mu7V2UNSk3WE?=
 =?us-ascii?Q?CnrU/7ka/spNWz+1KNzIb75gctfnNP/UPhnrJKRL/h1fx9j4itXyLUke+Xbk?=
 =?us-ascii?Q?NAeKV2JUDbP2r82UBbJJu8k073YP4o7kQKQDlNqN2Ont+Xduipv0PZZ+P7YJ?=
 =?us-ascii?Q?IKtnkvr97pMaNwv+QVNGrt6WvoJJNUv9CBI4H3ss9Hn+btxfC8RloNLNyGKP?=
 =?us-ascii?Q?rircmlTjQ2MGlZrYzEM2ZOkXGeZDRHzcVTrPtyHNle8ER72aQwIM9ewauanl?=
 =?us-ascii?Q?X9wFLYiFFOs1cTKDQtni1tBKBG30gE//M6YFyMo0+5FLzBZSG9XLrtnX6m+1?=
 =?us-ascii?Q?EIuccV14pm0PFX/JLMqfBnAS/Un8NGxNzxm2dHrBtk0FQJjrZ+vP3ysHZ5Wz?=
 =?us-ascii?Q?4S/Ycv3n55BYG5SMcugIyXVFPDZmO40pBHM1XFeL7nUz6PnTu48hr4CaTdUj?=
 =?us-ascii?Q?KGhqD4NO/gbZS4zJXIKZgSGzS2lqY2CkLRXh2D0LXDjxcagGKUl7T5lZb7da?=
 =?us-ascii?Q?giT9DVV3U1H1hmawoWzVMNP+m4eY5TEdC76WVq1WYvd8WDn9JrG0sdug8/Gx?=
 =?us-ascii?Q?nawji+zYflE9n7ORHJ/ds6zgW+h7cN/h4QuxEvuwp4JpYPpaakIxapTosPZL?=
 =?us-ascii?Q?0+ess7yxliFxi5rqxo/DlOu1EsOdnn+pbCsyrO9klCamp0oX0HXomc4qzZuy?=
 =?us-ascii?Q?w999W0SAIHBFoS8cyZMrfBmJS4/+Ke89M61eX2af9Lq6txLFkyoIigsurM+n?=
 =?us-ascii?Q?8ABCRkc9OibiaQVlsEZozA9SN65dNzP1QgBw5SadNC9zRX/cpRX/PEQpEAdw?=
 =?us-ascii?Q?005F8MvvuSCcTJga/byGHNlG6sWJYCtHv6SSSSl5LHBpZyxppOfE6HclDaV0?=
 =?us-ascii?Q?TsCl+VPBV6oHZcFtlU48klno1iXP0ZK1ESWB57dTr52hX7UwKiLqrZLM8pB9?=
 =?us-ascii?Q?fWxFS3HV2bF40xK/xkF4vIEAU3v4Eop4GvMba1hJkVphiFWyWjxq2Ot8W5eL?=
 =?us-ascii?Q?2khcMgnfWgTNXvCuDQ6br+/YdYqyqxoaqVa/4wg7AkhFPavs6atqNR1LT4e8?=
 =?us-ascii?Q?T78JfPLgEfWYqv3ECGLuSvgfHA5a/uGJGFxufaQA4K/pGUHfsUvTiqTG/KWT?=
 =?us-ascii?Q?R9BBQd4DJgDvTFdH23skSV4ESjA5WGU35L2MPFbcPBgT9D77ryhaQOk5ipOT?=
 =?us-ascii?Q?tFh51WFTl95VpZd9tZB9aDoyyopmYXCSOd07wXKouTBwgnnybbqtc7XIWeck?=
 =?us-ascii?Q?EMSM2LsXYqa708NK+ZIlwR575/PvU5cwaJUfUt66exZ9+NS1QcjJdMw4XpcY?=
 =?us-ascii?Q?Z1CmDmpqP486DZTGlUtA6Wgucm6DZWGvFpufK9sspsm4Veo7OpxMPib0x3Xd?=
 =?us-ascii?Q?Dd7XFU3G817qvNs/JVhzzR7BQ9pHwZ5vHWVcK0xH0JbbTLsJePNJ9qRLUT6J?=
 =?us-ascii?Q?9vUY5WFAnimY7JZUccWVH1K/4y4JbwhtwhPr3XYo0q/H1P1jdgJFrBTQVB9F?=
 =?us-ascii?Q?RQl9f/x1Rc9NCDdHb9Ufq2HIGkSFQ5VYmbgrRJopKH+DAFJ3wtAFK5ZzNlrQ?=
 =?us-ascii?Q?zx6gXenIoWpXZsrrCjAFECmdQ8tgvOaXkVLPEjhxOAgBRPwIeO0z9dVc2d7r?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f920a3e-0e24-463b-4591-08da5f8d7d35
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:12.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnHYF7ilWzZ/WlN4gccWR+4ZRi1f++KFYL0StX6QxogVWZmNb9Rjnl72tYe/1V6qR0wMrXpAp7QOMV19gHFZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2847
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: SemIWkYUidxhvrtC98oMonnVJegBP_FC
X-Proofpoint-ORIG-GUID: SemIWkYUidxhvrtC98oMonnVJegBP_FC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hugetlb vma lock (rw semaphore) is used to address this race:

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
sharing process or worse                        i_mmap_unlock_write
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

The vma_lock is used as follows:
- During fault processing. the lock is acquired in read mode before
  doing a page table lock and allocation (huge_pte_alloc).  The lock is
  held until code is finished with the page table entry (ptep).
- The lock must be held in write mode whenever huge_pmd_unshare is
  called.

Lock ordering issues come into play when unmapping a page from all
vmas mapping the page.  The i_mmap_rwsem must be held to search for the
vmas, and the vma lock must be held before calling unmap which will
call huge_pmd_unshare.  This is done today in:
- try_to_migrate_one and try_to_unmap_ for page migration and memory
  error handling.  In these routines we 'try' to obtain the vma lock and
  fail to unmap if unsuccessful.  Calling routines already deal with the
  failure of unmapping.
- hugetlb_vmdelete_list for truncation and hole punch.  This routine
  also tries to acquire the vma lock.  If it fails, it skips the
  unmapping.  However, we can not have file truncation or hole punch
  fail because of contention.  After hugetlb_vmdelete_list, truncation
  and hole punch call remove_inode_hugepages.  remove_inode_hugepages
  check for mapped pages and call hugetlb_unmap_file_page to unmap them.
  hugetlb_unmap_file_page is designed to drop locks and reacquire in the
  correct order to guarantee unmap success.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 45 ++++++++++++++++++++
 mm/hugetlb.c         | 76 ++++++++++++++++++++++++++++++----
 mm/memory.c          |  2 +
 mm/rmap.c            | 99 ++++++++++++++++++++++++++++----------------
 mm/userfaultfd.c     |  9 +++-
 5 files changed, 186 insertions(+), 45 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0eac0ea2a245..be0a5073766f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -459,6 +459,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 					struct folio *folio, pgoff_t index)
 {
 	struct rb_root_cached *root = &mapping->i_mmap;
+	unsigned long skipped_vm_start;
+	struct mm_struct *skipped_mm;
 	struct page *page = &folio->page;
 	struct vm_area_struct *vma;
 	unsigned long v_start;
@@ -469,6 +471,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 	end = ((index + 1) * pages_per_huge_page(h));
 
 	i_mmap_lock_write(mapping);
+retry:
+	skipped_mm = NULL;
 
 	vma_interval_tree_foreach(vma, root, start, end - 1) {
 		v_start = vma_offset_start(vma, start);
@@ -477,11 +481,48 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
 			continue;
 
+		if (!hugetlb_vma_trylock_write(vma)) {
+			/*
+			 * If we can not get vma lock, we need to drop
+			 * immap_sema and take locks in order.
+			 */
+			skipped_vm_start = vma->vm_start;
+			skipped_mm = vma->vm_mm;
+			/* grab mm-struct as we will be dropping i_mmap_sema */
+			mmgrab(skipped_mm);
+			break;
+		}
+
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
 	}
 
 	i_mmap_unlock_write(mapping);
+
+	if (skipped_mm) {
+		mmap_read_lock(skipped_mm);
+		mmdrop(skipped_mm);
+		vma = find_vma(skipped_mm, skipped_vm_start);
+		if (!vma || vma->vm_file->f_mapping != mapping ||
+					vma->vm_start != skipped_vm_start ||
+					!is_vm_hugetlb_page(vma)) {
+			mmap_read_unlock(skipped_mm);
+			goto retry;
+		}
+
+		hugetlb_vma_lock_write(vma);
+		i_mmap_lock_write(mapping);
+		mmap_read_unlock(skipped_mm);
+
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
+				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
+
+		goto retry;
+	}
 }
 
 static void
@@ -499,11 +540,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		unsigned long v_start;
 		unsigned long v_end;
 
+		if (!hugetlb_vma_trylock_write(vma))
+			continue;
+
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				     NULL, zap_flags);
+		hugetlb_vma_unlock_write(vma);
 	}
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2eca89bb08ab..8369db31df13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4848,6 +4848,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
+	} else {
+		/*
+		 * For shared mappings the vma lock must be held before
+		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * returned ptep could go away if part of a shared pmd and
+		 * another thread calls huge_pmd_unshare.
+		 */
+		hugetlb_vma_lock_read(src_vma);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
@@ -4999,6 +5007,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
+	} else {
+		hugetlb_vma_unlock_read(src_vma);
 	}
 
 	return ret;
@@ -5057,6 +5067,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	/* Prevent race with file truncation */
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
@@ -5088,6 +5099,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		flush_tlb_range(vma, old_end - len, old_end);
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
+	hugetlb_vma_unlock_write(vma);
 
 	return len + old_addr - old_end;
 }
@@ -5392,9 +5404,30 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
+			struct address_space *mapping = vma->vm_file->f_mapping;
+			pgoff_t idx;
+			u32 hash;
+
 			put_page(old_page);
 			BUG_ON(huge_pte_none(pte));
+			/*
+			 * Drop hugetlb_fault_mutex and vma_lock before
+			 * unmapping.  unmapping needs to hold vma_lock
+			 * in write mode.  Dropping vma_lock in read mode
+			 * here is OK as COW mappings do not interact with
+			 * PMD sharing.
+			 *
+			 * Reacquire both after unmap operation.
+			 */
+			idx = vma_hugecache_offset(h, vma, haddr);
+			hash = hugetlb_fault_mutex_hash(mapping, idx);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_vma_unlock_read(vma);
+
 			unmap_ref_private(mm, vma, old_page, haddr);
+
+			hugetlb_vma_lock_read(vma);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5563,14 +5596,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	};
 
 	/*
-	 * hugetlb_fault_mutex and i_mmap_rwsem must be
+	 * vma_lock and hugetlb_fault_mutex must be
 	 * dropped before handling userfault.  Reacquire
 	 * after handling fault to make calling code simpler.
 	 */
+	hugetlb_vma_unlock_read(vma);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	ret = handle_userfault(&vmf, reason);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	hugetlb_vma_lock_read(vma);
 
 	return ret;
 }
@@ -5821,6 +5856,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5828,23 +5868,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	mapping = vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
+	/*
+	 * Acquire vma lock before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
+	hugetlb_vma_lock_read(vma);
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+	if (!ptep) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		return VM_FAULT_OOM;
+	}
+
 	entry = huge_ptep_get(ptep);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry)) {
@@ -5908,6 +5960,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unlock_page(pagecache_page);
 			put_page(pagecache_page);
 		}
+		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
@@ -5951,6 +6004,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		put_page(pagecache_page);
 	}
 out_mutex:
+	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
@@ -6413,8 +6467,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
-	last_addr_mask = hugetlb_mask_last_page(h);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
+	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
 		ptep = huge_pte_offset(mm, address, psize);
@@ -6513,6 +6568,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -6890,6 +6946,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
@@ -7271,6 +7328,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
 		ptep = huge_pte_offset(mm, address, sz);
diff --git a/mm/memory.c b/mm/memory.c
index 8917bea2f0bc..3131766f9c7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1693,10 +1693,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
+				hugetlb_vma_lock_write(vma);
 				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end,
 							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
diff --git a/mm/rmap.c b/mm/rmap.c
index 64076c2a49c1..e1c19d86cea6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1557,24 +1557,38 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and fail
+			 * if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
@@ -1933,26 +1947,41 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and
+			 * fail if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
-
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3225b5f70bd8..1894e545a1a2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -377,16 +377,21 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex.
+		 * Serialize via vma_lock and hugetlb_fault_mutex.
+		 * vma_lock ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		hugetlb_vma_lock_read(dst_vma);
 
 		err = -ENOMEM;
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -394,6 +399,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -402,6 +408,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
+		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
 		cond_resched();
-- 
2.35.3

