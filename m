Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E45092FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382913AbiDTWlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382894AbiDTWlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A842EC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBjcp019298;
        Wed, 20 Apr 2022 22:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=NmyqhhEaUoaXJLuHNWT1slkwIGoiqwlIpP5W2GTLP+Y=;
 b=FA9DBgADFVC7dCQ29IE+mpcbjDtWTLRAhjqDFcLqMm6lnbHrCW7UIMPSw9fkpCdmRl8F
 GSZaMY3FEd1okIgQWY4ziqAjjbtvPPY5fMvMooPl+G88WLfcJBqxsF7W3C+73NFbgHim
 gPB61Yro37bUXIIyUzFGgLkxxa7FLGY1qINRFcMRVeZYOZ1Ugc+BlX8yjA1WhZj5OBQG
 Rnx7isnYL/Gu2WUk7oXbQB+PmlpKycDWMwbjf2BTNv7vhHpbPcfOiIIyWoxz8ey6blbW
 /crEivAaOyiOkr4zxfBPgKXzpltMCRZj8B9QTKRxUNLd68fFeqzod3l/IqyAqhA1UNjR 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7ct91s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KMQuqL035884;
        Wed, 20 Apr 2022 22:38:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm88dqrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 22:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNw0xGHoIOQAI2agn4MtCFoUnUox2ygXbQE4GvxcBgFgvtp8Sz/lXpBChOdQVjq9JOrRfZ0D5J2w2XRJC7mQ6n4s1/BcEflnmlVs4iydimNgst3Vk5NO8adpU3DEpBYaPRhgy99PQbJOw7KcO25JOVBcWHz07Fcui5te85N/U3A0GTnjJA3ga8vnCS6VLbxezK4s3Tj3TcpJpeIlmh+54CR5+B7xruVnhQuDVowU6QKqQxyG0JhRoUYMQFz6qpbGJ/Jtjqlf5PXvY0JMYQYwGjJOyuVgvcSGPg9BhYJS2X5pcAsHzakIgdx5TSW3gKewo+RXgKQukl0nr83rzZtoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmyqhhEaUoaXJLuHNWT1slkwIGoiqwlIpP5W2GTLP+Y=;
 b=PKplrXktbOTfhozBu0y671xeMFqmradbiORVSU+r5pK1XFxdOEYY9k0MHbg9CDem50+MDnFAbTZnVbDskfZKVCFc+OahhuI5bwoJSrmMuDgEVYzqRRgktSSedONq2uA7XBS50/F1Qy8Di6fjpMiGj+d7Bxht49CTwceyXXPF0L1cijrRWnpp9pMd5hl0vDtaJ7D2DhrnHyw6G4SXBA711m0xJDGtANV6yIFbkXuR4F/jbRntTVFRygvk7/TVD8VnktaCb4Sa6ixDswggLSHAtKz1oFL6jTBR6RNZsztYB8RbdQvvwv4O2l7J0DALOJ0lFDVqfHScebn1MH+DYx4+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmyqhhEaUoaXJLuHNWT1slkwIGoiqwlIpP5W2GTLP+Y=;
 b=ldLVOkfnB9YeiZSl6IM/WagoMPWfFMV4PVaAtdgdjso1mM7biYIHeQLIxWK02oH+n8OEfxOCLcDMy1T5O11q08hg5+ylZhdVYCjA0cVbJuprlrFNxXlnYP/YAqzmTSAL71KrYc2Wh7iFTlz6PgGGWeyAy94MU1L9eIAig6ISfxA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 22:38:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 22:38:17 +0000
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
Subject: [RFC PATCH v2 5/6] hugetlbfs: Do not use pmd locks if hugetlb sharing possible
Date:   Wed, 20 Apr 2022 15:37:52 -0700
Message-Id: <20220420223753.386645-6-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab265435-1391-415e-78d7-08da231e7693
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB455064B28EAC79F7EDF55263E2F59@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcp0fg29MJ4tD3QhJUpfAtE9sfZq/b2mYytVvJFUH2cutxm6u5VDokziQ8y9ieab2VozY8tDBfJ8VXlcbxhZMcS6HEmTb2FIQJYtRSZtgrpyYP8VB1xT0k0kbKSgJATmago58YcfSWbwzWYVjjDYjpdiU9dzbkSGmm9Pxi/jOxFDsneBWuMMS5uGAbk6jYI+ee4ihTFrYGFpQBiE1xxYZXCI8BEvE31pAPD+3MPqete3wqCa7Up44jzckIpBPmnXIlSv6SnpVJvUiVvBijBLoDpCFPTw67D7aUMCCrgtGKGWb6QP3kEsFRAaW493lT34XwYOXGfQrSRROoeJV+ldUqySr/puwpVt+nA9R7XddJxDfG5mhLMMcOJQd2Ay+ZEJZZrh39UZYyyoMzLQ2uHRZMjrChSY4B8UYAv0CEyFwuP4XevWtXZegi3dbtH4fCd/6zC9pH9RoCWbKvS0YPXLPT5V4kXuY2QMerENocAB5QuFKvBMaba70IvkVeHQGome6crCuC++v4gnxlOgFaY3H0vYrjUSKWZoNN/AsK0b5QLaVEr5SQ/PhOt4hg35MNON80l5usikJM5oYLvlRW/BNDrrYyyoUcLN3z2CvZ2yQsaumhXQi/e5HOuXCAAv066YH0tJKk+wwELA7OFwh4xLGMnCZsuO/UNdO489BbVvs14hj1tLs8XOyBL/+qsRikpoYej4uycX6nIhOhtWxvHVQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(508600001)(8936002)(54906003)(86362001)(316002)(30864003)(186003)(52116002)(66556008)(36756003)(83380400001)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(107886003)(4326008)(1076003)(5660300002)(2616005)(6666004)(66476007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nW8cuOqHc8R7eVgoZmt5esjOTNU98F2yezTiwwxTB2I6fdw4Zb742h6X3aEd?=
 =?us-ascii?Q?59YofvwBssYLM6ibkEmxohSh0UgedgA9jNGXP0SCnqSgwiCVxymKdLNmzbj7?=
 =?us-ascii?Q?UrlFN2HWiB7juG6lvn8Gc1MZi8rOGsd9vEx67/O0TRL3aXBPuD5nh0y6hnLI?=
 =?us-ascii?Q?ULFTYbq6cjXXs9tTtDuR/Gj0P/nFS1VHRNILtQn8UpoRhYoyXgBm+TjfFMHi?=
 =?us-ascii?Q?hAY3SfcR1MK63cRtduy1hVCk0b2M7U5JsqGSNnk3NwLOybpRYmDsSFn2ha1l?=
 =?us-ascii?Q?qBqmmy+3tA5PDLtYDcsWWS3O0e8vY5Wopnizgs8sn88Vly2OmSLLdxZK4Lvj?=
 =?us-ascii?Q?3odnKMbmgFu1e5sEcd90EB+ZVXS0KAbHxxP/jJPMKN99JPEgdqcWMMIQOlT0?=
 =?us-ascii?Q?9WAMNgEUW2KUbX12y4cVb3L95voR8r/lZJPk2PPQ3Sg1xTnRIhsgs7ijZ78J?=
 =?us-ascii?Q?tIUZSaWlpevslFxQsKLtLHYRT6z9A6xBKDvUhatD6IVQjJGeyssuaduNUo0q?=
 =?us-ascii?Q?+qth2WZi9u6GL3TjhKRZhDZ6EJnpU0x8oxsDdByn0JUINmx0ak0681LcYrCu?=
 =?us-ascii?Q?nht4h7z35arP8GOLHtCP190MTmt05DpI1IE9JNLAdb2On1Nwf6wCYIRcZqbw?=
 =?us-ascii?Q?bd1NgSTpwS4Vx78DO+EUv7OILOCsMUA9ba3QS6sdSsqEJuyOE6RF4aFl+mgR?=
 =?us-ascii?Q?FQWInHF69icAShyfAkNl3oInEpLfWmyySfarumeD7rAfUPmTer9YWUlUuwQ8?=
 =?us-ascii?Q?yGXU6SmRFIbpoR+y830xfbqXLhTfD4Qbftvg/tBjw7N64pmwqRGPeg2aseHT?=
 =?us-ascii?Q?eJeCqv1uSb57rVc+vvOV9xt47ojAJP9lHnRZnzhtsBClXQPIn946SV4XXpRv?=
 =?us-ascii?Q?8P4H4GVl3t16uFtSvHsWfm82/ijZutrtYHx7jvV6OSN9g6sW0R6dKRGTLeRw?=
 =?us-ascii?Q?y7mR2m736WB8jDhdPNDHUsyYQUpric87uZsqovC3qfbfM+QLNaTBkkYxxdE9?=
 =?us-ascii?Q?HHkCjjLIxD80KWvfz09h2U6TheVt0xxMOhgO8RoxbXRByMPza4WQBHzCdmLd?=
 =?us-ascii?Q?HnW3wR18kxbLHzokfZ1tvPTx+ul1EsYTxZTeQC9JYSH5xmYhIlxNr/wovUcV?=
 =?us-ascii?Q?drEown+Kj4NLrS0pQGfayWvBc2eLv96cvP7k1foNEUgeK+laUz+FC0paSXip?=
 =?us-ascii?Q?oegbWvz0DYffAoOD5QkiL1OEFbDTQFZMxneTyLmUExIK41ardGC1RdGj+R40?=
 =?us-ascii?Q?W0u53sUR0bq/UKHPfjDG5GYXUKwN2DncWdAg8OjN8PqChr0vbMoJKPM9l/uO?=
 =?us-ascii?Q?E2dKBLGEykP4BrN3eo6J+YRa8grWHJxKN7VZ1JsFa7+OxodmPVKPt7z1EewV?=
 =?us-ascii?Q?5kaGLJB9+ELLCFeerFelOQAHvA7G60bek2WHXU7OQzM6xv98ZS8u56ErbGmF?=
 =?us-ascii?Q?CbWHfu+3O/ShW2ssVsYOG/31wfnLyUrbHBN4+UQYOonnPibOkgow/zLR+abA?=
 =?us-ascii?Q?qtip+FPi3b4toNC46oByJ8DA1OvcRXk2ul7ltSY+fPD6LJ/+f8FFGx+0pdmt?=
 =?us-ascii?Q?nD+oJVbuawctSZP0dueTrGyPdT3GMsWKzUCGHINP+BOuewuakKKgaXujNZ+0?=
 =?us-ascii?Q?kN2/gNu6qIUCA2uCGHCR0pAB61fVNyGawZDe7ADiprC8FzqrBEPR2ZOgPUW+?=
 =?us-ascii?Q?A13WQPa2Ez6gmklcgU3AyYeVua7+T5Fg4Sp36jjgp3U+GxRR21v2haWAbjuZ?=
 =?us-ascii?Q?iiaeC0jUqZjIq65ApgozzRlIJZ03ES0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab265435-1391-415e-78d7-08da231e7693
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:38:17.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQj34edFzK7WlQGNobEiKVpkdXxWMFMyqwgHS6VDicLpTCSzkQMzdi0sG2TEShaNY5AEKb+XTc17ObASqQgNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-GUID: CqxUkVpa9tGnDE9Ls3EHUZJ-NeQkNSDT
X-Proofpoint-ORIG-GUID: CqxUkVpa9tGnDE9Ls3EHUZJ-NeQkNSDT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hugetlbfs, split pmd page table locks are generally used if
huge_page_size is equal to PMD_SIZE.  These locks are located in the
struct page of the corresponding pmd page.  A pmd pointer is used to
locate the page.

In the case of pmd sharing, pmd pointers can become invalid unless one
holds the page table lock.  This creates a chicken/egg problem as we
need to use the pointer to locate the lock.  To address this issue, use
the page_table_lock in the mm_struct in the pmd pointer is associated
with a sharable vma.

The routines dealing with huge pte locks (huge_pte_lockptr and
huge_pte_lock) are modified to take a vma pointer instead of mm pointer.
The vma is then checked to determine if sharing is possible.  If it is,
then  the page table lock in the mm_struct is used.  Otherwise, the
lock in hte pmd page struct page is used.

Note that code uses the mm_struct if any part of the vma is sharable.
This could be optimized by passing in the virtial address associated
with the pte pointer to determine if that specific address is sharable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/powerpc/mm/pgtable.c |  2 +-
 include/linux/hugetlb.h   | 27 ++++--------
 mm/damon/vaddr.c          |  4 +-
 mm/hmm.c                  |  2 +-
 mm/hugetlb.c              | 92 +++++++++++++++++++++++++++++----------
 mm/mempolicy.c            |  2 +-
 mm/migrate.c              |  2 +-
 mm/page_vma_mapped.c      |  2 +-
 8 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 6ec5a7dd7913..02f76e8b735a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -261,7 +261,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 		psize = hstate_get_psize(h);
 #ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
+		assert_spin_locked(huge_pte_lockptr(h, vma, ptep));
 #endif
 
 #else
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 75f4ff481538..c37611eb8571 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -864,15 +864,8 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
-					   struct mm_struct *mm, pte_t *pte)
-{
-	if (huge_page_size(h) == PMD_SIZE)
-		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
-	return &mm->page_table_lock;
-}
-
+spinlock_t *huge_pte_lockptr(struct hstate *h, struct vm_area_struct *vma,
+					   pte_t *pte);
 #ifndef hugepages_supported
 /*
  * Some platform decide whether they support huge pages at boot
@@ -1073,8 +1066,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 }
 
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
-					   struct mm_struct *mm, pte_t *pte)
+					   struct vm_area_struct *vma,
+					   pte_t *pte)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	return &mm->page_table_lock;
 }
 
@@ -1096,15 +1092,8 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
-static inline spinlock_t *huge_pte_lock(struct hstate *h,
-					struct mm_struct *mm, pte_t *pte)
-{
-	spinlock_t *ptl;
-
-	ptl = huge_pte_lockptr(h, mm, pte);
-	spin_lock(ptl);
-	return ptl;
-}
+spinlock_t *huge_pte_lock(struct hstate *h, struct vm_area_struct *vma,
+					pte_t *pte);
 
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b2ec0aa1ff45..125439fc88b6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -432,7 +432,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
+	ptl = huge_pte_lock(h, walk->vma, pte);
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto out;
@@ -555,7 +555,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
+	ptl = huge_pte_lock(h, walk->vma, pte);
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto out;
diff --git a/mm/hmm.c b/mm/hmm.c
index 3fd3242c5e50..95b443f2e48e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -486,7 +486,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
+	ptl = huge_pte_lock(hstate_vma(vma), vma, pte);
 	entry = huge_ptep_get(pte);
 
 	i = (start - range->start) >> PAGE_SHIFT;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e02df3527a9c..c1352ab7f941 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -94,8 +94,32 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
-/* Forward declaration */
+/* Forward declarations */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static bool vma_range_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end);
+
+spinlock_t *huge_pte_lockptr(struct hstate *h, struct vm_area_struct *vma,
+				pte_t *pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (huge_page_size(h) == PMD_SIZE &&
+			!vma_range_shareable(vma, vma->vm_start, vma->vm_end))
+		return pmd_lockptr(mm, (pmd_t *) pte);
+	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
+	return &mm->page_table_lock;
+}
+
+spinlock_t *huge_pte_lock(struct hstate *h, struct vm_area_struct *vma,
+				pte_t *pte)
+{
+	spinlock_t *ptl;
+
+	ptl = huge_pte_lockptr(h, vma, pte);
+	spin_lock(ptl);
+	return ptl;
+}
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -4753,8 +4777,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
 			continue;
 
-		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(h, src, src_pte);
+		dst_ptl = huge_pte_lock(h, dst_vma, dst_pte);
+		src_ptl = huge_pte_lockptr(h, src_vma, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
@@ -4830,8 +4854,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				put_page(ptepage);
 
 				/* Install the new huge page if src pte stable */
-				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				dst_ptl = huge_pte_lock(h, dst_vma, dst_pte);
+				src_ptl = huge_pte_lockptr(h, src_vma, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -4882,8 +4906,8 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t pte;
 
-	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+	dst_ptl = huge_pte_lock(h, vma, dst_pte);
+	src_ptl = huge_pte_lockptr(h, vma, src_pte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
@@ -4988,7 +5012,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		if (!ptep)
 			continue;
 
-		ptl = huge_pte_lock(h, mm, ptep);
+		ptl = huge_pte_lock(h, vma, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
@@ -5485,7 +5509,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			ptl = huge_pte_lock(h, mm, ptep);
+			ptl = huge_pte_lock(h, vma, ptep);
 			ret = 0;
 			if (huge_pte_none(huge_ptep_get(ptep)))
 				ret = vmf_error(PTR_ERR(page));
@@ -5553,7 +5577,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		vma_end_reservation(h, vma, haddr);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = huge_pte_lock(h, vma, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
 	if (idx >= size) {
 		beyond_i_size = true;
@@ -5733,7 +5757,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 								vma, haddr);
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	ptl = huge_pte_lock(h, vma, ptep);
 
 	/* Check for a racing update before calling hugetlb_wp() */
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
@@ -5935,7 +5959,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
+	ptl = huge_pte_lockptr(h, dst_vma, dst_pte);
 	spin_lock(ptl);
 
 	/*
@@ -6089,7 +6113,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
 				      huge_page_size(h));
 		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
+			ptl = huge_pte_lock(h, vma, pte);
 		absent = !pte || huge_pte_none(huge_ptep_get(pte));
 
 		/*
@@ -6267,7 +6291,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
+		ptl = huge_pte_lock(h, vma, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
@@ -6583,26 +6607,44 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+static bool __vma_aligned_range_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
 {
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
 		return true;
 	return false;
 }
 
+static bool vma_range_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	unsigned long v_start = ALIGN(vma->vm_start, PUD_SIZE),
+		      v_end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
+
+	if (v_start >= v_end)
+		return false;
+
+	return __vma_aligned_range_shareable(vma, v_start, v_end);
+}
+
+static bool vma_addr_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+
+	return __vma_aligned_range_shareable(vma, start, end);
+}
+
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return vma_addr_shareable(vma, addr);
 }
 
 /*
@@ -6672,7 +6714,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!spte)
 		goto out;
 
-	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
+	ptl = huge_pte_lock(hstate_vma(vma), vma, spte);
 	if (pud_none(*pud)) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
@@ -6719,6 +6761,12 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+static bool vma_range_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	return false;
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
@@ -7034,7 +7082,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
+		ptl = huge_pte_lock(h, vma, ptep);
 		/* We don't want 'address' to be changed */
 		huge_pmd_unshare(mm, vma, &tmp, ptep);
 		spin_unlock(ptl);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 58af432a39b2..4692640847eb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -577,7 +577,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
+	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->vma, pte);
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto unlock;
diff --git a/mm/migrate.c b/mm/migrate.c
index b2678279eb43..3d765ee101ad 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -318,7 +318,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
+	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma, pte);
 	__migration_entry_wait(mm, pte, ptl);
 }
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index c10f839fc410..f09eaef2a828 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -174,7 +174,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->pte)
 			return false;
 
-		pvmw->ptl = huge_pte_lockptr(hstate, mm, pvmw->pte);
+		pvmw->ptl = huge_pte_lockptr(hstate, vma, pvmw->pte);
 		spin_lock(pvmw->ptl);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
-- 
2.35.1

