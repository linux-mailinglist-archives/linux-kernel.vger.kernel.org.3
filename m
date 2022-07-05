Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC45673D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGEQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGEQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:07:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A982BEF;
        Tue,  5 Jul 2022 09:07:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dn9so17182560ejc.7;
        Tue, 05 Jul 2022 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bodYuUINtdfT+usu5Iuy+nZ7zDLIoEW71RzOe9gY+CE=;
        b=m6yBjGgY8If7QfJ6vQGnVzIhmqsmbiAS4ZCld01cuJaPqLXSR9hTZPpgxOBUxZ1wj3
         fww5Jy5wPiy8naN7KtFTi6LpZbrrIUiG3gLrORbc9Zt6jyHUJzIqVlZfplgc67iIwEPC
         07vAw075CO3Rmym+EZ384IRrZNhnpH8UEpXzlRLZ6rZJwTif8aVy7lwgRG7nsqK2/i1d
         b8RX7ApWzcaRnKoAHe+lPVyxTh/e3sNpZg9xJfBo1VJFHAgmKMbmiylnK9qn5nqKeKKC
         rg2qCer+PvsxCYDnd/792wN30kT035jFYgnA+Zj1goF4L0/G3prLZf63Rw/HdQbfpHmY
         Inug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bodYuUINtdfT+usu5Iuy+nZ7zDLIoEW71RzOe9gY+CE=;
        b=u3s0KxJdYVmCqbT1mTpxfHxLPIIhn8UJWYQCfy8H3pCzcgq9NnFJBlZX6+U/7uOt+k
         Dgy7QyPA1JjyVVG2JtnqD4RWAsYCYfJ+Op84BWvTqWArfIAuiZJLzuEPvA710Q+rRXBj
         AT608RUn4MsL+oXj+as0efdoWjLvwbgSCt9nvoojlDkJ5kr+Px5rAUoBaQWvjLz71rHF
         Xj5JIhZT9eYNqRSTSWRlZRl95r8HW5bXiVQa8d+hxmTqjrIgPJM8gSdpnVTpjk3w9JkI
         gujprtCCHpuiT2Kd+0F+zIP472F3yYAwczaTdrhU9nS5+eyI7/k2cnaYVEAQyElUVwtb
         i9Fg==
X-Gm-Message-State: AJIora/cCbPTM5mC4E+hjbpaYhemx7vKNq0GLZxyD5CDr0nDEkwUX/vp
        QH3qawrXIuLf/yh4wjQ0yME=
X-Google-Smtp-Source: AGRyM1uxGpRjQDzVyLzlwrHoo5ArTyiF+3VeQwC5ferd+XpUXT9jYRp0YRVlO5AqVTzmJl2/MRHALw==
X-Received: by 2002:a17:906:2086:b0:715:7983:a277 with SMTP id 6-20020a170906208600b007157983a277mr34808586ejq.386.1657037230525;
        Tue, 05 Jul 2022 09:07:10 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id z8-20020aa7d408000000b0043a37e1d8easm5876809edq.32.2022.07.05.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:07:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     peron.clem@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Tue, 05 Jul 2022 18:07:08 +0200
Message-ID: <5580615.DvuYhMxLoT@kista>
In-Reply-To: <20220705075226.359475-1-r.stratiienko@gmail.com>
References: <20220705075226.359475-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko napisal(a):
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
> | Register  | Name           | Bits  | Values | Result |
> | --        | --             | --    | --     | --     |
> | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> 
> DVFS started to work seamlessly once dividers which caused the
> glitches were set to fixed values.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> 
> ---
> 
> Changelog:
> 
> V2:
> - Drop changes related to mux
> - Drop frequency limiting
> - Add unused dividers initialization
> 
> V3:
> - Adjust comments

I don't see any comment fixed, at least not to "1", as we discussed. Did I miss 
anything? Also, please add min and max. I also consent to R-B, which you 
didn't include. Did you resend v2 instead of v3?

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..068d1a6b2ebf3
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk = {
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
> -	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider 
*/
>  	.common		= {
>  		.reg		= 0x030,
>  		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
> @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> 
> +/* Keep GPU_CLK divider const to avoid DFS instability. */
>  static const char * const gpu_parents[] = { "pll-gpu" };
> -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> -				       0, 3,	/* M */
> +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
>  				       24, 1,	/* mux */
>  				       BIT(31),	/* gate */
>  				       CLK_SET_RATE_PARENT);
> @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct platform_device
> *pdev) if (IS_ERR(reg))
>  		return PTR_ERR(reg);
> 
> +	/* Force PLL_GPU output divider bits to 0 */
> +	val = readl(reg + SUN50I_H6_PLL_GPU_REG);
> +	val &= ~BIT(0);
> +	writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> +
> +	/* Force GPU_CLK divider bits to 0 */
> +	val = readl(reg + gpu_clk.common.reg);
> +	val &= ~GENMASK(3, 0);
> +	writel(val, reg + gpu_clk.common.reg);
> +
>  	/* Enable the lock bits on all PLLs */
>  	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
>  		val = readl(reg + pll_regs[i]);
> --
> 2.34.1


