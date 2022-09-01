Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EF5AA15A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiIAVGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIAVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:06:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E8C5A174
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:06:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281KRSYi029044;
        Thu, 1 Sep 2022 21:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GdOc9wgSrwRAibuW3Nv7ZjfmdTNLDadhpBWc8mKN6gg=;
 b=z97Z/L7sKSw5+UUiVI7qn9VQ2OYWiXphYHroDp0uNsJU687IxecpMjzEDQ/InHDxwfYd
 EVOC60ob2GHUfSjeCOChwTNtbw5PmzIoITXXgiF9SVR2xdOxu5tWiYB8GPh0hziEk044
 GLv+Vk8DFuFBXmx9evk8AkTrqUxikzOM+0MGlbS2Em/FHi+saqwahNhvXIJM0tPHNbDB
 QZaE0FAl55jMw0V4etVfSdXUIG3b3VUgyP9RvABNy5EXasyG8h/8XLSb5SgWVOfLNVvp
 1AeK8qAPTtu/B2zK89XE4oPAYti4/5ctkABjRCOEqJARh5p02HyCp/W7UzjH6ClQHXPb Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0wghs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 21:06:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281IuhwI002331;
        Thu, 1 Sep 2022 21:06:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6yfug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 21:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KerWrzqlC57CrRUGNrQ207ekYbe/BOBqxkh9SYgMptDaCcIsF/jvGdTwpj7pP+HdFzL2VgNjsvYMoUd/lEb7eZJBln4+i8/v019U4B21Zs/T7j/4eo17rByOdNt8gYRRxnVqN5hnyhSyStMj/SlSp1tk0U/OnlB/U+9opvismmpdta4op7IKY2yTXen5ulK7Jba3uKfc2J4FDxYHp0izQPtbs2qiFFONZCIk643+n357P5i0pcKVuuEZ5SCfGu+m3DiGiB687JDF4EZQSX6sr2ixufH32I5mK9o2AYCL+vDb0g1zJ8RPjSyYkm87dPbyh+2kZEmJk8tT6DF9ma7qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdOc9wgSrwRAibuW3Nv7ZjfmdTNLDadhpBWc8mKN6gg=;
 b=QjOlNbSbzOiaWDdIisYibplEPH46qPNzJAM/EmS+hWcYmDioEA/kgiI3Ac7olD5b9ZTo61MbFwlZ0HCzdW3AnC+tiy+n9MkPUAEK4yHHRskrVrwlA07xes7TMaF/4mKFPDAzO6Dj579YjC27oYo4XcP+AMTBrkcnOEpJoa5M5JfcI1LmcmJc3juJvvvHOC33YHHD6IyZag+NTVQcjqxrcpUd9POEp9i3gtTUI9gyGWm+dHQw5XNompK8xNh5SDHRtivMdBiAQXMKt5IMR46/JUzSdu5DLA3RxlM/R+1M8K4VHJoQPIygC0wT4qwbP9P+jjjOt0gXZTupWpyjrDqCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdOc9wgSrwRAibuW3Nv7ZjfmdTNLDadhpBWc8mKN6gg=;
 b=x0c3ZzWGsqRq9Wmty1oCyG5k1JJQoCdyXUxgldj48eTQ5MEvwdVSuRkrkpJA3XgjJkCzOcbeHX+rM47TPiUvCloLhyrNQAAntmcaeHVglnosNq6XsredU2eg+EIcABPWuyD2AHXtc36yHK6ejq5nOhTqxryvWbvalinofp/uISY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5357.namprd10.prod.outlook.com (2603:10b6:5:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 21:06:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 21:06:09 +0000
Date:   Thu, 1 Sep 2022 14:06:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: fix races when looking up a CONT-PTE/PMD
 size hugetlb page
Message-ID: <YxEevpqBy2rIjcrO@monkey>
References: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66857384-b7c1-436d-652f-08da8c5dcafc
X-MS-TrafficTypeDiagnostic: DS7PR10MB5357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wCcpjKFsLPSAr07fHS1CHT3iZxyE1F8Y9T0HWXHjOCp9lQfkI+rqPiIeX6LcamaYjEUq6K0AipGLe5oV5kCSLcViFJH2x3oxY3JsG1Emx7foAnnFqdtty3yhbHh4RGNwGdGjPQz4PAu8/hdHGg8nze0937z0nF3I04lrDLjcb1L5/uqvP5Rlirgehs9qtCvvnFKAASDwWiOJAA45F0s7j0WqcfhE+7tr+CVFLZ7h/VWKv2XPLq+EYVKB/bQ8RrAJ3oA2knQsAGOzWOuZrjNfpeKny+yw0/UGuaSYK8MHRkCoTM7AvMCGqUPTmL575nQrfvitp9Qvdyc3nApWHFgDGmzeUZf+WyfHXzeK42vu8FU9/vUEtO5D34yYoPmOoazjasnSe3MFaTesXUFu68QTzcD+ttzamB5Zd5C74TGIMmP7psqsy1tLnfCqxb2bnAAp8TLZLmqQgwUbmOzVy8JKpmfrgzVj6TrzE828+0bLAbBKo4JgHBtWyByCDLruLUeY62P4BD+H1davuDjAAtfe41M/n4c+CgpTzqU5JvmA+HjsfpZUAPabPSniin5K21RS8S81UmTsNTPgrypgYHL0AoGx2Et6CxqCZG3b2XteXu4qsU9RnB7fjeWUx7RfJbzmbXCE62ieeQz5E9TCFBOiv5SpzyS1o3ZtyX6iO0+/letr1G8FHELfSSIFkE2wSLBS2zr3lf6XaEm8z8ZAojvlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(86362001)(83380400001)(6506007)(186003)(53546011)(6666004)(41300700001)(26005)(9686003)(6512007)(66476007)(33716001)(316002)(4326008)(8676002)(66556008)(478600001)(66946007)(6486002)(5660300002)(2906002)(44832011)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTHVOYc3oeQEuvtJ/mZsZme8HdyuKQNUojUKVeP5mWgjsTAjwk4JnI3TqWVn?=
 =?us-ascii?Q?RbtAM5vTHI9i8vq4ifIjfacHUMT/dgIaLj9g600PYwg8Kq6hYJVxHETjlKDW?=
 =?us-ascii?Q?bRcSjUGQ9T+XW+3qJUOlesi+N73BpdB/RkRFfOHU1OkAfdyuRYWg2R/Y6Z4K?=
 =?us-ascii?Q?SO4eyufW4Bu2FcUI3VaKKSmMDoRGyguaqDDQn0CGqdwoqPA6TTjo6DLM4Whu?=
 =?us-ascii?Q?VKU0VciHldqqwVrhylhihVkuv+cLuhjE2HGDs2T2EZX4Jg7iyPHhL4rjIyCe?=
 =?us-ascii?Q?jQuw+GlYqW/sXxCznHO2g4YrtOk7Mj8J+s2uwv6RP+PtWuBLfDoLqVC0YEZH?=
 =?us-ascii?Q?di+hI6jhy8dYyumiZ38rZpLurfG/ieK791WT4i2NQRa/nO4Y7H/Z84w7S+3P?=
 =?us-ascii?Q?yfLyEKg99ZiW3sIDKr/AtCkWUjkw/MZk7cFS9X2g6xxafgwGBAe2awd7P7vw?=
 =?us-ascii?Q?H+wJfhWSPAO2mfgyfPDpfU3LZz+vFmqGUv78boaGfa0tiU9Cu1M2uC44jQVt?=
 =?us-ascii?Q?CsAEvB5U/xO8hasKfwu/iCyuwvkIJVb33Wd96wsSc/i8NkeIXvDkv7BYR0i0?=
 =?us-ascii?Q?eYc1CwvrPMo1v+glG35emgFLpYCrO/Kt0hqm81ywqraSQY24ncCNyjx3JpA7?=
 =?us-ascii?Q?fNUEwesOLG8FCWttEerOrm4GMYHHXIJE4IUzcchpjPbtGmMp7Oc5cNUQKsse?=
 =?us-ascii?Q?PgeDYPZ8oMclJiy54r9DdxKQyvq8+KDIuc7VenBrke2FVZ6NbRYZAIbzr/YZ?=
 =?us-ascii?Q?HMg3S+7zMn/f2Mbzjy+rBzMhdHlIVACt0hitfA5NgVN9TSBdTLHwl9xiE+bM?=
 =?us-ascii?Q?94QO0JdhbtG9D0FDa4HcJEHCTZSCFStlRiRlDXJq0N+yLXVlrIx22KZmxQaX?=
 =?us-ascii?Q?eTcI4UoKJoDpeXJJ6YIqSlh2YrZQKuwGKIsFvqhixIwNOoBecFVNnXO/xxqq?=
 =?us-ascii?Q?GLjM/1Wiw0OLoOXVqAU/+J0DaAHHCpmxS3Y7cRnHObJ3GyMnhHlPmN7OlPft?=
 =?us-ascii?Q?LFqsb7ZCU1uq8yQ9p4o7cW9YNzdBmuyb5IRs5Qytyq8WfX7xNetkw+vAM5+8?=
 =?us-ascii?Q?pHjw8A2QlBZ+zTTzRPn+dlJa8xWsOFMD76EkECaKoPfNPNZxqEsPdJ7FnL5F?=
 =?us-ascii?Q?HNSVVDdTXd4Ut0EQmUpSQZk1G7P6UN4g/uS29WO7MytnolppHk7LbmtKbhdL?=
 =?us-ascii?Q?5LKKPmQ4Lwzb8kALDZq2OcEs7XsmG6s6RTm75HoNJX2jg7ou05dATsF1dz+3?=
 =?us-ascii?Q?zqKOIzoG1ZLR0RWKURMKnTBtv7usET2pxhBEUbOy93YeNTTQ2+GVc6ukaxV+?=
 =?us-ascii?Q?3wlrUdQ6PViObq4gZXtsmQbhy3eVpI9XYLpRk3cAXIQ+HQQ3S+cDq+LLdOsO?=
 =?us-ascii?Q?YBtl4YRqMr0FK0nUrjTCJL3y34jeYvcuM9mZileoL2MFthvJc2ApFAbR4VqN?=
 =?us-ascii?Q?D11QHA+5+KVLUfkuaCjTZrpd4V6uUbe91OecxhHAfxbMqgBfEBKqFIhxeHJq?=
 =?us-ascii?Q?YNGatRwBP8cHBzEDrYu1dDwg2nyWlTewmlaIy4pEDzRW6whYXxrccB2cSCdR?=
 =?us-ascii?Q?eHO90FSYYymqwuwi1GrfYBYysT7B2ma/1Q3+ZLP4jrs+h8mpdg6QRqHNpzNF?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66857384-b7c1-436d-652f-08da8c5dcafc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 21:06:09.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTzQGAI7ynWsloorW8YuDNPndjRcKInF/4C/AtB0Qs5HxcUiy8PhpWLG00mThGmH53RUKr2av0JVHKhf0ZN0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=757
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010091
X-Proofpoint-GUID: hU2cWngNvO24vqR_nHkl_muO183IRH1S
X-Proofpoint-ORIG-GUID: hU2cWngNvO24vqR_nHkl_muO183IRH1S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/22 18:41, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb
> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
> specified.
> 
> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
> get the correct lock, which is mm->page_table_lock.
> 
> That means the pte entry of the CONT-PTE size hugetlb under current
> pte lock is unstable in follow_page_pte(), we can continue to migrate
> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
> some potential race issues, even though they are under the 'pte lock'.
> 
> For example, suppose thread A is trying to look up a CONT-PTE size
> hugetlb page by move_pages() syscall under the lock, however antoher
> thread B can migrate the CONT-PTE hugetlb page at the same time, which
> will cause thread A to get an incorrect page, if thread A also wants to
> do page migration, then data inconsistency error occurs.
>
> Moreover we have the same issue for CONT-PMD size hugetlb in
> follow_huge_pmd().
> 
> To fix above issues, rename the follow_huge_pmd() as follow_huge_pmd_pte()
> to handle PMD and PTE level size hugetlb, which uses huge_pte_lock() to
> get the correct pte entry lock to make the pte entry stable.
> 
> Cc: <stable@vger.kernel.org>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v2:
>  - Combine PMD and PTE level hugetlb handling into one function.
>  - Drop unnecessary patches.
>  - Update the commit message.

Baolin, were you able to at least exercise the new code paths?  Especially the
path for CONT_PTE.  Code looks fine to me.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

It is a little hackish, but this is only for backports.  So, I think it is OK.
We may want to point out that code cleanup and simplification is going upstream
that will address these issues in a more elegant manner.

> 
> Mike, please fold this patch into your series. Thanks.

If I understand Andrew, this can go in as a separate patch for backport to
address potential bugs.  I will provide a cleanup/simplification that will
remove this going forward.

Andrew also asked for a Fixes tag.
Support for CONT_PMD/_PTE was added with bb9dd3df8ee9 "arm64: hugetlb: refactor
find_num_contig()".  Patch series "Support for contiguous pte hugepages", v4.
However, I do not believe these code paths were executed until migration
support was added with 5480280d3f2d "arm64/mm: enable HugeTLB migration for
contiguous bit HugeTLB pages"
I would go with 5480280d3f2d.
-- 
Mike Kravetz
