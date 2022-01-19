Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB54943BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiASXP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiASXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:14:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:14:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x7so14416782lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PbQl0BUn++ZB1i9uODmQ5ljj1iJBVeOFEPuDnyWs3xs=;
        b=BghlF19x8AQECHFk1LWzUs8loj0o450isIXnhV5UFd4gJH+MjeY6SxVNFPaiChU+rE
         mSFxggcrXUa+WFBYkj1zJiAlg1Va+0EkufrCanIuJmrwWs2pUUE8SnruiSYx1WEiUf8W
         P9+a2vUkbTG32v167Eiw+U+afcLyJSRDqxUKwCwV/GfgcKO8OyVUfCYWBpivzBCUowH9
         xd5ah/LFgz2pAPe0QzyT/S28Zf6ETKlocAuVMsCr3/EI2Ab6AR201k7dutPsyPO49mkE
         c3RLlxjLmLzmFq4nTGs9U0C+evsqyLp0ClWrbdFKXS2xP/nK7UgKPva2VZE2wT/ErfUn
         hOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PbQl0BUn++ZB1i9uODmQ5ljj1iJBVeOFEPuDnyWs3xs=;
        b=JT8Fw4L91yUceXdRiKaD4ykYXbZkm0Kvs76+nZVFFxOlO+WCULI04fssFauszjUxqk
         ire1L9hVZ1jTo46qglLGiToQqV+OkPtv61aKXI1H2J5lCkSUVEQtbOGwlnCkfTsppb2u
         AENTjvgylAoQ/kaiCG095wO+zDjRE3cWBFMYfgRBe8E6jHcXrYlekOGGZovBitU5dtV9
         v8QLuMq2OdJMfHN8jDJH6dNhgn1QS5LI9yo6/yEptQhS0SXurT3HaPq3LC8FIm5HX+mU
         oHuQMeKuhb2APbxIvTVIJKTe1PAv7Fh/2G+ngYByhBY9gLLrHvi8ynyUon4qsvcEKtfp
         GrqQ==
X-Gm-Message-State: AOAM532gMKJozqx8OmQVuq023iMd16P/J/XZ6wdIVKv2RNkGBI5Bfnhk
        xX3uq7M8Gngw5vGwfh7cCRECqg==
X-Google-Smtp-Source: ABdhPJyIGbFbXxIUsw5VhJwKDJr0lHFFTp7Ydun85LWYMO1pX6Qobx0Wz20uLUDHliD8JnPJUCZV5w==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr15946359ljp.390.1642634063482;
        Wed, 19 Jan 2022 15:14:23 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l22sm107192lfh.137.2022.01.19.15.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 15:14:22 -0800 (PST)
Message-ID: <176fb0bc-2f09-df3b-86be-ef69b8e6cea8@linaro.org>
Date:   Thu, 20 Jan 2022 02:14:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/msm/dp: Add DisplayPort controller for SM8350
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228045934.1524865-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211228045934.1524865-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2021 07:59, Bjorn Andersson wrote:
> The Qualcomm SM8350 platform comes with a single DisplayPort controller,
> add support for this in the DisplayPort driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   .../devicetree/bindings/display/msm/dp-controller.yaml    | 1 +
>   drivers/gpu/drm/msm/dp/dp_display.c                       | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 5457612ab136..cd05cfd76536 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -21,6 +21,7 @@ properties:
>         - qcom,sc7280-edp
>         - qcom,sc8180x-dp
>         - qcom,sc8180x-edp
> +      - qcom,sm8350-dp
>   
>     reg:
>       items:
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 8d9c19dbf33e..fd0fd03f8fed 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -143,10 +143,18 @@ static const struct msm_dp_config sc7280_dp_cfg = {
>   	.num_descs = 2,
>   };
>   
> +static const struct msm_dp_config sm8350_dp_cfg = {
> +	.descs = (const struct msm_dp_desc[]) {
> +		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +	},
> +	.num_descs = 1,
> +};
> +
>   static const struct of_device_id dp_dt_match[] = {
>   	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
>   	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_cfg },
>   	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_cfg },
> +	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_cfg },
>   	{}
>   };
>   


-- 
With best wishes
Dmitry
