Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461BC53F138
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiFFU5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiFFU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:56:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BBC5D8C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:45:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KC7oX032448;
        Mon, 6 Jun 2022 20:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8mBclENT70Amq1G/+YFQ5vVgG1jGKH43y17kCMnkpHg=;
 b=ssKiQm0+jLmxy7t0irrPapbTKT7NRqoyKAQj4O30Rx0Jk0AScwuceucIPqbmDvT+If88
 UXnx93iKMuu1LBai1zfSAXlIS4eCn6kRZO2VrymARX5qhFCiqr5ysH/k73ha1SGwsUHx
 jxEl75iuQajNmJHB3E0oAf0pQPpOVLiY/qLxFRAQy9BClB3ggqI/hlJkpMv8daWRCkmb
 fcw2smnVZjyManqMsHQTyXtPiITU2qcJvqzLbxjPJCen+CSEUMv4Fm9hMNhcXZbmKMKg
 +KqYYLOm2gvVX54Rl1N/0c+2KjzJcva0me7yzk2ihlfHnCZRGNBGiXHQ8zUUiHsiWL4O 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe9gg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:42:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFlFe015993;
        Mon, 6 Jun 2022 20:39:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu80abu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfKUD6r8+ix0nGpxtD4fgYEuOQauraMjypQKyG+s5CR5sTYJNUtyBNPrGF8VF8xV7/9VlApSpQ/l70OKhLJ12Cgw1NQyzI6IZ9F0/n2ofGRPOx/ie9NYdAGZsHsIwEI9fYiQGCeMyJotK0gtqcYI9XnPcVmgMCQlnoaKAjnB0w5i6lDNJOKfgEFrqx9YIyAS8Juai7JhJ5Bnq84Vpb/Ja6PwpEuZaEuOggA6Uqza4F71lIPIV/I6OIJHlVvUHzeBCA8mTLCCoATVlA2AaBY3p2Th9sRqtZz1mXr/UuOK/ges2sybDMdsa3O9XvmidQeWWt2th2dwXcL3i+/c3XI41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mBclENT70Amq1G/+YFQ5vVgG1jGKH43y17kCMnkpHg=;
 b=FNFlwRhCTOhRMIn9QRIbtqa190G0xvwQkW/9ASmyt3aCo07cYGe2gklAqRMMduNr518WvkRRgBRHVEleak+TCDzR/5NgQByA7Wh6ez9bfx49+XdMp4fv+TAVjNmAdXU0s21uOXOzofKcm4DZwvTXOow70g91jN5iHbB05d5bXSObVxF/z6TuwwPN/d3sABHv3KCf4Yf3o8NUvh/gI1retxIOldZjsQchGdyDmB8LF8JyodRMyvr69csHKkjFiDbzz1ZAIXkDU0YsyQHV66JKAbXyUPecjlsG1/IqRlqAoX5E6wespnpycKRMopHNPWVV1FWs3fVRP8rju5jMEjLsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mBclENT70Amq1G/+YFQ5vVgG1jGKH43y17kCMnkpHg=;
 b=M2XDHhDE7NOByRhz2oPJhq2uu91cD+/pXwfTQJjCsaaCez5xNG7dqdDvUvUE2zR9OSlGAbeYSzIasBmfjQ/PcsZYY8oVNuHqKmnHz/7ekX3DX96ezUe1sgl15i0TCkdVmu7jZ7jfBmOFMA5t4r0Qg3c6HhQ4hvEDzdQJ4Rz4q6Q=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:58 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:58 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 17/21] clear_huge_page: use non-cached clearing
Date:   Mon,  6 Jun 2022 20:37:21 +0000
Message-Id: <20220606203725.1313715-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa14bfc6-43b4-4304-dc61-08da47fc94a3
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB273445C5234CAB09AD1CAB68CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xos1bSqd+WLMESSmWbeKrIwpXVgDzRjkvhFLLeYezc6ihED1DRg4+5ztmSYjh9iHSmpwPB/JgDUnC6gFXjuV1OgscB8guAb99N+Ovbd7dBMzQ9Y1omkZVD5EETSfEnAwtn/M0YybcNfYSiIg6mNY3QWzrCHAqZVYilnGD5DqLWI22Yfg5dt0Vy/Og19NOXnM9PEVXMlDBR27MhD8Gk5+H7AkJCQKLMSGCqC+/wL02XnBdO8nI6cx6e7vw6eXdHRKWutDw+Bib7lWl3oQVbZ6R5ZgxtNeXHiYBHiytb19Aq6j+ecJ/tXojeyc/iHALRYY+vTYKjD6WvK2KTo+Yamo1D4GWJPn+C5Y5j4C3tAZqlpcwFKBdECyL2FY42g2E7nZLvi4Me3B6W8ZqvcJZdzj2Va0HgBvc5MjhYh17Se6ft56MMU24vb77GhhGVajCLy/QDt5M6c2TDeRml7gA4ZpuImUh3mLULShT2jbT6ddFTo6OoWHfmiBbDaTzrNfuideVpNRKhIPrEJigLmX1ho14JEHpDcoDzI28s8veNTuRueuP7FgRES8AXU1bzx8tc0p0v1O5IpyfXns1EFJuStJUr46OwXLxY+OBD1A7ec/wHUNsP68uNMbtEx8cSfljLu9g5Hda02fEPqMlQoQKhGW7zmLySDhjEDBpqAGBTYKqF+wo2ahY/0rdOxReGQdFNVUee7UdRuWZ154QzBMIP8dERCUAmIZcwOwLAa7YOBxsV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWz5DL1GJZLHk3Nyvpu6h2mAj2K9Jt8bL6wBRvFXNCtfAX6i6i30OsHZ9Yn7?=
 =?us-ascii?Q?+iUf4bQJYE5szeVykN+22SP9mSd0enRQfH2lVTPfqc2QRYX9E1J9Ds5Rx7pu?=
 =?us-ascii?Q?FrbR9m0GdgT5HdfCVAscnhcDmXf/elhrXs3sFdl12pOyw/Vm5hfpxLKwIJt7?=
 =?us-ascii?Q?HcKsPuWovx6mlUn4t4zzfRoojw+ktmRlbswmLY/NU3LDcm+Wevcfujy9xBeJ?=
 =?us-ascii?Q?b7g0hxRnXEwKeuL1q8gYlrX9Ans4VcsLGO1OMh4HjGdfBzqI48p1X1IFRy7v?=
 =?us-ascii?Q?jkeVgVe5yqdJ+gZFX5Br8Xn5YCRQhT0hJaTPtO4DFquH/RO0srZxWpkbszec?=
 =?us-ascii?Q?vb5WyHuVMwfxAIQw8aFa4+wOPwe1mIaa4rP/TZbOKiAblAwg8oItgLkCGu5a?=
 =?us-ascii?Q?jOmGVj2KYS0VnU241ZKiSgQtJQL9fAb027OzElsBcHRbOZ0a0r1oi8QJgbqB?=
 =?us-ascii?Q?mxHGq2gO8a0L2tjesy+LhI5bqd8qWZugaU935C8pLPD6AgzJuTihjD05N9/E?=
 =?us-ascii?Q?nO8MHNC6NyfP2CMIP51wmqV65qFc7TFS8Te26wh0KNbv/Kp5n9RS3c95dp/b?=
 =?us-ascii?Q?X3tHtsYApv/rfDGswDnhjnLxZcAeU0lMRJNfzhRbteYt1JOyuLI+MW8hVsih?=
 =?us-ascii?Q?H4KvGYrHMca3ok55QqzRF52rhaFcfFokXYeV9NyI5nUEbRTOGcDoqWuOofNu?=
 =?us-ascii?Q?JhMD8sNTckFpmFuA/fuN/wYNXVwC1ZFdKLYmCtmBd5UyRynm3AZ0ADN+wECG?=
 =?us-ascii?Q?+iXy4umBXEyWXnmfgvDgEXIP2fJ4EaejWuX7m6KA3OhINoWU62KtAPTIc1aw?=
 =?us-ascii?Q?vZjgbOZJOAY1jFwyANO4lpTQwM0lseDGFhh4zruSCeq8FtVeAa0q+HwX/h7H?=
 =?us-ascii?Q?dxCDrCJPTGIVVd66M46YS0wRmi/wcKmv+ACLXJ5wueqRIGjARbWxHcaeOSoC?=
 =?us-ascii?Q?Fw6xKXYHMf/gIlL+DLSqAKIAnqGOmJGe38BKVylSR9V7Y2vDUNfaApEfBfEk?=
 =?us-ascii?Q?ANJ+TaxolVvFM50+57hefKNbukCjZ3GBccDf8j9K/nhhNsJokoMHutPZMCfz?=
 =?us-ascii?Q?zk0ReM5j6Hi3QP58NyPgHVUwBm+3Ix9Vk4dqud8FUiWsNHFcLoA2/XStXBGO?=
 =?us-ascii?Q?mz8iRaMJnbn2QFI1+5F+crCtcBE+0+NLoOG0yhAU1ljKKMZTh1lP8NcEjzS7?=
 =?us-ascii?Q?vM+ib2bvL+XHGKUMOj1e0pyG7HiGlHX7oq/OiM1+c+hksjXUBw5bw3/rmjGT?=
 =?us-ascii?Q?CGCXTVWsE6B8IFAF8AijZU0M6B7DrSFL0V1YtFB40KnDvPm6DYiBPMQ88U2h?=
 =?us-ascii?Q?iWGUMQiVtWF8oIiUHHgpxsia822sHcQ10DZ2a6kPIjPgdLzxb5Eu8DZ6eV3E?=
 =?us-ascii?Q?CvJ7bXLy0/cKBUobJtIO3o80G4oDu88fGvDv3gY/bhcyEYu2BOZxznjrqxSn?=
 =?us-ascii?Q?JgWfSq5xxQ2xnLOvw+/7cOwjJdYpNzd5Fa6e7gDf9MCTgIixRDVj0928uqxH?=
 =?us-ascii?Q?KtjkGFsEwDVj77koM8gMZ/9iRg+nh6/NeqUL362Tu/M7EomDHqNSsgBo1DUX?=
 =?us-ascii?Q?360XgnCJyBnFuC9hDk6fCIDfNGorWvzrnYQVisnfKZ1WWyfTsPFN6eE2fQvM?=
 =?us-ascii?Q?b9uQE0GMt6eFaQAB20DwnsqY3e9qstltUm10KX3Kd9/hxLg8pj9etHFBrQjC?=
 =?us-ascii?Q?MXqxzH3b1GBqc8lTsgcP5mZYUuvAtjQ5kBPWSjgnQpJ3Km1U+gmVMaSajtbR?=
 =?us-ascii?Q?IFnabYJpdyFi3crGuq/WZJcRvxdeK9k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa14bfc6-43b4-4304-dc61-08da47fc94a3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:57.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFRqj3hGiXwIyqp9zTxNHE6pNvpRauLgh79wol6Q6dUWlQQqryuPfYyhRR/qEcKBZaM2Gjg2szs/1xEDipl2m5IOJmUFx7UX6xBQgpuZnP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: djNFwhlMr1ZTXJLmPx9yzZSzZ4CaudUo
X-Proofpoint-ORIG-GUID: djNFwhlMr1ZTXJLmPx9yzZSzZ4CaudUo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-caching stores are suitable for circumstances where the destination
region is unlikely to be read again soon, or is large enough that
there's no expectation that we will find the data in the cache.

Add a new parameter to clear_user_extent(), which handles the
non-caching clearing path for huge and gigantic pages. This needs a
final clear_page_make_coherent() operation since non-cached clearing
typically involves weakly ordered stores that are incoherent wrt other
operations in the memory hierarchy.

This path is always invoked for gigantic pages, for huge pages only if
pages_per_huge_page is greater than an architectural threshold, or if
the user gives an explicit hint (if for instance, this call is part of
a larger clearing operation.)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/mm.h |  3 ++-
 mm/huge_memory.c   |  3 ++-
 mm/hugetlb.c       |  3 ++-
 mm/memory.c        | 50 +++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5084571b2fb6..a9b0c1889348 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3302,7 +3302,8 @@ enum mf_action_page_type {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
-			    unsigned int pages_per_huge_page);
+			    unsigned int pages_per_huge_page,
+			    bool non_cached);
 extern void copy_user_huge_page(struct page *dst, struct page *src,
 				unsigned long addr_hint,
 				struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a77c78a2b6b5..73654db77a1c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -594,6 +594,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	pgtable_t pgtable;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
+	bool non_cached = false;
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
@@ -611,7 +612,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		goto release;
 	}
 
-	clear_huge_page(page, vmf->address, HPAGE_PMD_NR);
+	clear_huge_page(page, vmf->address, HPAGE_PMD_NR, non_cached);
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
 	 * clear_huge_page writes become visible before the set_pmd_at()
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c468ac1d069..0c4a31b5c1e9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5481,6 +5481,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool non_cached = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5536,7 +5537,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			spin_unlock(ptl);
 			goto out;
 		}
-		clear_huge_page(page, address, pages_per_huge_page(h));
+		clear_huge_page(page, address, pages_per_huge_page(h), non_cached);
 		__SetPageUptodate(page);
 		new_page = true;
 
diff --git a/mm/memory.c b/mm/memory.c
index b78b32a3e915..0638dc56828f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5606,11 +5606,18 @@ bool clear_page_prefer_non_caching(unsigned long extent)
  *
  * With ARCH_MAX_CLEAR_PAGES == 1, clear_user_highpages() drops down
  * to page-at-a-time mode. Or, funnels through to clear_user_pages().
+ *
+ * With coherent == false, we use incoherent stores and the caller is
+ * responsible for making the region coherent again by calling
+ * clear_page_make_coherent().
  */
 static void clear_user_extent(struct page *start_page, unsigned long vaddr,
-			      unsigned int npages)
+			      unsigned int npages, bool coherent)
 {
-	clear_user_highpages(start_page, vaddr, npages);
+	if (coherent)
+		clear_user_highpages(start_page, vaddr, npages);
+	else
+		clear_user_highpages_incoherent(start_page, vaddr, npages);
 }
 
 struct subpage_arg {
@@ -5709,6 +5716,13 @@ static void clear_gigantic_page(struct page *page,
 {
 	int i;
 	struct page *p = page;
+	bool coherent;
+
+	/*
+	 * Gigantic pages are large enough, that there are no cache
+	 * expectations. Use the incoherent path.
+	 */
+	coherent = false;
 
 	might_sleep();
 	for (i = 0; i < pages_per_huge_page;
@@ -5718,9 +5732,16 @@ static void clear_gigantic_page(struct page *page,
 		 * guarantees that p[0] and p[clear_page_unit-1]
 		 * never straddle a mem_map discontiguity.
 		 */
-		clear_user_extent(p, base_addr + i * PAGE_SIZE, clear_page_unit);
+		clear_user_extent(p, base_addr + i * PAGE_SIZE,
+				  clear_page_unit, coherent);
 		cond_resched();
 	}
+
+	/*
+	 * We need to make sure that writes above are ordered before
+	 * updating the PTE and marking SetPageUptodate().
+	 */
+	clear_page_make_coherent();
 }
 
 static void clear_subpages(struct subpage_arg *sa,
@@ -5736,15 +5757,16 @@ static void clear_subpages(struct subpage_arg *sa,
 
 		n = min(clear_page_unit, remaining);
 
-		clear_user_extent(page + i, base_addr + i * PAGE_SIZE, n);
+		clear_user_extent(page + i, base_addr + i * PAGE_SIZE,
+				  n, true);
 		i += n;
 
 		cond_resched();
 	}
 }
 
-void clear_huge_page(struct page *page,
-		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+void clear_huge_page(struct page *page, unsigned long addr_hint,
+		     unsigned int pages_per_huge_page, bool non_cached)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
@@ -5755,7 +5777,21 @@ void clear_huge_page(struct page *page,
 		.page_unit = clear_page_unit,
 	};
 
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+	/*
+	 * The non-caching path is typically slower for small extents so use
+	 * it only if the caller explicitly hints it or if the extent is
+	 * large enough that there are no cache expectations.
+	 *
+	 * We let the gigantic page path handle the details.
+	 */
+	non_cached |=
+		clear_page_prefer_non_caching(pages_per_huge_page * PAGE_SIZE);
+
+	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES || non_cached)) {
+		/*
+		 * Gigantic page clearing always uses incoherent clearing
+		 * internally.
+		 */
 		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
-- 
2.31.1

