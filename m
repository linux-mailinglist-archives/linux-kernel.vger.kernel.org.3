Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBE57D7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiGVA2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiGVA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:28:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3A88E0B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:28:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M04LqF004920;
        Fri, 22 Jul 2022 00:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/NrwZPdjnZH8vSE+8/m7DQEEu5eXGb6CIHFfvSHhsDo=;
 b=HAG9dBNQvBV6yNejvB4Oeeh4sS/yBzmGrc+0WtPFNhnya52LdcrYKrN8JoiPhCPtvSD7
 k4qvMOh0lK5VfN3JyXr4D5XOQBoTc3b8I0erm5UOaJGmTslAj5wtXn/sg7eLQ92y23wk
 JNTOjt6bHmwOmXd/tTSSybJ6MVd75PkcxBwQ9DVp2sAFdZThICyiHzFLw/eLy3YO6Sld
 PkSPzcWrP8KlL7X0oEQN/PUCyuw6G9NPg2KKcjV9bZqq8jP5PqHUYsXSBUjaEpoqPSa2
 Po53JD07BlgIp75VDlM6RLoZrCar7WqfdmlrB2r1+pKBiDgnt3L3hIZrexk5ueDK5WK+ 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7adstx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 00:28:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LMI9vK022262;
        Fri, 22 Jul 2022 00:28:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1huj25m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 00:28:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWqlmzY5cf94mhwflTVkSXAm6IkAG8ozCuc3HLqNidBbHCuBLwYbuWCLxZWSiu/da0Aijns/iMs47UQD0wlvm6sucJK88iuxVfM5ZqgPZgQpbgn3l5i/9QE7KkNlY/PIJBLI/NGbVhVwaKFJ+S/1YMNYzBUobKKiT2E8GoiPQNztccuTH9rAkhEMdVkUIsfKDFAJHtZEjewzOmJEQhhwgYieXpigN2yAlHxpvdW4mTXX+VfGSLvz4O1qYLh23Tiy303yZbAUJtN3HVJeRge6f9X1/ZQPHAeDl9ICFiudOGTl53FsHXhigA20pQV0GoZQ64HGVChmqkYSZcTk4xp40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NrwZPdjnZH8vSE+8/m7DQEEu5eXGb6CIHFfvSHhsDo=;
 b=mo27xEwsuDUmkuzlPrvENJnvUws07U5kylb/usNK/uixWPT6XP222bSxz/w5z88q/VpcUnJkDH/L2oGb+35Q9YmSiyLxryMXDzmpv3cNIJlg7YH131S6Xdqih5ylIUszmrlYZlTlv2ab1IUBwaYbHBCJ3AUiAwZbCQEG8EwBknXFlcCCJZfKVYYEct0Pl67G83L9ZGo0NqfgSF5C0li3kSekh59ZXQazVnTMi+fUxG6lEsyHndfGZeCHxiSvRJMGkA3sK/5joV5mRN1+qSvTKG32c8amZTRgibY67m/idOVQ5CTksJGlsuQX92RAYAXHr9jyaHwMoiTPu0egcubGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NrwZPdjnZH8vSE+8/m7DQEEu5eXGb6CIHFfvSHhsDo=;
 b=rao0LAcEY0MP5SGZccPKHt93cUG1EqEfOxz8wg5QbbJSvAcLMTTt/pa3W02LuivRtLliSg2KLdTZVWxM/4ZdMqlRqTQk9ebw4/e6RN1TPcCr9Qvao/6qju/WdnBexTmMfTJFwPh5EtZ4iS5hBj6MfrYzq9rT7MMvJcAEWvocEYc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1750.namprd10.prod.outlook.com (2603:10b6:910:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Fri, 22 Jul
 2022 00:28:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 00:28:07 +0000
Date:   Thu, 21 Jul 2022 17:28:04 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
Message-ID: <YtnvFBn8tSm7y/mV@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721131637.6306-6-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2116e53-6297-4858-cf69-08da6b790cbd
X-MS-TrafficTypeDiagnostic: CY4PR10MB1750:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu7SZXC7AGqwcwSgj3BzmKz/HcSkrRznVAxJa/o1ICNiRZUdQlLAjaecca1BQA+PHxTaaAUBsJgdQL097iHBuqw52e4aJrk7Rj9CpGiTFGg7F1OSU/iacq99dw7UPuVAQzMo+T9hmV3lYFKiFMmCvwMVn5KVnnHbMxVU/Ag26BMldsxEgXCQ+n//4fZobEibHiz1QoDT4ln3aAuyBZHCxs+1+2Ex1xfRz40HbMJPoHHNaEBsoeB2pr93tBCgVKR4qkmI77i4B9SdxxBvNJu4t+/mg0Yf1QU2CwgvcE64acBMIBd216Eoo0fMbnZK4NDP1PFRJLqZMRVjFWAYGts5WxqTf8aCiCIEPCmCH8ad75H4yQteD+mYzxZgou32GvtGAb4Bjjj290x1TqzMqy7qOCw5XGI+Buc86zKvUjwVwxNm3IlQr3qm5D7Oya1W4LOhcDZuV+3KOaQHDBDPk+oo+f6jyxTTpebXzB6cuRpGFlbkH4AO/Ysiv0p64idalCxeZaEheHltY48pO2aLZMX2pPbdYJ6U9yd2vurDbJ4bJCF2ykc6D0tKOuhL/p3ILwjBXNlZ2D0g5FRNqMxgDI3YyIRuquIeabKcc9DE3nTxKG7dwhLa2kgLFmevurhaVsCJdT3Snw0/V3XLfrP4S3wbE1+HQjlwjg41L564beOGsf63SEZhPOdagckUwEyT97djEUcBDKuaOGsEikdZSr4ImsBpq4XcmPFohUpciNB7m8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(186003)(44832011)(33716001)(316002)(6666004)(9686003)(26005)(478600001)(6506007)(83380400001)(86362001)(41300700001)(5660300002)(6512007)(6486002)(4326008)(8676002)(66476007)(8936002)(66556008)(38100700002)(53546011)(66946007)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQPpfENw5EhkHOkwt/7yXeR9vGxLF+Ei73yH2hHweHKXh45MkrrmZcU22Gp0?=
 =?us-ascii?Q?TuF0mX77CIbpK/5mbNgd1nc4WNxJb2sP//6TD10nUhqFmJo66hHw7baQmT25?=
 =?us-ascii?Q?d2E1Xx4mHTpwnZo1YOSgMBeegl0W1Bbvo4Sb8BdkZYUOHX7Mdg2IRBVymhi9?=
 =?us-ascii?Q?BXMu/ewn0lLdVmx1hoBujQ4xTCNIz8TN06YLiS4uu+Jsi7pWxcuTGWlYU0eJ?=
 =?us-ascii?Q?0TB6RotUAqcTKPg5xb6RXKh7Q1qzlK/uQX1Lch33/99EJmSEFFyw3ixrm2Zh?=
 =?us-ascii?Q?aCa6GXUikqdbsI5OW/+cL1TxsSGAEJxyd/1w8d+h8QqJCV701f1mSbrQwVhl?=
 =?us-ascii?Q?oNnmE7Ts5tlrFLfgNoQdTqwonclEaRvldvNd4IKmSixR1E26w+rdEMoazBgg?=
 =?us-ascii?Q?cJJMDRuUUoM3LC5xQpXPXc86mF97ucssJWgFwm7UdFapCzrdPHXWtVbuLiBu?=
 =?us-ascii?Q?mfCq/Ey1mNiMeGVnqDZbtC6Gk8Q9GVTsLjNj7pRcoVR/BMOcC66aPCPk6nuM?=
 =?us-ascii?Q?0zlGruq/ibH9Y92mwcnxFB1rCLDvrWXBtGqsqOKpL1W9+72O7hkEe7Q2+uRG?=
 =?us-ascii?Q?UnIDF41dZwhlLHa6tv0F2VwkX/O6/5xKsLTLS8CdX3GVMoznOyEWkt+IU0TK?=
 =?us-ascii?Q?kaFCxvwfnNJfsdhbpts5IZJFMZEVYqQaR/23o1LZoIEFPkhG/qP0tgOsj0zJ?=
 =?us-ascii?Q?LwSjB+LCMyQNboj5aKKaZq9fxw8axNHgpncrnOEKf4iHDwZcDQ50QzxmMA3W?=
 =?us-ascii?Q?P54+VX6Rll6pY/lqlonRWvS79Y68DplfRIR1PUK4vu8gGErYxs/RXSiZIzGa?=
 =?us-ascii?Q?yW9xCYxyOCPgdT7SzuSJx/yyzbhv3S0hLIH/uKExIIRAkKU8wU+trB1NnFQF?=
 =?us-ascii?Q?Xoz+EONUjc6VA8Z5PwqF3/MLrB0w/KCPMStX2t6DvEXC5zM+g8W0bJBBwEZ5?=
 =?us-ascii?Q?LUSj3Xc7LvPvW9OyzDBiB3UByh2lZkz7FfjnpPmgPGcsPXtm0zceokqxPFrz?=
 =?us-ascii?Q?qbkEN8rBdBmVOAUneaUCyj1rYUPFwOHMO1DmlwaML3lqfkqvwe5uqP2Z8DHc?=
 =?us-ascii?Q?WPpifI0qeZj/J2nPlbZYlw3j7DR2nP20nZvMystBpuL9XGXXTK5vw8pPIaiy?=
 =?us-ascii?Q?sVPsm5lFsa9E7i6wrjPwqqc41d4lTPJORG6BKtLtW6tMz3KRDPrxuxD3tzI0?=
 =?us-ascii?Q?Eu0JSmjH5tdcKCqILGjkrK8PyB7lo/O8AB1wlOF2iENEatLZI2l1RGu8Yx6K?=
 =?us-ascii?Q?LE8vWU63FJeB494TUAsLbBPfpAFWFAWt8rnTIahgafKYuAYeEjSdY24h1ozY?=
 =?us-ascii?Q?w+Y0Zn+H6MyBHqCUjTgW4CZRhsUzWvYJn2HQMQeiF2t0dLrOgYsK+Kw6pEdk?=
 =?us-ascii?Q?pwIRWhQwHrU1Hd6X/2hvIwdJR2vIMwLG7aoDXST+QvVtpilrLAGXFoAyhsVO?=
 =?us-ascii?Q?yB3ZdGpsNwuSM4dIT0Th1sGVwbr7/i6gcU81qZW+Zjv5Xipbdof/I8zecrIM?=
 =?us-ascii?Q?EvmoFKN/x6te9Y6DbE/Sfc2TrtAi67z8SiitjJdDzctGV0So3LMMCbxikFPW?=
 =?us-ascii?Q?vHymbVaZ9R3Sa0Ed5694ACaKHNK9SfTTHfozKLQAsytuVMRYqUVbMyiK2imm?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2116e53-6297-4858-cf69-08da6b790cbd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 00:28:07.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWwbra3IBIiOlektjaTOFCQyyOQKZRLSEzGySzssYtWQaFDfOdS/EctXIP9MYv0slAReMaAYkWPrU4Hk3iJOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210100
X-Proofpoint-ORIG-GUID: QZqejG_hqY2Gc06-RPOYfOgTKnDo4jJI
X-Proofpoint-GUID: QZqejG_hqY2Gc06-RPOYfOgTKnDo4jJI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 21:16, Miaohe Lin wrote:
> When size option is not specified, f_blocks, f_bavail and f_bfree will be
> set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
> and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
> -1 first to make sure 0 is reported for max/free/used when no limit is set
> as the comment states.

Just curious, where are you seeing values reported as -1?  The check
for sbinfo->spool was supposed to handle these cases.  Seems like it
should handle the max_hpages == -1 case.  But, it doesn't look like it
considers the max_inodes == -1 case.

If I create/mount a hugetlb filesystem without specifying size or nr_inodes,
df seems to report zero instead of -1.

Just want to understand the reasoning behind the change.
-- 
Mike Kravetz

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 19fc62a9c2fe..44da9828e171 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1083,16 +1083,20 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  		/* If no limits set, just report 0 for max/free/used
>  		 * blocks, like simple_statfs() */
>  		if (sbinfo->spool) {
> -			long free_pages;
> -
>  			spin_lock_irq(&sbinfo->spool->lock);
> -			buf->f_blocks = sbinfo->spool->max_hpages;
> -			free_pages = sbinfo->spool->max_hpages
> -				- sbinfo->spool->used_hpages;
> -			buf->f_bavail = buf->f_bfree = free_pages;
> +			if (sbinfo->spool->max_hpages != -1) {
> +				long free_pages;
> +
> +				buf->f_blocks = sbinfo->spool->max_hpages;
> +				free_pages = sbinfo->spool->max_hpages
> +					     - sbinfo->spool->used_hpages;
> +				buf->f_bavail = buf->f_bfree = free_pages;
> +			}
>  			spin_unlock_irq(&sbinfo->spool->lock);
> -			buf->f_files = sbinfo->max_inodes;
> -			buf->f_ffree = sbinfo->free_inodes;
> +			if (sbinfo->max_inodes != -1) {
> +				buf->f_files = sbinfo->max_inodes;
> +				buf->f_ffree = sbinfo->free_inodes;
> +			}
>  		}
>  		spin_unlock(&sbinfo->stat_lock);
>  	}
> -- 
> 2.23.0
> 
