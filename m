Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F1536912
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355085AbiE0W7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbiE0W72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:59:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A513327A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:59:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RKldMU006274;
        Fri, 27 May 2022 22:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3zEOXDOnNVDX1cmb24BXpclDgrucJjzYv60skjVuz1w=;
 b=WMD0C1dbAFIJPBuBh/Sdm+Qi14EjYr4+N7c7cwgYnCtFZahFTipWPMlU88DhKPsoL0cZ
 KnSZSF6YZ24IFNCrx/ADeLr8SQmNlRe5ypSfFmc1AM8oft9GXl4MYRGadJGtl3/ZuciU
 hP4GIaLftcld66wKzd+H+vVZV57I6pvubE3k7QG8g6b9HCiS0gveyQw+VFbJSSthpSCS
 yFSUiI+xaw/Tjx4jVAgvViSdJ0/soghAQSLTMkcEj9yquYZ6npDyMoy4OYn8ejbd+A0t
 3nUdtGBqslzzNwhn1np42Q8T2I89ou9qm8+alDqbli0X3/OcUa44ngktk+S0IIXi1Evb Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc8cex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RMoHiH009606;
        Fri, 27 May 2022 22:59:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wys19p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drJBCzgf4OQAbPL2G5T8lzOWjquKOHWhtg6Rn0/jpMHFTE9DfOYl3hHUtKM0bX9kARIydyZ1kjrYMcL0WiV913ImkiNnCzbMPcF1yWQrShQZ+YLaq6h53VIeUlqIeD320S7vWtA0zVofOsfEBWcj5ZbAk8ws89aW5MQb5H5PzCJBNaS4V05oUi5X1U1229KdV+jFtxIZy4Yp/NO5lIy2edvvId3TMCfrc9QNIoQrC1TgAJAiGv7mXTAYD5vWHA/yCr2KWkSc1xxyl8HhPD+KoFM92Yq0nhr4wIE5VYGOBibJznvVDvPpabzaJ5noR5+GPyL6I7n5J9M981BXGFOcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zEOXDOnNVDX1cmb24BXpclDgrucJjzYv60skjVuz1w=;
 b=IwQ13nSzn9r40iYiyDLQku/McObryMt38vYOtAqz5k8gDnArESAivoPB98UEMTZgsBwdcLA611ILrtt0UGRu6XKhzTvC21e0kVlfbBfJj638GWCH5ShyQJSqhuAN5wk3GWNv68P9/zym7BJX/GWDdhQ9UjxAGiVdPdNsuW4iy9nesCutJBwbI7WQlp5ucf4ME3XpGhZ3hFWUlOYxe4yt1jT/jWvzvlZ/ecVboAEZ+V4b1I+ryBuYgbqVPNYzKEWZIL3w/5igV+8ht64FaRg51uy6vR3pz1/AkDsKTsdrPxfn8XgbY/z+FMzTKIREFTnuGBzWL6AVatcIH7OMHYHhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zEOXDOnNVDX1cmb24BXpclDgrucJjzYv60skjVuz1w=;
 b=xl0MoRvStaJtP3btr386iQCnY3nY8K+FQbx23BGO+fYKza9nE0ZWDCMnJ5DTcTXbwXpzHpQodCZ+TetaY+wUdrsD/RLVg+PeKpgyosZHKj0rRqNGXOWQkSbQFkYBwX/K8ig1dSWdn0PJZamB2XKEsn3AA9Tf1yv8b/sMx+36xJc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 22:59:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 22:59:03 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte not present
Date:   Fri, 27 May 2022 15:58:47 -0700
Message-Id: <20220527225849.284839-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220527225849.284839-1-mike.kravetz@oracle.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c51018e1-f5bf-4799-7b85-08da40347e65
X-MS-TrafficTypeDiagnostic: DS7PR10MB4831:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB48319167D8FF955E344BEE31E2D89@DS7PR10MB4831.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNBpEErFZEsfyJQKOQDlQFsgtURvw4ysEM9U/zLpmmEg63lwD6hXu1Z7xvaJdVWk5v5+AQTEDR2UpIyGCN4BNz9jZmpmAq5uXN4U4ey1yNAM4XJx6LclGqSF5pmQzRLGqCSax8ztI0cKUfTWnAtXr2FezE6hvlPTudb0EVJT7soAMJoQTLHihOV+hxtxLov+EbGIztHpooHlijtuAuc7bixjiZJpB7phOfqHqjFmhX/QglKmmEwG8AjgzHSwF7Jqq0TIngmkjvkhz8hh1vTWiVKt5yUleDz2BwBZWU4VrJ+xnB7sg9y2aoZ59XVv93gWGGrFgNBPCojUK/pryjebKrXg+rdQ5e73Jw7S2S18yIVxBoQfljjKLqrMC+v3rPN/2A2SpgajscRNTdbGAXukC4rxUUzHuZEo4+RKFUrbqwsomlW8TDkEyuTQLP5B+iss+dXqPNIHmmAU2zEsh6RP6ldk7ytiQn55hZDQt5PnkdN90vrB6WeejiIM7HzVf3S5qvAqtkhgp6e0JYk5g9KKFc8vC/+ibwFCTgB+Wl974/MT09eP/0kiqMEA97qqERVCh47BWfzW9BddGlYxMSoE75wfx5HBaUwIpk1iWYmxAiek3hTh/6oegX4y1M32iEuZbj2/gwesW7C2dHLU9ZfOPRlXIeEDvIFKBZFEn0BBEvJqhV58DGoM4xJr/sgOBedFN5fwz5XmjhzOmYpK+ksocw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(6512007)(6666004)(5660300002)(2906002)(52116002)(508600001)(44832011)(8936002)(316002)(86362001)(66556008)(66476007)(66946007)(4326008)(8676002)(6486002)(54906003)(7416002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lDWOWtqURVwYl4lbdgQr8szMg1ITLFvfAQ2psuUack8Z85Smj3B+Kz4Wu6G?=
 =?us-ascii?Q?Tdsr3gujDhyg+IFzCO3qaZ8gDU5qGhblekF/DDClP3+xduK9LCdJodKsdo6Y?=
 =?us-ascii?Q?ERwzAWFiwiX/K4kkxVFl4XsK/BId31IMYNM65yH7tweniVM7+N/f67LQ3u7y?=
 =?us-ascii?Q?QkZmijOArvH1mrm34XCOPlhH1v55hu4hnBYEH+fWyGXrV7tqKhrzbGFnRXam?=
 =?us-ascii?Q?hws2gVpqBrdkUk7OfZ30pAREhhAQHLEwRlklByTJ6T20wBcoYMQTjbk7bHoV?=
 =?us-ascii?Q?SKjRf0cV0j4VQHDcIXdIFz2+gMM1cQRW6nJMwU2vcPlVDVwLbClIxlpveb7M?=
 =?us-ascii?Q?h7ngPTG4qWNTEitHGvA/m4NOXZrAIGXksCkPllj0Cdn2OZv0oA41r2iRuDVw?=
 =?us-ascii?Q?woNP17FiI1D/pSYvYy8aw/1H7IV6UESXqyWhZwSHXfPA6bc5jEGQmdSfJ6J4?=
 =?us-ascii?Q?vwJHw8qJGpHtdEfYMXc3V2FtEkut76emWIdyEjfdn+PaBxfQV19YkL0w5wG6?=
 =?us-ascii?Q?Kc184oJV5opV4gmvAJzDKViSycZxSPuPgTfIRwepG+ZZktz+9YAvXWuC61LI?=
 =?us-ascii?Q?W0hjhQ62eXjmMGhV+bRIvCUeeg7nYOwRSAQTkz8thRiI1Vysb249eGA/OPvB?=
 =?us-ascii?Q?e+thCdGA97flMWWXmy3MGEsBiljbvkQHF0vugf5Srtczvnxxpvl7D+jZLMl8?=
 =?us-ascii?Q?2AigNRXOm88/pvluLV1Tu307OagO91brO56lEWzLjcyjKTfAAKtmCO3sU7g3?=
 =?us-ascii?Q?vQ7bWTh0KXxLxFQEeYzLfT5ZNQS77PekH354PqvxCqBiHF8AAIrZYuADr/MJ?=
 =?us-ascii?Q?M2wEPMo8wdg9SKdk0/45pcN4iATk3gdfn2LHqJOaWp4EiQEb73XLHHf7VoYg?=
 =?us-ascii?Q?oEM0sV631E/h0qYMdfuIwRwPHBytO16EbzcnJZalGorIYiFXBOiLqyjMknfo?=
 =?us-ascii?Q?JUzEnRg6D7r0x4IwwnaJ+zCR12gFKq7MpKXtLq+LfU6rnCkm7CkGChQgBqJY?=
 =?us-ascii?Q?PgIEWz/TlxMv0ZWp8jO98NMWZkGGaDxPGEpvySisJ8V4YidlpRvmG9rWfo2a?=
 =?us-ascii?Q?KFGLat3GEK+NzFnTYLEH0e+ozb3uwwf6kSHxjf97mx6sdEOkgxrQbYTYp6k+?=
 =?us-ascii?Q?Ph1CVnROzcyx/Kuh30nDVtyvd7ZPKpgVmoTvoO1ESwnTFbO1lcpl6p/ODRwO?=
 =?us-ascii?Q?3ZfI6b3Uc/9vZwDeqQ6HgTu7jbfmZNvLSBLPADIAbNStccv5Mz9A1/o7Oaw3?=
 =?us-ascii?Q?MzQUG+HnWE5Fu3oAaDpHRRrLHbigrZ8voSDZIwNobufYJ/24he4B8LTk797v?=
 =?us-ascii?Q?lrBZk4spPOOB9mPgS2hZskCBnHGMdtrLIpxplye+qGKqfbX5Zv05O/Q4POVU?=
 =?us-ascii?Q?saX83zeDVNDLeRC4wheEKFgqm211VYx7WX5LXQuqIzSRNzySvwcwWIFrQyub?=
 =?us-ascii?Q?e0nOoGbAFiCg/tc6OwwvKmOkkFGwuz4iNrQzVy1qXOoQEyR585/UeIMnBfql?=
 =?us-ascii?Q?E61CAxnud6zZtbjq062nTn8XgAN7DT2gvQpvtw/GvHCFYzxDarcqcLDxpptI?=
 =?us-ascii?Q?J1k/n1bDYj7Sfui+bYQgJCItrj3g0+x/IqDVxDu9Sxx6V34v/zh+uTtT078B?=
 =?us-ascii?Q?i6RyYx824nv7c7VV8icfVR4y0+YnytKT4PeccaOUUYLutVaCGaRhAkRfvJ56?=
 =?us-ascii?Q?3iDHmuclXor5AVgRgzw71XwFZhcXlG4gAjKOAj4rKCu+CC8osPh1LIS0yb4a?=
 =?us-ascii?Q?Z/7iyZacICXi3Dn8DruMJ9tPaxfPnmU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51018e1-f5bf-4799-7b85-08da40347e65
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 22:59:03.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpzUJwew93OyEjoQzxSxSeIwZ2I5bxBuvlgJNeWiJM13UGaY5nlNWRCFfwZUM2Jf4MrGD20s/SkXpxtZZWo6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_07:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270111
X-Proofpoint-ORIG-GUID: gYnZrLLda-e_fdbSDCoMVcYP8red8kdU
X-Proofpoint-GUID: gYnZrLLda-e_fdbSDCoMVcYP8red8kdU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HugeTLB address ranges are linearly scanned during fork, unmap and
remap operations.  If a non-present entry is encountered, the code
currently continues to the next huge page aligned address.  However,
a non-present entry implies that the page table page for that entry
is not present.  Therefore, the linear scan can skip to the end of
range mapped by the page table page.  This can speed operations on
large sparsely populated hugetlb mappings.

Create a new routine hugetlb_mask_last_hp() that will return an
address mask.  When the mask is ORed with an address, the result
will be the address of the last huge page mapped by the associated
page table page.  Use this mask to update addresses in routines which
linearly scan hugetlb address ranges when a non-present pte is
encountered.

hugetlb_mask_last_hp is related to the implementation of huge_pte_offset
as hugetlb_mask_last_hp is called when huge_pte_offset returns NULL.
This patch only provides a complete hugetlb_mask_last_hp implementation
when CONFIG_ARCH_WANT_GENERAL_HUGETLB is defined.  Architectures which
provide their own versions of huge_pte_offset can also provide their own
version of hugetlb_mask_last_hp.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 58 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4cff27d1198..25078a0ea1d8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -194,6 +194,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
+unsigned long hugetlb_mask_last_hp(struct hstate *h);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long *addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c468ac1d069..a2db878b2255 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4731,6 +4731,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long npages = pages_per_huge_page(h);
 	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
+	unsigned long last_addr_mask;
 	int ret = 0;
 
 	if (cow) {
@@ -4750,11 +4751,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		i_mmap_lock_read(mapping);
 	}
 
+	last_addr_mask = hugetlb_mask_last_hp(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
 		src_pte = huge_pte_offset(src, addr, sz);
-		if (!src_pte)
+		if (!src_pte) {
+			addr |= last_addr_mask;
 			continue;
+		}
 		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
@@ -4771,8 +4775,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		 * after taking the lock below.
 		 */
 		dst_entry = huge_ptep_get(dst_pte);
-		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
+		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry)) {
+			addr |= last_addr_mask;
 			continue;
+		}
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
@@ -4933,6 +4939,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	unsigned long sz = huge_page_size(h);
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
+	unsigned long last_addr_mask;
 	unsigned long old_addr_copy;
 	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
@@ -4948,12 +4955,16 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
+	last_addr_mask = hugetlb_mask_last_hp(h);
 	/* Prevent race with file truncation */
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
-		if (!src_pte)
+		if (!src_pte) {
+			old_addr |= last_addr_mask;
+			new_addr |= last_addr_mask;
 			continue;
+		}
 		if (huge_pte_none(huge_ptep_get(src_pte)))
 			continue;
 
@@ -4998,6 +5009,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	struct mmu_notifier_range range;
+	unsigned long last_addr_mask;
 	bool force_flush = false;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
@@ -5018,11 +5030,14 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 				end);
 	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
 	mmu_notifier_invalidate_range_start(&range);
+	last_addr_mask = hugetlb_mask_last_hp(h);
 	address = start;
 	for (; address < end; address += sz) {
 		ptep = huge_pte_offset(mm, address, sz);
-		if (!ptep)
+		if (!ptep) {
+			address |= last_addr_mask;
 			continue;
+		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
@@ -6285,6 +6300,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	unsigned long last_addr_mask;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
@@ -6301,12 +6317,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
+	last_addr_mask = hugetlb_mask_last_hp(h);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
 		ptep = huge_pte_offset(mm, address, psize);
-		if (!ptep)
+		if (!ptep) {
+			address |= last_addr_mask;
 			continue;
+		}
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			/*
@@ -6857,6 +6876,35 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *)pmd;
 }
 
+/*
+ * Return a mask that can be used to update an address to the last huge
+ * page in a page table page mapping size.  Used to skip non-present
+ * page table entries when linearly scanning address ranges.  Architectures
+ * with unique huge page to page table relationships can define their own
+ * version of this routine.
+ */
+unsigned long hugetlb_mask_last_hp(struct hstate *h)
+{
+	unsigned long hp_size = huge_page_size(h);
+
+	if (hp_size == P4D_SIZE)
+		return PGDIR_SIZE - P4D_SIZE;
+	else if (hp_size == PUD_SIZE)
+		return P4D_SIZE - PUD_SIZE;
+	else if (hp_size == PMD_SIZE)
+		return PUD_SIZE - PMD_SIZE;
+
+	return ~(0);
+}
+
+#else
+
+/* See description above.  Architectures can provide their own version. */
+__weak unsigned long hugetlb_mask_last_hp(struct hstate *h)
+{
+	return ~(0);
+}
+
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
 /*
-- 
2.35.3

