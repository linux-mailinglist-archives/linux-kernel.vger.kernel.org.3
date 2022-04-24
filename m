Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E950CE78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiDXCat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiDXCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:30:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5306116A;
        Sat, 23 Apr 2022 19:27:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 53DD45C00E8;
        Sat, 23 Apr 2022 22:27:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 23 Apr 2022 22:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650767265; x=
        1650853665; bh=5aHnylZhBrIbPeHjOBkVxfTHbhAukjfHst0cFkOu57k=; b=u
        jE+1YolNokydrNd0C1U/GmGsRVaANV/H6vkM8dUz64h0BmoRdYlJ3M+UEt4ispal
        TpHYd4als3XGG0cGM8amlSTOzXm/kG6lxydg5a2sqSX6ClmEaBTq4UgzQHBJY0MS
        DrMSppSFDuZi+4QD8eZVzpPdFpGVAqEGcJbBGTQoVG0stqOY8gqnbAVrSZR3ukoo
        C5jecbWTjTXM4BKoV8JKIwLjx7zd0H0ba51qNdvs6Dv1hPsaE+M9dUnkdgKk/HFC
        FxOvi46mCpVolSITd/OUrKXDZEQCAr2LZ9lAQOIaZJ7t/f1x0z5ibq6bdcNzRXGc
        ehxgLDvgG659SeB/TLrQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650767265; x=1650853665; bh=5aHnylZhBrIbP
        eHjOBkVxfTHbhAukjfHst0cFkOu57k=; b=ks72ZrlBVF7wPaLgoznPZzso4dUSy
        fjJwyimyA3yOGVQfz2oyRGmLJBLErO9X9mR2braEpx1gCBQmDpjRs1EK97QtDW+H
        BoQ/z17GMLLF+MmypF3LO7GyClV8BhnoXpaD87NUa8xzew35y1Hu/yXaQDK1oLJd
        zvYFFtTWdTp271uKPhkAZNG23gMvScmU4ahKbF//h98iTu+YEHFnESlsicgllzp6
        DL3inBzcJ0OR2ofuU2iOYNxTVQVRx+KSevP/KogXqmV74alz1TD7RLn/MKF251h1
        9BkOCbDoNCN7keuWUyqoqVQieORZyDl34OVZa4aMxDD96ZQzJ5McuAATA==
X-ME-Sender: <xms:obVkYuVchIntTHbFBoRMEFWAdDBSXc87rQHIxKDi3EF_jWhYwuQNdQ>
    <xme:obVkYqln4_lzr5R1V1RX1npEAkzUNb8yA5H6rTUqDR_Nx1b7qGyGtsMDarZAYwIuv
    moZE9x_Ox2yjdi8mA>
X-ME-Received: <xmr:obVkYiZRIcqq2sr9M6kPRmPuOoJ5hYsz_pKjXGE2vy6dW4o5t9xfj7AyL9mEJn2z5GERm2NrZ-v3mGXP6OsYE8cQnF76A6Rnndp6ssF0vvshYJVi2rQAt-hbyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:obVkYlUdAwcioVSIfGuGx_-RyszklQzEBByX2k-xodZeZ5qoI6Er9A>
    <xmx:obVkYomfTcUzEGKj2bBd_-bZvPYW_ljAj3EgQZgku08k4Xlksp-ssw>
    <xmx:obVkYqeflCAfmOxaM6Gd6PBWLl--pq7ryX6xVjqxucPLECLFgEnhFw>
    <xmx:obVkYhcmb-6V-tJYYaqbFU7x3duThdTTeBSXNwVIXMJrcWW2UiFRfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 22:27:44 -0400 (EDT)
Subject: Re: [PATCH 08/12] mmc: sunxi: add support for R329 MMC controllers
To:     Icenowy Zheng <icenowy@aosc.io>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472BAA6CFEA5BD4B18D7D4EBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <df585ee2-e365-b974-3f2b-27c113a76b1b@sholland.org>
Date:   Sat, 23 Apr 2022 21:27:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472BAA6CFEA5BD4B18D7D4EBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The two MMC controllers in Allwinner R329 have a mixed feature set
> comparing to the previous SoCs' ordinary MMC and eMMC controllers.
> 
> Add support for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Samuel Holland <samuel@sholland.org>

> ---
>  drivers/mmc/host/sunxi-mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 0e8fbf4957d8..06934eef8be5 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1207,6 +1207,15 @@ static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
>  	.needs_new_timings = true,
>  };
>  
> +static const struct sunxi_mmc_cfg sun50i_r329_cfg = {
> +	.idma_des_size_bits = 13,
> +	.idma_des_shift = 2,
> +	.clk_delays = NULL,
> +	.can_calibrate = true,
> +	.mask_data0 = true,
> +	.needs_new_timings = true,
> +};
> +

This is the same as D1, so you could reuse or replace that configuration constant.

Regards,
Samuel

>  static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
>  	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
> @@ -1218,6 +1227,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
>  	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
>  	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
> +	{ .compatible = "allwinner,sun50i-r329-mmc", .data = &sun50i_r329_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> 

