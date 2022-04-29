Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D43514F82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbiD2Pen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346797AbiD2Pek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:34:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC42AE13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:31:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v4so10923935ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=L4gd9XH9ZkMrMysf02/jJS+u3ye0fXwsmTBORcRrEAw=;
        b=rjCftH5MU+cvS8ZyYU10R8w+rSYInT3reNsmcEeCv4c6F5Cw/cCfMOKNVCW8vn8yQX
         jl0kLfCu0HYFnQeq+NuP9Q9Yu0WTsIehnnnpEC/ElV69ho7KHCHRNyfof9BPnk4hIxcH
         NiVOtiaQYf6Qbbp3gTvqbDCt9c6a86zF3nra7RSvO+jiLjMu50qKvnyDp/aGJTfPHlNu
         3ta+C2ENNdjLzBw/Q1rfxUavisA09K5x8NyZACuJATsuKJVpVeS5X6o6h/LbFF+cRT16
         lEIBkfsKcnPro3kNMbhzBgc4wtkiDozZM6IJF1mxBAjjVchsJllGSv5HQreYnT6TEWz6
         8Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L4gd9XH9ZkMrMysf02/jJS+u3ye0fXwsmTBORcRrEAw=;
        b=MVoRMNrKx/OxNxJEteXTpqtjOo4E/D7pWuj1OFDY1X2DGjybgyTefH2isZN6xYyCJ+
         eGX3SVjwnqLbeyv3Vmg7qNpH929rluKTTuPLlMmzVkyFQ5760yhHOuALz6LJ8CMSObyR
         ztT850/6DmxCam1iyWGTKQlcWJNd/yO28cOUysLwUKCxL3IfA0ZHA+T/xWlSbedGjhUT
         A/sdUV9B56MUuLuy6LpUG0V/CO5ZoCDTHBuKkMGzBOBIkBS4uEwZbOAbBxC4mcwE7bYb
         19GbOrSj4GS4X4BFI6PujRsbHw6paDJ1rhPzKNZPxlc/nvTTr0gHN+EmxiQM3oThXuNw
         6snA==
X-Gm-Message-State: AOAM533wVp75wbdyv5IOAu+eF6g3mV/IX5J3LU178RrKYOdqimJYhFof
        2kgvXmMnWTVTWEPMAOJw5/X2OQUQy4ASJg==
X-Google-Smtp-Source: ABdhPJwCfoa3DJcQbwhqYiYIwVHR8Sx061+IjUHZA6n1Z5l441AqCIkag1bSJcWM8N6RqYLTEeRmdw==
X-Received: by 2002:a05:651c:54c:b0:24f:2d81:c3ae with SMTP id q12-20020a05651c054c00b0024f2d81c3aemr7296516ljp.239.1651246277550;
        Fri, 29 Apr 2022 08:31:17 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x25-20020a2e9c99000000b0024f3d1daed2sm298980lji.90.2022.04.29.08.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:31:17 -0700 (PDT)
Message-ID: <c0a5df00-dda5-3fe4-161f-a4ffda28077a@linaro.org>
Date:   Fri, 29 Apr 2022 18:31:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 4/9] clk: qcom: add support for SM8350 GPUCC
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-4-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-4-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 18:12, Robert Foss wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> The GPUCC manages the clocks for the Adreno GPU found on the
> sm8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/clk/qcom/Kconfig        |   8 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/gpucc-sm8350.c | 640 ++++++++++++++++++++++++++++++++
>   3 files changed, 649 insertions(+)
>   create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index e27f37ac2d9c..9b1f54e634b9 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -703,6 +703,14 @@ config SM_GPUCC_8250
>   	  Say Y if you want to support graphics controller devices and
>   	  functionality such as 3D graphics.
>   
> +config SM_GPUCC_8350
> +	tristate "SM8350 Graphics Clock Controller"
> +	select SM_GCC_8350
> +	help
> +	  Support for the graphics clock controller on SM8350 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>   config SM_VIDEOCC_8150
>   	tristate "SM8150 Video Clock Controller"
>   	select SM_GCC_8150
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dff6aeb980e6..e1b7e49c8da4 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
>   obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>   obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>   obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
> +obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>   obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>   obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
> new file mode 100644
> index 000000000000..d6098fd5e12f
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sm8350.c
> @@ -0,0 +1,640 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sm8350.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-divider.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL0_OUT_MAIN_DIV,
> +	P_GPU_CC_PLL0_OUT_MAIN,
> +	P_GPU_CC_PLL1_OUT_MAIN,
> +};
> +
> +static struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1750000000, 0 },
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll0_config = {
> +	.l = 0x18,
> +	.alpha = 0x6000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",
> +				.name = "bi_tcxo",

We are introducing new driver without previous non-dts bindings, so 
there is no need for .name fields.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll1_config = {
> +	.l = 0x1A,
> +	.alpha = 0xAAA,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1 = {
> +	.offset = 0x100,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll1",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",
> +				.name = "bi_tcxo",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> +	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
> +	{ .hw = &gpu_cc_pll0.clkr.hw },
> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
> +	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> +	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
> +	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
> +	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src = {
> +	.cmd_rcgr = 0x1120,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_0,
> +	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gmu_clk_src",
> +		.parent_data = gpu_cc_parent_data_0,
> +		.num_parents = 5,

Could you please use ARRAY_SIZE()

> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_hub_clk_src[] = {
> +	F(150000000, P_GPLL0_OUT_MAIN_DIV, 2, 0, 0),
> +	F(240000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_hub_clk_src = {
> +	.cmd_rcgr = 0x117c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_1,
> +	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_hub_clk_src",
> +		.parent_data = gpu_cc_parent_data_1,
> +		.num_parents = 4,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
> +	.reg = 0x11c0,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "gpu_cc_hub_ahb_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data){
> +			.hw = &gpu_cc_hub_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
> +	.reg = 0x11bc,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "gpu_cc_hub_cx_int_div_clk_src",
> +		.parent_data = &(const struct clk_parent_data){
> +			.hw = &gpu_cc_hub_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_ahb_clk = {
> +	.halt_reg = 0x1078,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_ahb_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cb_clk = {
> +	.halt_reg = 0x1170,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1170,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_crc_ahb_clk = {
> +	.halt_reg = 0x107c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x107c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_crc_ahb_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_apb_clk = {
> +	.halt_reg = 0x1088,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_apb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gmu_clk = {
> +	.halt_reg = 0x1098,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gmu_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_at_clk = {
> +	.halt_reg = 0x1080,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_at_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_trig_clk = {
> +	.halt_reg = 0x1094,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_trig_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_tsctr_clk = {
> +	.halt_reg = 0x1084,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_tsctr_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
> +	.halt_reg = 0x108c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x108c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_snoc_dvm_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_aon_clk = {
> +	.halt_reg = 0x1004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_aon_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk = {
> +	.halt_reg = 0x109c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x109c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_freq_measure_clk = {
> +	.halt_reg = 0x120c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x120c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_freq_measure_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_gmu_clk = {
> +	.halt_reg = 0x1064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gmu_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_qdss_tsctr_clk = {
> +	.halt_reg = 0x105c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x105c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_qdss_tsctr_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_vsense_clk = {
> +	.halt_reg = 0x1058,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_vsense_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
> +	.halt_reg = 0x5000,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x5000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_aon_clk = {
> +	.halt_reg = 0x1178,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1178,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hub_aon_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_cx_int_clk = {
> +	.halt_reg = 0x1204,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1204,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hub_cx_int_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_0_gfx3d_clk = {
> +	.halt_reg = 0x802c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x802c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_mnd1x_0_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_1_gfx3d_clk = {
> +	.halt_reg = 0x8030,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_mnd1x_1_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_sleep_clk = {
> +	.halt_reg = 0x1090,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc gpu_cx_gdsc = {
> +	.gdscr = 0x106c,
> +	.gds_hw_ctrl = 0x1540,
> +	.pd = {
> +		.name = "gpu_cx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc gpu_gx_gdsc = {
> +	.gdscr = 0x100c,
> +	// sw-reset = 0x1008,
> +	// domain-addr = 0x158c,
> +	.clamp_io_ctrl = 0x1508, // real?

Should this be fixed or removed?

> +	.pd = {
> +		.name = "gpu_gx_gdsc",
> +		.power_on = gdsc_gx_do_nothing_enable,
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = AON_RESET | POLL_CFG_GDSCR,

Comparing this with other gpucc drivers, don't we need CLAMP_IO here?

> +};
> +
> +static struct clk_regmap *gpu_cc_sm8350_clocks[] = {
> +	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
> +	[GPU_CC_CB_CLK] = &gpu_cc_cb_clk.clkr,
> +	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
> +	[GPU_CC_CX_APB_CLK] = &gpu_cc_cx_apb_clk.clkr,
> +	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> +	[GPU_CC_CX_QDSS_AT_CLK] = &gpu_cc_cx_qdss_at_clk.clkr,
> +	[GPU_CC_CX_QDSS_TRIG_CLK] = &gpu_cc_cx_qdss_trig_clk.clkr,
> +	[GPU_CC_CX_QDSS_TSCTR_CLK] = &gpu_cc_cx_qdss_tsctr_clk.clkr,
> +	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
> +	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
> +	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
> +	[GPU_CC_FREQ_MEASURE_CLK] = &gpu_cc_freq_measure_clk.clkr,
> +	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> +	[GPU_CC_GX_GMU_CLK] = &gpu_cc_gx_gmu_clk.clkr,
> +	[GPU_CC_GX_QDSS_TSCTR_CLK] = &gpu_cc_gx_qdss_tsctr_clk.clkr,
> +	[GPU_CC_GX_VSENSE_CLK] = &gpu_cc_gx_vsense_clk.clkr,
> +	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
> +	[GPU_CC_HUB_AHB_DIV_CLK_SRC] = &gpu_cc_hub_ahb_div_clk_src.clkr,
> +	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
> +	[GPU_CC_HUB_CLK_SRC] = &gpu_cc_hub_clk_src.clkr,
> +	[GPU_CC_HUB_CX_INT_CLK] = &gpu_cc_hub_cx_int_clk.clkr,
> +	[GPU_CC_HUB_CX_INT_DIV_CLK_SRC] = &gpu_cc_hub_cx_int_div_clk_src.clkr,
> +	[GPU_CC_MND1X_0_GFX3D_CLK] = &gpu_cc_mnd1x_0_gfx3d_clk.clkr,
> +	[GPU_CC_MND1X_1_GFX3D_CLK] = &gpu_cc_mnd1x_1_gfx3d_clk.clkr,
> +	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
> +	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
> +	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
> +};
> +
> +static const struct qcom_reset_map gpu_cc_sm8350_resets[] = {
> +	[GPUCC_GPU_CC_ACD_BCR] = { 0x1160 },
> +	[GPUCC_GPU_CC_CB_BCR] = { 0x116c },
> +	[GPUCC_GPU_CC_CX_BCR] = { 0x1068 },
> +	[GPUCC_GPU_CC_FAST_HUB_BCR] = { 0x1174 },
> +	[GPUCC_GPU_CC_GFX3D_AON_BCR] = { 0x10a0 },
> +	[GPUCC_GPU_CC_GMU_BCR] = { 0x111c },
> +	[GPUCC_GPU_CC_GX_BCR] = { 0x1008 },
> +	[GPUCC_GPU_CC_XO_BCR] = { 0x1000 },
> +};
> +
> +static struct gdsc *gpu_cc_sm8350_gdscs[] = {
> +	[GPU_CX_GDSC] = &gpu_cx_gdsc,
> +	[GPU_GX_GDSC] = &gpu_gx_gdsc,
> +};
> +
> +static const struct regmap_config gpu_cc_sm8350_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x8030,
> +	.fast_io = true,
> +};
> +
> +static const struct qcom_cc_desc gpu_cc_sm8350_desc = {
> +	.config = &gpu_cc_sm8350_regmap_config,
> +	.clks = gpu_cc_sm8350_clocks,
> +	.num_clks = ARRAY_SIZE(gpu_cc_sm8350_clocks),
> +	.resets = gpu_cc_sm8350_resets,
> +	.num_resets = ARRAY_SIZE(gpu_cc_sm8350_resets),
> +	.gdscs = gpu_cc_sm8350_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gpu_cc_sm8350_gdscs),
> +};
> +
> +static const struct of_device_id gpu_cc_sm8350_match_table[] = {
> +	{ .compatible = "qcom,sm8350-gpucc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpu_cc_sm8350_match_table);
> +
> +static int gpu_cc_sm8350_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm8350_desc);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "Failed to map gpu cc registers\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm8350_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm8350_driver = {
> +	.probe = gpu_cc_sm8350_probe,
> +	.driver = {
> +		.name = "sm8350-gpucc",
> +		.of_match_table = gpu_cc_sm8350_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sm8350_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm8350_driver);
> +}
> +subsys_initcall(gpu_cc_sm8350_init);
> +
> +static void __exit gpu_cc_sm8350_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sm8350_driver);
> +}
> +module_exit(gpu_cc_sm8350_exit);
> +
> +MODULE_DESCRIPTION("QTI GPU_CC SM8350 Driver");
> +MODULE_LICENSE("GPL v2");


-- 
With best wishes
Dmitry
