Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B855092F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382879AbiDTWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382887AbiDTWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C327424A8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KL62JJ025975;
        Wed, 20 Apr 2022 22:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=9TO8JGBywDKFNvzhFp7t1FbK+6cmhE8PCx78UOndfm0=;
 b=F4kYUHxKg19Fm659lhzBvLEaPLbyEyCgBcwvSRfjRlBMeKaMM3y+loNbkDS+PeoEylY9
 X35sme7bjrmgNyYorSnEjcRDmj/vZBQdkyWaCCW8goKJjZbjCQXPN+E3aTFAoZQ8yCpH
 yEWnFK3XmbgwqhTf91ebLrfihXHh0PSeH2XvfYY+0hSs7U0dXbmxHF82I5HbyomHW/zC
 uUpWIrFrqO0vArlX5R1TtyIG+EPWsiZMBDI6VrJQ5Z8pUaXVFnTEgsR+Os8zUWRqc/u+
 HcE9UL9JJh71uFUYAXKlyUCoH8Y3u0dVS3qZD2Jn24CJpFVHIzLPsjKNiiJFecO45qn+ oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7ct91g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQMhP010599;
        Wed, 20 Apr 2022 22:38:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm883jg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxdMbt1NHTo1or+fwrPVEz9WqHBedAinEIIzguz12r3Y0h+n22G2bYz+VKDw2qllGYHTV9fdhnGZrX4XC3pYTg8S4MW0Mnv9fSPflCiEiFXya6+8xRYOtsxhw0yC9RawmGGXXLmt+RBK92QweXuTGNBSK8bbaKB2p32JLNAc7Rvl7EUXcihjYCM8C2CRLdm6MB6ss6hb4TERsR8GlfWmFS+Kqiw2d276dE3abmDdhURaPNVNs5xmznpVioFFf109fP3c8chtxBynC5AV47f6yHYm69IxawfhUaKF0cPIRku2qOf8Vpm7qxuOag90JA9vM/hp/ZKQM4Bhekoim8Mi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TO8JGBywDKFNvzhFp7t1FbK+6cmhE8PCx78UOndfm0=;
 b=nnC8FHpl5ZtkvPKGwt2a6120wuN8yVpsVBz+iE+WXYpqQG3128Bd1XnjiSaRcB1OVSHmI2aOHEb1LAuqrPCVeFvnWCE884PLbrEbVPTzKO5Xo6ko402ycRSLCbWZKvUehCG+hptjflfJeKrZz/7eHecWKGFVlSs3l/4GLtv5iwhIsIxoHLPYh3+wLMGIa7j9REHC1q8Lf1c2xuP+mjb6VEQZ9X8BgT0ogmYC/2uVeIvUpF1AVxKsG9A1l3bTN7Wdqo8NrbswipVADuLXUG3AMac7idV+249e4U1r6IXe+SfQll4NWf3pSumQqORQ/jNAJt64m9onJL4F9DpW3zEdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TO8JGBywDKFNvzhFp7t1FbK+6cmhE8PCx78UOndfm0=;
 b=cOHLF+9IqjhHgY1sM0zDfSaU0wpsm2EuFe+mXlhJud+YAhMYwnHnXyIOJupqSS+vG0p5rzmc9Cr7SF0O96BUFyRSi4bxkZiK6Sv8AoI6PoeITkt4xhFoxUAYx3QRQinNLVUtBPy6x4T1NHGqsVyqGyv0AOc2j0M69YXSM8E0a6s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:10 +0000
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
Subject: [RFC PATCH v2 1/6] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Wed, 20 Apr 2022 15:37:48 -0700
Message-Id: <20220420223753.386645-2-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6dc3827-c9ff-47c0-24c1-08da231e7213
X-MS-TrafficTypeDiagnostic: CH0PR10MB5035:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB503556D8F6580CB09C119530E2F59@CH0PR10MB5035.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32Wacf8/t8Ka1ikxEjFIoGdozch0Z0ryr3MexY4QsZgzD/Z0mD22BcBSWiSdBH6S5tjuW+Gc19FTHCOqm4gQnxIRc00I5sRfijmkUOclyPuPadViplAZOp4jIN43QveqVeJIOT6zntlNvq02EvNsWrFath+/lP5X/mGGgxgOhMuVdSYTVt0NBl6VIN4CWUYY2+Y57O0mQfOYQvVoNz22H+LAo2Wi6qJtYqtgUyxrhhqT7iEG72415mcRUHv7HF0PgJ/fSXKurWJWz4kwnyLZa6BJmttyKV9mMayhny9VmOdzfb06+k9klzV/pIjD+jRnQkkGX+w/9TjcRLPp9MxccSnsKu99r0liAtPjqd+g/KyNAIleBgwIjhK29UnXSItfbc+cOJvR8BUZwv+Z0p8o0s08VVqpE6d2uOxofnMftU3syXSoVwPXZJFkKwhZbQ5XznJ6vHnH4ZfTt8OBM0f/lk5pCgLarHxmiVVR00OKVTWhQUJnirmlBLs3BvXa8sn3glTN6Ycxmp8bO+6u3hOJ7HAUYjLTlro8HcDbFFOhvwXAcOewsYEA3D7s3mmIf2cbAIZlv7GKKmwus0CaJXfFi3eH84z0PMpW8nbiZy0AgeX2VL91I+lWa6+jjGPRzLXcoxkzQvOw5O0e72+Yq77CpOBt9D4BMoFhaBthZlT1g/+akQTtQsv/o69ykqpPehr0qg8/KYO2vM7VWC9vIEzoRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(107886003)(26005)(2616005)(508600001)(6512007)(86362001)(186003)(5660300002)(1076003)(44832011)(2906002)(6506007)(52116002)(7416002)(6666004)(83380400001)(66556008)(66476007)(66946007)(8676002)(4326008)(54906003)(316002)(38100700002)(38350700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxyz7n9CVqFely6oBLKNxicNN267JcbnlPh722NRJqMPh3voqJr4NBHXfDBh?=
 =?us-ascii?Q?OezArnKa+73b/lnY+soUbPtf5P7NlNGB6PGIcCUvfIyQlRNSlVfdN12JN+e4?=
 =?us-ascii?Q?DHD7m2TJPtfEMKxYZ2Dp5tKXtvucnbUw+Y5DnKSyGHL0aBhbRpfukIuo1sfI?=
 =?us-ascii?Q?AQ4Fv8x5rhU+ejznN7fpOpH/X4Luvwoy7yQw96SkKOcOwOhbMTXKIAm9czzW?=
 =?us-ascii?Q?M7MZNjRWfbEHFbq1/QA3wADsPdSY3+weTWvRx9MS6zbKmhzY1pzfAvJPHPsP?=
 =?us-ascii?Q?rhoy3W1DDKhE5Zs7dB/8UHawL02QQlkxZ5qGxFdh3CEnQNwVGxuYOb+tA+QB?=
 =?us-ascii?Q?9RT7zxXXVUdq10FJcD0if/8Jiwq1YqM8eGma9XE7fbcGSdkoAXSKdGJBzCbm?=
 =?us-ascii?Q?DhA/4FoE8DUbcPGUe2+WW1cX6JRfK/KJ1LpmppfLzEUf35w1aJ4Xfi5QaNy+?=
 =?us-ascii?Q?59eqb8UBleZtq5OcqCaQ32szIINVAQGygdG+hi3dWOF+m4dVPw/M/w5mzL95?=
 =?us-ascii?Q?LeWmMiYcTK0p5SwMmdQIqi2V1PlOxWgKlzor46w11ykyOM8LF+gNqZbWYoqT?=
 =?us-ascii?Q?9KJ3rPgcpOIHDmdbfxO1uNiR/zwiEyRbzfFFOxWbYkn1rIc0zi1VwPTCGJJE?=
 =?us-ascii?Q?y3BQXENjfCiKIKRG74itmtV7qixFRjqoKrmZ3BFybJfpz+0QdXwMkh8B7I5M?=
 =?us-ascii?Q?e3ndYIZrdEvQs0awn13KaM1os6OFpOuCXGPXiLtR2B4CcwxIwSE9KeaYZgIw?=
 =?us-ascii?Q?LG32NcjLFDYLtzhchJuLBfgcPCQPmMTVfieDXF15Mt8yOLuy4Fu7WmHoW2/8?=
 =?us-ascii?Q?OkdAKZF4nJehWFlP9Vi3kJDUlV6zzkLfBc38CX87SXfjrRa+iUp/uqhvU1PS?=
 =?us-ascii?Q?fQfunbK8TXM9M+o3T6f/wsUlRy3nHq6HqaHxBvmytqOMwyGDU022SxSyyT6h?=
 =?us-ascii?Q?0hvrKgzmBCfyQig0nKUEkInss1LDd8liErVifbt+NwZuh0sx4GfB5YiXMbIW?=
 =?us-ascii?Q?uf65lQqox0hYCbRqbD5KEqxSeGnfXPkikQaQzy9odWxtD7fvK5AOAGS4I+q4?=
 =?us-ascii?Q?4cbKrglhBSyHp8gM0rF2SZ91WbXZP6SvDXdMBma1FU79wnCTE4STAZ7AnlIf?=
 =?us-ascii?Q?LYzdEOOa7t0SZ4rfJca8l+nuYHsOxS0zdEqdlJa4Cvg5h08bKXiFNBA8dsQ0?=
 =?us-ascii?Q?/9elY9lT09qPUVqsrfQgr+PxHpxVcQys1/RDmVVl/s//tbrhU4uTEwm7lp6A?=
 =?us-ascii?Q?q3piK+ch+eyOOXC7J3TE4RdhIzWkN8pFv9izNRuHyyvch5CdmWAWgoPQRyMy?=
 =?us-ascii?Q?JLlTwV2pdCNxFl5wvZfM2WeNZPegEe+COvuzTxpskvDl+a6sd5S10186Bovm?=
 =?us-ascii?Q?Jb6cynb9FfK7zKTqpW2u/qJQArnUJxy58NQoHqoXvl55YUVVhkEl2dvEzFUh?=
 =?us-ascii?Q?LDglBVYCQGptmq/8H+0FXXJ9NwgfXKtO9g+4XcmQUlQW9YN3e9maOEcnCZcK?=
 =?us-ascii?Q?I27xYFJALKEazscHmQ4KBJ5th2qAKIMsOCJu/xNwTL6djiQ/h4V5epK5e0J8?=
 =?us-ascii?Q?hyF+wttjPz6N56BzmuroGMapt9nCP9pO/cOOq6HdI8U3g6aJAu1ME0fBFVd/?=
 =?us-ascii?Q?zeEO6Asa3gAGTP4uU1rRl1UWKhNCxPGffnn0w2b2Kv10AD7bTrC4zEWBrPuP?=
 =?us-ascii?Q?wCOHZ0fnTar2SD9LXM1DyXNAsSmoC2NqeHLsR5aNxSuBj7t3Q1WHHVN9IyAB?=
 =?us-ascii?Q?2eXxRyLp7vB7nOqMfbceAu1/VG7CkuI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dc3827-c9ff-47c0-24c1-08da231e7213
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:09.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksWvD4UZWZdzmCpMVyelTQBGD6eySPSw+zqGFE5X9/XBEDvZVX4AUIq3mdIWucwBYV4BPFPAGsEf9AO5TWfBng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200130
X-Proofpoint-GUID: 1tcUMBvqoA96ivuTupwwItio9IWGEZMK
X-Proofpoint-ORIG-GUID: 1tcUMBvqoA96ivuTupwwItio9IWGEZMK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
index 8b5b9df2be7d..1ad76a7ae1cc 100644
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
@@ -489,16 +490,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
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
@@ -542,8 +535,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -581,8 +573,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
@@ -703,11 +695,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
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
index daa4bdd6c26c..9421d2aeddc0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5477,18 +5477,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
@@ -5578,6 +5577,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5686,10 +5689,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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

