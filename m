Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5B5877A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiHBHPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiHBHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:15:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFF32DA3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:15:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t1so20666487lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c61IBeGENLBrfZtlLVNhveGWmLmYNBW+8+c+xekhbN4=;
        b=xisHHreQsg8+3CNQvjUzLiFcibwj9uUxJ2QlQewRTagHGQoP36+CZbvfc/rrpsOTsr
         5esKvZs4yhrgNcCEKQfRA3I3wq+Z+aiJ4Y9V4JV9TjrlXTOYVgTtCTsuw7qLBwDyRZ8r
         WFsaNN8T6wlUS6CDzl9oPjiDS/FhO/T5pJ2zo8hhy/FhwQRYsHZfYcgHV10LIKiWJ/Po
         lUoNmmJpUGJxZvrh8NRphScyouZmrcNiWwwzMayOFyD/ettTncNk4fs4mGCUJ4OyrRKU
         1kIDK3/XM4M0j7gW7SDCyhs9oNuaWY1jF6MdTEPNM1s52BlkfE+Zztk6ElhqAeojqbnP
         NYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c61IBeGENLBrfZtlLVNhveGWmLmYNBW+8+c+xekhbN4=;
        b=3n9J4OLErmEcLjHgCxg3V3ZBCMD7y7mDhM+EQeRxNRtweqjQavaPQ37Zb3APz3NKf1
         kAHhbt24NOQoxgqSHyYH0YJHk7n0KFUGeHJuBjND34eE49koZv5g+DRrCDr1PFG1DhI3
         q9otHByLc3U3jIUBwCNYtWAz58IUiVAQ3Vfl81KI0hXrQxFtTuTHAnrj0aoeLsvXF+VI
         8lqpEcAGzHVc/51/LLvwuhT2c9izUgMPEKpsCTXoK4mkMX5pSLpgsb7p2DIZGvYAs8hA
         8h0i2u4J2FzJQK4B616TwyeCZ2kicTeOoVeO1IcW2lAxOB147HYDGqbDc8DVE+Bce9Xj
         pbJw==
X-Gm-Message-State: ACgBeo1xgzpAIQz4FYzpwveuL+B3eicsFSq6/syxO4Nxh+4Z9YzA4f75
        c54xbTfZzE/wDsJQ/xWKLgv3JA==
X-Google-Smtp-Source: AA6agR4DKQ54iF2lBgq5cgDu5t0vw5ELL8IbGd6dlICfMebN3W4GFM72tUtCrYKW0uIY59zfuFAv0Q==
X-Received: by 2002:a05:6512:3c8d:b0:48a:f74a:67b6 with SMTP id h13-20020a0565123c8d00b0048af74a67b6mr3619423lfv.231.1659424528774;
        Tue, 02 Aug 2022 00:15:28 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g12-20020a2ea4ac000000b0025e48907929sm922293ljm.23.2022.08.02.00.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:15:28 -0700 (PDT)
Message-ID: <9098554e-5327-0b7f-f4d0-a81880556136@linaro.org>
Date:   Tue, 2 Aug 2022 10:15:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/5] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Content-Language: en-GB
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730144713.3.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220730144713.3.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 12:17, Akhil P Oommen wrote:
> Allow a consumer driver to poll for cx gdsc collapse through Reset
> framework.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
>   drivers/clk/qcom/gpucc-sc7280.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
> index 9a832f2..f5df51d 100644
> --- a/drivers/clk/qcom/gpucc-sc7280.c
> +++ b/drivers/clk/qcom/gpucc-sc7280.c
> @@ -433,12 +433,18 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
>   	.fast_io = true,
>   };
>   
> +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
> +	[GPU_CX_COLLAPSE] = { .op = gdsc_wait_for_collapse, .priv = &cx_gdsc },
> +};
> +
>   static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
>   	.config = &gpu_cc_sc7280_regmap_config,
>   	.clks = gpu_cc_sc7280_clocks,
>   	.num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
>   	.gdscs = gpu_cc_sc7180_gdscs,
>   	.num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
> +	.resets = gpucc_sc7280_resets,
> +	.num_resets = ARRAY_SIZE(gpucc_sc7280_resets),

An implementation question. Do we have to poll for the GDSC on platforms 
like sm8150/sm8250 which have the plain BCR resets?

>   };
>   
>   static const struct of_device_id gpu_cc_sc7280_match_table[] = {


-- 
With best wishes
Dmitry
