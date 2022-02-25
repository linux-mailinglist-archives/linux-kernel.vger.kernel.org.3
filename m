Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205E4C4B95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiBYRCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiBYRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:02:17 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00066.outbound.protection.outlook.com [40.107.0.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE11D528A;
        Fri, 25 Feb 2022 09:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZpWhKZ6xMvP6eK7erQBczM86fhOqJtBTX0P1R7qxDl4PDHD2Fea9ONa20qvUWA5fFPuAzWu9LwACZuJfRnrcLNnWP3X7opfLJ+ziBXzvYSj43/33yqIugOIl8e6TDvryw3eGbz4UGVCps7qBTiBl5JvonwbpLnkBqA3mdGS5gAPvfaK1dRuBTyRl108VxosSuRn47cV1SOZs2lOHs6FxYQ8YZMkchRF3c0O0SvrkGHPu3i6gA3drpuPUAUrpNAXtYaMt1pBHc1xqtDYd0X84j62WyA5ZHhnVA0+F0cPblAM2+52gYVfEGmEWuresVSgv0JxeXyHcLQ5MEmDCFQeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz/B+qzp9bywG6BE2DZQAE7HZjk4pmFaLDU6LCad9Ys=;
 b=YX9BikklQ+IC+l+Kcbyxfk76dbYv3weZRgUws2odnuGY79mtmOeSKylZRiG2Sbix/0koScjJ8lyYkGeb3+7kmjBNJXkKLya2AarJum1MGhN+jn9h+HKmM8L3k7ZRgB1GEx8mrnP0WzbXIMlFLQdyC6+XOKhLuICtscyMUKPL0Z9lOb8kBXBi3XtbBEGsE0tOhFt+Yrj1NfLicWg8iM4BytRv9GApWwactu1Lnx39LsZPGLJ29o6uCjKC20wXUHq5Z7E32IH3f5sKvfW7iWZVVWL5LLQ094lAtOaqF61kCA/FFuWFEastRViiR5nBMAcEkIeZhnZlk6CklDMZGOM5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz/B+qzp9bywG6BE2DZQAE7HZjk4pmFaLDU6LCad9Ys=;
 b=scPx/ciOeAvxmrFPnZqo0MIHnjIt0N2b+UfwpgDwi7Y9WeyRnoLbtinDzAvJ9/eVo4GyCzzEMYQpFXoDFJN67onFDLCDQmTEWwFTYsFwy2KIgpUxkE7uVnWWCLs4fLdSXriqi/O393y11yXr727v6DZJdg9xcs6LHvoVlKRV54Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DBBPR08MB4458.eurprd08.prod.outlook.com (2603:10a6:10:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 17:01:39 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 17:01:39 +0000
Message-ID: <2f1f09c0-9b7e-5145-fb25-a5f1fe4d0ab4@wolfvision.net>
Date:   Fri, 25 Feb 2022 18:01:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 7/8] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220225145432.422130-1-pgwipeout@gmail.com>
 <20220225145432.422130-8-pgwipeout@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220225145432.422130-8-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ada119-8d20-4eaf-be3d-08d9f8807d1b
X-MS-TrafficTypeDiagnostic: DBBPR08MB4458:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB4458E03FD0ADA305A6AAA0CDF23E9@DBBPR08MB4458.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6m3lCvDJfbnFm0sUZkuq+sfeW3pak6rQzZg3IBFG1CyGJbLDkRBdIAJHVZpDSquV3DE9DsqEGypjcMID5T5b0TNs2nAPKwppAvPTeSvtv8Slr23gS3O1F9O5rfnkA1cpCSGPJCpSMZgXyc+nD+lTYAmXTHS0BQMgAncrAt2Rmq8ldrj1PadWcu6SFnxlX8ZZov/nRVg10PFjarRsjjMquO7lMd+7g6K/GCfzEiUUj8p7J1GD618x2Up/lRWQ+wQZZoAexSLDz41CWhqzxjwuGVSmFSkpAVL35u0WxD66TBRH4pGoAoFI81eweXxz5eu9lAjVLZl3fHLhesfgal8ADZ3mBdffcwt9IvzWDm4NEru6mM8Thh9H+pgI5sJJbjlf+1ngWWNBzieM1t+OwLHRyWYcieyyaSglYk77zd/EbXOgibia7oIuS7n/uVaYMBbuGJh2dbj/YJt+dCq5N+M7c7ZcVzEeQ/HVOc9EYBAu+GN6+4SLNNz/ejOKUNMnu/bb0z9FQa1eRR5GeriKOs8j5J2a2uPaIZLC51UK0GngnByJXLDq2oD0rUpivbZ06z+eDS4WcVh7aD/XagTK4E5GYXyQ72cctDupKHxtOuJ5t0b+83tKEyJumqdqiDLCzX9wP3IS/tEri7YL/xaRXkNhdSQV9XCu7sETkTcB8H1UZuP7beeB5kUCVIo1c9EySp7JvJ+NXju82Zwlu4eCWgGolbURFMY6qINCGb/18z8J1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(136003)(376002)(366004)(346002)(39850400004)(31696002)(53546011)(6506007)(2616005)(6486002)(36756003)(86362001)(4326008)(31686004)(66946007)(6512007)(508600001)(6666004)(186003)(52116002)(316002)(38100700002)(66556008)(83380400001)(110136005)(8936002)(5660300002)(8676002)(44832011)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJONTdqYTdadk16SThTL21VV3ZSdnV4N1R2ckgwdytxTWNTUEczYk5zeGdX?=
 =?utf-8?B?RTNvTGRsL1F5bWJxMkY0bXlKcEh6YVZQbDNsWFdEYUtHMVJId2I2Z05nWHBB?=
 =?utf-8?B?M25XdUhZK2p6ZkJCMnoxcDJiK1NCVEVmWUVyYVltUmxmNld5dGJma0R1Q2dK?=
 =?utf-8?B?OTlhU3B5ZVhsZTIyZmIvZ0tXMlZ3WFZDK1lvd2tvU0NjOCtCQ2QzNm1OYkNQ?=
 =?utf-8?B?NkRaYjFJQWVCQ3YvZSt2MjdYQzZmRUZxMGxhcFh5ckJ4bUVJb2Z5ZFJnV294?=
 =?utf-8?B?YkVLbHRqU1FVdjVVNzZTbUFlaHNzUy9INmk4Zzc5eWF2dXUwcW9SdHY3M01p?=
 =?utf-8?B?bzFRZndGU2ZWSkl1bHJUSTJKSVpQTTUvaUl6MUV4K2JSU2VXSWRmZmhROXJ4?=
 =?utf-8?B?bktXYzhaWHN4ck5TdDRLSEZyUEhpWFVsdy92UGZTa01kbklBUXY5WTcyTmdI?=
 =?utf-8?B?dGpUeDladEpSU2pna3RUdTdVMm1uWnp3NlBkR1g2N2xFemFoZzA4emRJUTdm?=
 =?utf-8?B?MlZxR05VRnJBWmZwMTFhdG5XdGgzaGlScE03cnlGR1BLQWNtMHVQQ3J2SlRH?=
 =?utf-8?B?R0ZjUzFtZ3p6YTNicmlCNnJ3dzl1UG4vcUdpaWNkR01ia05PSGZmZ2NCWVlG?=
 =?utf-8?B?SG0yUTJZcGV3OGhGYi9va2JPeGZSUUplY0dVbzI2MnBwQXR4bncyb21qcHZT?=
 =?utf-8?B?TzRJaFlOdFRPYlUrNE1MRGZrMEQ2L3V3UUpnWk1PT3MrOHV6aWdPcisyYnJi?=
 =?utf-8?B?bEVlNHJXZWJ2WUZqRDdvcEt3NitGR29Gc2N0WTRaakJBZXVuMFBLZXdIdlE3?=
 =?utf-8?B?UDZCcTRQWWVjVExxV0V0V3V3NXRWU2VzYVI3Qi9yTWtmTEVXTVhqN2Jtczht?=
 =?utf-8?B?SENVdDRxLzV2TVJ0OEI2eVlvZ05zL3ZFRlRnRGxCVGNaZS9ScU5hVlBsTHRh?=
 =?utf-8?B?Y1NUVFZ2eWdHUm43UlhzektWMFBRcGkzSFcwT1VGVnZ4ZVVNcUxBcFFPYkFY?=
 =?utf-8?B?MHhYclNOaE5OT0pXNUp0MDBIcEU0eUZNb3dDVkMrS3hQRXgzdkNIVlNMWTVz?=
 =?utf-8?B?SlRSb1ZiVUo1U0NMbVlhVTFhWFZUcEVYR1kwK1dVdGJXbG5vU0RldExQMTZR?=
 =?utf-8?B?eGlrdFJCK3RYLzVFcnJTNGJVZ0NjRG1UK2cvVDlaL2RGaExvTVhrY2Q0cVdi?=
 =?utf-8?B?UTdCZ3AxMkt0VEN3QkVORXpUZWdWVndubVNUd2NUbnBmNDVlOWd2UUJPYklj?=
 =?utf-8?B?eTZuMmRZazFwM3g2ak9YcVEvemdMOVJsVXpjQ2ZIMDd1ekR4SWt3ZjdFckRE?=
 =?utf-8?B?ZDdjYUxGTW0vckhFYzF6TEV5R1ZIeTVhMDhCdERjZmc1VkR4WmNsYjYrYWJO?=
 =?utf-8?B?RnNBMWNDTkRJOTJ0SFhSOUNKMytZdzJ4M0dmYzk1eGVWeUVKbmVteWl4WEpI?=
 =?utf-8?B?K21nTHFSbUF3RjlibHY1ZWxjd29lUHA0R0oydlZxb2JyWHVxTEt3cEtIMWdu?=
 =?utf-8?B?NW1vSVlFNkNyVldwTW5iT2txTUtVVFljUjJ4ek8yVEdKb0Y1OUpuWDVQWTJJ?=
 =?utf-8?B?YVNwWGdsSi9yL2RtRWhJMFhycGxTalpQK3RiZ2toWnlyWlAzbktRM1dEb1FF?=
 =?utf-8?B?eGM3K2NsZkVlajJoOVdEU01jd0ExbnhlcS9mQkZ2TjVPSldtWXNqVkJycnM3?=
 =?utf-8?B?VVJmUkZoazVmUi9uVEZmeGlFWFJDN3RMSFpqUEJHQmY1TG13Y2FuWEtlbTJz?=
 =?utf-8?B?WWptVTcxbGhSWmpVcWtWT24yOWkwMjdWTzR1ZjdnQ3ZZMVdQR05GeXl3SFlU?=
 =?utf-8?B?WDM2cEFuY3lwd2cwT0xQVGh5R0w4dTd0OW9nTTVaWkxadkx5dlBkNGNnbWNB?=
 =?utf-8?B?Q3EyR2lRQk9CQ3ZMNDJPeTNlWHhVaXhZcUVjRFJlazRPTUNnK3p2bWxwQXdv?=
 =?utf-8?B?OWFTMCs5cXF5eVVHNDRVaC9oM09Kc0g0YTRQeHdxSXlzQ1JmQzZ3cTFmWVg1?=
 =?utf-8?B?VG1CWkpNazVKM29rd0R3WVltWU1IZXZTeDNlME9yUE1veG1zaCtQTWxtYi9Y?=
 =?utf-8?B?Rks0YTlkSHgraE1RM0Rxa3hJd3F0dFhYYzRSYUUzZ1d6WWtWRWxXRmNLS3Zm?=
 =?utf-8?B?QS8wZTg4Yk5VNDNPMDJvWXB4WXRqVjlkWlhxZlFUL0lYTGhFelBxREtzdzdr?=
 =?utf-8?B?M1F4NDRMV3g4cC8vdVJIOE53TlRkVTAyNWFkb0hWNDBSVTBDMXBEcHMzU0tl?=
 =?utf-8?B?c1AveWRTZTMzb0ZacjVnMElMckdITE5JNmJvaEtCWXprV0U2WDNqczBVcXVV?=
 =?utf-8?B?aERQcy9qSW05RURGTXNsQUN2MkprT2JGeHVjRExHYVFnNnU0OVlaMG1yRldQ?=
 =?utf-8?Q?OPbO/69DcmLKgNUY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ada119-8d20-4eaf-be3d-08d9f8807d1b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 17:01:39.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQEOj9uWok0YzkKVtdNrrMkSqXl3tfv+hXQV6t5yfG5yKwcDUWP8LVzshQiUevNuyyRXCb2/RfQz8A4cyoqOwgFQuDenV+sJUMU2G7VZYC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4458
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

(It should be noted that there was a slight mishap in communications
between the two of us resulting in two series with the same goal. Now
let's clean up the mess :-)

Thanks for your series. Seeing that it contains more patches than mine
it probably makes sense to use your series as basis. Please Cc: me in
future iterations of this patch series and consider my comments below.

On 2/25/22 15:54, Peter Geis wrote:
> Add the dwc3 device nodes to the rk356x device trees.
> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 12 +++++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 +++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 45 +++++++++++++++++++++++-
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> index 3839eef5e4f7..8e8b52f58f44 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> @@ -6,6 +6,10 @@ / {
>  	compatible = "rockchip,rk3566";
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3566-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -18,3 +22,11 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usbdrd30 {

I would really love to have some alignment with the other USB controllers

usb_host{0,1}_{e,o}hci

here. I am aware that older SoCs and the SDK are using these names and
it might be painful to have different versions to maintain at the
moment, but can we please agree on

usb_host0_xhci
usb_host1_xhci

or something like that?

> +	phys = <&usb2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	extcon = <&usb2phy0>;
> +	maximum-speed = "high-speed";
> +	snps,dis_u2_susphy_quirk;
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..77c044cbaaad 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -99,6 +99,10 @@ opp-1992000000 {
>  	};
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3568-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usbdrd30 {
> +	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> +	phy-names = "usb2-phy", "usb3-phy";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 84d5d607e693..4fae5b3b326e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,50 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	usbdrd30: usbdrd@fcc00000 {
> +		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfcc00000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk", "grf_clk";

Please consider Johan's comments on my first series. In my tests
removing the PCLK_PIPE clock did not make any difference.

> +		dr_mode = "host";

Based on the description in the commit message above it should be "otg",
right? Boards are free to overrule this, of course.

> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		resets = <&cru SRST_USB3OTG0>;
> +		reset-names = "usb3-otg";
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> +		snps,xhci-trb-ent-quirk;

In my first version I had all those quirks as well, but are they
actually necessary? I decided to remove them all to have a fresh start
(also activating them did not seem to affect my test setup).

> +		status = "disabled";
> +	};
> +
> +	usbhost30: usbhost@fd000000 {

Please reconsider the this name as well.

> +		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfd000000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk", "grf_clk";
> +		dr_mode = "host";

Here "host" clearly makes sense, as this controller is not capable of otg.

> +		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> +		phy-names = "usb2-phy", "usb3-phy";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		resets = <&cru SRST_USB3OTG1>;
> +		reset-names = "usb3-host";
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis_u2_susphy_quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;

What was said about quirks above holds here as well (although one quirk
not documented in the bindings is missing here).

Best regards,
Michael

> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> @@ -297,7 +341,6 @@ pmu_io_domains: io-domains {
>  	};
>  
>  	pipegrf: syscon@fdc50000 {
> -		compatible = "rockchip,rk3568-pipe-grf", "syscon";
>  		reg = <0x0 0xfdc50000 0x0 0x1000>;
>  	};
>  
