Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1206F59F314
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiHXFdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHXFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:33:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E16077EA9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai4zb0CIE0iH9MvU3gQZ9hXSOdN69rDHoNtPbdNjegppUNLYmAuSvr2hvr/8hYP5Sr/S26Dl1TN1e/wJrY086L4q2Bd99ApGrLA3A3en76bo/DeeYf68hWjKzNpb+/fFBIuAW1pbwU+lILnZL2DYBqsbyDKOjf7ruTeLjzUccYmBYPHQRbGXdtTSAmbKwHw+BdBsZLx64XHftXDHqtrCB6YCsdIUGESEQjO09qyXvKCfQEJSf3ZBjIOQWNpCVHUfws4Rt4ZbhqquegmGa/u+aCoiClk6bbX1a1+0nQqR3kF8cE8F398l3+c0Nz8D27jAA6R8wQABdjBvIIzGG+6j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCi5KwrZ3sNC8e2iARBN63lWxqe+kjMkg9Jd3/8tfCE=;
 b=aBQcygmxSnk5WRtxbBGuBIv61NESpzDzanO2Buv3gMncJ6BEyOecemVWgezukxR8K0lu5OvpzrGUXTSKsb/7WVtNybMF1QyF8tBDqMAIiADZO2glNIMNjvmkfpCQMrLwiQ+VhXe/9EKRS2ya2AbiG54e7mx7wenYK2WmB1tnFn2WI3L0hWpQhCq5aSVpgmgHuQDOyL9yy/3CxpOnJ2qEPq1csTOUHB1gRq+/K5tcTQ0fFzwYUxEhI99u7fbdibC8yGQ1Dwm9QE7xv8wOeqrkKHHfJXDLgHmPLtd1MLfRWlsQDKhpVzx3GdpEf/ftMxCegcAvah3rkjEbuzaYtVXeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCi5KwrZ3sNC8e2iARBN63lWxqe+kjMkg9Jd3/8tfCE=;
 b=MxWNUOo1qmm4Z7KqyCvj97yvUK+bmQf/sUpvdcLhaFnl+4KP0+ShzORM+TYd6FIMLHo9125lJnF8NEofbAdWfJHfI8vDNawLLml8nNukxwPAnq9JadHhF2wDOYY0bYoZ+5V95X+AEXqbexy41s8St7QAPqduadU1GhcNU+GsKHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR0801MB1711.eurprd08.prod.outlook.com
 (2603:10a6:800:4e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 05:33:13 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::2c84:f6b5:8727:b073%11]) with mapi id 15.20.5546.024; Wed, 24 Aug
 2022 05:33:13 +0000
Message-ID: <86198a8a-96d4-5856-bc2d-44bf352c82fe@wolfvision.net>
Date:   Wed, 24 Aug 2022 07:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] phy: rockchip-inno-usb2: Return zero after otg sync
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220823144728.47068-1-pgwipeout@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220823144728.47068-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::18) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58654e8-5a52-4c3f-584f-08da85922354
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1711:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bveGBtZeMJwdwLS1oEJV1Ir9N7+wOrhtSijw0N8dcBuwr2u0/Es7VX+I+SU45GMn3lrMZIwnfMx3oIwzKNzlYh5Q474qqHuStvSQ5v7XQM2NT/1cLr4BbHeQrJc2H5HJ+Pa+uRAoMS5F7Ej0AS+5QvvGYJ/pmRGmJVGNTf5peDi9LZ52MzEOfCrur5ThrbIiEGOAQmCyQ9iHmaMUcUiYGiAnmQkzTpU+OkaEYpsBZ+aXFvauOj5Q7pS4Yg1S4lFWk3m7Z2fkcbJCulG0gJI6FM59g3X8FoVIcou+yCTZYBWviDrIhJAU3Zqm+kXR9RG6IjkWSV05snVVAdMDK9okBxNb50nSw13Zb5VPVWdb1kYjpik7q4V3oEdEKcn0epCvhZ1A0Bt7T0XDtnZFk9aSlH47qMH61l3UQpp0vM20NMA8qejOOILZ8oMjcClm88Km6kuc00FCjcjHFpLaPTIWbwC3p44/AZKAh6P0GFIV+/dkiMz+jF677sWmthoKL8/bM0DuoHo95Y2qDyEii+ji7qnw/z3io0brW9nc3p26PxzEp82+MOAPTksvo0rUBF4bCuv54cMHYWMgHNAT3TjiLJouGY67i8kniN7+nKqh8cg2HBUCUvrAFedCgF9qCsSsduFMxt1wsJxXJU1WZSLdUIRrARlZfTk7jo2S8RgBtmOeAjUye1/B2KJa+D7T9AyokbwUx0iBjKFlWOS4OMGTxE0wMknBy9KNn8ryeS6AZ1G89wUDR0ib63uAoKVWbhyT66gD/buNan8UZK7ATP/b2Md3VBOoB2AVJAJvpdOmVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(66476007)(66946007)(4326008)(8676002)(66556008)(316002)(6486002)(83380400001)(31696002)(86362001)(6512007)(8936002)(41300700001)(7416002)(44832011)(5660300002)(6506007)(38100700002)(478600001)(52116002)(53546011)(2906002)(110136005)(2616005)(36756003)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRqcVQwWHJrcmRkSWExQWFvb0U3WlpsN3RScGtSQkZ1YlpJWEhUM1FGeDVD?=
 =?utf-8?B?eUVSb2xkVjZKZGRYVXhXNW15TG1OUStmNmhEZXJscWN0TS9LMFlkYkNnRGYw?=
 =?utf-8?B?eHRaL0xUUFJFenBrOTMxOWVTaXJhbTZoV09Nd09VNktWM1IwOVN5Sm9vUWor?=
 =?utf-8?B?bnF6Z05xejA2TFJ4cFkvZXJmMEpiOUhOSnhRQXlhaVFLMGxnSWU1dUpoUDlZ?=
 =?utf-8?B?WTh5eitSV1VJbGE5OE9uQWtLMWZqZGE5eTVvZ0pXd1dBQTdkd1hITUdWK2w2?=
 =?utf-8?B?RWhjSE5yUGVucHo0ZThhaG45UjZGdHE5RSsxY0h1RnhxekhIOXBUN3l1OTB4?=
 =?utf-8?B?RFNVbEw2UzZ1RDlZdmZpSjFOSitvNGdZbSsrRmlSRzMwdWc3M1JWd2pqOWFU?=
 =?utf-8?B?dWtLR2pQZ3RaM092NU95UFUzS2loWmNhU1BWaFM2S24rNXNMa1B2K0VwWDhU?=
 =?utf-8?B?Zk9jT2oxUXFGWDljVWVSVnlsMVBqYlNCckJIdGIyS1RucXBQZDdUc3phaUli?=
 =?utf-8?B?aUQrQWdWaXBIQzdCTm1iOWd6T21CMkJjbXRROUx1RmV3UGpvRXJzSmdPek9D?=
 =?utf-8?B?NTB0S3orZTI4eWZ0UVZCZXo2NXVRMXhHckJyUUkxbm9hdWx3RHM5T012Y2Rn?=
 =?utf-8?B?SlF5NThqdDBhOTdsOTRZQnF4SlROYUU0TzBBclFkc0ZJelhKcU9OSS8yNjk4?=
 =?utf-8?B?SjFHei9vMFM5SmVvT0xEWG50Z29NUTFsczJ6STlDZ2U5eGJDQ29GNW42MEJF?=
 =?utf-8?B?Z0xtajVlS0MrRGQwRnlaQ0JSRVlsQkpVRDZMRVVMSUowNE1CcXo3Y0RocDBn?=
 =?utf-8?B?bzBOcURPSGJNc1l4M3hYU2FjNDlaSnhCK3lpdnR3RDFJcFJHQi9oSHd0Z3RJ?=
 =?utf-8?B?dllybnlqT3ArOHFSeTNQVVcxN3RpU3NkWDg1Q2lSZFBqKzFlQ0ZxUk40MGtp?=
 =?utf-8?B?clp2NW0yZ04wUXd2SHVFaXdFVkNtY1hTNERLVUtUdnVyTkFpSmdoT0YyNEx2?=
 =?utf-8?B?aytpdXdjRC93VVo4bWNodkFiS0JWU3VpNCtHemo1L3llT2UrL1JuQXY2cVIz?=
 =?utf-8?B?bU9tL1VxRzJxQU9JNHI5MEpKUXhveE1oeXJrQ0lJTDNJWVRML1V5aXhId25S?=
 =?utf-8?B?WnVkdXZFamhkbzRiUWtPOUxYQ2tuTUxWcFp3NUpSdVdudnVtQVB1THV2dzlF?=
 =?utf-8?B?bFhMMFlKYldoMWFabytNcEwvMzJlS3M1TWtOUFZkTUs0RUZFTktnYmlLaFE1?=
 =?utf-8?B?dWhDVENHTk5IWHVIS1Yvamd1WjBwak8vWmFsbkt4VUJWUXpIeFB4Z1FueHJw?=
 =?utf-8?B?UDgvZ2hEcTBIMzFCVkVoVTZIb3JkOG02V1lSR2F3RXBtRmZkSVIvb3E0OGx1?=
 =?utf-8?B?NmtHSDk5WWRsb0ZNU1hZQU5paysvdzBrdFhGVnpJaHg4NDdiYjhnb0RrSTFk?=
 =?utf-8?B?Yk9OZlNpelEwUTVBRDEwcXZNU3d5UnVLMzUvOUdpa2lPanFpQVVPSUdsSFcy?=
 =?utf-8?B?cW1MNzFzRnA4ZDNmRFFVN3cwUVNmNDJYYUxWd2IwTjR5eWRaSWd2VXlnYXNP?=
 =?utf-8?B?VXBoQnNTWS9jREsrWVBvcUV5UGpUT08zbkhSUTZkbUdKeG9PSnRKbTQzMmwv?=
 =?utf-8?B?aGhOdTN2a2dLWWtwN0NZQk5hbDVzcmUvMzQ5dEVVNFJsbm9iVUxkOE5jdmFH?=
 =?utf-8?B?RzZSVkhhQ3lFVk92cTJPSDlIU3NFcXB5ejgvcjNQbzl2V2hhVHU0UmpHYTNs?=
 =?utf-8?B?a2pna0R0T09QV0lBbHpuUzJaMVFxUHBvbzQrTDBhU2lYVkgvcmxMMTVnbktF?=
 =?utf-8?B?NTJicUZ0RTB6Qnk5b0VyNE1yTEsvTTFsSFBaMzZUNDlSL3o1cFR2d2pCUllH?=
 =?utf-8?B?TmZ0a1YzLzU0TzdDNWVYL3ViQnFpMlpqV1FqY0xBNTluSTAvQndZUTZxTzR6?=
 =?utf-8?B?TWszdTFLN3Nzc1ZUemdYODRYbWR6TXVKNnhsQ1AvNWIrTVg3Y2NHaWJESEhW?=
 =?utf-8?B?Z2o5UWE4NUJVVjFlVmNuQ1ZQYm1xY09KTHdxUWFMVCtxRmxwSDNIanRDSVJa?=
 =?utf-8?B?N2J5OWxFQXo4Z3lpeVNOM0tBc2RWazd6cGlTeldYdVR5ZWJWV1EzR3M1dVoz?=
 =?utf-8?B?VHBoWVdBR2QvMXdYcEdkcElxbFE3bnN6RHRFTFpKVUVZQXorSTlZaU5PbHNy?=
 =?utf-8?B?SklDZDlnQ04raExMTXVWSEdIbWJ1OWhZMzdwN3pOOE5tWUtIT3ZRdmY0WlVq?=
 =?utf-8?B?SVF3eGp6b0xwb1ptZ3l5b0ZaM3pnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f58654e8-5a52-4c3f-584f-08da85922354
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:33:13.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XkpVmSZ1joAUBzK9LkkVoNwBhz59k6ltFs4HAX5ZL/zyODQT/qhMQrbqXbbDQby4bcKj8nP0TbuzUCzSLSgSbWaldCSl7Zr3A39NBi/QIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1711
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/23/22 16:47, Peter Geis wrote:
> The otg sync state patch reuses the ret variable, but fails to set it to
> zero after use. This leads to a situation when the otg port is in
> peripheral mode where the otg phy aborts halfway through setup.  It also
> fails to account for a failure to register the extcon notifier. Fix this
> by using our own variable and skipping otg sync in case of failure.
> 
> Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 0b1e9337ee8e..d579a22c61df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1124,7 +1124,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  					  struct rockchip_usb2phy_port *rport,
>  					  struct device_node *child_np)
>  {
> -	int ret;
> +	int ret, id;
>  
>  	rport->port_id = USB2PHY_PORT_OTG;
>  	rport->port_cfg = &rphy->phy_cfg->port_cfgs[USB2PHY_PORT_OTG];
> @@ -1164,11 +1164,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  					EXTCON_USB_HOST, &rport->event_nb);
>  		if (ret)

This needs braces, right?

	if (ret) {
>  			dev_err(rphy->dev, "register USB HOST notifier failed\n");
> +			goto out;

	}

With the braces the patch works as expected.

Thanks and best regards,
Michael

>  
>  		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>  			/* do initial sync of usb state */
> -			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> -			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +			id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> +			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
>  		}
>  	}
>  
