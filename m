Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237634C0A27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiBWDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBWDWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:22:38 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F331232;
        Tue, 22 Feb 2022 19:22:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3A5565801C5;
        Tue, 22 Feb 2022 22:22:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 22 Feb 2022 22:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=IkQN2es09BGyMo
        mk4XSaidbsdDwmtXzWNdN/EUwe0wI=; b=DHVMG4Y3sJhtwmXC+v2SFFiu3PzNvJ
        euyD5W2HAowEb/+qfpvaL3R2mUE5fcJlKQ4h9E4lPaBqJRt9/VL7EGtI938AP1D3
        D0zMWN/9Fo6GgV2nR6a7vLxyJl/9rXuzVf/5TSFRkdacbUcxNlAKS1Ejd78gKEsL
        IwLFioOPZo3c3hLvvRG+FDFnhZNMUFlCLhewUT1RTBHg/GyLNifkbIDEEzPubsRs
        /2FmcRGjtOOyhGIhtRDPbf1ARjBiKESY5m6GeI+Kh+pXmF7jlzyVpbGq4JB5dcFd
        7onx0+N9ztWH2U+HG69b8bQlPwE7VLTnvQJYRvAWNEWfUKVyzRnOehHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=IkQN2es09BGyMomk4XSaidbsdDwmtXzWNdN/EUwe0
        wI=; b=STeopoSb06swZtR1gNJjMp15wrHyXSdTSQqHjxiDaQGdCiPX86bvasLBY
        egLbZ6wAZ7sCKRNtQzyUbcO6hdtL+dR2uzhA4Au01zTr9ijldOhJV+TqwcO4x2bW
        Vu0ujjHARsv7oKFoJ7/aQ0d+ZlXIZApbXWA7T+Uxf4qrmbCWbhak2F0Ybgo9XnZ3
        +VnxZ34K/OmKcqlSmrRrOn/Ph3VY5OEWHkFw4L3uPJ3zXpPi/xAVkPqbOxLyBqga
        KNmOKZSHf3r8kjdth0uSL0RyeOTgLKGGd7k2DC+GYM5XjMWlyy75NhCs5YlXiXOx
        a42g1v7Js+aJdOdd6Oy3rsfYLFB5A==
X-ME-Sender: <xms:YagVYiccQBzetdE6Yr9ysKYe-EaBJO9TNRfbcRrGCFY8PlrerVEPRg>
    <xme:YagVYsMiga44LamZsGtqfIoY4E00FN-X5QrN8ik1Jk5QcsczqSJkLsih_OUcanSzB
    4jtKhmrhrGX-s8kow>
X-ME-Received: <xmr:YagVYjhXW28uqNfRYuxJKPIY2wVzkPsnTc-HtD6qmHii5DLwOOH93NIhv-4FqLOzU8omZgA50FfsGWi05baWhRnHTZBCCm3XwKmFdA4MW9vA3qn5w58so7BkSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:YagVYv_ew7ZaINbHJaeC-C5Txqjp35SMFltfTexnNavnwz6CKHBn0Q>
    <xmx:YagVYuvQFr0yEZDsTWvjOvgHQ_Kb_QjsV6IBZGWPN4Ko7fgErGWMKA>
    <xmx:YagVYmGy9OXFHczyvOCL4jNVvv3FdbuX6Pz4TorS2ZVayq-IMmC5Rg>
    <xmx:YqgVYmEfEL8miVxhdqZLNdhbUHosKGrn047kgLeVsugd7HX4xQb0Aw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:22:08 -0500 (EST)
Subject: Re: [PATCH v10 01/18] clk: sunxi-ng: h616-r: Add RTC gate clock
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-2-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <01e8d2a0-cdeb-ab64-42a7-48376b49c00e@sholland.org>
Date:   Tue, 22 Feb 2022 21:22:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> The H616 features an (undocumented) bus clock gate for accessing the RTC
> registers. This seems to be enabled at reset (or by the BootROM), but is
> there anyway.
> Since the new RTC clock binding for the H616 requires this "bus" clock
> to be specified in the DT, add this to R_CCU clock driver and expose it
> on the DT side with a new number.

It would be good to note why you didn't add this clock to H6, even though it
exists in that hardware.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 4 ++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
>  include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> index 712e103382d8..26fb092f6df6 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
>  		      0x1cc, BIT(0), 0);
>  static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
>  		      0x1ec, BIT(0), 0);
> +static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
> +		      0x20c, BIT(0), 0);

All of the documentation I have found (manuals, A100 driver, BSP D1 driver)
points to this clock coming off of R_AHB, not R_APB1.

Regards,
Samuel

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
> @@ -179,6 +182,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
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

