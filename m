Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F65A572F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH2Wi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2WiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:38:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9AF9DB63
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:38:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TME77T026007;
        Mon, 29 Aug 2022 22:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=p1/5mG2sATC4DNP3i+SzHrjuT3c/ydMezTOBzE3nE5A=;
 b=kTZB4C8PdgOxqPsk3TEbRMMW3FAPsNVLMEbPMMK/gcn1VfY+AB7FNa9U2dLpJwv2wu6g
 ncioqhe2+bbGvNlNQJcO8C1vKjkuBy2jvZgSk1IdOu+5gloy1E/H2+TPsw9X0UDhCdL7
 DU+etz3Zl8agzpgT44XdzKA6RWKPGkcp7jMOCldrtMCxNjQ0LRCj2Rp6yTG4owlARDce
 V2bhJrqcMSJZ4p2/F9aQDj/r4fVhanPCWQsz9ah9kz/p1Tfyxvvlj9dhXNhOCWiazrj+
 qR76nC+MSCM9/AO3qmjF01gFMBkZ1hMtI8ZvtCwxHCdTuxS5FeNMbWEDyE8Gb69wg6EJ 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59vpad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 22:38:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMPwBq017997;
        Mon, 29 Aug 2022 22:38:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3ansy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 22:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq/9arLmxJ9gRweIwJjXteo6TsZzUk1AG3Vxo+vT9MZJMCBteh51FTKQPGMqlpj3iAxUfq06IKqo98TAhjTdWcZSRINRXN9e5vLvn75STen9IMpRlZhinFXpG4EQQNHGE6CMGQLc0PjRE63a6Z6xnL0VMxRczmMJuqpCz2QdZxBpuBegRfoByridTO75LHIeeIQIRCKi1gtpLemuHLIo3o4MTt0Jvn3zoXRDO4dBT0qfBvyehvbtUWerhcC0c/WTZvMEo6v7PxqE4VwQ7IPjTcCV5IrSHHpP9O00EdHV3OR2iWBp6cCxt9Tcupy3Cvft6N5a1W9eyM6SP9MG12fTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1/5mG2sATC4DNP3i+SzHrjuT3c/ydMezTOBzE3nE5A=;
 b=LM8LSO0PlbNQ0n1LsNxN7jzab7eFDfj/U96Uwhv+nz0gGhHWf+vX+DpTNRvwpt2lfkbOaxsyGruHTOmrlJf6cawUeACO45IS+MGftxoaKGtzOYyN1bfAXzmZlJK+nl82mfqBDOp3dM0iSy7keYU/VQe+O8AR8HBfE1obPfIRrEC9af0A/RpNHriJRr8x4VBpOd9qScHJYFJEXtmNfc9pd0jE61JQG+dRQLg++s0SkYYWDYWI2WZPgzOvQhWMtZn09Xo1DQ74eFcU86nq9N36jIeKvhz4O2SGIiRaqbw8Y6cN3H3ycbaDU/9C0nEwRlhYEbpwJDkoVk7D6cRG66tg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1/5mG2sATC4DNP3i+SzHrjuT3c/ydMezTOBzE3nE5A=;
 b=hgWxlzHcqnSz01A40MDwkjyD2w1Q/hwOER/MCDJ91mCBiVRSQiv44W/+qzPmqwFDrFhZdq+hZphCyoJijqc+Z6AD+ZmmSydkSf+7wygYNPq0kHT/Q+JjJGeR4QNokmUH8txxBuEB0GtJNhLtGktvOtef3AfRZtEwS6l4P/38950=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4466.namprd10.prod.outlook.com (2603:10b6:303:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 22:37:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 22:37:57 +0000
Date:   Mon, 29 Aug 2022 15:37:55 -0700
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
Message-ID: <Yw0/w0u+4qBHyy5u@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-8-mike.kravetz@oracle.com>
 <0e31f9da-5953-2f44-1a59-888e3313e919@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e31f9da-5953-2f44-1a59-888e3313e919@huawei.com>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762cac8e-1c5b-4d06-dd67-08da8a0f1f1b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rtc2fqHiOgpqTX729vrw2bOmtoqcpU3YyZ6w5+qZgPTMyyPJac/QYqaNoqGb9cHJO1cSqJfE1YbMVbpt+Gjcsk8sbF4Jl/Gs+6mpAi7tSSLZ67TB+RcEdXQV12+vLrAc9hnakc9IcMz0SH/NknNdm0SgzN99o4JXhV0UfhCLwbm+URxG6BtOtqmmlbDuj1znrxmqbePBy0iakShDjhR4cYc6KoGPMel0uIp4QmSXVhk//1YzmNIYiIrIx6Y+9fwh92QmYp68K/dvrCkJeU0pgZDcaOJ9K5o3H9zNIimzDT5quqENlkLBfSKZIacdYHs2IpyUnx0P+sXOBFmlG/4TKBwmyBOxtRPcfTBJuipgBNNQWxkw00tZihGtF/U+0qytcbrT0xGCUEUfU5NAPOyqzbzdERBBx/y9SoWKI1cPpCsYMX60Xiu2NPEsh0e1Oy70lVM2xcRABSCqiN58u9BCeGnABlbDCnVj3KssfvTeL1+3rdkcuWvthCNUXOxf8JNF4fmQ5UdBx3JWi672t/fVrwaN/ti9rMjvgOsS/Zsdc1A9qNq4ZFL8Py6EV5fC4B26GaW8XMcHtpWHj7ggkmP0M3Hdw9Ch41+RkFYpnUGnwd30NZZrk2/BISggveY19QcYxflfKRmiD0E5x3vGmAUaA0qmeGYUZBt3+Wf3z6Xzhm9QU2OY5D/8TCMrhQr7XmSd/PJ1+pdEH7FS6kxgWNuXWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(396003)(376002)(366004)(86362001)(38100700002)(316002)(6916009)(54906003)(186003)(66556008)(66476007)(4326008)(8676002)(5660300002)(7416002)(66946007)(478600001)(83380400001)(6486002)(53546011)(6506007)(26005)(6512007)(9686003)(2906002)(33716001)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+SQc98D92F7ghiga1/x6ZsyhMq5xd2J6o+zGNuGCF0fcDrDfvMeIJR1NGki?=
 =?us-ascii?Q?hoeubVxxZ941HNBTT87Z6STE418QimmsHCQDoJ4OFHVPNKWkJgER2MASfdPM?=
 =?us-ascii?Q?j6Dui6r1zmxq8uFrGf6HcHnyaLlZIPH/Sl3OHsGHopgB8sdoSLw1HBTApJQX?=
 =?us-ascii?Q?QYyYzxkLdROL9nC/sDDCmhQsqJlJu/JG5mCaKgEuVhl/gC2j9u7Vxx93hTDI?=
 =?us-ascii?Q?WA2eVrVzFrOfU6pnAq/osPVtLCgxJr4s3Y8/5D0VI1YFIc8Fa6Kpqiz66I/q?=
 =?us-ascii?Q?1ziT9wEAf/pL3W5X9TRZESGnkJgB8llLFJl6Jf0/jkWkzxTIDDoiqagLf4dF?=
 =?us-ascii?Q?A3pEywbgzPlxr+/ZZCCNWWdeQen/J+xkdlc6yqtb0nrPVkYXhEcMdkbZ5Itg?=
 =?us-ascii?Q?Tii/vEDSzYPaEnqDJpdvX0ZXNBVrSDsy2cDj2UFtL6v0PKPka/UgZ6hUbnk8?=
 =?us-ascii?Q?FYCujuFTvRdwHqfPN6wktO7PGp6eRX104x3CoAi/Xw4010m0utlGZqzlLncX?=
 =?us-ascii?Q?dBs9yh8FuO8iAPhv3QvTQPAUrfj5Yt8V7d4mvsu/RuX936/4QxkeiUfeqX6j?=
 =?us-ascii?Q?kutLNoZF03FPaZUVKirXRmZ4qUnOvAwwrArs4S2MXvu7NYRgVE6hGRcEC5ct?=
 =?us-ascii?Q?yvccjYoqnU7c/n207ri4NcmOXwJw2A5ns6oJERqFO1ZVpaSQIfn6ManxdJjX?=
 =?us-ascii?Q?2N+D2vew5lqrD9QuIdxrQfs1POvhaeYdzW0LAOCkqW/+74T4mRB3ZH62dC62?=
 =?us-ascii?Q?D95dnWR7f0WeidrxGjoT/Lwy9r9kPsbbKvXlRTYsVqqkP61Zg8Ww5WRhdTch?=
 =?us-ascii?Q?cS0v8Ywnns/T5Qxu0E6O7tNGI+zwQ9ec8ZYiaCY9pyPWSpePPS32sWsJnyae?=
 =?us-ascii?Q?Iv95Ec+wQ29y/gGaZCKTinffmb3YLzlGTA+yd9LDzNMOI0OloNwEpmJz29iR?=
 =?us-ascii?Q?dxmnd4MGElUW5qB/AgADaOkxDhiwC0A2B73BBTm+ET0br6ltg9myFqUXCIJU?=
 =?us-ascii?Q?GhEG5UsfdsaSdbAItdHiKZmeIIk8MfQaZVHhUxRRMVByq+lgBdTxo0n0pjFr?=
 =?us-ascii?Q?0D/eziH2gxg9nWBlV3gZv3bjTyomZD9D1ELD8n2sKSelIJqCPEDDIPLppA1O?=
 =?us-ascii?Q?xML71cc8ZAvsvtBPTsrVEFfZpIHcBsKswSA8lq7ryxJVa81UBsGr+N0FKpqc?=
 =?us-ascii?Q?TvGCBDKsHAPSNlIRdl1q1E11Idu1SCITylKmzBf8iof0gwOeKWBOp9WPoEw8?=
 =?us-ascii?Q?Ua9DsY0Bloqk8GgGDc4n5KWo8FRcVZ3xuacxFuz15jHQV6feSms4QU6jbssC?=
 =?us-ascii?Q?8RflTWP6EWED4mLvCwuh1Lv4kvyICgINAc7/qLLaUZvWlm1A2Czw6mrjRwGk?=
 =?us-ascii?Q?UUjzi5U1rgGcUL52DTFHe3hvnI03T/PC78c2c+nC8Okoc4h1E/RHMd0ltGoJ?=
 =?us-ascii?Q?r7q8e4U50KqEfKyjQXjcY7OL8CDxZRmRUPLjMPYPKnK1L3YcS3Ka+V4e83kw?=
 =?us-ascii?Q?PBrQ560g+YGfXBqzcYZlz6s0wWTaJF1m0klb7/YoVR93zT2rPyPxLIpjBpFk?=
 =?us-ascii?Q?EOlml73tNbE9PXssBD2zQ6lEmHtgv+cns0ymxWjo7JtCR8EG2kAohkfefbij?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762cac8e-1c5b-4d06-dd67-08da8a0f1f1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 22:37:57.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KaRp9gwjQq2MSUvZETSMbb3hbbEGxXeRgWf4zFfevrZNzorAFtDeDVytEEIsNw6FSxRgp3DJKzeN6oorAFSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290099
X-Proofpoint-ORIG-GUID: 9LuCEKEA1xM4KNGoP8pMpk8oPkmpAOU5
X-Proofpoint-GUID: 9LuCEKEA1xM4KNGoP8pMpk8oPkmpAOU5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 10:44, Miaohe Lin wrote:
> On 2022/8/25 1:57, Mike Kravetz wrote:
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
> >  fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 94 insertions(+), 29 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index e83fd31671b3..b93d131b0cb5 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -371,6 +371,94 @@ static void hugetlb_delete_from_page_cache(struct page *page)
> >  	delete_from_page_cache(page);
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
> 
> I'm thinking whether pte entry could change after we check it since huge_pte_lock is not held here.
> But I think holding i_mmap_rwsem in writelock mode should give us such a guarantee, e.g. migration
> entry is changed back to huge pte entry while holding i_mmap_rwsem in readlock mode.
> Or am I miss something?

Let me think about this.  I do not think it is possible, but you ask good
questions.

Do note that this is the same locking sequence used at the beginning of the
page fault code where the decision to call hugetlb_no_page() is made.

> 
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Can vma_offset_start/vma_offset_end overflow on 32-bit arches?
> > + * No, because the interval tree returns us only those vmas
> > + * which overlap the truncated area starting at pgoff,
> > + * and no vma on a 32-bit arch can span beyond the 4GB.
> > + */
> > +static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
> > +{
> > +	if (vma->vm_pgoff < start)
> > +		return (start - vma->vm_pgoff) << PAGE_SHIFT;
> > +	else
> > +		return 0;
> > +}
> > +
> > +static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
> > +{
> > +	unsigned long t_end;
> > +
> > +	if (!end)
> > +		return vma->vm_end;
> > +
> > +	t_end = ((end - vma->vm_pgoff) << PAGE_SHIFT) + vma->vm_start;
> > +	if (t_end > vma->vm_end)
> > +		t_end = vma->vm_end;
> > +	return t_end;
> > +}
> > +
> > +/*
> > + * Called with hugetlb fault mutex held.  Therefore, no more mappings to
> > + * this folio can be created while executing the routine.
> > + */
> > +static void hugetlb_unmap_file_folio(struct hstate *h,
> > +					struct address_space *mapping,
> > +					struct folio *folio, pgoff_t index)
> > +{
> > +	struct rb_root_cached *root = &mapping->i_mmap;
> > +	struct page *page = &folio->page;
> > +	struct vm_area_struct *vma;
> > +	unsigned long v_start;
> > +	unsigned long v_end;
> > +	pgoff_t start, end;
> > +
> > +	start = index * pages_per_huge_page(h);
> > +	end = ((index + 1) * pages_per_huge_page(h));
> 
> It seems the outer parentheses is unneeded?

Correct.  Thanks.
-- 
Mike Kravetz

> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> Miaohe Lin
