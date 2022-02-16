Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5F4B8B40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiBPOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:20:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiBPOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:20:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BEF1DE599
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f3so3571998wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AA6sqHNZlIg8SGGbsraAtAlG7fg+PCiJ8r+WX/B76Po=;
        b=CtRgQr4vdIESNeW8jYcs0C6ivkl2n0pBfMkfDOpZ6FPM8OkGSHQxhJb+X0ugruc9cN
         rgxTXkLxX4Ev7W9Si/K0a8PJT1tnQ2W3T3DSKG7fnShjGDmhRZFw/3JfRuG/EYD/pydf
         q/yl4QFapvWzNBTA3r9QzFzpt+G46umUgfFyDgeEjpyx0SzubWRfjWifT+CzvYOMW2Ga
         EfMbX23vxb17BHWsLI9vn3HVxT5nLEynoigLxZjDsZ5zIG/1UEWsg0iZ6a1MwR4SL8QP
         qmBN5JyIFcup9jVTbOpt+jIjYZXgb7svY5nxxyXxESBQGKEer0qkTvtRcjanDmiUKGN+
         XODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AA6sqHNZlIg8SGGbsraAtAlG7fg+PCiJ8r+WX/B76Po=;
        b=YQO2++X8a667moYwrrK+zSIEV8/aNc+K9rYUTvaQT8CpRPY45dRhK+scGXqAwW5fEJ
         UWsL/72Rtvgtn5P51v9/tM3Bakm5+45Qs0d89IlKxphOymhEN6xwzOFhG+b+nA9rGwet
         WrGMkyL2IkQdZ5rK+ZhjO/2my7qU7Cxoz008OlRO3Dpwplb5LtXu+9IYDI8OGG2dK1uJ
         pNnE/OBaQ5wmCKSmi42sbPEYM3D+5chDzcb45diEVEsWhCvtF5CfZUzIWmETNpdUpHEk
         O2Mv44EJ5G7E2D4Ei+O/pt6b2o7o7YlcLsZVYuHEjEmcnklW68OmNEGuCt5zuREjpSlr
         bBcw==
X-Gm-Message-State: AOAM5308PZ3QOdElIVl8S/jW5Hy7j3z2T2+X8EuNXLHYMip50qpwfqhJ
        gGVUFKht5Rj7zLzIEOwHWBofvg==
X-Google-Smtp-Source: ABdhPJzK8GjerP0gr5REaN0lpUxRC3/agCT70JvKOqZN+hZJp49y95J3ljQEeWqh1kgthEzhPnzZeQ==
X-Received: by 2002:adf:fe0d:0:b0:1e3:3f5e:7469 with SMTP id n13-20020adffe0d000000b001e33f5e7469mr2520594wrr.61.1645021205108;
        Wed, 16 Feb 2022 06:20:05 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id j6sm24002828wrt.70.2022.02.16.06.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 06:20:04 -0800 (PST)
Message-ID: <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org>
Date:   Wed, 16 Feb 2022 14:20:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 7/7] pinctrl: qcom: Update clock voting as optional
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
> need macro and decodec clocks, these are maintained as power domains and
> operated from lpass audio core cc.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 16 +++++++++-------
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  1 +
>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c |  1 +
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 8a82fd9..103f0a6c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -407,13 +407,15 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
>   				     "Slew resource not provided\n");
>   
> -	ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Can't get clocks\n");
> -
> -	ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Can't enable clocks\n");
> +	if (!data->is_clk_optional) {
> +		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
> +
> +		ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Can't enable clocks\n");
> +	}
>   
>   	pctrl->desc.pctlops = &lpi_gpio_pinctrl_ops;
>   	pctrl->desc.pmxops = &lpi_gpio_pinmux_ops;
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> index a511d72..c1079bf 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -77,6 +77,7 @@ struct lpi_pinctrl_variant_data {
>   	int ngroups;
>   	const struct lpi_function *functions;
>   	int nfunctions;
> +	int is_clk_optional;
>   };
>   
>   int lpi_pinctrl_probe(struct platform_device *pdev);
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> index 5bf30d97..4277e31 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> @@ -143,6 +143,7 @@ static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>   	.ngroups = ARRAY_SIZE(sc7280_groups),
>   	.functions = sc7280_functions,
>   	.nfunctions = ARRAY_SIZE(sc7280_functions),
> +	.is_clk_optional = 1,

This is forcefully set assuming that sc7280 is always used in ADSP 
bypass mode. Which is not correct.

Can't you use devm_clk_bulk_get_optional instead?

--srini

>   };
>   
>   static const struct of_device_id lpi_pinctrl_of_match[] = {
