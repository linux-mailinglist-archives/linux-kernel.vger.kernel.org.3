Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BF5ABA24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIBVhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:37:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD6F4C98
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:37:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282KKYo2024350;
        Fri, 2 Sep 2022 21:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zT2RcTmaSj3lqRcOGbIleiF+9wwmzQEtCi2ncCdt59Q=;
 b=RGQ33ZrR1B5/5hrXfyjUYCZxhOWjmGz91hyUmRqD/Wkqy1/3VQqGmy7GvbwPSOM0qmvO
 5bXrwHuN7rlbK3QoHGeSP/ZFJcZDcoIQlfeJtW5f+xh2VavSdbnxZTYvB0JDbFTKPAoS
 LzpsIVpRK7J/x92LyLCFWspcgkhIxNQD3c5d1S4qqJhTnuoHzxWRY9uW5jKMC7XBgVER
 kwSC+9quv8cRRowdLrwOu4f9XuMfoJ3BiiyamVRmGpLdkYs7ieocM/FaAoTKcuKTCIjQ
 pgL9REQkEzpcluReCU3BHGKKGFyjvWIF1pSyBglzsXG5dlllUAIzizC99XmyVjvc1pYt Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a7xc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 21:35:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282HXECZ009142;
        Fri, 2 Sep 2022 21:35:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7nk6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 21:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We4HRIi9xSRTdyAI7FJr8f2ivjK0X95T53ri0i6RviVAD/Q9s6TmJDj/MJIQwZ1KaAHQyVNfwSjCBZKTIqdDvods+L8lzS2qZuJ+k56qBwr1xmUXzlg/c5nsASd6mPwvZjYIsLuPCFlI0tAret5Vw1kcbv3uRBJE57t9SN8oSlQOpy3Szoh9AK9GVVV7nPrE7OARtg2cerbmoXUYaKiCsh10DWDiS2nW20GiGjrsLRzVMXoUW/9s+K0OyHm5MjNTVD2sMfg9+BimJoHcCTYjMeqxVUrqzQ9DGmfoku/NVv4P8gHXk4o6dGBB6M/YrdzPr6lUVWEByOISUfKHy+jsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT2RcTmaSj3lqRcOGbIleiF+9wwmzQEtCi2ncCdt59Q=;
 b=L/mTdvZeWE/Fa7nDrWFLeJlOehWRuqOQiQFozE8eB7jRCesQPSiTB/CeYiYTZYk9BK6x2MyL+3OW9xtst0HOUKvit53Bqc/z/BRKDGtV4nVwZYkrSpOJ3IJZbuUkZYhsri/2tMwMDQhwCJpPfYhCC3J/Z+Jz7QcevbsdyySQ9u4faLPOUhk4t3If42hGkvnOtVRw6DqmpYSa0oIUHyj6HX2eiMEsmxUX6WJJLYEzZLVutBmx0gdiHP8Op15ET3f6N9e2iJt31OEDEIXssxD8vVfsQGMJ2c7ZYITDugEB77BWH39YRh44MzlPX+WvstK30MLmKhP551okrwZ0eoKmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT2RcTmaSj3lqRcOGbIleiF+9wwmzQEtCi2ncCdt59Q=;
 b=HVUSBQSm31xh2CHCfRtxV3ab+pBKGPEa+HetNmnt2OZ9ZOe+ORJUYo1oPmbdjLnYSFhdoEpXtCAdttex0xWLjh3YS2+hzZSfuczGS3QNlq6PN750hiBI+8wVs8a/WMhQdish7ddj9zmR5cTowEv7ot/ZO3yQUoOd3L0hF9qEwBA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Fri, 2 Sep
 2022 21:35:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 21:35:38 +0000
Date:   Fri, 2 Sep 2022 14:35:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] hugetlb: create hugetlb_unmap_file_folio to unmap
 single file folio
Message-ID: <YxJ3JxvUnMDsHQT8@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-8-mike.kravetz@oracle.com>
 <0e31f9da-5953-2f44-1a59-888e3313e919@huawei.com>
 <Yw0/w0u+4qBHyy5u@monkey>
 <304a6d9a-9029-8ee8-7205-d0ef4a5403bd@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304a6d9a-9029-8ee8-7205-d0ef4a5403bd@huawei.com>
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3946a0-957b-4c80-4158-08da8d2b1380
X-MS-TrafficTypeDiagnostic: DM4PR10MB6086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65YqEQaUSWVyWV/YJHLIF0Zu+2MKUb6W4PWV56/ItcF9eF0aY9H8YP2KIvwmqLLu4gxePwLMF1wQMHZdBk/eJtWii1lX+H5hKtjqwV9BTt1FLiCXm2sEGODLXnhTGG2XAqwfPCvh5qKLFRPkLL4SUn4v6NbcL2JlTOGBdIEotVAdgWzmAXWPBTRi4ftTMKFf4a1LPigp9LFvcfPW9VgazEL7DcoWjeQhuygWWnPOti9t3/WNU168w9oXX7gQcj6xbxYbBNZ2etaCOSd+POc6cD2l7VAqYVXwOQP+j9geMAbCncY6j/DNftUu/GMSbUgFPrKx3Ff2raTzaqJvKga5DD39dxJRKShez+uOmXTxiGvoKBIvqqwTr9iTA7xF/5pUUc4HpxWtPt+ka4haDw7bqAalHuu+gNqbwILq11cBLtlLgeA6dyJksjiI/pB6nZEPW7gOV1ZO9h5F1Mdv931wZeuxgDGPDWMAtHpxDemWDC0bZTSyznXQMk1wP6b+EedNt9iYxkI8uhjun6h3dDpBgCmEINWpDFUylj0o6LfG3/hqBhyM/k/V4RosAJKczJnMD4y5kmcdrUtavJNQms8LCcj1DjkY0mcDGwQbNOPrmNVshGQooW87Fp71SpGCKNafqPPcj3EUU9RpBewc8S93h0PMkgUj2wWKWH8G0ji6KaClPD8A71h5cRUUOl7GBKdyM5Y1qyj+rXnlc4dNICUjVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(136003)(366004)(346002)(83380400001)(8936002)(8676002)(4326008)(478600001)(66476007)(316002)(54906003)(33716001)(66946007)(6916009)(6486002)(7416002)(44832011)(66556008)(5660300002)(2906002)(86362001)(38100700002)(6506007)(41300700001)(53546011)(26005)(6512007)(6666004)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nigEkyoMfosqFr/ldNDoiuy7ZE7CUzkX17Sz6Gh7GCQWUZzNECQnBHvpNlQG?=
 =?us-ascii?Q?3hPvws5bHHpRYj3myCZyfHj+vG/QPQ0xmzl1+ub4vS3N5Bc/yUyGY2RBD+op?=
 =?us-ascii?Q?Cshe4nV7p4AcjSM0UjdlwfUNPqyU39HZKM/WuyT3Ht39fShyHMJ/tCCE1KIc?=
 =?us-ascii?Q?LJwYWpd/yUKzaRDWM/4Dmir6M2G8CRHhJCyQs3KF7ZWPs5YZYf4GE6yxqbim?=
 =?us-ascii?Q?dECceG7aZg5j3e/tdey+nDcDBqVamkFK2mefbN+iJdG+osY+YEyNflzzkRWB?=
 =?us-ascii?Q?/fukdkPBFFqu+VS3B3ql/qHzvFdxcUck9H8tUU/fU3mmlbxpcyhsgT4K9Vq0?=
 =?us-ascii?Q?uL6UIcbiFti6Drzm+wuXQYlqCdbTtl84PJ45jWHuuqGe4YceDniyHrmMJgQt?=
 =?us-ascii?Q?KJIBiRBKZHSXtUqSbKHbshrFFYU23ls6zeApJWhvgwGoINfr/HhNhv+/IRy0?=
 =?us-ascii?Q?Jg1hiG6JYW6jYus+/eggJh+Yzruye4X3In4IoeNU46AVL8rwC83ODcqnk3kQ?=
 =?us-ascii?Q?XAc0NImHmneX/LpKvmPgk/R5w6O2pnks1Bphfy9KIxUW6vx6Fx3FLj+gOeF9?=
 =?us-ascii?Q?8VkTn1z9/k2ZrsOF2dYxK+RXd8etOigf3XZ3ktnXLzQ0KFEVodKM/sAlrzRr?=
 =?us-ascii?Q?NHegXzkffsv+q6nUUnF+/jizYRbEmIWphCqgDZFfWVwjF0fEil3vmHFakLGA?=
 =?us-ascii?Q?fhIGtcxUgsBLEAnGKYeFKOcAssRGkbrT4Jgxb7/9Z0+JxeLWHBVmU89TOoMU?=
 =?us-ascii?Q?WFIUSi62O8DlLjF4C9VP1e2EOmaw2Ubinx/5Bm0XBjfKxYItzqGhEdCcTay4?=
 =?us-ascii?Q?RWLywTu0igEZCO3y/ieVopprxrRZyWewhqWDKHlDtLUQ8E87qbCMepfR92o3?=
 =?us-ascii?Q?u5ZBkTTU5RxuuWHYDDa5hnc72otUAQTHfLJP/bEiOb+l9xMDRGrCKnkkL+1H?=
 =?us-ascii?Q?/yleN3N/Ha24BTOYtuBQ2iubc93Hf+5MRQaS/59pesHR+u3gfvDMhiQp4y4E?=
 =?us-ascii?Q?WkJJhzLdkeP49qebt3I52TtoyZWKGUdsH+vmRyVLM6IUJLszIgLoBFT/JWdU?=
 =?us-ascii?Q?5g/eXzKAcKPA7ndZec2XZrW4wxDGYKxxed9xJZqUf1nGTTGA/obx+P1wkzWT?=
 =?us-ascii?Q?BJ6tT2am9c8L48d2K6w68LR1/4n7CKUDhXYQAgZ1zOGPYG/e7SmccN83Ilbt?=
 =?us-ascii?Q?8XA7xPRWF+5vRsCokYx0lCinhvvBHN6hK1DnejCkaTXhASxyLXViTjVQRh9n?=
 =?us-ascii?Q?aL6b0svoX7OsaScPxvlXB/HTVntsTiuAKuuou5MnmNmjyOLJXIfx5Rsg+KOY?=
 =?us-ascii?Q?IX+iPuEJ1KKt2tvas/iTK9G25xn/fTz9JKQDaQzE+WAPZUghlSmDz48PJHE0?=
 =?us-ascii?Q?vbKKP9lUTb0jrIsTdp6jJhuNjaS5bbCxXqlKwwlYnTAiZpyGvgyZMo+xaPC1?=
 =?us-ascii?Q?ZMO2i8LXRkJZOzF9UVDAVgMQ4mKrj4kLddPXF1fvmPo0djvmwxrP4PNJryTf?=
 =?us-ascii?Q?ePFxcm414Qdl/avpsYPl4A2HoP8lmrRQq5OavDIPMuwVPzvYIJZyUO2fHeJW?=
 =?us-ascii?Q?PChJfVI9x7nERJf9wHv9yrlQzEk+SFPb8Ao5v5pgiWIW8p9RZ7fvB5Ya9GE4?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3946a0-957b-4c80-4158-08da8d2b1380
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 21:35:38.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqkg3NAAPTP9ci2F+NWhbDaABk86C8arq72Awog+Y3fXzDicmJhJ/BhY95jvC2mr9hxDDWmF8AM6+aNUogEM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020095
X-Proofpoint-ORIG-GUID: 8E6wBsUkXSn1U_4EmeEzi2FCSN3T3uy3
X-Proofpoint-GUID: 8E6wBsUkXSn1U_4EmeEzi2FCSN3T3uy3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 10:46, Miaohe Lin wrote:
> On 2022/8/30 6:37, Mike Kravetz wrote:
> > On 08/29/22 10:44, Miaohe Lin wrote:
> >> On 2022/8/25 1:57, Mike Kravetz wrote:
> >>> Create the new routine hugetlb_unmap_file_folio that will unmap a single
> >>> file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
> >>> modified to do locking within the routine itself and check whether the
> >>> page is mapped within a specific vma before unmapping.
> >>>
> >>> This refactoring will be put to use and expanded upon in a subsequent
> >>> patch adding vma specific locking.
> >>>
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> ---
> >>>  fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
> >>>  1 file changed, 94 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >>> index e83fd31671b3..b93d131b0cb5 100644
> >>> --- a/fs/hugetlbfs/inode.c
> >>> +++ b/fs/hugetlbfs/inode.c
> >>> @@ -371,6 +371,94 @@ static void hugetlb_delete_from_page_cache(struct page *page)
> >>>  	delete_from_page_cache(page);
> >>>  }
> >>>  
> >>> +/*
> >>> + * Called with i_mmap_rwsem held for inode based vma maps.  This makes
> >>> + * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
> >>> + * mutex for the page in the mapping.  So, we can not race with page being
> >>> + * faulted into the vma.
> >>> + */
> >>> +static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> >>> +				unsigned long addr, struct page *page)
> >>> +{
> >>> +	pte_t *ptep, pte;
> >>> +
> >>> +	ptep = huge_pte_offset(vma->vm_mm, addr,
> >>> +			huge_page_size(hstate_vma(vma)));
> >>> +
> >>> +	if (!ptep)
> >>> +		return false;
> >>> +
> >>> +	pte = huge_ptep_get(ptep);
> >>> +	if (huge_pte_none(pte) || !pte_present(pte))
> >>> +		return false;
> >>> +
> >>> +	if (pte_page(pte) == page)
> >>> +		return true;
> >>
> >> I'm thinking whether pte entry could change after we check it since huge_pte_lock is not held here.
> >> But I think holding i_mmap_rwsem in writelock mode should give us such a guarantee, e.g. migration
> >> entry is changed back to huge pte entry while holding i_mmap_rwsem in readlock mode.
> >> Or am I miss something?
> > 
> > Let me think about this.  I do not think it is possible, but you ask good
> > questions.
> > 
> > Do note that this is the same locking sequence used at the beginning of the
> > page fault code where the decision to call hugetlb_no_page() is made.
> 
> Yes, hugetlb_fault() can tolerate the stale pte entry because pte entry will be re-checked later under the page table lock.
> However if we see a stale pte entry here, the page might be leftover after truncated and thus break truncation? But I'm not
> sure whether this will occur. Maybe the i_mmap_rwsem writelock and hugetlb_fault_mutex can prevent this issue.
> 

I looked at this some more.  Just to be clear, we only need to worry
about modifications of pte_page().  Racing with other pte modifications
such as accessed, or protection changes is acceptable.

Of course, the fault mutex prevents faults from happening.  i_mmap_rwsem
protects against unmap and truncation operations as well as migration as
you noted above.  I believe the only other place where we update pte_page()
is when copying page table such as during fork.  However, with commit
bcd51a3c679d "Lazy page table copies in fork()" we are going to skip
copying for files and rely on page faults to populate the tables.

I believe we are safe from races with just the fault mutex and i_mmap_rwsem.
-- 
Mike Kravetz
