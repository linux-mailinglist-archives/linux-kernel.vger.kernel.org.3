Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0054E907
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiFPSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiFPSDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:03:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01CC4474F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:03:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFV0EF032726;
        Thu, 16 Jun 2022 18:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Uua3kQlr7s54gE0BxM62bAAi8e8HEjmYRtKgJQKIDqM=;
 b=NIbeLdfp+6Ni/uyKKMHFmZ6N8tyb+eSuK14iD4XQTp0Vns8lYPI6aU91MAk+S25ByzCz
 vShnqV0+4nSLB57ujYvhKhmNNSgeovcSMnXUlfRSedBF4cBAzaFwCkjQ6PJD9Pw7dXHw
 GstZ8cZiZYRJtq1pALJ/pmsOYEro+XuR3tAGOwnSLFk2VwFhlJrG0UlAaJzjk5m03XIs
 aL/VWKlpXGyj5qAYQQsc5Z0VZVWXlXmXuF5cHNWTvGySxUm5EXvXrEdt+A3saVMSaxK1
 t9uLnx6a5vKEEa2P6FR+IaQmkn2+nwPcwgzsZw4GKhW0IbV8ar2TykFHrFQ2sCDMpn1b 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2v4de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:03:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GHaS2K009538;
        Thu, 16 Jun 2022 18:03:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq2ntc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJT1yXjA62YLzduqI8Ng9XqSHlgoL/aR0aCtCBpzOOR9sti3wg+J6jo1Ix2o0NPQQFOk3YiHHDkykoIEc6TQmACQ51UqM/FH5pnStnm6YDOHoj44G7wRJ8AdG2tz9rS7KH6ydJpgyWNLgg8yUohHxFw4mv9Bs55hClIb6yboMWMx51vSjct+L5YT+Ne5aHWi+1mlJJwP2paLvqP9dtSiTAnJaMBOS21dvRyMQLj/VD/ghc4aCxlL1XX/jUVQ3c2PA9koBKJ9lruzWgtPRG7oDYDgIKo9hNMAZkLQRb+a9fsmdxjDwCr99ans/I17sbK7lCRMow59xM4qc+sWLfJz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uua3kQlr7s54gE0BxM62bAAi8e8HEjmYRtKgJQKIDqM=;
 b=HDY+4fT0N8t2ZmJbF0zt2gw9fYop9g8fTNit0iUAChHaux6wRI+5QJnkJIqI5TJMbn8zS2W4a75RTMBi1gSnpr+Q/9vaCWqubdkjnSpd0Gfqh4ovcDaE+wIoKx5GJXwdkEsrFRk9Eg5eBm77wrdUaggMj+cn/1UpVW+9WtIfstvQEuXLqNwi0/VRawxh1BmU08b0FdTAsGJJ3oCmUVY50oeTutGPCK1HUEE8aeFB4/faP96VjxzQ5mvf3kNxJxdhyXTMEI89Rj1pbDHXQzSse75mpUcleFJcUSh73Yh6bq9+uxr2aWOgugb1g+JvrSBVYLzSFsc0sDkRJlQUGg5Y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uua3kQlr7s54gE0BxM62bAAi8e8HEjmYRtKgJQKIDqM=;
 b=nP5laO5f10V0gJr7Y87xAQY9qWRJwvgqu7IlJdthrHX/A2wfKr6qB/pKQkDXMkMz4ONPrC2VDQz4yLRgoND8Un4LQvPdTp+Pma+9Z/CLs5u0a/amVOQwE/d0yJrpAOdzcae4XNEgB1tr9hpAiKbo4AqKGRL/32UgXDWo4aFxnOY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 18:03:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 18:03:37 +0000
Date:   Thu, 16 Jun 2022 11:03:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: remove minimum_order variable
Message-ID: <YqtwdhEx+57uDtpQ@monkey>
References: <20220616033846.96937-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616033846.96937-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0267108b-cea7-4104-c05c-08da4fc28978
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4543:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB454312FF015DCC171F08E6ADE2AC9@SJ0PR10MB4543.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlQxKb2y8TTw/Ir0fJfOE1Zh+7Qne5+HiQwj4tku2JzPIxEU+YdkUoOe26vg+QoFwed/W+YVn/dI9acNFxjAKkmyEAhIe9SGVWq4orMFn1NSsTQ8zdrYdF6pF+4MDj09fCsUg4puZy+NZGfI1YiI6C4BEPxEv+h6NBWaYluQBatp/fro/7L6bH42d2aungrQhHGjzHnuJ6vGSVBpGitNWwGLtxE3h5IfO4ypl6c+LVw1UYV75Iwgz+t9TmtoYm1aVc0Q2hg4lJAIHKcy4jLxMwVsjnHElkSJk+bWvyzAC/4T5NLrFAt+IX1va8+k7ZvqFlPiouvOh+cwUePIKzlqlyvMhKjzX2r7+GarbeBgP+1qmDIyiJyI7ElbeZ22Jsk4D1cDbFd0/3zXOKItGA3QnpT8NY7Ujt7pZ4OIf8iKqbLx/hBQg3w2D/rZqy/zPy1QWW+7Cg93o5cFUJD58PpEmgWSHdGwxywjxbizmRHHVO+UM0aMNZR8r8gaZ1O0f5rkjuuYny6+89Izt/lE1DiWvVbmjf9FBX+iCcVI013+uGldQylYwMDt4JEK8JT5akISM2u4yTGNvm2Dpyxy467D/BkhSCS9Dg4j62Xs1ddTJTHb57oY2WZDd0NlCWbrV3UPv6UKfgyW64w0PqsgE/dvVybIZOF5mg7/nKS+BPqYrbnEUHlEo1sgN5imDDLdgQoTKrOZ47W/VP718jYqg9mGyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(2906002)(6666004)(4326008)(53546011)(66946007)(66476007)(66556008)(8676002)(44832011)(33716001)(6506007)(5660300002)(8936002)(498600001)(6486002)(186003)(6916009)(38100700002)(9686003)(6512007)(26005)(83380400001)(86362001)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vWu9Vd3ysBDAO3Jbl79WvOTuiEulWw/mLvaMl/rTfjaBNO8E8wwLdXknwa6?=
 =?us-ascii?Q?OE4M7FIUGFyqNpWsscH6rR6X9ghJIuSBZ5X/kEw6aOav3VKs9MKkh2Mz4wV6?=
 =?us-ascii?Q?llyDDVFy8S7Ymi9ujXtgi09I/EufsWaiajRj6JtDg3UE9TMirzbWVCk/MrPE?=
 =?us-ascii?Q?WHnfu9wF8Tkql17pxwk3saj3UZymsyLI5yYXyxLD28q/usq9SGjwlR8/eG6w?=
 =?us-ascii?Q?HYEUDNGh4cN2u+ZPlIY7yqQPGU0WCwtQ6wIuzmEupIAutsTaznMJLu9fdZvE?=
 =?us-ascii?Q?d6aw4/G8yjIPuzpqeUqZnq1Vwp1Za2mvdlOnudbRti13OsH8RotAWpMfJMra?=
 =?us-ascii?Q?/00D2S1R47D/f+mK1V+gJNqTqg2ZPlQUoxbQUT0ADOohIiNeXcxszCFLrn13?=
 =?us-ascii?Q?SmKeBt5m+wEIDjED9jjTT+7wSaFizRwJWvU+h21HXwQww6UuJ4EZnHHiWvRb?=
 =?us-ascii?Q?uEBq+7JDVrT01UvV0Xxgz66LVl7kAU/Nh4hglgrG1fx9/ZLMv25mtBdmhT6/?=
 =?us-ascii?Q?MBC7oYIe3LfgCBf7o7Zq9zv/8lmnAPZRDFxUm4uQn08R6Uw+Vt5Hyue3ztgP?=
 =?us-ascii?Q?JhMUktOlo3Ihu/OVsK/rokMviE4a9eBFs4NvujEXrexIdZfWuSzENevfvCWO?=
 =?us-ascii?Q?xB+0Oun6Xl8TmauwUu+VzZQN9v3x0JVW0c2FkSW5wv6llrNOawb7FZmF4yiH?=
 =?us-ascii?Q?CoLbK4Q0McfwyqFjX5ZcosLozC3oeK0w2q8716khts8G1SdeZuoPW277xUOY?=
 =?us-ascii?Q?l3InOw1Ng7lIIL51j9KwpL5z+6oUasueeH9f4K6aluqTclq61GS8q6gRdebl?=
 =?us-ascii?Q?iiH+qcyaCoFrqeWwe+uAM7Q6mdvw7o0cnSXkiv7s6tWzSFwSQOCfUc1gc5u1?=
 =?us-ascii?Q?xyzuVY7IFVH9RsXQ3JLBy8bcOgQ10iWp0ZE7AVAPZJ6uUj4I+gZli7CeSc1n?=
 =?us-ascii?Q?ER5oGEkB43QIhE7UIDNFaPOX9NhAoARZoISJCpYdCSQshHMUojYpV474mhig?=
 =?us-ascii?Q?5/wK8GWw/Izi3pUVSoQkEdIMEjkG8tpd3M2cm+xlDg/5DeSr9SKL0/OP3mMB?=
 =?us-ascii?Q?8vmdkzd9QmGYvo3vKv1JqAItWk3LPUxu2409njSCM7hzreZ6psMOt0pfBqBj?=
 =?us-ascii?Q?zjmu81HQpGsXqfcyy1LjIzpEQVT9yGKgHNOANAFkvr/6Clss8+JcocsbE0+A?=
 =?us-ascii?Q?ryr2mmyAZJeIicGnb4NenEKRGhA98w+gQaxT4fFpY5W+BfxYRq/jXUHY08No?=
 =?us-ascii?Q?IWJDG3xr/MGqNGh1N71fDT4RG/qVw1nTu1NggZoSwxUEHldTNDgNE2p1tyAW?=
 =?us-ascii?Q?hcYJPxi9tmSkrIfcXMm8D8FY0vS7a3Nobq4TM5atHRxt4gSZUZ1Tymy6FcML?=
 =?us-ascii?Q?p6TQXw4LDVulsHBe8KSXGCjytMWAB2NJ56sJ8YuMO2JDSDn4LGB5zclwDd+h?=
 =?us-ascii?Q?7fFJ32ehKm7AJ6HVn2FO2Qocc+5j4d6hJq8vBLcV2N7iEy3gOZ1uJUPKphir?=
 =?us-ascii?Q?m9z5U6VLDiXNQ3VSSFa0brffxEvOB6jVbFLxqMJrLQ8VvGlujVO+pdKXHzb9?=
 =?us-ascii?Q?AVXuqgFPiNYnTZEWkJSRYszPdzHFR906CoF2mHIIfm5kk1aUW68sI+nejs4Y?=
 =?us-ascii?Q?mxFwHbRRzUJR3WUnZBj2kEKiSe1k6o6n2hCinV8NeuHghmo0Sf/MMQf7JtyH?=
 =?us-ascii?Q?zBGh8Y92VtCFdkHJg721NMg9fYqpSXlzLRPfHHXcnqohzdgFEXBn12HBLZ8T?=
 =?us-ascii?Q?2Yfsk9O2VQavrIznfrhDaIUebCDkcD0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0267108b-cea7-4104-c05c-08da4fc28978
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 18:03:37.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjcjK+GKqRknKi1FgbS4QNugxOqsNIaYKkRNguTuydyywlFZO8RFqvCk/A76ym812IAgrnzjfwL84jghbV5TEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_13:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160073
X-Proofpoint-GUID: cpg0Fb-5qXRZu69CpP4TE1g2vl4XhPjt
X-Proofpoint-ORIG-GUID: cpg0Fb-5qXRZu69CpP4TE1g2vl4XhPjt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/22 11:38, Muchun Song wrote:
> The following commit:
> 
>   commit 641844f5616d ("mm/hugetlb: introduce minimum hugepage order")
> 
> fixed a static checker warning and introduced a global variable minimum_order
> to fix the warning.  However, the local variable in dissolve_free_huge_pages()
> can be initialized to huge_page_order(&default_hstate) to fix the warning.
> So remove minimum_order to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8ea4e51d8186..405d1c7441c9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,12 +66,6 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
>  #endif
>  static unsigned long hugetlb_cma_size __initdata;
>  
> -/*
> - * Minimum page order among possible hugepage sizes, set to a proper value
> - * at boot time.
> - */
> -static unsigned int minimum_order __read_mostly = UINT_MAX;
> -
>  __initdata LIST_HEAD(huge_boot_pages);
>  
>  /* for command line parsing */
> @@ -2161,11 +2155,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  	unsigned long pfn;
>  	struct page *page;
>  	int rc = 0;
> +	unsigned int order;
> +	struct hstate *h;
>  
>  	if (!hugepages_supported())
>  		return rc;
>  
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> +	order = huge_page_order(&default_hstate);
> +	for_each_hstate(h)
> +		order = min(order, huge_page_order(h));

Since we will be traversing the array of hstates, I wonder if we should
optimize this further?  We could:
- Pass the node into dissolve_free_huge_pages
- When traversing the hstate array, check free_huge_pages_node[node] in
  each hstate.
- If no free huge pages, no need to do the pfn scan.

Yes, the above is racy.  However, the code is already racy as hugetlb
page state can change while performing this scan.  We only hold the hugetlb
lock when checking an individual hugetlb page.  The change above may
make the code a bit more racy.

If we think that is too racy, they we could at least check
nr_huge_pages_node[node].  If there are no hugetlb pages on the node
there is no need to scan.  And, I think we have isolated this pfn range
so no new hugetlb pages can be created.

Not sure if the above optimizations are worth the effort.  IIUC, the
pfn range is at most a memory block size which is not huge.
-- 
Mike Kravetz
