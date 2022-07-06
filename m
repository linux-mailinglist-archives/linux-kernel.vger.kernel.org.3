Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6217569344
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiGFUYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiGFUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C517052
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Ijf04006141;
        Wed, 6 Jul 2022 20:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=te8H6FiW+ZCi1kHi4vnGpyWN3HEzotPXjbRd4dg6mzU=;
 b=TaXdFZcrNT+jH0wLXV6gL8n9BmEGt8hEzRC2j4tQ1M8KXifbzxMwH69Qc8VA/D4MoW2r
 aa4vppCGitV/cidQagqyTxjKO6niKUD1nZ+oYFC7fh3KTOn3v4NT4EcCe2uJAwqyyRys
 miCkOlfzX0Hwq+HJD7qLC3OUlmje5eY/a77/g7idj79WpKxVc3cLHEJ8hllpsnn1WwYe
 i2aLfU8XFqeAsP6SzDrDZIBylPJAw6WrCG21AIyyta+W+9seSDFxR/reo5iXh2LK7D+A
 ZqGkgu2N7mPlLu8Iax0xIeR0f9Y83D9PW/Ir5VCOVkzd/zcw5MrF01d1l8bztY0qFjJj Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyu6vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLH6w015962;
        Wed, 6 Jul 2022 20:24:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud56ec6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stz45zuajHqqVxA1A27a7WlAxuwnEUoHYuXwXzCxSUWIPkJESgRSb7qK0BKHZtDPtdMY7gE1xtfb/35c5pxp+YdFOu/n985LIrrGVh3GdMAdoeIukg9xJ7efLSWtbYNTYLoA7xK3mZHiGuqL6p/ug12WvHt93gzCMJG/FXeYDNSBgoJKWayWfklXsmTaURm+XDwQFTIlgm6aWFd+a2TXQuCPfICESQcXGC51+u4lnZfW4z/YOJRq1o+Vk3vLT4+OoXILKWmp77N1T8Tjt2nARjLEUuWmvJzOooQ4ZzGE9MBUXPPzB1Adgti9DDd/W521cSnfnb4zVB6vLuFmVas+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te8H6FiW+ZCi1kHi4vnGpyWN3HEzotPXjbRd4dg6mzU=;
 b=F+0G3cN2mnymmQHsBOx6+KA0Vh1hEoNmLzitXzfY5OLnYecS60xLHyyP0tt2D6wXHYwCpuFiH0I71bTKy50KLnPzJxqsZum8/FNXQx/fyZLnmR7Bq3kj9qn5SR6TtuK3R+m9AZ+rKeRA4KeR1yvPxnbBoz3tdjVoFbMu4VsSeXTG56wtA02WL4zpXY8UKg76iKly4Zzj5loUv54Wl98wo+HiZRVFzFJMXvEDAkcLfZ6NrVHMK9wDtLXEQPPSaVNXgTXpRKjpIf/85ErXVvKyVGt2QPFbvLGR1aiBLZR3MLzlq8+MiW03vEoOkLkBOL87Dpku2jUdIi8zvaWooaLrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te8H6FiW+ZCi1kHi4vnGpyWN3HEzotPXjbRd4dg6mzU=;
 b=MlXLSBQSMvinx4NWkCaMNfj8+5z2Ye88jQJJQkX9dCgVcEh4vEKugolKicR886UVLHBtnYsKkOyLJFy96mXcmPdWibYTNK6pPcUeJ2M+Yq+6q2tg7Ud4UIwuEVD5EZ4NA4LHGLeudgrLiBYbmrzDmyKmZ+e0L6B3JtsmJ5Kk5Nw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:24:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:03 +0000
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
Subject: [RFC PATCH v4 4/8] hugetlbfs: catch and handle truncate racing with page faults
Date:   Wed,  6 Jul 2022 13:23:43 -0700
Message-Id: <20220706202347.95150-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:300:ad::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edaea703-4ec4-47c2-f861-08da5f8d77a4
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1U1NCopZrz6U8SqzBHuXLiY/l4Ed6Nqfj85/keWvrlt4eD1p7SZVhu7sekhUsgvrB79t8AlrjS+C9h0IXR04yJElupTxn5MdQA2h1+Tjfuloft5GrS/ZaCFy+8RSNv7gbKgk/OzEVfAfdb30jShaPlT7vl3xb4kj9u+JR2Al6zkHU7xCcLjCtV0eVnAhLvB2+K6t0bVDKs/wAYfMH10K62K28d0qiSRyLlzGXZlCm6u3BJyHQTP5+CuClQtQObQUinQ8Ih/xgteWMvGuQ3KGC5/k60dBXiukCOluWhC7bGol1iiUEZPREbjodW2kAqgIwXY3IgJgrKOqGAy4KBGJ/GoujmFTIrTvLsJec2EwiqBHsb+3h33GIEEsrxq79ZPqqh4iZ3rApm7Dzh6IkVMxJPogTWWmJr4FNmrsq5el2LfEagz5A68dZCLHdpB52zf7rTOdMtSEvfaUnTklruuwzz1PKnUUmtdV+nuUEAsteCjOxENPf/fxmMjCGlbUB8qYTxZRkRpFZiXcpp7DU+/y3Ll4XgVAJ0ZDZr2Ji14jDD9Zhz0XkJukrFjLNVnT3Wgg3BDnJUQ8EEW6ugX/OOz9DG5m/OK30pkCCdwHGcWNprGBGaVnXNIJthIkHDLBa1LXswwbUeuAdRDyEbyAUKHF3ZsAjn9entmLU0Jjxh+iRnpFY41UplFzkn5gUqHWUVTxguIWfEErHDRVOOQTK3tCskgADhk/c5GAMiSXg9rBOcXpTV+WltwPbuDGhtrCrQzY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(30864003)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9I/e0Xl9YWpDRY0jCbQKBrjPdibLEmM3YZN4ps3J8jJsSr+sF6PMRDBBEhJ?=
 =?us-ascii?Q?gGGKj4Af8dB6FOxVxw63nmuc2jGNERDUVbcIU/E/GkN530o5+fl6sUBYrL6m?=
 =?us-ascii?Q?sIMWLBq41Yjh3DN5WsyriEBgroqQsN526qtlqp03zOS10FapkP+FvX0OO23c?=
 =?us-ascii?Q?2S4zjsRGOWSt67SoARhXLBK/xJWudcQJOXWeLOayVhAa1ohhLsKBYG/xkZ36?=
 =?us-ascii?Q?ro0gyP3KwmAU2YhcXglH3XCMREPl16gRpn02D4jmNixWEo4bKwY0XqRqSnhm?=
 =?us-ascii?Q?HJYByzXSY7D1TCq7TBcxgOEXBmmABxs1MPOF88Q60EWn0s0RcGq7cS/Jayu8?=
 =?us-ascii?Q?KKodu1/aPro6sNFSqimp8wCRqGAUxmeuTv0zxSo8Kr0G9uxtc0a9MjbXuEtF?=
 =?us-ascii?Q?yeXDCv+hT1u+OA9o4vVOXZMoUh2AECg7EHWyVMho8zIUptGB1YkLB+7IsKsP?=
 =?us-ascii?Q?+UAugexzkrl8KN+bjFSYFbk/fw2x8+WMnSNLzajewizioRmRy53mfTy814rp?=
 =?us-ascii?Q?IjZBEgn1VWvOEsvM1L6DuDQ6juTXezQiLER1wro6MxWArRsdYuL4fdIyeM5x?=
 =?us-ascii?Q?DIO3GuORrPGQ5H8kF/GRGdUUg4MakJ7Rhx7ZH0ybAWUBh6Jz1DXDyotTwVdh?=
 =?us-ascii?Q?Ypc44gbxAn3bqPtunU5K76CG7w7w/OV4QkXoTRQmuwDqPc6zLNIAeumX8Tp1?=
 =?us-ascii?Q?riSEEW4H1ze6KDoAIigLRU3x3zgvbq8bQoZPl3xHf37cwA9QjoKQvnENcETR?=
 =?us-ascii?Q?K1ur5Mod/HiCfQ2VbicWYO0ydmbbY3F7B+ox2zL4GsuuWTjIXidAsnPrIlH2?=
 =?us-ascii?Q?k92v7S5tHvr6vlg7TFryo+x/B0QiQrq5i9n8XFnkwQ+4ASOMaFdfgS01xKu+?=
 =?us-ascii?Q?wTgNgocIFmLgY3w4eCG55ZbT3cyxzlzBLl1Y51zPkrMROjYKNAbH+dHf9xmm?=
 =?us-ascii?Q?rS8jAlGrUPAU/LHVZplxWAhWQ9cuhTwJEn1e6mKTblINml6t0+RhBGVjs+R1?=
 =?us-ascii?Q?Xqn0ywx45cLrqYfbI7cZlFUh6Z/uinieDiErAByrULpHlScdRwgkF8QjYGSz?=
 =?us-ascii?Q?i9fTzg3c22HQ6vy6/V/IMt/Bq48PPPJcTRBaNLHjv8spYiA7T93mDFC9jxkd?=
 =?us-ascii?Q?YmnF0c5XQYKqufdot4U3utWwovHcBC+ZSAqldC29FQa2Vw8r+Zp8lC0QAuOX?=
 =?us-ascii?Q?k2MH9zOEujIXxaArUbXsoJb3kqLTFJzt1PKFUknPmOUeot28HclQhl2tX4Wu?=
 =?us-ascii?Q?LnVjDGtT+7rTE0AmqqWB1+9MyQ4jKvBio03tL42AHmGRhNFn940meVcnLNcF?=
 =?us-ascii?Q?8ChUqy7Zuv/QmgMs+tufJISq2UwtK2r22AXdRityj8J7BmIZwqVR5Pr9WMP1?=
 =?us-ascii?Q?Woqar4gQ0lZz/EwogFAuM5jLey76Lq/cVGUwF9m8EKqOc8l1R01A+DsvjGKa?=
 =?us-ascii?Q?cQuQRqlI0t2Z7nJRJEo/t5LRXW3jpZxjKZoK8vh+f8cqpJHklGm6na/0ltCT?=
 =?us-ascii?Q?wx6ZelWSYuU8Ni9ee9BNfheQa//7BswK1IQSXl+vM+6TMUmfUI+qOS4ogbnr?=
 =?us-ascii?Q?MftkYHiAUgW++II1+SimEU8Og4faVakVEpA8gkIcgnuLQS0/NwruklU6Scpg?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaea703-4ec4-47c2-f861-08da5f8d77a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:03.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLl6r8Xe7UdZOxfX8ESjBp/OFiTG7mJmNxaYBucT8Gqmy27z8sykL9zMoUPIGbKdR4rfbiS+ZnpUaMHRE+xb4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-ORIG-GUID: CSXnD4FdLKUL8bBUV4Oux3Y6KSCL7Xg2
X-Proofpoint-GUID: CSXnD4FdLKUL8bBUV4Oux3Y6KSCL7Xg2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most hugetlb fault handling code checks for faults beyond i_size.
While there are early checks in the code paths, the most difficult
to handle are those discovered after taking the page table lock.
At this point, we have possibly allocated a page and consumed
associated reservations and possibly added the page to the page cache.

When discovering a fault beyond i_size, be sure to:
- Remove the page from page cache, else it will sit there until the
  file is removed.
- Do not restore any reservation for the page consumed.  Otherwise
  there will be an outstanding reservation for an offset beyond the
  end of file.

The 'truncation' code in remove_inode_hugepages must deal with fault
code potentially removing a page/folio from the cache after the page was
returned by filemap_get_folios and before locking the page.  This can be
discovered by a change in folio_mapping() after taking folio lock.  In
addition, this code must deal with fault code potentially consuming
and returning reservations.  To synchronize this, remove_inode_hugepages
will now take the fault mutex for ALL indices in the hole or truncated
range.  In this way, it KNOWS fault code has finished with the page/index
OR fault code will see the updated file size.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 88 ++++++++++++++++++++++++++++++--------------
 mm/hugetlb.c         | 39 +++++++++++++++-----
 2 files changed, 90 insertions(+), 37 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a878c672cf6d..31bd4325fce5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -443,11 +443,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
- *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() prevents page faults in the
- *	truncated range.  It checks i_size before allocation, and again after
- *	with the page table lock for the page held.  The same lock must be
- *	acquired to unmap a page.
+ *	maps and global counts.  Page faults can race with truncation.
+ *	During faults, hugetlb_no_page() checks i_size before page allocation,
+ *	and again after	obtaining page table lock.  It will 'back out'
+ *	allocations in the truncated range.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -456,27 +455,46 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  *	This is indicated if we find a mapped page.
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
+ *
+ * Since page faults can race with this routine, care must be taken as both
+ * modify huge page reservation data.  To somewhat synchronize these operations
+ * the hugetlb fault mutex is taken for EVERY index in the range to be hole
+ * punched or truncated.  In this way, we KNOW fault code will either have
+ * completed backout operations under the mutex, or fault code will see the
+ * updated file size and not allocate a page for offsets beyond truncated size.
+ * The parameter 'lm__end' indicates the offset of the end of hole or file
+ * before truncation.  For hole punch lm_end == lend.
  */
 static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
-				   loff_t lend)
+				   loff_t lend, loff_t lm_end)
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
+	pgoff_t m_end = lm_end >> huge_page_shift(h);
+	pgoff_t m_start, m_index;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
+	u32 hash;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = m_start = start;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
-			u32 hash = 0;
 
 			index = folio->index;
+			/* Take fault mutex for missing folios before index */
+			for (m_index = m_start; m_index < index; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+								m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
+			m_start = index + 1;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -485,13 +503,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * unmapped in caller.  Unmap (again) now after taking
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the folio.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(folio_mapped(folio))) {
-				BUG_ON(truncate_op);
-
 				i_mmap_lock_write(mapping);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
@@ -502,20 +515,30 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			folio_lock(folio);
 			/*
-			 * We must free the huge page and remove from page
-			 * cache BEFORE removing the region/reserve map
-			 * (hugetlb_unreserve_pages).  In rare out of memory
-			 * conditions, removal of the region/reserve map could
-			 * fail. Correspondingly, the subpool and global
-			 * reserve usage count can need to be adjusted.
+			 * After locking page, make sure mapping is the same.
+			 * We could have raced with page fault populate and
+			 * backout code.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			hugetlb_delete_from_page_cache(&folio->page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
+			if (folio_mapping(folio) == mapping) {
+				/*
+				 * We must free the folio and remove from
+				 * page cache BEFORE removing the region/
+				 * reserve map (hugetlb_unreserve_pages).  In
+				 * rare out of memory conditions, removal of
+				 * the region/reserve map could fail.
+				 * Correspondingly, the subpool and global
+				 * reserve usage count can need to be adjusted.
+				 */
+				VM_BUG_ON(HPageRestoreReserve(&folio->page));
+				hugetlb_delete_from_page_cache(&folio->page);
+				freed++;
+				if (!truncate_op) {
+					if (unlikely(
+						hugetlb_unreserve_pages(inode,
 							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
+						hugetlb_fix_reserve_counts(
+							inode);
+				}
 			}
 
 			folio_unlock(folio);
@@ -525,6 +548,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 		cond_resched();
 	}
 
+	/* Take fault mutex for missing folios at end of range */
+	for (m_index = m_start; m_index < m_end; m_index++) {
+		hash = hugetlb_fault_mutex_hash(mapping, m_index);
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	}
+
 	if (truncate_op)
 		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
 }
@@ -532,8 +562,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
+	loff_t prev_size = i_size_read(inode);
 
-	remove_inode_hugepages(inode, 0, LLONG_MAX);
+	remove_inode_hugepages(inode, 0, LLONG_MAX, prev_size);
 
 	/*
 	 * Get the resv_map from the address space embedded in the inode.
@@ -553,6 +584,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	loff_t prev_size = i_size_read(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
@@ -563,7 +595,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
-	remove_inode_hugepages(inode, offset, LLONG_MAX);
+	remove_inode_hugepages(inode, offset, LLONG_MAX, prev_size);
 }
 
 static void hugetlbfs_zero_partial_page(struct hstate *h,
@@ -635,7 +667,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Remove full pages from the file. */
 	if (hole_end > hole_start)
-		remove_inode_hugepages(inode, hole_start, hole_end);
+		remove_inode_hugepages(inode, hole_start, hole_end, hole_end);
 
 	inode_unlock(inode);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a9f320c676e4..25f644a3a981 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5491,6 +5491,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool beyond_i_size = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5548,6 +5550,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(page, mapping, idx);
@@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	/* If pte changed from under us, retry */
@@ -5652,10 +5658,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
+	if (new_page) {
+		if (new_pagecache_page)
+			hugetlb_delete_from_page_cache(page);
+
+		/*
+		 * If reserve was consumed, make sure flag is set so that it
+		 * will be restored in free_huge_page().
+		 */
+		if (reserve_alloc)
+			SetHPageRestoreReserve(page);
+
+		/*
+		 * Do not restore reserve map entries beyond i_size.
+		 * Otherwise, there will be leaks when the file is removed.
+		 */
+		if (!beyond_i_size)
+			restore_reserve_on_error(h, vma, haddr, page);
+	}
 	unlock_page(page);
-	/* restore reserve for newly allocated pages not in page cache */
-	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
 	put_page(page);
 	goto out;
 }
@@ -5975,15 +5996,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * Recheck the i_size after holding PT lock to make sure not
 	 * to leave any page mapped (as page_mapped()) beyond the end
 	 * of the i_size (remove_inode_hugepages() is strict about
-	 * enforcing that). If we bail out here, we'll also leave a
-	 * page in the radix tree in the vm_shared case beyond the end
-	 * of the i_size, but remove_inode_hugepages() will take care
-	 * of it as soon as we drop the hugetlb_fault_mutex_table.
+	 * enforcing that). If we bail out here, remove the page
+	 * added to the radix tree.
 	 */
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
 	ret = -EFAULT;
-	if (idx >= size)
+	if (idx >= size) {
+		hugetlb_delete_from_page_cache(page);
 		goto out_release_unlock;
+	}
 
 	ret = -EEXIST;
 	/*
-- 
2.35.3

