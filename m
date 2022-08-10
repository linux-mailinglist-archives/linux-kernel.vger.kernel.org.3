Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44B58F473
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiHJWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHJWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:39:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D81C925
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:39:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AKiD1L008197;
        Wed, 10 Aug 2022 22:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JKh+X/RSgroiiJU3VyEy2HAnBFp3pyziy6y3RfS7qJA=;
 b=ZECDTeJdJCSjsAZnNBOsQjFxzabV7AqnRKBslEDMbikatKJ0XrCPEgfMJS7DcW9CWGIV
 cXBL/Nx8TZv8542XyN0ih8P9xM/CbyIZzYzjTgVk2Dg6NGOL/7CdLB3NTkQHE6RnVuTV
 nbI0qymUsPe3Npr84D0IxT6n+PK6INA12M4pdK6x3xlgVWLe6BolUsNUh512wgIdJ5d/
 lW7Un6muAapBXdiVc23FOck7W3M3zfsMJ03LsnAl3YuNneA1D3Ean7AM7UjPlmck9ukc
 u894MRYRR6BR8peElltKCA5SmqrXqEszpy7m5QXcOGy3B/UHgU4AqoQSqdVo8F6NchOb 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9k8mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 22:39:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27AJaHMB036849;
        Wed, 10 Aug 2022 22:39:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj3f9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 22:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGFt/6Xcn4dIRdN5I4HxsYZZvTaLB4lCZ7hmqsQT09WPXv0ZZN9XGLvHj2cg4u7jlPmV85YBSEwfKlv2NhG8tr+strFXMnC1MVodyIUoREPtHVsjTNHAXLY751ecccdZbj11Q2S5BejiTakGmZzsqvj0M79p9+6MP8ZD4ETFjPF3ktLHu+5vupTS6aE3w73NTZoUrEuRoSy6Fg88/IS22SrqubD1vzB1E5Z46nOPjkvApntg9AePef0JhAdlsPF8VJMOjRUNB3pzf4glMhXLJGdozjsPo4YJX6w8/z5orljzKKnk4oWRn8iB8tLw/0BhCXzKyXwpEHf9jR6v9apWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKh+X/RSgroiiJU3VyEy2HAnBFp3pyziy6y3RfS7qJA=;
 b=hqnYg6wAG5jUS+AOkIEg9X0n0baiF7uZW99tKlBJWJZL+TOTZjw3xeEAZZcyoe+6b9N/jS/kd0wZbjSbL+lZCpwwZVap5/Is5CjUZVDQ0WpJwVfw/o7vXoEqeakl/RlDBeb/GvwJJxYXGe4mrMUsX2aYxlEEbvVo+j3B88qAGo3EKRtKumxFjnUgzOOi6o2S7NAgoW5RdeaD4x5xQ9FEYQl4sdXn88/AejVlyMSFdOXDotlzktWNS00Ig52MLsE8qGG/vQ0Bbu1mlNQ2COdvmKZB9LeXYKH+OXFqmKyjAXdwp2DGBzLuwf4DVIu5csB24jpQ5Vo32kaxjVzBc0L73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKh+X/RSgroiiJU3VyEy2HAnBFp3pyziy6y3RfS7qJA=;
 b=HjP6mswKxGVf2DV6c8g3vzNpI2EXhgSLSctwW8oLSKwVVM/7vH+NOGTp9/FfeZCINIi5ZAm88RifHvvCWFkYYKUk9+qbAOMixjmh69qNaL3DbL11hL06y7iSAxUlS3Nqx0EcueDgxqOWDzpQROu+ZdHrmMK+5IAfb01fYM776eo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2870.namprd10.prod.outlook.com (2603:10b6:a03:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 22:38:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 22:38:53 +0000
Date:   Wed, 10 Aug 2022 15:38:49 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: freeze allocated pages before creating hugetlb
 pages
Message-ID: <YvQzeUUvBVUYh8cn@monkey>
References: <20220808212836.111749-1-mike.kravetz@oracle.com>
 <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A74A816B-2EDD-411D-86F7-E7D5B507FAEE@linux.dev>
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b97db9a-c120-4dfa-81bb-08da7b2119ea
X-MS-TrafficTypeDiagnostic: BYAPR10MB2870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE7nqcAdjqbN6l2qfpRs6+3TNcBWs4jZjQJCcpCnYaAPjiw0LXlJt5Qfjr/wLXZH/kdMyt+rHFhgqBtdwhwDOyvmMg+kj6K7HdfYc2v0PxZ4uNS08aw+Jn6BzK5Eo7BF9ad9Xg4oagXFkE3HlCFUdVurf3zc3GC7qvarfSOlEbKgOCzuy85Q+dJBQ/WbdHQYgj4zaeyDGpnl78jKJyfyCTrYlQ95y2gz1qrFdh9fq/Wd8MLq1T3PA62CM3KAEbr+UpHMrTWdtWhk6vPRpgzvFEeyNeW9pzX0BqKCi2+ITl3wd3Z9ErKgDZC1d8AL6mSF483PwRpR55yIaC/pyQHWmL7I3icqqL/DnLilRi/tpffXOM6ffGJSbnHCROQl2MKd2PsbNV6244DTUddb21H+vsHhOZEuFSbCYXy2qolvFPP+d4fEiOCTavOXikk0MehkdAZNmrVFAsl4/2Gsvb4AeoTyl/j+CwRMBEZh3Z6N3Pon1FSs+pq06kAtpN/NQE7Buus+sxmCphxdcdM4jtOFw0h4TzKU03rBRasOzwHGGpCZKuC4sEXdoeEznIo7x7AXAhy96OH2w/N7JSo6bHLYsqYFvlKfkAKZ496XS45zPKMO7URRO4T5YCagqBiNqfayptZ3MX40L/VgkId8r5DccOq9P+MK6WBkEfYZTkNkdJt4CbKmk/gX+uOr6jQ88BO/nPq/6wDpgTQYVpsfBWL5U6GpXmAaFxjWpOgwRGWOAIaBWZYTt5I7jFVAqzZ9u1aM0ACd0zVO0Lo9zWXwSbWkCN5SPLcBZwL5XgY/PPOZtOaaNoKjGxrXkZrH36l3TdcJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(8936002)(66946007)(6512007)(44832011)(26005)(86362001)(9686003)(53546011)(6666004)(6506007)(2906002)(8676002)(66476007)(5660300002)(66556008)(38100700002)(4326008)(33716001)(316002)(966005)(478600001)(6916009)(54906003)(6486002)(41300700001)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kb7IcoBIT0F1ACQ5F+OMvLDHAWOJQoWclHOSqhcdJ5nT1J8m4rZmHSRYAoiw?=
 =?us-ascii?Q?h7/gyE3NebW/+6hp1uXlxA7rLtxq0q/ZRmbklG4F4sgBhti4TfcJCTK9CqQU?=
 =?us-ascii?Q?+YgzkhL6ZSLp53qJeM6IcKZ8coYwFTrjw6GSujsyAbm6/1HhMFi6lW17aFFm?=
 =?us-ascii?Q?fCT7SWJJKmEiatBRqAHIGe9VPuCmKP+HfxGYInO75S00D7noX0Ykum2CxkJA?=
 =?us-ascii?Q?1uE6gRXHAj0NUrvWTVsX5TwX7W0ytEaXHQyArCAhcnsAtVUv1McpeN4gRkj6?=
 =?us-ascii?Q?m/ucTzIL/gv5FnHx+ZciJdNrz67mOHMNqeRXBJpSPFve3rV1fwEYON8M0PyM?=
 =?us-ascii?Q?K8/p6sShnLwf3Q9LFBLF58++JZ3nFz8yEsi40DXpjyboNdanaMgFQiP/QAKf?=
 =?us-ascii?Q?bX6OW8AblCvXNRwEguZM5A74FwtL7S192cVTpEILJgimsZ8Ve0huM7XdSLBb?=
 =?us-ascii?Q?lnWOOD4sOpkN/M74FH5DdLQx0IX+be5hTiByu26ni69/NNhtdgoYiP9Vhrb6?=
 =?us-ascii?Q?rMUxXCBqvu0gE5p6rEZwcA4aqZ3UUsCvG5tyek24fLGi9o9eHxMj9EI91T8j?=
 =?us-ascii?Q?/rhoScOXB1jSQ4bZjYRTowvDViBmekrGh25VbYknunpxMHt9g7XFO9tgjORq?=
 =?us-ascii?Q?vT0Uwy+rWagRv5UIjLCFkEQcqQgrGldAIRWt2eAUnKU0XR+hMGLdB2zAaAjq?=
 =?us-ascii?Q?wvSlH8VDE78TIwCmTgFQ1HfGmr+8xYXR2MPHBbgIr77pNCxgy99I1gAeD3ii?=
 =?us-ascii?Q?bKvKkpVNKRJFMqyiLuvc27zu1VsNUWrOxyyWpFlHCknGrqCJ6mTsLzQ8/eWV?=
 =?us-ascii?Q?DJ8DAH8yxZTrkL4P2/5xB/fnoCMTBfN14+WqdkqmMVeiG6Ev033kj04qvk2Z?=
 =?us-ascii?Q?OHc/BEjFrKDbJpQWC4VzpjphkMqhtLWTSpXhhOlqYRx5wTRyyCFYTUuV15Sy?=
 =?us-ascii?Q?YA/a2de8+lybpV43G2fgTAEzCYt6FBr+N//4fPlKByfhWGaeA6RlumWyOrs+?=
 =?us-ascii?Q?sM1aLcL4dmMGu8Y843A0FqLlg1wtCkYYUbOseESNO3xUV+f/HoOXmgx1AJ7c?=
 =?us-ascii?Q?r4DpBnWan/b9x+12wrTHyb/TW/orbYkeTSM3lIbi3XaBUkhnYIAl1VkRtaIU?=
 =?us-ascii?Q?/2NSoni1MXnz765ZPLe4YTrjM2o6r7336dQF/gQ5UngEVN7KjvlfI/gjXF+C?=
 =?us-ascii?Q?oNXi121q6IkgBHHB2Fk29YdDhFSrXtS6KAP9Ct1buFXDwEVekSitzTlfqETR?=
 =?us-ascii?Q?8o+wyBmmNMndDSrjyWPPYs0GtNXtxNzM96unF534EjOkSdvomuSwStDjidI3?=
 =?us-ascii?Q?W8Vhs4hZwNrW9KVPFWx0nHESSd+TtLrEiSKxdX6PBf8nvCIZKeSwD2qluBhH?=
 =?us-ascii?Q?UfAFBawd42C78NRO8WAoKuWq6GFJfTZbwy3FzFt4zjwVEVqpe4Ew2cccwQ1k?=
 =?us-ascii?Q?DbegF+YL66fRLGnqmNiq3OImUoyipYzx/NY04nu2SNNfUlyxZglU30a+TbOX?=
 =?us-ascii?Q?TDW1x+9YTNhE7P2lJuLz79gPyRs7FQBrkDdCOK3Wy7zn2VoPHNyWaLOSuzOL?=
 =?us-ascii?Q?yKn9OvQWGL5JjWSW6f3cY6HvZ7efIaNo3H8At33q5PyurphzwngML1G1OZZ+?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b97db9a-c120-4dfa-81bb-08da7b2119ea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 22:38:53.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5wpHG6bLXyJWJ0xn52B7OtZqp5i1S1YyMC5koXyoONxG/SfmzHCaDDnX/XrMZWdzQ44xCxrYlm8MnC5TZeh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_14,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100068
X-Proofpoint-ORIG-GUID: D6AcOWigx3hVCYgJ1OwkIndLcaAsmhGd
X-Proofpoint-GUID: D6AcOWigx3hVCYgJ1OwkIndLcaAsmhGd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/22 14:20, Muchun Song wrote:
> > On Aug 9, 2022, at 05:28, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > When creating hugetlb pages, the hugetlb code must first allocate
> > contiguous pages from a low level allocator such as buddy, cma or
> > memblock.  The pages returned from these low level allocators are
> > ref counted.  This creates potential issues with other code taking
> > speculative references on these pages before they can be transformed to
> > a hugetlb page.  This issue has been addressed with methods and code
> > such as that provided in [1].
> > 
> > Recent discussions about vmemmap freeing [2] have indicated that it
> > would be beneficial to freeze all sub pages, including the head page
> > of pages returned from low level allocators before converting to a
> > hugetlb page.  This helps avoid races if want to replace the page
> > containing vmemmap for the head page.
> > 
> > There have been proposals to change at least the buddy allocator to
> > return frozen pages as described at [3].  If such a change is made, it
> > can be employed by the hugetlb code.  However, as mentioned above
> > hugetlb uses several low level allocators so each would need to be
> > modified to return frozen pages.  For now, we can manually freeze the
> > returned pages.  This is done in two places:
> > 1) alloc_buddy_huge_page, only the returned head page is ref counted.
> >   We freeze the head page, retrying once in the VERY rare case where
> >   there may be an inflated ref count.
> > 2) prep_compound_gigantic_page, for gigantic pages the current code
> >   freezes all pages except the head page.  New code will simply freeze
> >   the head page as well.
> > 
> > In a few other places, code checks for inflated ref counts on newly
> > allocated hugetlb pages.  With the modifications to freeze after
> > allocating, this code can be removed.
> > 
> > After hugetlb pages are freshly allocated, they are often added to the
> > hugetlb free lists.  Since these pages were previously ref counted, this
> > was done via put_page() which would end up calling the hugetlb
> > destructor: free_huge_page.  With changes to freeze pages, we simply
> > call free_huge_page directly to add the pages to the free list.
> > 
> > In a few other places, freshly allocated hugetlb pages were immediately
> > put into use, and the expectation was they were already ref counted.  In
> > these cases, we must manually ref count the page.
> > 
> > [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> > [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
> > [3] https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.org/
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> > mm/hugetlb.c | 97 +++++++++++++++++++---------------------------------
> > 1 file changed, 35 insertions(+), 62 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 28516881a1b2..6b90d85d545b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1769,13 +1769,12 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> > {
> > 	int i, j;
> > 	int nr_pages = 1 << order;
> > -	struct page *p = page + 1;
> > +	struct page *p = page;
> > 
> > 	/* we rely on prep_new_huge_page to set the destructor */
> > 	set_compound_order(page, order);
> > -	__ClearPageReserved(page);
> > 	__SetPageHead(page);
> > -	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> > +	for (i = 0; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> > 		/*
> > 		 * For gigantic hugepages allocated through bootmem at
> > 		 * boot, it's safer to be consistent with the not-gigantic
> > @@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> > 		} else {
> > 			VM_BUG_ON_PAGE(page_count(p), p);
> > 		}
> > -		set_compound_head(p, page);
> > +		if (i != 0)
> > +			set_compound_head(p, page);
> > 	}
> > 	atomic_set(compound_mapcount_ptr(page), -1);
> > 	atomic_set(compound_pincount_ptr(page), 0);
> > @@ -1918,6 +1918,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
> > 	int order = huge_page_order(h);
> > 	struct page *page;
> > 	bool alloc_try_hard = true;
> > +	bool retry = true;
> > 
> > 	/*
> > 	 * By default we always try hard to allocate the page with
> > @@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
> > 		gfp_mask |= __GFP_RETRY_MAYFAIL;
> > 	if (nid == NUMA_NO_NODE)
> > 		nid = numa_mem_id();
> > +retry:
> > 	page = __alloc_pages(gfp_mask, order, nid, nmask);
> > +
> > +	/* Freeze head page */
> > +	if (!page_ref_freeze(page, 1)) {
> 
> Hi Mike,
> 
> I saw Mattew has introduced a new helper alloc_frozen_pages() in thread [1] to allocate a
> frozen page. Then we do not need to handle an unexpected refcount case, which
> should be easy. Is there any consideration why we do not choose alloc_frozen_pages()?

I asked Matthew about these efforts before creating this patch.  At the
time, there were issues with the first version of his patch series and
he wasn't sure when he would get around to looking into those issues.

I then decided to proceed with manually freezing pages after allocation.
The thought was that alloc_frozen_pages() could be added when it became
available.  The 'downstream changes' to deal with pages that have zero
ref count should remain the same.  IMO, these downstream changes are the
more important parts of this patch.

Shortly after sending this patch, Matthew took another look at his
series and discovered the source of issues.  He then sent this v2
series.  Matthew will correct me if this is not accurate.

> 
> [1] https://lore.kernel.org/linux-mm/20220809171854.3725722-15-willy@infradead.org/T/#u
> 

I am happy to wait until Matthew's series moves forward, and then use
the new interface.

-- 
Mike Kravetz
