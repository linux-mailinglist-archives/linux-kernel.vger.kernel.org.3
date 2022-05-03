Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF13517BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiECCKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:10:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE13B3CD;
        Mon,  2 May 2022 19:07:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1393E32009A6;
        Mon,  2 May 2022 22:07:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 May 2022 22:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1651543635; x=
        1651630035; bh=xUeFWxsF5CLekYiemda/iXJE5D5dmgNKZ4AF9FvZhgI=; b=E
        YJtIdNUHjcaX7VD3d737fYk7Uf0xE11EuATUuVFFJ5qG4c/VAvH8edQEtc/SHmKf
        MFje+wEREmXz5jWzpSf7XD3Y/wkdJ6EWCvR5vgeB/+OAys0n7yRtYIg/M86JEVXb
        I+t/smKJX5u2dFC/tw3BUkxu1Wn/MQZ+1BSF9YxEzOr4xIcg6a9ByQmcz31Km5l5
        cTXcsdWUBnlxwt55upZgvPEe5R+LuL8hzoOki1cg0Q0LiI/4BDAXklXl+h2efHK6
        KcTnrriGtiTirch6/cKh9n0TbYyRzjrcEf+sqI8GJfoniLp7J2bZsSdvr4hSsmp7
        gC1cOUQW5Hl96f/Wti4og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651543635; x=1651630035; bh=xUeFWxsF5CLek
        Yiemda/iXJE5D5dmgNKZ4AF9FvZhgI=; b=N+LfR9m3tsUk8K2rL2GNIh0qSWW4D
        i2RFLHJ9Ar6EA6cd3xFjs2ZEoqNY8TndJzoum+BM2TJKB+Rq1amHVWNq8NjBw7sX
        dPp8vTX+5q1iY0OTjqCcSGsCgjYrG+kwOsUV2usHn0qbf/ZYTSi0xmLZmxsAwqeI
        tiBfudrlGV5w8JFjRVqcFB9nmcSsV9yIpDrXFyyoWxyliMwpUDR82Bd2oH120XeW
        4atfr6iTUAniCWCohaHjtHqrA6NYEbYyD4qGqIHa7v42PtH82H7J+QaxiVd/+37K
        Nsv1QDc5wmM+m2Q6gGNFu4lWOEqccKmIpx54sFPNhUsTUFxnVXwVb+SEQ==
X-ME-Sender: <xms:U45wYoq5kocPCBnMpAf08BwvABmceqh7C23Bm2eVAz_Lk-HLSd5Udw>
    <xme:U45wYuoXWYvHWne89jJG8pcXNMQiZCBRvUm6TW7BsseN6xaSmlgrt7QTxkRvx81rq
    YA3RjUUDAWx304mEw>
X-ME-Received: <xmr:U45wYtPCg0-9Zwrh5JvEZkimzRl-hrwYnYkLEv_jEggmh8eOfnNy4IfBFOi8M3cPb-015w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeigdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:U45wYv7xihWsWib2z3IrMhV3LfULXb3BnB-s2i2gl6vcK71V9KZ2Mw>
    <xmx:U45wYn4B_5dU-K559YWtMyTsWaWATVn2hwaCxRTJyJPtlVY6WAzbRw>
    <xmx:U45wYvhy-feLxdoNLuDpbgIkV9rJN0-KLJ-DMsdaMVJ71G33bDEVFA>
    <xmx:U45wYrgzMkA2MYR1UT2-SR5Yt5HWBTJITtQjUxmef7bAbpTL1egXxw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 22:07:14 -0400 (EDT)
Subject: Re: [PATCH v11 1/6] clk: sunxi-ng: h6-r: Add RTC gate clock
To:     Andre Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <20220428230933.15262-1-andre.przywara@arm.com>
 <20220428230933.15262-2-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <875fc3d6-fb45-903c-e52e-4abf43b46db2@sholland.org>
Date:   Mon, 2 May 2022 21:06:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220428230933.15262-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 6:09 PM, Andre Przywara wrote:
> The H6 and H616 feature an (undocumented) bus clock gate for accessing
> the RTC registers. This seems to be enabled at reset (or by the BootROM),
> so we got away without it so far, but exists regardless.
> Since the new RTC clock binding for the H616 requires this "bus" clock
> to be specified in the DT, add this to R_CCU clock driver and expose it
> on the DT side with a new number.
> We do this for both the H6 and H616, but mark it as IGNORE_UNUSED, as we
> cannot reference it in any H6 DTs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>

One tiny nit below, if you resend.

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 5 +++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
>  include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> index 712e103382d8..88509339031e 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
>  		      0x1cc, BIT(0), 0);
>  static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
>  		      0x1ec, BIT(0), 0);
> +static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
> +		      0x20c, BIT(0), CLK_IGNORE_UNUSED);
>  
>  /* Information of IR(RX) mod clock is gathered from BSP source code */
>  static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
> @@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
>  	&r_apb2_i2c_clk.common,
>  	&r_apb2_rsb_clk.common,
>  	&r_apb1_ir_clk.common,
> +	&r_apb1_rtc_clk.common,
>  	&ir_clk.common,
>  };
>  
> @@ -163,6 +166,7 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
>  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
>  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
>  		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
> +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
>  		[CLK_R_APB1_W1]		= &r_apb1_w1_clk.common.hw,

The new clock should go after CLK_R_APB1_W1 to match the ordering above.

>  		[CLK_IR]		= &ir_clk.common.hw,
>  		[CLK_W1]		= &w1_clk.common.hw,
> @@ -179,6 +183,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
>  		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
>  		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
>  		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
> +		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
>  		[CLK_IR]		= &ir_clk.common.hw,
>  	},
>  	.num	= CLK_NUMBER,
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> index 7e290b840803..10e9b66afc6a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> @@ -14,6 +14,6 @@
>  
>  #define CLK_R_APB2	3
>  
> -#define CLK_NUMBER	(CLK_R_APB2_RSB + 1)
> +#define CLK_NUMBER	(CLK_R_APB1_RTC + 1)
>  
>  #endif /* _CCU_SUN50I_H6_R_H */
> diff --git a/include/dt-bindings/clock/sun50i-h6-r-ccu.h b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> index 890368d252c4..a96087abc86f 100644
> --- a/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
> @@ -22,5 +22,6 @@
>  #define CLK_W1			12
>  
>  #define CLK_R_APB2_RSB		13
> +#define CLK_R_APB1_RTC		14
>  
>  #endif /* _DT_BINDINGS_CLK_SUN50I_H6_R_CCU_H_ */
> 

