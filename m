Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B1514F95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378541AbiD2Pie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377782AbiD2Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:38:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A918344
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:35:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n14so14671868lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jMT4TT5P8owVF9luCAEwViUwvrHVEy/mXna8eqg97zA=;
        b=SzULoFPTREh5J1EJTLKiZTodpVReUG3V/vfT97A+wewEEmxkbfiWYZQJnURGS2NXjm
         gUTcF0tGDYJ4K7PGFOJ2ixEbR/rDAZZU6LV3Z8savNifOukpI9B6TUgFAt2yGJIkxNr+
         KUA/0StRmBy34UL8boJ9dJ6iZXx7jM8b3YavaZmtI9m44GzuWfYtf8QcfpgBRg+GPMqI
         cju/LHYOaV3S6QUxnlJFZP3dcGlAy/mPTiA4QAFptL7+Yz1zhLHEOjlZq00CWKp+IusX
         7drnezSDe3rxtP699UcVkt2r3DQ/P9T94XdIRUNDsUMMib6EvOzxE+wQOsxPm8UAC4av
         wKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jMT4TT5P8owVF9luCAEwViUwvrHVEy/mXna8eqg97zA=;
        b=BVROQ5yHiQfKmSvnQPZm1io+Nv84XqZm9HeKbNHseLFRbkrsxYafirt6PJLpp1ypyx
         JSKYMGIwr2EysaeACVNsAx4d7ZsC7+ty3mdtSNWYHUfXl4HTfqdwEwhkwyvJBjh8AWna
         2Kqzq1g//AAtftEbMLenfBSFrihjunx15otV5pKGldVJM01HJU4kg1I5/0QX24+bQHGF
         rtwNIxXdk5v/X9bpUUoR9H7LSm4mbYO8fNFCseJzzIZSKwuGDA9B81A0pVWOecJEd5x/
         0bNPAPT8H+/CJru76Oc/Fg4YRRTm1kbeBuoXTVa2NdwAdiaftHp0PxaCpDgueLYrEG4I
         miWA==
X-Gm-Message-State: AOAM531g3/hif973nEaHkw2oWpLNPNf1xiqedrr2a/QCFBk2I0m8iZ4C
        F6PlLJU26fmENgcVJe4OyMAOfA==
X-Google-Smtp-Source: ABdhPJzFaFgjdiH85+8IVOWWBKjwzo3XK8EinNHm4PmoTCXk/aS7qA0GQkVBWOCMJN5uYEOA/uCxvA==
X-Received: by 2002:a05:6512:169e:b0:470:2124:63fb with SMTP id bu30-20020a056512169e00b00470212463fbmr28468748lfb.616.1651246509965;
        Fri, 29 Apr 2022 08:35:09 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s3-20020ac24643000000b0047213921f71sm261759lfo.290.2022.04.29.08.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:35:09 -0700 (PDT)
Message-ID: <2012e99c-9303-b92f-fb38-be3064352094@linaro.org>
Date:   Fri, 29 Apr 2022 18:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 6/9] clk: qcom: add support for SM8350 DISPCC
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-6-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-6-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 18:12, Robert Foss wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add support to the SM8350 display clock controller by extending the SM8250
> display clock controller, which is almost identical but has some minor
> differences.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/clk/qcom/Kconfig         |  4 +--
>   drivers/clk/qcom/dispcc-sm8250.c | 61 +++++++++++++++++++++++++++++++-
>   2 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9b1f54e634b9..1752ca0ee405 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -609,11 +609,11 @@ config SM_DISPCC_6125
>   	  splash screen
>   
>   config SM_DISPCC_8250
> -	tristate "SM8150 and SM8250 Display Clock Controller"
> +	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
>   	depends on SM_GCC_8150 || SM_GCC_8250
>   	help
>   	  Support for the display clock controller on Qualcomm Technologies, Inc
> -	  SM8150 and SM8250 devices.
> +	  SM8150/SM8250/SM8350 devices.
>   	  Say Y if you want to support display devices and functionality such as
>   	  splash screen.
>   
> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> index 22d9cbabecab..95f86ffcc3b3 100644
> --- a/drivers/clk/qcom/dispcc-sm8250.c
> +++ b/drivers/clk/qcom/dispcc-sm8250.c
> @@ -43,6 +43,10 @@ static struct pll_vco vco_table[] = {
>   	{ 249600000, 2000000000, 0 },
>   };
>   
> +static struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1750000000, 0 },
> +};
> +
>   static struct alpha_pll_config disp_cc_pll0_config = {
>   	.l = 0x47,
>   	.alpha = 0xE000,
> @@ -1228,6 +1232,7 @@ static const struct of_device_id disp_cc_sm8250_match_table[] = {
>   	{ .compatible = "qcom,sc8180x-dispcc" },
>   	{ .compatible = "qcom,sm8150-dispcc" },
>   	{ .compatible = "qcom,sm8250-dispcc" },
> +	{ .compatible = "qcom,sm8350-dispcc" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
> @@ -1258,7 +1263,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>   		return PTR_ERR(regmap);
>   	}
>   
> -	/* note: trion == lucid, except for the prepare() op */
> +	/* Apply differences for SM8150 and SM8350 */
>   	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
>   	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-dispcc") ||
>   	    of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
> @@ -1270,8 +1275,62 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>   		disp_cc_pll1_config.config_ctl_hi1_val = 0x00000024;
>   		disp_cc_pll1_config.user_ctl_hi1_val = 0x000000D0;
>   		disp_cc_pll1_init.ops = &clk_alpha_pll_trion_ops;
> +	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8350-dispcc")) {
> +		static struct clk_rcg2 * const rcgs[] = {
> +			&disp_cc_mdss_byte0_clk_src,
> +			&disp_cc_mdss_byte1_clk_src,
> +			&disp_cc_mdss_dp_aux1_clk_src,
> +			&disp_cc_mdss_dp_aux_clk_src,
> +			&disp_cc_mdss_dp_link1_clk_src,
> +			&disp_cc_mdss_dp_link_clk_src,
> +			&disp_cc_mdss_dp_pixel1_clk_src,
> +			&disp_cc_mdss_dp_pixel2_clk_src,
> +			&disp_cc_mdss_dp_pixel_clk_src,
> +			&disp_cc_mdss_esc0_clk_src,
> +			&disp_cc_mdss_mdp_clk_src,
> +			&disp_cc_mdss_pclk0_clk_src,
> +			&disp_cc_mdss_pclk1_clk_src,
> +			&disp_cc_mdss_rot_clk_src,
> +			&disp_cc_mdss_vsync_clk_src,
> +		};
> +		static struct clk_regmap_div * const divs[] = {
> +			&disp_cc_mdss_byte0_div_clk_src,
> +			&disp_cc_mdss_byte1_div_clk_src,
> +			&disp_cc_mdss_dp_link1_div_clk_src,
> +			&disp_cc_mdss_dp_link_div_clk_src,
> +		};
> +		unsigned int i;
> +		static bool offset_applied;
> +
> +		/* only apply the offsets once (in case of deferred probe) */
> +		if (!offset_applied) {
> +			for (i = 0; i < ARRAY_SIZE(rcgs); i++)
> +				rcgs[i]->cmd_rcgr -= 4;
> +
> +			for (i = 0; i < ARRAY_SIZE(divs); i++) {
> +				divs[i]->reg -= 4;
> +				divs[i]->width = 4;
> +			}
> +
> +			disp_cc_mdss_ahb_clk.halt_reg -= 4;
> +			disp_cc_mdss_ahb_clk.clkr.enable_reg -= 4;
> +
> +			offset_applied = true;
> +		}
> +
> +		disp_cc_mdss_ahb_clk_src.cmd_rcgr = 0x22a0;
> +
> +		disp_cc_pll0_config.config_ctl_hi1_val = 0x2A9A699C;
> +		disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll0.vco_table = lucid_5lpe_vco;
> +		disp_cc_pll1_config.config_ctl_hi1_val = 0x2A9A699C;
> +		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll1.vco_table = lucid_5lpe_vco;
>   	}
>   
> +	/* note for SM8350: downstream lucid_5lpe configure differs slightly */

Isn't this already being taken care by the previous code?

With this comment removed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>   	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
>   	clk_lucid_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
>   


-- 
With best wishes
Dmitry
