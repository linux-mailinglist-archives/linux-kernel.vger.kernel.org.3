Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7FA50C533
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiDVXoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiDVXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:42:37 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7C1971CF;
        Fri, 22 Apr 2022 16:39:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 870A93201F1A;
        Fri, 22 Apr 2022 19:39:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Apr 2022 19:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650670770; x=
        1650757170; bh=TYWJpQ9HQWPCAbkcH0PjM6q5uQurr4Nv5cqpAtGIW0w=; b=E
        FENhP/7MV9tPhgisJOFk3lrUsecxytcNQp/tyukbGkDBdRkfFICN/EAVmK4RZHH+
        S2liZrPaDe1MzEWsYK5tM1/yY/s6/1g0Ohgi7kKAXdzeApNX2t5M4DFGlkj4Ko3x
        yImBnxau/nt5PfpFCUAG6X9HeDJnsYEsIzsRYI0e4w3SxTePOLbStlrNSeJr2LpW
        OG4ydRbGW/bJuXLnAMwcw27I4/x0BvA7oyZpd4c4ounHszngpnYlorHpssOtycyg
        QA7BB8Ws79pSGhlrscoH96Fy78VlRllQcr2luZM3QtWuEtN+3MUO8QrXs7c/knQ8
        Mgzekj+ntWHKKf0NvVtCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650670770; x=1650757170; bh=TYWJpQ9HQWPCA
        bkcH0PjM6q5uQurr4Nv5cqpAtGIW0w=; b=R58i3gzzLAy2O7OM67y8+iBpFehof
        /2k1p442uBZQ+vOwue0z8isrZLIhn+OuL9vT55ZkHIEH6cnmijNH82uz8ketc1Iz
        tA7T0DcIsIvdzkVeLNUZFZUV47dnXrxLIh04ZW3DDKQ5EId4FVYomr9VkTFjr3sF
        TPSO/+L1OzgWB8BzKzjYohzmPfULB3yu603HnE8C7jEgXJ6VPPVu/PVObWgb4szm
        6n2b86PdKqv6pXshzDXB/FuwrbKlaI6A3O3n38A1nzW0i0OiMJyWG4gsuSPSAv8n
        YPLzbMNgvb0gmyWpdMFlH2A0Uf0D9vclnIfU5tNF+4aO0tuiv7QQrlYLA==
X-ME-Sender: <xms:sDxjYnyMEaXVFAwPvJqg02koiuV-7aeviTQcvC-uXV0UkeAVCn_YzQ>
    <xme:sDxjYvRU9l6oDGyycx3iHTrpNjyrWciIZ2gYVRRfUyPoVkrR548C8opOVxjKLKaBk
    aMDO4lNIHMuLcZaaw>
X-ME-Received: <xmr:sDxjYhW8hZ_4Yh3J8HCxF3Bz_Bk0RY39vwBSCNFr05KZ7W4sOjgGbQDM3xMNHtYXDmRR1mIMn_fbVP0btNMAeiATkN3joHitRE7AJVuVjTuKmarxxeLqLTCHWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:sTxjYhhfK_Ep7s8DWrx6ltNprNcq-oELOce5i66luFweD3ylS7G03Q>
    <xmx:sTxjYpDRSl36lwaMYrl6e03OCly2H_lIu6H7WPlYI76iIpbNy56ZBQ>
    <xmx:sTxjYqI2yYKb3tbPE6qZWZcCVh27GL-3X6SpvYvOKBEuLpRYYTQnqg>
    <xmx:sjxjYhZrPXTIvWEgfb8nNaAFfSITyvyqBc0H0rOs-y_3X62GigX7Ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 19:39:27 -0400 (EDT)
Subject: Re: [PATCH 2/2] thermal: sun8i: add R329 THS
To:     Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
References: <20220422161156.1075227-1-icenowy@outlook.com>
 <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f21303dd-14e2-80e6-ef07-2a1584d93b2e@sholland.org>
Date:   Fri, 22 Apr 2022 18:39:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On 4/22/22 11:11 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The thermal sensor controller on R329 is similar to the one on H6, but
> with only one sensor. Calibration method is still unknown because no
> calibration is implemented in BSP kernel, neither is it documented in
> the user manual.

Looking at the BSP smartx-r329-tina-for-jishu-community-v0.2, I see:

ths_calib: calib@14 {
        reg = <0x14 4>;
};

And the BSP driver (drivers/thermal/sunxi_thermal-ng.c) claims that R329 uses
the same calibration method as for H616. Maybe you are looking at an older BSP?

Regards,
Samuel

> 
> Add its support to sun8i-thermal driver. Calibrating it is now
> prevented.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/thermal/sun8i_thermal.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index d9cd23cbb671..3a2f381005b4 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -312,7 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  		goto out;
>  	}
>  
> -	tmdev->chip->calibrate(tmdev, caldata, callen);
> +	if (tmdev->chip->calibrate)
> +		tmdev->chip->calibrate(tmdev, caldata, callen);
>  
>  	kfree(caldata);
>  out:
> @@ -628,6 +629,17 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
>  	.calc_temp = sun8i_ths_calc_temp,
>  };
>  
> +static const struct ths_thermal_chip sun50i_r329_ths = {
> +	.sensor_num = 1,
> +	.has_bus_clk_reset = true,
> +	.offset = 188744,
> +	.scale = 672,
> +	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
> +	.init = sun50i_h6_thermal_init,
> +	.irq_ack = sun50i_h6_irq_ack,
> +	.calc_temp = sun8i_ths_calc_temp,
> +};
> +
>  static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
>  	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
> @@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[] = {
>  	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
>  	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
>  	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
> +	{ .compatible = "allwinner,sun50i-r329-ths", .data = &sun50i_r329_ths },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);
> 

