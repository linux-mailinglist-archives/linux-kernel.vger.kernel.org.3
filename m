Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10215A0148
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiHXSWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiHXSWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:22:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547174352
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:22:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OI44RF017323;
        Wed, 24 Aug 2022 18:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mAPKf/0QfLryLwIFnZq2MAh0fzbfH3R8GH3LC5BSk6s=;
 b=WPaX2Y8pHvgxn/Vpb2XzUAnIAFpq0PRIm8cDnLlCBAFuhC6GqUbfQCekvT2wL8eI9j0H
 67Ing87Mf5inMExkJwX5Qi6pwGENMj8WGh1zMrT5Z6lLyCqEfG3hVGzXBBf7ZG/Wao5b
 9NJD/SS9l9jHViE+7lJJFS9MxXNvILdGkuQjXP+iPhGwfGP1N+FM34sFV+cAyLFVb6aU
 /q9z+sNSHTOBUSajLrmr3Ki8eMpe5K7XNNQ393U5AKmUIRKjApYghml5vzvR/szd+sje
 aBNNxJCwLD7jtN91WJMAsvZ7ZIU5Y0JuVpJBk0YImVy/7LbedkHMmqwNQQw6uI18AxG2 Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23vdyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 18:21:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHH9bE021798;
        Wed, 24 Aug 2022 18:21:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5nc7vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 18:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+KPIJh2zokrXw72HA7psHNHxGApQSOLeYUKIriVZoKDAjmx07ueeDhxFCk0wI7mWFL7chV75O7BrovlpyXjCMv80DaLzbRTnXJT1J+S7naeJjxQrUtynmcNOtQkG0MwQsaBaECVA25BnwSXKuiU/vQrIWsQmZ/5AcsKuKJIsPT6z17++Ze359KFKzWfR7IWTMRgcFF3SEH9JK99ORw183CMMrNp19jbrSdthgfxF6YRIcxt2uxBoNtbLh79M6bjldWjqDwpdAs4D0hYqViutPKGX1a6aXLWsb2BejHQv+zr4q3gw3zwn7K+5vndsMrTbNTslkApf/SVKWNsuSBlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAPKf/0QfLryLwIFnZq2MAh0fzbfH3R8GH3LC5BSk6s=;
 b=TYLHg+m6KrUWdTNg90O3KvRwg2irSiPE35lEhaVdvcniowD8rN9nJr64u38FPkuba9pXIPvdWgscUs+8PRCRsjRgKTxd2E/sUy0PwY2rBmc0goEmPLGhXoIH1FuIDtZhKgccg1TGNXQ+mclbWuA6gVmdJHN3lS+WHTnTsRw2wyzNqAjF1mRIJZacn+BZkICFeNj65ES/pv60z6CVDmkOX8O2aNHFesOqCJCAdyAN/sp4xWKvlwAEqAzrS8K7TeCrnEd7uL57GP6udCBbMd8rXxFoUuaUVhHm8MYxGPpckvM/fXfUljCXPiuJ62B6Cs+4Cg2P4icQl14tzxTzTHgmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAPKf/0QfLryLwIFnZq2MAh0fzbfH3R8GH3LC5BSk6s=;
 b=rE6acEl/mX9t+Ay0ZfHIQJz6p9NTKzbHvp4YUtqR1HrMV35t19U13va6JuSKYNWGu4ysLrmbCEI8YmnRnJxzhaxrC7Unu4WSl2QMxx3jlpuhVNFFPTFZapdSHQTqmCUiC08/vXXkg3wBMPhWuhavvD2ngaSYqldALwmJXfSq990=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM5PR1001MB2250.namprd10.prod.outlook.com (2603:10b6:4:2b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 18:21:54 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 18:21:54 +0000
Date:   Wed, 24 Aug 2022 11:21:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        lukas.bulwahn@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm/hugetlb: fix missing call to
 restore_reserve_on_error()
Message-ID: <YwZsP15q80ln+iB0@monkey>
References: <20220823030209.57434-1-linmiaohe@huawei.com>
 <20220823030209.57434-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823030209.57434-4-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7364e29d-f8e6-428d-550b-08da85fd8597
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MACIXYU0rfRb6Tge4JlgooCt2O0mzJkrb07iAaQ//xiGp9pMZUo6Xxnaz8FKeFN1+7rv+qO9GQ5PXVXbuyF7i5engi+x/YiNeacF27SOu+6vsCzmEf7BEr5mp9ZoOeI8CwJ2LmHNovppUTr5Sr8tgaqmQwAnBIsghJuAs8cAqlkXB6MkAC912bSgZMAFACR62cE1+d7gDQV0Cigwz9erta7Lk1vYA/0+0BzHY2xcFmF0K0RET37FmQMtiMbagbLIeKj0qA2ZxGG4COHi7TcG9r4kO0W/c9egjhXnUSWQILmmSm+eJ3YSc9mJh56RDC5d2oWn3qEcDgq3p0cCJSPiNox7IWydnbzYDV8E+b0ApwT1fXspEm4KM7GE3AVpqSCMQPk5n3wzC9hjN+hYnsoiN7gQPg1mzU08eiv7rCQVSA/924dQ4N8ZqU0/N0BuK72PpJjW2zGh8BZidT4V5+5bLYwrPWMmuhaKsWgKwswwzR0EGVWxC4cSkPyhQ5rRj8b5yx9Kqp8Nc0fYei40c9C44c4k3bBq6vkiRCqJmbhfUCtjBRAY7re78mb/7Y23+MEvDKZomUupz71F74gQ7EOWUuFSUDtytRhIgzkU8RPfjlDoQNrelfI1KFAj057/41aZIzEvMZL+B4AbzxLap7G0Vu3q4euWv3JsnIBAq7KCJFQ0Ga2u3gllAipnHWkCHWVc5540b8YuqWKgL+8yyeWf/wZL+HO5eC9E0gM51BUOlbm2DLYyQZsJ0or0tPre4IW0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(9686003)(26005)(316002)(186003)(8936002)(478600001)(44832011)(6512007)(4326008)(33716001)(66476007)(83380400001)(66946007)(6506007)(66556008)(6916009)(8676002)(53546011)(6666004)(5660300002)(41300700001)(38100700002)(2906002)(6486002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/q/l+DbWqKCqSGlrr1aa3ZNAQEb8wesdefNMdsutDtuPYf9542f+kblrnjt4?=
 =?us-ascii?Q?zEddSVeG49PqbKyzbE2hOO54P8iMaxinLf16rXBDA0zCLY4V6I9QrHGPpcvx?=
 =?us-ascii?Q?Qn3sDbfnvq52/cBWCOqchcmKCSJYOexHym9mq1E9PSYVMCdkT7PmTxovT+i8?=
 =?us-ascii?Q?5KakQAOqJ8psr7sJVBaGnGl2Efl5KzmyyR6uerefrp9HmECIn/aFruwDMQdi?=
 =?us-ascii?Q?MSvwgOC+MKfsL/SNdTsSJAxRb95DnwU3nr0XCjTq5n7qdmzNuvzWDgr1CuwP?=
 =?us-ascii?Q?oR7eE59/aed4/yeYaU7V/MF+EnGC3+hZqnrMWvYyPgwZs1eKSv+V7otb6MG/?=
 =?us-ascii?Q?EXu/xU4CyEMOMdAuRLHEGgMtdvO5IbBOsbxflu5icM8zxSlwkDBzOlDWK1Gs?=
 =?us-ascii?Q?PhUmRCZp0IpnjpjY5C1DTh8dH8lAUb6xvArSEFnCiq9SD5eib6crThGJZBvJ?=
 =?us-ascii?Q?4DV2iHFL/BTvw/lX5v5anOXnGjDUqtCWJxXNRPKYgbetnfxknDCH4G4pMuyc?=
 =?us-ascii?Q?LrHZoN3hw9N6n5OP+UQdO3uAZXGKz5B8fAWJKbGwiVb+F2Ae2QaajrULyXjS?=
 =?us-ascii?Q?HFMqPx5pjnApxpx9hkd2HZ9Jfk2OBWkbiJSbcYUs6Mga5ddFXtFXByJgQh0N?=
 =?us-ascii?Q?AJp7YzxlAFbtodgorlHjaqaeBYJopyrmqTsgRid/6OePc39P0mlC4mT+Zcxa?=
 =?us-ascii?Q?L89iPAq5WWAHCC4ZngsiAEbFK9BjrJY8lWMy4gKnkI2HP8Qxo7jd14ualUDf?=
 =?us-ascii?Q?4rcRB2gSnTBSYNJj4gMRla3LdkpMpbwoVRiJ5niZdx9BrMQBQPr6z7V+/JuT?=
 =?us-ascii?Q?93kQWgZlkPiwH+2fb09cs+9GoeH4WIpRnmkdDNpyeinev3ydXUFDXrhT/+5S?=
 =?us-ascii?Q?nLtey8i06YtMNTjZ0o+bNrnmeTg57doabAtr+NxrnbU7p2AJU+qH+p/oque5?=
 =?us-ascii?Q?LFt3lCTPLgvX9UY+5efJS8wS1zZwP1acljODrDppRfBRYBEADWVMQmQ4K2NJ?=
 =?us-ascii?Q?2eSveoAXJSpMU50CI/XYLnDqndPpIAYVLCaR1FVPG7PkOTAaELfRT4yEcn16?=
 =?us-ascii?Q?mNgagpPBVwRwSoYIv6dgR7IMa85V8oj5Yrs2B7hucFdnuL6eAJmBdHna3Ofc?=
 =?us-ascii?Q?o3QU76lD9k4mF8h0gwXRhFCieVVONq8jHAaGxfw6qynTw6B2wvocqFrbZUrg?=
 =?us-ascii?Q?p9XauPhJ1u58tPnKlkbihdmFuTYlmNFk5CgJgCwylgFZMFoJ2kFY0k08QNJK?=
 =?us-ascii?Q?GuXyDPincphvy3GdfCz6ciaXtVmuQLAHqcaxdtz4Ob0HV52GDAKtlPicts76?=
 =?us-ascii?Q?Xxo/4A+mr0xVZGVAx1zJcFOZ5dHYlOyj0n+Lazw0cW6VPVFQcHumJfO/WXaC?=
 =?us-ascii?Q?EJhaUkRVOw04Ym9fUPmlBNdFUHxki9GP6UWUtyytV+cSI+K25PUFqMo4ZGRs?=
 =?us-ascii?Q?A1Jyqd10eb3XjEC8NUHWduzuNRn0J96zhvWiUkxPAVOspevBondisEeDDI7Q?=
 =?us-ascii?Q?XSSj/h8JWTELHaGlDCG+w9ECg7486NJ1mTDOXBbfe6dMrqRf1z13OsKI/a+M?=
 =?us-ascii?Q?goWXWfbvBunXAn6ElDhecdNjulPS3Dc6MD/suOdze+lG31N5p8EP29hi9j8D?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7364e29d-f8e6-428d-550b-08da85fd8597
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 18:21:54.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/4zJo+xxWyo1KVf200Q91BKfOLY8Pc44gghYBtMNUQjK1aE/zrhzU9udu/iVaq+GGzuk4da/vWnJWS+XQD8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240068
X-Proofpoint-ORIG-GUID: qLPFbemkrgLHlYgQiJCSC1kcGHLwiQMy
X-Proofpoint-GUID: qLPFbemkrgLHlYgQiJCSC1kcGHLwiQMy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/22 11:02, Miaohe Lin wrote:
> When huge_add_to_page_cache() fails, the page is freed directly without
> calling restore_reserve_on_error() to restore reserve for newly allocated
> pages not in page cache. Fix this by calling restore_reserve_on_error()
> when huge_add_to_page_cache fails.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d46dfe5ba62c..8e62da153c64 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5576,7 +5576,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	if (idx >= size)
>  		goto out;
>  
> -retry:
>  	new_page = false;
>  	page = find_lock_page(mapping, idx);
>  	if (!page) {
> @@ -5616,9 +5615,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		if (vma->vm_flags & VM_MAYSHARE) {
>  			int err = huge_add_to_page_cache(page, mapping, idx);
>  			if (err) {
> +				/*
> +				 * err can't be -EEXIST which implies someone
> +				 * else consumed the reservation since hugetlb
> +				 * fault mutex is held when add a hugetlb page
> +				 * to the page cache. So it's safe to call
> +				 * restore_reserve_on_error() here.
> +				 */
> +				restore_reserve_on_error(h, vma, haddr, page);
>  				put_page(page);
> -				if (err == -EEXIST)
> -					goto retry;

Thanks for removing this check and adding the comment.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

>  				goto out;
>  			}
>  			new_pagecache_page = true;
> -- 
> 2.23.0
> 
