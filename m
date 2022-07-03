Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DCD564572
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGCGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:50:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812F6578;
        Sat,  2 Jul 2022 23:50:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B1975C006F;
        Sun,  3 Jul 2022 02:50:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 02:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656831000; x=
        1656917400; bh=XbHz1O6006EfuGFVS6D/gxZESYgM1ts2Dx5M1x9GZ8s=; b=r
        NReSIBnmOK33z/OyQ9Ak9zvfdP+pUrIRipAl7qB0fPzEE2BCu+xbnbykWJcsG2HQ
        UFAp6JPUeuW20HRjGGsp2+Ge5LyvUcXn3mhz7c/PwoR02BLfwaFKbXxmyrjvKgoN
        SMdG7SD9hTVX9nYHnLa/dgr0Q6T2jVvkV3aHMVjhyH1bZKVvb5Jqaae9Wod9xu+q
        0xD2JNp3e3aoaSCESRWhbt+Tmcqves+c+MWFd+1uH3r8MFv0evjuOb4kHhWze7sF
        WT2kyjW744NA00ih64MTZHC40HIQwB6HFzpj4bIfsDKXYApG7hWyr0VagbcxQfSD
        SQxyr5yXncQDdjzECQ7Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656831000; x=
        1656917400; bh=XbHz1O6006EfuGFVS6D/gxZESYgM1ts2Dx5M1x9GZ8s=; b=b
        Cnm73gzsZPlhFLa83U7pergZ27NN8Hon5RdsVf9JZjpsne31t8cLJMZJQj4hSeRs
        oaiXw6KHDWbsTVSFserEblBiqwqt8qLXvJQx6Ep5MkPY4VZ8pP5QYNoXDfc4Qh2p
        mQxlI01qbpVH0FXmizTJpNEtThRIh3ul9sb0ecKe/cAuIjXuw9m9YsIHPGmfpRSr
        QaOvQm0CAgp69HtdBfEAJp0lXSmX9NfJusbM/JIMFVbpYDJbRA7NI4GGtvM93FzD
        XTQ4nPqejbwWrSLYqKGkXsfy4GQsgrzGicSHcWDCv+tQHuGq8QbHNMbyQ/SZLWMa
        tz4jDMiCA/df/8gvXI3IA==
X-ME-Sender: <xms:FzzBYnpmpR5f8htEICf7SXZkjW8_yqCSnVylYQt4MXgKZVERPYKGiw>
    <xme:FzzBYhpa7DKi2fV7TK3UH2ri-KUdpYSCWEv7lLD9LXki6e31Ygl4vB27OmlCAq1aW
    1TwLp2bTkJfHSdrbg>
X-ME-Received: <xmr:FzzBYkMR7prQ-WAIk1_GgSFnUV-ufDwTtL_aEteqKlqeUb14KiI1NpASZpoI3HPJGuH2TiF8jRAbIoM-LpqApVG8VpzZXBYDxYdn9VCjsu2qwosNW6bFM5Cvpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FzzBYq73hiNJD3x5qWUG9RLrMX5qzWfEZJqGXpHMo1I3x0fUDB-MzQ>
    <xmx:FzzBYm6Nqdcmr2sYp3TBgo-ramg7mrlEjZxQtpwLaCBwnRcpgab63A>
    <xmx:FzzBYiiokG5V0aiOVYpym38VTMjRNCLm_39uCAmYI44Pa7uR7O6gWA>
    <xmx:GDzBYvFfIauhGWDpbFl3K2EhiM-X5c63m8wIghdkAjXL54zNc9SVIQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 02:49:59 -0400 (EDT)
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration
 to support DFS
To:     Roman Stratiienko <r.stratiienko@gmail.com>, peron.clem@gmail.com,
        jernej.skrabec@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220624165211.4318-1-r.stratiienko@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e5837e14-739e-5137-7398-3acfc8a54b84@sholland.org>
Date:   Sun, 3 Jul 2022 01:49:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220624165211.4318-1-r.stratiienko@gmail.com>
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

On 6/24/22 11:52 AM, Roman Stratiienko wrote:
> Using simple bash script it was discovered that not all CCU registers
> can be safely used for DFS, e.g.:
> 
>     while true
>     do
>         devmem 0x3001030 4 0xb0003e02
>         devmem 0x3001030 4 0xb0001e02
>     done
> 
> Script above changes the GPU_PLL multiplier register value. While the
> script is running, the user should interact with the user interface.
> 
> Using this method the following results were obtained:
> 
> | Register  | Name           | Bits  | Values | Result |
> | --        | --             | --    | --     | --     |
> | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> 
> Once bits that caused system failure disabled (kept default 0),
> it was discovered that GPU_CLK.MUX was used during DFS for some
> reason and was causing the failure too.

The GPU module clock has only one parent declared, so it is surprising that the
mux would get set. Did this happen while the kernel driver was changing the
frequency?

> After disabling GPU_PLL.OUTDIV the system started to fail during
> booting for some reason until the maximum frequency of GPU_PLL
> clock was limited to 756MHz.

The manual lists PLL_GPU's maximum frequency as 800 MHz. I assume you chose 756
MHz because that is the highest OPP. That should be okay, too.

> After all the changes made DVFS started to work seamlessly.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index 2ddf0a0da526f..d941238cd178a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk = {
>  	},
>  };
>  
> +/* For GPU PLL, using an output divider for DFS causes system to fail */
>  #define SUN50I_H6_PLL_GPU_REG		0x030
>  static struct ccu_nkmp pll_gpu_clk = {
>  	.enable		= BIT(31),
>  	.lock		= BIT(28),
>  	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
>  	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> -	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.max_rate	= 756000000UL,
>  	.common		= {
>  		.reg		= 0x030,
>  		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
> @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
>  static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace", "psi-ahb1-ahb2",
>  		      0x62c, BIT(0), 0);
>  
> -static const char * const gpu_parents[] = { "pll-gpu" };
> -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> -				       0, 3,	/* M */
> -				       24, 1,	/* mux */
> -				       BIT(31),	/* gate */
> -				       CLK_SET_RATE_PARENT);
> +/* GPU_CLK divider kept disabled to avoid interferences with DFS */
> +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> +		      BIT(31), CLK_SET_RATE_PARENT);

These changes look fine to me. You also need to set the initial value for the
fixed fields in the driver's probe function.

Regards,
Samuel
