Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C865715FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiGLJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGLJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:44:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B377AA43A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:44:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so13027978lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ccOiMAgtSqX6XMOBrUrIJ0SaPuYb17sx2V9mHM1gD1E=;
        b=Y0a/DBRjll737XFCNqzw6+eMJGYJBX6D/hxspikU6eioe8Urv+VmTU4PAYR1jlkCc1
         JG/QXZYpVXP4sJVrD76Ej5OABuRlJqixN3zMtB1vcdxJHyc66ebGLe1VSjEbjUG30E1B
         8+bix2IrOGOVVKtbrVUvk2m6iKYZZJk4XkiAs7OQDql9f3CTajF8DvWUSHete2hSTZuQ
         e39cjbGzckLrRzCWgIZD4/kbCJv8Q5iAmBVEiCk672YXxIn99hLe36e9KvvKtM60H0qc
         CmJTOhlaD+Wuf7hknq8BQ8nzKMdF9WARIbGPRVYeHotKWrC6vZlhVoCxrsvypWm1LNYi
         ZeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ccOiMAgtSqX6XMOBrUrIJ0SaPuYb17sx2V9mHM1gD1E=;
        b=jGiMcjJTCBPKF/7sOVDw5UfQSimsDw85YxzHqjtxtK+6j8e3bjJpEjveK5f88dlWCs
         U9A/lqnGj3IpqT1VyykmZDZulMDbK7CNa7Rr12qg2dyZLmbJhvydohqlyLXIpFJNYeiN
         xEaV340V8LnSxyBomahEGzdUGrIkuivZL0ekUm5dxLhmKMqZdzzouj4A7pgDOIQ4OD2k
         2xiISts5FOJ++lkNF7U46LtcT/nWI6DP2tr40XEmQ0/KuUCwDrFlRnVZjfPjrMWBUucN
         QGsTw3luhMx8HPvY0mxgiFNcg34ogt2swO8EXLIiVZGZpFuu/fvo7XNKWFvWekurbBeL
         YNMA==
X-Gm-Message-State: AJIora+mARoE4o0nzctO9LmDcAisoHI6ja+GiErHHNxS8ZJknFeA6PBK
        pX4/EKE5bpFRbsGIqWqmKL/IwQ==
X-Google-Smtp-Source: AGRyM1t0XIrqxrRUMiAPNhXh/+UpC10KkgPORctfq7pZBW+gpw3mxfsKIRyrLm7Hrb3xag7p8eKBdA==
X-Received: by 2002:a05:6512:304c:b0:489:d0e3:2efb with SMTP id b12-20020a056512304c00b00489d0e32efbmr9494549lfb.34.1657619072024;
        Tue, 12 Jul 2022 02:44:32 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm2078959lfh.286.2022.07.12.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:44:31 -0700 (PDT)
Message-ID: <7fe9aab5-73a2-6209-ae65-d955c426f745@linaro.org>
Date:   Tue, 12 Jul 2022 11:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] clk: meson: s4: add s4 SoC clock controller driver
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-4-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220708062757.3662-4-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 08:27, Yu Tu wrote:
> Add the peripheral clock controller found in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  MAINTAINERS                |    2 +-
>  drivers/clk/meson/Kconfig  |   17 +
>  drivers/clk/meson/Makefile |    1 +
>  drivers/clk/meson/s4.c     | 4678 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/s4.h     |  156 ++
>  5 files changed, 4853 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/s4.c
>  create mode 100644 drivers/clk/meson/s4.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4ca46c5c8a1..f116ec0642f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
>  L:	linux-amlogic@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/amlogic*
> -F:	drivers/clk/meson/
> +F:	drivers/clk/meson/*

Why?

>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
>  F:	include/dt-bindings/clock/s*
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index fc002c155bc3..1a344b0564e8 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -115,4 +115,21 @@ config COMMON_CLK_G12A
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>  	  devices, aka g12a. Say Y if you want peripherals to work.
> +
> +config COMMON_CLK_S4
> +	tristate "S4 SoC clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select HAVE_ARM_SMCCC
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_MPLL
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_CPU_DYNDIV
> +	select COMMON_CLK_MESON_VID_PLL_DIV
> +	select MFD_SYSCON
> +	help
> +	  Support for the clock controller on Amlogic S805X2 and S905Y4 devices,
> +	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
> +	  Say Y if you want peripherals and CPU frequency scaling to work.
>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 6eca2a406ee3..b3ef5f67820f 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> +obj-$(CONFIG_COMMON_CLK_S4) += s4.o
> diff --git a/drivers/clk/meson/s4.c b/drivers/clk/meson/s4.c
> new file mode 100644
> index 000000000000..a97159222f0e
> --- /dev/null
> +++ b/drivers/clk/meson/s4.c
> @@ -0,0 +1,4678 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-S4 Clock Controller Driver
> + *
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <dt-bindings/clock/s4-clkc.h>
> +
> +#include "clk-mpll.h"
> +#include "clk-pll.h"
> +#include "clk-regmap.h"
> +#include "vid-pll-div.h"
> +#include "clk-dualdiv.h"
> +#include "s4.h"
> +#include "meson-eeclk.h"
> +
> +static DEFINE_SPINLOCK(meson_clk_lock);
> +
> +static struct clk_regmap s4_fixed_pll_dco = {

None of these are const?

> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll_dco",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock won't ever change at runtime so
> +		 * CLK_SET_RATE_PARENT is not required
> +		 */
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * Similar to fclk_div3, it seems that this clock is used by
> +		 * the resident firmware and is required by the platform to
> +		 * operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) Mark the clock used by a firmware resource, if possible
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock is used by the resident firmware and is required
> +		 * by the platform to operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) Mark the clock used by a firmware resource, if possible
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct pll_mult_range s4_gp0_pll_mult_range = {

Not const?

> +	.min = 125,
> +	.max = 250,
> +};
> +

(...)

> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const s4_clk_regmaps[] = {
> +	&s4_rtc_32k_by_oscin_clkin,
> +	&s4_rtc_32k_by_oscin_div,
> +	&s4_rtc_32k_by_oscin_sel,
> +	&s4_rtc_32k_by_oscin,
> +	&s4_rtc_clk,
> +
> +	&s4_sysclk_b_sel,
> +	&s4_sysclk_b_div,
> +	&s4_sysclk_b,
> +	&s4_sysclk_a_sel,
> +	&s4_sysclk_a_div,
> +	&s4_sysclk_a,
> +	&s4_sys_clk,
> +
> +	&s4_ceca_32k_clkin,
> +	&s4_ceca_32k_div,
> +	&s4_ceca_32k_sel_pre,
> +	&s4_ceca_32k_sel,
> +	&s4_ceca_32k_clkout,
> +	&s4_cecb_32k_clkin,
> +	&s4_cecb_32k_div,
> +	&s4_cecb_32k_sel_pre,
> +	&s4_cecb_32k_sel,
> +	&s4_cecb_32k_clkout,
> +
> +	&s4_sc_clk_mux,
> +	&s4_sc_clk_div,
> +	&s4_sc_clk_gate,
> +
> +	&s4_12_24M_clk_gate,
> +	&s4_12_24M_clk,
> +	&s4_vid_pll_div,
> +	&s4_vid_pll_sel,
> +	&s4_vid_pll,
> +	&s4_vclk_sel,
> +	&s4_vclk2_sel,
> +	&s4_vclk_input,
> +	&s4_vclk2_input,
> +	&s4_vclk_div,
> +	&s4_vclk2_div,
> +	&s4_vclk,
> +	&s4_vclk2,
> +	&s4_vclk_div1,
> +	&s4_vclk_div2_en,
> +	&s4_vclk_div4_en,
> +	&s4_vclk_div6_en,
> +	&s4_vclk_div12_en,
> +	&s4_vclk2_div1,
> +	&s4_vclk2_div2_en,
> +	&s4_vclk2_div4_en,
> +	&s4_vclk2_div6_en,
> +	&s4_vclk2_div12_en,
> +	&s4_cts_enci_sel,
> +	&s4_cts_encp_sel,
> +	&s4_cts_vdac_sel,
> +	&s4_hdmi_tx_sel,
> +	&s4_cts_enci,
> +	&s4_cts_encp,
> +	&s4_cts_vdac,
> +	&s4_hdmi_tx,
> +
> +	&s4_hdmi_sel,
> +	&s4_hdmi_div,
> +	&s4_hdmi,
> +	&s4_ts_clk_div,
> +	&s4_ts_clk_gate,
> +
> +	&s4_mali_0_sel,
> +	&s4_mali_0_div,
> +	&s4_mali_0,
> +	&s4_mali_1_sel,
> +	&s4_mali_1_div,
> +	&s4_mali_1,
> +	&s4_mali_mux,
> +
> +	&s4_vdec_p0_mux,
> +	&s4_vdec_p0_div,
> +	&s4_vdec_p0,
> +	&s4_vdec_p1_mux,
> +	&s4_vdec_p1_div,
> +	&s4_vdec_p1,
> +	&s4_vdec_mux,
> +
> +	&s4_hevcf_p0_mux,
> +	&s4_hevcf_p0_div,
> +	&s4_hevcf_p0,
> +	&s4_hevcf_p1_mux,
> +	&s4_hevcf_p1_div,
> +	&s4_hevcf_p1,
> +	&s4_hevcf_mux,
> +
> +	&s4_vpu_0_sel,
> +	&s4_vpu_0_div,
> +	&s4_vpu_0,
> +	&s4_vpu_1_sel,
> +	&s4_vpu_1_div,
> +	&s4_vpu_1,
> +	&s4_vpu,
> +	&s4_vpu_clkb_tmp_mux,
> +	&s4_vpu_clkb_tmp_div,
> +	&s4_vpu_clkb_tmp,
> +	&s4_vpu_clkb_div,
> +	&s4_vpu_clkb,
> +	&s4_vpu_clkc_p0_mux,
> +	&s4_vpu_clkc_p0_div,
> +	&s4_vpu_clkc_p0,
> +	&s4_vpu_clkc_p1_mux,
> +	&s4_vpu_clkc_p1_div,
> +	&s4_vpu_clkc_p1,
> +	&s4_vpu_clkc_mux,
> +
> +	&s4_vapb_0_sel,
> +	&s4_vapb_0_div,
> +	&s4_vapb_0,
> +	&s4_vapb_1_sel,
> +	&s4_vapb_1_div,
> +	&s4_vapb_1,
> +	&s4_vapb,
> +	&s4_ge2d_gate,
> +
> +	&s4_hdcp22_esmclk_mux,
> +	&s4_hdcp22_esmclk_div,
> +	&s4_hdcp22_esmclk_gate,
> +	&s4_hdcp22_skpclk_mux,
> +	&s4_hdcp22_skpclk_div,
> +	&s4_hdcp22_skpclk_gate,
> +
> +	&s4_vdin_meas_mux,
> +	&s4_vdin_meas_div,
> +	&s4_vdin_meas_gate,
> +
> +	&s4_sd_emmc_c_clk0_sel,
> +	&s4_sd_emmc_c_clk0_div,
> +	&s4_sd_emmc_c_clk0,
> +	&s4_sd_emmc_a_clk0_sel,
> +	&s4_sd_emmc_a_clk0_div,
> +	&s4_sd_emmc_a_clk0,
> +	&s4_sd_emmc_b_clk0_sel,
> +	&s4_sd_emmc_b_clk0_div,
> +	&s4_sd_emmc_b_clk0,
> +
> +	&s4_spicc0_mux,
> +	&s4_spicc0_div,
> +	&s4_spicc0_gate,
> +
> +	&s4_pwm_a_mux,
> +	&s4_pwm_a_div,
> +	&s4_pwm_a_gate,
> +	&s4_pwm_b_mux,
> +	&s4_pwm_b_div,
> +	&s4_pwm_b_gate,
> +	&s4_pwm_c_mux,
> +	&s4_pwm_c_div,
> +	&s4_pwm_c_gate,
> +	&s4_pwm_d_mux,
> +	&s4_pwm_d_div,
> +	&s4_pwm_d_gate,
> +	&s4_pwm_e_mux,
> +	&s4_pwm_e_div,
> +	&s4_pwm_e_gate,
> +	&s4_pwm_f_mux,
> +	&s4_pwm_f_div,
> +	&s4_pwm_f_gate,
> +	&s4_pwm_g_mux,
> +	&s4_pwm_g_div,
> +	&s4_pwm_g_gate,
> +	&s4_pwm_h_mux,
> +	&s4_pwm_h_div,
> +	&s4_pwm_h_gate,
> +	&s4_pwm_i_mux,
> +	&s4_pwm_i_div,
> +	&s4_pwm_i_gate,
> +	&s4_pwm_j_mux,
> +	&s4_pwm_j_div,
> +	&s4_pwm_j_gate,
> +
> +	&s4_saradc_mux,
> +	&s4_saradc_div,
> +	&s4_saradc_gate,
> +
> +	&s4_gen_clk_sel,
> +	&s4_gen_clk_div,
> +	&s4_gen_clk,
> +
> +	&s4_ddr,
> +	&s4_dos,
> +	&s4_ethphy,
> +	&s4_mali,
> +	&s4_aocpu,
> +	&s4_aucpu,
> +	&s4_cec,
> +	&s4_sdemmca,
> +	&s4_sdemmcb,
> +	&s4_nand,
> +	&s4_smartcard,
> +	&s4_acodec,
> +	&s4_spifc,
> +	&s4_msr_clk,
> +	&s4_ir_ctrl,
> +	&s4_audio,
> +	&s4_eth,
> +	&s4_uart_a,
> +	&s4_uart_b,
> +	&s4_uart_c,
> +	&s4_uart_d,
> +	&s4_uart_e,
> +	&s4_aififo,
> +	&s4_ts_ddr,
> +	&s4_ts_pll,
> +	&s4_g2d,
> +	&s4_spicc0,
> +	&s4_usb,
> +	&s4_i2c_m_a,
> +	&s4_i2c_m_b,
> +	&s4_i2c_m_c,
> +	&s4_i2c_m_d,
> +	&s4_i2c_m_e,
> +	&s4_hdmitx_apb,
> +	&s4_i2c_s_a,
> +	&s4_usb1_to_ddr,
> +	&s4_hdcp22,
> +	&s4_mmc_apb,
> +	&s4_rsa,
> +	&s4_cpu_debug,
> +	&s4_vpu_intr,
> +	&s4_demod,
> +	&s4_sar_adc,
> +	&s4_gic,
> +	&s4_pwm_ab,
> +	&s4_pwm_cd,
> +	&s4_pwm_ef,
> +	&s4_pwm_gh,
> +	&s4_pwm_ij,
> +	&s4_demod_core_clk_mux,
> +	&s4_demod_core_clk_div,
> +	&s4_demod_core_clk_gate,
> +	&s4_adc_extclk_in_mux,
> +	&s4_adc_extclk_in_div,
> +	&s4_adc_extclk_in_gate,
> +
> +	&s4_fixed_pll_dco,
> +	&s4_fixed_pll,
> +	&s4_fclk_div2,
> +	&s4_fclk_div3,
> +	&s4_fclk_div4,
> +	&s4_fclk_div5,
> +	&s4_fclk_div7,
> +	&s4_fclk_div2p5,
> +	&s4_gp0_pll_dco,
> +	&s4_gp0_pll,
> +
> +	&s4_hifi_pll_dco,
> +	&s4_hifi_pll,
> +	&s4_hdmi_pll_dco,
> +	&s4_hdmi_pll_od,
> +	&s4_hdmi_pll,
> +	&s4_mpll_50m,
> +	&s4_mpll0_div,
> +	&s4_mpll0,
> +	&s4_mpll1_div,
> +	&s4_mpll1,
> +	&s4_mpll2_div,
> +	&s4_mpll2,
> +	&s4_mpll3_div,
> +	&s4_mpll3,
> +};
> +
> +static const struct reg_sequence s4_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x00000543 },
> +};
> +
> +static const struct meson_eeclkc_data s4_clkc_data = {
> +	.regmap_clks = s4_clk_regmaps,
> +	.regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
> +	.hw_onecell_data = &s4_hw_onecell_data,
> +	.init_regs = s4_init_regs,
> +	.init_count = ARRAY_SIZE(s4_init_regs),
> +};
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,s4-clkc",
> +		.data = &s4_clkc_data
> +	},
> +	{}
> +};
> +
> +static struct platform_driver s4_driver = {
> +	.probe		= meson_eeclkc_probe,
> +	.driver		= {
> +		.name	= "s4-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(s4_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/s4.h b/drivers/clk/meson/s4.h
> new file mode 100644
> index 000000000000..d5563dcbd52e
> --- /dev/null
> +++ b/drivers/clk/meson/s4.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __S4_H
> +#define __S4_H
> +
> +/*
> + * Clock controller register offsets
> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe000000
> + */
> +#define CLKCTRL_OSCIN_CTRL                         ((0x0001 << 2))

No need for double ((

> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 ((0x0002 << 2))
> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 ((0x0003 << 2))



Best regards,
Krzysztof
