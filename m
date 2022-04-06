Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92474F6CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiDFVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiDFVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB9169B3E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JwOCB024505;
        Wed, 6 Apr 2022 20:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=0XY7zY6ntq67oUzjau6R15h26yGx5JqSdiJFIknMbsg=;
 b=tkX7D/3KV7XvMsNXHKIPJzRW1KmqGPgYmEb2ox+S+a6jaGYjX0UW0+r81dNVs7/wJYOc
 AceUtoRfL3EcJlkKQNyuAf/S4lM48bHqkGNz1qaYtoBUv4dDxdsm9Ol6oT6Y3Y81E8Iw
 mwZ2G3BSxrtq0INNNJdW4kchWaD16vQxX2s9NYIpXjGKGihuny56Zh26L8Vlqw+sL8z6
 XOLQThbZ/uGFcxI4gsFrYEJqa55TU8BgbbCsRMMIsGHVnzstn7kE5sfoGpHusxrHZW0z
 lGTAiwqHTw6hCGz6/0qeRnt4ZwJVU3KqDMA4fmleuGRhEuFLaOu7CO4rW5WIGO57WAF0 ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1ta8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KkO4V013648;
        Wed, 6 Apr 2022 20:48:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqhmsh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCrcv43ScIowxQO4ztkczwnIzMN/nRbqYn65ptp/up/qI5gTggPaV1YP6eagx3jnyMHzDYAj6hWm/ph8oHtoI/QQQisfOOnGg7vxGVxMiwD0B5AlpcokpbUGvI1WLZn8YsA2h2kP06yhfx98efg3LR/ADgSCT+nyyR26n0zjiKveTTEVv25uKYNZ/KcpbosjJn4uqsoT9j+Iz0jGDOQFr2L3gy22pMR3gw3s8cvn+RlUgn6/XUpBdOdgDODwHLVcYgqwJCipgxhRRZH75te+YZzEKwXKjcTkwal05yj3fra09JjQRFk0E5Yyj/3B7aA5M6ETBQ+a4Z8oF2+mSthMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XY7zY6ntq67oUzjau6R15h26yGx5JqSdiJFIknMbsg=;
 b=byFkI6A/S+6h/9cMfT24yImeCjtAl8z+4h1Xj+cBxbEYMytI+u10+L9gdAaEpy8/3W2CjUIb/2rlc37kAb1bCFyUBfQFg2bI/kFuiqxchYvSjOwnGXghasFhLpLn8+XNiHqg/1WtQVosfWNReQS6V1TEoXFFX1lbVPqHSVb8dMDbx5z/mrpz2QLpeXuyYwjVJiqUn3KWL2KTluH9aLIcukJ9Kxeq1ZiP5NUya1k3BnTfwL8a955CmtjewY6LcjPw4GwASUEPiLUPNHURW6nhbS4lAR3ZCTu7nqjEFxdCpSKQIBq2wJNgu26+aKKFPJrGTxIUbHawMyvP+AxZGsMyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XY7zY6ntq67oUzjau6R15h26yGx5JqSdiJFIknMbsg=;
 b=Xogq+E0TD/dFCRVZ/3jR+JjvBAgFj6emp3MNah0IJf6BZACYCArUKJ7kMQQ1wGDQK0Db94/I/LQZ7wmafMxWeXxBXEBJRt/d+B2w99LmAOfLJXiVzQuiuAE8kto0LQy8/LNz31TeVHWGTO8Fij674RL6BA0RFpmtChAh7AIY8UQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1909.namprd10.prod.outlook.com (2603:10b6:903:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:39 +0000
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
Subject: [RFC PATCH 1/5] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Wed,  6 Apr 2022 13:48:19 -0700
Message-Id: <20220406204823.46548-2-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5aa08e16-3020-457b-b99a-08da180ed412
X-MS-TrafficTypeDiagnostic: CY4PR10MB1909:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19093C540D50EDDAE02239C1E2E79@CY4PR10MB1909.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TLsJc0UVE6yV/jqqk4Fe2R7j+rGVsg5O6fqn6a5v9w0qhFAFDtCq2qKA5A/DYcoCLF0V498BC4MX8PoxUaH7CI2zGR68+hJj4AbtHJuEIUAcE4A86JmZwd4eDG6+h3o6Oj6PpbGnYMlW28Ml9j0kIpRH4X41Rg4peam8DwBuIPy/rIrf2YaVqZGrqva/pIFstGqGacRLfYKCKpnzlgznNMs20vIf8hwoNmESqszWqA5oXUwMx53xPGK0N6uXXLix80kw9TEQHVjw5vb3S/eg7/v5imu0bC1DcYsRauEdQpmWstLJC8zq8shS7geE6XTqsxgC+6uaQhKvqIdlM+boinm5VBocHj/ISJ6YIcp7qJewkAimSq62azQpNGJCsiphVFkADJb9oidU/TTZeycpXj6c+9XkOfs+TQWUXxli7CR/3lFp7RSWh6+NMBZh+9apdqz2mm3o3K1IE41IO2wGJOU1vTpcK9f++Zybt3p1xUREQOjZtEJZwpUsWC4Vpe6LhEp3sql/LOUvm0SH5UrnTP7r591qFK3zAeUaFVL4WCiAmUwcP8AOD5EKcQeUC0OHXp1I2RI8dJiDj3vvS7IMynTQsMu4QKcr01mYpPbzHsgtbs+RUL/jn+x38Cdat6r62AhkFeBEUxk7PuCRQa7q9j3raUz7ineDuxOqXRQ9FnAW9fgSlx7RjGPFsvSzlbR9zLHf12kyxwSnbY9jIuW9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(54906003)(2906002)(26005)(6512007)(52116002)(66476007)(66946007)(4326008)(66556008)(83380400001)(316002)(186003)(6666004)(8676002)(38350700002)(8936002)(86362001)(508600001)(1076003)(6506007)(7416002)(44832011)(36756003)(6486002)(5660300002)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K68gWHZcpuih4gXEAGQCd18UwmqpYJ6DFTU42+z0WVyTYeAHpWmcl4/cIFxO?=
 =?us-ascii?Q?1hYsLAXcxU5yq8lQtctwFC3b0ufjZBwmaVyNxmBPrHcoZnEmRTv/aI44rOez?=
 =?us-ascii?Q?xXKrWa7CWVSa3YZSctz5JdJwL09asB5125Bt7AU++Frsl3xBo2gw2XvK8GcG?=
 =?us-ascii?Q?YpJ9+ExuHWMnWPCk1wwsn10RGns5VWPqwWIrEPJrJ6j8nuL3wiB4to3jVynw?=
 =?us-ascii?Q?1xQfPlxz23UgVXf2BKYgpcfGUsiJqS/Td1hXYqvR5DpUasusxiKZe0Edc//X?=
 =?us-ascii?Q?smhXlXJ9UWQkXQqA3kmLnnJKGCC3fI8jv6lG5R5hm6B1pP03NfHVgRSsYWHJ?=
 =?us-ascii?Q?jiU6g2afnEbXZScwGj56nvXpqY1nu6k1GVsZbiGKo/yi/P90Rmt/iIlbyXLR?=
 =?us-ascii?Q?oXJB7/kntIvaE3t7lAOGHg+l5pf7p8X4iA2aCoKW8Bmx4C3EsXOTbH5FLc65?=
 =?us-ascii?Q?u0jHRHiBff9EAouXdlXIMkWw4apQXdY68Nb25fkUD5JhNNKqjHBiEmSwW7pn?=
 =?us-ascii?Q?t6H0lUQrvstFE+ot4QLbIvzFP4OvO/x3yzXXnOWug6Rl8LbmZj+w7RDWDD62?=
 =?us-ascii?Q?5XxLAYDdBtqT+3Tq6eCOc93P77Grg7CPIB1GsHVzrsBGDjwUNb7yCNlNGlkA?=
 =?us-ascii?Q?opSH8wsFJq43UekiiSbadtB5EZLOs4QARKEJGWI6bS7txZb9tyDK0pTD9pAv?=
 =?us-ascii?Q?BO7ZZ92aIo0+QM/xbuUIPzwAEmHbpKo9nf8z4EcLO9G6tRViQGpd1OjuPlx6?=
 =?us-ascii?Q?pwbgFZJHfHd7gebsNQ6M7qfeSqktSJExAwv3zsT2htSU6iYQ6AWjU3e9RSSd?=
 =?us-ascii?Q?hh4XqaNr6a8/vu88I1qyguWUDoMcand7CaAuqkbDK3OuWQbjlwgJjpJ1Rs9s?=
 =?us-ascii?Q?COIsTs/cpVfdxnZ6Z0tagthqLLV5J6w0kBTyz4YrH+IcMPHRGuCaLL6YwCUq?=
 =?us-ascii?Q?CFOPvtEW0iWDykrk5aEC37AweLdH1cgFEgG+yjZQFQ2lA+ZTPy7M1sP1UtJp?=
 =?us-ascii?Q?7pGFFWvxOLRsPj53vaL0c+6wY3LhZoZ2nMCatrP01R+Ygx6sigJAQ4h177C6?=
 =?us-ascii?Q?6A1h1Vmaza3oZvkytwHqWVxHoI6WFkz03p05MxIZjUTedd6fLVn/WKUgbQ00?=
 =?us-ascii?Q?WXuC5hMvT1ThjwnVBhO87Lw/CvFgMbaqhuEoZuBmHyJAl//WZfsilC6FKvuB?=
 =?us-ascii?Q?qCuh4LN5itb4rQWEN6+6kMn7qHfgNw09FlzNQsE9M/+1j5bavhfHDa8t/mEJ?=
 =?us-ascii?Q?9QbUs+DCvK2NSMP7QcDygit+2OtCYUw2iIpDIbGI15VuG+SUYMQdnNNxrqet?=
 =?us-ascii?Q?lnWyT+5aKsQ/96Jo0m0zfPvxGZiBaS+bGZ4UqFokc3txr5AX+BMHD7C0ooNj?=
 =?us-ascii?Q?zG9EvhZlM7fgIi8YAXRSqpf9/bT00WEOQ3jS1e1GHe6EAGMBSg4nYap9YCD6?=
 =?us-ascii?Q?aUASECr/AawVckO3jAdgvzFNKgJFGeQWe81ixagcVeapd+FUvwjWl6MJ5iWl?=
 =?us-ascii?Q?yGtK0IKDZ/rJargRUJUrhb2EqfiVAwxIIEbA2dBCB+8UVtKjhnt7pTuOFSph?=
 =?us-ascii?Q?/gIagGqChP9ceX1khY11HaVET8zfQl698bH3+r0+xnqLpjVQPYabFnw693IC?=
 =?us-ascii?Q?HdUb5WIc34K700tc2a6K+JeM0sJpg0BW8Xs9pIAFBeMoQYwboKvGSrdC3cyP?=
 =?us-ascii?Q?LdrDphmjbBm5rfLng98PuWIpI9f6tR0YN6BDOCrsgfqufC3DEOMMkuKStxGg?=
 =?us-ascii?Q?M5DcoZocIb2MB7oPGhKjgynZ+2tkuNA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa08e16-3020-457b-b99a-08da180ed412
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:39.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPGO+Z+PLrqfTDipHOrAQ3T3X79pHjtgZ2QUEnZCuUMso3AnmmpCjXPtsJJOV7scLtqJHu34bk14sQC7R58aQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060103
X-Proofpoint-ORIG-GUID: JmJN8gwGYn35fu7oGYU5Zk0xEQ_giKac
X-Proofpoint-GUID: JmJN8gwGYn35fu7oGYU5Zk0xEQ_giKac
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  The use of i_mmap_rwsem to prevent
fault/truncate races depends on this.  However, this has been shown to
cause performance/scaling issues.  As a result, that code will be
reverted.  Since the use i_mmap_rwsem to address page fault/truncate races
depends on this, it must also be reverted.

In a subsequent patch, code will be added to detect the fault/truncate
race and back out operations as required.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 30 +++++++++---------------------
 mm/hugetlb.c         | 23 ++++++++++++-----------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a7c6c7498be0..e50de48c7707 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -450,9 +450,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
- *	page faults in the truncated range by checking i_size.  i_size is
- *	modified while holding i_mmap_rwsem.
+ *	in this routine.  hugetlb_no_page() prevents page faults in the
+ *	truncated range.  It checks i_size before allocation, and again after
+ *	with the page table lock for the page held.  The same lock must be
+ *	acquired to unmap a page.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -488,16 +489,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash = 0;
 
 			index = page->index;
-			if (!truncate_op) {
-				/*
-				 * Only need to hold the fault mutex in the
-				 * hole punch case.  This prevents races with
-				 * page faults.  Races are not possible in the
-				 * case of truncation.
-				 */
-				hash = hugetlb_fault_mutex_hash(mapping, index);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
-			}
+			hash = hugetlb_fault_mutex_hash(mapping, index);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
 			 * If page is mapped, it was faulted in after being
@@ -540,8 +533,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -579,8 +571,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
@@ -700,11 +692,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/*
-		 * fault mutex taken here, protects against fault path
-		 * and hole punch.  inode_lock previously taken protects
-		 * against truncation.
-		 */
+		/* mutex taken here, fault path and hole punch */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f294db835f4b..398b7742cc63 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5401,18 +5401,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * We can not race with truncation due to holding i_mmap_rwsem.
-	 * i_size is modified when holding i_mmap_rwsem, so check here
-	 * once for faults beyond end of file.
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
 	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto out;
-
 retry:
 	new_page = false;
 	page = find_lock_page(mapping, idx);
 	if (!page) {
+		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		if (idx >= size)
+			goto out;
+
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
 			ret = hugetlb_handle_userfault(vma, mapping, idx,
@@ -5502,6 +5501,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
@@ -5603,10 +5606,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This serves two purposes:
-	 * 1) It prevents huge_pmd_unshare from being called elsewhere
-	 *    and making the ptep no longer valid.
-	 * 2) It synchronizes us with i_size modifications during truncation.
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.35.1

