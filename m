Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8154B134D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiBJQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiBJQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:42:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80131.outbound.protection.outlook.com [40.107.8.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D62E87;
        Thu, 10 Feb 2022 08:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/MKSxMrqkJVvjFqmDsxc7y2e8Rf0i+ses3DNPc8XCEuBtA4UknsrSSXWCtZ/bGGCUlhXxNXjPi3XZS16cWUWxmN3zSaYRaIVSKJ4ms8fK1nyLLT8+JAgIpZIykmTZCI3ontwDDUVFx4vu8uU6ZMmgNkHyBinK/d6MZw7javxiGq0ilG2eynV2pM23ms7815Oi3RYF6bf2fDrE4KZ0rTi4pL8ogmFxJN4/3UbQ/lr56AeYqlg9up18mDpaDDlmQoXv5dMApRUxXpr2AQMnTdwU3NR3YNrJraFsOqMXgMX8nSLwECVChBKaWw6JYxQyd/D73igjgKsPB4Q+mAVY7uoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHjby0Z61ssEsArNtgJusHMxvjAJOduWKgsAuFML+6M=;
 b=GWeKLK7RzGz4jfHrW84n1urGm3PuotA7sjuj6/wlUR3B5Zvhe+zsiFInj3rfOhHGsyBBsnsf6CuCYF5mrNqZ03kcpos8F8dZ2cCAJAkw3L27aiM9i4uteaJFPxKHKVP4FnDlOYS5odZul/SNKvg+xA9PMm1JAHj3es62grkTDsAMfJEWpoT2xgf09/v6Dz+bpPuQp3GzEemLrk8vjpyShYctzLW/Av3PQNUqwF2pQRBKtyJgiBnDoVVnVgFlrszVr+ExcXD6+P1gUxM6gVIyCE7fQr/ZiGkxd3YXY777ZmwDbUK1N32APIlIhtdEOCNpC+iz2XO4Eoj6unz3pfKyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHjby0Z61ssEsArNtgJusHMxvjAJOduWKgsAuFML+6M=;
 b=ZAZSbqM0EMFcjCgH7LBnd5/afWwIqzcgKSDtBT4Krwkl9Bju1drWdke6I2OwydyLLBZ1ZCWkauekDbfB1Bf+3wfTjiuRxzu+l/LcZ7qr3Uj+dl9lxZw74VSqrWMk2fid2eLl87pCfIMpwhYkA08q597JwXO6+9HViEGfNiwWM9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by HE1PR0201MB2187.eurprd02.prod.outlook.com (2603:10a6:3:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 16:42:31 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::dcfc:1278:ab19:ed07%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:42:31 +0000
Message-ID: <fbb84b08-5d3d-3684-fdee-5ce367280857@axentia.se>
Date:   Thu, 10 Feb 2022 17:42:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Content-Language: sv-SE
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-3-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20220208020441.3081162-3-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0389.eurprd05.prod.outlook.com
 (2603:10a6:7:94::48) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faaa2cb5-d9f3-47a7-75ca-08d9ecb454a1
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2187:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2187585109DB13977ADBDA72BC2F9@HE1PR0201MB2187.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNVI9DLZ64NXOSsg/LYsR1bwqjqGUgEuPKGGugyYid11sUpeYkfqFgoVqPqBRk/WKCuBI+X+8f1USQR0Ao1qNEdHBH3qf8KYhdRuNyT3io2dwDF9SuM+VhzzMIfhKHU1cy4K3rcHXFvGseKKnlGJYipchVeSdlo0SOMrS+c87MfR83bBjliRQZhe6U+WYQj49fy3wSdUFcjEdzP/XLTQ4oWCjXyzxcV4AqS073QGsJLpIdN8B1S9dl0MxgBKOjxaJ0AgpqB6c3pPxsovzlgkXiRKAVV3mut+f10HeqOv9IJjAkLt3PxQIYzwnE5HUYRXrjLXBCg7paYQC+lAr08XRk3Eh81K6Ge0nNxr6ccrWyU7oPwdoeYGPYol+b4UgncbY5U4haSBQAAk6CMKJTx2MYPq0zSoQ9QHUE/gCemKz+O6ho0cPGJaT9nrJ7YikVj3x1t7G0k4z+5WQ8LMr8ffRW+72X76MEUjLSRJSfh0axf/oJlEQ5r+YeuNTe5oR9Fr+CgZPo0gmXWN9JUZXIRxWGYSIBfSm/WZ+amXiBsBE2tiQkjz4WY0JRCjlIZj1/o+BEknc8VHktaTbNDjd15dEwJMW/ZB8Vi6K0p3l3FPgtMSd5AbLFHPEXE5BgSR/HMCNHiiIE6QzwcQUe5pJdBlaNxyDLYsfwHdRFx79uj0zUdMshnRl8Y2CT0dzFnuM7oo9CRFcyJA9kaQxrJ6h5Sk3+2OTz22v65ST+D1U1OjU+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(366004)(396003)(39840400004)(346002)(2906002)(31686004)(38100700002)(36916002)(6506007)(5660300002)(53546011)(508600001)(6486002)(6666004)(8936002)(8676002)(6512007)(26005)(186003)(2616005)(4326008)(36756003)(66946007)(66556008)(86362001)(316002)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlOd0tWN1JjUWJLSCtTL0hQQUdOS3lSN0JqWDB2cmlXdXJZaHZ3NmtlNzBB?=
 =?utf-8?B?UlFNNjkxVlI1emx6NzZNams2WHRVNzUzcVRRaUNXM1Q5MWZIdkM4L2hDbUdp?=
 =?utf-8?B?TExWbEVWdlY2bFF4VHBGSktweFFQMTdzbGlMOXRCdHVBYlRFRDJKSi83ek0x?=
 =?utf-8?B?Q281VmZFWW55eEQxR2VIaWVZRFZEQUdlZjcwaDFKcUpRS2hBRFh0OUQwOEMy?=
 =?utf-8?B?clJ5ZW0vaVVyQThJWnE1aTVJUlBwRnl1UDFtUHVjeUhRVXVaRUt0aHUydXp2?=
 =?utf-8?B?VHowOGF3WUFCamNjQ0NmRmloY0lwWEJ3b1cvejFpdktKbFhJVTJxRVpQcEpH?=
 =?utf-8?B?cWFLNXdpRzJybkFjalliMitDQkRmemNxRGNzS1BPMm5MZ1FiZEVHWFJrbncr?=
 =?utf-8?B?aEYyc2ZvRTF5L09NelFXdmpnbnVQS2ZTenp1UDJubGdBTlJMM2ZtUkhMVEpn?=
 =?utf-8?B?ekd0VWw2RCtqN1hoeFIycldpbGxhY2dranN2YklNaVF3WjNmMXZQeW0yT2t1?=
 =?utf-8?B?aWFCZGJZNEdRTnV2YkQ4Q3NiNk9uNWlHS2pUZElrd0lVTkQ0czk4R0Z6Rmln?=
 =?utf-8?B?TWVOb2l1SENoZUJVUUFmaXBSSkZNQnZYcUY4clZoemE5Rm8xYlJsQ3BHVVNj?=
 =?utf-8?B?aGZMK1BRNGRvWEYvOHV0eU54cWhVNm04QlF3dFU3ZFA0bUZobEhxWkhJdW1k?=
 =?utf-8?B?T0dWWGh6VmkxL3ZoY1FLbFhIM0drNCs0eG9BOU84QW1IUXpxN1loTjN1aTI3?=
 =?utf-8?B?NUVidTk1YWpKMjRFdlNzeDIwS0FXN2NJY0pnZmtrTHNXcGpBa2lGWHRrNXlu?=
 =?utf-8?B?Qm9IYUpJYnh6QnlMTFYxS0w4RW1VMGZwbklObEhXdXduT3dVaGRvZUZyQ1BV?=
 =?utf-8?B?UDY4UUdIdktGQnk0bEl0dUlpeGdKdUlwYzVhZ0ZYL2NRNHN4YVdScktLY2N1?=
 =?utf-8?B?N082d29UR1h0UmdORVFFbWdVVEszdmoza25COHJaYmV6NHEwZnRiTU5RcnpB?=
 =?utf-8?B?ZGZ0WFlETk1UalArdkN3eUdMYm9ibUZPbnorSi8rM21Da0svOGk4WHRTVjBI?=
 =?utf-8?B?dlRIRTQ1OEFTZFZSeWRNNDh3b2pvU2lSRGxsck5Qd01NNUE2algwQ2V1eCtH?=
 =?utf-8?B?akwvYm53SlE2bTRReXQ3ZXN5cUFuWXQ0ZVZ4N3ZrUG5oRGpyRHp5VHo3VUhM?=
 =?utf-8?B?ZFFUVGhBVnhmMEUxQUFsY2dyQmFJdDgyWVpJTVo3azhSaUFpQmpzbExISWds?=
 =?utf-8?B?M2RTajBpNEVxaGpaczZGSkFoNE8xUjh3M05UcGMxZ2d1dWRXQWU5TUFSRm9U?=
 =?utf-8?B?ZkRKMTAwUkc2NU9MOTdRSkFwaWkrV3lRVjE2K0liVHdXdk5RdTlTWDNFb0pV?=
 =?utf-8?B?Sk0yUjA5aWhiRWF1L1ZybmtLeVZLK3pKYTdHdzBuTzBPeC9BTUQ1UnlGUXB1?=
 =?utf-8?B?MkxHQkg3OCtDMmNrNW9RSkdKTVdIQjZEYzZyM0VyWW9CSjkxUFFjakM1bVJy?=
 =?utf-8?B?c01hNU03T3lvbjdDcUtMK1pQZ2k5cUdRMWYvMFpGb2lSMjBENmhvOFhLSkFl?=
 =?utf-8?B?bGdvcWpjbFlwNVQ2WTNpUG1PKzBiUVVabGxiQnFrdW4wdDNTenNicUFqeGYx?=
 =?utf-8?B?alpPZmcvQkQwV3lkcnRrRFlhcGE0MVNPWUdjbk1TNmdGYjJOT0xJZzRoYWxi?=
 =?utf-8?B?dWJJUzhucEhTcXpIK1R1MEppT3BkWmVybFYzbkpQa056dWQvcDFPZnlmQU9D?=
 =?utf-8?B?UzJDQnhRYkx5RUo2cktFWFZYZDdvbGZ3MjcvWU5uSFI3MjZ6bjNEeFRJOEVW?=
 =?utf-8?B?dk1vRndBVUpWd3BzUkdlNmNxMHpOMGtzSytFaWF2ZGpxK0IyemhvU2gzM0xU?=
 =?utf-8?B?QzBlYVdmQ2pkeGFyWU02N1lXZSs0QkxIRjRDT2hxa3Qva2xmeUNMNWZ4L3RG?=
 =?utf-8?B?UHgyMUwwSjlXeVljby9KUE5rbXljSTZkYjhxMnlOMHZmbFY5OVZoRHlEUVp2?=
 =?utf-8?B?Y1FOM3JwY3ZzbWw3c3ZHcnV2ZnZmWXljbGh6NEdQZENtS2hXT2QwUFhUVkRp?=
 =?utf-8?B?REdzM25DdlZIUXZrRVZWZ0FxRC9INXdSaHNkZGZOYmJha2RFR2pCemV3Q1N2?=
 =?utf-8?Q?Al5Y=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: faaa2cb5-d9f3-47a7-75ca-08d9ecb454a1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:42:30.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +z0gZ5EAxyVY6/A5yzIxmcozsokALHlQS4QqeeZ9gDiwdPe7sWDr0HPJtvYUElCG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As usual, sorry for my low bandwidth.

On 2022-02-08 03:04, Liam Beguin wrote:
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 65832dd09249..f833eb38f8bb 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/afe/rescale.h>
>  #include <linux/iio/consumer.h>
> @@ -23,6 +24,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  			  int *val, int *val2)
>  {
>  	s64 tmp;
> +	s32 rem;
> +	u32 mult;
> +	u32 neg;
>  
>  	switch (scale_type) {
>  	case IIO_VAL_FRACTIONAL:
> @@ -41,6 +45,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		tmp *= rescale->numerator;
>  		tmp = div_s64(tmp, 1000000000LL);
>  		*val = tmp;
> +		return scale_type;
> +	case IIO_VAL_INT_PLUS_NANO:
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;

By now, we all agree that the big numbers in this context have nothing
to do with unit prefixes of physical quantities, so the macros are not
really appropriate. However, in this case we have IIO_VAL_INT_PLUS_NANO
and IIO_VAL_INT_PLUS_MICRO. Not using "NANO : MICRO" here, and instead
go with "GIGA : MEGA" is just plain silly, if you ask me.

So, either "NANO : MICRO" or "1000000000 : 1000000".

I'm not sold on the macros. I frankly don't see all that much value
in them and am perfectly fine with raw numbers. To me, it just looks
like someone has read somewhere that constants should not appear in
the code, and from that concluded that #define TEN 10 is a good thing
without thinking very much about it. There is also the possibility
that someone who has never seen these defines thinks MEGA is 2^20
instead of 10^6, because that is a much more likely candidate for a
define in the frist place (not everybody knows all the digits of
1048576 by heart and 1 << 20 many times require extra brackets that
might make it look more complicated than it needs to be).

Back to this case; the connection to the naming of IIO_VAL_INT_PLUS_NANO
(and ..._MICRO) makes it ok to use the defines. So if you feel strongly
about not using "1000000000 : 1000000" I'm ok with that.

Cheers,
Peter

> +
> +		/*
> +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
> +		 * OR *val2 is negative the schan scale is negative, i.e.
> +		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
> +		 */
> +		neg = *val < 0 || *val2 < 0;
> +
> +		tmp = (s64)abs(*val) * abs(rescale->numerator);
> +		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> +
> +		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> +		tmp = div_s64(tmp, abs(rescale->denominator));
> +
> +		*val += div_s64_rem(tmp, mult, val2);
> +
> +		/*
> +		 * If only one of the rescaler elements or the schan scale is
> +		 * negative, the combined scale is negative.
> +		 */
> +		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> +			if (*val)
> +				*val = -*val;
> +			else
> +				*val2 = -*val2;
> +		}
> +
>  		return scale_type;
>  	default:
>  		return -EOPNOTSUPP;
