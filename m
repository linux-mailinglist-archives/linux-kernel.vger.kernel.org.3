Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE351EF78
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiEHTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377237AbiEHSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12598BCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:35:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248AR09E024475;
        Sun, 8 May 2022 18:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wLWWo354qIvKCgKvx1+lOHynQRGG75IK4wbCdZa4FGk=;
 b=o4zywmpFPdiLBEiNGSofsp7SKzrrbyia0mzgUoVy5WnMGL+UARdbU/LIZP3hxF3Xhrn8
 16Lu7MnXaiIkd8/QdKIWRYVhwWllivd+73Q9Ifb/htJQvDBfPyPblP+IJsqKTnWaUrtY
 186wgrhr9TVJsBAhUIj2QkI6H+AX4g57V45KNVk0LOfqJUJ7ljJvVXxe4l0mIgpdRVsL
 8FXBUum4ipgSHGv4H9NYbpxzz7PlFv8mCyJvOUb6APQ3G3nOr39uY4rwvwGP96tJKk/l
 OWekMYEVsaVl/Hq/0xTT/kVQGWGYmr5Q8tj+Mx3HUYtA+tZrqtJGGeujFWJwYYXoaSOh Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0htvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVT9M004939;
        Sun, 8 May 2022 18:34:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf77dm3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTQyr84rMY4qc66wxU0mczoiagFlNkOk0CCqQs6mlMR7t1UK2f7XByGt8zlU5zkhC50RAGFY3p793KQ+f38Plmv+7hebttQRJtiJBRF7/4lAU0rwJ8EEnYBYaNwy5LHFNtmhMG1DQnLLXYJMdh81dWCzCpv/7eRVgxA1LrnVIdfkg5vX91yXM6OVR9gR8RGyw9xDioV9ILn4Bh6PxEZM3OXcM1RZMA7JYoDyRha6T5xWKcA+Uyu1G99ifLQOJ1AB5dnhSwSjrEfTUYWDfHE1BqEo0G+v1fsiGfWGw3TyNw+G+T0ii587KU0PjLFAgcrutF2EDrSwICkVSh/Cs1Jerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLWWo354qIvKCgKvx1+lOHynQRGG75IK4wbCdZa4FGk=;
 b=d7bF8OQPkDKfZI5o/YBLp1AJTL1PQS7sXMH7KZk149DeKmYCYj2IAVlopXWQwDrIkqGmaraHOPKQHSNtEPFG/MX3i6wFg3OM+j1qdzG8/qEYkZ9AQPPYgdToZ2LHVXNuaLW4nifZOvGysIRA+FZzxH7ATskIqSrmj4ljVqKpPHueXPaK3+0HfAwE7Qas5Uu3UPSRSvXduLdGUYl8IpHOWxesgc02nc8220HnMGpHRS8HexplO/sHPzO8AyhwoEeC7FoxkKYCMXHsPyP9ysGOF1OEtaGRY8MBJaUXzX2t6Q0FRKzkcZ6IrtECU0nBmep2kvprijl7+6A+uE+dH3f2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLWWo354qIvKCgKvx1+lOHynQRGG75IK4wbCdZa4FGk=;
 b=YbuL9v8yhJrBxMsKj2VzTqxw0A7jfNLCIyL5RPrgLW9TRN7LD7ALvTmBuHF5vRfigzSaq8npj7/8XTPXUIs+u6rbq+t+jyUNV5BVDgfL6G7NSoZFWZcqVAtUtw7l0KnqWWrHCCmK+rB7oW58zobqhB66myD8GPcFIa4S+50WSBQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:41 +0000
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
Subject: [RFC PATCH v3 6/8] hugetlb: add vma based lock for pmd sharing synchronization
Date:   Sun,  8 May 2022 11:34:18 -0700
Message-Id: <20220508183420.18488-7-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b48379d-68d2-47d0-eaa2-08da31216a6e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485E8028DDDD3474940DBC8E2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oteJYfkzx7GbKwBe1vIge1z2to/+S1Hz5obbcIiZco2JMj7XWudQcjnSZQysNyZtURnlrjv3dFnWHiD024lA6Tu+5X4UWRQrXq+/AxdRG62SGOYT5GKJI6meHomcX+VEni/CZ95OxHkR3fv1ck3z+T5LhiAJYPmgFKpvT8ekUG0+b+frNdY7JmozHVMDarIxiRewoECcevTS22FWVBRQE1Z58L/GO2hBfyidntofJPsFhNRen5FbEpuJKVmvlloRdSj4nyQigpx+pzRkTJ1JqRix6LurCGdXdFefrdyqZR77cg575R4Tn8ZrL1BbmD3NMhaXnx2XboRanahmDcYgl6Q1Nqh8AwvXLsITSkKQAUNsdIcIZl/x3bCJfeMR6Wb3gLTFG/dXCl/IL5PQ04Z3jAru2a2laDDtVS0XU4rrA2R+hL9u1FriDg53CrpX9PkfH7yCyKow8Ygn4Y0kzxU0pZBqtDopngpNaryhp4oQWVFSQud8yHx+BU3m0vWyiKCrPcgu6eXEJBi5uANMm59wZEyaO+t4teg+4YFkXHqtx/YdOxwZxSKHITlTORpoLkaEKWQ5Mcn446SyxvLmC/G8R2F8NyrLPISH7UkHux5vGUYN3YWqDZ26fQZfmCtowpwVD00mVErll6mRcXuuNLluVT84zdIZ5Jnij+1A0qCcA5ONuz8/LVJJSWj2tqfQNPJJ3LR/akhsT6NK0P0Nr1C9aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(30864003)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/D5Ah7dciMfwMwHHBNSGUwg5XXbCFjDdevDhqCa00ydP1iU0h/0tSzbpx48?=
 =?us-ascii?Q?ngjBDVuumLqYtyRmpI1XAltsLFhpMkKcwspIodxVcQw80ojTlSCK7V2QkhWM?=
 =?us-ascii?Q?N1gbX4STj2mI0eXDxk03sj3H1hCMemvA2TrCAyMg7AfPUQaVUAuE8NJGuwKA?=
 =?us-ascii?Q?w7xs6QnjVn3eqVspsPANcwBUpZHwqSwa+rk3eclPR5dxSUyTjjkvdf2SbMru?=
 =?us-ascii?Q?vLYdhPpQXH4DViLNOSP8wtVgLIKp61vm75I2tAbCIwZQpPCjY6m62FbiGJYV?=
 =?us-ascii?Q?L93NS2+bxSNvWnCxfdB+uub93kBDBotXI2FLMDWC9xli1fRwxnqp+HU5QKRB?=
 =?us-ascii?Q?n6nkjsIf3IXdPuNHsaOi6J36X6LdQVC0hwap77q1Mlm06Fnq9G+snm9hODCg?=
 =?us-ascii?Q?p4McFfz2McNRZvfvbcN6UuIbNVE58OoSkamiFy3NrYdI6GHQdaA+y7o++EAe?=
 =?us-ascii?Q?Cn9iBt5t5hTWjjcO/VXUfJOQi9YKeOmQapO1NvGj6aWICOab6ctyNcH7s2DH?=
 =?us-ascii?Q?AkQVwQ0x3kZp5+YbsyF5NhESZUOo7xnEH3nAqD+POH+H2g0Fh5m/q/5J0eAP?=
 =?us-ascii?Q?iek4jFahEHu8kdkgh0hX6vUysY5sEXuGrX3hRJ53NvNTqUTf5hdnNrfgvKVj?=
 =?us-ascii?Q?tXJSKKXWBAjN5TMtL+6mXbshT1gWSwTtXOcxT/jL+QpndWt16XuCLsJ339vl?=
 =?us-ascii?Q?t9GnVYpCCE1N/0vDDbM9jWTGPwe4OsI2YY9YHxBrKUVE63gf6SjhsyvhuthU?=
 =?us-ascii?Q?+8c5Av5vC5rambsajbrLfuISWkeugT3RHLS056jj2m7GmGgzovwFjUBhpUv/?=
 =?us-ascii?Q?BoANAQV5Mbqk3ceES8IsaAocL82iJEc+ZnRkmSfO+NPhG4opkGhHniyq4C/U?=
 =?us-ascii?Q?j6dYEb+1nxBnoWcX5N4EZMiUUqD0tvwrizJDR4jH5tg6QNxsTGQEKPagBVnd?=
 =?us-ascii?Q?m5IR/fBus+hgM6pMoSPwddS6hYqGWxVvAoYsnx7+810KzSBhvI7izWUJ4TE6?=
 =?us-ascii?Q?nnyZxph9sJUP3PcZGi6vgV7p4TMzzQV03EVrI3x4E7gWaAyszPAcqgixVDIt?=
 =?us-ascii?Q?cN7wDofnYHUGS51kTYE+GePDww8qnSnuoCC8m1ZJlXhpgSt4BwYQok0KIiAh?=
 =?us-ascii?Q?t3gX3WnqW29E18OnZbU+6B6ECcfy8g0m2hF4CdiTst2aFFclnP7irOgLFa0t?=
 =?us-ascii?Q?Vug9pC/FJQoPmjzq8qfkPX2ffntxrlHCyBMbaP7bMDOoJEmOww3RE9WG93Tq?=
 =?us-ascii?Q?eX2sT5Ulm74HEXJ21BRbzrjmDUauoRChkQLXwX6ZCbZZHdaJPMviio9DiDmt?=
 =?us-ascii?Q?6VUXqANmh+qKp4KfQUjtPQ1Cje9CnXBIHD8OXBgkfeG/N4M0xWb8PApQaRXi?=
 =?us-ascii?Q?wqWED2HdHDI502fJPP2n7CWcsuLgNv3Qjc+D4Ne2XSYiLVQNPjBEAN0l71c1?=
 =?us-ascii?Q?9RTTDUqqC7XOsyp2UFhd2CKRK6sgtWzHoQW/8iOSPHPKzY4/3MNBtfn+Rr0b?=
 =?us-ascii?Q?yD9nihdua/cB3e9KoMs8CIvGiU31wJbmYB/dSXawhydsAGMABAp0//nFJxaL?=
 =?us-ascii?Q?WwnStjYN+AOBHoceWT5ImTSrIRc4UISHsgyyVo1sNOqxd2HfqjfsMw+zYg/O?=
 =?us-ascii?Q?Iu9TfLRCN1tgkpETh0q4mQ+4ZiMUcKCAeJB55F0BXla6THx2qCupcvnrAadQ?=
 =?us-ascii?Q?96+K3cGaJKIXMhkjFYE8wYGEGSCvE2+MWlISFrEPmZUN6gKwyQ7+1SJIIM07?=
 =?us-ascii?Q?caoNrCB/klsBQ/87MTt7H5D/VDLVgKg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48379d-68d2-47d0-eaa2-08da31216a6e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:41.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcqYS1Atief3Sjimr660KtyQNPaxxHOYTvp0fchtL1WQa1THsvjei3etGcIl5GhzICeF02T1zCDaAqnvFPfEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-ORIG-GUID: 53TmYlMcyt9shRKARH2aOgOpccuYy8XY
X-Proofpoint-GUID: 53TmYlMcyt9shRKARH2aOgOpccuYy8XY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a rw semaphore and hang off vm_private_data for
synchronization use by vmas that could be involved in pmd sharing.  Only
add infrastructure for the new lock here.  Actual use will be added in
subsequent patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  34 +++++++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 138 ++++++++++++++++++++++++++++++++++++----
 mm/rmap.c               |   8 ++-
 4 files changed, 169 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e8e837c15eb9..a02bce4a1575 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -123,7 +123,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
+void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
 int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
@@ -210,6 +210,13 @@ struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 			     pgd_t *pgd, int flags);
 
+void hugetlb_vma_lock_read(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
+void hugetlb_vma_lock_write(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
+
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
@@ -332,6 +339,31 @@ static inline int prepare_hugepage_range(struct file *file,
 	return -EINVAL;
 }
 
+static void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+}
+
+static void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+}
+
+static void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+}
+
+static void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+}
+
+static int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	return 1;
+}
+
+static void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+}
+
 static inline int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 254ab63c1106..359ed6a3e3e8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -677,12 +677,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		}
 
 		/*
-		 * Clear hugetlb-related page reserves for children. This only
-		 * affects MAP_PRIVATE mappings. Faults generated by the child
-		 * are not guaranteed to succeed, even if read-only
+		 * Copy/update hugetlb private vma information.
 		 */
 		if (is_vm_hugetlb_page(tmp))
-			reset_vma_resv_huge_pages(tmp);
+			hugetlb_dup_vma_private(tmp);
 
 		/*
 		 * Link in the new vma and copy the page table entries.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d278c95e9135..e8861603b069 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -95,6 +95,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static bool vma_pmd_shareable(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -909,6 +910,89 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
 #endif
 }
 
+static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
+		vma->vm_private_data;
+}
+
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		down_read((struct rw_semaphore *)&vma->vm_private_data);
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		up_read((struct rw_semaphore *)&vma->vm_private_data);
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		down_write((struct rw_semaphore *)&vma->vm_private_data);
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		up_write((struct rw_semaphore *)&vma->vm_private_data);
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	if (!__vma_shareable_flags_pmd(vma))
+		return 1;
+
+	return down_write_trylock((struct rw_semaphore *)&vma->vm_private_data);
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		lockdep_assert_held((struct rw_semaphore *)
+				&vma->vm_private_data);
+}
+
+static void hugetlb_free_vma_lock(struct vm_area_struct *vma)
+{
+	/* Only present in sharable vmas */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (vma->vm_private_data) {
+		kfree(vma->vm_private_data);
+		vma->vm_private_data = NULL;
+	}
+}
+
+static void hugetlb_alloc_vma_lock(struct vm_area_struct *vma)
+{
+	struct rw_semaphore *vma_sema;
+
+	/* Only establish in (flags) sharable vmas */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (!vma_pmd_shareable(vma)) {
+		vma->vm_private_data = NULL;
+		return;
+	}
+
+	vma_sema = kmalloc(sizeof(*vma_sema), GFP_KERNEL);
+	if (!vma_sema) {
+		/*
+		 * If we can not allocate semaphore, then vma can not
+		 * participate in pmd sharing.
+		 */
+		vma->vm_private_data = NULL;
+	} else {
+		init_rwsem(vma_sema);
+		vma->vm_private_data = vma_sema;
+	}
+}
+
 struct resv_map *resv_map_alloc(void)
 {
 	struct resv_map *resv_map = kmalloc(sizeof(*resv_map), GFP_KERNEL);
@@ -1012,12 +1096,22 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
-/* Reset counters to 0 and clear all HPAGE_RESV_* flags */
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
+	/*
+	 * Clear hugetlb-related page reserves for children. This only
+	 * affects MAP_PRIVATE mappings. Faults generated by the child
+	 * are not guaranteed to succeed, even if read-only
+	 */
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		vma->vm_private_data = (void *)0;
+
+	/*
+	 * Allocate semaphore if pmd sharing is possible.  Private mappings
+	 * are ignored.
+	 */
+	hugetlb_alloc_vma_lock(vma);
 }
 
 /*
@@ -1048,7 +1142,7 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 		kref_put(&reservations->refs, resv_map_release);
 	}
 
-	reset_vma_resv_huge_pages(vma);
+	hugetlb_dup_vma_private(vma);
 }
 
 /* Returns true if the VMA has associated reserve pages */
@@ -4581,16 +4675,21 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
+
+	hugetlb_alloc_vma_lock(vma);
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct resv_map *resv = vma_resv_map(vma);
+	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
+	hugetlb_free_vma_lock(vma);
+
+	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
@@ -6399,6 +6498,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		return false;
 	}
 
+	/*
+	 * vma specific semaphore used for pmd sharing synchronization
+	 */
+	hugetlb_alloc_vma_lock(vma);
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6422,12 +6526,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		resv_map = inode_resv_map(inode);
 
 		chg = region_chg(resv_map, from, to, &regions_needed);
-
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return false;
+			goto out_err;
 
 		chg = to - from;
 
@@ -6522,6 +6625,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
+	hugetlb_free_vma_lock(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6603,14 +6707,30 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_USERFAULTFD
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
+	if (vma->vm_flags & VM_MAYSHARE && vma->vm_private_data &&
+			range_in_vma(vma, start, end))
 		return true;
 	return false;
 }
 
+static bool vma_pmd_shareable(struct vm_area_struct *vma)
+{
+	unsigned long start = ALIGN(vma->vm_start, PUD_SIZE),
+		      end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
+
+	if (start >= end)
+		return false;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end);
+}
+
 static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
 						unsigned long addr)
 {
@@ -6622,10 +6742,6 @@ static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
-#ifdef CONFIG_USERFAULTFD
-	if (uffd_disable_huge_pmd_share(vma))
-		return false;
-#endif
 	return vma_addr_pmd_shareable(vma, addr);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index e0ede92830a9..d0d87b9cf58b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -24,7 +24,7 @@
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
  *       page->flags PG_locked (lock_page)
- *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
+ *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
  *           mapping->i_mmap_rwsem
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
@@ -44,6 +44,12 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
+ *
+ * hugetlbfs PageHuge() take locks in this order:
+ *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
+ *     vma_lock (hugetlb specific lock for pmd_sharing)
+ *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
+ *         page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
-- 
2.35.3

