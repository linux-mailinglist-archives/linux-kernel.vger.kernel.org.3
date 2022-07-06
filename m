Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16D56933E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiGFUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGFUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EE18E04
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266ITxSt022853;
        Wed, 6 Jul 2022 20:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=S8ky+HpgCvtwJPQsoEGH4UhlCf9p48ZRt37tRuCVtNs=;
 b=sTAgq4qRMcatDhyAulbi+yftIxYwoWE75L1+NTiZOfJMD11ocZGlLjpx3EzBtLSozjhL
 cIKdh9qOR5hOIaOOk84DR8cgBtJg7P5zl07Oc3NcKe4FAzVjZ6CuwuFfMR4vAF7eLcIp
 LkBKPn91Rda6B51aQw97E4beS18JYG0te+nDEBJWp5phYVtRWsIo4yi5GmU6bwQ0buoL
 ZGzSKDGvj39uB5x78eeXO9rfFM7Fkq7VEYnHVA8ke37U4FL4iT/mNAmhAEX+/aAwjLIf
 37UDCWLaL503lZJl0zeOo/CC8He4Ve9pWrv+2oh5kBizuPKms4l9S7qLUuQtm3cTmD2G AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyk9we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:23:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLI3Y022765;
        Wed, 6 Jul 2022 20:23:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud63w1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:23:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAVta7vloAL+2Rt60JulYWiRtF7ik92/sBBHnV0OkGiSDoUC0IoIU8ZaM6UKfO/2L7wMC0hhlcaJL7jOsj2CF5dRWgIF5LYYflWCKbCiieLAPkdIxwePM0CsdhC236WsFCF4E+6RX0YkZJf8fdTQ4JBi3RXXbMz7oiC0k5NirTFM0Xm1NB0oLZ3NgyzqbOrcxzfab9YryDc6cHmQfIc+Te/HNTQiF6XsI4FQfubUKWRyK5rLgRtTN2u0l8U8kLD3foAsn/HQl4lhyDCtVGYEPukun3qRo/MbtQRzQZ6qJG80uKJZlmRyn2FYRXhwKnekTWPVM/H/BgUiU0mOMDdzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8ky+HpgCvtwJPQsoEGH4UhlCf9p48ZRt37tRuCVtNs=;
 b=GTdODo8BQOn1PZ5j0HOZqf1UrWuKznkpM9kewqBbzuiQ0IXuw0OkEa4U+IZGnNpl6obYb/Sa5puSSC3D2Slo8JY0CaXvJi3Htk/86s/owkxFcbv8g/iqkFUolp8TzuugDBP2r+mvecHvc+l7theRRx7oHTi+SWVCbMn8JbZZZNW6lohoeNK7YNJxQoubSbzZnMUUyr68uS15g3TYCneXLDUul/6rLRfIorcJAFxdW2OPYYDoY6UdGVZ6uvUGcwH61fimrBtROllNVJIwa36ts5C4RgbDVAlR+92maVrkFeDSLnIskQUhEmhFy/+flQu9ofzu4FONs0DLMt0EnQvDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8ky+HpgCvtwJPQsoEGH4UhlCf9p48ZRt37tRuCVtNs=;
 b=BtXX38bfgaYLXUPwDkcnAjrFbs/F92OVx7Vdb5MHEur/Gih6ticbpAez+9QI5KJoaeNdiALkCYDIJUzQ5mR6N2BlXWgV9sf4O/WS/aIOJS7C1F0S4oH/uxXMuUYCiu/JGwYlIZXn49lgR1RzuIuQR2nLwMLHV6ICbnJc0kZwoTE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:23:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:23:54 +0000
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
Subject: [RFC PATCH v4 1/8] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Wed,  6 Jul 2022 13:23:40 -0700
Message-Id: <20220706202347.95150-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:300:95::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ec24ff1-5785-4e36-c98e-08da5f8d7253
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9ELnLpZrDFXZ8a+JaRaK8yQZqZ141fP6djDZIwJG5TFCpe5ZI7UjszpBJzv3vPbOE53UR1GvJB3xNqtSa5wm+OFxa4RsMFFbW8M1NxiPljxhO8ci0KJMfFV5MhS7uRmitM9N7PdcP6/mRKOXB4l5zRtTTj1IYL0AuqxvzneWP2BtgowcEpbNFq0EFT7TGqWt8hmUQD0DX2n0C1rwGYb+RkkzYzG2KCAJPUNo8ua2ykTbp/sN94eaDDzdvHpAV/Rnq+i8I1ndMxoL/PNM+gHjYo57yR0im7AAbP6g/RfoyxmNQbxE1BvxQDsWRnSgYYFQ9PXGdy68hzn/J/5mhsH1HRkixPfu+uv/4xOtwgE8AcoWgWfGMQkXWVA8E2TAQCFrNpNfo8z+nt6flahbJWd+6WxfL3djjMp23YCHJESvdpVb5GkqJ/EohZ8YNrId6g7mpVVDlDUxHNxrTri2ywTcEm5Ogk0KNZCeR7QQEmnOroQmd6fcVypd0sX49EiUlqVwKEayOcXbJfA96rs10bI4hrhdJYtc16gQOehhCOnFslLozVi9p0C56RFrPdslWV2LQCh/o/btE45zWnjEMLs1MYtiCgsnMKLMZm/+a3654r4HEAASWOuWDBAbaEvesx3qo7tYgSY33r+XjMlY9sc/c7Pf+auY8kXcpKUEQlrGhRXtH58gdtIJCoMwJzrTYpoqQHXPyxGAMrpyvj5bkUw5T8ya+mXcBkVe9OCsVAKmO1e8euQ9wOrd4bcSxQU6kxU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZsQSUBaRr9yO+pWdMRs0/5/Fz3yVfC8xfAtnGIJ1uTGpdp9qWOv0CZrqod5Z?=
 =?us-ascii?Q?G3l8SWZhhsk5J+2kGTHPE73C+5MpC9naPCbgIoL4tiKvXjbMj8aa4mBA/9p+?=
 =?us-ascii?Q?ixS7kfh7YKfeo2AkPpx9rt30oQkIL1WAKVd8FGRaafmnwPkLUjO9qkD0QdYj?=
 =?us-ascii?Q?L+w/b9XeledLGcQdWgfOtLYOap9i5XAE5Q9vti1OiB2Hs64YzmGFrgSMp27/?=
 =?us-ascii?Q?+EvusxLtUOmQsE6QBMU7C4/LHF+SjixXq55DrH5zjx2qm5dcFRcO7ybOMrOz?=
 =?us-ascii?Q?4IHEdtW4CudU/NXuI44/wlbV8/+3QHBxb9nn8vwMGjhSEUyovo2RIUXzJ7sT?=
 =?us-ascii?Q?009zm9gk4Qr5Es5eImL4xrxss6JuWAD8saleJzWEVkgnEPMXMhLOIuqibAAK?=
 =?us-ascii?Q?CVMBFfehqVoxfJVz5YNzLQpWAZhLJGog90uSRsdFeTeiuFcM1j8d+DlyFTSM?=
 =?us-ascii?Q?JI6WFHcfv+q9tfrKYWyPGpJ07Y1Eso/MtkwqyV6SfmEnQMTZ7Di5nTXcNIWT?=
 =?us-ascii?Q?rAndSJWArLKsEXKHa1LBgMUsK8qib/NRpzHdq7uxQVxmccCEs9lXbHhsKBSh?=
 =?us-ascii?Q?MOD7brNMJNtdMae+2u/+6N5b+QCyKZsfMmXTbH7Suje+YhQvwz+ODEEWfSb7?=
 =?us-ascii?Q?JRTvHKt05pD6j0TznnbP9cBISvHg36msvZNMMbEhzGUViYQXrewzHXH1G0fz?=
 =?us-ascii?Q?2C2/OZjcCtGyi8tFVdwwT81r8J9SyARttrUqkLoKhKl68nMMfY1D+zMNf6lt?=
 =?us-ascii?Q?tyGB8hDnXfweM+AILAAp94FB8KfSOKzi7T2sagHXhMPpgPd48Yk6UH9kqQTb?=
 =?us-ascii?Q?4QKk4n9gl+PXdizIxeL6Mp+b8udPMOKYE+l/KwVO6aMeE5SFrXaxllFS0nEO?=
 =?us-ascii?Q?OTP92ve/P75JDHJlyIw+5DUmr1ndtJHAx1CEtF4Yo1WFH9BiUb3E+wtd7PwK?=
 =?us-ascii?Q?eHZulkctfhpzHKVhqsUjydUf3avxm7rEqtRY1JdY2C4AsZxhQlzOhOokEiJU?=
 =?us-ascii?Q?CpcIrNvrZ+JwY7pf78FllEa03GZW9xtEGFrySd1jStFOybA5jd3LPJKlTAod?=
 =?us-ascii?Q?7MdyXpaFwwjXfL0oywvZXoup6kz6rwVf43o45mKBZzsVRjyTFHOd9AvsxWy9?=
 =?us-ascii?Q?YGpyc/JIzeRl5bC8kHbp+RiQ982IDaEWcPIp7dRUKsfHJHGW1kPs4TAHSA+r?=
 =?us-ascii?Q?JTdmx5VBQDNPyE8w+c4XMoc2lHY88pVxzOdbNy1C2XbR4DmoRCXsYYn/Vtom?=
 =?us-ascii?Q?uqjvjSLvRP0Q+AwFkULJWQGBAoWqthw7IDtnbH3I4Tvy/cZ7g4FoFHSp7j46?=
 =?us-ascii?Q?XreBPJQnyS+Co5E68neoIo37NOZEWO0VDZVle5mVMnIE+4CAEE2DGhQr9rr8?=
 =?us-ascii?Q?fBBOpyHSMx8bIh5IS36qkhtO8oIckLxNiKzzWy6c1GgCRUoQmXJT03ufcIAN?=
 =?us-ascii?Q?FXWaXPL7u2XgMk3gcMvqVLU9pQ5XG6CyvnB9f+w0v+k6cSCsinHecWRkgwns?=
 =?us-ascii?Q?J80bo3O+agD5yBojHZWe+pvnPy7Hhw0teg90ytbPCn0S303Ck+KG6LS7Q4U1?=
 =?us-ascii?Q?GJxWUoGRv0zQHBGJaMWgp4YbPKi7IaM5aROiH8HLqeaODNXLjbhGwBIv2QYJ?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec24ff1-5785-4e36-c98e-08da5f8d7253
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:23:54.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jln9XzX0cOjV2yQ+ehVvA4HvlnOtpDwhJA6uSamlKgvrPFSuqnOAGSYWfrSG73QxlfyRVc+g6OnfW7VE0kjWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: qPgZt_s0ldSzeqM6gYCjN_wPrIejo08A
X-Proofpoint-ORIG-GUID: qPgZt_s0ldSzeqM6gYCjN_wPrIejo08A
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
index 20336cb3c040..9fa1af39382d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -451,9 +451,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
@@ -483,16 +484,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash = 0;
 
 			index = folio->index;
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
 			 * If folio is mapped, it was faulted in after being
@@ -536,8 +529,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			folio_unlock(folio);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -575,8 +567,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
@@ -735,11 +727,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
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
index ca081078e814..02cceb7b8cce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5532,18 +5532,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -5633,6 +5632,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5741,10 +5744,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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
2.35.3

