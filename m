Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACDC55EFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiF1Uf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1Uf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DC1CFC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:35:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SJBTwP031397;
        Tue, 28 Jun 2022 20:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=riN+4BJyNNrWvb0a32kr0Nfys7+1ev/dcms0HZQouIo=;
 b=IerSemFpbMTuMXLzB5i5OvITb/bRemmvXe0b92+VcAfG8dztvvsFDFLsNWvbqom/84j4
 K3V47Y1sUUijtVQOmsb/aN0KlRozoYdxpB8M4NYu+nXRnnwZ4yBOFBxRIjXLSJxVUaJt
 XUefTUnpN5iYNgCupnQFJMWGKVRXRLlJX+HxbKjLczMCxkSsaEUsu6q3GHLkh3NIMsY4
 YJDetdeMjuFtvoMJ1SNLSKzRMdyJImgbqvnw/7K/OZ/PN0SnIjgkQ+yNPy0df2YU5FVb
 w6lPleRwL3BMW9cJHtBts8mbOzfdIBEvhPqvHQ3guFaz4PgRgQxa+/OMCLEKU2N27pSM RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0f9ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:35:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25SKF4QR005549;
        Tue, 28 Jun 2022 20:35:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt88xw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 20:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwpnNv9M76RjklC6uc/7PzTwh0ae2HujaoQz6fFF97+vfuiNdFA8wAWF/v6o1cp2e53fafs8zN4neY72h8w2mpDWGR9uLhnjXe5UdF3b26N+QzxU9D/FPFIgJRpJ+nJUQcydCOHi5RBpDF+D+s4K8kt2JbOqsNb3qS9JZtWD3bkJnvRLoJBPVlidNLdYfqRudUYYBF8yCsncdP5reztmNPQWEg7lXC0klh2IZPIZXeo2pVo/tiTkVxkCPRA4j9vF+sPkWvLV4DILN0yOFb+ngkKfEtWeFDQBcuQ4gp1Zo+jxMCZ4l25G+MeivI03WErIbO54afWugCqVMm32vt84Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riN+4BJyNNrWvb0a32kr0Nfys7+1ev/dcms0HZQouIo=;
 b=C5rt9ACPoUnmXN7qj6aPnUr0ORxx1Z416WU+NRBDbd4oHpxgKbYNyfEeyOhmBUgj6kkTqgrqkNwiL2JRdsIL5aGWWu8pJtl0IRuEwWUHjQJm6FGZptf37d9qYSQLnyQbSPRh0uVcwvvNlUgmyrCWGzTqW4sLmYw6eHj6I2akTzn4kZcvZrIkUh07Ad34kmzKUBgKZP0A/wM09QpfxbRIZicXdu6bDbScB5uncyCZrw5+OEp2RLO8ZoXPJcUu7ky1Fuswa6zTJ3RQE7tRY61k2TbiABd0mNtmOpvsmp61aVNoZHOGfNl5qa412thFzS0KlTXjc6CR1bJHSTLJaMQ9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riN+4BJyNNrWvb0a32kr0Nfys7+1ev/dcms0HZQouIo=;
 b=UOLQ8lKUx4RvWkZGcHvJOD8uyq1cNtrbr/hWXKjuO4mymE/2DWONCl6SSsn98Rp0OS1Wte8xtQ4wenBsWXTtxLT3g2SlbQ86WRHew3pSfqUDQAglpEQ7J0sNX5uAxfK52UYyH6vYGTHRwoDMaAhk0cYXLQz0om05gUY4ikT/1qI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1878.namprd10.prod.outlook.com (2603:10b6:903:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 20:35:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.022; Tue, 28 Jun 2022
 20:35:14 +0000
Date:   Tue, 28 Jun 2022 13:35:11 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/26] mm: make free_p?d_range functions public
Message-ID: <Yrtl/4zHIzSzoc6p@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-7-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-7-jthoughton@google.com>
X-ClientProxiedBy: CO2PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:104:7::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f1bd43-fe6b-4c56-1f2d-08da5945b45e
X-MS-TrafficTypeDiagnostic: CY4PR10MB1878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12llcGKCzZOyuCzaPObBA+oARu01xBCYs2dwpu5SE2+QTwS2eeeIisEO11VgvYESTzB5w4TyyT/Gm/id88PLWnTI54296VR3PWcd8djdR17U4+ZuuezhkS+LsD49cN9c14fK7u+eYsie8oWdirmR/PGMpwiML7o9ULAM42JWryJZMevASfjUGzvMAiuEDQgZSsYqjPhAFKBv/SLNodgI7FkPjIZ+LA5sWi0W1UyrAeaggvCAzUaUlOaPCStZmgHaONaoYtS3tKwmeXK1buznwNtwpJDF19grAOLptwCVrxdAo8ZY7PkXxmBhDwOIY7EX/ngT+t5v/w3tgx1705ddykubVAB17oeRFnjztNysFfZz5BT2pM+7GGxV5D0dsIZfmbiZDrtS8y8AvxtBc0VmIkMAYUXBU6vZdTgIzTtME4B96lSqkAvOYtcp7vQCrsopbRpO9i68h27wJ1xo6kuCCC3ia8DZ5m5nb9KqA+LlpGtuvVK8lQ9WLbKv0hMhhPdnSMt0ICTc+gWiRyyYrIOq7J1WgYCTzWqsmoVhj2x8I4eM6u3CQW1ASAGrEmqrO1M9jJNCXY1qC5al8cd3uVt7VIFmkQRHJKeXlZPXNUkzFfgGI73iVYJy8m8pe2j892DGalYUAJVFEkHOFncKHtCEoiJIQiBnjV67UIAwR3fywEWvd04sdU6dGWGw6eYEk8RjU009rhTBgvovEkuAYwsn+0bJHicRk82iNNs5WWmo02s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(26005)(66946007)(186003)(8936002)(53546011)(83380400001)(44832011)(66476007)(6512007)(38100700002)(9686003)(8676002)(86362001)(4326008)(5660300002)(66556008)(6916009)(478600001)(41300700001)(316002)(33716001)(6506007)(54906003)(2906002)(7416002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wlMicX3aZLgLD3j2bMgMIPbhaDhC/MXJzD3xp9/yglf5bSZBEyKy+6ftxDfy?=
 =?us-ascii?Q?1zP859KsJPDFrcqLbnxHrClSTT+BFTaA1Uf9RqCoLgUted9OsQiYJ1thvX63?=
 =?us-ascii?Q?Qv49Qpf6MNuw3P0DDm3fSDzewQ7LE7ePbx9yV8RdMdM7NWalvcBe4NK7pfQq?=
 =?us-ascii?Q?QMMAARQqx4PDXhvG8UphWNpuG88cO1SVCPSzfsGs5wFN/6w6h3/eybYu2W/+?=
 =?us-ascii?Q?pEGJmcZtpq13oHdzKcceLgWgDweoOmytnGJS/gZD0D1rUbnRiETTa2qzhYmT?=
 =?us-ascii?Q?faComg3jr0/wkQkZXITcs3gJG4EhEMItsodnSxe5dA/F8wXtdR7+c6v8yULI?=
 =?us-ascii?Q?1sH9FkNx9Ax+EN1qTj5SG5z40mwMo3K9Oh5Jl0PCcW9TgloDC0H/TW2mj2Tq?=
 =?us-ascii?Q?/DakH9ciVYxuje142sEsyZzh11txOmUMc5sDk/NzlSSocDT5sFl0oR7Vkejb?=
 =?us-ascii?Q?GtCruYj7nN2M3tvzXSieZ3pZZ3smp+4TFJ3/TCX4eYi/CU/PLzHSQqjFveiS?=
 =?us-ascii?Q?o3F5i+AewVPkspjaV0128zbE9m3QQNQOaNx0Zc6S4BRbzuie1jZthDw01pOq?=
 =?us-ascii?Q?wTSVu9GhltGdJicECfuyvIb6yCcYKHOvTMbdPip+lyl7qc/nQp2/CWgwD3Az?=
 =?us-ascii?Q?XIORCRnRF7Q41aX0k/IDk6pD1pscJ3hNrKVc02+Y6NTRnC0a+FbgbPXaWwCB?=
 =?us-ascii?Q?+ozuXZMmQDRbEqSlIyZaFPDv87UQlkmcsBX/WJZBPq1tI5BwKDM922k4FN3T?=
 =?us-ascii?Q?MJdDWgMkYFKIBFiZC63foz27vjM9Fj3QvibY1YusUezcyhyPSkVstZIVjMe1?=
 =?us-ascii?Q?cM/kpYn5+fPxUW12PHiEtF7lYxH0j0K7GQeHDRhpYcSoU3mMItxhmWXW8GeK?=
 =?us-ascii?Q?2KeLjyOKqnp3AqPB/UcPee3zsMHFpJIGQLiTdyJo7uBk/PSx+Ng9kj1sjqQ7?=
 =?us-ascii?Q?K1TNzAVX7SWLOGNCRGmx2Cq/3zRJwNB4i9MqdPTJeKkfC9WwjklzslnlFsfP?=
 =?us-ascii?Q?dmDYYdMPry0ow2mFG/JE5guf8PAywPcufF3cE2XXD1EbViesmWchd4502+yW?=
 =?us-ascii?Q?ZXF+yyBgX+N6fPUSWCnSS5UZfMufkVpFva79mfpWnsGp5xXqrLwgIJIA26Z3?=
 =?us-ascii?Q?B1Jpu87HoTkjyA++w0QPpleWosqaGIkudASP3FF5COnZmjLd2dvw7n3JUwDe?=
 =?us-ascii?Q?n6VUvDXcVanvGN7V60l5YX+bld5CdPwBm6Zw1sYT0hTDGtS0OzpM8SwryGCp?=
 =?us-ascii?Q?7QsRB6ZfmjB3omRz6Re0HvYsK2VCJEAdZ3A/XQc9j9nzdjE3PyftIAC/4Nd7?=
 =?us-ascii?Q?G8UhHcjyLdm6jFVJ///tuOFMOJF8l8jkM1ds7C0IcftrRPt2avfjjOX1/R9L?=
 =?us-ascii?Q?DoMEz5mmYXr8YFMHI/cQYORToQ0xDjql8BfRbCjhNGFtN5ADRV2pbrcROXr5?=
 =?us-ascii?Q?86ypgc+JisvfYvW9/Ih3k4fhdb7p3HhlHrQGei2+TOEgXDgD2xCfG0ZJA+ba?=
 =?us-ascii?Q?w2lvociSCuxVEsdvyTz7BnCeo3rJQ6x/FLCBODIb0KONSbi7jRaLxfl6BrhK?=
 =?us-ascii?Q?HYTN+2u6KtBXS9cuTaPNsnUBLbRt5TG6jsBi0843VjHD5V1H51qUlu+3U55r?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f1bd43-fe6b-4c56-1f2d-08da5945b45e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:35:14.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brx43ilYWLmPAtDB1ofruuls/8U4c2LeG317GwA56ksUSbIZNIT9GGp72Eu3m7Vf3L5GgHGdEr2xMdAxz1yDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=459 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280081
X-Proofpoint-GUID: DK7Ek3MSO0HAenny305XxwNKGLI0cGjY
X-Proofpoint-ORIG-GUID: DK7Ek3MSO0HAenny305XxwNKGLI0cGjY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 17:36, James Houghton wrote:
> This makes them usable for HugeTLB page table freeing operations.
> After HugeTLB high-granularity mapping, the page table for a HugeTLB VMA
> can get more complex, and these functions handle freeing page tables
> generally.
> 

Hmmmm?

free_pgd_range is not generally called directly for hugetlb mappings.
There is a wrapper hugetlb_free_pgd_range which can have architecture
specific implementations.  It makes me wonder if these lower level
routines can be directly used on hugetlb mappings.  My 'guess' is that any
such details will be hidden in the callers.  Suspect this will become clear
in later patches.
-- 
Mike Kravetz

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/mm.h | 7 +++++++
>  mm/memory.c        | 8 ++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bc8f326be0ce..07f5da512147 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1847,6 +1847,13 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  
>  struct mmu_notifier_range;
>  
> +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long addr);
> +void free_pmd_range(struct mmu_gather *tlb, pud_t *pud, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
> +void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
> +void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long addr,
> +		unsigned long end, unsigned long floor, unsigned long ceiling);
>  void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  		unsigned long end, unsigned long floor, unsigned long ceiling);
>  int
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..bb3b9b5b94fb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -227,7 +227,7 @@ static void check_sync_rss_stat(struct task_struct *task)
>   * Note: this doesn't free the actual pages themselves. That
>   * has been handled earlier when unmapping all the memory regions.
>   */
> -static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>  			   unsigned long addr)
>  {
>  	pgtable_t token = pmd_pgtable(*pmd);
> @@ -236,7 +236,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>  	mm_dec_nr_ptes(tlb->mm);
>  }
>  
> -static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> +inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  				unsigned long addr, unsigned long end,
>  				unsigned long floor, unsigned long ceiling)
>  {
> @@ -270,7 +270,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  	mm_dec_nr_pmds(tlb->mm);
>  }
>  
> -static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> +inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>  				unsigned long addr, unsigned long end,
>  				unsigned long floor, unsigned long ceiling)
>  {
> @@ -304,7 +304,7 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>  	mm_dec_nr_puds(tlb->mm);
>  }
>  
> -static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
> +inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
>  				unsigned long addr, unsigned long end,
>  				unsigned long floor, unsigned long ceiling)
>  {
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
