Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B985A5710
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH2WYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2WYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:24:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE08276A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:24:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMDsYA029278;
        Mon, 29 Aug 2022 22:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JqQRZRnHelJH6ogdrBm9gzsYnKIUXEBCkcmNogCBP3Q=;
 b=QDTRnJq9s8UxHfLXbKzTnGfyk93mBeX8mNGCYhsbK9ZLE06m/NN8OCttvmbedRVSGt47
 1chB7fRBhiZhzKXXKwP9rtT9WdohPvd0XV8PT7bXPbbzUshOm4nvbRkVUgLB5Mq09Ers
 Eiq87g7ZwpJnDt89dHwoAe+ajCi2J8giz9pJcOjAcjD0MDRL+lsSxAyLkndynJt+RKt/
 xHbfpSPKZja4dSKlqQl3KwXGe9JEEEA8FGuuMxsTQIgoGI3GW+rairZQNtXaiih19/5f
 HfiwxKGovi8Ubg250zwSl1N+UBmpEel2Cd2RYYIOdG7u4ZtKOfBsbIFI/NaB3aj4n8a+ Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbvns8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 22:24:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMFTRU033360;
        Mon, 29 Aug 2022 22:24:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q338vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 22:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdJ1o2O9WzTxZfAQOSqh/d4MbvyfSUBITC1dQOqFjk6IzR2JtMBmaoj0rPsIRx076nCteXt9uRH7SpWiWat3taMkqolXfBx3m/kIOZ63Qe0aoVAk83Gl7s//71Z7deJh6IN5lOUZOpgNoKaiPvd2fd0Jw+hAClQoBRni6l/wfoIvO3M76rPTsejpZcB/V87gL8iJDEcvjafJnWwnVC8y8HBnG/w83vFvWOCrsaFV0srAVpHJWUGmbJOcyS9J/imBiGQDc93zIPcsWlkss3pOD1QDIswyd5FsOPqRPE1PA5wiYM0Mcjw6aq08Tlo6dt/QenABZEa+rS2+juP5yN6eKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqQRZRnHelJH6ogdrBm9gzsYnKIUXEBCkcmNogCBP3Q=;
 b=kKFFeYt5Ht3yeVnHN0uOqM8bh7F04es6FstuO/KT5/xnEscMLGh+wptDFyFxmbajjEdXWqlDdA3SQnQzMcDgwA+u8QBG9mnEila+uPs3UKoNLTZBW9Dza+Hvg8Q35Ouw5kJH3Mdo/RWOqnjiWv210cbCDKh56bPsgW1mAh5XfdJNsaVhQLz/gLFshqORVhoNn4Y+pYbvQWAtZVmQ2ijmyDLgeWwYQJHdxRLzvn6sR49QTSxi4meMgf7M1IeNSD1ew5RF8gG1hEUdsRGqs6HhZ5wG6bNS4DYlo9hZCafDNZUyJJhBNhDV8Sq6q0dvBOaYWfDvNH/zwy1osRxjY6P9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqQRZRnHelJH6ogdrBm9gzsYnKIUXEBCkcmNogCBP3Q=;
 b=GC3g3zH+N4kMAyOL1pSQU6bypiIAmvecKhacnqr0R3+qdXPq3MCdM/hxpQD53Rw7lqxDSKabJys5c8ryatUpI1zOd2ngZwlii9g6HIgXqmMS82YNZ7939btrO+EijT1YBUfpbcyRPJatRMflopO7jbsSHM1SE0ZsoGHsXgkqtWA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 22:24:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 22:24:19 +0000
Date:   Mon, 29 Aug 2022 15:24:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] hugetlb: add vma based lock for pmd sharing
Message-ID: <Yw08j5m62is7kqSg@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-7-mike.kravetz@oracle.com>
 <47cc90bf-d616-5004-555d-b3d7e9b09bd1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cc90bf-d616-5004-555d-b3d7e9b09bd1@huawei.com>
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da42b006-5e37-471d-ba4f-08da8a0d3707
X-MS-TrafficTypeDiagnostic: PH8PR10MB6501:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAEjXWjIjurFRpgOhygnzsL0aMg3chba8sSpz0hP1hzl8JCjPAvCamskpaUFwBHHk4VqI0fDcc7atyoC0Ms9Ve96UnCihSPDsS9xjUvAliYb5cCxLx4I/8B8BD2xdBr44yKtSB8+5lIDRbYLggNujhktLP2r7SfyDiPs5PeDfNu9/lDQtYwpUlRlRpgMSgEfzgNIC42JBI9praqD3RGEKKuLdYE/M6b9a1DUSTG6h2u6mKEC8LxBxauzG7GLMrhJAezf979lcdFkQjFBKM9i8nBENUttfK/pLhLZzQQQi6YjEPx75zGdhf3p2EdiJ0qLIQvilVqJKhXebe/H29RO9tNUXMTkZodvaHFJ20WHt9KoAMAUdcr98iOr8m4njYp9IFqJidfVy+BdOGW7LjmJB+nKgBcYH1RlG9LaxxaCOHJWQBfWVBbyjJ9DgYILwl+TpFKr/NxJmfBX+g+RwEFEMTJ6SggGcAryGAcD9aFMWvur2W2/02hVRTnJ2AkYfyM/x9dn4dcIcRyyTVZJjbaVIfesNHD4+fVOHJVt9XBVm2NBRYs5UFGdDJceoC1XHzc7wgT8qwvcEjmMo5a5I2PPXiRw+jLoNIuRQVwqVHfn+VDY25DOnajHH+xzMJhQcnlnFPu48IHGWZbuod/ZXL4gqDeASIHq6+5Kn9x5r9j0EH4fN3CM1bL4OLUiaCGrVtokdduBa+NLZjA8fWTRWGw1VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(66556008)(4326008)(8676002)(86362001)(66946007)(66476007)(44832011)(38100700002)(53546011)(6666004)(186003)(9686003)(6486002)(6512007)(6506007)(26005)(41300700001)(6916009)(316002)(54906003)(83380400001)(33716001)(5660300002)(478600001)(8936002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6uWyM+nW70USmOVPLIRWxGnBZ7hTwXlaxuwELPrwUp4wgsKuSs2sRxtaxbf?=
 =?us-ascii?Q?xrEZ8Y7sNQaEpTvtoGJQf5T+h8T7i2hrMci6GnFMqMoy4+QFhpucvgY+zfMa?=
 =?us-ascii?Q?k1Hs44PPvjVWGCygfPztBAsU4PoTMtdAcMOjE6OalxUA34sgHLQ/3a99zhxH?=
 =?us-ascii?Q?nRItAXm2TA2Dh7K9Uj5XDSXsvcnl3RchSiSCJD9kceeMrAsaWhKAkRDNmiqI?=
 =?us-ascii?Q?TvbDPRCw/mKD/WoBXC/1c+erSQZMtYL4dmH0+viSlsLdFgCE5F/lZ1SwuEnv?=
 =?us-ascii?Q?U/fiDK4W8WIxwu5asXLoNjpOOqGS5j/ExipjkRzgwVIYD3dV4d1lLgt4qSN4?=
 =?us-ascii?Q?qn21tUykOcDIQBJKg3RefZ/zbAc24RZXWykOKf5ec6rqY7X8eTXVhXJIxa2e?=
 =?us-ascii?Q?RvMMJcQTNjRPksVHaJ3eysO3/pCFCcNlKUD/hGIwfEx+ptC7G+7zxaDE1Wva?=
 =?us-ascii?Q?jTYWQuODOXFpL3KI9y013i9t3g2wFkkBj+EsznJ17jMSdSy5OEke6E8odTRP?=
 =?us-ascii?Q?M3Nf02MvZ9ahzR81D2eiZ06QCTOzhRPI//AHUCcd1MvMMoqXs+b7zyWA2lmR?=
 =?us-ascii?Q?BINJyO+fE1A/Jj3cAR4Nv+HC/EzjtdSg/0/6BC7VJIU91d6opfTQlqN7/k+W?=
 =?us-ascii?Q?cts7i1JLBWSfPLcWEGNyGNk1BuvKsZyGD/JP7yQNq4rfsPAgRq4u41YE6yoe?=
 =?us-ascii?Q?cS4jl+qbFjzRzxaSTrd1/hT4qhGcwPQKy7libLX05AM35zM0KTT9/7Cch+bh?=
 =?us-ascii?Q?bjTMKmHu11ujadVKSVET316ui3xiXmbnvKZHCclLG+I0RPV9pYcDoNY50xH3?=
 =?us-ascii?Q?eSOcIRhq/vnpLPw0xsKZYPGWjgHxPyzGV60ngaACaWJBwcOjaOF9cwlqI2nx?=
 =?us-ascii?Q?86YoBi/H2Tj5fQdOIXgb70EtjnMMR4j0gGlUoh5bWoJ3F75WY3tV5I4frgua?=
 =?us-ascii?Q?/+kstpKKz53N5frF+O8m3xc7OjAJo5dRoXF52pEj1zY4qrOMM6TWOS7QlTem?=
 =?us-ascii?Q?TZmb0H6DYD1Y3PT/RC6gxLXigZmgh9+v29w38XJe9EivO9/Q+RnBUv7yBgx+?=
 =?us-ascii?Q?IEWPpAwVgl9RovyoWax0bTbuL5odSOpRZ7g8/ZIHYBZ13nrauJlqgaJmCtO0?=
 =?us-ascii?Q?i2wxSlELdFmX6tkdSHnRZQA8xCqgSY6U1hjjoPe88lcuSVAmJ3CbKNnMkBIb?=
 =?us-ascii?Q?h7leiefpknnLGV+XyKgtkM6PHO0JhUKwTBgUHSO4yC43a1ZraDsJFkYmSeVC?=
 =?us-ascii?Q?nO3mz+fWjJwHbQ0VQIQiDYDwzRgn5xYubur/g+/y0GH689EaEhh+Z9kCyzJv?=
 =?us-ascii?Q?+y22y6pUsZMU1N57LCmEiR9Zonbt3njLoR/ZMWrQtjsl38orh1QFlDrcp8fP?=
 =?us-ascii?Q?LRZP34P+AptokwXkrnIV7fpjqw+o8ENl87xMGn1Y92b3rdLYVso2QklIr0fe?=
 =?us-ascii?Q?mu/oJnALC+H2eNG9KqBJF9VSnfQtF2OKv3dLzY6/CLDnS+3GnhFEy25YA34H?=
 =?us-ascii?Q?uftojO8T2seFnLnAbfSvGGfi8mLoaomdWvxjyvmNlKXzaSx4PUBF/01vI5Vj?=
 =?us-ascii?Q?DHOGUcpXJ0FIZqTnYeuvotS9gOD4pt9E53OuhY1R12p5Gq+7yx3tE+ycDlX1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da42b006-5e37-471d-ba4f-08da8a0d3707
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 22:24:19.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og/T7vnTKVt35hUK7EOu42qjIxxQf6qgIOqpHOaNKEYAeu4pL8xWZZ7yxn3EvL79VwZ9exwMXCCx/gR3ZLeseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290098
X-Proofpoint-ORIG-GUID: jFKsblMDYdg6RbZ2rAuEdU6jjeDQ2FZp
X-Proofpoint-GUID: jFKsblMDYdg6RbZ2rAuEdU6jjeDQ2FZp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/22 17:30, Miaohe Lin wrote:
> On 2022/8/25 1:57, Mike Kravetz wrote:
> > Allocate a rw semaphore and hang off vm_private_data for
> > synchronization use by vmas that could be involved in pmd sharing.  Only
> > add infrastructure for the new lock here.  Actual use will be added in
> > subsequent patch.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> <snip>
> 
> > +static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
> > +{
> > +	/*
> > +	 * Only present in sharable vmas.  See comment in
> > +	 * __unmap_hugepage_range_final about the neeed to check both
> 
> s/neeed/need/
> 
> > +	 * VM_SHARED and VM_MAYSHARE in free path
> 
> I think there might be some wrong checks around this patch. As above comment said, we
> need to check both flags, so we should do something like below instead?
> 
> 	if (!(vma->vm_flags & (VM_MAYSHARE | VM_SHARED) == (VM_MAYSHARE | VM_SHARED)))
> 
> > +	 */

Thanks.  I will update.

> > +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> > +		return;
> > +
> > +	if (vma->vm_private_data) {
> > +		kfree(vma->vm_private_data);
> > +		vma->vm_private_data = NULL;
> > +	}
> > +}
> > +
> > +static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
> > +{
> > +	struct rw_semaphore *vma_sema;
> > +
> > +	/* Only establish in (flags) sharable vmas */
> > +	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> > +		return;
> > +
> > +	/* Should never get here with non-NULL vm_private_data */
> 
> We can get here with non-NULL vm_private_data when called from hugetlb_vm_op_open during fork?

Right!

In fork, We allocate a new semaphore in hugetlb_dup_vma_private, and then
shortly after call hugetlb_vm_op_open.

It works as is, and I can update the comment.  However, I wonder if we should
just clear vm_private_data in hugetlb_dup_vma_private and let hugetlb_vm_op_open
do the allocation.

> 
> Also there's one missing change on comment:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..4bc844a1d312 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -863,7 +863,7 @@ __weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>   * faults in a MAP_PRIVATE mapping. Only the process that called mmap()
>   * is guaranteed to have their future faults succeed.
>   *
> - * With the exception of reset_vma_resv_huge_pages() which is called at fork(),
> + * With the exception of hugetlb_dup_vma_private() which is called at fork(),
>   * the reserve counters are updated with the hugetlb_lock held. It is safe
>   * to reset the VMA at fork() time as it is not in use yet and there is no
>   * chance of the global counters getting corrupted as a result of the values.
> 
> 
> Otherwise this patch looks good to me. Thanks.

Will update, Thank you!
-- 
Mike Kravetz
