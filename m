Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5381574015
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiGMXg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGMXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:36:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105184A80B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:36:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDq0E017776;
        Wed, 13 Jul 2022 23:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5QvsnJLOAdn1qBL8uAHAPgNvzszv+x1xd9H12ThkyQs=;
 b=XJoAdEZ0OrZ4oP6odFt4GtRBcr+TeZvoeb75bnDJiC6nvnbLpgri6Fp3LA5PgWGFiLzg
 Mx8xv40KmOdEnYqykY0TBiVUsj/hjEhKDLGJrroWfHury4xpraPrGd2M2Fr3kRx88jCC
 CCeS13gfTCe+VjJHD96zvvlhHvkE+czOYVOVxX1NW1u0FLrLcZ1kReprhXXEYP1TBjZp
 RhqOmiStVvDwDsVQGWOlwaHTUwbGA71WSGzkGPXiNJXPV5YCiF9HE5wF0JM9yaMUeQ1W
 Jvz+xYnqwMoBhlZsWSzMzPTYWNhsaGXg8X53CcBM2/MVUl59cVrzo0+jNrR14KKaV53S 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgu1w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:36:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DNPPss037474;
        Wed, 13 Jul 2022 23:36:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045n2gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPWlC+0Lej3AS0UGcMjuXSQHws+jC+A5o7fyOdBvx9cE3s78mPOqJboRUOTvU3UI6Do/1mSEb/Kg+8FoJBm0J5Kea5eOQJtKgyVdY386cTNFK1XgFE8OLK/c9NYH2qtC5afoU7aEb9w+MnIQ6qeCT89kN7XMK020lH1GijtXyF4/uSe+8R33QjsNcUBXTZAfPESTQuH/d6M9zRpWYxmtFXfgdV3N2PvWjEydPl1Pp4gWclvYIlonDMhscMGuJJLcBky5UU0cmKu5nJPaBEfDerxABYgpVN/HWZb8cXaA90mqkC1u5haZ0N5RIDYSpBI6xxqKUeGS5nW562br4IYQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QvsnJLOAdn1qBL8uAHAPgNvzszv+x1xd9H12ThkyQs=;
 b=BoHsjT0OjJ5B40CCmdRR34AlmSUDXd+kO/HvXrxWZP7uriNqD+VtVQB5I0p/aTgN0+QH2gnyCDByHDRmP1xpXpKkcyzAerLhy1+oxDl/xncfLBj2/eG8cMhvlcGGyZtE1Lr97Hfz+gTT3os2h/B6fyFLnUXF8Rl7sHLmP04SdHpxI61xIntoJasC/TPbzZxpa6j/BeeTXDz7dpCHUAtrRZNbg475+dxw9ImelYYhhJU6LoPSZuSuLBlKsnaNl2/4V+zBiP3z3/Lv6PHmUqPNNXPczdkJ7kRbAjndWqVSWJBmv44BykblkvOWh15RNfHg91O4mA4u+dF7ysgyShYVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QvsnJLOAdn1qBL8uAHAPgNvzszv+x1xd9H12ThkyQs=;
 b=dmTBUc02O71goKi8gug0ZbLTi87SUcIym8tm8YqBYQNjwTRSfgmeN8XB+E3OypX7sr//BqaUijltj4mk6Dq++j+tBbOOpUDn/L7YzrnVVx6dm5Y3iKq83xMh4qEnPmM2gvbUBUl1iYDaHZUJIb6aiC0u9k2FfbtFdli79kE58Y0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6084.namprd10.prod.outlook.com (2603:10b6:510:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Wed, 13 Jul
 2022 23:36:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 23:36:36 +0000
Date:   Wed, 13 Jul 2022 16:36:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <Ys9XAbuxkDUlnmv0@monkey>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey>
 <Ys7ViSsOxLaQJIfy@xz-m1.local>
 <Ys7uXHdzzFezUub5@xz-m1.local>
 <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
X-ClientProxiedBy: MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec1f4f2-052d-4abe-f498-08da652886c3
X-MS-TrafficTypeDiagnostic: PH7PR10MB6084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iTx+WgQg2DoiPHCgFNkEvQnGQ2N1Y4D6WwUwfyCBBIM8NI57b+mDrWetd4E/pDet6fKcUc0XEK/+tRw6apHNA9WgUefqB53bzzNl2cePgaCjLql/XCn6vmnasx9XjNMpsbQ3uG+gugCgIdNKi6QxV5Ehd299WtIkvHYzuilK2o6wxiqQJ5H76se4kp4LPR7MeyWZsqE3wpyDopRQqAAGXQn6Yv7gRX+/VITPmudeHo2iGr5l86sikNPCt7s6XMghMdaTLNpF7NeYcHL153EfEGgFuU+0M3ivZt8FdGz2XAflXQwZ2l1kOMRDWALaE3pwkF1Z9wC/dB2jGRUZ5WIneE+1iMYbPLl3sTlSiEBfDW3W4Eamj+4tsyzQSHYTGbRcDT4jr0TzdLl75UP2YVfc6z7ray2ve0/P254t6Kt6GM16xgEnQRKACvoIBiaIC8V/UavMLZGLnYZAIX7ENYtgOoXh/o+FWOYKNaEeixtk5peQZmlEVC0Zxv+ycP2T0upovuCRy6fb8gURstDqEK3U4Q3gDmIpgjCo6jwEXewGf6qfx9gLiu7qx5p1+0m9/OtLlPEwdUf/9vfnbX12iljvuUYCUDWl6TiGAHPvrVvWBAtn83D070XIdc/EuOaBXDazVfkdMlXzP85OZlQt2fnzFUHf8bB2dOkSjlWasRFIMTrRDxlBAZL4U5U9uiPZRKWd0P1C/6/gN9pzhLv4m0WTuuE4DsM6T888eAVbD1ZfNIdOm4dRuD1pP+ZAwY18ZoX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(376002)(366004)(346002)(396003)(66946007)(66476007)(9686003)(4326008)(2906002)(5660300002)(8676002)(66556008)(44832011)(33716001)(54906003)(38100700002)(6666004)(186003)(6506007)(6486002)(86362001)(6512007)(26005)(6916009)(83380400001)(53546011)(8936002)(41300700001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cniCSEiKGUTY2Pb7EHSC4M5nJzDbSpPKxvFTNrtC2LCr2nRGFWchR3lppZEj?=
 =?us-ascii?Q?hn5kIMps5lJ/D/Z5DffaF2uNzCxHlAStFEpOBQgy8zrmouczc4CBP4C0Bqwn?=
 =?us-ascii?Q?6MHnGUcET6yqk+T0j7r2Qf12PlVmjSy1Knb4KF5E08iw6dka94R/F0IbIjJR?=
 =?us-ascii?Q?Ri5Rcu2fpSp1yQrIzT0AdL/NGqMnObDefP545TORfvYrHUm9Jioyp2G/e0ue?=
 =?us-ascii?Q?29rGrcsJ1/7Zqz65q+ihof8leHBSCnHvmGq+quPC6RNQqgvgtE6UuFTFvoeC?=
 =?us-ascii?Q?LCqb0yQxneU0GHV9S9Xqpg2euqZJGN5Mfa6r6Nd/yLZGTMTaDVXZ1zha8sEm?=
 =?us-ascii?Q?r9u0oskvqcS876cAAlowo9UgDHVvJgJZND47h2T97p5aVOQk5DSl07kmc0RR?=
 =?us-ascii?Q?Ag5jtYhw6XpLfPz43zQC204MLCZKmNSpIIBcongfh696T6zjK6APjiYSupik?=
 =?us-ascii?Q?xe5z1XcGWZEDuS1BROeAXt51g9Yq2k0VXCtowe2taIj5bwVdpc1wuLATkmT+?=
 =?us-ascii?Q?LhLKHIv3y1WtByfVX0LoK5eqEYMcRhDC1RkpeLYZFXSzNYsnEfUCz0kaVoYV?=
 =?us-ascii?Q?KVVb31U1tiVMVAx2ZQnB64X49J0N9ai6yRpghbIaTdIiEV+N534njYpV+M89?=
 =?us-ascii?Q?Xh3+c6R4jioVWsnGhg67d+JANvESILc7UWT5o7mS/8dg4TayfvpW5CGTqDot?=
 =?us-ascii?Q?2JI1T9HpdPWB/Qc4sl9UMRtsBV2D0Bf3eV+r+pf7BtV6WQRy5HtCIVL+gvco?=
 =?us-ascii?Q?f79ZUeQORdTa0BWfiMDzSyEQ0smjAy9L4/V5wPYRwsmnmwOGKkcCTj+8VUSE?=
 =?us-ascii?Q?4Mt8DFbI0u7YiOaIfJOODSyejLaz7BDmv7L0+H52eHTfgifGkUojsECqXjkL?=
 =?us-ascii?Q?3zfsb9BBKrJDwioenT2fM7HsXad62WEP+9uYf/bAf/qU2wefLFxhNw4Uynjh?=
 =?us-ascii?Q?S+pYt3qmQ/D7AHroO+fRR5Rt4Sw0dMmR0iJWcqcM5WuYubIE6B7ei/CgYKs2?=
 =?us-ascii?Q?T+cKGAQOMoW8sEypb3VaKw4hnZtLM94FwGuFJguXxJWzuN+s7kWk78ag6rAt?=
 =?us-ascii?Q?cF803UavrWDpBDRp4zVUUYxUFzgdW0spQO2R8GpHNDOAYe4KpPuxMEDCaETS?=
 =?us-ascii?Q?zgHhcVulyebNNFbZz06MJhskU3DVcABnT9srFV61CCN0fkE2sHaOSRX4hUr3?=
 =?us-ascii?Q?7NilJ+rPYiEXb954n5QsZs6+E04QOPzUnCeqIIp/YQ5L0+HoRQyOEoPP88YB?=
 =?us-ascii?Q?XILhn8mwtdp72Kjx1414OvJ0F3uP+7NMFaU+nI5YRBBrni6L9jidgT0FbG/B?=
 =?us-ascii?Q?G1bSO2JMbtS6N/PVyuf2bPJ76AmRupF8dWL8z8MNYuFzKQFT1Mj1wL6GblkW?=
 =?us-ascii?Q?zFNeVLDEnW/viD1Hl2t1obayBcf2QIgO//WGJmnhDuvoZd9s9UblSAnGqEdA?=
 =?us-ascii?Q?R1nSJ+k2WZ6aMRemsMtx51AKqALDSIdqgRt0EtGfKFBweurjxt88CaUAEIES?=
 =?us-ascii?Q?SnEB7US6jD5NLRVM0h/UtcI8LBXmp/B5ufMpdcYARa40RXL7Z9FOd1KkQYZ7?=
 =?us-ascii?Q?hXrPEscCEpSg5xbKC+CYDRIKqXlY/v5HgoR/PGGQuwvi4sJt11XC5xPFiFP4?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec1f4f2-052d-4abe-f498-08da652886c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 23:36:36.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1n6zdArgEQg2x/31soklKmIUSeFCr0kBvHOl1dMTCl0jq5etknEwJWJJdLwX5J16BaAsjwdW2YDZn1UvfbRoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6084
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_12:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130094
X-Proofpoint-GUID: np3NkJGnidOxyW592hdXg0tlFIvtPLYk
X-Proofpoint-ORIG-GUID: np3NkJGnidOxyW592hdXg0tlFIvtPLYk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/22 15:46, Axel Rasmussen wrote:
> I think there is a small mistake in this patch.
> 
> Consider the non-minor-fault case. We have this block:
> 
> /* Add shared, newly allocated pages to the page cache. */
> if (vm_shared && !is_continue) {
>         /* ... */
> }
> 
> In here, we've added the newly allocated page to the page cache, and
> we've set this page_in_pagecache flag to true. But we *do not* setup
> rmap for this page in this block. I think in this case, the patch will
> cause us to do the wrong thing: we should hugepage_add_new_anon_rmap()
> further down, but with this patch we dup instead.

I am not sure I follow.  The patch from Miaohe Lin would not change any
behavior in the 'if (vm_shared && !is_continue)' case.  In this case
both vm_shared and page_in_pagecache are true.

IIUC, the patch would address the case where !vm_shared && is_continue.

On 07/12/22 21:05, Miaohe Lin wrote:
> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> for them mistakenly because they're not vm_shared. This will corrupt the
> page->mapping used by page cache code.
> 
> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8d379e03f672..b232e1508e49 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
>  		goto out_release_unlock;
>  
> -	if (vm_shared) {
> +	if (page_in_pagecache) {
>  		page_dup_file_rmap(page, true);
>  	} else {
>  		ClearHPageRestoreReserve(page);

-- 
Mike Kravetz
