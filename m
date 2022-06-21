Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A367553F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354622AbiFUXmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiFUXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:42:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26833121A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:42:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LNaP3O007491;
        Tue, 21 Jun 2022 23:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=b7pZPf8KxDqDvAR2CIY7Hvt7H6la+n4zss/aciBRcWI=;
 b=IN8FpqH0r5EJdhyxcS3qu6dusWbxUWO0V6QGQj26pe3LHQs4WzXjKAIPROlxHCeR9Ce7
 yJXEVcvTWov6lk10z8qDf+ISymMN9G/mprVyasy92O0V/sYw2Y3NYQrD4e9CC4QgMW/V
 TBsJhb0rIPxjxdXQ+jU8VTZ6uGsJ4X//DbKCGmtkzr7Fr2/pUor4auDUMgdtve5Ew0LJ
 zpuPpQRQQ6pjE+bwLRSaoWPplyI1pIRo6Q+2TU0HouSutxVZdoiROi7MXtx6asEXB6Lg
 5O6weE9XvV0PbUaXiZYOWeSr9uQLQAleGtfaxnJXDeofPG6TdP6S794UOWSZaS24YC+f CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1y0mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 23:41:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LNeYFR006254;
        Tue, 21 Jun 2022 23:41:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9upukp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 23:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzaUNSKOxxoNvZr+rG23x8cHp7OWLrB+CMDhiGxOEg5RyphzvBs32WVtvsP+dJuESLAnyVysbJpRDNGRxazJ2TS3k1AGW1KbQ9csAtSPL4KovS01QvGoza5iJyB+Z5ARbe217qsnibBDJwuf3joN0Q6GrgxSpP+xGwKcIivW1pDMTrC5K12WPXKdLeCO91SXlaEATNvNA+batS8m9cFZa7/UuWroUDM7ZavLc3jleWMjKKQSUgsSE4Wy5FXdStxkjQHl9fIxvrpGSB3rWTeFwU+me8Cgvjm2+7h3RsvpaF7pdTfhntqaGU4GOTbBAK3c9AuDyFixB/5FL4+XhuFzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7pZPf8KxDqDvAR2CIY7Hvt7H6la+n4zss/aciBRcWI=;
 b=CGKfctNAU7wDFs/PliTrNWoqbpQxvmgxplsXFxvVqjd0A2Ie0M4Ltk5nhTb+iD8c9q6ZiuIF5Ms9B+ZZzFgTG45hf4bKB34xtC54y4Oy+3n4HAlZOZ2xZ7EDHyGaCs2FqeKuTW8E7xB/22tn64TxDhIM/aQVzN8Lc/15NX1Z9dTFslsEUl7h+HT9wyiBL3s3DETlixw3gUILIqmeHUafssNrK5IP5328OxVAdx7ox+ZGnDJ5zjxQhDxDfzSPOEmvJjQQBKZCwPvGU+0hsSeMmeh0VwTtOKeu87yoFi/k6eqezdwHH4xzUEmVNfNMYvhyW/DwlGh9yV8F7HvWC0tFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7pZPf8KxDqDvAR2CIY7Hvt7H6la+n4zss/aciBRcWI=;
 b=JYIoGUxdwEFqMzgtIDLVC2XaW2UmghiASg2lhDDKCRCtAzEv4e376fcLlpE2i5j83BYttl4y0/KTEwyzBvR9Zj8/bYnpfvhT9W1jg3l/yYi/BOJ0XFp2f5DsVweb7J10R0A+MBzsqR1LUh+2NP30KxR9p8rO9UyT7eNOmcpbYmQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB3816.namprd10.prod.outlook.com (2603:10b6:610:8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 23:41:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 23:41:53 +0000
Date:   Tue, 21 Jun 2022 16:41:49 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, songmuchun@bytedance.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
Message-ID: <YrJXPT4dB39ylZtT@monkey>
References: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: MWHPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:300:116::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0454375a-a190-44d8-ad6c-08da53df9e61
X-MS-TrafficTypeDiagnostic: CH2PR10MB3816:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3816EC348714BECC00FD9BA6E2B39@CH2PR10MB3816.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FShIqA6yWWuDEgOasxxf9qOz05kxr35WliivxbnpZO0EG9IHKgfj6VgmQh1lEpIu+eDl2IJOCHAv9jCK87gh5BbXsu1/1x6yvxz7M/EZR1CPm43hicDXiALdVZaoHdzJW2UNOeAkBw4KAXA7sAQQaZygIl3VOLLhU7Wm7xcLjfEyeQkjNsvokQTXZupo/3p2oaxjXx34bK23FccnTu9wgfcfCsH9EpAQtEpyU0a6bsDpz+MfbwIqmoUfHc1WI0LDl1sMVkk0/UNbUpgJ/yqNSuesaf8VSslBkbFOIOo0OAHPYgVyeirlODcSbrLIl9XVMy4QHfAsML4ee/zWETpMETkwrjM4x1loINisx6EzYfCMiUbwXpqdIQvXc/gUIGnLIlzYxO1sXiOvP3y+yYMUH7FjxBhf31zeIaEdGbbXoRV/+RoybNHHQg2RoR9x7TANOUc88DEEEbgkLgZLHiLXYVMz1Ihf7J4+LcoD+WmqJkGchpYlLPHo8pYN/RqJC2t9ZRCCT9f7camQSEeyWzo93jG3CJYNbt0OONzQTIWVraWXYxbbopILJUrreKa3qJ/L8OF9lS7qqL+sfCqMKpdox/axDQGJ6HvqPc1KKksvhpwmlAOK9z7cwKV36q2U5E7E/6RPMFO8oe2F1Ub4top6Q8FBtcchUH0UqZyCWym8c4s6G6BnkYAgjaZr2fza6Pc1lsZEyzZpX/DkEAgAwu6T/Pq7tUz0pnPd50jScl+Ws5HAG0WxufOTIC1wiD2M9CfFpvdZtYtioLqipnofvPY2QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(136003)(346002)(376002)(186003)(83380400001)(41300700001)(9686003)(2906002)(33716001)(6666004)(26005)(6506007)(6512007)(38100700002)(66556008)(6486002)(5660300002)(44832011)(6916009)(66476007)(316002)(4326008)(66946007)(966005)(86362001)(8936002)(53546011)(478600001)(8676002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dqb6Q64IGM4jCw9/2vct5m27qsuvm+qOqwCW/ZgYQ2cLcGMTzAhhmZIeHfqu?=
 =?us-ascii?Q?9Yp/mX3uy9/lnFqnpkG6hyUYGBR/gjuInPiQzZp8yl+1uuKKeEE//4meMavL?=
 =?us-ascii?Q?RFP4G3Yv1Ryl9i37Pejg1x0VzRCykMk3Tbixe1+3SV8qXJtVsa4UEcetZ/Sr?=
 =?us-ascii?Q?KnPH2jYhw4sa3UIseTqUit+1UEKjIp2qM/wq0V1219HQhw9C++3xeIhStjhI?=
 =?us-ascii?Q?J60suePMPVKm1f2FUGGtTl9DzoCGwvT24y2HqcNdgIrz9DJ45WwTHVfWYR5+?=
 =?us-ascii?Q?XmLUYGUmGxbnK4MSRjb+pKLpNzEmnFwjLYQgXL/Yo8Cxb5qfpbs3xr09chtS?=
 =?us-ascii?Q?cr9cr9oEe4djpOhtML4r9Mbmp+nht5dMPC5icM7qJHeBYzyyWp/bmSqf7jiw?=
 =?us-ascii?Q?RwAx6sY7i5o3EUd6FNJE9efNx2GwKQzbO+R9oB4iLNZmf3PxJHyky4qYCqyO?=
 =?us-ascii?Q?EXJ5w7O6OcglNWu7BPbx1N0cnNkCiMcoAcJxs5tkWIfXW2k5EiTY+QChQrr7?=
 =?us-ascii?Q?y611pq07nW3i7xbTifBylUT0sjlLsOq/ZgUWfx5Tgb8SaNWpH8wJiZ4QGIew?=
 =?us-ascii?Q?AvxTAO8pLYYG6FMR5/sYyZ5q+784nrHTQHRQ/CbXy4lKJlJfZa/j5JMo3MDO?=
 =?us-ascii?Q?l97z5nFjn4EvrV+D2qxOFyHC1qtdkVTVccYEj8CpcRIflQA1z8gdkFNvOBw6?=
 =?us-ascii?Q?xQ+pggL8BPoS7vECzVeEaCHn7TLjeNse5QbmYICiMOQ07cLRWC30kbmcJoj9?=
 =?us-ascii?Q?6RKOyl7PDZKT3uwGmsfI44THpAM/Kaqk+2kLq2hpnz3oGxI4KxxAxqgT1DGQ?=
 =?us-ascii?Q?VCENXvviqNb1/5wTqTXjGobiRfnZGhDPS3MGmFGbDLyuDfY7pdUUPkGDnmUt?=
 =?us-ascii?Q?t4jXBY8AiW73Fr74td8cU9cXoW0N/Kp9fZnpyWP7lbJCcXvXIXg04JtiCO0w?=
 =?us-ascii?Q?ptYHCvx2QKOgkV9uLWkz+Tsy/aKGEEBefp5pclDJy1nSC4b+E/HybINGq8gM?=
 =?us-ascii?Q?t5jofW7fxJtO0LvK4AVD/0iIAxHUnTzICl/A5NPnrAr2LU21KzmQx8CgR9ig?=
 =?us-ascii?Q?KbpG7RVkKQJ7fBlJYqAsUu422tmHQHJHB4EMM7+T5P6a//056cryPqM2u1zC?=
 =?us-ascii?Q?c5FM71dHPyqatKKvphwz6YXJRs6b1Tx/5A1lXSSspd9y7CxwQ2OPCjjQ6c9w?=
 =?us-ascii?Q?yIrkKLQEH+QsCINH1HAYpN8kzzyqJOO9z6dFz31feVNDJAqoREY16CMNuHqP?=
 =?us-ascii?Q?+Lu1xnBaRVrSANdIfKGqk+c6lrXP9xVxJbi8ImCXBFDZM0zGnaF8JIqTkvPE?=
 =?us-ascii?Q?DGY9CtOOmrXlDl5H9SENkD7nDB0WPqeBtxofWrOKCHbRsbPdYsfRi9AVcb/l?=
 =?us-ascii?Q?r+sBCbr3sWDAu7366wyB39+aPs4rROzbCeCqlHprQgqLV3oX2FAtw5f77ssF?=
 =?us-ascii?Q?KMaQ5TG83rHxrA9F18xraPNE36fnGjkUVb/nx3n55rRhzbxWk+z3smnx+FpL?=
 =?us-ascii?Q?Ah7VvfAxseXlisXwJKyeC0ubc6CJwkshj9mb0VCLoRWYgE1X4gRf/+54pIj6?=
 =?us-ascii?Q?b95NF1cW1s2tR2wcgCXlXxW6FkruCisG7m8nK9EcSFKbyAA4OxC8O7xM43Ue?=
 =?us-ascii?Q?NI8xc1E872HXP340jtdZ8pHHtyaTmF5dfTucrBjNeefCEu/SxIEYPXzDNp6g?=
 =?us-ascii?Q?6vkP1QvvcNo6qix3VvBgaXbE9rhJSqWF11/ZfwISMavWwIx2gxL98UKzP3SG?=
 =?us-ascii?Q?ez7u9RS3tv916c6OE8Ws6eL+pXKsWag=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0454375a-a190-44d8-ad6c-08da53df9e61
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 23:41:52.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn+xLZsyXnMbo3pa+W3tmPw/5desYOAoB4i2zRj5J02Zft3g0CLyZSdlSl030Zb0I1ZzR7Qnbvf+AiKqp/4XuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3816
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_10:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210104
X-Proofpoint-GUID: kCIeRYIKdWTLxXEBfHFfPIsOAjNf0baL
X-Proofpoint-ORIG-GUID: kCIeRYIKdWTLxXEBfHFfPIsOAjNf0baL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/22 10:34, Baolin Wang wrote:
> The huge_ptep_set_access_flags() can not make the huge pte old according
> to the discussion [1], that means we will always mornitor the young state
> of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
> will get inaccurate accessing statistics.
> 
> So changing to use set_huge_pte_at() to make the huge pte old to fix this
> issue.
> 
> [1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/
> 
> Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/damon/vaddr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 5767be72c181..d24148a8149f 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -337,8 +337,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>  	if (pte_young(entry)) {
>  		referenced = true;
>  		entry = pte_mkold(entry);
> -		huge_ptep_set_access_flags(vma, addr, pte, entry,
> -					   vma->vm_flags & VM_WRITE);
> +		set_huge_pte_at(mm, addr, pte, entry);
>  	}
>  
>  #ifdef CONFIG_MMU_NOTIFIER
> -- 
> 2.27.0
> 
