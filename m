Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0598156ADD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiGGVj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiGGVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:39:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2C20BCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:39:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCoPZ020654;
        Thu, 7 Jul 2022 21:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=g42YrPTvGElUTZ3D+5qrntbowTCsB3L+lalvousnV0A=;
 b=UMQQYh+41dJj8I4+cyhId7E7Ai64qsljvutY5hPr8PE5buexpry7BUvhfjWZjpKU1K36
 AqpV7jublstQsk4HoFMSlJdPlAOINCCb+vtEJ67WLBIyG2hhgr1fDxJ22wrYGbHMB5u0
 ExflqWstwnIVXA8T+B4Gn1dJFnG7bDSKxxHqkNYMzmBW+CWVtVCuCIBvLhwjQU+Xaj3+
 w3pniMvjWR6XtQKYE78irU0MDyv90vh4F6L72Y+RZNe9efK8ouJt9YKck/t92p1Qk1In
 kd59PZoOJTJN9px+9YAauVqBLt9e2qgnHo49qXgzKDkkKiOmkvazeUIRi2aODUIrW2Ag hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby6g6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:39:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LZMGP006422;
        Thu, 7 Jul 2022 21:39:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7bxvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k149Ngb1+xXLmuCNNiqPtIe8fAoPGuhEe9Un1tJfM3UPLyosSyVfVIRuRWtPUNCwZ/hjF5XsKyrHP1Ow4Jaw7m5nqI5VtH83t+LTwSqb7Q3aAQXYdaCRkAPXHbTp6J8xuasSCQv0uuBOH7BUIZJn1JKkEAJiqnpHMoUtUSRZmtzovJmm6tu/ymQYfxA8/afuJk2lXSAAQ/9ueBCyGt9uc3l5x3j9JOVmp2RBbSClbwd8D7PJzY1bUnbb7sgykE9gHymrdHUyyTgPIj3bQWkKeleIYNoJqeLT+Y24yZ/QwYZg+lvGeouvInywOf481WTRB/l7KAyz1/wdHgJA/5kHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g42YrPTvGElUTZ3D+5qrntbowTCsB3L+lalvousnV0A=;
 b=HbANs5dg89TJ/UK4bJjuOyb3lZr+2wv/4vdxTzjZmVsoJkInE5ety3vUZuasB6AKzMhUtPnqLmgrIMSLLNZaoEggUVgYx2WdQvem3Oo28IgNUKaNU3x8bpeKNpRNE2nTXbkCQI7DWV4LaQPaspVYqygfWzKyTbsY3tO/A+E/GFpz7ivN7LEyYlHo6q5/KEGVD3BkU566lSZnFZ91aEKTk2DbgYm5NSrJVc8/0sb3AAsm4Vw/es7YUHwEYgWihm3dEi8kDOPZ3UG4+ZS57vIsN4TqgNSv5nkLi4q42/JFTO6obr27Z/BvmaYNyvlsm173TU4Y40LtguD80vwNpshftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g42YrPTvGElUTZ3D+5qrntbowTCsB3L+lalvousnV0A=;
 b=n519syp5SfGT2w3zQj2aumQBCSo1FybQPrWgoZVze91r3m1SxX7WeEAQaG4sRdLeNsaC59YbcYsgkrr5eHjjwimAOSzbuxnXEvR4DdBofvv7CX9A5PF8jaidi1+jSHD+my7t2vA8VIVIgfgWuTPjw5D5bUJU5md6SYoH07mhjj8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 21:39:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 21:39:14 +0000
Date:   Thu, 7 Jul 2022 14:39:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
Message-ID: <YsdSfBUAINPlsR9s@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-11-jthoughton@google.com>
 <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNO+4Nzg=rgr1R027i2Evo-UKiFEK1gQcMHtF8uxcHzeQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aac02376-3aff-4566-1236-08da60612168
X-MS-TrafficTypeDiagnostic: MN2PR10MB4175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siHDJJUoUW1iRe5WJrN6wllGkmjh+WDAA8rkReEBw+n4uVg7Jx1nBndLgMVH+ZdY/GJ8IBiY5IQpt3vnCrREPm7PuxSv2nD1Kq5zTOTakjnJSe0/Sl69vNzUcc5ufg048NIE27OEeYnmZSxj2VK5p+bwrmT266hzEZk4d8N/C3TyFWi7/MHq2cBr51ieCfuSHv96e5LmoCa6iXYViO0LudVBwwMYGRmRjkvVS1H14O0I26vgYn8mJZBWDaIHgcdH4OPtatOyAUT1eQezS4s5svLVBP9j3Kr7Pz+olEs9t0NpyNLJAFfjuXSL/oi2MOpj+X/HgK1PnCMiDeGp4dmAfXTh3w7Zz6dp/Zfbii6Lijf0RqAt5qyVa5tQf2weZ9weHWBkrU+b7jDSL6J6uW6T4a91/yrVfLFZ5LQxrbul1bNwM7uytT3iUwkByZSyzOJvaAFUpUi1TTTBk5LK1iO9Ro8SN5DKTk+okFtEcCgdz/qfHykxgvrd1mDJjv74m97db7Ymr66dPf1xR0fvT+M6FanxsZOmrL0Z1TVojQ1pxIsozdY9Gf3gw9Xxy5oMmk9VlOtkMC+8l+BNSHdydcOfsJjMibHlNS2iNl1INxfBxzPUX8p5D3MVHAKVNJ0n/OvOKXESU1vElo/v+3jBR2C+vCvj4XBy7PwV6x62kAWo5RLvpWQcOjb8URj0ZMRJ3WBxyfIcmwflutcvhGlpqKERTdw7jho2vgmOcrjcNyeGXQqMRB3wuJD0yLGSOpNXUcff
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(136003)(376002)(366004)(346002)(38100700002)(83380400001)(7416002)(66556008)(5660300002)(8936002)(4326008)(186003)(8676002)(66476007)(44832011)(6666004)(9686003)(33716001)(2906002)(41300700001)(478600001)(6512007)(26005)(6506007)(54906003)(53546011)(6916009)(6486002)(86362001)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQghSm7PQWE0n2I7rdxjJmnL6FIhnx6bkr0Nye+7xjHCpkDRzHYcHGuVyzD9?=
 =?us-ascii?Q?k+ER+cxelAjHP4oEQpEQ+C34duBvVvv8x8d85MidGsxh9lDAljK2sz7vbTDD?=
 =?us-ascii?Q?msTkZmFgBITeh63RULA2IHRAZg/Cwn2Xv8eM/8stSgrLPDDHgC7sct4POfO2?=
 =?us-ascii?Q?mHFZVUetcGcW6lRWXUW2m/zV9WOIJRnzh0kVRTs6Ezj0LEiahEkKEL0Kz3n5?=
 =?us-ascii?Q?O0VipV9xC+snQaORajL0TitRs8BwpV4R9dS6FSR/wdtY40yj3iGpG+JLnjDk?=
 =?us-ascii?Q?BF6RV+FQbe2jmZIeDsJVgJjpnOfQDA2oFvonJEszEDXDxPYSFbWSxmBYo/W7?=
 =?us-ascii?Q?+vZt128ecGZ9repL4ZOS3OU8YU8ZXZjP/4gSmGFO2JV76LZXcuDpH1UMODbz?=
 =?us-ascii?Q?dK1+FY0zkRwMkatIE29jsESPfj58TQW9lan498OA6LW7LZ/nJvfe3uCGGee8?=
 =?us-ascii?Q?KtvkNmA2frlgPOeMzhV4ebPCK8luAdNHuLHa8PdvefuALk2JwOLwEn5Kn3FI?=
 =?us-ascii?Q?SoSbqWR3937GoKuJcJeofabESFqgaLakfTpuKug2vWc3N7wCYtTlOKYxi0fE?=
 =?us-ascii?Q?6JHmV9kUbcJXyQjJXtx6oYKaSfFFpeZfkryYHPoaDcf/ajLnoFRO9+ialCA8?=
 =?us-ascii?Q?bKBBYJ7ko5HAHvFPIuM+lnydDZu6IYh/jEOD5TwO8N2COv8nXxider+diRp0?=
 =?us-ascii?Q?LnlekXW6Ai7um/n1M3MAODyZoxZp/uucYUPOecaXXWiaCkJaE7eQZTg91Onc?=
 =?us-ascii?Q?qYFtD5bk1b0tbYpeNKrT/OLNTIdC1CeZz/TIuymB92z1kAtvRwfzeeLebuSW?=
 =?us-ascii?Q?H5sNpFzHHdIXzUxnSTXgmSRrHU3TWz1zXfuKpnG/RL9sMvEq+Duo6ZP0eiY1?=
 =?us-ascii?Q?UuatA45WzbBV611qhpkSDq5MnPJUH4raZgLQ50ZWmbJtmtD6pRAkJIBiQqO7?=
 =?us-ascii?Q?z3L4BVgVxsfeSTW7xtePvjXdm8w/loCGvIHrv3xeieeHvds5SsmMFYDUYV4E?=
 =?us-ascii?Q?azdTVxOeDJexVERbPzEZwIiQdMmkS9AIMEQF17ws73mvWcYHJq2kYFxNtGP9?=
 =?us-ascii?Q?Udkcpn1aAMkCx7GUK1zQb8RQQpVrXnWZCZ748lK9T6L4qAWj84g10Am5JeaD?=
 =?us-ascii?Q?Q6P67hYNTDcRsHl1R7lXXP//Dm0FYuhYjUlA20n0YVLNobkLldJ4c8FIAODs?=
 =?us-ascii?Q?tMp9mchufo/zBg9De3Tf+3Y9ZpWKnKZojiiJT35RKzs1/M7awHUGJ8ecA2d7?=
 =?us-ascii?Q?99GSqWv9GlehdxGvUlSdKdjcL9KuC3bdIi2Qq8Wv1R9knA1F3xZk20qXAI65?=
 =?us-ascii?Q?6NtZItRARepu53mbtppu18m5rEI4r6mOumo3bIqnRXBu3BJUnpV6i2DLgh1s?=
 =?us-ascii?Q?KyZisCBzCsyfkPrYe2jJ6ltGM8FhRopOTX+SsTRoxMvlV48SjSJ53XGqnb0a?=
 =?us-ascii?Q?xHHHTOEnlzGnQQCPbrIH+cTXmxvtzQUTLK67njllv5TQqOxs/uHm/47hHjdW?=
 =?us-ascii?Q?S9G2njB9j7L41CPvMhQ9PONKdkhuGm87fgO5w1D4JLkTz5Nx7NGwtozV2URV?=
 =?us-ascii?Q?/ft60DaBHEE62pkO/5adelJO+msH67degicSIjfao3jZMuEYsMohCO8TixWd?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac02376-3aff-4566-1236-08da60612168
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:39:14.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOe5nMddaoA0Eiwvg/LcoIDxh34t9jLjDSbropsDnXvKzPG4IVcZMm8pxhJ8nVvPxKvdt2dSrymGfFfgfk8vhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070085
X-Proofpoint-ORIG-GUID: 2TwUEiWO8E8fkgTJ-eV1KwmrtB6YzH9e
X-Proofpoint-GUID: 2TwUEiWO8E8fkgTJ-eV1KwmrtB6YzH9e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/22 14:58, Mina Almasry wrote:
> On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> >
> > This is a helper macro to loop through all the usable page sizes for a
> > high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
> > loop, in descending order, through the page sizes that HugeTLB supports
> > for this architecture; it always includes PAGE_SIZE.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8b10b941458d..557b0afdb503 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> >         /* All shared VMAs have HGM enabled. */
> >         return vma->vm_flags & VM_SHARED;
> >  }
> > +static unsigned int __shift_for_hstate(struct hstate *h)
> > +{
> > +       if (h >= &hstates[hugetlb_max_hstate])
> > +               return PAGE_SHIFT;
> 
> h > &hstates[hugetlb_max_hstate] means that h is out of bounds, no? am
> I missing something here?
> 
> So is this intending to do:
> 
> if (h == hstates[hugetlb_max_hstate]
>     return PAGE_SHIFT;
> 
> ? If so, could we write it as so?
> 
> I'm also wondering why __shift_for_hstate(hstate[hugetlb_max_hstate])
> == PAGE_SHIFT? Isn't the last hstate the smallest hstate which should
> be 2MB on x86? Shouldn't this return PMD_SHIFT in that case?
> 

I too am missing how this is working for similar reasons.
-- 
Mike Kravetz

> > +       return huge_page_shift(h);
> > +}
> > +#define for_each_hgm_shift(hstate, tmp_h, shift) \
> > +       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> > +                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
> > +                              (tmp_h)++)
> >  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> >
> >  /*
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
