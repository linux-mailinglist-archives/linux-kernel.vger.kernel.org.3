Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655A3529C15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiEQIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243305AbiEQIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:16:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528534B1D0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:14:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er5so7818037edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8Ecq0Ku2beTjpdYuC7n32WxuB6qItwFuWOoIkbynN/o=;
        b=Ca15DO6EL/upHeqZOCzDDQnBFXZeQWIelA6fxfQpXCyt8tiyaCCdM/Uu2QCO2pIyHN
         mg/r0bcEAFj9I8vZb5CEuLTsUEyfd/9gNJVgi1P+1EXkZDzFyYvsv7ljbTYy4QQq33VS
         mw1536pHPBaIXgj7xRWZ42sHKnIPfFfG8uUBZnZr159Mkq85lSu6liwEWrBTqVxZ9Sr3
         2L7SBOm9tVg8Pv6VssDHH2SBcfQKPnd0r10fGYK2SCKuSPomHs1d5LJpWe01ebiPRKl1
         lnTnf5ss3TMPt9KWrkVKabj8nbVPRSwmFWvIAzn7j6jv8mMKI+xtRBxWddKmZkMieI8z
         xK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Ecq0Ku2beTjpdYuC7n32WxuB6qItwFuWOoIkbynN/o=;
        b=vpC2iF9z9NS+mieJjXdeY6ulkK/mQqvToLlc0QTcqRvNXgrNs2MsWczXel+fqy8QP5
         9XwbJ/5T9QU8jrVp+TaHKRsqRA84//6ourVLqW2P9hfXbaojUUx1qKBmY+jvMHvb96JG
         DMbcXFrMTFVjIA8WJCaK3iZVWJsNT6XDKYJ1brT3w9KZGPotzf7j0L2Gz2uzJv3xaAA/
         8z5NYUgKC9LLcICfq+X/FarO1smIVXFSID7mDVu3t8tORt4rWg7X6U7WHXURrWwdyLdS
         dJLid2c0QD/W3P8zLQgvph9gAEUywu2jaigg+S3pTrAkhj56Tvjmvb53LiJpXZQ2sBfG
         JiiA==
X-Gm-Message-State: AOAM5334q1s6ikLU9xlZYW42wxplTFoj08NeLlwdf08jdXTetNBgplgL
        120evfwq9NZPPQp1vK0qypx3NA==
X-Google-Smtp-Source: ABdhPJxL3w7M2CT0m0b/rGCiLOWpURaIM18EY0VF9FVJv5Cdce8TN1NErRx/ifFnG4dKms4UGCrNiw==
X-Received: by 2002:a05:6402:1cc1:b0:428:a06e:a30f with SMTP id ds1-20020a0564021cc100b00428a06ea30fmr17264315edb.377.1652775246933;
        Tue, 17 May 2022 01:14:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7de8c000000b0042ab4e20543sm2575111edv.48.2022.05.17.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:14:06 -0700 (PDT)
Message-ID: <703e2b25-00ff-9b69-d7d9-212a60ea76e1@linaro.org>
Date:   Tue, 17 May 2022 10:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 3/6] clk: qcom: Add IPQ8074 APSS clock controller
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
 <20220515204540.477711-3-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515204540.477711-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 22:45, Robert Marko wrote:
> IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
> cores, thus also providing support for CPU frequency scaling.
> 
> It looks like they are clocked by the XO and a custom APSS type PLL.
> 
> Co-developed-by: Ansuel Smith <ansuelsmth@gmail.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Convert to using parent-data instead of parent-names
> ---
>  drivers/clk/qcom/Kconfig        |  11 +++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/apss-ipq8074.c | 170 ++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/clk/qcom/apss-ipq8074.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 00fe5f066de5..9494eb74374a 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -134,6 +134,17 @@ config IPQ_APSS_6018
>  	  Say Y if you want to support CPU frequency scaling on
>  	  ipq based devices.
>  
> +config IPQ_APSS_8074
> +	tristate "IPQ8074 APSS Clock Controller"
> +	select IPQ_GCC_8074
> +	depends on QCOM_APCS_IPC || COMPILE_TEST
> +	help
> +	  Support for APSS clock controller on IPQ8074 platforms. The
> +	  APSS clock controller manages the Mux and enable block that feeds the
> +	  CPUs.
> +	  Say Y if you want to support CPU frequency scaling on
> +	  IPQ8074 based devices.
> +
>  config IPQ_GCC_4019
>  	tristate "IPQ4019 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 671cf5821af1..7b2da6dd570c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
>  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
>  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
> +obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
> new file mode 100644
> index 000000000000..38d03cd0ff76
> --- /dev/null
> +++ b/drivers/clk/qcom/apss-ipq8074.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,apss-ipq8074.h>
> +
> +#include "common.h"
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-branch.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> +
> +enum {
> +	P_XO,
> +	P_GPLL0,
> +	P_GPLL2,
> +	P_GPLL4,
> +	P_APSS_PLL_EARLY,
> +	P_APSS_PLL
> +};
> +
> +static struct clk_alpha_pll apss_pll_early = {
> +	.offset = 0x5000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> +	.clkr = {
> +		.enable_reg = 0x5000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_pll_early",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo", .name = "xo"
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll_postdiv apss_pll = {
> +	.offset = 0x5000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> +	.width = 2,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apss_pll",
> +		.parent_hws = (const struct clk_hw *[]){
> +			&apss_pll_early.clkr.hw },
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_ro_ops,
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
> +	{ .fw_name = "xo", .name = "xo" },
> +	{ .fw_name = "gpll0", .name = "gpll0" },
> +	{ .fw_name = "gpll2", .name = "gpll2" },
> +	{ .fw_name = "gpll4", .name = "gpll4" },
> +	{ .hw = &apss_pll.clkr.hw },
> +	{ .hw = &apss_pll_early.clkr.hw },
> +};
> +
> +static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 4 },
> +	{ P_GPLL2, 2 },
> +	{ P_GPLL4, 1 },
> +	{ P_APSS_PLL, 3 },
> +	{ P_APSS_PLL_EARLY, 5 },
> +};
> +
> +struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(403200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(806400000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1017600000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1382400000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1651200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1843200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1920000000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(2208000000UL, P_APSS_PLL_EARLY, 1, 0, 0),
> +	{ }
> +};
> +
> +struct clk_rcg2 apcs_alias0_clk_src = {
> +	.cmd_rcgr = 0x0050,
> +	.freq_tbl = ftbl_apcs_alias0_clk_src,
> +	.hid_width = 5,
> +	.parent_map = parents_apcs_alias0_clk_src_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apcs_alias0_clk_src",
> +		.parent_data = parents_apcs_alias0_clk_src,
> +		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_branch apcs_alias0_core_clk = {
> +	.halt_reg = 0x0058,
> +	.halt_bit = 31,
> +	.clkr = {
> +		.enable_reg = 0x0058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apcs_alias0_core_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&apcs_alias0_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT |
> +				CLK_IS_CRITICAL,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap *apss_ipq8074_clks[] = {
> +	[APSS_PLL_EARLY] = &apss_pll_early.clkr,
> +	[APSS_PLL] = &apss_pll.clkr,
> +	[APCS_ALIAS0_CLK_SRC] = &apcs_alias0_clk_src.clkr,
> +	[APCS_ALIAS0_CORE_CLK] = &apcs_alias0_core_clk.clkr,
> +};
> +
> +static const struct regmap_config apss_ipq8074_regmap_config = {
> +	.reg_bits       = 32,
> +	.reg_stride     = 4,
> +	.val_bits       = 32,
> +	.max_register   = 0x5ffc,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_cc_desc apss_ipq8074_desc = {
> +	.config = &apss_ipq8074_regmap_config,
> +	.clks = apss_ipq8074_clks,
> +	.num_clks = ARRAY_SIZE(apss_ipq8074_clks),
> +};
> +
> +static int apss_ipq8074_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	return qcom_cc_really_probe(pdev, &apss_ipq8074_desc, regmap);
> +}
> +
> +static struct platform_driver apss_ipq8074_driver = {
> +	.probe = apss_ipq8074_probe,
> +	.driver = {
> +		.name   = "qcom,apss-ipq8074-clk",

That's not the correct name of a driver - commas should not be there.
You need of_device_id instead.


Best regards,
Krzysztof
