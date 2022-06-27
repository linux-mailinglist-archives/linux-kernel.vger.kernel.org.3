Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E29455DBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbiF0Smm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiF0Smi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:42:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF5B25
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:42:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RGBgKA002157;
        Mon, 27 Jun 2022 18:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=PuzUcpmS0kI+rUTPvoJbLBaGT1ddt4IzzTdKNfEZNZU=;
 b=mdIMAMQpvCZmjl/2vlaQFdMLqH3myNh8lYweBPWmiCfSMg9L+4fB/KNpTEGkt2GhIEVx
 EZvFgUVNaExcA02W7L098MZ31VlKMWDkFzuKilsRAWfi3wsmEHf+V/KTR17fNWdpax2J
 kERtdfPNUw4u/knLXvKvmlW4TBks0V4W+MyEDALarjmy/tXuYUhce6dyfW1q68uf5UHq
 5CtQu5U39xnDKWJns9GnChr93SEG92UVg6XQU8DZVgSFrTGmQGdAqg9jBwl2GW+DN1rP
 ujAF87SN7ESQxtIQOiuG93BGo/YmhJWs2EvFBQYZTu3OrHJIhUQMdjaKqUnljXRI3Iry Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52c380-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 18:42:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RIfPF9034742;
        Mon, 27 Jun 2022 18:42:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt164rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 18:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR9lsBHdeYKgHVVVkPNO8YUd7oc3dM4LdI0EPjfEp4p1Di8xQmcfXZBsUdMwo0y27Y+dzbOt9Ci1b5EbqgedWATRpr+kwVGHA7lJ9K1CSDzJcUuGBp6NydIlr8JRA66OXnpl+pooWnbmxs6KwtKO/+wF7a7QpLdQEsb72GLDv6+08cWeTaQud3dxYgc71BIcQGIMAVtSEC23nLIQUHVcJJzH75FcBpi/iN1zAevjaFaqGxegSJrq1RFfBp8R4NrWBRzJeULjY7NoUie6CfntzkAVGSbknmW1/M/eywAKc88PdUtFdV6BDROx3Nqh+zKSM7ynSv9nNzQxLJIBKZipTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuzUcpmS0kI+rUTPvoJbLBaGT1ddt4IzzTdKNfEZNZU=;
 b=VI6ERn3fMWmyXNgckOU8lenhPsMvg8il3+EfV97Qe8WdRDJtSG25/R5QFZGBUojHvYttiHyJOVJHcNTsRlDnrVhDCpl0u75AehdI97DOqcJ/hGwuJmaZ1qYH3nJT6l/MQSlePQwnAaIPZgPX7Y2xakYvmMpWIbJgoibrT1SlZChgIIC0S+fY4MOjjBgvzrMUPNaIbkTP5cS1jwkWlnIFz6lLOo52HnFYFVPIWZU9IjQ9UZgnodcuoWXP08fPZ62HWqNe51lPQNCBatVK25iGFG09kjfQtYzvKeZMvrw6G9qpqour1a23QiwYXSInDhbsnSYl3BMKynSdQNG7oR5+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuzUcpmS0kI+rUTPvoJbLBaGT1ddt4IzzTdKNfEZNZU=;
 b=sldtC0v9LoYlZW3DagyIqyAnf7ZYD5GnqolGEFfLcVx/ZwyxyERlUrZjmTMdXqS4Ky001P9BFWCjgpRGYsVhu0rI8VYsn/g36hZ6ZquRZEduKs4Uae8FP6VGpiOyrEpG3ESLxhSHRr/CC4o2A6K+aTslZz+cSOv14/OcAKkWrgI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2239.namprd10.prod.outlook.com (2603:10b6:301:31::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 18:42:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 18:42:24 +0000
Date:   Mon, 27 Jun 2022 11:42:21 -0700
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
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
Message-ID: <Yrn6DfTINknKNS04@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-3-jthoughton@google.com>
X-ClientProxiedBy: MWHPR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:300:ad::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c004eab-f6a3-4ffb-e041-08da586cc6f3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMvYGMlQa8ZUeUCtkM6DdPMTerESsxbK5m0PNLvCzpDy82ggvMVgC2OOUmH7lpVwtTxqeENCbmmHh9wwP9oZxxXUShTcleGB9WE1baXXRNdN+K4FVEr+lPh2AmeJuDa9cF9SXsYMB6ixLOJFc8wjTLTvqJLfAcWVz3pxyFxy4Ae2zL8n0xtOcEEPN6uyDO3MOAQMXstTVoxC/lOjyvuIwh/G0o4RI//qqIohqNCBluF5dfyKHSE6kg04siAiITL+uvvluC/VFAVCP/OcoAgivE/R/koGToF0rWkg+Uoc7C3hk0mxP8i5xvI9nSQskaqBCSuQPnWtmiuHLJCkPM0IoC4rbKLSPHcZzT+nRFmR1sLD/YBAr7wvQ4JEnCFmS6R2KbGGtzSK8xY0HPO5v42HBffsKiy2W5XbedppFtelInatUkHDF6uEl2GvtHmCZtGZdxI+2UTv9INJ7AbfVvF4HXQO3PDiqj/jpyLstugxQsgu/mqfP/WAPi9UPknI6T+NEx8DcZDRZsa1t9Sr6WCi5sWdZlh+DKf73h2cftviG/Vr8A5iADZbDG8O2GTCe+tOpPTeiE/rgob9wVvA1zjfE5GZeGpKTQiXA3YM8MlNHmJWAFlul2qlpklhAAJj+8LSr4SpTUW+i0lZMv7N7qim48CMOhau5NsAtqOoElfxQjw4qFbiXu7iahPwuUstrAB5kBvE6DABMQ1FWNdPXfBiyOiuah2o51OvScFrCZ+ZUu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(7416002)(66946007)(4326008)(478600001)(6512007)(9686003)(6486002)(86362001)(54906003)(33716001)(38100700002)(26005)(6916009)(41300700001)(83380400001)(8676002)(186003)(8936002)(53546011)(6666004)(66476007)(6506007)(316002)(2906002)(44832011)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVD97WCfh+qQJ1emfo8ey96iNjdLuBU/fB1qp3Wd1U9DiCVPlBVypO7QU9XW?=
 =?us-ascii?Q?tdiJKxfaT4JCNI6PejfvOJg54sNMfciaHe6vBZ+n9Hac67D9KGpR7/1Svkc/?=
 =?us-ascii?Q?yApCtxtLBrHqBZmyaR80HTTEQR/C7X4nC2MIUPW9HwsSfDUs+t8V5BSYvG2+?=
 =?us-ascii?Q?FDNbgzM2qwA3QznEAw8D5hr2NBi8ZfN3cHjiITs/MIk9hN7AdhuxDDLIHcX+?=
 =?us-ascii?Q?IbP8xXey6zxjz7X4hlfkv2AJWTojmKnmcSygzcmc5Pn2gh49+LO0mflA8Gt+?=
 =?us-ascii?Q?QNvoh+XafCogIWa6dM7LQiAxWrnyK8sssfdERgr5Q9o90Ky/lkPP6drSdj6k?=
 =?us-ascii?Q?FPG6nNGMVWIC6L1THDglWlI1pEReD2eC1NoIIRfnjxLUqqMeAukcguoW7Mcv?=
 =?us-ascii?Q?wOGf5sN/gO0U7EAOToI0VjLftaanfmF8QMkuFEvab3FGPofv7g77+ZdLXUgt?=
 =?us-ascii?Q?dxS7e3AKVUFG0eRtzZQnVh81P7hQn0rYICd+o59MBXtNQepDzLeXsaL/IwPI?=
 =?us-ascii?Q?woSY01cMxT5dfi8a4ZU/NZjVjNSxvtNU5Alkfh6uOWNFgWE/QDJ/3ZxnDht7?=
 =?us-ascii?Q?MKASrx4nhtzw7G8m5xcn1Mywk9J5pezm+J6N5aQ/8lZCzPMbWeI55oETgJcv?=
 =?us-ascii?Q?OkWONLN7YTZB607gXpcx5OgC9hngeFy2Lcj8cO7GdPQvp1QkNY0YgCAcxYHZ?=
 =?us-ascii?Q?cBLGd4/gkVFmtNPdHIIf4v7Uf3Sj5CS7O5jAIlXbainzT2HlQhFqkJlhz1kd?=
 =?us-ascii?Q?upqqS7+C29z+6XVARf19sxA10tuDKGEfZBJ97z2Kw2gKIj35tUIg/Ccb1ijJ?=
 =?us-ascii?Q?ffTB8nB6KqT6lhzc+8nNSCClC7DXEnP/e40YCYN71zIs71US61I7/x8755yV?=
 =?us-ascii?Q?8uo6LhmglmrqPd80TteQh+x6kkEmORFtXxoqt0YMWjkez6oeFAae044hf0MZ?=
 =?us-ascii?Q?zGC/Z+UKf5/TWSE5AddXpj5bj/mEqCG7zmbF37FNG+pqtoWRDcNtrVB5I10+?=
 =?us-ascii?Q?1WPcDpDhTDrI1shbV3PFjKMtejwaFX8VPeS6NViurJUQTSauAOEl3FJ/UmG8?=
 =?us-ascii?Q?FkbXdHpmIsiH3ijHoj41sJONpb3uYxmA5nv4IfZa7HxCYYOtrFpptx0pEdyI?=
 =?us-ascii?Q?Y3ag5ItIg+3xrqB/G09mzP4XbA+VwCjngfJAOF5H81ei6cYw1nN0UMQqw8lC?=
 =?us-ascii?Q?DXv6FUi+olCBOYB5bclRqsIrpiKeJ/AJKltY3ibMJTGKiGZrIMFK0OwtqnZ3?=
 =?us-ascii?Q?wOflFP0rlO1udf8T54rCOBdbB0H0RMorAS6rKvDuzFRg8hnnFoVxVW0/cX/m?=
 =?us-ascii?Q?IL8NyEd4p/uGeuFoHKWN7hmzbG/rRiCkkv5lrDFOmI10KN0nThB8RtC/5MZw?=
 =?us-ascii?Q?1EMPhnXLzmpHGTRgkksfgp1UhwETbnzCyAQrH14JaTdU+S7IZn944J9KAtFC?=
 =?us-ascii?Q?d+dMP4hhLvQ0I/PUXcunsTtqBMHCxy6oVOzCZRqKPeIM8I3M+969Swpy0d77?=
 =?us-ascii?Q?ZzygBNsNKln9t0nlAaqTchC8/BjYsP9GN2beUjd46dpgs9qhw5RFCnZ6hOo6?=
 =?us-ascii?Q?UmrZd8IHMTyn7XbMgwqQ5k7AYSNmD5dO40ALNNrZXledvyIXuUnpn6s67Ny2?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c004eab-f6a3-4ffb-e041-08da586cc6f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 18:42:24.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuR8RmLzZHLBYL0SIYphlKsXlveDJrOYlPu+rOBpZt8Onbo8u4Ocu+v0zX65phUbMDzyMlzm3bWXcF9NeP5rog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=914 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270077
X-Proofpoint-ORIG-GUID: R4wSbtS6jkAlQUOhezSH2QpigsTwTN4y
X-Proofpoint-GUID: R4wSbtS6jkAlQUOhezSH2QpigsTwTN4y
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
> When using HugeTLB high-granularity mapping, we need to go through the
> supported hugepage sizes in decreasing order so that we pick the largest
> size that works. Consider the case where we're faulting in a 1G hugepage
> for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> a PUD. By going through the sizes in decreasing order, we will find that
> PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a57e1be41401..5df838d86f32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -33,6 +33,7 @@
>  #include <linux/migrate.h>
>  #include <linux/nospec.h>
>  #include <linux/delayacct.h>
> +#include <linux/sort.h>
>  
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -48,6 +49,10 @@
>  
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
> +/*
> + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> + * to smallest.
> + */
>  struct hstate hstates[HUGE_MAX_HSTATE];
>  
>  #ifdef CONFIG_CMA
> @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  	kfree(node_alloc_noretry);
>  }
>  
> +static int compare_hstates_decreasing(const void *a, const void *b)
> +{
> +	const int shift_a = huge_page_shift((const struct hstate *)a);
> +	const int shift_b = huge_page_shift((const struct hstate *)b);
> +
> +	if (shift_a < shift_b)
> +		return 1;
> +	if (shift_a > shift_b)
> +		return -1;
> +	return 0;
> +}
> +
> +static void sort_hstates(void)
> +{
> +	unsigned long default_hstate_sz = huge_page_size(&default_hstate);
> +
> +	/* Sort from largest to smallest. */
> +	sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
> +	     compare_hstates_decreasing, NULL);
> +
> +	/*
> +	 * We may have changed the location of the default hstate, so we need to
> +	 * update it.
> +	 */
> +	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
> +}
> +
>  static void __init hugetlb_init_hstates(void)
>  {
>  	struct hstate *h, *h2;
>  
> -	for_each_hstate(h) {
> -		if (minimum_order > huge_page_order(h))
> -			minimum_order = huge_page_order(h);
> +	sort_hstates();
>  
> +	/* The last hstate is now the smallest. */
> +	minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
> +
> +	for_each_hstate(h) {
>  		/* oversize hugepages were init'ed in early boot */
>  		if (!hstate_is_gigantic(h))
>  			hugetlb_hstate_alloc_pages(h);

This may/will cause problems for gigantic hugetlb pages allocated at boot
time.  See alloc_bootmem_huge_page() where a pointer to the associated hstate
is encoded within the allocated hugetlb page.  These pages are added to
hugetlb pools by the routine gather_bootmem_prealloc() which uses the saved
hstate to add prep the gigantic page and add to the correct pool.  Currently,
gather_bootmem_prealloc is called after hugetlb_init_hstates.  So, changing
hstate order will cause errors.

I do not see any reason why we could not call gather_bootmem_prealloc before
hugetlb_init_hstates to avoid this issue.
-- 
Mike Kravetz
