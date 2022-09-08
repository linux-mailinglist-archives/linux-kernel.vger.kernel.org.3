Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF115B1AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIHLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIHLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:10:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD065A3E8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:10:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v6so6057666ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=M8TjVGi+dvieD4daFHMvoDToWClMKumVkJMvJ1/RkFQ=;
        b=JUL+XJHQ4d/04YtpxtDMwFY2Y5MmaF/xiJBFAsvXzhDyQ9lglQuK10Tztc9Em2yx05
         xFR/XXNay9QrpLUaX2Q8YsOIOAkDSzQN3ZRhAT45zn7fKxeOJrcgB+nUyT1ciE5Jkem5
         dSqSLOupHgCk1PBOisWvAhsZVC925rJIob4H+Gc1ll5fyFAOZchFaJEH75T4gprtyQTW
         8zmAelNwh13Xn+3iT+1D8ROFPbGcmCg0ASO9VDp7SpLgQfLmcIDg3NvlUQdh3OY4/lIu
         8ZqpVFWmReLmEljfMqcDc5ItnKuzJHPdSYvWKhueTK4V3qIOTEDTb3SD69/66JaFWTln
         Z7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M8TjVGi+dvieD4daFHMvoDToWClMKumVkJMvJ1/RkFQ=;
        b=hLe9hS/hfq2Z+O+6CWTHRI1+//BkkpI4qFE43pQY8U/WacceeKJ7pPCI09cM/Jy/Ic
         ETUpWMv2OKSqG3KGlJBBQmbopMQgJ56Ny7NkZg8V0Oq0f4kGNzEev7k75VauYQVKUk+c
         RJtJ1MlLNwrEcepPzmWLMgNJ3RGsYzb1lUDKl8d8uc6zHuh0vopEMtKITnJaC4jvC5sT
         Xnfo/Q6+amq7iGLKiOlUQpMg/covBIGt2LbqSa3n7EAV8AXK3TgfEKv7qpwdMh+OZTMp
         egGcarlOTmkhSuzP89o6nUIvoGLVDGcTkowB6TPBU+QSpocHfcjwWZn9zqLJvuZjSy8H
         +kDg==
X-Gm-Message-State: ACgBeo2Dsz/+AM+Tca7EV2IoYGH1YheXL/3mZ8XBHEGvVH0zV5txqDrI
        M3hLslrvtn+0j1F3b4OXCS83eQ==
X-Google-Smtp-Source: AA6agR6vHmIYNFIFpblQhNC8Ltenxf7xgA/5SHfm848ngZh43E14ZZH2Q+SOU89YcKh8GIjhp+xWCg==
X-Received: by 2002:a2e:9bd9:0:b0:267:5851:4676 with SMTP id w25-20020a2e9bd9000000b0026758514676mr2226608ljj.10.1662635410616;
        Thu, 08 Sep 2022 04:10:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b00497aae401f8sm762134lfp.184.2022.09.08.04.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:10:09 -0700 (PDT)
Message-ID: <8233a19a-9b0b-6962-6f36-381c8f380ad3@linaro.org>
Date:   Thu, 8 Sep 2022 13:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/3] clk: qcom: gcc-sdm845: add sdm670 global clock
 data
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in
References: <20220907223927.139858-1-mailingradian@gmail.com>
 <20220907223927.139858-4-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907223927.139858-4-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 00:39, Richard Acayan wrote:
> The Snapdragon 670 adds and removes some clocks, adds new frequencies, and
> adds a new GPLL (Global Phase-Locked Loop) in reference to SDM845, while
> also removing some GDSCs. Despite these differences, there are many
> similarities with SDM670. Add data for SDM670 in the driver for SDM845 to
> reuse the most of the clock data.
> 
> Advantages and disadvantages of this approach:
>  + maintenance applies to both sdm670 and sdm845 by default
>  + less duplicate code (clocks) means smaller distro/pre-built kernels
>    with all drivers enabled
>  - clocks for both SoC's must be compiled if the user wants clocks for one
>    specific SoC (both or none)
>  - additional testing needed for sdm845 devices
> 
> Link: https://android.googlesource.com/kernel/msm/+/443bd8d6e2cf54698234c752e6de97b4b8a528bd^!/#F10
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/clk/qcom/Kconfig      |   4 +-
>  drivers/clk/qcom/gcc-sdm845.c | 398 ++++++++++++++++++++++++++++++++++
>  2 files changed, 400 insertions(+), 2 deletions(-)
> 

Thank you for your patch. There is something to discuss/improve.

> +					&gcc_tsif_inactivity_timers_clk.clkr,
> +	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
> +	[GCC_TSIF_REF_CLK_SRC] = &gcc_tsif_ref_clk_src.clkr,
> +	[GCC_UFS_MEM_CLKREF_CLK] = &gcc_ufs_mem_clkref_clk.clkr,
> +	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
> +	[GCC_UFS_PHY_AXI_CLK] = &gcc_ufs_phy_axi_clk.clkr,
> +	[GCC_UFS_PHY_AXI_CLK_SRC] = &gcc_ufs_phy_axi_clk_src.clkr,
> +	[GCC_UFS_PHY_ICE_CORE_CLK] = &gcc_ufs_phy_ice_core_clk.clkr,
> +	[GCC_UFS_PHY_ICE_CORE_CLK_SRC] = &gcc_ufs_phy_ice_core_clk_src.clkr,
> +	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
> +	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
> +	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
> +	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
> +	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
> +	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] =
> +					&gcc_ufs_phy_unipro_core_clk_src.clkr,
> +	[GCC_USB30_PRIM_MASTER_CLK] = &gcc_usb30_prim_master_clk.clkr,
> +	[GCC_USB30_PRIM_MASTER_CLK_SRC] = &gcc_usb30_prim_master_clk_src.clkr,
> +	[GCC_USB30_PRIM_MOCK_UTMI_CLK] = &gcc_usb30_prim_mock_utmi_clk.clkr,
> +	[GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC] =
> +					&gcc_usb30_prim_mock_utmi_clk_src.clkr,
> +	[GCC_USB30_PRIM_SLEEP_CLK] = &gcc_usb30_prim_sleep_clk.clkr,
> +	[GCC_USB3_PRIM_CLKREF_CLK] = &gcc_usb3_prim_clkref_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
> +	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
> +	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
> +	[GCC_VDDA_VS_CLK] = &gcc_vdda_vs_clk.clkr,
> +	[GCC_VDDCX_VS_CLK] = &gcc_vddcx_vs_clk.clkr,
> +	[GCC_VDDMX_VS_CLK] = &gcc_vddmx_vs_clk.clkr,
> +	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
> +	[GCC_VIDEO_AXI_CLK] = &gcc_video_axi_clk.clkr,
> +	[GCC_VIDEO_XO_CLK] = &gcc_video_xo_clk.clkr,
> +	[GCC_VS_CTRL_AHB_CLK] = &gcc_vs_ctrl_ahb_clk.clkr,
> +	[GCC_VS_CTRL_CLK] = &gcc_vs_ctrl_clk.clkr,
> +	[GCC_VS_CTRL_CLK_SRC] = &gcc_vs_ctrl_clk_src.clkr,
> +	[GCC_VSENSOR_CLK_SRC] = &gcc_vsensor_clk_src.clkr,
> +	[GPLL0] = &gpll0.clkr,
> +	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
> +	[GPLL4] = &gpll4.clkr,
> +	[GPLL6] = &gpll6.clkr,
> +	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
> +	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
> +	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
> +	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
> +	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
> +};
> +
>  static struct clk_regmap *gcc_sdm845_clocks[] = {
>  	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
>  	[GCC_AGGRE_UFS_CARD_AXI_CLK] = &gcc_aggre_ufs_card_axi_clk.clkr,
> @@ -3515,6 +3881,7 @@ static const struct qcom_reset_map gcc_sdm845_resets[] = {
>  	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
>  	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
>  	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +	[GCC_SDCC1_BCR] = { 0x26000 },

You are changing existing SDM845, so this should be separate patch with
its own explanation.


Best regards,
Krzysztof
