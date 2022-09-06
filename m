Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D15AF24A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiIFRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiIFRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:18:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDD96753
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:07:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GNxas025868;
        Tue, 6 Sep 2022 17:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hSrMo/2TUUptZSppsh65rIud+aVg6iPumkVfuvP6xxE=;
 b=DtQRDUHxMiaPQwAmqAG4wXc5py+2RzP2q21djOdUISaU1V9FmMkRWVo1uJ9wIXrQYaiO
 cNIdvPlgLxgYxZ+FGUU73+gSluq9U3iG+ZXfYlqUtfKXIZNTDgbxzJPDYZ+mx6omYPY1
 7qVG0ERx4Ja0D1q0zVoUWJo3+BDUpm17gdGQ/fjfbdzPeoIsPGOOUUrWv1UclE+YGGOc
 ZgNs35pmwrxaLcxzWUaFdkPMRl04a3YcTwp3hgfjmrY64pFk+5GkvxzcmdHFnd24kD6H
 7ILA9dm94+fOPy2tWGYKeNbpplAOWDDBBwBqxJKWVEkxu17JP6yOFQxp3xCxIhEfur0J Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2ejh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 17:07:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286EsSoB030607;
        Tue, 6 Sep 2022 17:07:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc368b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 17:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1jYCL82dck+nl8l6mpI2QjGbwjCm4LTjXseRBKVwE0Omnvi6R9wt79R1pWP7BOOwa9hjEjmUcbJe7I6n+ucWfLPV+8PMimCamGB1cOMuLYKZJENNZBUjQmh1zLDDAocbf4PCQccJKt6yLpPcj5BbEyjyMLLHuWbloOOhsOwXult6F6PtpsMdHQZ1FYwbiw5ClNQ7qYaaAyxF+w9eOgYZSwyVKA+BkuJF8qWB7TBcc4kRWJsDLz3eKSgjEqmNI/TRSabeXqNWMc8rbNC/5j7W2ifsoINYL8UwoKIntER1D0kL+MYCsxClWg4A6EDbh1JHgMsA04bl6Oj6U9CGH23RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSrMo/2TUUptZSppsh65rIud+aVg6iPumkVfuvP6xxE=;
 b=bLBl1bSlKxmhgaewMwuode6V/NUlXlESB0DG+PLcWHPBULTzBa2vUsHNR0ONlOIaUY6daWlEpqqjjCALUK04L/AFCqxOAgxYp5Ehr3K4rk3dHMWgcOpwSGl0B/dI3CZMb+YHWZ0zhCtQ5AvfPwFiq50B+og/WmFkuRpYVPIHdJhbW4ttpADpXQqZHUAgKIcbymIgbAtEwHDfUMuJFBOMIuqigoSNh3YCNyGKcwiOmGMa6UrQG18TLcFJqs3CKtnFfvN/1kiiO9/Tvv6m9AIZaM+srFLq17JciL6q5PwKgg7BunWHkOt92WyaKyCViu2Dkz1oZXoJi7lon4LEYVECyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSrMo/2TUUptZSppsh65rIud+aVg6iPumkVfuvP6xxE=;
 b=y5nwizmzFTOqnYLNarEnRHmmkXzQYaBKs5u0rvULd+lmSSndHylEc0LPLJXdDzWoL2KhoxyhXVOYju8lBxrR45t9wmw0PNWmdxXnF6/NWvZAJIJ67dHsesz4eF/Y+jP2A8U0gwh5/O8yJ3Lr2uJQP/8DujxaBDuBAKzcjJXHfNo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 17:07:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:07:06 +0000
Date:   Tue, 6 Sep 2022 10:07:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Cheng Li <lic121@chinatelecom.cn>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: use mem_map_offset instead of mem_map_next
Message-ID: <Yxd+Nz1wAwiIOWsd@monkey>
References: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cfa8fe-6207-4267-35d8-08da902a39ec
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlNM0sVPon+xuOYjuadKFvpcW6QbEXJSD2xXDPjfTYfdjVGrKyq+bhVnyebSB5WB3StJueEah0r0r4F/xr7JNICGpzd2nH0JBK2E9CmwIxumkpB4NNG6colLl49/L20qb39X9WpNIYRWUrVIV7+O6yxLQtc//8j2w2qg4r8uzmQsiVofyf5DRe6hXN7anvDMmyJ6enCpbKn1Fj2N1rR37lo2EC/kYAGMytYK+auKjqe/zZOxysRSUkHReE+NHRJwE73ZRK+Vn75HBQMC5FZgkg4YfhYzIT8rk+1y2kPK2uPuji5L27MdU57IB0cQoWKMmC5ozXWo4kDzIAMSkpLDVYq/kkqUVF4+GBjruVmDk466EStYTrBZLSPcJLLDa6HuY8rz5NUAq58B7trTryWAEGxzA5CsYtBRrj5+k5lVgtnDY/WbyEVFoz+TV+uuGDh51O0s1HIf0+O67eIo/r/5P/6sN0s0oY+4FGjRxh0kD9o1IL+6p6xpdtZ8Mhd5ow5GMnR8VlL8nmGwOtyMeiEjc5jlIW73/DrgKlcG2CBgDYO/Yy37BPYE4KsnuGseZM4XFEcz80MHg6kSn82HzOtZ3HtSLeuI6Ge1qtKRf+3wOOdoP8ItsXpQyC1QCSHSirttL+ldjzx+w+1llx0vEPmCSxMd47usIkWO7Zwlau0wVJZ6li81i1JKbdGrFJrLvDkuQJ3AjrqK2PKZBNPhsgxa8tKZERr/z+tM28Kr3Uk3lwCxXHC36wU575dL/sYK+o+F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(83380400001)(4326008)(33716001)(8676002)(66556008)(66946007)(66476007)(6666004)(41300700001)(316002)(6916009)(86362001)(6512007)(9686003)(26005)(186003)(44832011)(2906002)(5660300002)(8936002)(6486002)(6506007)(38100700002)(53546011)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgmUevYQ35hsUpXYUyQa6p6GducIFv+AeiYpLK5Z84kG3KxZHt5q79kmhg8e?=
 =?us-ascii?Q?856pwWCNh+igwshI3PE91d3MHYbXA2srfX5W8pjArzic0GfgaDy9ZaecXHul?=
 =?us-ascii?Q?4a5g+8JMyADwIz1W1oyCrl1DuGdfvo6UVffatn3p5CLfNEeQzLefqq8J/qLU?=
 =?us-ascii?Q?89XHz4NEN1b+9oYRR89+2KT6A2pfp1LHkBxraUvL4EpahksoZ/u6+gYYfMOq?=
 =?us-ascii?Q?tsPxIpAhJRSNLf2Q0TcYExUdK5zZB3VEDOx7A4mlplLGwOJC7YBdvuizBqV1?=
 =?us-ascii?Q?6bcI8J/rlf3Ox4lGgG+JZWy710rCu9XxK74xcBnM5VQbUAg1PhSQjS4Vu9ON?=
 =?us-ascii?Q?Hdl/nwQ59dHcNQfyeGEDQJFn83MKfCZcfhUA9fr3WKvFK/J5bbgCddM+dGL2?=
 =?us-ascii?Q?pgcZ0TXCCl+QNSPT4veYUnffcDqnIA6QnR4gpxBXBtfpd9JhbH9QeMeSkZbR?=
 =?us-ascii?Q?Wx4262gKwc1+6vS9pWsGpjYAzyEYpeIU48fWlhy8n921ZmeCKOk5+yVOUljF?=
 =?us-ascii?Q?s/M+W14xEy2D1mDaFaqdcfNXhu43z5WQ/nvgIN3ztsfeB2lnRk1ktnGyHH0m?=
 =?us-ascii?Q?iiP1LQqAGED/Ad9KsFPSyx+MBhtQxFEErH8jQhnaw97R7JAfhi9hPWPrl5gV?=
 =?us-ascii?Q?Dzu7rXyEDTHJ7/VkPxAtSITuDXM1JThTb3dkDpXvjE2eabsBKoT7CUOr0Nsc?=
 =?us-ascii?Q?I0yZ/B8tso+q4Onq8Q18VRWnuHOx/rygSU5SjZroFwVwOn99XQoRW/Wnj3t4?=
 =?us-ascii?Q?lfjL6+Mq5+IV1mzG3imrRAbS+cxXwKl6Y36hKHwQAz4vHSvsBWOFIzuOTxSb?=
 =?us-ascii?Q?oo9QQgl3I2XiCseF37CalnuoQw8TvKybzhmFNbXOYTpJEajiQceUG9zKDUd1?=
 =?us-ascii?Q?FSww7BwPchJqnYhmi8n5/rPW2IMBrByryO/yiSJltTLqj7DzyIOtu08eJJzz?=
 =?us-ascii?Q?FdUHCXQZrh/vVkM65F+mC8yo562FEcdTNTY81YRdZkhsF08QCwU8z/t2kIFn?=
 =?us-ascii?Q?hLiAqyz2ibNKsmVFvgeur360wuJYTwhiw3VJMlawGyeyrN7EOgxkPSWVj7WX?=
 =?us-ascii?Q?4j+qaU3n4pdGuGP4gt/Rs6vuBmYl0/9olIRG6LBlg0Fpu9tLTgwpaMpprc0T?=
 =?us-ascii?Q?TeX+DCE5BCyNNvG4TzPUMtWclui6GEeigpzbAlwFp2DusA/sjoHPxxnP8lzF?=
 =?us-ascii?Q?sygqVfXWeO6BRuk7NCYp8qDDOdqUTndq1vzzZKVHYXPo4PqFCSUX7Et2CAlH?=
 =?us-ascii?Q?p4hNDZEvX0q0Y/Hsa19DX21aB8ywQw5zO9z3kRfPu1iKTGzbrPOvkio3NLLA?=
 =?us-ascii?Q?m45p471FJYa/53epQ9A0Nh2SUaQBlvRdiDuT2wXrE8+eiQJgIKspAICyWMdh?=
 =?us-ascii?Q?kbY1s0kH2v36MuIQTs+1f3CO+Tgq/kM8rwCjm1IAs9lj4J8VxJZGrYG0UkCP?=
 =?us-ascii?Q?tney0LStf8vJOmDu6UyvRXxB4k8t4Dd1gFrcTeiVNS7GlvetLotFncf1RJm+?=
 =?us-ascii?Q?BpX91ce/qdE1SOWEbNuDnZ4qLfrovdGNErFKwzLR3AKiUqTcrvkdH4YcxAy0?=
 =?us-ascii?Q?W4fCeQ0Fp35DbB/ncwguSQQnCUwG7B3g2W32RHC8N0P2uhJSYkt349hQFOXW?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cfa8fe-6207-4267-35d8-08da902a39ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 17:07:06.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icL3BrUiFsIEtjamV0z9QBcAPitBbW7puaxZF43wCXqOvjH0L4oEq6HAoMtfNGlIBaba48xnFElZgWI2MiHm+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=905 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060079
X-Proofpoint-GUID: j59AR8vVNGkcHGvTOqrHYz0YndU0O5Tn
X-Proofpoint-ORIG-GUID: j59AR8vVNGkcHGvTOqrHYz0YndU0O5Tn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/22 06:09, Cheng Li wrote:
> To handle discontiguity case, mem_map_next() has a parameter named
> `offset`. As a function caller, one would be confused why "get
> next entry" needs a parameter named "offset". The other drawback of
> mem_map_next() is that the callers must take care of the map between
> parameter "iter" and "offset", otherwise we may get an hole or
> duplication during iteration. So we use mem_map_offset instead of
> mem_map_next.
> 
> Signed-off-by: Cheng Li <lic121@chinatelecom.cn>
> Fixes: 69d177c2fc70 ("hugetlbfs: handle pages higher order than MAX_ORDER")

The Fixes tag implies there is a user visible bug.  I do not believe this is
the case here.  Is there a user visible bug?
-- 
Mike Kravetz

> ---
> 
> Notes:
>     v2:
>       - fix build error
> 
>  mm/hugetlb.c  | 25 +++++++++++++++----------
>  mm/internal.h | 16 ++--------------
>  mm/memory.c   | 21 ++++++++++-----------
>  3 files changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e070b8593b37..a9592f69bf82 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1308,12 +1308,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
>  {
>  	int i;
>  	int nr_pages = 1 << order;
> -	struct page *p = page + 1;
> +	struct page *p;
>  
>  	atomic_set(compound_mapcount_ptr(page), 0);
>  	atomic_set(compound_pincount_ptr(page), 0);
>  
> -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> +	for (i = 1; i < nr_pages; i++) {
> +		p = mem_map_offset(page, i);
>  		p->mapping = NULL;
>  		clear_compound_head(p);
>  		if (!demote)
> @@ -1530,7 +1531,7 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
>  static void __update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> -	struct page *subpage = page;
> +	struct page *subpage;
>  
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
> @@ -1561,8 +1562,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	if (unlikely(PageHWPoison(page)))
>  		hugetlb_clear_page_hwpoison(page);
>  
> -	for (i = 0; i < pages_per_huge_page(h);
> -	     i++, subpage = mem_map_next(subpage, page, i)) {
> +	for (i = 0; i < pages_per_huge_page(h); i++) {
> +		subpage = mem_map_offset(page, i);
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
>  				1 << PG_referenced | 1 << PG_dirty |
>  				1 << PG_active | 1 << PG_private |
> @@ -1769,13 +1770,15 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  {
>  	int i, j;
>  	int nr_pages = 1 << order;
> -	struct page *p = page + 1;
> +	struct page *p;
>  
>  	/* we rely on prep_new_huge_page to set the destructor */
>  	set_compound_order(page, order);
>  	__ClearPageReserved(page);
>  	__SetPageHead(page);
> -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> +	for (i = 1; i < nr_pages; i++) {
> +		p = mem_map_offset(page, i);
> +
>  		/*
>  		 * For gigantic hugepages allocated through bootmem at
>  		 * boot, it's safer to be consistent with the not-gigantic
> @@ -1822,14 +1825,16 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  
>  out_error:
>  	/* undo tail page modifications made above */
> -	p = page + 1;
> -	for (j = 1; j < i; j++, p = mem_map_next(p, page, j)) {
> +	for (j = 1; j < i; j++) {
> +		p = mem_map_offset(page, j);
>  		clear_compound_head(p);
>  		set_page_refcounted(p);
>  	}
>  	/* need to clear PG_reserved on remaining tail pages  */
> -	for (; j < nr_pages; j++, p = mem_map_next(p, page, j))
> +	for (; j < nr_pages; j++) {
> +		p = mem_map_offset(page, j);
>  		__ClearPageReserved(p);
> +	}
>  	set_compound_order(page, 0);
>  #ifdef CONFIG_64BIT
>  	page[1].compound_nr = 0;
> diff --git a/mm/internal.h b/mm/internal.h
> index 785409805ed7..1012a305a60f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -646,25 +646,13 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
>   */
>  static inline struct page *mem_map_offset(struct page *base, int offset)
>  {
> -	if (unlikely(offset >= MAX_ORDER_NR_PAGES))
> -		return nth_page(base, offset);
> -	return base + offset;
> -}
> -
> -/*
> - * Iterator over all subpages within the maximally aligned gigantic
> - * page 'base'.  Handle any discontiguity in the mem_map.
> - */
> -static inline struct page *mem_map_next(struct page *iter,
> -						struct page *base, int offset)
> -{
> -	if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
> +	if (unlikely(offset >= MAX_ORDER_NR_PAGES)) {
>  		unsigned long pfn = page_to_pfn(base) + offset;
>  		if (!pfn_valid(pfn))
>  			return NULL;
>  		return pfn_to_page(pfn);
>  	}
> -	return iter + 1;
> +	return base + offset;
>  }
>  
>  /* Memory initialisation debug and verification */
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ba73f5aa8bb..32179c4fd1a5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5637,11 +5637,11 @@ static void clear_gigantic_page(struct page *page,
>  				unsigned int pages_per_huge_page)
>  {
>  	int i;
> -	struct page *p = page;
> +	struct page *p;
>  
>  	might_sleep();
> -	for (i = 0; i < pages_per_huge_page;
> -	     i++, p = mem_map_next(p, page, i)) {
> +	for (i = 0; i < pages_per_huge_page; i++) {
> +		p = mem_map_offset(page, i);
>  		cond_resched();
>  		clear_user_highpage(p, addr + i * PAGE_SIZE);
>  	}
> @@ -5677,13 +5677,12 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
>  	struct page *dst_base = dst;
>  	struct page *src_base = src;
>  
> -	for (i = 0; i < pages_per_huge_page; ) {
> +	for (i = 0; i < pages_per_huge_page; i++) {
> +		dst = mem_map_offset(dst_base, i);
> +		src = mem_map_offset(src_base, i);
> +
>  		cond_resched();
>  		copy_user_highpage(dst, src, addr + i*PAGE_SIZE, vma);
> -
> -		i++;
> -		dst = mem_map_next(dst, dst_base, i);
> -		src = mem_map_next(src, src_base, i);
>  	}
>  }
>  
> @@ -5730,10 +5729,10 @@ long copy_huge_page_from_user(struct page *dst_page,
>  	void *page_kaddr;
>  	unsigned long i, rc = 0;
>  	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
> -	struct page *subpage = dst_page;
> +	struct page *subpage;
>  
> -	for (i = 0; i < pages_per_huge_page;
> -	     i++, subpage = mem_map_next(subpage, dst_page, i)) {
> +	for (i = 0; i < pages_per_huge_page; i++) {
> +		subpage = mem_map_offset(dst_page, i);
>  		if (allow_pagefault)
>  			page_kaddr = kmap(subpage);
>  		else
> -- 
> 1.8.3.1
> 
