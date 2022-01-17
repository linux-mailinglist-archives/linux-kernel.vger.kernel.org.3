Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57E1490220
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiAQGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:54:31 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:32481
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234779AbiAQGy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:54:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4hpYXBo9es7lEKgG0bgmbXkjXqXjdJ3rlB25eVANDmeOqZFHoAHE3Qm7KjM9FyMV/HZDba44WFWHsrS+Sa5c+PjmYpjvbkIAwoEM3N6WZcXaDacYD06+LPqA14PgO7nUoirnAaZ/EO0Iwwwz9GzQNBJBX7ak7Um4UCUs+EyDRPr94Ja2c3TtFWgmkTINnu2a98uSXtosxYGTDanqblTzmEqFWQT0fRUY1mGqFz9VCLPEjUPqzK/h4qidv9xQjXWc4fcJwVL60U5/LrRFzmDDwucfjepgu/k2IDtNj7Qy72/keMSD3lHCz3tYPv6lPb6FAs9IuP8ZIzetMFDzCP1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4pIC4nL2Ffea+ifiPpHtgsApXsM57ZlGGp+C0Y92dw=;
 b=TPZ59koYzKmn0NwELiYWN0l2pcL2wJntA5+H/v22cPdiXL+VXcaArMlzrKTTVXnphsZqq0oBB+1Nhxp0TuVYlzfOqOoFio6F5bksio2eziu7lo62mIDQ64bdV9VmO4iM1Vt0sJ4VxrBG5FVJqMgS6K+Hhu3lRqYkMHQVCXZWQIaSc2HZx/odYvlI39OFg9/DT31//go1HrxJwKc8i8Jy17+tsf20VlFNWafUkPsFfEJG1ulA/HeaNiY04zig2ihj7YbrBoh66Aitu0hBgyoJkRLHhV8FUFa91U7z9CqmdPUE9tYZJOgNusvRCvzdBr9J7f+/m1g1aKUl/NC3psNA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pIC4nL2Ffea+ifiPpHtgsApXsM57ZlGGp+C0Y92dw=;
 b=hOvwq3YqllrxEzN5qHuUMO8FfPwjBBekV/Obb8MbXahY3bPak76CvXaU/k+3EsU5oikjEM9qZHOIzabVoYx+7EYXJTLuT1H7WNQhxo/4T6B22Qz7HO6nn5J0HlQNqqODvDav0q4aNA87gCUi5DS99YHGgKReK/H5M35D41q8tXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR08MB2907.eurprd08.prod.outlook.com (2603:10a6:7:2d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 06:54:25 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294%4]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 06:54:25 +0000
Message-ID: <cf821d43-6f9c-f05e-c479-7970aeda9986@wolfvision.net>
Date:   Mon, 17 Jan 2022 07:54:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220116124911.65203-1-linux@fw-web.de>
 <20220116124911.65203-2-linux@fw-web.de>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220116124911.65203-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1b3caf-cb42-43cc-dbca-08d9d986330f
X-MS-TrafficTypeDiagnostic: HE1PR08MB2907:EE_
X-Microsoft-Antispam-PRVS: <HE1PR08MB29077263211C7EB99A8005B6F2579@HE1PR08MB2907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdLdaFSWF70MYaMVrTgrhFC+Z2vk9KTCFAtmrMxbMk557PXLwTaKppUYtTDeokEP/4s0fTpcLEu0FmxCcsMTxHmEgfkcbhYQKUKPY9AFALlaE6US73HJEqPRTrSbMHHi4jAPqJd864nlj2boizj/Zo8xlhsnW7tTrvWsq2evPXFSNf1Gb82ReZgCdtTWwgf3H5zgHiyuYp523qklTAOLDacqpCwE+971GbJVtPekmuGJ5308C//6xDB3h1m9XUcCw+StT/9l02ZikWLJaYVC9oc1yM9HBoJ+htMiQ4eDA38FzpVNtxeDd3FB5v5h99Cif/i3QrNhWkOdO8vgT4q8VpWoEmSwSiw02mH2loLokP09bzp+w1EzcU42GV+CKdt/TmYzmJ5qaUjyfeLj/XcerWbuHLX4p/W/Url8RvHIEK68SFvjbfjoqMDF+d5GhgmLINoaqfokL1l73QQbGwOSKbKKObrdIwc+U0vbGBnwOqBeCY45FRYuW/0dzO+xiKnhOFZ0MjnCUdXB+ElIL95OEsYIH6ajl9FfyfI5UpBEisMgeKxkc7hOrBug/p6XPgJEWbgmJeu5k5y2eYr9ovEL/FZrwD/W3H953nLWT+WJM0dOEXJM0LXAoGxTt8sE8r4cAKbPgw3WXGlInZeP6blwE1SFopb4Oe2eED7HgFXlQmzzWKadYohWtELy+7SZJnxjtsbQVsF8olzvIp4srnL+qmgDYmP0Jl72rNg6QeS2MIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(8676002)(36756003)(8936002)(86362001)(31686004)(2906002)(44832011)(6486002)(38100700002)(53546011)(6506007)(54906003)(186003)(316002)(508600001)(83380400001)(66946007)(5660300002)(6512007)(52116002)(2616005)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHpaU0lIbXhobXRVaUVUdTBhV0ovKy81dWFDTFJoaVYraWhzNUR2U2x5Q0xM?=
 =?utf-8?B?cm9TTHRaUmFyNU5ObkErUzNmUkVwRHFVWW5WTkpwQjZ1STdCT1ltNitFQ0x6?=
 =?utf-8?B?OUJHMmlHbTB1dm01M3VzOURkMlZCMkE3a05mOUhhTHFIV3N2UjJxbmdtQk9l?=
 =?utf-8?B?NnY0bExid0t4WWIybWdwTmVlcXZaTlNibkxBb3VKOW0xVGtUS2VWOXFmNmZL?=
 =?utf-8?B?SFdvWTZWWHRHSkZnaUlFYUV4SzNwVlJpZDZXOXN3MlhlS1VuTkcvZk0xa3Iz?=
 =?utf-8?B?UUlYb0hqQjI5Z2ZCb3BMVWdkMnZsTHFlbGl3RnByMk9kUlh1MnpEY1ZFTjVW?=
 =?utf-8?B?aVRZZU5ZckFSRUVmT3pkYnl1bUJmL0tialFPVW9JZXJUMnBOeWJBSG1BSDBX?=
 =?utf-8?B?S3Z4b1pUdVF0emNpQUgzeVFiRFJiWTlxSnVSR2Y5TkJaUHh0MmthZW9VM0xl?=
 =?utf-8?B?Z1JkMUg1Z3R1bHdBclA3aU5pOFJQVkJHNjZPYStqV2FhZzR5Rzd4ekNzTUZG?=
 =?utf-8?B?T1lEUExUclBUOFpnVG5RblVyYy9UVjhsTWdrVEcwWG5Ka3pnMWVPandMeElp?=
 =?utf-8?B?L09CQTZWdk90WTAydTJla0lLOHBUM2ZCS1lOcXhMTitmWU9tZWxaSGhyNUUx?=
 =?utf-8?B?Zjl1NnRTclBFVnFMWG1UN0dZZUsyZzVIb3VSVFNaMnBReC92bkh6bWx3bnpF?=
 =?utf-8?B?TWlVM1c1cGpCR2VZenFaVzAwR2pBd0E4SklzTVUvdTNpbHhZUnlTZzBST3h1?=
 =?utf-8?B?dkpPMTBmbUp6bXNBR2JiVGZLVGN5dFZzYXd5SGI2d1lVYTJvdjJ2Q1dIQk15?=
 =?utf-8?B?dDR2b21QSG1sdXBPeWl5QXFETWorZVRxQ2wvWDU0VXZJTlRTUUk5UkY3dEhk?=
 =?utf-8?B?dllxNlRaUkw4dUxZRC9ucGY3ZGlNcGRBR09xd3NMT2tZVTU3REp6T1QxTWw3?=
 =?utf-8?B?QUNtSTV1Nml5d3pzMXJyZmFrbkVrTHV0cmVqTTRsSDdJSWt3RTFHYUY3bk9w?=
 =?utf-8?B?ajYwMzluZ1E2d21FSGJrMy9HakJjWkZnT3hkR2hxZDNOQXlBL0ptSm56VjdY?=
 =?utf-8?B?dTRDNVgvQmluek5qWFFabHh5ajN1SnpROU9TblAyQ2hSN2o3LzdYVlZtMTRE?=
 =?utf-8?B?Nzk4TWQ0cXhDZXhzaU1EY3RpbnBjVnpwQXlZTnVQbFUxOG1ING01ZnlpdUVu?=
 =?utf-8?B?VWY5ZjRUMXB0amlNbzJweHlIcjRKa3Y1N3hwSElEdXNHU1hYRTlNVkxIVjJV?=
 =?utf-8?B?VG1NRndSelNrRWtNRjhKWWhvTHdiL2JoRE41d3RQTHNIN0pNZ0JBYTNQRUdD?=
 =?utf-8?B?b1RpNUJnRjRJY3JkalU1bXRxT01WNHFuR0ZZNGtYcUY4ZkYrSUJOWnhiRXI4?=
 =?utf-8?B?eTl2RzhFVmhQVkhMb0tqZXJhYXBHMVgrKzV2ZGZMOUtMdHE0eURISlBKRjNX?=
 =?utf-8?B?UFV3NXlWZTdVaDlXOXF2NmZFaGVKUkNCLzBNb0M4ZWZaR3Z5M2tudklJaFFD?=
 =?utf-8?B?V2tZSm1rZ1FWc3JHYkg2MVZRMkZ4d0F0WHE3RGVRWVd5eUUwTVlYM093bElW?=
 =?utf-8?B?cVJSUXFycXE1L3J3bmNoWDRkejVCTWRFQUd3TENuTVNjNzh1S0RyVUJkc256?=
 =?utf-8?B?TnFpOFN3blpKNDdMMkVtL3E1NUs4Tng3SVVEcUgzV1BRWWIwUmxRdVFuYTBo?=
 =?utf-8?B?SGh2RUlDWlpLbXZlT0lEcE11Nnpiamt0bUlLcXRPQTcyejIxYjF5cmtheW1n?=
 =?utf-8?B?K1JORXNYVDRIZnpMS0RWcklEU0RTRmtjc1d0TGRZWnAyRldybzU5eUZIb1RD?=
 =?utf-8?B?czdQYkZtNVM3US9vMXdSNUtJSG43eWwvdkZmS2lGMnA4NmpiazRtbWs1Vnl3?=
 =?utf-8?B?RHgxa3lEODhNL3RMTGQ3UDBGWTM3OHRkSkJMTUxyWmdGQkVqanprSEs1ZjFx?=
 =?utf-8?B?MnBlRUFOZ3VXdHhhZWJHUUt6TUJaSmQzbEpCT2Q5YjBadk9VS3FrZ3lmSzFh?=
 =?utf-8?B?SDIrTXRyT01zZkU1MmlqRGZrd2VDUmJpU0Y4WVl1VDUwU21TM3o5VmtUaWo3?=
 =?utf-8?B?SWwrRGlRaEd2OThNdndsWk50cXNwZExUc1AySEh3WjBBcmxhU1ZJM0xNRmFV?=
 =?utf-8?B?OHhDSDM5U0o1d1UvZzNTK3Q2MVpxQVdyd3ZkZitnNTlTVUVocnUzSVFpZGpx?=
 =?utf-8?B?RDhYS01Ja2NUSkI2NDJVeTh3S3U0MURNenJjaXJ6K25iZllxZ1FuZEdrZ2ZC?=
 =?utf-8?B?SEk5WEpURDNWMkJMRzBCdzRiN096aGF1Wjl1bE1FcWMrWVRGS2c2SXZZWlk2?=
 =?utf-8?B?eVIvTWhROG5VVzlxYW5sWnZFQTA2aXd3ZTV5c0NQaG11OFU5RjZtM094K080?=
 =?utf-8?Q?cKiVZ94EpBrKCULY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1b3caf-cb42-43cc-dbca-08d9d986330f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:54:25.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbd/aPXQSBOX0rM2GeajilQC0KGCJXqsoxV4ZOPiA4MzzTW2VvwF1FUVOKxkcfdKuwAM9Bwog+yplqCtxW0XskadxaxCckNRxZM4+sMACOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank,

On 1/16/22 13:49, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> pclk_xpcs is not supported and breaks dtbs_check, so remove it
> 
> following warnings occour, and many more
> 
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
>     [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
>     [15, 389], [15, 185], [15, 172]] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
>     ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
>     'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> 
> after removing the clock the other warnings are also gone.
> 
> Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 2fd313a295f8..d91df1cde736 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -32,13 +32,11 @@ gmac0: ethernet@fe2a0000 {
>  		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
>  			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
>  			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
> -			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
> -			 <&cru PCLK_XPCS>;
> +			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>;
>  		clock-names = "stmmaceth", "mac_clk_rx",
>  			      "mac_clk_tx", "clk_mac_refout",
>  			      "aclk_mac", "pclk_mac",
> -			      "clk_mac_speed", "ptp_ref",
> -			      "pclk_xpcs";
> +			      "clk_mac_speed", "ptp_ref";
>  		resets = <&cru SRST_A_GMAC0>;
>  		reset-names = "stmmaceth";
>  		rockchip,grf = <&grf>;

This has been on my TODO list for a while, but I never found the time to
submit this cleanup. As far as I am concerned:

Acked-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael
