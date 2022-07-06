Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5865694B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiGFVvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:51:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593C1A810
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:51:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IjTEZ006104;
        Wed, 6 Jul 2022 21:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8vCJOvnQH43pauivrDiY21+0gOaJa1qJDR4tLmPkLWI=;
 b=mUO95YDq3V71WJ6o7OB+YBNqDuBeUv5jV2Q/+hCQ3hOUHC6vGI05iquFzTKr5yhFtlm/
 dmLrgy+GCcxgUlvrwiKwwIdVBrMUyfn25ZVVGuUZCcaRWsbkpXBnhbNY3xlnjBPvdw2d
 FIwDk97qG/it9hvmjTpvjcRxzU16sOVjT0YjiHRkOn9qqDOlQU8nUD/lZJzlsDLkgCZI
 CC0Dc2mdZ7G0WV65n/h85bUFvKoFl3QyQjz/zSd9aR/Agdzb2y13mG5IniWGQJ8mOb0N
 ZHk2IJcW1z4KLDpCVvpZBAHqOH/D2EXGv+OxDhz8r5m4Rjp4cYIJ0fRAyUKjaJV+Uhg5 1g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyuc7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 21:51:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266Lj1YI032427;
        Wed, 6 Jul 2022 21:51:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud167j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 21:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuVjIRmu7GssyYPp03fAx5RbipJsBxPbzv3IKwf6sFX0XKun/ulAOZXv65Trpf3AJEcyqoog3MQoqnav0grA8iWAkmkwOYgRr9SpiHAvTb7HCdDyRF1fvdJZlBrU90ZNplBYg6liPqRmh2GnYrhajG9rn1M6LFRh6+7W02QQQrVyAQRPWw2wrLa1IzS0MC38lgvywUKUIe7I1A5qLRkSaIREPPO0c43ymPifPMhWuj+RhuFVClP9Uho8OoP1sX8Fnazyz9Tw+QIWASYp85/hDvsB/LD3SvUut8mlKQfqC65C8GoRUEUbfLqRDhqqQkyJDJrzkMuScslBQEJwjxYS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vCJOvnQH43pauivrDiY21+0gOaJa1qJDR4tLmPkLWI=;
 b=iaGbcLmS8ug69s/1lXplwqjeOfE5/NiEg1hL4VprBjZyrcRZ1MblMScDtGk8CYTZFYVyRnIehslE2+oLCidI3O/ydx9Nf5yFBz6VUj63Du25ZDTXfvn4tbwmlF0U3cAuChjC28ZiMci+Hg91kcIsfg0ZN0PEKbXD/D0RO6c33KbuWRGYnFnH7Ldc3Ux6nEPsmOTQjntiPQlHlIHu9sAG9i0BdD7Kz9/TJI3VqeUWF5s6EnWOEm/iaks0tC46A3AwzGQlzn3U4vxA/LcT460VeQSPtpXJJf7QfZM8pYO2Ugu+h2gpQ7hrloK8ZqzLPIQxsdPeZrPvxJgHS86HaJ67Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vCJOvnQH43pauivrDiY21+0gOaJa1qJDR4tLmPkLWI=;
 b=LAxTKjgfsLzaNeayZyuSIrBtZLH/nN5OEdUMp+iAUs6vG4e2/z75cjlCxiSRyo43Dzrs+REMZj9v58yt1AK4KPAkeO+ZtCtTLYL3oeZRG0wrkFsw6n10CoxgKpXQM1b4fyDJeLnmNQ0CbFRu2piEZaXoVJ5eTh2FCC5BO8jCdKk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 21:51:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 21:51:03 +0000
Date:   Wed, 6 Jul 2022 14:51:00 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Message-ID: <YsYDxLUebryYIuwe@monkey>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3662d4-14fb-4cb4-768c-08da5f999f51
X-MS-TrafficTypeDiagnostic: CO1PR10MB4578:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /c4YeGu0kC4ShTWQ63hSGazoLTFyEAbwsyYxh9rgvrvi48gr7Lsy9bFCou2H6XK4C5EC5PfZ+aFszNY6Jy97WiCfP+kxEJQ/iqn2BDn9w9zL+j5vosY5FT6IfGiVr5Eb/ZAQtqywVFKvPeRsSRR5bHL+ttMJsThB0qV5yN55GMc9C3m3E4vcGfvPja6QufrYj1xNcfy844qC73W5jqJUOaXhePHWeES0zWnLlxWP6qgjq0Vl+lB4Fz85yw1FWIea0SukaZs4K+4X1OqHk4lNfe8MWRDxAWmTD29S1dCraC3+Jwu+FE0G52/tw7tOU//9Dl3K+zhjbxdEzT0l89m8cCJw4IX48frW/0vCh4zBecvM8gV2svgaoN3xudgEZyTXMzFVdFtPOv9e1fYPDdOdVNINbJQGEcqpEM7Zhd8qyuP96pdhaVUZhKVTwkek9p39F7u/bkCcEqJ4RSj1m0tseMPk4FQuW/J4RbDdFOgVOaqvmhOjFo/xCsrHNdLegjSg39CGMCtHEUF2Lnc1AbC2dbxsNQAqy/CTRXByHWJVBTZclEC8h4M0Nza7vc2a9r4rWbZC/zom6TAhQDojQmu3u2F/xb+nU1MjSNOC1bPYo4SK0x/ckj8bJJmhuEkhlwLtFGRbmGy2xTYGxA+4hXFdX3v7/B/wvy5ppqoSLzP4BNcSoXqx1aRT/s+nKDfXthIb+PQFI3tE1ujpk52dfqyfm+BAYTB9e6oGUteT5XxA39PQgRfxlk859ht4vtbkjORe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(346002)(396003)(136003)(478600001)(54906003)(6486002)(41300700001)(26005)(44832011)(7416002)(6512007)(9686003)(316002)(8936002)(5660300002)(53546011)(86362001)(6916009)(66476007)(4326008)(8676002)(66556008)(66946007)(38100700002)(186003)(33716001)(6506007)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMAD9F6Pv9L2fxPg5oQQwVHvQi8NNuIMTI3+LyYOdLWrlKaxDqFpuh2lU8iv?=
 =?us-ascii?Q?0PHmb2egEftlVS4sXkhxpZCx/4nsZy9bLfhoQ1HCiH5Ef2q3Mw51QB2qtHfr?=
 =?us-ascii?Q?4Z5COX0E1gjC1hpoCd7qvP71FNE8afc1FAw0BFxxMVVFfZkzowUqpb3RqPkQ?=
 =?us-ascii?Q?9hAqddaPyLLugIoKW5hwNzZFyTZQ2PmAYA44bm9PLSz8P8LAIznpR+Rr+2hx?=
 =?us-ascii?Q?3pEpJtnF3UjgJTKvjX4gYb8P05mKXateSzlzfU7lYJVxVB4d/aIgIKzbpmKy?=
 =?us-ascii?Q?EKGu7FLpB5r/37c2PZUFA3x/TDExtoPt56fRRwM5Txp3SqdlqpbnN2g9Qkdt?=
 =?us-ascii?Q?qriIOQldEo0oZyjXjNrykXrDrVLkD7FnhbCC8eYO9JdtgJN+6TFFgyGj1rDz?=
 =?us-ascii?Q?ztuamYWSGjfPIcdho50WfUEA+4+7AFY3SzqYI5vVW1l+/S3iNFwC734AQ33p?=
 =?us-ascii?Q?L47PHAC0jwcYphMtXucO3ERaY9RE4mZ0pAYIr2fjSUvDKh0zBhfLil1Bs4Lb?=
 =?us-ascii?Q?nsUqXjPUTuCiwXfr9OB4R8Hm9stBV2F/Ca3E8aNSMCuoGAeiWCBxrLRk0pjk?=
 =?us-ascii?Q?pHRmSXOTQxyVcTG+7tvDFNoaGV9WnChK0qZQaI/8eq2/hPdBSDJBo+ABW9VX?=
 =?us-ascii?Q?ntyFn7gOwo0jixYZBLo/ANEU89qG1ExhMXRSVeLaLzQmbSk12WNbB+eJAvP3?=
 =?us-ascii?Q?EiJjyTw1iLOjhpRpEL+lJHQJO5dKU0Js+qpHZKNvJku8rL+ToJiiGc/9UKr0?=
 =?us-ascii?Q?6tVBLw7LIG4fXPpTcKMLZiYfVIhRYi2vgudLGetz9efQ3OMl56eIaG59ABnW?=
 =?us-ascii?Q?hKRxBOokdxTv11gLzw5iKD69v/TfbGcp8a4UDhUQf3PR3b4cCS2h3pU/1VTt?=
 =?us-ascii?Q?zO4YwHra81BEw3MpghBCWX0UO/5fRnLzky7dw5rcYHeMSfzqF02a2ODRqySm?=
 =?us-ascii?Q?E3XyL4Y/IA6UDawT+3QRL+12KGEnqIrxGbusaSLYxKZPmFU74dUXrsjWHv/p?=
 =?us-ascii?Q?+nCDjBUAKQWhjddO4X5as3XxdKTjxb2ADh1QJ8yBe6MH7/0IFX2X2C0pac4h?=
 =?us-ascii?Q?IDc8pmuUDRxxrsvzQDYpcKxqhQjiNHgELLQp9EqSNZxxw7vZUMLxh584wvQO?=
 =?us-ascii?Q?avK55nlzLsgY4tt7q5XF226rS+9t/F/zeEQ+9tgIjDYNitnrIOMd6KFILAAe?=
 =?us-ascii?Q?uX/v8PBwRBc/3D4P405B0+0J9nCihcLRdzUe72X6XX3425Ow8pD9bUEv3KcW?=
 =?us-ascii?Q?2OrtjJeNTOt187E/AbWDx3Lo4Z430xMQztKEWVhMaRYqHvPPtBD6WtYqXqov?=
 =?us-ascii?Q?xEX8lRgTZGWvU4yC7Z9mG34zFpobqTmyy0JxiNXeoab2XrAhSsozek9REbX2?=
 =?us-ascii?Q?nTRCIbizc2qdOjc0LVvP84lHIWRe3lomJ35EDNlgxBTGaBsrbLoTXJQYDYQC?=
 =?us-ascii?Q?YdfImC7ca+8lhisGAz4p3ieT/HfGHr1BQrMqSalXkIFoCoq8V0JFpVuWgntC?=
 =?us-ascii?Q?1zM0T39CLLQSlISBtU6hji8xQ0QrpEyDmleBz0hDftJLQqbu61E/sOELuTZF?=
 =?us-ascii?Q?Zs3wft9qXJ8nYxnBtWPbSrUJ5P/QJ1V+JJnQN+dIK6yzqREVomgwTt+69nRF?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3662d4-14fb-4cb4-768c-08da5f999f51
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 21:51:03.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyJkqmB4oEz9+g0H0cAAQdp+YMug7rTLNvVihtQ3hZxJTZ4yiHcGYB55zGqwltoJSzSkLYuhSeIxjvQQfjPPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060082
X-Proofpoint-ORIG-GUID: PDX8lGj2nENue1U0zobTfqsaYZn89ajf
X-Proofpoint-GUID: PDX8lGj2nENue1U0zobTfqsaYZn89ajf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 10:33, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> I found a weird state of 1GB hugepage pool, caused by the following
> procedure:
> 
>   - run a process reserving all free 1GB hugepages,
>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
>   - kill the reserving process.
> 
> , then all the hugepages are free *and* surplus at the same time.
> 
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
>   0
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
>   3
> 
> This state is resolved by reserving and allocating the pages then
> freeing them again, so this seems not to result in serious problem.
> But it's a little surprising (shrinking pool suddenly fails).
> 
> This behavior is caused by hstate_is_gigantic() check in
> return_unused_surplus_pages(). This was introduced so long ago in 2008
> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> at that time the gigantic pages were not supposed to be allocated/freed
> at run-time.  Now kernel can support runtime allocation/free, so let's
> check gigantic_page_runtime_supported() together.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> v2 -> v3:
> - Fixed typo in patch description,
> - add !gigantic_page_runtime_supported() check instead of removing
>   hstate_is_gigantic() check (suggested by Miaohe and Muchun)
> - add a few more !gigantic_page_runtime_supported() check in
>   set_max_huge_pages() (by Mike).

Hi Naoya,

My apologies for suggesting the above checks in set_max_huge_pages().
set_max_huge_pages is only called from __nr_hugepages_store_common.
At the very beginning of __nr_hugepages_store_common is this:

	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
		return -EINVAL;

So, those extra checks in set_max_huge_pages are unnecessary.  Sorry!
-- 
Mike Kravetz


> ---
>  mm/hugetlb.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2a554f006255..bdc4499f324b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2432,8 +2432,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	/* Uncommit the reservation */
>  	h->resv_huge_pages -= unused_resv_pages;
>  
> -	/* Cannot return gigantic pages currently */
> -	if (hstate_is_gigantic(h))
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		goto out;
>  
>  	/*
> @@ -3315,7 +3314,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	 * the user tries to allocate gigantic pages but let the user free the
>  	 * boottime allocated gigantic pages.
>  	 */
> -	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
> +	if (hstate_is_gigantic(h) && (!IS_ENABLED(CONFIG_CONTIG_ALLOC) ||
> +				      !gigantic_page_runtime_supported())) {
>  		if (count > persistent_huge_pages(h)) {
>  			spin_unlock_irq(&hugetlb_lock);
>  			mutex_unlock(&h->resize_lock);
> @@ -3363,6 +3363,19 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			goto out;
>  	}
>  
> +	/*
> +	 * We can not decrease gigantic pool size if runtime modification
> +	 * is not supported.
> +	 */
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
> +		if (count < persistent_huge_pages(h)) {
> +			spin_unlock_irq(&hugetlb_lock);
> +			mutex_unlock(&h->resize_lock);
> +			NODEMASK_FREE(node_alloc_noretry);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	/*
>  	 * Decrease the pool size
>  	 * First return free pages to the buddy allocator (being careful
> -- 
> 2.25.1
> 
