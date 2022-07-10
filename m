Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D256D0DD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:47:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECF5140D9;
        Sun, 10 Jul 2022 11:47:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so5461720eja.8;
        Sun, 10 Jul 2022 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C80Ap1NXuZqTKIgCrLtABirop3OeeK3fdoI8KowoeOs=;
        b=ZOpQ1n0M0OnqaRpX8U1nIdAk1kQ66bjVUCEE2Y67Doa8nB74h809IMNYQDcsHN5JV5
         W/kt/2kZZiQNxRMOyFZhQWnLBGkvw8nhao0WNJ4eyq+0vpsdnoEiKYhv7csabekLSo/N
         o80kR/iIVciGw8O03J7f2qEQPI8Qpsiq2LESCxNsxDtEoLQhLeInKqrXbOQAObyD1BUs
         4LzvcMOvfApyyZiB3MVEf0gri17579oZtVWhhAsidaTONVEO0+9SshJo7Tc/HC13DYEO
         zVJ6Llo2C0o9HgEpHndudpMAFOBk1EgEK2edcQxFr8Z/83WcQDZbkGPCNbg045TwJx13
         GudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C80Ap1NXuZqTKIgCrLtABirop3OeeK3fdoI8KowoeOs=;
        b=V9shph1S/OoDJMt8hPEgf1ERLG8v6r3k3AY9v90ecn4Ae0bXf6ZYpu7qid4r0B9s7g
         wxpzZs5VaczAFdS3jiHbQ6IwROV3o25nJ/bYoMo7U8wWVomeHUmSLXloSqTisbUUoX1S
         xu4kAZwPaVIWMRwnJWM4l9NUVI2eRYuhedgvbuBcBIW7m78fZuSHJes7txG6P8wi5dY2
         GuoCsnIulIt9tmS9okp5AY1C4OrdthqNZi2/JTWnPEq5mJmEqyMTl3RyPE92INDV64+X
         Kj7TfssEnbgmBhQQjvlC5YYPbbkH6Vq2RUcapU+feZpOvEMV0N2rWqhX709o4vYuFX3n
         s0Fg==
X-Gm-Message-State: AJIora+BWwEXT8h205ObUIXJo9v8HKPqdBWXffO9tsJ0m5fhsVXCe2d7
        UAKBET/cnfRAWUR7/2PWQno=
X-Google-Smtp-Source: AGRyM1v8LP9i025JYfgRgPcAmlTD5Y+Rcjg0cRMXzHhXx90s+gyCRBFmmeu3UaNXQf9uAZpxRsVPOw==
X-Received: by 2002:a17:906:6416:b0:722:e812:1000 with SMTP id d22-20020a170906641600b00722e8121000mr15282978ejm.275.1657478876956;
        Sun, 10 Jul 2022 11:47:56 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id x21-20020a170906149500b0072b2ef2757csm1780200ejc.180.2022.07.10.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 11:47:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [RFC] ccu-sun50i-h6: Bump-up DDR0 PLL to 1800MHz
Date:   Sun, 10 Jul 2022 20:47:55 +0200
Message-ID: <1917526.jZfb76A358@kista>
In-Reply-To: <20220710175214.544748-1-r.stratiienko@gmail.com>
References: <20220710175214.544748-1-r.stratiienko@gmail.com>
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

Dne nedelja, 10. julij 2022 ob 19:52:14 CEST je Roman Stratiienko napisal(a):
> While debugging complex animated composition cases  I noticed a glitch
> which as it turned-out eventually was caused by lack of memory bandwidth.
> 
> I can't find a DRAMC manual to check what input frequency must be
> supplied to avoid exceeding the 800MHz LPDDR3 which is installed on
> my orangepi3 board. But the system is running stable so far.

this is hard topic. Generally, max. supported DRAM frequency is board specific 
and is set by SPL (part of U-Boot), so we can't assume every board supports 
max. frequency for its memory type. In fact, this assumption was proven wrong. 
Some boards were unstable until DRAM frequency was lowered. So in short, Linux 
clock driver certainly shouldn't set DRAM frequency. There is, however, Linux 
MBUS driver for H5 and A64, which can throttle DRAM frequency when system is 
idle, but max. frequency is still that one which was programmed by SPL.

There is no definitive DRAM documentation, because Allwinner usually tries to 
hide all details. DRAM drivers are, except in rare cases, all reverse 
engineered by community. Register values (mostly) match those produced by 
vendor driver. Fortunately, at least H6 DRAM controller matches pretty good 
with one other memory controller (one in Zynq UltraScale+ MPSoC), which is 
fully documented (see comments in U-Boot driver). MBUS is also pretty standard 
and it's not a mystery.

Note that it's hard to convince maintainers to either lower or increase DRAM 
frequency as it was common issue in the past. You have to do a lot of memory 
intensive tests, both CPU and GPU, running at the same time for extended 
period of time. Initial board bring ups usually just use same frequency as in 
BSP based images. If I understand procedure correctly, boards are sent to 
Allwinner, so their engineers determine max. DRAM frequency and timings, so 
these values are pretty trustwothy.

There is other possibility. Along with DRAM controller and PHY, there is MBUS 
core, which is memory arbiter and responsible for bandwidth allocation. You 
can change DE priority and bandwith there (again, in U-Boot DRAM driver).

I hope this explains why things are the way they are.

Best regards,
Jernej

> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 750368a86b8b6..abdde80307993
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -1203,6 +1203,17 @@ static int sun50i_h6_ccu_probe(struct platform_device
> *pdev) val &= ~GENMASK(3, 0);
>  	writel(val, reg + gpu_clk.common.reg);
> 
> +	/*
> +	 * Increase DDR0 PLL from 1488(default) to 1800MHz.
> +	 * (DE3.0 require higher memory bandwidth while displaying
> +	 * complex composition at 1920x1080@60FPS)
> +	 */
> +
> +	val = readl(reg + SUN50I_H6_PLL_DDR0_REG);
> +	val &= ~GENMASK(15, 0);
> +	val |= 74 << 8;
> +	writel(val, reg + SUN50I_H6_PLL_DDR0_REG);
> +
>  	/* Enable the lock bits on all PLLs */
>  	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
>  		val = readl(reg + pll_regs[i]);
> --
> 2.34.1


