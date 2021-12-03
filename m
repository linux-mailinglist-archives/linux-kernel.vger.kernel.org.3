Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF34670A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbhLCDXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbhLCDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:23:41 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F57C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:20:17 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso624706ood.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJoVk3rXUz398tlAPaYkfNg5UuqyJJndacNsBihAPCQ=;
        b=FpCIRndlBi8LdIwXFzDDWqUjuVMB/0kC9GzScyMBEcxryNtrqisNi2G1SpWLyChVWx
         ORFkgZQ7wOG0D8XCr9sQgT7zdOSe8Y3aHeowoVGBPFpGQSovfu2QZgL41gs+LTlYEeRd
         RfOEORj16JKgH5k+hSe0J+ZhrhXKB9FRPrZWN646yRKhVCSsV0nukdSxJfh9M9S1aoUI
         uXJIzKvknR3Lfiou+Jmx+EIg0GaHV1vHcgGBpglh3x279CjhlKNS8RsYyR+Y2c/rdeMu
         kZVGoDmS2W0XRLlYeg8uGLelvf4fxnf/mONUgqJ2lACO3aRUsuvVmmg0WQ0bUU3YM1o0
         r5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJoVk3rXUz398tlAPaYkfNg5UuqyJJndacNsBihAPCQ=;
        b=dfSQ8ZzmoRcTFiKjeDel7Bf46pAhojoU3OKzZ6KsNfE31EVBoiU6kbhpNVm/3Pteel
         kt+Dg/Fc0fD4foXt3SxqUjBfubYZOiekEwl6UYj9m3KBt/ZL+0/UwSt7vCLr+JC4Zud5
         +ZqgllN7q3E5g+T2TpxnTNcwGtRbcDck1XlPqDWyJl/OyrtmqSRZkO6O5cjtm+QAPmhD
         +PEdFMfF5KyzdpFIDecWPmM/MEiFCelpue83bbRuIRx7Id+0g558TaR7jZxmA+0Inoku
         sroVhp3KE11VRFvFFeSf8hR6yy0R86UlJe/C6AabicHynAnpjJsR4zqybU3DeqyK2Ood
         mvYw==
X-Gm-Message-State: AOAM532MtPxqNB8Awml4wnfN4OZvYpr8XBidck2xdWt6QOK0+JuD7MzM
        2XbFqXr/2H3XKTzkILwfIIaLpA==
X-Google-Smtp-Source: ABdhPJzcnbKzTROSXM07Z6AAlu+A4kXhtriXTKVzNcQBvpOGfbkoLPmRCRmcQ50N7tsa58D63aYuVg==
X-Received: by 2002:a05:6830:1049:: with SMTP id b9mr14391159otp.60.1638501617215;
        Thu, 02 Dec 2021 19:20:17 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t12sm395218oor.21.2021.12.02.19.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:20:16 -0800 (PST)
Date:   Thu, 2 Dec 2021 21:20:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 3/3] phy: qcom-qmp: Add SM8450 UFS QMP Phy
Message-ID: <YamM65exw/iAqB3Q@yoga>
References: <20211201074456.3969849-1-vkoul@kernel.org>
 <20211201074456.3969849-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201074456.3969849-4-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Dec 01:44 CST 2021, Vinod Koul wrote:

> SM8450 UFS seems to use same sequence as SM8350, so reuse the sequence
> from SM8450. Add the new clock list for this phy and the new compatible
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 456a59d8c7d0..a959c97a699f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3091,6 +3091,10 @@ static const char * const qmp_v4_sm8250_usbphy_clk_l[] = {
>  	"aux", "ref_clk_src", "com_aux"
>  };
>  
> +static const char * const sm8450_ufs_phy_clk_l[] = {
> +	"qref", "ref", "ref_aux",
> +};
> +
>  static const char * const sdm845_ufs_phy_clk_l[] = {
>  	"ref", "ref_aux",
>  };
> @@ -4087,6 +4091,31 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>  	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>  };
>  
> +static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
> +	.type			= PHY_TYPE_UFS,
> +	.nlanes			= 2,
> +
> +	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
> +	.tx_tbl			= sm8350_ufsphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
> +	.rx_tbl			= sm8350_ufsphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
> +	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
> +	.clk_list		= sm8450_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sm8150_ufsphy_regs_layout,
> +
> +	.start_ctrl		= SERDES_START,
> +	.pwrdn_ctrl		= SW_PWRDN,
> +	.phy_status		= PHYSTATUS,
> +
> +	.is_dual_lane_phy	= true,
> +};
> +
>  static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>  	.type			= PHY_TYPE_USB3,
>  	.nlanes			= 1,
> @@ -5745,6 +5774,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sm8350-qmp-usb3-uni-phy",
>  		.data = &sm8350_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8450-qmp-ufs-phy",
> +		.data = &sm8450_ufsphy_cfg,
>  	}, {
>  		.compatible = "qcom,qcm2290-qmp-usb3-phy",
>  		.data = &qcm2290_usb3phy_cfg,
> -- 
> 2.31.1
> 
