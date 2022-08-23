Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E576F59F007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiHWXzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiHWXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:55:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DCD8B9AC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:55:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NLE7lZ021877;
        Tue, 23 Aug 2022 23:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3MaqWG5gVRQ5pyiXsfTlK82WDC42aHn2EQ2M6HUj3XY=;
 b=P9o0ajthBVW6+a+vg+6uhAZ5RBpYiz2hB2FZNX4qGj80BqjEoQ9ldJB28+jbj9nc8o0s
 s5NAK4p+66i/0Hjtsy7HMgkGB0jp92/cYCcCQHuVQjoKN3iZFUtWkpentCaHx5aa5Zwd
 SRidCQAWyhhNeBfSju6hNeP7A8mDLWcC6rGNOABM+phtx8n3/Omj8MC2v1JGe7g0zq+7
 kRYxE1tPogzLlGChFdOGMt+GqPl+xerShtBhEbpl8lltQ5H/BnHvUYmaBQ23Z4M1ERTJ
 But4BN+tu9pivlUdJn8sdofqU5BU6T8nZ72NznfTOqwkEq7XZVRpHF1kSRXmZXj+deKH 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25j10w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 23:55:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27NKHT0S018242;
        Tue, 23 Aug 2022 23:55:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjf1bth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 23:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCcUc9kqKVovVqKIe5/8Tbg6nJvXipRQRaZjGerdwgG2RWKApygvLxn1JhNEIXNpsXaIZ41hL9bChHHZslcsdjcVJN1Yk0wVRUcV6/prZccekfJ1Qz+vcof8F8CD3Jind7fo0O6yaOXOg1obL+iLbEqqjYfx6n6bILjpw+AU/z/IC1lm3YQcKZB0o2unPCvR9G74YaIGe9KVH2JYd4DFkJDRTarY8LPcgQpRHgvi0HvD8lBUsXfsCrqYgk1iwnkDF4PAvvfVmKbvK/SVdGUNWWWpd0cqsxiNUq+2qnB+o7/a/UmhiZuoGnXKpBAsYaYODH41ISg5zkkxLcW1FnhDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MaqWG5gVRQ5pyiXsfTlK82WDC42aHn2EQ2M6HUj3XY=;
 b=CGaAOCbl8sWPiIUsP1PGyijKNsQJvk0k5D/pZ3PGwGoyax0BIuEXyfK5C158K3/NuIfBuyn/HlJuqAiNVRqxc0tmCw9NJNA0KCtXHBgRokSninyMovDGw7SyJWozrNoZMIhrX4AeQHIXbeh546QZSBRrwOWm504V/NIjwL9WMfhQtsru+CUy0L2V/TRsZieERRbsVTayBzw8cLrT+CpifkQiM+QQw+/AiS+s4RU6KaxEdB3cJjlNXzridmIHYde+ePBkCuCNr/Qkf+OoXRufq1E3rEg6ghfZpMEcBD9iloZ5ONl9q6Sr429p9uLnIjRKV3Wnbj4ZAGpeKLtDLpvQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MaqWG5gVRQ5pyiXsfTlK82WDC42aHn2EQ2M6HUj3XY=;
 b=MP2pess6+dynX/FKKQZLUljDD3NN+NyvFb+FodOYwjhmrXmTr5hH6QmJKKnJjAAkbXPaANT7UpZC7WhXrV8Wo5dkf+MRcBcdSVU/B18HI5xrJw5swyj8ypK6wjKNpKw21VwwgWp2ieu/bx9R8rryzsxy+vnCPuFqxPXkSDVqfUM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR1001MB2370.namprd10.prod.outlook.com (2603:10b6:405:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 23:55:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 23:55:31 +0000
Date:   Tue, 23 Aug 2022 16:55:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <YwVo7xSO+VebkIfQ@monkey>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec36c4d2-a3c0-49fa-216f-08da8562f626
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2370:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iy24rB0n3n7fhxQshmPf+CFZVxAeeib8X3f5w34YSvQtZMpeIsuM/h4zNqFE+KTJLdyN2ukauRDsAEyJm8joX2p5nAAIexn0OxcWVNYUpnmqTkGTXbOS8FmJmCd432xLVFjDkDOxPaaCMI+9f4O7ZdXO0nRKGVpKoURWIuJE0eYl6UuLSP905T44lsSmE002mkNGoJCUbN8cJP+Y2sRnHL/wU4S4PaX7UYgHnC9JH0EGaIRNTD9G30nWosU3OcZ8jgJfIb3LXtsKDDkXHhr1dMxOkDx3KRAQHNH7Ysv30or3Mrm/Lc2CP6jNTsmY9WFYqeX8TEgTUYXUCNXWOU6gOM2vrO68tc7271ZYrxgySHJlgl71XPDHi3dEOQtp455R3NkfCKIFpis0Y1ilrmky9gZBseo+Nk4cPva1lzDVPVrKw7qSyZWiKs4MOxpMAHSrqN6Db5G4dW3Oe2PXQXak1MeEd+XWTy8Y4ZbplmHznjE9EfQXThTiSD4WmCxnhN/wLKCj10pIvk9F79or6Bjw6dZa8EyKdTKYZVGB7vppbZpWaMPgwLMVVIc4AaSqf/il2wTnxSXx4ThS2bvXR6nadqHHdPtikqDwMN1VV6uXuKzAWeK9CIcXRaNKG2XOj9mJEcxx/B5sEL9bsAwcO5L16TIwIzuVQVYRTV9PcUo/IrJRypOKBw0F7cDjFdXMPcSl4WFqTq6V9m0TK6iP33WdtDH4G+PYn+sxDfEtxPx+pWl1FDHuoxrBpJF9rAAgNx0+x2oLHfzo+Loy3SMZ8/7krQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(66946007)(44832011)(8676002)(66476007)(4326008)(66556008)(86362001)(38100700002)(6512007)(53546011)(6506007)(9686003)(6916009)(6666004)(478600001)(6486002)(316002)(8936002)(186003)(5660300002)(2906002)(33716001)(83380400001)(41300700001)(26005)(21314003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4u4Zb6FjV21hCeOLp8NOV9mW+r34VdlXls4cBLB/w1kGmchz6X4+dKvRuqta?=
 =?us-ascii?Q?seQ7jnpkuoyD6k/CyGz+eEXA74uzbhwc/ueMuluAHDceImjC1UAJ7ZBnZkgN?=
 =?us-ascii?Q?rq8lO+HbbT4mMgV1i/uYlF9OcTrZWYVGYHtwuDF1gwptGktQQzbrfh6l77Qd?=
 =?us-ascii?Q?WivSt/olbwrjT85qKA+u4VuNeuf/Xd2UpuQ9q0Cmwg4gkpA7V6+mdFE9catQ?=
 =?us-ascii?Q?/8fkX1FIUOPnR/oZ/mz/bbvqNRU13gRFLwR6J8Dax9po6X9u1A2W75A1BHT5?=
 =?us-ascii?Q?jJYjOOZ3UmpLcztKV2eaTr6zaQYkgxbFz3s4PIY6Es5BBNF5TVDv4RhHAR93?=
 =?us-ascii?Q?jH0YrQmvwzPFOy8+OSy2FNN4bf1E9g687ttOjJTdN00aQ5ikzdlgg9XIcvMN?=
 =?us-ascii?Q?WK9SkH0M5GR+CAvg7pjYqU1J61NXQM0v2dRpZlGPOLuc9UCyi81344wJeWuU?=
 =?us-ascii?Q?BXZ5aW80JWDiO7SrmXIVg+pPm9BtlWjsirg2Ml/ISuewO0CIDNfPkhb5yw7R?=
 =?us-ascii?Q?i+Zvm+AbFS7Z2bAgqovCjlGh0PhGUtFhi2SREvDiHzSBYqhUyA5yaNADLILi?=
 =?us-ascii?Q?DYqOavpwgcZi59MDNn36yh8SP41Ab70zMSSM0DoUwj13Ov54NtgbijNhKQjw?=
 =?us-ascii?Q?Vc4ptVwnq86F7PnPNZD/b/1n0eX43I0t9qebm672ZY9UZbHdDrmuwghEuScA?=
 =?us-ascii?Q?DqF609MtypL8aHmLU0HkcuUuCq9KadPSEH+I6LeddQtb7b3ZbJhMDWuxFYc5?=
 =?us-ascii?Q?lIBlcUlRN12tLtCxVMMEYlSzFX+DvnHOgLNBxliG6wdEdjLd5o0jdZ8+IEBX?=
 =?us-ascii?Q?bjgpFciSoudzTOp1luhyzDD5J9fGhvkbiLCQE4WbXmzUMPwJD+mmczsWsTm6?=
 =?us-ascii?Q?jOLhX5PSZMgGXrx6HeGuEVBGYgRrR0wkr8t6ypMUasRyh/RoOoPaEy7ZsDte?=
 =?us-ascii?Q?j7qDdHPVCZR4d8ukXzJHxtfCctEaM/BVqy3QpCHTB2Z0Rpdv1eMdCryOW3/s?=
 =?us-ascii?Q?tHJAdhQLPplw/Gjfhp7K9M55MaOyGhHLl/eAi9f5uQDlMsOFrjhfj0Neujah?=
 =?us-ascii?Q?kVpecvFCO58ivOWzfRAx9n/Br3M/w1Er29+zhS6kaGiizNE3sW5i9nT+BjKV?=
 =?us-ascii?Q?xyC6guoO187F+otnyWCa1n96WXbrFR/mJSN9r8rvOrxy4y7TLgsXc2LqC3lW?=
 =?us-ascii?Q?8VIAMS8Ka5LELb8Unl7qs9+T1Hf/xHVwgZOldqAuo9aIBi4a53A5ifWPBZuk?=
 =?us-ascii?Q?S+iwR7G8eTToUWIA20i8VVZd0SYDT006Ifdn8+1Ax6LZP4fkTclPf2CFABiD?=
 =?us-ascii?Q?dithgTluMFw4lyPZCurq/wjKar3CtrAISGRXJwXgcE3lLcLGLjwKDEAgj5ew?=
 =?us-ascii?Q?vqgPbOf1cWvyzhGVJ0ZhbYe6nUPKdGhE6BMk3IuuQp0Fcqp16ULvR71A/yi9?=
 =?us-ascii?Q?kLbimSZDXbTm/f/DLXjkQG96lB1ji2svysjzLa14J9O66kGkV478Rp8/Ce5H?=
 =?us-ascii?Q?qKg0TCyJildV1uknzeNMVwVJwSVVjdzs2sS5vQrN5NSjjJI8kCN1gicpTlNd?=
 =?us-ascii?Q?XchJme8TJoRUKwzlqhUf6tSorFPAhh3ejjEC7qDWZkgtI4Qxv1wM4hxviHur?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec36c4d2-a3c0-49fa-216f-08da8562f626
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 23:55:31.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfUsmbrmSQ3Yck6p+SLOhl+BDKvGCuxo9IyHQZMPE1GPMBvljQ4xZe3eyljeCdWl4uVJxXd/FPSesHixID33GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230089
X-Proofpoint-ORIG-GUID: d7HCALEkNQqVSVbrNnjBi5tVtoeVnUVB
X-Proofpoint-GUID: d7HCALEkNQqVSVbrNnjBi5tVtoeVnUVB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/22 12:23, David Hildenbrand wrote:
> On 23.08.22 12:02, Baolin Wang wrote:
> > 
> > 
> > On 8/23/2022 4:29 PM, David Hildenbrand wrote:
> >> On 23.08.22 09:50, Baolin Wang wrote:
> >>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> >>> hugetlb, which means it can support not only PMD/PUD size hugetlb
> >>> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
> >>> specified.
> >>>
> >>> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
> >>> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
> >>> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
> >>> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
> >>> get the correct lock, which is mm->page_table_lock.
> >>>
> >>> That means the pte entry of the CONT-PTE size hugetlb under current
> >>> pte lock is unstable in follow_page_pte(), we can continue to migrate
> >>> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
> >>> some potential race issues, and following pte_xxx() validation is also
> >>> unstable in follow_page_pte(), even though they are under the 'pte lock'.
> >>>
> >>> Moreover we should use huge_ptep_get() to get the pte entry value of
> >>> the CONT-PTE size hugetlb, which already takes into account the subpages'
> >>> dirty or young bits in case we missed the dirty or young state of the
> >>> CONT-PTE size hugetlb.
> >>>
> >>> To fix above issues, introducing a new helper follow_huge_pte() to look
> >>> up a CONT-PTE size hugetlb page, which uses huge_pte_lock() to get the
> >>> correct pte entry lock to make the pte entry stable, as well as
> >>> supporting non-present pte handling.
> >>>
> >>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>> ---
> >>>   include/linux/hugetlb.h |  8 ++++++++
> >>>   mm/gup.c                | 11 ++++++++++
> >>>   mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>   3 files changed, 72 insertions(+)
> >>>
> >>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >>> index 3ec981a..d491138 100644
> >>> --- a/include/linux/hugetlb.h
> >>> +++ b/include/linux/hugetlb.h
> >>> @@ -207,6 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
> >>>   struct page *follow_huge_pd(struct vm_area_struct *vma,
> >>>   			    unsigned long address, hugepd_t hpd,
> >>>   			    int flags, int pdshift);
> >>> +struct page *follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
> >>> +			     pmd_t *pmd, int flags);
> >>>   struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> >>>   				pmd_t *pmd, int flags);
> >>>   struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
> >>> @@ -312,6 +314,12 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
> >>>   	return NULL;
> >>>   }
> >>>   
> >>> +static inline struct page *follow_huge_pte(struct vm_area_struct *vma,
> >>> +				unsigned long address, pmd_t *pmd, int flags)
> >>> +{
> >>> +	return NULL;
> >>> +}
> >>> +
> >>>   static inline struct page *follow_huge_pmd(struct mm_struct *mm,
> >>>   				unsigned long address, pmd_t *pmd, int flags)
> >>>   {
> >>> diff --git a/mm/gup.c b/mm/gup.c
> >>> index 3b656b7..87a94f5 100644
> >>> --- a/mm/gup.c
> >>> +++ b/mm/gup.c
> >>> @@ -534,6 +534,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
> >>>   	if (unlikely(pmd_bad(*pmd)))
> >>>   		return no_page_table(vma, flags);
> >>>   
> >>> +	/*
> >>> +	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
> >>> +	 * ARM64 architecture.
> >>> +	 */
> >>> +	if (is_vm_hugetlb_page(vma)) {
> >>> +		page = follow_huge_pte(vma, address, pmd, flags);
> >>> +		if (page)
> >>> +			return page;
> >>> +		return no_page_table(vma, flags);
> >>> +	}
> >>> +
> >>>   	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
> >>>   	pte = *ptep;
> >>>   	if (!pte_present(pte)) {
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index 6c00ba1..cf742d1 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -6981,6 +6981,59 @@ struct page * __weak
> >>>   	return NULL;
> >>>   }
> >>>   
> >>> +/* Support looking up a CONT-PTE size hugetlb page. */
> >>> +struct page * __weak
> >>> +follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
> >>> +		pmd_t *pmd, int flags)
> >>> +{
> >>> +	struct mm_struct *mm = vma->vm_mm;
> >>> +	struct hstate *hstate = hstate_vma(vma);
> >>> +	unsigned long size = huge_page_size(hstate);
> >>> +	struct page *page = NULL;
> >>> +	spinlock_t *ptl;
> >>> +	pte_t *ptep, pte;
> >>> +
> >>> +	/*
> >>> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> >>> +	 * follow_hugetlb_page().
> >>> +	 */
> >>> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> >>> +		return NULL;
> >>> +
> >>> +	ptep = huge_pte_offset(mm, address, size);
> >>> +	if (!ptep)
> >>> +		return NULL;
> >>> +
> >>> +retry:
> >>> +	ptl = huge_pte_lock(hstate, mm, ptep);
> >>> +	pte = huge_ptep_get(ptep);
> >>> +	if (pte_present(pte)) {
> >>> +		page = pte_page(pte);
> >>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> >>> +			page = NULL;
> >>> +			goto out;
> >>> +		}
> >>> +	} else {
> >>> +		if (!(flags & FOLL_MIGRATION)) {
> >>> +			page = NULL;
> >>> +			goto out;
> >>> +		}
> >>> +
> >>> +		if (is_hugetlb_entry_migration(pte)) {
> >>> +			spin_unlock(ptl);
> >>> +			__migration_entry_wait_huge(ptep, ptl);
> >>> +			goto retry;
> >>> +		}
> >>> +		/*
> >>> +		 * hwpoisoned entry is treated as no_page_table in
> >>> +		 * follow_page_mask().
> >>> +		 */
> >>> +	}
> >>> +out:
> >>> +	spin_unlock(ptl);
> >>> +	return page;
> >>> +}
> >>> +
> >>>   struct page * __weak
> >>>   follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> >>>   		pmd_t *pmd, int flags)
> >>
> >>
> >> Can someone explain why:
> >> * follow_page() goes via follow_page_mask() for hugetlb
> >> * __get_user_pages() goes via follow_hugetlb_page() and never via
> >>    follow_page_mask() for hugetlb?
> >>
> >> IOW, why can't we make follow_page_mask() just not handle hugetlb and
> >> route everything via follow_hugetlb_page() -- we primarily only have to
> >> teach it to not trigger faults.

I have no idea how we got into this situation, and do agree that it
makes little sense for both follow_page_mask and follow_hugetlb_page to
do page table walking differently for hugetlb pages.

I think I have noted elsewhere that all those follow_huge_p*d rotines
will look the same.  It seems they were just added as needed when the
follow_page_mask page table walking code was fleshed out.  This also
needs a cleanup.  If we eliminate hugetlb handling from follow_page_mask,
perhaps we can get rid of all these?

> > 
> > IMHO, these follow_huge_xxx() functions are arch-specified at first and 
> > were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm: 
> > hugetlb: Copy general hugetlb code from x86 to mm"), and now there are 
> > still some arch-specified follow_huge_xxx() definition, for example:
> > ia64: follow_huge_addr
> > powerpc: follow_huge_pd
> > s390: follow_huge_pud
> > 
> > What I mean is that follow_hugetlb_page() is a common and 
> > not-arch-specified function, is it suitable to change it to be 
> > arch-specified?
> > And thinking more, can we rename follow_hugetlb_page() as 
> > hugetlb_page_faultin() and simplify it to only handle the page faults of 
> > hugetlb like the faultin_page() for normal page? That means we can make 
> > sure only follow_page_mask() can handle hugetlb.
> > 

Something like that might work, but you still have two page table walkers
for hugetlb.  I like David's idea (if I understand it correctly) of
using follow_hugetlb_page for both cases.  As noted, it will need to be
taught how to not trigger faults in the follow_page_mask case.
-- 
Mike Kravetz

> 
> If follow_hugetlb_page() can be arch-independent, why do we need the
> other arch-dependent functions?
> 
> It all looks a bit weird to have two functions that walk page tables and
> are hugetlb aware.
> 
> Either this screams for a cleanup or I am missing something fundamental.
> 
> -- 
> Thanks,
> 
> David / dhildenb
