Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20BB54FC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbiFQRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiFQRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:38:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7423EB8F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:38:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HFSvt4005230;
        Fri, 17 Jun 2022 17:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=n3r4NquQ2h1uC3l8rdXyqs6dlKnUKFB1b7CVLZYW6IY=;
 b=qXIXTCJWG8fqYRq18tSkJGZRWyHElygyGf3nrOghe4dxwB+4vZIlADnXz65b3dfWNBUH
 Ajnybk2J/ANGPnnJyfaMO4cOKy0RAmsaDizUPlWt5vXYVKOoaGi+DMRuCdsC+mTo2pp0
 ptVyVdbAx/hp3XCHf1L6BUWiLU2aguB86iFEvkgqwXJDt/atR1Ey0VqyPa7AsQH1Uymk
 ljVzdJ5wcLMx67oXgZ+WIBl4ivrPydlR0rjzOZTeV85K1QDehnbCfa9YLmdMn4NuWWlK
 m7y2Qs4nf9gBHojBKE+EBM5+h9BAqiOeq5f+7Wj53XjMBJuW6YZuVmQ8fZC1+K8b+Nu6 dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjnsedmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 17:38:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25HHaTYu008017;
        Fri, 17 Jun 2022 17:38:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbu95fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 17:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2K+sezvNP9bCT6Q/zjsurHlQPXxeL/mDLjn00rf7H40vTjUg9MQ0PWyYKbQoPun0hVR7tfkhJPMNjx1lxziPcKMj8fgyWp3JEOxWM5ywVzFNoHbikSzF7HS4NmP6QYHFDIuUTL2IgZ3J/bq6BeWtLF0TYgir0cNdIn0m+FnBaBDbyB2SDHsn4LJ4C93ckTUqbDLutYWPwRglUGvnHRkwzDzPLLqxj5AjDZyNfrYyfVt+SKYMRnXzS0L6NNA/B0uT9Zb2vDclQcOd1DImAG1S/LmX6PruCvfIGUI6YvDtbp3oJBTteUGmWfAdY+GG3hh50COUkg3KUCJrI5qs69i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3r4NquQ2h1uC3l8rdXyqs6dlKnUKFB1b7CVLZYW6IY=;
 b=BraYzogZdxmvf4mfppgB3tuH7LKqpIPiQ4Qj3li9fkH3X/IblA6XRBhBzoDv0Pmg4GNGBT7t/allwk9kPm5bhyZEBkbOdcSJbVO801AbfZ8nVxxHK6Kf04Tjg9FxYBIRUkUNMVgPrKCMJTtsu8CygPLXTcML7ScdBx3vE1UE6fUy/kploFhQtSjXOu7WtDQrJKecYtlxZY96XnJbcCog+9qkJnuqvIAS32e9Hhqb+R5JwwKbeXQpSCjxk6ZvtTm3LH12D5v7ulp3kgMobnbjBcW7GXd//CO9giWsYGMrmfwoxJ/Z34f4A7yGNfn4j2MdZxxeDzR1aXPEl6HAzzSLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3r4NquQ2h1uC3l8rdXyqs6dlKnUKFB1b7CVLZYW6IY=;
 b=bV/yS67lr1T6cB29Iy1VIxlAZVU2h09BwwwdqyyBBhztGNyLTmhFcVYq/S8cMItAKOtUB1SDbLX9PJOZq4goyKrvcqg4VkyWCGz6MvQIUw+WQzgTSkY7XFdfisvLOseV6Qz/XL4+mXuWavCJtYLFiCnGbN2GGyYs3C4bv/LDVNE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR1001MB2085.namprd10.prod.outlook.com (2603:10b6:910:3f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 17:38:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.018; Fri, 17 Jun 2022
 17:38:27 +0000
Date:   Fri, 17 Jun 2022 10:38:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: remove minimum_order variable
Message-ID: <Yqy8EaibIH1k7/qR@monkey>
References: <20220616033846.96937-1-songmuchun@bytedance.com>
 <YqtwdhEx+57uDtpQ@monkey>
 <YqwwOYIQ6KLuQavJ@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqwwOYIQ6KLuQavJ@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: CO2PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:104:4::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bff46fc-f80a-4b65-7f5c-08da50882ff4
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2085:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB20851DEEAFB2425239C585A0E2AF9@CY4PR1001MB2085.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ovmf3GmiW+gBGffuMDO74imV02j2kvt1dxW0MRa5Q2Kt22cw17CpEsv55lMFoGhqpQpOujHXmC5ACJWRel8KUNZ1ojnxHP5AgG6j0hcw5AtQOLyRP/wqkX9VgjXQyi3IRv3xjMwuoUrFVqybgFCHO0ywgQiJKqVAFde5sGOkKnvpv3NXVNPx08Q0DCosK5lJmWdR5xBuSdlPSzJcu7CD30ts8V92L3Ym68GVOSdGobrVI6cguJdm/NWolTQzSQSYq42Z4j/QQt6caSN8GK/UiQB5SE6pHDp+cRHSbLN1cY9lJBo2TOMLQLWL0XlADnUby65erL/qZ6jJ2t3LJmQ3NR9Hj3VpXTojhq19reQ0FZNYqAUxLi7LQ/Qw/VeqywtI5OJt6fzBd/Q9K2hL0JJTXXNVR9uB64/LsAeAX0lKRuQdCkZoupFxGVGkrNtePpdQaOd9Qebvzzm64RUb0DdWSlLSvrIOJy+1WrRPayhr1irKTPOXa98meDbqMsl3jQeoXl3YJt5BT+u5ZxoU/pZgPbkqaGBOUtE64fa5P23Unm3h9EJBVS/cbSaH5dUKKRCC/eN18f4STogRa8L+pYUWtqpoJb/rWrmsRDk7dSzgRTalreE5QbMC0Sa1CfsLgSNrY7o2M+kdcULFCOc2sWeD8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(44832011)(66556008)(66946007)(66476007)(4326008)(8676002)(86362001)(6486002)(8936002)(498600001)(83380400001)(26005)(9686003)(5660300002)(186003)(6512007)(33716001)(53546011)(38100700002)(316002)(2906002)(6506007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4XBdUhMOiD65Hasq5cAlxj9M+HE9x84a3ylcLWfg+JDDsSb94+AfltpZjbU?=
 =?us-ascii?Q?1sKN0o21PeKQmNUNtL0d++rrKwUb7PWyWeat7XmmqwggMNhbCIloIFLdNw7T?=
 =?us-ascii?Q?EpSt7ItFP1Iqjq4CleJQbWTf49qKARdK7Ah/S6E6SHnzY4X+Bc/BZnfLJ8Bo?=
 =?us-ascii?Q?ZmCnj9qM9y2darC9IAVyZCYxep9OVSivaEIZKSYSiY21jkrILLj5MViW7lkg?=
 =?us-ascii?Q?NipL9xcl0CXA20JkTb14NUI1R1BixBZfjmonLVvSZQ6crQYIfuRWTOVrQCaW?=
 =?us-ascii?Q?SbcN1IRRdmI/ockOnC7nJJBBu1LFh/X7zdqr9cWdJsw95OysraARk0QmMi6M?=
 =?us-ascii?Q?U32qJXLKdvN/FdAkKBes7VLpg+fkJMaPL6c/ow9a96uCk6uTZQqvxDVsvwdk?=
 =?us-ascii?Q?6Md4bqupNIywwa+Q9JhdesgmJnpCC9lmdUumDqNEdYG1URKZoalblHhTtYmY?=
 =?us-ascii?Q?ItsodmJRz+VhNtnNocqq72h8Kn++7RiB9a7MPfCQBy/AySj7hbthpcllxd79?=
 =?us-ascii?Q?PGV6eZw5u+4tBCHISJBPxwxztfEgPm665kF92OPOxRMYKAaQSOj1FeZoL57l?=
 =?us-ascii?Q?wCc4yjXuGjLO9Jd0c9Isxapzr2yeKHyIn8ZyGOOUhMmlCgRS7Pf9SsNHsA4+?=
 =?us-ascii?Q?X5CrEs+JdDu2005FLCPooRKm0C2X7RjmQfTV9IzhBFcIJpaUKgMNyWx68f0N?=
 =?us-ascii?Q?2aZwbsvY7xEqObCXCa+E1RwdAEHqmmak1s3gnRQXwkiAkddD9IgPoKiY9/5d?=
 =?us-ascii?Q?zZHJKDq013JZQkJ2z8Hj7TSY2LF8IO9gFS6VfYeQQ/9cjhTEHZzv1+yOhkHk?=
 =?us-ascii?Q?+SL1DYv0d9wIRDDxo5nDAH7Kw1Z9Y5/g6lnwP1n9JhHZZ7+0CBt4fSDR5j6V?=
 =?us-ascii?Q?kF26JzYrbBlWeiJJS8CVSOKgC/SAxfTFnU+wVd1OjP9zOhEh8XUTMQf2iXPx?=
 =?us-ascii?Q?der04Fyvm6CgzCdhpo9PCiPlz0wuRzxYA1sQQPjfT8wdKFU06KyjrhzAayom?=
 =?us-ascii?Q?UpAxQHptoTC6RVldWdlhiljf6VH8qeI0N8/AnrG6ruHIjFl70ON7DQ/hFJW7?=
 =?us-ascii?Q?uSVXhmzvykIbMbLhd4VRi8ibJQpo3pM2pt6KWAezoitxzH0mUozFsOeG/26x?=
 =?us-ascii?Q?FuRhW2C4eS4wteuOgvjyrlSuGJLexiIJ90bHGM1JJQCGNKIEiiHZzyGeKqCn?=
 =?us-ascii?Q?hVUrEv9Gf+qsMdnVe6qzPvHB7QKJaqqzeV+Hd/Tq0zlDpRlu0bHtYFWIZg4x?=
 =?us-ascii?Q?T7kJrHc6hy5kxCkfkFYbO7x+8ypYpf6Dk8iBp7P5TOGVyPJj9jnme8fumMkw?=
 =?us-ascii?Q?LOPiDs7mxgPkFMV8VBLV0oWKgY7EoaczQwo7wiW6hyUvq89CQ9fIdIY34nF0?=
 =?us-ascii?Q?GXYulUeCMrUOgnQU3t5VEQPEEkyEXtMKGFcxu6V1Q6a8d6LtSWPfHvEhC8MV?=
 =?us-ascii?Q?NoSRIfRgu5AUdFxPs3G1E5KZkNQasowmdjWHD/R+on/RwDx967m6eJLhhDxz?=
 =?us-ascii?Q?MGw6tbX7tOaQ+oJ3AVcrR40dSONbDHwcooGF02MVgcKvK/Qvq3hRIstiV5+o?=
 =?us-ascii?Q?dySuagAX/xbki+rBJpVImc80zTuUyewBR08gtSo4kVKUBCgMHldcobmUZR53?=
 =?us-ascii?Q?K0FJpTw1duRa/8U0EEavRUvKgasej/WvdcGLH2AmgohfRS2qOlYnXfLfZQoS?=
 =?us-ascii?Q?FD0h+9I6Elz6W4DKfXz8VfM6IcS1DAuVSG1xU3IyDBkMIhXmBBwhcKrxOniX?=
 =?us-ascii?Q?bgGP7LP/QC0NgrhIxaKy0ztsDIkBVAo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bff46fc-f80a-4b65-7f5c-08da50882ff4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 17:38:27.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc7nutwAl36JebdA/SGbHltEEdD9kMaFQFbE40WnGPWtmNSeJT7GtszOfotYca9KoNTj3v/64rqUESjiYbAjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_10:2022-06-17,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170077
X-Proofpoint-GUID: 1CcGU0SR5pRxroX9A7TfKxRhqFJbWGxg
X-Proofpoint-ORIG-GUID: 1CcGU0SR5pRxroX9A7TfKxRhqFJbWGxg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/22 15:41, Muchun Song wrote:
> On Thu, Jun 16, 2022 at 11:03:34AM -0700, Mike Kravetz wrote:
> > On 06/16/22 11:38, Muchun Song wrote:
> > > The following commit:
> > > 
> > >   commit 641844f5616d ("mm/hugetlb: introduce minimum hugepage order")
> > > 
> > > fixed a static checker warning and introduced a global variable minimum_order
> > > to fix the warning.  However, the local variable in dissolve_free_huge_pages()
> > > can be initialized to huge_page_order(&default_hstate) to fix the warning.
> > > So remove minimum_order to simplify the code.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 18 +++++++-----------
> > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 8ea4e51d8186..405d1c7441c9 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -66,12 +66,6 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
> > >  #endif
> > >  static unsigned long hugetlb_cma_size __initdata;
> > >  
> > > -/*
> > > - * Minimum page order among possible hugepage sizes, set to a proper value
> > > - * at boot time.
> > > - */
> > > -static unsigned int minimum_order __read_mostly = UINT_MAX;
> > > -
> > >  __initdata LIST_HEAD(huge_boot_pages);
> > >  
> > >  /* for command line parsing */
> > > @@ -2161,11 +2155,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
> > >  	unsigned long pfn;
> > >  	struct page *page;
> > >  	int rc = 0;
> > > +	unsigned int order;
> > > +	struct hstate *h;
> > >  
> > >  	if (!hugepages_supported())
> > >  		return rc;
> > >  
> > > -	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> > > +	order = huge_page_order(&default_hstate);
> > > +	for_each_hstate(h)
> > > +		order = min(order, huge_page_order(h));
> > 
> > Since we will be traversing the array of hstates, I wonder if we should
> > optimize this further?  We could:
> > - Pass the node into dissolve_free_huge_pages
> > - When traversing the hstate array, check free_huge_pages_node[node] in
> >   each hstate.
> > - If no free huge pages, no need to do the pfn scan.
> > 
> > Yes, the above is racy.  However, the code is already racy as hugetlb
> > page state can change while performing this scan.  We only hold the hugetlb
> > lock when checking an individual hugetlb page.  The change above may
> > make the code a bit more racy.
> >
> 
> Agree.
>  
> > If we think that is too racy, they we could at least check
> > nr_huge_pages_node[node].  If there are no hugetlb pages on the node
> > there is no need to scan.  And, I think we have isolated this pfn range
> > so no new hugetlb pages can be created.
> > 
> > Not sure if the above optimizations are worth the effort.  IIUC, the
> > pfn range is at most a memory block size which is not huge.
> >
> 
> Right. It is not huge.
> 
> I have no strong opinion. dissolve_free_huge_pages() is only called in
> memory offline path and it is not a hot path. If we think the optimization
> is necessary, I think it should be a separate patch.
> 

Don't really think there is a need for such an optimization.  It was
mostly just a thought I had while looking at your changes.

Not suggesting we do this, but if we wanted to optimize I would think
about adding a global variable (or something) that indicates whether or
not hugetlb pages have been created.  If no hugetlb pages exist, there
there is no need to execute ANY of this code.

As mentioned above, the size of a memory block is not huge.  However, I
can 'imagine' some cloud environments where dynamic memory resizing may
be common and there could be operations that want to offline TB's of
memory.

Again, just more to think about.

For this patch,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
