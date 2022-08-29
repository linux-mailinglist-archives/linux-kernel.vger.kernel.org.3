Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9F5A57B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiH2Xlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Xl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:41:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674F832DE;
        Mon, 29 Aug 2022 16:41:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMDpTS029262;
        Mon, 29 Aug 2022 23:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=dH0bxeGGd0ag1AzHwW8p9U/ErRkmEogRjk8EZr5Dmfs=;
 b=e7VuMI8mvBXj70TB7iV+leGNMbvkQPIYiW+/AvMZeLd9fPgciZ/+fk2YySme7ViW1+or
 pJeIrK+ZblPZ5GlzA0xkPBCiuqfoEFvzc+ZFUpOCv85HAsc+ZoklCfMW3VZoupA8tfIA
 Y2/ai5tGjtQ2BP2kKCp4gkwyiz+oQHb+Dzt9KTLQWryF9P4ymH2vMkeBXn4gJTf1cIee
 lRpuIWkBp7gvdh+a0gUopKAUiiWd93DUK7Mxf4ZuttgFA5H05+SiWd/i3HgLra0mOjK2
 fCvkpmeG8ELcdRv6a5/agtIElz++VOFOwzN+18yVBvucAnmpis58wKPxgiVxRizsF3Db VQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbvryb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:41:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMBoni002882;
        Mon, 29 Aug 2022 23:41:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3d8k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcCUvEEZ6IsW5PdLGnR8rtQXaAXQIIiLdy+ERsCfn5ubv4rOG0c7jLmdDM0zLspTuAGpokxgJNdbdhLHcBEYhL94Yj8Fwo6bFr0EnkfP3vOiWvFv8yfx1H6eYAq6iI9LvMPSr6LgztpvjiTCJMftZvFG5NTpA6tgeet2NKeT8zccTrKNLgzJiJCzsJgFIUuiSitwA8cML70qUbtl9gh1ij8XnvnULSEfTPKdsIa8VEaReP3v1MHw9M/QzNNW3W8Hi09xyt4krXnq5Wzar/57LYKKF0/HZXY0ohUG71pa/0+GOivQ5LHYNCA+fx85TOYbl7iyRQcVrFV5n2qwI4xJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH0bxeGGd0ag1AzHwW8p9U/ErRkmEogRjk8EZr5Dmfs=;
 b=RijR3gYIKjThVmz05G6h4Mmdl+odz8rpn/b9JNIWi/M9s6XXiP6Qq9+eyp+hu9juIHj2tspWqknL/A1j4ECKE5gBEDbf3grjjMp15kKFQzq2EBfACKCUY8aY67TuVSbtpkAiUcRRSqkN2nV5hU0pOZ+X6r6QlkL2CDOF+Eet9vExo0yDLNN9vTULWCWYCVlh2tgJDZwnq1Cpw+n4gRvevpeHH2nkR9pjU+oGbhg3Pq5DxHEoA4O2tQ4L3is44HX9UDe1ZjxjqmgdFvDY5AzS7iCpSj1oP7I3JW9NqrfyfZrVsSsceeVmdolsdGpsAgsPJbWyszJxP1cCBusGuBjKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH0bxeGGd0ag1AzHwW8p9U/ErRkmEogRjk8EZr5Dmfs=;
 b=twXrrUrI3wNTx8PAzQq1rRW0uGceegcoiakLsUes16sSOq/uwsdzGtQxR9NLoFTAfuLIWAwriMCbK5uPdbmqdpIPpwOp45+2qaddmEn2l75sdbqzX5e7ptI7oeF5pa2HBZkBYdzH50jO/ys3ArTtEFAxa+plRvhOtKqpqpTHJ8w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3157.namprd10.prod.outlook.com (2603:10b6:a03:14f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 23:41:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 23:41:02 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Date:   Mon, 29 Aug 2022 16:40:53 -0700
Message-Id: <20220829234053.159158-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab88f935-8dd4-464a-5e0a-08da8a17eec9
X-MS-TrafficTypeDiagnostic: BYAPR10MB3157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbgU9cC8ro9z4Q/GzKZAQoj8tK5obeU6nsLMMYBX8GE1iDo3zm+H/6iikLVPw0gRBrJvyjtrnFWdUU/Nh0Y3o4xNdi/N1L/hBcHOj6eG2F9rWvuIKoauFodMzaHEuXqpHPaqRwEsE1846U9Hlgw0Cy2oMwjwaF2SMDx8ua6jhrXQEc1nocrAgyn5GzHE7LOEnQz4YRB4eRkP6VVnELrqGQlj+MJTewuj2UmijQTxbzQfcutZ9u4BVHToKggLIIBkh53yQrduHMlwf0Qy92FuXWtsR/vuQ92Ytclnj0oaL5pGIegNkuhHzDRvFdyj9qP1QWB920tH97eo3xoRSdwusQ7PXOflphX1pZ5EI2dV1ohGZ/D/ldXZPc1Yz9Fim+PkB17QnzAw6Snt/9UVZzc8C3/70u1tjHAvif/soIzIA8lQ958zL1x2DoWGbUIwhetFu+i+KMFjQpq7BVwyE1Zx6gqYoBLCffwUbdNFtVXjOWfLmmxKXNUY0BdH1+Qbb/OBt4kuHGFJ5eSjHFsGbcmS0Ok+5BDaE7WS1qOHWZO1yFrtwitqqVE68mSlSzfg826OyzKO8i6GRPLKU9gWKnZI1f4K6kfi+/2VADI2qtIo+DddEkMMuzMeui7knD67NrIpUi3YIsQJy7mfdKFeqoVqj2MozhPvSC5aOmdBaP8c80gvIEsKSH8/3UtwyolSu1i5y5yK/j/jlpHh2bIAFajnjVg63/j/qN9HNmCN87qD2TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(396003)(39860400002)(376002)(7416002)(8936002)(8676002)(38100700002)(5660300002)(44832011)(86362001)(83380400001)(36756003)(66946007)(6506007)(6666004)(107886003)(1076003)(2616005)(6512007)(26005)(66476007)(6486002)(30864003)(66556008)(2906002)(966005)(54906003)(316002)(186003)(41300700001)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ET/iac9Nqi0gQaxtPV8MXqBE2oA4xxvwvaCndB0pce2+F5Vw8lJy5s2BLeyR?=
 =?us-ascii?Q?o54emJ1UDJd9NjhtPEwxggG//43Yp69/PARDKDm1WCIdl83Lpiuz3AOE7Nnm?=
 =?us-ascii?Q?nzyEUVfiKmC5MUcZnsXUhsjoxZ0p9eYHZcuqRve8BiZW/ZymyRBKvJyhFpox?=
 =?us-ascii?Q?LJZf5aH+sdk892E/4b5fW5XosjDVG/4lL+vzJG4e5FXWGHz3P9Zv/7D7oOOL?=
 =?us-ascii?Q?7hen5TuiWbFNk1Az/U/c0btcTw8fmFtZOqbOfrJUrgJwaT9CB9DM2YTFM33v?=
 =?us-ascii?Q?YOaRZKLIk3K10dcdgWvsNLgsFj+hlE7HR0pGhiXJcnKL4lMGP0g4CiwNb0DN?=
 =?us-ascii?Q?n4uy3yCdj01wLYjFBE3r+Fs6kHENNeEHVOC2iHqeb2qlizB+vqAu81nTKMqv?=
 =?us-ascii?Q?Tks4yhfgbvOPfwQCD1U+P2H+wi8qRC/Xi/JQED+9Lufarb/7x+5oSB56QLJS?=
 =?us-ascii?Q?TT6jZ9VXCLX4lm9gN/lVaq5x+H98BsTa7PDS7r7js48gxdEmtf2PBRnP94Bf?=
 =?us-ascii?Q?ziQy9MFwyWclDQL3ThqmLhFrjhpDFx0PIoxJeJ1L5gn0WAQVyI1JIQGm7dNQ?=
 =?us-ascii?Q?W8HyPs3fFaWMONtTPofZOfpbOs8C2unBlFxmt5C1jqDY39oN4YcTlsgFoZVI?=
 =?us-ascii?Q?ZVGhfBDFZEmuy5B3VyI0on4nbZL7pifCrvmYQY0/JYZ9S4+Q+bhYem9POpcT?=
 =?us-ascii?Q?RQsIrze6zAtCTXc4HiD2w9qHNqVBgdnvb9h++M6BkV5D9vaBBNG90vdd/10q?=
 =?us-ascii?Q?cn33I8wIxNnsDTMxFPH1B+yIsmVoQRVXq/7NJBtV5ZRkuf69StHLN2YrW5pe?=
 =?us-ascii?Q?jg6IHmYCLsHTlDoYNQTyi+8t4mZSlyOwnleqAvMTU/SpeQc0cM705D1HDkpe?=
 =?us-ascii?Q?G58YhKPl8mEwV6yli1emuJzHiyIPdYHgczK4A5DyZ5AavGfTNlyoJqlSXGP5?=
 =?us-ascii?Q?G00v3pSnTolzI+n0grnjFuSxYBzlX3wisAdUvVPFW24gp3GMzqNgmZE4VWwD?=
 =?us-ascii?Q?16OvcQMMTM/4Sk7kppyjVBS3CCZMd4Y6UowfClnf8i+3NwBwhSkJNUIXw6+z?=
 =?us-ascii?Q?MPtuqk8xwQ9tiF8N0JaRPK65I0eYeQYhJei5ct5GQB93nesE2N3zLGwdioTk?=
 =?us-ascii?Q?KJv8RPrcJJcnIomlLpKhyYZqYSfbeaG0c7Yj5dDiFbVzmUz+BCJvLCKOQhmf?=
 =?us-ascii?Q?u8YSnPfcbNYg+EsEA0tnd0zpav0QEap3hUPOvJF50aqE2Ej9mL3vbKPHX8my?=
 =?us-ascii?Q?iFpXQ0JXJGjx4n7IGyBidq4GMM9ED8uU5wDrog/Izg5dvXe5jHQUCrM7ak6+?=
 =?us-ascii?Q?wlUj8t0MnBEQUBiqQs1Blhe2AIo1GzsBfYXPzo+XCkLi2AbAghm5KYy6DcAL?=
 =?us-ascii?Q?q9JM/EZv1LRDZ5uRBuFoUT2T+4zF6569sXfryvILk+j4x/ZmuVDs5c08R+qN?=
 =?us-ascii?Q?6+H4Hm97MWrgOw7DyBnZV7R7uD6mEzMrPDTJjB1o9NqbMKpg+Onrw18WkkfE?=
 =?us-ascii?Q?09T8aPTTgSqcubL0xFF0bszU3kmD2dZDtBNoz8hU6Rn1vkFg6Aloknz/qOK6?=
 =?us-ascii?Q?B0SwrYb1eligjUKTnzBXMXZqIrMbeLsYFDkA5ZJKZ5FnjuFrDwS1HI3o9trT?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab88f935-8dd4-464a-5e0a-08da8a17eec9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:41:02.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsba93DH2Yxk6FV71n1+Tpkq5klF252Ar3+ELaQnaXKzQeU0Mu3mCCONDaDKdqivoGyOPuxem3/Ygz80P6S9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290105
X-Proofpoint-ORIG-GUID: Ot_5sGcmFgzRCJvRBfIYpdY6HSMoXBo1
X-Proofpoint-GUID: Ot_5sGcmFgzRCJvRBfIYpdY6HSMoXBo1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During discussions of this series [1], it was suggested that hugetlb
handling code in follow_page_mask could be simplified.  At the beginning
of follow_page_mask, there currently is a call to follow_huge_addr which
'may' handle hugetlb pages.  ia64 is the only architecture which provides
a follow_huge_addr routine that does not return error.  Instead, at each
level of the page table a check is made for a hugetlb entry.  If a hugetlb
entry is found, a call to a routine associated with that entry is made.

Currently, there are two checks for hugetlb entries at each page table
level.  The first check is of the form:
	if (p?d_huge())
		page = follow_huge_p?d();
the second check is of the form:
	if (is_hugepd())
		page = follow_huge_pd().

We can replace these checks, as well as the special handling routines
such as follow_huge_p?d() and follow_huge_pd() with a single routine to
handle hugetlb vmas.

A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
existing routine huge_pte_offset to walk page tables looking for hugetlb
entries.  huge_pte_offset can be overwritten by architectures, and already
handles special cases such as hugepd entries.

[1] https://lore.kernel.org/linux-mm/cover.1661240170.git.baolin.wang@linux.alibaba.com/
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/ia64/mm/hugetlbpage.c    |  15 ---
 arch/powerpc/mm/hugetlbpage.c |  37 --------
 include/linux/hugetlb.h       |  51 ++--------
 mm/gup.c                      |  65 ++-----------
 mm/hugetlb.c                  | 173 +++++++++++-----------------------
 5 files changed, 74 insertions(+), 267 deletions(-)

diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..380d2f3966c9 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -91,21 +91,6 @@ int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr, int write)
-{
-	struct page *page;
-	pte_t *ptep;
-
-	if (REGION_NUMBER(addr) != RGN_HPAGE)
-		return ERR_PTR(-EINVAL);
-
-	ptep = huge_pte_offset(mm, addr, HPAGE_SIZE);
-	if (!ptep || pte_none(*ptep))
-		return NULL;
-	page = pte_page(*ptep);
-	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
-	return page;
-}
 int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bc84a594ca62..b0e037c75c12 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -506,43 +506,6 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	} while (addr = next, addr != end);
 }
 
-struct page *follow_huge_pd(struct vm_area_struct *vma,
-			    unsigned long address, hugepd_t hpd,
-			    int flags, int pdshift)
-{
-	pte_t *ptep;
-	spinlock_t *ptl;
-	struct page *page = NULL;
-	unsigned long mask;
-	int shift = hugepd_shift(hpd);
-	struct mm_struct *mm = vma->vm_mm;
-
-retry:
-	/*
-	 * hugepage directory entries are protected by mm->page_table_lock
-	 * Use this instead of huge_pte_lockptr
-	 */
-	ptl = &mm->page_table_lock;
-	spin_lock(ptl);
-
-	ptep = hugepte_offset(hpd, address, pdshift);
-	if (pte_present(*ptep)) {
-		mask = (1UL << shift) - 1;
-		page = pte_page(*ptep);
-		page += ((address & mask) >> PAGE_SHIFT);
-		if (flags & FOLL_GET)
-			get_page(page);
-	} else {
-		if (is_hugetlb_entry_migration(*ptep)) {
-			spin_unlock(ptl);
-			__migration_entry_wait(mm, ptep, ptl);
-			goto retry;
-		}
-	}
-	spin_unlock(ptl);
-	return page;
-}
-
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	int shift = __ffs(size);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..8ea3e5e726e4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -142,6 +142,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
+struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+				unsigned long address, unsigned int flags);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
 			 unsigned long *, unsigned long *, long, unsigned int,
@@ -202,17 +204,6 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
-struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
-			      int write);
-struct page *follow_huge_pd(struct vm_area_struct *vma,
-			    unsigned long address, hugepd_t hpd,
-			    int flags, int pdshift);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int flags);
-struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
-				pud_t *pud, int flags);
-struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
-			     pgd_t *pgd, int flags);
 
 void hugetlb_vma_lock_read(struct vm_area_struct *vma);
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
@@ -264,6 +255,13 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
+static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+				unsigned long address, unsigned int flags)
+{
+	/* should never happen, but do not want to BUG */
+	return ERR_PTR(-EINVAL);
+}
+
 static inline long follow_hugetlb_page(struct mm_struct *mm,
 			struct vm_area_struct *vma, struct page **pages,
 			struct vm_area_struct **vmas, unsigned long *position,
@@ -274,12 +272,6 @@ static inline long follow_hugetlb_page(struct mm_struct *mm,
 	return 0;
 }
 
-static inline struct page *follow_huge_addr(struct mm_struct *mm,
-					unsigned long address, int write)
-{
-	return ERR_PTR(-EINVAL);
-}
-
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 					  struct mm_struct *src,
 					  struct vm_area_struct *dst_vma,
@@ -312,31 +304,6 @@ static inline void hugetlb_show_meminfo_node(int nid)
 {
 }
 
-static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
-				unsigned long address, hugepd_t hpd, int flags,
-				int pdshift)
-{
-	return NULL;
-}
-
-static inline struct page *follow_huge_pmd(struct mm_struct *mm,
-				unsigned long address, pmd_t *pmd, int flags)
-{
-	return NULL;
-}
-
-static inline struct page *follow_huge_pud(struct mm_struct *mm,
-				unsigned long address, pud_t *pud, int flags)
-{
-	return NULL;
-}
-
-static inline struct page *follow_huge_pgd(struct mm_struct *mm,
-				unsigned long address, pgd_t *pgd, int flags)
-{
-	return NULL;
-}
-
 static inline int prepare_hugepage_range(struct file *file,
 				unsigned long addr, unsigned long len)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 66d8619e02ad..80ce04a5bae5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -661,20 +661,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	pmdval = READ_ONCE(*pmd);
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
-	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pmd(mm, address, pmd, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
-	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
-		page = follow_huge_pd(vma, address,
-				      __hugepd(pmd_val(pmdval)), flags,
-				      PMD_SHIFT);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 retry:
 	if (!pmd_present(pmdval)) {
 		/*
@@ -764,20 +750,6 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
 		return no_page_table(vma, flags);
-	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pud(mm, address, pud, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
-	if (is_hugepd(__hugepd(pud_val(*pud)))) {
-		page = follow_huge_pd(vma, address,
-				      __hugepd(pud_val(*pud)), flags,
-				      PUD_SHIFT);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
 		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
@@ -797,7 +769,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    struct follow_page_context *ctx)
 {
 	p4d_t *p4d;
-	struct page *page;
 
 	p4d = p4d_offset(pgdp, address);
 	if (p4d_none(*p4d))
@@ -806,14 +777,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	if (unlikely(p4d_bad(*p4d)))
 		return no_page_table(vma, flags);
 
-	if (is_hugepd(__hugepd(p4d_val(*p4d)))) {
-		page = follow_huge_pd(vma, address,
-				      __hugepd(p4d_val(*p4d)), flags,
-				      P4D_SHIFT);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 	return follow_pud_mask(vma, address, p4d, flags, ctx);
 }
 
@@ -851,10 +814,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 
 	ctx->page_mask = 0;
 
-	/* make this handle hugepd */
-	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
-	if (!IS_ERR(page)) {
-		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
+	/*
+	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
+	 * special hugetlb page table walking code.  This eliminates the
+	 * need to check for hugetlb entries in the general walking code.
+	 */
+	if (is_vm_hugetlb_page(vma)) {
+		page = hugetlb_follow_page_mask(vma, address, flags);
+		if (!page)
+			page = no_page_table(vma, flags);
 		return page;
 	}
 
@@ -863,21 +831,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return no_page_table(vma, flags);
 
-	if (pgd_huge(*pgd)) {
-		page = follow_huge_pgd(mm, address, pgd, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
-	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
-		page = follow_huge_pd(vma, address,
-				      __hugepd(pgd_val(*pgd)), flags,
-				      PGDIR_SHIFT);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
-
 	return follow_p4d_mask(vma, address, pgd, flags, ctx);
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..b3da421ba5be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6190,6 +6190,62 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
 	return false;
 }
 
+struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+				unsigned long address, unsigned int flags)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long haddr = address & huge_page_mask(h);
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *pte, entry;
+
+	/*
+	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+	 * follow_hugetlb_page().
+	 */
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
+		return NULL;
+
+	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	if (!pte)
+		return NULL;
+
+retry:
+	ptl = huge_pte_lock(h, mm, pte);
+	entry = huge_ptep_get(pte);
+	if (pte_present(entry)) {
+		page = pte_page(entry) +
+				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		/*
+		 * Note that page may be a sub-page, and with vmemmap
+		 * optimizations the page struct may be read only.
+		 * try_grab_page() will increase the ref count on the
+		 * head page, so this will be OK.
+		 *
+		 * try_grab_page() should always succeed here, because we hold
+		 * the ptl lock and have verified pte_present().
+		 */
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page = NULL;
+			goto out;
+		}
+	} else {
+		if (is_hugetlb_entry_migration(entry)) {
+			spin_unlock(ptl);
+			__migration_entry_wait_huge(pte, ptl);
+			goto retry;
+		}
+		/*
+		 * hwpoisoned entry is treated as no_page_table in
+		 * follow_page_mask().
+		 */
+	}
+out:
+	spin_unlock(ptl);
+	return page;
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -7140,123 +7196,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-struct page * __weak
-follow_huge_addr(struct mm_struct *mm, unsigned long address,
-			      int write)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-struct page * __weak
-follow_huge_pd(struct vm_area_struct *vma,
-	       unsigned long address, hugepd_t hpd, int flags, int pdshift)
-{
-	WARN(1, "hugepd follow called with no support for hugepage directory format\n");
-	return NULL;
-}
-
-struct page * __weak
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int flags)
-{
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t pte;
-
-	/*
-	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
-	 * follow_hugetlb_page().
-	 */
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
-retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
-	/*
-	 * make sure that the address range covered by this pmd is not
-	 * unmapped from other threads.
-	 */
-	if (!pmd_huge(*pmd))
-		goto out;
-	pte = huge_ptep_get((pte_t *)pmd);
-	if (pte_present(pte)) {
-		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
-		/*
-		 * try_grab_page() should always succeed here, because: a) we
-		 * hold the pmd (ptl) lock, and b) we've just checked that the
-		 * huge pmd (head) page is present in the page tables. The ptl
-		 * prevents the head page and tail pages from being rearranged
-		 * in any way. So this page must be available at this point,
-		 * unless the page refcount overflowed:
-		 */
-		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
-			page = NULL;
-			goto out;
-		}
-	} else {
-		if (is_hugetlb_entry_migration(pte)) {
-			spin_unlock(ptl);
-			__migration_entry_wait_huge((pte_t *)pmd, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
-	}
-out:
-	spin_unlock(ptl);
-	return page;
-}
-
-struct page * __weak
-follow_huge_pud(struct mm_struct *mm, unsigned long address,
-		pud_t *pud, int flags)
-{
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t pte;
-
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
-retry:
-	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
-	if (!pud_huge(*pud))
-		goto out;
-	pte = huge_ptep_get((pte_t *)pud);
-	if (pte_present(pte)) {
-		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
-		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
-			page = NULL;
-			goto out;
-		}
-	} else {
-		if (is_hugetlb_entry_migration(pte)) {
-			spin_unlock(ptl);
-			__migration_entry_wait(mm, (pte_t *)pud, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
-	}
-out:
-	spin_unlock(ptl);
-	return page;
-}
-
-struct page * __weak
-follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
-{
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return NULL;
-
-	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
-}
-
 int isolate_hugetlb(struct page *page, struct list_head *list)
 {
 	int ret = 0;
-- 
2.37.1

