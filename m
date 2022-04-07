Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDA4F781D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiDGHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiDGHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:52:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A4E9CA4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:50:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2376vFGQ014690;
        Thu, 7 Apr 2022 07:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ubNnfJ6A1LiUVY4dtRn3SrypsxpecCkb+3TibgJ2bzg=;
 b=U6/rKtKeUR8wW/GjI431MfQhphWTe8FfGkI4EnC35lBYYeZzh989ZbIVxVU2DQMbfncY
 eVrcYcfUa5ylfs3iakXv5p2RfQAgrp45s+xRuZBu2LfX2qrE7B5TD3SZv1TacQssoI57
 QURiq+GGEPjlMUDXDaFdQLt1P4bmg0eOwtUIwXiswyvfIUuW8KwlqmGVfaGSE5q823CX
 SReMViWsgPfuew5K0JNZEXgAWE8pVYywtp61xeCTIQ2exmmyFiw3A26zw5l13shM6dvj
 OcqVQpP3QR9xChPDVLqJWyki+MYBqGDj5REJt8BxeuZCQ4XG2s3qv+kMOrLWfA+/oQ+E jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9tv4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 07:49:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2377khhb004142;
        Thu, 7 Apr 2022 07:49:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y783e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 07:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIdEiJT4uut0J7FEhtB8LAP1BnxoAbfprALN+qNj6zVb6d1HgVF5pgQtj6+YF4SHdYlnz6sCpraCqFVhHgKM6f/u6xrf6PQ7xYLO5TYfAzA8YNNVYNMxAba7rDUDjtELxlzni+EX3fFfpAQzVW8uLula1XiChuUoyExXwXLVq2gvJYH2R5uJk/5lwO76pWSqTY2jJIyO29Ya2R6RneYpoB2i69lDztRC+em7xqFA1dNK2TeOaNRPI0T1lqIudUSu8PZntWgw7mZ7kcVcUxdnzNSMWW6xAkbT/FaYblm2Fs3ZEHsUbPHG+ixCT8zh55VWWoQa9fvawCJh/tPvdGopBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubNnfJ6A1LiUVY4dtRn3SrypsxpecCkb+3TibgJ2bzg=;
 b=lTQqPITErB4XMl6GfkMWhvJDMIfMHh3ilQPh63DwsgZdFW8E3V6OBv6WxQ9R6fHOoazZbRLi5S0etppEbO9iWqQP8TIO39JUbdoQkXBU5aQUAPNAnwBAu7m8aZHO0M+2PXZmKgPcYZJ7WRpnG4oqKXuU6bsEDbO1Ro67gb/ehkqV9p2xXWKQifpw8z4QcUQXvLgR/nsmrj5pG/mITPTNNb3H5ASvI/h2TuvraCV/wyDhlKFRbspJyuNqOqf2LL7D0Pewkne52DAoPNJsEWdm5zYfjro7DgRGI0kQ8le4+K+OgOWxAZZrWOBZAYo6gIbGY/R6xU7jofxpsYJtGbSRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubNnfJ6A1LiUVY4dtRn3SrypsxpecCkb+3TibgJ2bzg=;
 b=w6NJvdGh2e3iLgpAQ270pTyGICf+KugufqoM96RalTs+xRe4jo6HD6i4KojbcW0bTON9uF1JbytrwkjDo/IwQBqS1WTctmUPvcKW5+ingXonkqFWPI8ywBNcweyLoBrHwSB9yKR6ad39k7D1YlykO7n2oT+GHDaCOyhqASVxwEQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5421.namprd10.prod.outlook.com
 (2603:10b6:a03:304::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 07:49:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 07:49:55 +0000
Date:   Thu, 7 Apr 2022 10:49:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192u: use min_t/max_t macros instead of
 if else
Message-ID: <20220407074945.GJ3293@kadam>
References: <cover.1649288226.git.remckee0@gmail.com>
 <9855c33d65558f7d2e66805009444288b99f9248.1649288226.git.remckee0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9855c33d65558f7d2e66805009444288b99f9248.1649288226.git.remckee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923d09c5-26d7-4081-8034-08da186b34d5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5421:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54213B9B72589718EC43E9258EE69@SJ0PR10MB5421.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfJ3nEGC2bPY12ZjgxoLbRWzInCsFiVy6NNGM2glQIZiQTorZuXRMNAPIufoI+gxZtsYDXxwdxLm2fRKXOSZcX2gEqMiUYoFsac2JLfBx01DnsaELsv0MgwvmxT6DoRgBQAE9N0gRREZruQjXweqfecF7JJLRCiIAIFnUpW9gg5cv+gDQBtiWa3eUpigob/OnOXLNu08kOHOj5hg6Ae634ibQdyF6BAyZ2eJe9m4tR9dPnEwfQhpgc1xU3APC4VtNwTQGvuQsv68WR31LFUItkMgSYRfFPKAYhjxQZ136qchBwZ1/9MEyIp7BIO+uU+8Hmqb+1xwNYnXQOg97b0JD60VZj/Wof79y1d58ni45jnZGgd0vMUm2/0pm7Y4CqyWmzRemHj+CZqC+LuQh7ppvLo4xLzNXtILOn/bwErm5JMvHX9DcxDKuz9h2Cd7fKFmyaVOyUYEXEF6nTpc5B3NhbGK1sX1n0txwhYxEZPQkGRvEOoVgl1OE2CAE+9petEVpExPqLzr3hX3radbARLaFHHzu4FuiYkcIeb+EYmIbEBg0xzh7aHkLNQShPFglKxqh4HxLThJKA6N6q6kQr6YhZucnKBrtdsT6WuQZ3hHTA94iIUTXxNaFsgyLFMnvokG4yL9Lhpm3MI0GxA2tYLxiNoLwqhUZ3h+hVl15HejdstmlMMUmwQXOVTL3beceXdaeBcXNkQtkheswsvLNb4Pnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(186003)(26005)(44832011)(38350700002)(38100700002)(8936002)(5660300002)(1076003)(66946007)(316002)(2906002)(33716001)(6666004)(6512007)(9686003)(6506007)(52116002)(86362001)(508600001)(66556008)(4326008)(6486002)(8676002)(66476007)(6916009)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3UDWiqVSLu2UR82InGJskddA1omLEeU4vGxqMOb6/+q29qPKGCP7I1InWjr?=
 =?us-ascii?Q?bsxhjEXoNdvXlxZAFWKjwI5cK+z/CPpKyCAXy9u+hys4uFM9kL2wKS6cvabY?=
 =?us-ascii?Q?i1IeCrSHXeu6BUAse5ZrMu9z+ocxxfePOBW8yFXjj2bNdyWnLCdjdHl4ynOY?=
 =?us-ascii?Q?xLoHVJgCnTm76W9ebOOgNGc6UzVAMZK/a27hWAWppUBbAhKGVVe0E5X1s8vZ?=
 =?us-ascii?Q?jxmmUNireUVmLrML4zmrxLv855Jlbr9zL6TvF69lPnrA9GWWInjPEoTjNIdw?=
 =?us-ascii?Q?IdSS/G6jCSxIOzN92WzyYcDhDwebaWVDTilBP2t5Naq5wqC2XhSffcIMWDyR?=
 =?us-ascii?Q?7Imnd3rMZW9+P5o9amiNvlccMg30Gg7kgdbnxTQQCj2nauQJqqV/F5JPvToa?=
 =?us-ascii?Q?caWR4aM169k0rMAMTIHEKqyhMq6zJX5CbTHYYBH6J9p3XPqdqX6bNvbweu0U?=
 =?us-ascii?Q?bbKVdNSxbJ1pgbdELA5c2bRS1WGCCXXSY64mWyXBGaKQdP1JXGAog4nIJt17?=
 =?us-ascii?Q?6XD0ZRhvsl7E7GrJgYAsjifJAvpmndMpnoDS8Qe9kY9dgzhRsB3Fd3QdwmAn?=
 =?us-ascii?Q?srvBcQOT0qjeYhSYz4DQcAqH2tOYIqFYDeE1OHH5n+XLncsEDrlaufGzDzZ8?=
 =?us-ascii?Q?aL/oNW4N9VyM4LKEKBXOoucLA7ZFYsZXO6AeFd/EwbNXu1abJJ8LF6v4J92k?=
 =?us-ascii?Q?pEJ3VrHRRbxA/XqhrTO1Npa+zVfM3A2Ngri5pY9WMR3aIGbYm5y/LHe/oxvd?=
 =?us-ascii?Q?9KxKX+7vWLaT72W2KVYhWFlKirsvsXin1ONZN5xEhPPStG7k1FJ3UPJSIpTv?=
 =?us-ascii?Q?lfwOIMgo8xVF3nHNhm2P9yL/z2oK8Y0eplCXhI3z3U6mVFdPcWp/8soEv+TJ?=
 =?us-ascii?Q?pgRoOkRUPW4AX84+RponoZhyA/MNLYuSeQGJKZSnEU2UF+yLTcdXzJavUB1O?=
 =?us-ascii?Q?LUd7iQQpg8SoN3KgJqLMlijaqux59L8fiPpD8qmXP3ZR66puOMElWFl8luWD?=
 =?us-ascii?Q?/bSm4rPiVEjcFPR67yd31stmyHbz6qug+jZGX3d4nSCJLYEaS05EX6KTJpw+?=
 =?us-ascii?Q?Qs1YeFSJ0rKU0pT/171DWKrNNLVhwV2q0SljGZgNPIyZTKqorwGpsk3xgNID?=
 =?us-ascii?Q?t6nbQKE2rO4476KxSvfPsFFF/xB4getciRw3srYSllOFEbnL1Ag4SkBeh2rD?=
 =?us-ascii?Q?WWlCgtJV1P42AkMgjtpy4XrQC+OzLqPDEF6SvhYNJFFKhqyh0i3jctj9LxIK?=
 =?us-ascii?Q?C/v6UrMVgpvoshJ6RwAVdivOBBxi1Hd7159QSIglBkuU3TikItaj7VuRTD8Q?=
 =?us-ascii?Q?lgH+Hbvv/5talRPCYT4VJuk4KSvVrjoEqVIBiT2XqGVKTDbmXsaWhErXO+sf?=
 =?us-ascii?Q?n9QDGRqqnFzFApQ2lCdPzBTfl9RNrgZtyA1rgx5sgNwLGWvQUAps55tnSgJ+?=
 =?us-ascii?Q?hzQ9bZsj1xOLzAmo7BJH1XXSc8DiRO06eIIbCBqnzKGaxoe7qAk4Tlv7oV9I?=
 =?us-ascii?Q?Lh9ZHavpsllr7mmLL5wCsk6oUfS2TTh4iAUSx7mRjhy1FSZjHFZYwkd6htQ3?=
 =?us-ascii?Q?3UOvUDymxisWattPtaXBPIWN/BIk/Ov7yTIZwQVR9gW8mo09yNuh7kfE7a5c?=
 =?us-ascii?Q?3fzhtO9U/RkHGZZCWWhQbyJn/dsFI1eAW+xRzj486ZUZBH2jL9iCltVPNZME?=
 =?us-ascii?Q?puJI8XOTD4VnnUv/+Ti2qdfDOOsClP7zsCX+VXHUFaui0lJ2/YICoMV13KEd?=
 =?us-ascii?Q?Dcl4gLx3um0xBABkG4S7BGZB8didrss=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923d09c5-26d7-4081-8034-08da186b34d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 07:49:55.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSh6Dw94ogfufeUlC3POFM2zLRobxM0zOqrfvEdArLdcIt5Dec2BytYaji/Qqr8DiIsSNZqSx1GWaLnjjlp0hzZJvypreVzx7PWN1DAWiII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070039
X-Proofpoint-GUID: o8ka49jmNRofKp4h8yQ38v8arRS4Ihji
X-Proofpoint-ORIG-GUID: o8ka49jmNRofKp4h8yQ38v8arRS4Ihji
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:09:44PM -0500, Rebecca Mckeever wrote:
> Replace if else statement with min_t or max_t macros to increase
> readability and conform to Linux kernel coding style. The _t versions
> of the macros must be used to avoid applying typeof to the bit fields
> pPeerHTCap->MaxRxAMPDUFactor, and pPeerHTCap->MPDUDensity.
> Found with minmax coccinelle script.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> index dba3f2db9f48..8f2cd669c5d4 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> @@ -940,10 +940,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
>  			else
>  				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
>  		} else {
> -			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
> -				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
> -			else
> -				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
> +			pHTInfo->CurrentAMPDUFactor = min_t(u8, pPeerHTCap->MaxRxAMPDUFactor,
> +							    HT_AGG_SIZE_32K);

The u8 cast doesn't cause a problem, but it makes me nervous so I have
to look up the types involved.

pPeerHTCap->MaxRxAMPDUFactor is 2 bits of a u8.
HT_AGG_SIZE_32K is an enum, which in real life terms of the compilers we
use is going to be a uint.

With min_t() you want to do the casts to a large enough unsigned type
so that it doesn't truncate.  And so u8 works.  But it would be less
scary if you cast it to a u32 or uint because a read will assume that
probably pPeerHTCap->MaxRxAMPDUFactor is a u32 and HT_AGG_SIZE_32K is an
int.  These are false assumptions, but probably that's what most people
will assume.

The reader in this case will feel safe and not worry about truncation so
they won't have to look up the types.

regards,
dan carpenter

