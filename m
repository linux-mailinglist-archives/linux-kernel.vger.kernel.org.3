Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29C588099
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiHBQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiHBQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:59:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892515710
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:59:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272GoONA015276;
        Tue, 2 Aug 2022 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Y8oniLbUIf8X2iWjT5rHZVnjU6vhoZPdrfwz2mJmBQM=;
 b=H99AI34pfJq6lzbAD82+v9vLiBM+qnLjRK/ZySbuks8pjS2fxHwA7CwUceWMAWVxfdIm
 KnYCv2cu5wfWw4wtFLofS/zCDgf9+DgpEZpwkmOdMKtVbI4gfZyf8okhNGol1DsmE2Nv
 D1+zMFIerYVI3EqXVeYMcn7tNu5a4+pct6BLd6W9LKFPj5AOiJIyV3F0fbBpyVZo4IiI
 0zXUngfr/NFAztRCkbY9y3+QMDGUN4AnScZTXwz/Rdp6kqjbJDERCSJL6JGpvrfF9/5L
 IicUsWJ4Fx9UOKvQK0r4YXa7GNlRiydymNmUAU1BJOMmmC/c6PL8SRu8xkiNCjTIgMeK eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tffue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 16:59:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272GX8IK006766;
        Tue, 2 Aug 2022 16:59:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu328b3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 16:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djfvh6LdpATGjTryYlrJYWjaWdu4uUK/KTdVJx3bioXl5+AmhAQVkdrOSSiXFUDobGgalncwZv5Oz/zcemoo1bYqauS4cewK29YfuQgJDF2FiamCUChtAuGgubK8AC9keDKUYLPP4NE1qul1N6fq2lGJUJB7OPHaJ2/PVv3vQAvDqFF9RqT4TYUwFPU8WDVZKsigWxoIwNtnjv8BdjgJJss24flulHb82LCLMRyY25v7aIvSmCI8V0BSXLZWol9ZB899QGD+te175LNic+lVWvf8F0xg1NdatIhziiiM5s8I/7r9+veybElcXT47+6Lo3rSjVo2FbruJNB75r0tM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8oniLbUIf8X2iWjT5rHZVnjU6vhoZPdrfwz2mJmBQM=;
 b=jP3N+wgfNkHCXTW4zfwQbYRjMlz0sclm4F3jCb2B1IRUNFJ9niR2SdnuEELqVUu+EyeMLcraYkoQ6q1fMWmvD1k3lwoR9T2mkkI6+em7K9qbZ2z1U0wFMswFQAJen0F81GgE9wa5A+Jm08Dk/31fmogJ145eKKi2vdy8sK2gGaMF/8InDakOFH53hZmrGohf5ZO6cFoIqsHjVTVyfGvC3lbsEUCo99igoNFFF2XUfn4GTaMOOXppSTFuXe3MpBjTN0q9uXjYvB1Gi2ad8dtlTBGWtSSz6v2367sKBUvl7DswM2K/UOwjwnV9Ftam7o0A2346kbKCzNEjWqLdRjN+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8oniLbUIf8X2iWjT5rHZVnjU6vhoZPdrfwz2mJmBQM=;
 b=uonvCxNt2YWBjuhR7B6y602wf/8VydqDL1pXRy2z2HC8wDMtWmAnnVZnye6U0OW+NG9PZXS9qN3P7fcMd/Z+Eqb+2kPBaBfF6OScCgsDLmIM8e+LZgvHjyKnEZtHMfJTUvlWtDMakGskYQmHH8hjxYX3ZWir2LEAXh1y1lQCsbc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1494.namprd10.prod.outlook.com (2603:10b6:903:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 16:58:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:58:58 +0000
Date:   Tue, 2 Aug 2022 09:58:55 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     luofei <luofei@unicloud.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>, songmuchun@bytedance.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, hwpoison, hugetlb: Free hwpoison huge page to list
 tail and dissolve hwpoison huge page first
Message-ID: <YulXz+1iLHuZBEDb@monkey>
References: <20220802100711.2425644-1-luofei@unicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802100711.2425644-1-luofei@unicloud.com>
X-ClientProxiedBy: MW4PR04CA0383.namprd04.prod.outlook.com
 (2603:10b6:303:81::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b4271ea-c616-456c-fb9c-08da74a84a84
X-MS-TrafficTypeDiagnostic: CY4PR10MB1494:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTsJqquqM0FWTovZwUb2IiyQSdy/M8BB9JdHy7EBvEHJnCIOsQ5mZdfFXfinSwQQ3uMR0e13//KrRVGKniMMDRbeJ1P0/MQbwaNlJl0vvuEzpc+4hAYC+85CN/xUP40RCpcs2+HjFYqDeiXDW08ed1MxC/fymuHxH3GlhKdhNyX7sXVCH4+kmO0yEfPUKpaVVt7GT9HEB95v3BelKoYkKDAr9v8Jbm6kHFM7vGtDYOV0XdiTRRFWvGVs9hvwvRoQCoC3RXieBSfIh8cOiJ84JPKw42wPqstNuHEqONqfX4ln6rsOcG9aIzaVlaUZSDLkwG4rC1VlH/zBFj/lOw+AhGCTQG20lOfQAjOhH2UWtS0wSiQPr1n75Zy6kHSiAOqHVIZSwCxFCQNYDt9EqZ80YQPjqFQKFpa4TTq7bzqMZRdi2CphqjxBrTxiBUtQLgMD4XBO2i2lefCzcy8IhzesKtx/VSWtcIuAN8Szf0TWx6EjtNtsolxIJk/Tkf9Ps7TBkqva38v2Y5FExzeDsrqNh/9M8OMUFFYf4m5vQX5D7LOtlHrtM7kC2RUWC+ywwXziz4BYQsJq73dBEwvikaRyXS+D2W8IT4phLGu9KmEjmAbAlAEUak+9o3mD49yAJoKbL9zZ9PJdVY2wsjJk2r+k+SNoXy5qpviqPabSvEKjEc089ygEHH6xxgUwX5UFNIaLurRbmez7yjK4NuL4VQkwvE/KDFkMYCfXNLIFbGuduZNtE6LuWCYHYsLzcQca52Wxhmjsm6pccWGptKlzM19nY3DCKcg117lwWdsZ0acCjBlOp4wh6aEMtz47+rBGUXJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(6506007)(6512007)(26005)(5660300002)(9686003)(33716001)(38100700002)(53546011)(316002)(6486002)(186003)(44832011)(83380400001)(478600001)(66946007)(4326008)(8676002)(86362001)(66556008)(66476007)(41300700001)(8936002)(6916009)(6666004)(2906002)(54906003)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSa2fKo3TGy1aYUMAzGllTz2lJKxvEHe+hiM6h1F8gpdZIfh9XajakS7dSy/?=
 =?us-ascii?Q?8NyRZ0rPZOzB0KxmSxdh6vhbWb4BlYwnNTiitnm5+U18gidf2wMD7bjnX8QB?=
 =?us-ascii?Q?5pLG5iFj3BtXgNWPe935HOV6HfqvsNxpcDtZE/hDl1a/ngFXg5jpBbCsQpjN?=
 =?us-ascii?Q?ZphJHpLcdjbo8ceVPe9Szh6GAe9AL0kT+j7nAxs8fbr3KXp1+xJ/Dh456IrL?=
 =?us-ascii?Q?I2enuYloPYxCWezDfd/Mxd4CxeXD4O3BTN2FwuSsGrsrSzWWQW89Rc64azDm?=
 =?us-ascii?Q?EBzzrE0J3ncgOVtnqvRa+qhYT5+GFpcvA0oxj80y1A+8Z1F4EWOVTgRGphH4?=
 =?us-ascii?Q?ZDnyQZsFSPiT6FZIHUGeCShNvHoR6nL9rA7QFG32OpDOIB+rkmgFQ9qsOl/d?=
 =?us-ascii?Q?8fYfrAdtgfCO7Y3h52yjys9y1uNNFP/I5LEGz0VRgNpgbCYdXIEOFZhDovkb?=
 =?us-ascii?Q?h9XMtdpZyzrcWLCn+RF/kVRWZqw6ECKGdSlpccVS4JioyzmGxEUYMKDfNZW+?=
 =?us-ascii?Q?nF20kAD0OQM2LsLd1uUsY8E9rM8nDyZdmdCQxbDct6cAPxeRfEw/IZ8Yqvhz?=
 =?us-ascii?Q?6o4Xz/yV7ocSsU81xsWcPjBn51/62PBnrebPMrJTl1VhZVVBmFWfbcBniF8O?=
 =?us-ascii?Q?mXhlsl/mMGTR+EIZGc3NEwy6rCODo8LfEh0Q9l8XobkO1tkDQ6b1QFHy3zTG?=
 =?us-ascii?Q?jhJTGEL60L2GWXz2IypnmQwabTLtj67yycKk3vFYDOs4pezycuI9dntSIcSn?=
 =?us-ascii?Q?Hd8kCw8t5SfolfO3W5ekRJJ7Acinsah/6tUjh10tFgU4qM/bfapGOYLb/AY+?=
 =?us-ascii?Q?CS/ZOyw30ZAIM4Xacd749jLZnmsPgeWdD6vKQuuGRj+dmPFtLC++zhS6tbOi?=
 =?us-ascii?Q?J2KzOcN8fPiUjX0U1YBmrOL73qPLIMdLg/TErH1JQSnymGKN5nEtBwe/bQWi?=
 =?us-ascii?Q?H637YbP2Np3coWmj8Op0IIs5B6VmyZ+eSzvbPmPvKrPDZAx25My3RtfEZXFb?=
 =?us-ascii?Q?YcTqjbC/mEoO5kupXsii1QXn+lIE/PDgY/2NDoMsiOrLOsQ3ir4Phxy5tDEV?=
 =?us-ascii?Q?itTlfNpAr28U0qsDHPx29uNlCn8pUJAY0t2bciDawT7uJBE22QvvpQwSV6e4?=
 =?us-ascii?Q?4sxlLzRoXAipz6Vm9kHVFaH14EB//FQy/THXUSRF4LdCIOVDRVt1b9l45UN3?=
 =?us-ascii?Q?z141wDkeT4e4jnOL4O45N1uwuurv3vBPjx7VJzdPwIwoqc2Hec1rp6CxEgPT?=
 =?us-ascii?Q?6JHHKsEhgkY9NI6TWo0o0H8SlO1dTZicZIRks3JxHoLqghctI9O6XvphX/YF?=
 =?us-ascii?Q?K27UcXsBLAFzmd/vDMYVV88KjkMaIbQXyGJUr+JKyig2oSBYl1YdLb2SFVgd?=
 =?us-ascii?Q?oKmtC9I60q6qE2KQD5Z/jyn4BXtojHY8vAlFZjhXIaTbCwNegpLvhI+RUvkb?=
 =?us-ascii?Q?PaWMOhiM7wvBiTND/NWYiI3HV52W1r+1gT4FFwZS5auTnE30WvTmB7K30w4b?=
 =?us-ascii?Q?GaVL78tmlMXeg2xulB8TMBhMd2qrvptjb1H8aZ1h7xOdXP8EXvO7ORI9c3Nd?=
 =?us-ascii?Q?i/YCqG0RiVcZ7Gf6lEHQDTyS7HaxN61w2zXv2vFPU4LxuxEnTIRVEV53a/AW?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4271ea-c616-456c-fb9c-08da74a84a84
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 16:58:58.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfeDXLHYjBbVS1jpQ4bzJO0vSI9GY57iUT1BcDnCS0hWOmmuw57F+aQruqTh4cj/sxEs4mPPnFDhBtMJkTOf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_12,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020079
X-Proofpoint-GUID: oyDBwxE7kcg2qMqxOjhOyP7b6NOspEH1
X-Proofpoint-ORIG-GUID: oyDBwxE7kcg2qMqxOjhOyP7b6NOspEH1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/22 06:07, luofei wrote:
> If free hwpoison huge page to the end of hugepage_freelists, the
> loop can exit directly when the hwpoison huge page is traversed,
> which can effectively reduce the repeated traversal of the hwpoison
> huge page. Meanwhile, when free the free huge pages to lower level
> allocators, if hwpoison ones are released first, this can improve
> the effecvive utilization rate of huge page.

In general, I think this is a good idea.  Although, it seems that with
recent changes to hugetlb poisioning code we are even less likely to
have a poisioned page on hugetlb free lists.

Adding Naoya and Miaohe as they have been looking at page poison of hugetlb
pages recently.

> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  mm/hugetlb.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 28516881a1b2..ca72220eedd9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1116,7 +1116,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	lockdep_assert_held(&hugetlb_lock);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  
> -	list_move(&page->lru, &h->hugepage_freelists[nid]);
> +	if (unlikely(PageHWPoison(page)))
> +		list_move_tail(&page->lru, &h->hugepage_freelists[nid]);
> +	else
> +		list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
>  	SetHPageFreed(page);
> @@ -1133,7 +1136,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  			continue;
>  
>  		if (PageHWPoison(page))
> -			continue;
> +			break;

IIRC, it is 'possible' to unpoison a page via the debug/testing interfaces.
If so, then we could end up with free unpoisioned page(s) at the end of
the list that would never be used because we quit when encountering a
poisioned page.

Naoya and Miaohe would know for sure.

Same possible issue in demote_pool_huge_page().
-- 
Mike Kravetz

>  
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		set_page_refcounted(page);
> @@ -2045,7 +2048,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
>  		 */
>  		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
>  		    !list_empty(&h->hugepage_freelists[node])) {
> -			page = list_entry(h->hugepage_freelists[node].next,
> +			page = list_entry(h->hugepage_freelists[node].prev,
>  					  struct page, lru);
>  			remove_hugetlb_page(h, page, acct_surplus);
>  			break;
> @@ -3210,7 +3213,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  	for_each_node_mask(i, *nodes_allowed) {
>  		struct page *page, *next;
>  		struct list_head *freel = &h->hugepage_freelists[i];
> -		list_for_each_entry_safe(page, next, freel, lru) {
> +		list_for_each_entry_safe_reverse(page, next, freel, lru) {
>  			if (count >= h->nr_huge_pages)
>  				goto out;
>  			if (PageHighMem(page))
> @@ -3494,7 +3497,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>  		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
>  			if (PageHWPoison(page))
> -				continue;
> +				break;
>  
>  			return demote_free_huge_page(h, page);
>  		}
> -- 
> 2.27.0
> 
