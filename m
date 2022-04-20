Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164375092FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382928AbiDTWlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382895AbiDTWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D142A30
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBhbp009605;
        Wed, 20 Apr 2022 22:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=S+Lj0Un0XA7m4klVzSq+CKG30o15R40mxoXfO5MaODA=;
 b=pY/qXCQ5Yr7KTGuv+AStkbBeA1ATBe/9FlocR9yry0jtK6uPOLsXHVWk7E3jlB9/rUzy
 n0HX32awUOknteg6gvCx+CzKL3VWYy97EbFS+Kl+AffVisyJF73Kn/o5IZfbe3srj/MI
 DFkAdoFinQH2/lSDZHBPCZh6ymI/lULjyukgPum9LwgUqVfXOQVXk3ykLqe8TJ7I6sE2
 0PH8THC1f/MZ0PsE6wRZcp1oRugywxTbkNKa1lpxrYm2lvNy1Nw5ortoT4UDZsoZBJJe
 V9mUojxo+8g7fIzKVgkUeq804oqE9KHp8aobzuE1nOd1gF8ZJaKQxuN5iCXSiFsr7vWR lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2tg7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQ58x013168;
        Wed, 20 Apr 2022 22:38:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87vs4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehvsbC8jCHjL4NH00ndTJtrq89k3J8RMCmQei1yNE2j9aDbCJKziS/9JxWIYBeSByJ31Eyg58kDwnS0oaG5Lc1PsJvFg9MAth3Qrxswfq17U7Bf+ygu5oJ06HhCb/9cLMync7nk4gVddNIR7O/Q6HiFYOHMQPpqnEFUNfHHg36XR9jo5Uuyby6AuzAmlOIu6H7oQvNGh6vb0RJdmQZBpjs3CesYZ3sTayCJaQNmZWkIKIKMaN9CWfJiPPZl3FyFlevsww4ay5lTmkubwhQoq1RGbNBIb1FvBlQnQaKPZ2Nroe/NdH+9xAjdXi9kzxNpzPmsccKZhramwieOrGxTjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Lj0Un0XA7m4klVzSq+CKG30o15R40mxoXfO5MaODA=;
 b=eta2OJDKRCXwySP6B4rXQEBImonrQEjZe+RFx20x47VNiwxDgLh43mIJqyWj/BuVVA1RwMIpUn9yYKXxSiK+81vwbGIyeye/zRC5rbVVnI1IbKyO5kHMIRSWxDOrAppuq+YLjZT6Z6zbkXG/2fPgKm3u7HrqIXF2CQKnDWHs8OkMmluxqCGcyVaoJluUt5aNovvgLwhovmnvq11CxkFh7Q9+sdRYbVlN3wx8603qsAr/Reb4aAiITRJ6wzzxhrAoal8zQt0MGyOVbDZNRjNTsn62TZ6gCIae/++cFmaGFxHiIWMFap0RCkmio82gVtDp0ydZzrr94JSxsHwJt4MBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Lj0Un0XA7m4klVzSq+CKG30o15R40mxoXfO5MaODA=;
 b=EPlvRYyb13666V5dF3MBSmjs5gvgzSRx8ZfakaIaQajpCcMcSrB73XS0cIcYeKc76oXbiAEEG9VpVctwu075Vo26qDGrl6PmrlIH+FSsxnZE0ByqQ46nKKvnwwcUMjDfvbsHViqwCVKTM9dKkvFyU4Z6gVQEUQ2KvGyu7ghloBg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:15 +0000
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
Subject: [RFC PATCH v2 4/6] hugetlbfs: catch and handle truncate racing with page faults
Date:   Wed, 20 Apr 2022 15:37:51 -0700
Message-Id: <20220420223753.386645-5-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22661210-0259-4e4e-ff17-08da231e7579
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB45501B6341E3DA70C58BE3C9E2F59@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAkAIrJbeSfpxMli9+QkqMoP37jzwzmtd38j/vYKiEgvtxBAzLJuZjNds7CWlWVuJOuug/Mqr9WgIDD+JDV+J54YNt+Ua3bj+BAXvthkFyI0mmzCmfMAOtCijbgfoAbaM4qe9DNNJwhxMZgKtuiRTqzc9midUKGujO7uuC9dcVQQ0+KE5oN5yOMaVDkrs8eeTfB8afgB6xPECzFFuVC0GA7k6B36GpN8KGZgVE1d7NxGiDulWuZriqFYSzy9zZ+/XUpkd5TBTCQYbbwgcTX+nWvnU/+HKDQc9mjUSbmycIxURWjCg1xdY9KkJrh2joG2xgl1wpP+ulL2uqBx5tU9kjFD3GswQadznTN20btARgawa8arGhkE3JsadZoDWEGsXJ+aP2bHcIddIjt1T7WJjaICcI8EunI9SJ+X6E6k6haQ7fR1Z7sc6q5Y1gwSNeRvKl6S0N9g4MXJOaHl6aIB2JmhKi8KDg7kTZdD0It2NCx5ZE3rq2JgNqQHBI8oajCVVlLoHdjmBtb15QmqRJrQXl6EItBMOyubNBIs76XrT4YU+85qSejMPLHATuxb4sBvJc2CNb8q/0rFbzDMGvvo0cIVQNfSjuNSL/IKimViyzI2ux0zzTCt4lUOqZdhQe8a8taSIOezXUz+x2KHV9WSZqsDaJzgXfLkOG5JiVLS98GCSVgvuTUxGEg41nsxqCeKlxKAzf4tVmtNY04XiZ4+Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(508600001)(8936002)(54906003)(86362001)(316002)(30864003)(186003)(52116002)(66556008)(36756003)(83380400001)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(107886003)(4326008)(1076003)(5660300002)(2616005)(6666004)(66476007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CK3x5JrZ4wTYh0tfcNEPC9to5uKg88cw7BmL8DbJCd7XinN5XY12N3yxxKAq?=
 =?us-ascii?Q?FmE+pQt7scdn1Z+qX35DGtZCOOg06vfFmGo1ra0GVKPVke+h+8zHRGcw08h+?=
 =?us-ascii?Q?TNUJ5fzPgzbrl2+PyExKuCxVpHbCjAkRXlsDJBiNGlGfEAo0kIKPEKWRcibM?=
 =?us-ascii?Q?Bldk8mFSemM2Io73qgEHY3mtc32Eu1GiLmdkiXIIudesPFO9UtR4ZcCBAmcd?=
 =?us-ascii?Q?YE+raho19skpeCzTbHdyCmxYHbC+fDjzAS4KHSUnv6U8M+c3mRZiFjKGtjst?=
 =?us-ascii?Q?E3OfPsNy9O5RbNwo49ZSJ86nLPRS0aKOocsFTx+au5AZatDzGYzq2jmX/era?=
 =?us-ascii?Q?Kx+cruhYJPJ2TZj7pnzb5G7vlh8RxFG/s6bdYJS32x6YPBqsCwFc8JDr8i9S?=
 =?us-ascii?Q?qC12eFjwk2wXxXqX7Gp+K8EINdtVmxktYU+RFvw2P7zwlszDlpxC53Kl1qDq?=
 =?us-ascii?Q?oqlo4dHTccX+H0don2XHgL956xip4I+gqAHTH+DOt5HXhfYGC7/xe8wGIsCW?=
 =?us-ascii?Q?3Jbp/ldNGc8yF5nuOVX67Kgqi/RV5znMltnhLWJW5W3I65olQqW+Jjkda6w4?=
 =?us-ascii?Q?8wCvVZtfOjqh8EnVWohkHf9e+bsuwdwkAJjPBzVwgcNFMVXuC3Up2RN7SM13?=
 =?us-ascii?Q?w7uw3VGeAgA6rTnaAZtPdM/NlXh/HbuHY25vxpmdfuRk/PVBEWC5EyTfvech?=
 =?us-ascii?Q?OJUEESJf8ibTAbb9/R7o46Pz7ydL+75vj8UqDeKy2a3syEpivN6/dItwtMOz?=
 =?us-ascii?Q?dX0uq2gdftvz2eOGI14Aaj0FhXYNHbBBDet2nleF2jXluHIQj4Sxjw98AcMJ?=
 =?us-ascii?Q?e9jZiNZqDpAT1cSw1uIae/vjA47sI/tbBWisSwF4pj/ikZoJ3q60K06V0d2P?=
 =?us-ascii?Q?oWM2T9r9LQ2xIFhkITDQIq16xi1og+7Md6AdWN+l88W5mm2Xh3tVhjh60MJa?=
 =?us-ascii?Q?uVy0/nkdMLUTlHYFajZl/4CqVS7ljpMWnCXS8j2XibYSG7MpQPtKcAZDnJF4?=
 =?us-ascii?Q?1nijA7YsndhkHwv7ofPFMKkDtGwPMmN3XZ6FVLAFZWUWu0ixMGUAhoPBwGJv?=
 =?us-ascii?Q?kqmW9FXMwNB+lKUcfPrpovludf4fOw8ZHvU7m6QWrNUMYpZ/LlWxUPaVX00F?=
 =?us-ascii?Q?3xts2kFai7utyAT96uLf+gtad2W5yNerVkr0+alwRXUWyH76loqdzGCqGAj2?=
 =?us-ascii?Q?ljnMA148UYJOx9FrX/v8YFXXSXVA0f7TW8LEg53IXNJinkOVjUaOS6eFk9wG?=
 =?us-ascii?Q?ziInvngcE0Za4iw8r6lO2iesVdJeZwOPAD7pV0X4XKdSD2l177Lf8Qt9euI3?=
 =?us-ascii?Q?hSYLpbokrUCRH86g08oOWa1rLOca+3/BC64M+YFge2S66HeXsUdpU4wZFpox?=
 =?us-ascii?Q?cwx4Ev/gD5VUJBS3VWOBhLN+QIBTg7+Z52Cf+WrDEkXLz3nQL5I/8ZsaOBoZ?=
 =?us-ascii?Q?9LyeNTtqtUSANpKMKO+7WCYMhcbnTCN2bJnRnsNk6okv3M+XYZpnAWOjdmpS?=
 =?us-ascii?Q?78G+/6Eqg2Ro/R7NcjyNORWjIMOya2ED1DibcyMVjWgDKWor6S1bizcdwdUI?=
 =?us-ascii?Q?FTAj0Rl/cgBBSO9rnQrek0mWys/0fTIlFrwfUheyv9LeOhiNR+BQ5KUA3LUc?=
 =?us-ascii?Q?OdjC3ju82w6YZ+E5U1UAydVizLwHO64Frv1Vu1GpCLH9ACSil2yuLSuRFhua?=
 =?us-ascii?Q?Q1s14CqDW/GlZZpuO6KScogzq9qsqv4pMaAmvfnOBjWiJMkEHYmNZc61KTz2?=
 =?us-ascii?Q?Zu525UaXKz1/S8PPiwAeUdKo0OmzcPI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22661210-0259-4e4e-ff17-08da231e7579
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:15.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKtMwEHtY9/d7SQmfGR+h2WopaRbEWquHtFHwH5G4eHcSN7ww3Fs6vJ1/utFYccV9bvel746fQelxZ92N85ptQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-GUID: jq1l1Q7xNQlIvHEmRA5JhZSmLrM22i83
X-Proofpoint-ORIG-GUID: jq1l1Q7xNQlIvHEmRA5JhZSmLrM22i83
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
code potentially removing a page from the cache after the page was
returned by pagevec_lookup and before locking the page.  This can be
discovered by a change in page_mapping() after taking page lock.  In
addition, this code must deal with fault code potentially consuming
and returning reservations.  Th synchronize this, remove_inode_hugepages
will not take the fault mutex for ALL indicies in the hole or truncated
range.  In this way, it KNOWS fault code has finished or will see the
updated file size.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 104 +++++++++++++++++++++++++++++++------------
 mm/hugetlb.c         |  39 ++++++++++++----
 2 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5e4bd2f1705f..d239646fa85d 100644
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
@@ -456,14 +455,26 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
+	u32 hash;
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
+	pgoff_t m_end = lm_end >> huge_page_shift(h);
+	pgoff_t m_start, m_index;
 	struct pagevec pvec;
 	pgoff_t next, index;
 	int i, freed = 0;
@@ -475,14 +486,33 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 		/*
 		 * When no more pages are found, we are done.
 		 */
-		if (!pagevec_lookup_range(&pvec, mapping, &next, end - 1))
+		m_start = next;
+		if (!pagevec_lookup_range(&pvec, mapping, &next, end - 1)) {
+			/*
+			 * To synchronize with faults, take fault mutex for
+			 * each index in range.
+			 */
+			for (m_index = m_start; m_index < m_end; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+						m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
 			break;
+		}
 
 		for (i = 0; i < pagevec_count(&pvec); ++i) {
 			struct page *page = pvec.pages[i];
-			u32 hash = 0;
 
 			index = page->index;
+			/* Take fault mutex for missing pages before index */
+			for (m_index = m_start; m_index < index; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+						m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
+			m_start = index + 1;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -491,13 +521,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * unmapped in caller.  Unmap (again) now after taking
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(page_mapped(page))) {
-				BUG_ON(truncate_op);
-
 				i_mmap_lock_write(mapping);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
@@ -508,27 +533,46 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			lock_page(page);
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
-			VM_BUG_ON(HPageRestoreReserve(page));
-			hugetlb_delete_from_page_cache(page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
+			if (page_mapping(page) == mapping) {
+				/*
+				 * We must free the huge page and remove from
+				 * page cache BEFORE removing the region/
+				 * reserve map (hugetlb_unreserve_pages).  In
+				 * rare out of memory conditions, removal of
+				 * the region/reserve map could fail.
+				 * Correspondingly, the subpool and global
+				 * reserve usage count can need to be adjusted.
+				 */
+				VM_BUG_ON(HPageRestoreReserve(page));
+				hugetlb_delete_from_page_cache(page);
+				freed++;
+				if (!truncate_op) {
+					if (unlikely(
+					    hugetlb_unreserve_pages(inode,
 							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
+						hugetlb_fix_reserve_counts(
+								inode);
+				}
 			}
-
 			unlock_page(page);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
+
+		if (!(next < end)) {
+			/* Will exit loop, take mutex for indicies up to end */
+			for (m_index = m_start; m_index < m_end; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+								m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
+		}
 	}
 
 	if (truncate_op)
@@ -538,8 +582,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
+	loff_t prev_size = i_size_read(inode);
 
-	remove_inode_hugepages(inode, 0, LLONG_MAX);
+	remove_inode_hugepages(inode, 0, LLONG_MAX, prev_size);
 
 	/*
 	 * Get the resv_map from the address space embedded in the inode.
@@ -559,6 +604,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	loff_t prev_size = i_size_read(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
@@ -569,7 +615,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
-	remove_inode_hugepages(inode, offset, LLONG_MAX);
+	remove_inode_hugepages(inode, offset, LLONG_MAX, prev_size);
 }
 
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
@@ -603,7 +649,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 					      hole_start >> PAGE_SHIFT,
 					      hole_end >> PAGE_SHIFT, 0);
 		i_mmap_unlock_write(mapping);
-		remove_inode_hugepages(inode, hole_start, hole_end);
+		remove_inode_hugepages(inode, hole_start, hole_end, hole_end);
 		inode_unlock(inode);
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d60997462df8..e02df3527a9c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5436,6 +5436,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool beyond_i_size = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5493,6 +5495,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(page, mapping, idx);
@@ -5551,8 +5555,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	/* If pte changed from under us, retry */
@@ -5597,10 +5603,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -5921,15 +5942,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
2.35.1

