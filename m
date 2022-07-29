Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF75854EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiG2SMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiG2SMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:12:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5DC5FAFA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:12:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THx1t9008321;
        Fri, 29 Jul 2022 18:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=56C+M7rHJFwjbUHo1UZlGTizDzYc/HGcAYAVi6KUfcU=;
 b=CGzAyFXeBgmXpAuDoXuCWFfs36wArFc1G8vSqa2CPv8wMyKpNOY3bwBTVAget2Fo+DI9
 w8CqXGGmHWBo1/rV1NQY5ldNUG5JkvXpMcwd75gOi8E83zgnF7ghkk/UkxM+G1aI/Gtj
 VVTBgwlpZmCNRpzsH0Fvy7LEsABqlp06OAmgde6tNCePwvlCfL7yXzAO6fNUHamUJgGw
 Ibrh5S4E7WGUKM7sx02usJcrFIWC6aRjxd3OzjolWgrpAV6pknM6XxxSGPugNuOxE5bl
 L/oP3f+T+ulSjafjxczBESdfgWlQtOSpzwrDp3iQMfFwS3SLBQAV9R8vCW7c/EX+I4sx KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940yk63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:11:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TH078k023013;
        Fri, 29 Jul 2022 18:11:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yyr86f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfydOaAYzo6D0oJBtXINRa5P4V/x/s/waDlN3Z1UeqwbhhweA4S7s0Km+2OpSPv0s0r4fHoWxAvX12Xfex9nWHM51SX8+YloXQ4kfkO1ygDLAyLjqBGu61PhU8OWmWmmCKQnVhuqJMzScQFnbdUPTKZMJtEjVdBQeXZkaTe9mkFhy02A0YPpKRarCqIeXUw0imS190EbC8VFg2osQkEbAoeWGKFpFisVYI+HCIjRX0Q5REFrrsxYeH2DzSm8iijR5SfH0aMXHW1SmgmKoApG5IxIsmchBYfmUzqV4sF1iNhE2OY/KWlFnkMmmBTMOubOeV2P5Q5LD7sywXBUOujNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56C+M7rHJFwjbUHo1UZlGTizDzYc/HGcAYAVi6KUfcU=;
 b=HIE27+NsUNxAtTJYDyj8PGNK5a5JAkmcFh+DCIJZjjwvijvX5V0vCin1roe6wfzfm2P8t8giMRDAyobRFiRQCe0srwEeaLMbyQ26u9f7PmQ6ko8ik5Hx0HfHfFFyHjlwiWRlIpgryW4cRUGECb3I+/8DT61ohzLJnPPXXiXGfMzgaFa/dt+i8mdhC1gMpeEfbSKxZHwtcDAva3+3zzF0vK2Y03X25J8qBlno/Qqb6DoqR1QrWXsKQtRagJsNAdLA4EFPLDqCGr/UIjQU2MZbufy2HCqToyqVqimBIkUK246LEQ2GlubTRGK/kuHkgsBBCXzAD7XJLCSaa8Rmp3iOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56C+M7rHJFwjbUHo1UZlGTizDzYc/HGcAYAVi6KUfcU=;
 b=HF+Ys/5duM3iFzdgI2eVAIkxcZfHLUogMSNbul/xARHWYSOMaR6KcWtcvifwmBvICKi5BmJlKwK6Z01RI26K/nPC3ZOwQZPaN58K+CyJi5uVLASRmpHNTwXoGrsgvVSX/vf6KNXTCkFxWJHfamM7fMUjbEY8ycp2ie+Q7rEjWko=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6198.namprd10.prod.outlook.com (2603:10b6:8:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 18:11:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 18:11:33 +0000
Date:   Fri, 29 Jul 2022 11:11:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v4 7/8] hugetlb: create hugetlb_unmap_file_folio to
 unmap single file folio
Message-ID: <YuQi0obsC7x5krRs@monkey>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-8-mike.kravetz@oracle.com>
 <3557d5a9-231c-4007-3e7e-5a7bf34ecaa8@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3557d5a9-231c-4007-3e7e-5a7bf34ecaa8@huawei.com>
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7628c293-626f-4a86-da10-08da718dc4a4
X-MS-TrafficTypeDiagnostic: DS0PR10MB6198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zshSNUVbBAf60JWbhC6/yUtTQtjDmPNxNSMTLtSPbpqCnrt40pxiY1ygFHQlSzk0n0PCt5bMLIZISICfY9gtS9kLIpgWrtF2g/DsvAfT4N0s+S13WqIoQcnKumsA7mAA9GTqJiwC5/lyQ98MkLG2cncq8E2YpNT01Q/4ML+RMKgNHJdLyX5m1fjcwIfkA+F8btttRcGiwX2AhRWwRG3yvInSCyujSpnCX+lIsKt3oQ7odKtNX4q0RHgBddgTqTnWSkM0y/X+ZQv8vw8/s+mj9LEftvxZR4oAZosuJ7ygaw28llYZMcWToW1n+0eLTh3lYMoCQyOoJuqBHEtB9GvgdwTX2QxLuE1WN5NTGYsMsFvr6BGE23BZ+bJf9vZHssjUvF7mXWa5GYBTkK1WwLNpjrN/Uz8aWSc5iZEFn6bGwH9pZcLrZhZhD3+2luOpBRuq2XbtRwEQV6hEeHwVypujbBfjNbCbEOAY3bFP+62AZp6sPwOtPO3AA4e7X0xlLWhzdvp2hjDv6OlMKfDcH0COLjcle7sQgp6Sb+V4pzrMgjXLm4BXcORDC0NB2Ou6f/NB1ot6IjTcHPb4ifskQDKnSnK0EyJM4fBLGBYpj4+fzm9biGbXrRY5x8DTocTFB95YhVyBkhUIjBI9D8oqQ0MH1IEjJikhOxtUKKXUs2XRsiTSXVXwiaokC5YpWccBQlDImQ1H49tKhInEpceWLrOq6iVzYTtsz6ooiRkSM7Q7YgicdLSi6BoqnP97rRhqalt+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(33716001)(54906003)(316002)(8936002)(186003)(7416002)(83380400001)(44832011)(86362001)(6512007)(6486002)(66476007)(41300700001)(66556008)(38100700002)(2906002)(66946007)(4326008)(5660300002)(9686003)(6916009)(8676002)(6506007)(26005)(478600001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qStVFyq3Q5BnFyMCq+YqqreApCai+IJcBzCjGz4x5s/8ljkbBOd2sF8hpZsJ?=
 =?us-ascii?Q?KD/YPNkhb5joJGMK5MYcL9ZuNub17EvZ3CPgaA97zO1i9PmIFNDZpSIDtSua?=
 =?us-ascii?Q?/Wrurrjye+UUG6gF8W1CAGFLigubYpI4jNFH2GM462R2SI0YmoMWtYCXL6SF?=
 =?us-ascii?Q?MC9mthaQpy8ifkFyjXR3/Eu5HgJAkTptwOffsWLZDB8gdZb2/c9Urs5qtFT/?=
 =?us-ascii?Q?THAau8pxxv543r7sgCB3p0dDOemjvhxdpWEJlrRa04iq+eXxr5xj8IT2oRUP?=
 =?us-ascii?Q?ABEswcrrcsGJTcZvV4f6i7rFoeaATGBXeUdL0CKm1JJxUe/bBA7vo6bg1IIy?=
 =?us-ascii?Q?ZCf+7t8zuexsrM0wPrZGayyMYsqCbuHI2Z2gHrioaPDcktu+zyGfJ2G6dRh8?=
 =?us-ascii?Q?lU/2KZiaZFkYzuXfLVxJtMKsNcspY6KJ0JKYGKtAPxL5WnRFdlD7ECqThL+7?=
 =?us-ascii?Q?LomkLAmIyBxjaekForj+EZjYk2aSupYgP7AZ7eABhiHRG+msseyELPNXe3Vj?=
 =?us-ascii?Q?uLtdHtNMOJx5fr7gkO1i3kigpMnWq/thKzV8hnq/h9aGwoIudTIrzUcOv+Ki?=
 =?us-ascii?Q?vaLJr07ssoqhmHwA7jOaSSr5yHZ8b2gDFJGAEIF+HRvuEP1RhE9b2l/AUORr?=
 =?us-ascii?Q?pB8snwf6rHq31b/n7bpftr9N+rgQm7dVbsBNp/rLKs9NWyv+FcQFKrxda4bO?=
 =?us-ascii?Q?BTKnVdhxPyOTW+XtRAW9DAA6JPYki+rLkO9XLC8gIeIAM0jZkmqmBXR1kbYc?=
 =?us-ascii?Q?K2+TRXQyZaP80wDiZYhYLlkoHeQ8j9nWeqkzndVHdrYHHE8ILV+PaTQ4lWw2?=
 =?us-ascii?Q?Kj4c64TY7pO87mXen/B/KK3iIu3ckcMrEd8neUp7u+VdG2xBUeIN25YepgFA?=
 =?us-ascii?Q?HoIVQHVRtTiEAtVO029JbxA8yan6mcx/zkbcE0UHijVSEB5hxs14bjUK1FjQ?=
 =?us-ascii?Q?fH+HPNKT9Y92EIsP+cCNyeM8HhyktV9XZ84ASuoWFrAMQcEmNI4CC4ddpIfP?=
 =?us-ascii?Q?BX6ic8GxWtk9DkGwpfB29SBnKtV3GaX3CqkDozZZNbiWNa32p46xYX9Z8Wtj?=
 =?us-ascii?Q?majbD5t4Vf1bMgqvblJ6lbJ5FRcBKRjSa4E/6JYOUm83vbaimDjYhAC6Ao7R?=
 =?us-ascii?Q?XlWuO4inZ15qQlB7Wcq5d/aUzpY4Fj4iCc9HEFsmelRjTiZBMmVLVJy7sXMI?=
 =?us-ascii?Q?+AiHk0SK1PY9cmKFiLSEa082di6/9YSKRU0a/LGMlSHsxcLnRRrcDuuiYoQn?=
 =?us-ascii?Q?Byan05Yl9wvlC+Cy2RBS/uF4lw2Mx/BpVVT5pbt6Kx/xdDV+NYwokMAc6mgW?=
 =?us-ascii?Q?xpWbzxMGJmGt22MNnJGtvmOdxGfHvybfmsekYUSbxbKjApHvh7a+cKRPo2Uo?=
 =?us-ascii?Q?3M4tQbAnGzB+Zm98MKWj5oseIl14EA3y+F6SViFG8tp7LLZZ6FxWzn3298Ua?=
 =?us-ascii?Q?6HYnMJLby0i/MrrXZMk3Dz/e7xKnWggk8ovJ4AHN236gOZJMiCLlkjqZTQi+?=
 =?us-ascii?Q?iL2uNa+fCt83wX8UH3Y5Kdscl2QtycpnrSCQiEYf3F7IZbGO4WHEf2VbOM3c?=
 =?us-ascii?Q?Xf3yY+/aDjGLvc8NxCrgpTtUz3GWqV6HJWVkRX/Vk0sFrLB+wmmiOOQ0qkhD?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7628c293-626f-4a86-da10-08da718dc4a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 18:11:33.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8sSmkbaPqUEj/glzimDaM+schv5FZZUnXFduadorJnGOWrN5dXUg6Mw3+bzgiMXk3fOBOKIqaweybMhLnbvHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290076
X-Proofpoint-GUID: 4vOYg5uPpeY56MDt6UVS765SRTUzcp6W
X-Proofpoint-ORIG-GUID: 4vOYg5uPpeY56MDt6UVS765SRTUzcp6W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/22 10:02, Miaohe Lin wrote:
> On 2022/7/7 4:23, Mike Kravetz wrote:
> > Create the new routine hugetlb_unmap_file_folio that will unmap a single
> > file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
> > modified to do locking within the routine itself and check whether the
> > page is mapped within a specific vma before unmapping.
> > 
> > This refactoring will be put to use and expanded upon in a subsequent
> > patch adding vma specific locking.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  fs/hugetlbfs/inode.c | 124 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 95 insertions(+), 29 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 31bd4325fce5..0eac0ea2a245 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -396,6 +396,94 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
> >  	return -EINVAL;
> >  }
> >  
> > +/*
> > + * Called with i_mmap_rwsem held for inode based vma maps.  This makes
> > + * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
> > + * mutex for the page in the mapping.  So, we can not race with page being
> > + * faulted into the vma.
> > + */
> > +static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> > +				unsigned long addr, struct page *page)
> > +{
> > +	pte_t *ptep, pte;
> > +
> > +	ptep = huge_pte_offset(vma->vm_mm, addr,
> > +			huge_page_size(hstate_vma(vma)));
> > +
> > +	if (!ptep)
> > +		return false;
> > +
> > +	pte = huge_ptep_get(ptep);
> > +	if (huge_pte_none(pte) || !pte_present(pte))
> > +		return false;
> > +
> > +	if (pte_page(pte) == page)
> > +		return true;
> > +
> > +	return false;	/* WTH??? */
> 
> I'm sorry but what does WTH means? IIUC, this could happen if pte_page is a COW-ed private page?
> vma_interval_tree_foreach doesn't exclude the private mapping even after cow?

My apologies, I left that comment in during development and should have removed
it.  WTH is an acronym for 'What the Heck?".  I added it because I did not
think we should ever get to this return statement.

I am not sure if your COW of a private page would get us to this return
statement.  In any case, if we get there we need to return false.

Thank you for your analysis and comments!
-- 
Mike Kravetz
