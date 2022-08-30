Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C071D5A68D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiH3QxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiH3QxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:53:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354598E981;
        Tue, 30 Aug 2022 09:52:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGhP1u009100;
        Tue, 30 Aug 2022 16:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NDamwHxaTju0rHF4FONuyxNhG9DXQXXJDvzsWK+Q8Fc=;
 b=CawWyu1ypFhK1q0qVYe++mGHGBonGn9SGQKqUnW0GoOiuNGB/kf4MGkHLArSn/JjIfAS
 n7ihaWWZBYAY84e/KtGpALYrHalHKpad6bdWYhVZXkrtRVODCMI5owAmVFemNc/IIYP2
 Y+TCmDenf9epnZseaumtAGb4XAQyFEKdVQ1EmXwze3ad8fJzZe6JndDRlUH4WP0soZkX
 QOjczYe5l9SCHvmK7+EOq7qTuvbV1rTxTLLGPGMHTdOZcosU1Rt1jboz2jlyg5FpKu3e
 UyqXDNMYYWtK4eHgtzrmW0wF+NT6uqqKe+fgJEqiuVw7J/5wpdDBxrgiP3pbyzXFysNE XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt6xbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:52:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGf62m024368;
        Tue, 30 Aug 2022 16:52:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4e8qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5RnoXraeheiCREKaV/w7rjrJDtaSQCYzg1gefeKezHnJVztFJVh/IIxCziZ1fUtb1tQYmUzmI+jyBB3idmPaEFrgi70cCbQsY6q+t9wXDN0bCe/cgOEG3fVG4o0CC8UBJy/PiBDi1etX6kugWKW5hvVbgKei8wS4/mULiC1FJ/V+wXl8mQ7GHBmCKisCnf0pQ3a/ADUJo1FYUQzDAKyfCkz+y9qkdRbYPDgsP7rv5Xs+136+U97rP/cknmFdILU5hCZeZu8tt/NW1hkBX2ltnTVo8QGItqSIPKZt4/47PFLccL0MdI4vOV60W60P2/dnmHDIjLzSdZvhtHpO/x3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDamwHxaTju0rHF4FONuyxNhG9DXQXXJDvzsWK+Q8Fc=;
 b=SNxIzSQHFwdlLb0HcT2MSEoIocIM0pLCEsiT0z/VctPU+jIWfnss2Zrm2MWDXwvlpwsMpbImxmJRVGL1n6mgzU3yoF8246tV9CYrs8+gO/ycITaHHO+su1BTIGuZwi4VbwvVJn0go9qLfCnJR+1gD6y3OMy7deixRqA9dyRauGPtOEYARJc8mIe7mTfDvMPGJd9CfkuolXOjd1sdrKfnrXKgtF/n7Xp2rUX7vYsLLTNdt8pcVbxN7Mrp1u5MUCf+F7Tqp4WQD7jamsgWyjgVhisFb3VxNAw5wZqlUp6IzHoNs/l9x3W6uThe1XqI6GqezjWtdzooWp4BBrL53luCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDamwHxaTju0rHF4FONuyxNhG9DXQXXJDvzsWK+Q8Fc=;
 b=l0ILTc20a8w90Q8mArhB8JA+oipANdwmMte+YAxyqQ3xLhnza3hi4I9Tyol9w9nHlZuXsqGf5BUuegWSxhWBvM1hSL5zloa8g3ciBnecJ0Q+WKN3AcsznPIS8km2bR7tMFnhkNBwdRnCVtUP9QDpatnV+J06zfMonWJOfk3cIt0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2126.namprd10.prod.outlook.com (2603:10b6:301:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Tue, 30 Aug
 2022 16:52:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 16:52:12 +0000
Date:   Tue, 30 Aug 2022 09:52:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw5AOZ/Kc5f3UP+s@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608934d4-466d-975e-6458-34a91ccb4669@redhat.com>
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b2f4c18-5ba0-46ff-4544-08da8aa7fbc3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2126:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taGAAfsEBkFxAQiI6HVMPe9gl4TOUvvKWKMJOhOFCKWiWRv8Ddi0YHQTd4iuGC+H8ff76OZOIo+vzzDPFVPTTASW6cqumom5WOsbwrZHFqcfXESdV/biS0dE7OFb0IGogjOql2Ks5lIswwK2928aNuFx5pChP3eHlZW2t1XGLnokDW8xS0434cF8tHS4FdrjgQkw7CqC4dJDzBBtmEti6m86CQurWZwcNRp2Vbf2aHxrFbmsDKa6drfWlPybAGufjTK5bAH9CGzgebVi32dUx1DXbsMnBYZ7z0R4PlWyVT8ESuaZ6OzyjIn8SJslRASczIRlY1vo/TmwDC6h5R9IaviIBOwFi0YjYSfQr7yK2ztmMh6z/5wHzO/QEHUXcuCyqCTy/56HJeiOrfDNZ3b0meJCKXkdeZQOdXQQ/77F561Ckmj13KpBc9ksFPCl9GuE24Xk45xfSHyNnVQ4eACOBF3HOXrHQpSdG6mfLQDE+gE5yuLNGsQzAXYs7lNdJdnC3GrUA37eDVcYw28/Cv9ix+jO99mzVVp78U/prHtCEqgz485IgITJx+0c0YNoc1FtvvflO4H2m1nLx7fJ0Za/i+aRJTGqhHGTRHf4G4PTIOLZF2efBL8NGcaREiuD6SgPP3Q9NbDWb07xWCBNrYywdpVEccpZ4gPqp119+LGaN2NkQjAOvAHQsYH0VeIYv5L2p1tfnI3Yj6cISp1Nul5MOQfegaKPk6k0HCo3gE3r/DHhSgi77QZske+Bf+HkQGug
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(376002)(39860400002)(346002)(6512007)(9686003)(6666004)(186003)(7416002)(26005)(8936002)(54906003)(6916009)(316002)(6506007)(53546011)(5660300002)(4326008)(8676002)(66476007)(66946007)(66556008)(41300700001)(33716001)(478600001)(966005)(44832011)(6486002)(38100700002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFNJZI8MvEnQt4wdl61UeCfv1Kc2yu5H4mP4Avd0xH81noUgk2/sFHQF0Ob8?=
 =?us-ascii?Q?VN4mW3WjYfzX3F+RbX3U6nzE5eIlUsRFX5dUNg7uvdvAgGHt1q1hWflnyaDS?=
 =?us-ascii?Q?JcR5fAT2bdUhixn67KMFvl8DEDkTKk1chY+lqCdYZMpifx33+ikVY6bakVvI?=
 =?us-ascii?Q?5dersMYQJb4v7OgZn5FxuYruyMdTQPv3ZfUd7gmtA44Meh/yhuJkoPQpMZru?=
 =?us-ascii?Q?7AKecjtImtG8lWpp5H/i/UM/1ho8qVwkLmwrM4VMPJSwapeHON5eFymkBilP?=
 =?us-ascii?Q?8EczTR7amTclvgJ1mgx+9U/UOYbusAdP+0AENkozwIcRk+9EQf1mPghCkubW?=
 =?us-ascii?Q?SkoZPZYC1pZegu3NoN2bY7FIQd9yAKTBUvAcy5F2DBc2zCj/z0dRf1GyDw0a?=
 =?us-ascii?Q?vQAX5+O9OxlPctdmhploEbFcqewza5asqrYNLmiPkN8eUnjeFDm72DNs0oCT?=
 =?us-ascii?Q?0LDpWLTHtboUOPkF9D/9vrKAsnKxg2+Yu7pv1DMKCi3iUpkKRLrDcqE+24pN?=
 =?us-ascii?Q?Rp6HIOqjmxTH23+d1r+jMi09YzK3+gDxPzm0pxaBm+tBMpIrox/RVbu5LSP9?=
 =?us-ascii?Q?qEEinOYJAa7vYUS7JAZ/7R/TP0avB+Y7V20dYhjG5vV4F1jdy0/CIwXlGsk2?=
 =?us-ascii?Q?FaW+U7pvcHBgTm0zztQAEC7YiEJ8J/KRLWf5hY45Dd6I8Qm3/0G/mqp/WjrK?=
 =?us-ascii?Q?RakKOxN6wOHXSXgzgKRZtPVejk9r5Dx3q13wQHrAnGbnn/HZiexB6G3tJ3M1?=
 =?us-ascii?Q?uTi88Qx3S7NTiRKuwJLEMT1i/WlFffqBil7gWzmiIeFByMukGmTFtsuXt293?=
 =?us-ascii?Q?xbrow/DSlsHsu/ETmXL7JodRWrwyFbjECsxO6HpYSzcLMGHUv5RTTlRpva/4?=
 =?us-ascii?Q?K8uoptww1Ovo+oJppli1TmERMdpFZiAWYXFk6tyRgXRDmBLKZXxteuNxZ4Le?=
 =?us-ascii?Q?EVF4y6l75eiW5NpWO1m0ukNWND7J8xRx6FpS/NcvjeL1c+1TI68w2LhJn3vg?=
 =?us-ascii?Q?767DSWy2BHndUeoaKZtXI4u+0t67Yh1fdrmmD2dpUyYn0355bwDtMtRw8tVr?=
 =?us-ascii?Q?K1YbA9LwD/QKoOz+03RI3NTOrEqvyXy9YiMJ+PRK6QzDD6np6wNUboyD6yM1?=
 =?us-ascii?Q?1iHY/bByqgWRH0by0prcnXrTWkSx+ByPFtbLU1hoWJZ61TCVm2X+LjfXkWSW?=
 =?us-ascii?Q?aYk5m0ueuJwPCvXncXyUJrB6OC8AMQDoaTBprGLZc0kt2Eica7Xcm+WyAlUD?=
 =?us-ascii?Q?fa4TINk4Mlhh4xJuEDYkBBJJW8jdiv6xRHB6Gr+rM/HGHdrgdVcvHb0gBbmB?=
 =?us-ascii?Q?6RmXJ0KiIN45E/nIUcsHy307fkflBvAw6Uep3pYlPoG88M8tsz6XnnC3Thq8?=
 =?us-ascii?Q?8TwVmy1qjlHMltMvNajezpyeUgE/i60D+WH2BmNJw15kZRJL7FjtH7/kd7jP?=
 =?us-ascii?Q?QOYj9SWE4iTbIGoKlfHS30fvfb0Bn6z62zOViQX/tV8sbtU3RLaQ3aL0LDtq?=
 =?us-ascii?Q?hrUfGus4ybFDOysYNbAPZ1AuCeCKCu9Uuo32WfjpFS/ZvTSNAMgQGA6UGe2W?=
 =?us-ascii?Q?W0ZoBcKXCLc9hcI1xu+aHVmezjn8HgQLaxfxL630Q6MdtBsTszumxjLVVEbR?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2f4c18-5ba0-46ff-4544-08da8aa7fbc3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:52:12.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjdOqFfTEUo94TzTAc82jqmJlMeJAYP4UHCWXiT8kSPgCtPSHkt6tKAqGLnGnQz0o31QBuTSs/Cl4E/YauEFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300078
X-Proofpoint-ORIG-GUID: y72t66wUhVaxD4mOJaQFAdmQrDUBOIBJ
X-Proofpoint-GUID: y72t66wUhVaxD4mOJaQFAdmQrDUBOIBJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 10:11, David Hildenbrand wrote:
> On 30.08.22 01:40, Mike Kravetz wrote:
> > During discussions of this series [1], it was suggested that hugetlb
> > handling code in follow_page_mask could be simplified.  At the beginning
> 
> Feel free to use a Suggested-by if you consider it appropriate.
> 
> > of follow_page_mask, there currently is a call to follow_huge_addr which
> > 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> > a follow_huge_addr routine that does not return error.  Instead, at each
> > level of the page table a check is made for a hugetlb entry.  If a hugetlb
> > entry is found, a call to a routine associated with that entry is made.
> > 
> > Currently, there are two checks for hugetlb entries at each page table
> > level.  The first check is of the form:
> > 	if (p?d_huge())
> > 		page = follow_huge_p?d();
> > the second check is of the form:
> > 	if (is_hugepd())
> > 		page = follow_huge_pd().
> 
> BTW, what about all this hugepd stuff in mm/pagewalk.c?
> 
> Isn't this all dead code as we're essentially routing all hugetlb VMAs
> via walk_hugetlb_range? [yes, all that hugepd stuff in generic code that
> overcomplicates stuff has been annoying me for a long time]

I am 'happy' to look at cleaning up that code next.  Perhaps I will just
create a cleanup series.

I just wanted to focus on eliminating the two callouts in generic code mentioned
above: follow_huge_p?d() and follow_huge_pd().

Really looking for input from Aneesh and Naoya as they added much of the
code that is being removed here.

> > 
> > We can replace these checks, as well as the special handling routines
> > such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> > handle hugetlb vmas.
> > 
> > A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> > beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> > existing routine huge_pte_offset to walk page tables looking for hugetlb
> > entries.  huge_pte_offset can be overwritten by architectures, and already
> > handles special cases such as hugepd entries.
> > 
> > [1] https://lore.kernel.org/linux-mm/cover.1661240170.git.baolin.wang@linux.alibaba.com/
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> [...]
> 
> > +static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > +				unsigned long address, unsigned int flags)
> > +{
> > +	/* should never happen, but do not want to BUG */
> > +	return ERR_PTR(-EINVAL);
> 
> Should there be a WARN_ON_ONCE() instead or could we use a BUILD_BUG_ON()?
> 

Ok, I will look into adding one of these.  Prefer a BUILD_BUG_ON().

> > +}
> 
> 
> [...]
> 
> > @@ -851,10 +814,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
> >  
> >  	ctx->page_mask = 0;
> >  
> > -	/* make this handle hugepd */
> > -	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> > -	if (!IS_ERR(page)) {
> > -		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
> > +	/*
> > +	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
> > +	 * special hugetlb page table walking code.  This eliminates the
> > +	 * need to check for hugetlb entries in the general walking code.
> > +	 */
> 
> Maybe also comment that ordinary GUP never ends up in here and instead
> directly uses follow_hugetlb_page(). This is for follow_page() handling
> only.
> 
> [me suggestion to rename follow_hugetlb_page() still stands ;) ]

Will update the comment in v2.

I think renaming follow_hugetlb_page() would be in a separate patch.  Perhaps,
included in a larger cleanup series.  I will not forget. :)

> 
> Numbers speak for themselves.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
-- 
Mike Kravetz
