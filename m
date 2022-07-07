Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194D56AED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiGGXEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiGGXD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:03:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2610FFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:03:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCF04013683;
        Thu, 7 Jul 2022 23:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oLdiWJN91HYSUN49HlX4h0JhoZPjCNJTmB/t+1kGkW4=;
 b=rfvadj913d8Cc/00R6Dr9s0V57Pzju/uam0JsCjcJ/3dqeHUoEnfeevEd+pfDolZ5N2J
 5bD8qZ7VjBi7WA8D1EEoa3vgorwJj1h6jxJcxW2eXQ7YZNY0ei4jxewyYR9mgeucruV1
 MSX3HwdhNQySb4e9MFRZH1K+j8ph0I2VAu75ygTEPwKxtEspP/VvTOCYiJxzUS68F4k7
 LP1lujnaVcnbyafp6bQKW69ltQK3IwnxWjbsOlRVWdOCze4I1vLEgR9aAuKLJHz1bar+
 S+i+3v+Ex0UpdDzJWYjRxcSYwwKSjgE5Ab1q5Lh+2j5OQMDnF+yWh7UaxYPSQFOhy5SN 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyend1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 23:03:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267N1vPO016125;
        Thu, 7 Jul 2022 23:03:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udfuwjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 23:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds2b+VtGusQEyRhknSYNWdj7MUiOwvS1WbaA6xaQE9CVet4XE4qTe6lduATPa9IV8X8U7DJFj9QIRNV2YAejUtzMHhmABzH2Qi2lQs0CP3zc4Ck+kjRbO8HlbLD2ZXgeEcov1YVHa9PP4OG01eI/LW5S4a+nLx+UZs6JLYDkeBF+9KDy+kHokNJvnL18w6RtOpJYyPEdobH5uIfUe7rVSSZmf80bJ9sCsTWdAJxZ20AtHWzE4zJclVG3vC0BTeSnoyf7SbHfOA27f4dcd3fKRvYhC6im2ud05SW6y8vYvNkh7YisxZ6AIfRP7Swk5QTF+F+iFOkMwQnDIjw5CAmGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLdiWJN91HYSUN49HlX4h0JhoZPjCNJTmB/t+1kGkW4=;
 b=cmppH0f4DhsfNP8zBs1SULAzb8aAIoGaCNSgSE9JYMC4PILiQoPA7P7qI+8kY7MNTg+L8KXBQzwRTLvcXUBD76OFuESZZvmfVwFZRzvtSmSdkftDntsEHfalBLOh2PROuEK34CwcUbFqRYed6qHim1cGJMKk6KAP5YtN2i69D4rHCjxFvyCg6aupYF1W5RBLpB0Fk1E0CXLcgVN2Yd/dwgf7ye0d7yJ0Zk7J+ZkrOu7I3CxMFhAcEAo3jpwvcR8qnS94zkbI2hg7u7+7RmUEOdbs/nAO9kpBkvTDaAs208SrxMLpgQZhRlMkDerHvZCMJVLP05r/SKttF09b0ZP8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLdiWJN91HYSUN49HlX4h0JhoZPjCNJTmB/t+1kGkW4=;
 b=K9A6YU2JJXqaXOn8pwyZkvS5+tPVasdppPrQRss7PABQEJsSnjcYa3uNxcZtLJFjqH1UHUvVcksL0bUc1wxWYJ5fMK9E17laJLXwxHXDH1NRgrVpeg6R7YjUQjTnr4L41K0PjmVzAkDY2kE5Auc7CImFnovI3l7hq27zbQXHUXU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 23:03:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 23:03:47 +0000
Date:   Thu, 7 Jul 2022 16:03:44 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "manish.mishra" <manish.mishra@nutanix.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/26] hugetlb: add hugetlb_walk_to to do PT walks
Message-ID: <YsdmUJcRoLDEHvNK@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-12-jthoughton@google.com>
 <ac95fce2-b095-62ff-7f87-d803572e39f0@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac95fce2-b095-62ff-7f87-d803572e39f0@nutanix.com>
X-ClientProxiedBy: MWH0EPF00056D03.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:d) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0e48d5-bc21-4ace-be24-08da606cf2c1
X-MS-TrafficTypeDiagnostic: DM6PR10MB4153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wppwKg6swH7GHrFoTEedMhlzFgVsEaJGK24c15hvPK7r3tZRizHuqvtNDoD88SJpq6cbMXaCnyc1XWzkYcl2KG6ep8Naph8Yez1+I3HlRA/W0UGSgejTFz7J9VjvuHbYnlSArKpMAh9ERhtLqQmsOlt3fP/wsiDnE7iDqf2NORX+lsrXwHKS2AUx1DrcRsBWPU4N5ZLJxDNaL041MxdYzeiqa+w9FVOf8IfjpG3Lc7MchlkHqmASvZOwhSFfApCWAcFqi4WQmbd2vJtg8PnJ0cOro2tYfTTlgyzrUUmKJm2E8AwUS1LLhJmYNUpXb2vYHYJS+Yu28jYlAGjAVrzcIY2nBwS64XbXpZfkbUivDF7N3reGMZAdFoVLW9d3inJqWl18ky4AVrAqgM0ZkdCGV7HXXt2eyswFPWa0du9c0UuZALnFYwcQjlsilIS8GIuLMRtgjTfVJ2F0C8Psy58ZVx3UtocTIYl1el6TPn+GHTlT7yYhMc9fcWLuZvoQmrXp57Dgj4uMq/JRhdxzjss/dtZBy8oDWYoNUG27DGsva+MRehNxOhK7Srv+0eNxYe7aY4mY87PHacMfZFshdJf8ItU5jvoM1v4rMmA0wArkU5pZg+XbSacGDPisdL2Z/QRSDFed/vgj9RgBveTMSPM6vSG8HAy9N4YGj2rWmGUGOBW4b6p+bDt9E8F2/WX4zf4BWyu+DoJRfvX4QKjEL/n9oIS37wN8f3Vpl7zSsZ1uqTqmrEVlX63z36X0xDd9bA5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(66946007)(296002)(316002)(66476007)(66556008)(4326008)(8676002)(26005)(5660300002)(6512007)(8936002)(9686003)(86362001)(6486002)(6506007)(38100700002)(53546011)(478600001)(6666004)(54906003)(186003)(7416002)(41300700001)(2906002)(6916009)(33716001)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrAkfCkENYS3LROl1yMLVCGG0pHgBPuos3U5AESXS4dtXppUyqdbyEwAGc5A?=
 =?us-ascii?Q?A3x8YX8o8MGE4avJZt4ompoWDF+K/0tO3gq3zaiZEQTfZQQaGBkexLAiVR7d?=
 =?us-ascii?Q?BQ9zVy6MsfCFZOOEzPxUcH3F9OLSqhKfe5yq09/nWWMfWpT6Vp/eYybYMLov?=
 =?us-ascii?Q?IBthPMZLcffMxdNG5iNypQKZE8UTbBY6lDSie6Qk8sBXv0rK4BYGV4slfM5V?=
 =?us-ascii?Q?YdHSpQKQtrZcLY5oqWCdAn5pPDIjy1S9AGkiVGBFeg+DEIlFFIrZpejDVtvH?=
 =?us-ascii?Q?KsomtDU82wuMRX+yeN1tAD5qwpVEpzrOc05VSonk7Bj2Zy8+P21TpWae2yQs?=
 =?us-ascii?Q?GTRDqha2/ZiQ8kfzW2bL9ZFic4DiY20RfoB9y8N1pls3VfSstmRAt9ZzJ5me?=
 =?us-ascii?Q?Lh5HJhtacGVPTb7ohkmhb0NrNnRXaHwHqrSbGotb44JHJTFgKpF4VRu9WMyP?=
 =?us-ascii?Q?9ldtjpJ+u+vArJc36+xSZ4BO5KBlcMRRIGyIpphrXGGw8ta/JrS7TD2I15pj?=
 =?us-ascii?Q?JJ5KwTxrP5Wt1Mx6AGDSgK7905GfWx38BL2AOU8HhG2/Lofs93lC0lGSXuW3?=
 =?us-ascii?Q?0jA9nDTB6X5XEIR/+3hgcFmMSruq6sOuHdHqkaXBxh0LxYN3ogKvliCRCcqn?=
 =?us-ascii?Q?Dl14qX9cB/9bNG9aDjXc4SxOPL1b+GEvyiL8yBWcf9nmi3UybIzmWWO35i0U?=
 =?us-ascii?Q?D7fuOaAAkjWlgzo5qtv4SZGgaufkmn7+rEO6RCx6R35JowdN2riy8K3aqkhd?=
 =?us-ascii?Q?C3/RYLi5Vp7AGZae3dncC5sAgjJB+pDpFEgjYluu4WDfQSUpmE0q4PPn8j8I?=
 =?us-ascii?Q?5LvxfGHa5VQ5otrCwrvaSkQ19+a5Z6WE6PDLrr1zbEHEIx7A0nFWBF5JhkaD?=
 =?us-ascii?Q?0+K2WRGiKOXDtcu7I3cllkNVA7yV1Xtb1ylZMInbvSM2dyCCZAXYMRm81Xvi?=
 =?us-ascii?Q?NM0wvxfNtZ8HCktWyR0OKAJd7i60a4LnBBCsAZhdpIcv4zgHu8Dv7BxBPSik?=
 =?us-ascii?Q?Ke5Oo/k2oOzEOaCR9VfFAfMw9nRMVEpgkmVKh5MECBZ5myMCnugT0bZiF9c2?=
 =?us-ascii?Q?dLmuSTsjPrZ1o5ALeUwq5CFs6ZlG8mxuss9Ct5GgkuUyUtTMWw8Ggrfi3YwP?=
 =?us-ascii?Q?XqnzoPAgw85oNKHtNW+CqpWofY5wKUJizyPcq5BxFQjxz4SiLQh/Thru+EjN?=
 =?us-ascii?Q?7NakE+b/absGcxUzEIuBp2ng/2eBGiOpxkkKM4Nsk+8D4inKV1pletyX6mQ7?=
 =?us-ascii?Q?yCKR9kZgrC/WhvD6hE921OF07w9aGaONUvlSgLibRWWsXe0CUFUs4/z+uA91?=
 =?us-ascii?Q?IzRfwoRsSAenJiQk0PYOdiHjo5SHE+VEb4sHP8jaIGa5y4A5osHNK/Frb7wJ?=
 =?us-ascii?Q?XGqhfeJ8SUjLpwv2ds3vYuRh1T03ChQqZkSjPHLo1EPUjsHz0qSf0MUjFH3M?=
 =?us-ascii?Q?H9fq05Wll/mliKbFfoPvsCeKSrO/y2tag4C5sI/XJQcUohwi4Rj2vN27GwEB?=
 =?us-ascii?Q?aoV507btGtpQctk0SkpVgsfsE0UIHRqFiamTpKCN8SG+cSB/hENMISsYyPTL?=
 =?us-ascii?Q?F2DCkTWHZC1tT7mZ9uYfYkMe2BTEFtpz17C1JzGxpbfBfUVEjnfB+YY4UKZP?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e48d5-bc21-4ace-be24-08da606cf2c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 23:03:47.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x9tO7laUlz8ztFqreLSWeBIzLq3D156go6jIhMCVF4mUqGZs3YQDTK3l/gnd7y8GX6rSWQxp4Qv4BgiiQIVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=450 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070090
X-Proofpoint-ORIG-GUID: fi3y_X0U6lONGub-6_JUQVfQyHs-GEyP
X-Proofpoint-GUID: fi3y_X0U6lONGub-6_JUQVfQyHs-GEyP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/22 18:37, manish.mishra wrote:
> 
> On 24/06/22 11:06 pm, James Houghton wrote:
> > This adds it for architectures that use GENERAL_HUGETLB, including x86.

I expect this will be used in arch independent code and there will need to
be at least a stub for all architectures?

> > 
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   include/linux/hugetlb.h |  2 ++
> >   mm/hugetlb.c            | 45 +++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 47 insertions(+)
> > 
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index e7a6b944d0cc..605aa19d8572 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -258,6 +258,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >   			unsigned long addr, unsigned long sz);
> >   pte_t *huge_pte_offset(struct mm_struct *mm,
> >   		       unsigned long addr, unsigned long sz);
> > +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +		    unsigned long addr, unsigned long sz, bool stop_at_none);
> >   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> >   				unsigned long *addr, pte_t *ptep);
> >   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 557b0afdb503..3ec2a921ee6f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6981,6 +6981,51 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >   	return (pte_t *)pmd;
> >   }
> 
> 
> not strong feeling but this name looks confusing to me as it does
> 
> not only walk over page-tables but can also alloc.
> 

Somewhat agree.  With this we have:
- huge_pte_offset to walk/lookup a pte
- huge_pte_alloc to allocate ptes
- hugetlb_walk_to which does some/all of both

Do not see anything obviously wrong with the routine, but future
direction would be to combine/clean up these routines with similar
purpose.
-- 
Mike Kravetz

> > +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +		    unsigned long addr, unsigned long sz, bool stop_at_none)
> > +{
> > +	pte_t *ptep;
> > +
> > +	if (!hpte->ptep) {
> > +		pgd_t *pgd = pgd_offset(mm, addr);
> > +
> > +		if (!pgd)
> > +			return -ENOMEM;
> > +		ptep = (pte_t *)p4d_alloc(mm, pgd, addr);
> > +		if (!ptep)
> > +			return -ENOMEM;
> > +		hugetlb_pte_populate(hpte, ptep, P4D_SHIFT);
> > +	}
> > +
> > +	while (hugetlb_pte_size(hpte) > sz &&
> > +			!hugetlb_pte_present_leaf(hpte) &&
> > +			!(stop_at_none && hugetlb_pte_none(hpte))) {
> 
> Should this ordering of if-else condition be in reverse, i mean it will look
> 
> more natural and possibly less condition checks as we go from top to bottom.
> 
> > +		if (hpte->shift == PMD_SHIFT) {
> > +			ptep = pte_alloc_map(mm, (pmd_t *)hpte->ptep, addr);
> > +			if (!ptep)
> > +				return -ENOMEM;
> > +			hpte->shift = PAGE_SHIFT;
> > +			hpte->ptep = ptep;
> > +		} else if (hpte->shift == PUD_SHIFT) {
> > +			ptep = (pte_t *)pmd_alloc(mm, (pud_t *)hpte->ptep,
> > +						  addr);
> > +			if (!ptep)
> > +				return -ENOMEM;
> > +			hpte->shift = PMD_SHIFT;
> > +			hpte->ptep = ptep;
> > +		} else if (hpte->shift == P4D_SHIFT) {
> > +			ptep = (pte_t *)pud_alloc(mm, (p4d_t *)hpte->ptep,
> > +						  addr);
> > +			if (!ptep)
> > +				return -ENOMEM;
> > +			hpte->shift = PUD_SHIFT;
> > +			hpte->ptep = ptep;
> > +		} else
> > +			BUG();
> > +	}
> > +	return 0;
> > +}
> > +
> >   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> >   #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
