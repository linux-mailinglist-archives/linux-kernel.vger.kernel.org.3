Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC4560C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiF2WZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiF2WY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:24:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C540534BAD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:24:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4BgL014121;
        Wed, 29 Jun 2022 22:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gFNA9gFGOumi8JAsRjepkFyehIAT32wf+ysAVPoarvk=;
 b=Ak13ZtjUvOBeY1gKThai0rLub+khCD1U0xYjo4HsSXDWaZ2BwfbZSCxNvAgBAgfhmwjJ
 sziPgzOnxfSA3pi6xUn8wX9kvYmMhsjvS3dfxwAkJAyhcSrqlEw8gacE2R6NDRyzEjv8
 BH18ZVxSE2wwsdAJ+3QPUuZFFHV1wQ69wBjCQdAvE/AItcvvlNAG1O3iT4/a+hABS6e5
 GVpaphVFscuH/JeMNpNVlgMN8/bXwQ1J1ij96+jUMhl3AmRJnWhl9Ny4CkquJuZ4p9mV
 6aiOjsFoT5H4VKJJmQQmRC4pcqWIxT93JsdQtojyH/Qb1ihgsEt2iLmmJIznRbQ8PEjH Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysjfne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:24:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMKx2O035315;
        Wed, 29 Jun 2022 22:24:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3wk8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1DqSJ46d2K20ubhzarhXpDRX2zNCFVn+RiVqyiO9dMgs5wGAdChZIbRIqRaOLRGAvg0K7t7CE57SgqbZMrTuz+LTCgRBkDHLCF2cRypA5AFpOYgRcSz4WnRRJPtXDenJRStTMvGx4eexoYzigMS5dtPD5H+Wug9BSNS9mOEpv51F1L4HovDOwLtHjDtexEuxkTcz4MmudaynYBT/WwrshDX3T0TymZ6r7Zx2D+Cb18XHRXvAzassQP6K6O3qmZ6aO2kT23XZoBJbBhF1E2JwPbYTbnMkHsK1rt994uPwvSEMDfkUaYI7QMZF3xXUmsN9MjIXHjWokXGoNq+533DNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFNA9gFGOumi8JAsRjepkFyehIAT32wf+ysAVPoarvk=;
 b=eWufZmsZ6CXdhgfDmZxN+6ngXHieghcCoESVXyTf7EVt90KD3G0HhuPTcNW9N/MySQl0tOn+NKELZAYMhyZLhyEpGVRwxcNP4PW6aglTOaoXNehQz05AaHbTMWv3eeE4prNTu9uB4IMsbu+Eo1CNYyoHDUn79KxKXUd3Lzp+FxWpp+cl+O05dPe9gJ7xYXz8vAjNupJizMbODAmXRBk/aMn2ZOPrRmzaUOsJHiCwIByDrRRPQa3WvcAMh/1VdczOXjjpeimtutf+xTy1eYI7VAM7uSq7bR3Q2r/0Q1YDZ0f9J0okLM2Nx9/+JAOZJK1fisMXMKaEJoROurydMwGCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFNA9gFGOumi8JAsRjepkFyehIAT32wf+ysAVPoarvk=;
 b=xWNhxyefTVSGgmkx61VGSKlNAcvAM2HfgjVNbeAHawD+cZnFGdqddABctuZP1U6/nrJsHryU9DHs92n2TvWeuICR7EsnNKYq2ZivWhAgEddn2jA+w2RgR5qAfnp1W1IECtv96PQfwNTKdeo8y+ASsHDqNdVJ/AL2xGIZTOpVgyM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1512.namprd10.prod.outlook.com (2603:10b6:903:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 22:24:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 22:24:48 +0000
Date:   Wed, 29 Jun 2022 15:24:45 -0700
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
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an
 explicit shift argument.
Message-ID: <YrzRLVQaYtYAYsEa@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com>
 <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net>
 <Yry+PPHSat2uN+aG@monkey>
 <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
X-ClientProxiedBy: MWHPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:300:ee::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c92c0b-6432-4cbb-5e6c-08da5a1e2d88
X-MS-TrafficTypeDiagnostic: CY4PR10MB1512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KwDeQf5gePr3EMDf29q6qHotmecZEc3ZxrXbhgpt7y5IMuS51IasLzovnbS/8p13TNrGrtwKiNALF5SuUya70A9erPQPX4Tznv7pkvt4N8xt+kpyzfkzfcV1MRBgBytGyQ0KPkjl/qExvpHL9SrIXgPj6PG3iyiqag9rdccEU6Dvf2trcc2U2bzOaNDM7P3904zEWfvMBSiGBcD3eg3ofuLMF2uyNW0blylFv+97uXeIvMSZ3dbijETgWya7+CYTFqkLfSyMkerYuYASmKH3UYOlwt2G6cw3mdrJUGOtr+G+zrlO2rC9mvv514+AYS41MAFaK2PA2S6AH+pG8BgeUVNlGJwQbe0Qya3tri37svWMH+v2YzoPlPRK3DS0L2NfJt/rYbJXvVR7bpR3cSpgJg+WDp7hmCJ1S+5zu3zjmAvb7sN5Kb1N30kIFbfTaZPwwbgbJWUHMcLmVJiv2lJjkb9AunllXiDiDgXEUZi7yb3+/sE44H2Z1bMD85TWu3FqhmBVbFWPHquYNd2F/MUFDeL9OawVkAA2umis8/1cupUNh01Eflclk4JmAh45N7RS1sKlCx/VB2a6AQNtmNmlOexdYdvqbJcj8pTZ3m4ZNP2E8DCTdLohWHwKui2P83PBfzNX3KA+9RXMCTwB0m1K1zHEjkF537I0cv+SxjDat7mJsXuQ6qINsXxANpkp8+FfgUZ1m6gSe0xpC+rMqgdgI/SP+ZY0BVubqLdc45JBw9MCINHE6+97Nv4cXcMNREgnmi01fYHNMyV3OChsIm14dug6Bi87a5cAArI/z7SALY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(366004)(136003)(376002)(8676002)(66476007)(9686003)(26005)(8936002)(66556008)(83380400001)(66946007)(53546011)(5660300002)(186003)(38100700002)(316002)(86362001)(44832011)(6512007)(6916009)(4326008)(6486002)(54906003)(33716001)(6506007)(2906002)(6666004)(7416002)(478600001)(41300700001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVMHe7SJxwG5P/zPjrO6zriHX4TOydxs+YivR0J9nR428BzRBQvp4a5Xj17m?=
 =?us-ascii?Q?xE2n7wxF0j2gNrARaBvropMEz4sNNwaLpmptDIHIOgCkOTMswh2P7VrXu+bh?=
 =?us-ascii?Q?IxVjNlF6cLHA+7thnXFxT9InHXq4G15FYpmb82lKHdoNvVrHOfjm0RrL1SNK?=
 =?us-ascii?Q?2q4ZiLVZPXCayIrLEWu5kJnIWKepsEAaDGBtwS+vKzy0yqjQCTgIl9GN80Ls?=
 =?us-ascii?Q?Z3oFYyAMNUhQrV7MpR7hHQLpDhsVZyAYJpN7U+76AJcpCyGcwQREfsYPFdSy?=
 =?us-ascii?Q?/ASSgyQGQ4EGrouyDegsy1SSVmarjlzPEMw/Sp68KdAMaz6h2WM9lJzNa1Rj?=
 =?us-ascii?Q?zzt32UnnGNMlApNqjsrZMR64wSxiB0A3MNCud38Sorl4yTixLstuaLqyOdZ/?=
 =?us-ascii?Q?YRfwA2A8zTMBGl3WPR799y+WwoYORkNX0/k2DpmKWZmUkZD/Yzop3jfLlNBB?=
 =?us-ascii?Q?s7PLsqRHrluE6QTCTM7b2Dl37izRY9GF7yGBvW3VfsUalCjMQMzUkzNYD3lv?=
 =?us-ascii?Q?wGd4NsDX26YvmW0ysZoHPA6RVIYg68uEBPyRMeiF2a/dZsFKy5P9xYjwPxor?=
 =?us-ascii?Q?eZi7hEyh/z9Opo3xogCBbjP0vjgQaE7cgLF53wICY5wVj+b+X/ZUKQb3of1F?=
 =?us-ascii?Q?jrBEjVQTZvFlz3J2HupMZU78QkSIyUTt6bfWdqOF9S6aWF9Glq+UJT2WjVX3?=
 =?us-ascii?Q?3KfteP8LnmYhzYgdtD0PyVoPvHyxlN+62JuKWwPzxLihUwrrYElirMhU03ci?=
 =?us-ascii?Q?RPzE4aTtAGO7688aE+izkA0OE4nFkrMIapA/J6rtprHGJRUDlhH2OV107lvq?=
 =?us-ascii?Q?mijVgg8/Kx0+YWqJja1n+ChNz0ah2DWv3QqxcDyIE/9lG9mOBzIGF3gUx1pJ?=
 =?us-ascii?Q?RNpQVMZ5Tn+Jmi1z7iwlEJNub2hRbdyHFf1q9gnUa1GTHMqPOpjBioEeOLqG?=
 =?us-ascii?Q?GcwLROSylBgQRyJ8UTt1/1jcNr3Php/QO/TyWneezCN77t7PsFGEkHU1njV0?=
 =?us-ascii?Q?WqaLnTpVTSH1G2vWIIPbHUfIwThCtaNbO8cqfd+kUrg3g039SHVCLCmHcVOg?=
 =?us-ascii?Q?86WK9QH+Ld5ZVbOkRyJzm9K1JkUUAGnCxOCoqixLz8twBI1+ktSz/vLq8J7l?=
 =?us-ascii?Q?8vJzNwBZxq4eN8sKx91nxfzzGyrV9BleAQ//TGT4bQXUHwA8alTtaxiQWFiR?=
 =?us-ascii?Q?BUMycAH5eL25d61GiKBi11xA68FP8zgK3k4NFFrQ39fzm+P4bhv/+kGLHLq3?=
 =?us-ascii?Q?MdLyiJkNcxPp+36dlgEAyxKNS7xfHW6g6/55XOO7KAztOetF2vnm4jOgiqLv?=
 =?us-ascii?Q?T9My9jIdTgTINc/u4HLmCxLB5HNujzwFJ+jmmF3niKXNGxVaH78Q/oQe5nH1?=
 =?us-ascii?Q?bQ/1FP6T5Z1TnnWdRhp4zxzUjl0YBXD3j59V8pKgBRq2jP2nyxqssudXUvqM?=
 =?us-ascii?Q?tY1+CJHqEFV6UPegPKIk6SAnCmpmsCDQTpZAolTaC3RWAhEvAwR9ZZL6vTts?=
 =?us-ascii?Q?TjZC4kSEePqCKKt16lDpHHf61jE7Vne9CRVr6VZ2WoWfZ32xSotviosCG8O9?=
 =?us-ascii?Q?C/0aNZeHEnEYNHV+3CDjkutR0bbBVOFFLXfixC8OnzDTQMSfgGOnWr4ZZfL/?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c92c0b-6432-4cbb-5e6c-08da5a1e2d88
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:24:48.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpUQOUco5g9tiRhYjjySB9udNm6X0QVvokVUO3HjZI7z9+Zy5Rc4mZhf8TRl1vYHLKqyWK5Hr94roG+EwCZhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290077
X-Proofpoint-ORIG-GUID: wy1s9D_-llMxL-Fm-wY7vwKn7ZMCIPtA
X-Proofpoint-GUID: wy1s9D_-llMxL-Fm-wY7vwKn7ZMCIPtA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/22 14:39, James Houghton wrote:
> On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 06/29/22 14:09, Muchun Song wrote:
> > > On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > > > On 06/24/22 17:36, James Houghton wrote:
> > > > > This is needed to handle PTL locking with high-granularity mapping. We
> > > > > won't always be using the PMD-level PTL even if we're using the 2M
> > > > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > > > case, we need to lock the PTL for the 4K PTE.
> > > >
> > > > I'm not really sure why this would be required.
> > > > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > > > with less contention than using the more coarse mm lock.
> > > >
> > >
> > > Your words make me thing of another question unrelated to this patch.
> > > We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> > > did not consider this case, in this case, those HugeTLB pages are contended
> > > with mm lock. Seems we should optimize this case. Something like:
> > >
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index 0d790fa3f297..68a1e071bfc0 100644
> > > --- a/include/linux/hugetlb.h
> > > +++ b/include/linux/hugetlb.h
> > > @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> > >  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> > >                                            struct mm_struct *mm, pte_t *pte)
> > >  {
> > > -       if (huge_page_size(h) == PMD_SIZE)
> > > +       if (huge_page_size(h) <= PMD_SIZE)
> > >                 return pmd_lockptr(mm, (pmd_t *) pte);
> > >         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> > >         return &mm->page_table_lock;
> > >
> > > I did not check if elsewhere needs to be changed as well. Just a primary
> > > thought.
> 
> I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
> then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that breaks
> things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, we
> need to separately keep track of the location of the PMD so that we
> can use it to get the PMD lock.

I assume Muchun was talking about changing this in current code (before
your changes) where huge_page_size(h) can not be PAGE_SIZE.

-- 
Mike Kravetz
