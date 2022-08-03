Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E548588802
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiHCHc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiHCHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:32:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70D1E3CF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:32:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h12so18017890ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tCz0eZ7hj0SBYcW7YLoM4xbGHfSBezEbOzG70uXQv2E=;
        b=UQnCKUKKvtVHCY04Bl7gqxpeS17g7R/aV2jI3AoSjsZfWJZMyaaAucq3S6ZVXgkTOK
         8NQueQoHM9J1NqcdLQx6udmD+BA7fg207woCKShBKdwPrAdWPUsix8mGKei4mR6jJGJL
         D+4ziuOUQQ6J71TRGCTKo9dO1iISn8GyrkmYNYtDTLB2MqQ81Xy146ExsRs7JxQgBB0A
         TOvOvp1A9r1hYt06GpxirVyV1MXhxxtiiOh6KA9uAuJyEFvhYtnKr4vbYiSHzbVq51e7
         EnpPx/9htA3E8rp+kVh0uVpakb16GqcjsDHF8bp4hm4BNYpBoYp5hlanbFhZYRvnGMLX
         tHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tCz0eZ7hj0SBYcW7YLoM4xbGHfSBezEbOzG70uXQv2E=;
        b=zApm6sVBQbeG9taRpOL9PFpVS4L6rYvk/br39+ShBb/awD2K/FRBxb1eu5810hx9uT
         k77YZ7fFTLLKP7U0HVl08wffQB7b5IYXvptt0tN2cvgoFcr0EA6D+Rl/3VgMW4HHgEFQ
         tTF5eUYFxL2c+i8ni89KhZ2j329nGgCVvASKvgEdNjOAB42BAMzXdFEWNPvocLxCOSrg
         OH1V0RUEOPz5fYgS4gVaWtrInSIyfeyxO6BeL16x/NGZfD0dORrXFmI1SSVwLdovX8Pb
         jBZlOzPC2XTeBDEM5guQmd1IGrMT/0o1sb+Nh/2PWl4wCQWJsv066ku+9esD9OxIqskZ
         3NVw==
X-Gm-Message-State: AJIora9Ca1e+PkvpPK59AUJgKKqso7jiSqXy3dKcTNQQRlLZZ0H9ibpr
        k7phFbkMGU03H00Bu6NVrsZraQ==
X-Google-Smtp-Source: AGRyM1uNPBvCp/iMne+R+R5SxoIvwyxixvegV3a1Ek6hsgb/gXtraJ6LYaaBAC7qNVfH0EePFBnE+w==
X-Received: by 2002:a2e:9d59:0:b0:25e:1eda:86f6 with SMTP id y25-20020a2e9d59000000b0025e1eda86f6mr7888434ljj.315.1659511970088;
        Wed, 03 Aug 2022 00:32:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bp23-20020a056512159700b0048a83336343sm2339145lfb.252.2022.08.03.00.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:32:49 -0700 (PDT)
Message-ID: <3f79c5b1-9ce8-6aeb-300a-565ba018ae11@linaro.org>
Date:   Wed, 3 Aug 2022 10:32:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] drm/msm/dsi: Improve dsi_phy_driver_probe() probe
 error handling
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.6.I969118a35934a0e5007fe4f80e3e28e9c0b7602a@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220802153434.v3.6.I969118a35934a0e5007fe4f80e3e28e9c0b7602a@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 01:37, Douglas Anderson wrote:
> The dsi_phy_driver_probe() function has a "goto fail" for no
> reason. Change it to just always return directly when it sees an
> error. Make this simpler by leveraging dev_err_probe() which is
> designed to make code like this shorter / simpler.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

> ---
> 
> Changes in v3:
> - ("Improve dsi_phy_driver_probe() probe error handling") new for v3.
> 
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 74 ++++++++++-----------------
>   1 file changed, 27 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 0a00f9b73fc5..57cd525de7a1 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -621,12 +621,9 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
>   	phy->pdev = pdev;
>   
>   	phy->id = dsi_phy_get_id(phy);
> -	if (phy->id < 0) {
> -		ret = phy->id;
> -		DRM_DEV_ERROR(dev, "%s: couldn't identify PHY index, %d\n",
> -			__func__, ret);
> -		goto fail;
> -	}
> +	if (phy->id < 0)
> +		return dev_err_probe(dev, phy->id,
> +				     "Couldn't identify PHY index\n");
>   
>   	phy->regulator_ldo_mode = of_property_read_bool(dev->of_node,
>   				"qcom,dsi-phy-regulator-ldo-mode");
> @@ -634,88 +631,71 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
>   		phy->cphy_mode = (phy_type == PHY_TYPE_CPHY);
>   
>   	phy->base = msm_ioremap_size(pdev, "dsi_phy", &phy->base_size);
> -	if (IS_ERR(phy->base)) {
> -		DRM_DEV_ERROR(dev, "%s: failed to map phy base\n", __func__);
> -		ret = -ENOMEM;

Here (and in a few cases later) this changes the error code from crafted 
-ENOMEM to the proper one returned by msm_ioremap_size(). This should be 
mentioned in the commit message.

> -		goto fail;
> -	}
> +	if (IS_ERR(phy->base))
> +		return dev_err_probe(dev, PTR_ERR(phy->base),
> +				     "Failed to map phy base\n");
>   
>   	phy->pll_base = msm_ioremap_size(pdev, "dsi_pll", &phy->pll_size);
> -	if (IS_ERR(phy->pll_base)) {
> -		DRM_DEV_ERROR(&pdev->dev, "%s: failed to map pll base\n", __func__);
> -		ret = -ENOMEM;
> -		goto fail;
> -	}
> +	if (IS_ERR(phy->pll_base))
> +		return dev_err_probe(dev, PTR_ERR(phy->pll_base),
> +				     "Failed to map pll base\n");
>   
>   	if (phy->cfg->has_phy_lane) {
>   		phy->lane_base = msm_ioremap_size(pdev, "dsi_phy_lane", &phy->lane_size);
> -		if (IS_ERR(phy->lane_base)) {
> -			DRM_DEV_ERROR(&pdev->dev, "%s: failed to map phy lane base\n", __func__);
> -			ret = -ENOMEM;
> -			goto fail;
> -		}
> +		if (IS_ERR(phy->lane_base))
> +			return dev_err_probe(dev, PTR_ERR(phy->lane_base),
> +					     "Failed to map phy lane base\n");
>   	}
>   
>   	if (phy->cfg->has_phy_regulator) {
>   		phy->reg_base = msm_ioremap_size(pdev, "dsi_phy_regulator", &phy->reg_size);
> -		if (IS_ERR(phy->reg_base)) {
> -			DRM_DEV_ERROR(&pdev->dev, "%s: failed to map phy regulator base\n", __func__);
> -			ret = -ENOMEM;
> -			goto fail;
> -		}
> +		if (IS_ERR(phy->reg_base))
> +			return dev_err_probe(dev, PTR_ERR(phy->reg_base),
> +					     "Failed to map phy regulator base\n");
>   	}
>   
>   	if (phy->cfg->ops.parse_dt_properties) {
>   		ret = phy->cfg->ops.parse_dt_properties(phy);
>   		if (ret)
> -			goto fail;
> +			return ret;
>   	}
>   
>   	ret = devm_regulator_bulk_get_const(dev, phy->cfg->num_regulators,
>   					    phy->cfg->regulator_data,
>   					    &phy->supplies);
>   	if (ret)
> -		goto fail;
> +		return ret;
>   
>   	phy->ahb_clk = msm_clk_get(pdev, "iface");
> -	if (IS_ERR(phy->ahb_clk)) {
> -		DRM_DEV_ERROR(dev, "%s: Unable to get ahb clk\n", __func__);
> -		ret = PTR_ERR(phy->ahb_clk);
> -		goto fail;
> -	}
> +	if (IS_ERR(phy->ahb_clk))
> +		return dev_err_probe(dev, PTR_ERR(phy->ahb_clk),
> +				     "Unable to get ahb clk\n");
>   
>   	/* PLL init will call into clk_register which requires
>   	 * register access, so we need to enable power and ahb clock.
>   	 */
>   	ret = dsi_phy_enable_resource(phy);
>   	if (ret)
> -		goto fail;
> +		return ret;
>   
>   	if (phy->cfg->ops.pll_init) {
>   		ret = phy->cfg->ops.pll_init(phy);
> -		if (ret) {
> -			DRM_DEV_INFO(dev,
> -				"%s: pll init failed: %d, need separate pll clk driver\n",
> -				__func__, ret);
> -			goto fail;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "PLL init failed; need separate clk driver\n");
>   	}
>   
>   	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>   				     phy->provided_clocks);
> -	if (ret) {
> -		DRM_DEV_ERROR(dev, "%s: failed to register clk provider: %d\n", __func__, ret);
> -		goto fail;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register clk provider\n");
>   
>   	dsi_phy_disable_resource(phy);
>   
>   	platform_set_drvdata(pdev, phy);
>   
>   	return 0;
> -
> -fail:
> -	return ret;
>   }
>   
>   static struct platform_driver dsi_phy_platform_driver = {


-- 
With best wishes
Dmitry
