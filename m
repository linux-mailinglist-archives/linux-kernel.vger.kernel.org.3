Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A85514F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbiD2PgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378487AbiD2PgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:36:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97216541AD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:32:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so14672775lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=74mQW4KLk9pT6It5kma4iQOF1/OQ3T5soZPy6uFm7bU=;
        b=o+hJDbDtPeC2H94/JnT+yfkZa4lTDWxNsYr63f89TTv8h1qvtho4vfKWlayCPCsZFr
         Dtmv3I51rj6nWn55nMXBrZD2LC6tuDH75mKRjOLYfz+x/Q762ai+dgScrYRQquQ/rtJ1
         GjYPc4T2Nq1hXSIbDQpmL0pM//+imxq4Nf4holSl9T8567jZZwBMUTS73cPQHhZ/S/sl
         3xgR92cgKgGmVPWUKxt+Un5XOxJwIUoL0xxuhV6mGf25Tp/ZycuzejulVfjV9wOzLR1P
         e/Z8IaHdqPSzkCUB3rrf6Go6MKHKiGWXzApx/FjuFfh2EU7JV1UBYqDvswuNOGa8Zi56
         Emyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=74mQW4KLk9pT6It5kma4iQOF1/OQ3T5soZPy6uFm7bU=;
        b=MZNU30zE98SkvMSzXIox5h17PONeeRhXaDTY4TPLK3PzPwa510dr1/OnBNz8Ya2Dc/
         A4QEmETEfauUVcGoq4eL8IyU7l9ze1dmeO8wfd/iX2MjtIpG0rDdX1eeFH/UFv4D019H
         AkPCQQYyhNhzosaHgcVa/zt5WTmcinCxRsy2SDMNkb11pPuwZmw0C6fwNQsD9tEr/OWb
         N6ZLKXqp3s0aIAZZhte8adz+kxWtlsybX6t+35IkbBtO7ZnCDkBMYkdmf8rQFrnJMN8O
         O6McNYrbyMRx0vr3mENXPXLW7GwTYU9h57E896Dh5Jg7B93l9IExe2hiN5L15IKA/dYQ
         WcBQ==
X-Gm-Message-State: AOAM531B4c1vymcxfQbFb00mw6l6sRkn1sOxCe7I9VXd4rASj+gBMyY2
        iXuFuevtZlzEAJUfPNt+YHFRtA==
X-Google-Smtp-Source: ABdhPJybhXYkGY1wj309oPqqPdUYuuAVfsdO9/1/t2vYYGdKoD6XagxBryw5z9pZLscNu8virMpYnQ==
X-Received: by 2002:a05:6512:11cc:b0:44a:5770:7425 with SMTP id h12-20020a05651211cc00b0044a57707425mr26976977lfr.406.1651246369984;
        Fri, 29 Apr 2022 08:32:49 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f8-20020a19dc48000000b004720649aa22sm262066lfj.182.2022.04.29.08.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:32:49 -0700 (PDT)
Message-ID: <56189cee-d300-41f4-259d-fc74510f7afd@linaro.org>
Date:   Fri, 29 Apr 2022 18:32:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 5/9] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-5-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-5-robert.foss@linaro.org>
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
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>

> ---
>   .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
>   include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 +++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 9ebcb1943b0a..4090cc7ea2ae 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -20,6 +20,7 @@ description: |
>       dt-bindings/clock/qcom,gpucc-sm6350.h
>       dt-bindings/clock/qcom,gpucc-sm8150.h
>       dt-bindings/clock/qcom,gpucc-sm8250.h
> +    dt-bindings/clock/qcom,gpucc-sm8350.h
>   
>   properties:
>     compatible:
> @@ -31,6 +32,7 @@ properties:
>         - qcom,sm6350-gpucc
>         - qcom,sm8150-gpucc
>         - qcom,sm8250-gpucc
> +      - qcom,sm8350-gpucc
>   
>     clocks:
>       items:
> diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> new file mode 100644
> index 000000000000..d2294e0d527e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> +#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> +
> +/* GPU_CC clocks */
> +#define GPU_CC_AHB_CLK			0
> +#define GPU_CC_CB_CLK			1
> +#define GPU_CC_CRC_AHB_CLK		2
> +#define GPU_CC_CX_APB_CLK		3
> +#define GPU_CC_CX_GMU_CLK		4
> +#define GPU_CC_CX_QDSS_AT_CLK		5
> +#define GPU_CC_CX_QDSS_TRIG_CLK		6
> +#define GPU_CC_CX_QDSS_TSCTR_CLK	7
> +#define GPU_CC_CX_SNOC_DVM_CLK		8
> +#define GPU_CC_CXO_AON_CLK		9
> +#define GPU_CC_CXO_CLK			10
> +#define GPU_CC_FREQ_MEASURE_CLK		11
> +#define GPU_CC_GMU_CLK_SRC		12
> +#define GPU_CC_GX_GMU_CLK		13
> +#define GPU_CC_GX_QDSS_TSCTR_CLK	14
> +#define GPU_CC_GX_VSENSE_CLK		15
> +#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	16
> +#define GPU_CC_HUB_AHB_DIV_CLK_SRC	17
> +#define GPU_CC_HUB_AON_CLK		18
> +#define GPU_CC_HUB_CLK_SRC		19
> +#define GPU_CC_HUB_CX_INT_CLK		20
> +#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC	21
> +#define GPU_CC_MND1X_0_GFX3D_CLK	22
> +#define GPU_CC_MND1X_1_GFX3D_CLK	23
> +#define GPU_CC_PLL0			24
> +#define GPU_CC_PLL1			25
> +#define GPU_CC_SLEEP_CLK		26
> +
> +/* GPU_CC resets */
> +#define GPUCC_GPU_CC_ACD_BCR		0
> +#define GPUCC_GPU_CC_CB_BCR		1
> +#define GPUCC_GPU_CC_CX_BCR		2
> +#define GPUCC_GPU_CC_FAST_HUB_BCR	3
> +#define GPUCC_GPU_CC_GFX3D_AON_BCR	4
> +#define GPUCC_GPU_CC_GMU_BCR		5
> +#define GPUCC_GPU_CC_GX_BCR		6
> +#define GPUCC_GPU_CC_XO_BCR		7
> +
> +/* GPU_CC GDSCRs */
> +#define GPU_CX_GDSC			0
> +#define GPU_GX_GDSC			1
> +
> +#endif


-- 
With best wishes
Dmitry
