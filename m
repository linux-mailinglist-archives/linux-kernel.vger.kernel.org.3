Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71514FF08C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiDMH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiDMH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:29:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2CD47
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:27:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w19so1898376lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QARgvmkpr8VVbyyV9NCF/ci4KYaV871c1Ej+b6nyl0E=;
        b=aSERqlI6AgOSiUivPNKdqIbmT5M9Xv2yCQJxrGNk7ZF/XMJYXIkpoKgA/YEvUsje1y
         090G2iyN7TJFvJqgRn2IQVPedZ7bIlDdZgkwACxORsQ2x47GASAOJ574hsEiNHtY+A6M
         QP6guAS99tnF4hG5Mez/T74bgZbcRgageIJ5cDoirD1/URyjKP1zHU40n4Cv+Ry8dGq7
         N6QvyW1QExYFHxrk7cBYKxObhUqiVaswFg+dbdwgDhVkVaeqZdK15cui+TR1pSjhdCTm
         Xfl2vUq4bJROYc6z7yV+MR5BYUpJxIpxzNHJNDdb4PeudOFx44liJBr9QkHa+xzMXNn5
         wonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QARgvmkpr8VVbyyV9NCF/ci4KYaV871c1Ej+b6nyl0E=;
        b=gyV7IiWoDVj/u4ePHEoA/QKMOmdFfR/tTsF2JAHfuuPXPdZPKXTjShmBCXw4S9fMZq
         KRhH1CEm8N/iRKVpg2dtCQfmWgS8BmQB2Pai/jDpcn3/UEITkLKUKY+80iTG5LCoUTn7
         CCyFfJR6fSs1vK5lRva1Pos5w1/1Gn/GdBWRv7oYGXUOx8SnIHUn2Kuzh0okhz9ZAtrN
         xNh3DCib6AszzIeUzZPG5T+0m9aH8oRnt5K/9PC2EEvirXQ6QUXZMZ8A8d6tVBsVzQWU
         qwVCm8G8WcuKhlFJoQX1ww3vQxTLsWu4mq9xN3sfB/spM6Ds0fOGT4P9CsM8WkeciNQm
         60yA==
X-Gm-Message-State: AOAM533wO0gJ0xgRnN2m2OmPp6q0WM3FiodqTiDWrF5GTwnXcEk5xs1P
        H95l8LheXWi8ObRKggk5HvxZsA==
X-Google-Smtp-Source: ABdhPJyCMeaEoNC8ctpBkTlLeoBr7h/Q6l6by9SEIGLzZHnngd0lYcZwtTOD4kceei/TXW5O2Cm12Q==
X-Received: by 2002:a05:6512:1526:b0:45d:cd2b:912d with SMTP id bq38-20020a056512152600b0045dcd2b912dmr28578677lfb.409.1649834841264;
        Wed, 13 Apr 2022 00:27:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b6-20020a2ebc06000000b0024b5c9e91c4sm1125356ljf.63.2022.04.13.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 00:27:20 -0700 (PDT)
Message-ID: <bad40b1b-73af-a1f3-d0df-b59e4a599015@linaro.org>
Date:   Wed, 13 Apr 2022 10:27:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] phy: qcom-qmp: Add SM8150 PCIe QMP PHYs
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-phy@lists.infradead.org
Cc:     bhupesh.linux@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org
References: <20220325222130.1783242-1-bhupesh.sharma@linaro.org>
 <20220325222130.1783242-3-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220325222130.1783242-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 01:21, Bhupesh Sharma wrote:
> SM8150 has multiple (different) PHY versions:
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> 
> Add support for these with relevant init sequence.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 90 +++++++++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1f729a..8e928b9619b6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3294,6 +3294,11 @@ static const char * const sdm845_pciephy_clk_l[] = {
>   	"aux", "cfg_ahb", "ref", "refgen",
>   };
>   
> +/* the pcie phy on sm8150 doesn't have a ref clock */
> +static const char * const sm8150_pciephy_clk_l[] = {
> +	"aux", "cfg_ahb", "refgen",

On sm8250 we use GCC_WIFI/WIGIG/MDM_CLKREF_EN clocks as "ref". 
Downstream dts lists them as "pcie_X_ldo". sm8150 also has these clocks 
(GCC_PCIE_n_CLKREF_CLK). Is there any reason why we use CLKREF clocks on 
sm8250, but ommit them on sm8150?

> +};
> +
>   static const char * const qmp_v4_phy_clk_l[] = {
>   	"aux", "ref_clk_src", "ref", "com_aux",
>   };
> @@ -3583,6 +3588,85 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>   	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
> +static const struct qmp_phy_cfg sm8150_qmp_gen3x1_pciephy_cfg = {
> +	.type = PHY_TYPE_PCIE,
> +	.nlanes = 1,
> +
> +	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> +	.serdes_tbl_sec		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
> +	.serdes_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
> +	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
> +	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
> +	.rx_tbl_sec		= sm8250_qmp_gen3x1_pcie_rx_tbl,
> +	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_rx_tbl),
> +	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
> +	.pcs_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_tbl,
> +	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
> +	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x1_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_pcs_misc_tbl),
> +	.clk_list		= sm8150_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sm8250_pcie_regs_layout,
> +
> +	.start_ctrl		= PCS_START | SERDES_START,
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +
> +	.has_pwrdn_delay	= true,
> +	.pwrdn_delay_min	= 995,		/* us */
> +	.pwrdn_delay_max	= 1005,		/* us */
> +};
> +
> +static const struct qmp_phy_cfg sm8150_qmp_gen3x2_pciephy_cfg = {
> +	.type = PHY_TYPE_PCIE,
> +	.nlanes = 2,
> +
> +	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
> +	.tx_tbl			= sm8250_qmp_pcie_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_tx_tbl),
> +	.tx_tbl_sec		= sm8250_qmp_gen3x2_pcie_tx_tbl,
> +	.tx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
> +	.rx_tbl			= sm8250_qmp_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_rx_tbl),
> +	.rx_tbl_sec		= sm8250_qmp_gen3x2_pcie_rx_tbl,
> +	.rx_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
> +	.pcs_tbl		= sm8250_qmp_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_pcs_tbl),
> +	.pcs_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
> +	.pcs_tbl_num_sec		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
> +	.pcs_misc_tbl_sec		= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num_sec	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	.clk_list		= sm8150_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sm8150_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sm8250_pcie_regs_layout,
> +
> +	.start_ctrl		= PCS_START | SERDES_START,
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +
> +	.is_dual_lane_phy	= true,
> +	.has_pwrdn_delay	= true,
> +	.pwrdn_delay_min	= 995,		/* us */
> +	.pwrdn_delay_max	= 1005,		/* us */
> +};
> +
>   static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>   	.type = PHY_TYPE_PCIE,
>   	.nlanes = 1,
> @@ -6007,6 +6091,12 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
>   	}, {
>   		.compatible = "qcom,sm6115-qmp-ufs-phy",
>   		.data = &sm6115_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy",
> +		.data = &sm8150_qmp_gen3x1_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy",
> +		.data = &sm8150_qmp_gen3x2_pciephy_cfg,
>   	}, {
>   		.compatible = "qcom,sm8150-qmp-ufs-phy",
>   		.data = &sm8150_ufsphy_cfg,


-- 
With best wishes
Dmitry
