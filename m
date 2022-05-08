Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4C51EF96
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiEHTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377112AbiEHSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D163BF56
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:34:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248B5RYr024462;
        Sun, 8 May 2022 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4IHy59R2DLbf7dKJ2p4ivUhgcekrkY477KIFdwipY6M=;
 b=sesmywomcEYemP+SAcnrL+Oyi+4Vcgl3wWamR/vXrkLvnZ9O5DEQtEIgNR+wihmJJLQ4
 38m9PSEfB7Kwf/Y17KDz3lWVZ7zrsbKalItFD/UlOPkBjFc3QKb+T+PZAIn/BIJJODVi
 Z0wCAk3/285LSM+Iobppf/1II6BhccAkkL8XIk+61CtcuSEnSxE1xjjWLFAdPRK6kJSr
 NUV+m4F8ZZiHU30tFbSx64q0SVIQZx8w69yYV/jfybx7Q1Tspjf86AlSScpQvC27212K
 MFcK9I7/uLIj4MBztvaDJOryaoFY0uc3XAXU/6jyPlkKJX4x6b9NqGYSa5S9siUInJJS yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0htvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVFip025089;
        Sun, 8 May 2022 18:34:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf708b4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkrdD9Xip63hfttkJgL6IYXtoGu2Vfpot0DgGIOoLShw38oIhboM2GJxuke2YHCajE2g6MF1kgoG+oXNsbFI63a1xmXN3P1iq9S0nVzlNTBKf3oXTB5Suw0DuYz4G27tQ2KqLLA7a5916jC/wi+j5EW1+zk0/b56Cu+SuODpxF6VQjIdHZ0MKZ/54cw51d455sUTmzDuJKqd7cjyoVn25ObUl4GG3ZDyNGjJhYzJ2tFevCCwQ+N4BLZSUKLQVRMiaumZjZUp4EU00CxL7duQQ8RQ1zW7tzzQR2XN1BOTo1r6BNW5MrgXF5ep2HzaK6hymF8/X2MK7SRb3w3zcd+rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IHy59R2DLbf7dKJ2p4ivUhgcekrkY477KIFdwipY6M=;
 b=Z+Meb+IFFI3TCOLlabW127xNns/AjH+SWfzCyBllX/AxdMpSRbHeFHauz6CC8NCwEe+Yc1TUapdl8jOr3kkqhoMnJ9rSI69Z6tP04FkybcQXHOIIuDf+vQ8sXje5IHwAiCCSBdZf+PzWfHWWX0ljiwxIpMzmDPT+sUonm3kMSbusZkVDep7/N2wyt/T1z/aHyA9zsmzFT8J5CgIi9W4AuXsr4VuwpSCjZe6nR9be1T14HdzxOgwgrObuM/B0SITczSlbcAYnJis9+1HVr5Odfq6XvQ2LtGPyHYhyzbcr2ALwg6CEBq1iKkWl7FqKmM5DYKIVmoeV8pn2pqrhuB7wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IHy59R2DLbf7dKJ2p4ivUhgcekrkY477KIFdwipY6M=;
 b=B8tWW4+PRnlrDObZZQhe1ySo6Cn0QrX8ISlN19eCwNLGrbWOM4D3Csb3aZrXVVFw8BXdQOkQRZPxy7SJ4dYghuHP6YLhr6XeDUsZ5x0/Z/WhUuGo+0HdgcehpKgoM3JZdhka/QZiuBFiniN46cybKUq+QmEvrmmb+Fv2eOwArnY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:33 +0000
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
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v3 1/8] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Sun,  8 May 2022 11:34:13 -0700
Message-Id: <20220508183420.18488-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220508183420.18488-1-mike.kravetz@oracle.com>
References: <20220508183420.18488-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9188fc8-cbe9-4d4e-626a-08da31216572
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485057E6657AC68080A9A3DE2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7aXz4Tw4oV1WP02QPaieH5tRL9drdbkvSGvV1HQZG9x1LvYzOarJ0+vrr13npIe0PqMJf4uuhy96VpEvkrApSTpBQ7Q02d/vMvbgFGU02dC8N/Xg541XDPcV9iusrh+7OjBOt8XWKmgEKmg5XXCRrVKo8zbGVkcsSNWwTLFtt4bDnpPh6811xigzp1V/Y1PUnnbKnFR0jNx2y0+VdpXgkcxR+HNsYTia9QMvekOZmvyC80a1UD9c7vQHj6tdvyhsrfjerMKszXT0gA1fRBWdqW8m7YS6M4kyFzqdNVoosHGorfdqVS1rm3IqZmoBtfBUSsB0zMdJA0U6v5IvsFZz/f57zZQLpMWZ0nt1ts3syKwflAh0TeyzY5dR0aFdM/pg3ATAQQBBJlmiT17xoxfuH/9In3HqAEAxofl0Nes+aW6fV6Tx5lZMWnVxS9/48SpW1frLPazlqaVbYjFWl2QbUePxqagJWmDrz/l7ntJtiJIdgeee4dLt0GajE6A2/1oCumnBkJnS3zcDL1GsBADl8IarXwNHHNPw0new+lkxV2iOzL8YFoHc6bihv+8Bt20SMKGuQLPq1yp+ek+6vqolAhhpLdoEyU0aHLqTqY6dJ+V/wvCyuczbo4fIdM7yfT1OzAIQc2rELz1zBXos/jsPsJIVcUfo2zBv+6XaMTv+FutQda6w2r5VW0oFfNJ/J0+PiW8JBB8GJ47uowWCr0gc5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6CG+mlS8BK+4vCwlSSPCHbrHEpIJEYGzdjzU0UxLnN+HpwD1qAXyN1WZC/g?=
 =?us-ascii?Q?Rj4otgPfp7+2wl9UxYvLMixjeOa0qDi9O8wbA7lGyp1ugwn+9ClqwO595LY6?=
 =?us-ascii?Q?Krljm3kArPPhk4tKQgOhqFPtx3gTvXlxDBIdcN1nCdBpVz/T+T2eedYDyJ0e?=
 =?us-ascii?Q?B+92bLCDoJ1Fc82fCRg60LDv+1h1aVED6w4ZY4iPZmtnmLcTmVLiv51bhaF6?=
 =?us-ascii?Q?75RZufhj7sxFveUMsDc9NVXayxCE+UtEOQ4EesZF3tvPmyyEWIsdduwUEKXQ?=
 =?us-ascii?Q?HRdenvUE+8kYiKxmv2SvgdzFruVdBcHnsGgo2AhI6/KngOpF5u8QmhVJSFbP?=
 =?us-ascii?Q?trGNnAeYZ9IuYFITmkOpdP4z8q3dK9lfu8zgW1/+spmm8viHyxN+U4xxh2xG?=
 =?us-ascii?Q?dhuos2zPq54Pnh99rIcWPgTc25R0Qs7wRP09OpJ3Gsf7kkNCrFguazotCvdt?=
 =?us-ascii?Q?E0l/3DPhcnBJDj9TVEfmyR6t6lJaTFbsETnIyUPrhtU9a3by1TlUgY0tS0w0?=
 =?us-ascii?Q?DRrvUzId1MHLJ9ske0f40L8tdjF0k17jMnfW0aQZMXhcjViuroLZfuKMq6Zx?=
 =?us-ascii?Q?HMX96I/159XO8bCJeOi4B1AG1ec5uqxn9KAlJTDQJbTVWrEOQthvTQOlKP54?=
 =?us-ascii?Q?6pYDKIMMOWLIL6511GR9nFKs8r0SJtHrGai+oKVvRSgNC0DnqzY7oiQ5cMY6?=
 =?us-ascii?Q?w7KyR+FRY+tJiRG/gc+S7pAKP1IsqQmb4digkcmxgc3miRKls2UT2z36WIhr?=
 =?us-ascii?Q?aBJFYlp++2DVR6Yi0X0lxskTPli5LcqaVCSatXjhubRWBKTTeg47w6/YHOqm?=
 =?us-ascii?Q?eJbfYpPLWeu9cojjzgIXdg1IkTr6q8GHfHikBWgqQBDelsw/ZimrM6G9iE3p?=
 =?us-ascii?Q?9xKtZwVTo91sF9U59LT3q7JmdXM59yn5QD2ReMaAZfLlc1geZtDm9gsnSG3c?=
 =?us-ascii?Q?CRrNvYhfCen6NNf5DSxtgjhpuKkzxrXJB9fQaVkPJ5DDeW6MdcCwX7yx6cZW?=
 =?us-ascii?Q?o1AFJWBSB5dZHqQY9ZUIv/+tAPS7OO6Yrnqs12n57LxmGDLfXoL6yoqqrUHc?=
 =?us-ascii?Q?3p++ceA2mjTx2J/zd41vzMuTrRw4DnpAeB+lkRtSTMizKla9Na/HygcsTQc6?=
 =?us-ascii?Q?IZhm+JHAiK87tYzYkFI+PCUoy9Cf4+MLdA+66P3mtHbbi4ulkU9FNQbYoQTY?=
 =?us-ascii?Q?NXzkUWb//GFQtPJ+bP6k0orTzvkLxCW+hBJnO+so+0Dx1n7TAj/WOCS8Awr+?=
 =?us-ascii?Q?15+X+iJXg1D5wQFtxySCcHK/pBl3UPVzJzYTfVWn6HACcEFIk/6eAmMbQkqS?=
 =?us-ascii?Q?AdewwQQqkb5Uv77bUh6ZnC8JJQWmF+F7ldL5iwNc0xNZAP0j9S+Gxrb5LI6C?=
 =?us-ascii?Q?NXCEd9VYqiGi2WASUdua5ZbpZwFYtstge2HdtU394ZtH13QuDpumkG4xQsf4?=
 =?us-ascii?Q?BE72v23Z4RbUGvS7HoO9dvO4kwmwnNJ+W1siqtHZQoOriOFIpEe+ubq1PF0r?=
 =?us-ascii?Q?PwbzlzDAJCaB6DZ5ubtbfWWJs1jZh5SptuCC/qiA24DWyAORRP+f0E9psVUu?=
 =?us-ascii?Q?vTy1v0VzUGiRH+FtNdpt/uWWYVZe31dPYQGykeTdCOF8f5fYqvxzP2IX62T5?=
 =?us-ascii?Q?VJTZx7LhPy6yme4Re8UxfILLk3r3z1ptItHTSK+pPIFvhk2+8zGQ3mFT8ftR?=
 =?us-ascii?Q?LVzO6F8MWRMMT5qxY8TizivMajv1o6OK1E2XWK2gQBir0QwTp90eqcij3IdA?=
 =?us-ascii?Q?bgPRHqnS7J0uZwV6pUIdiu7DmhAYSUM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9188fc8-cbe9-4d4e-626a-08da31216572
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:33.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5FLOJjotqnGYNc5dkGLLZBh88Txhe9c/CMv0WTJLWWJOzh0Vgj9URxAlqvXt8Jpsvn/lZorMKNegk4mbCP3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-ORIG-GUID: IYre_w27bKOh5GCGwVSamKNUbchXy4m7
X-Proofpoint-GUID: IYre_w27bKOh5GCGwVSamKNUbchXy4m7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 4c57022855eb..6954660869a7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -452,9 +452,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
@@ -490,16 +491,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
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
@@ -543,8 +536,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -582,8 +574,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
@@ -704,11 +696,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
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
index 7a9fbdc0620f..09a0ee4121d1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5494,18 +5494,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -5595,6 +5594,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5703,10 +5706,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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

