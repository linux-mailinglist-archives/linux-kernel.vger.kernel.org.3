Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56E52C321
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbiERTOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbiERTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:14:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48620218FD8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:14:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i17so2670154pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK+m+Erb6YskG54m9a0bE+9PKUoSbB3wH6ButzQ9n3Q=;
        b=G6JAvGTF4t35/9+wVonfb58EYzknmk/NVfYwjLaPGl23ONjHlJaLCqjVGRuAQkc/0s
         9U1O3sBns3FNWh0jLoFRRObRkkS3I+MJizPhqtbNTQ1oTUSGXn96cHuw/qxzIYE6+WUm
         8leVxiUwEFbFK6Ky9EHJmzA9792MfXYHYC8BYzB10DnIYzedRXQub2NG9AN3/xlCw91q
         38sg9QwmjAIrhOs0tV83qp7hy8rxB4XWZdYQ6TlSSVwLuD3pNMR2rOjOJa/ZPnq557jd
         Pbu9lDxH8xByPrfG1abG9Y45vA1Djl+3V1WP+rzOqaJggKfbSewzgujMO5XEuNjmm+Po
         N2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK+m+Erb6YskG54m9a0bE+9PKUoSbB3wH6ButzQ9n3Q=;
        b=YcJxriKR7C271JZAGMeKqzO2tC0B+FBve8t/9H9W/7nbI/zB23z9J27erlXnzziLAx
         /E1Xw4q0Nfbjx+KsryOI5ZcQqV+7kFl4oCcdYxUM+GsrgcDaHc18cQeGGnh9qv2we55d
         jvCbbulUx8MpwcbH4fryO4xpuoHbE9nvgbWk/ZkcNv6t91fJVfQaqZaiKZrHfRotg9rU
         ARga/eOH8ftl9zWazS6S0Er9+4J2hN+wj7AGgxUtgvuaePj2DLV3pe58jtl7bXfITXJI
         c9pdEZD5kyyAtXyfr+NIPrGBiH2IUnFfH0Tmf+UQATRltZjik7EwbA7aP5+GxTMwf04U
         4e+w==
X-Gm-Message-State: AOAM530baJG/9JQOeoREWE9pH2MqX+a065MY9VWwbuWc6Yt+pLWqH60b
        tfUFNP8F+qrJP/Ev7dWGtV8OX2h1a4dy7Dlbc5589Q==
X-Google-Smtp-Source: ABdhPJzizzRytewvRzJhZwf64TDazyWn8WzPmuJAiEMTvXLBnDcBb1l3srZGk4ut908jU2tcbcWiOh0iOEl82lineq0=
X-Received: by 2002:a17:90b:1e4e:b0:1dc:583c:398 with SMTP id
 pi14-20020a17090b1e4e00b001dc583c0398mr943991pjb.232.1652901279708; Wed, 18
 May 2022 12:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220504122725.179262-1-robert.foss@linaro.org>
 <20220504122725.179262-4-robert.foss@linaro.org> <20220516235057.GA3564535-robh@kernel.org>
In-Reply-To: <20220516235057.GA3564535-robh@kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 18 May 2022 21:14:27 +0200
Message-ID: <CAG3jFyufJtYP_t8mmYWFgOHarbfOcu9VpbFFDO0DPdrB=XXHXw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
        jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 at 01:50, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 02:27:22PM +0200, Robert Foss wrote:
> > Add device tree bindings for graphics clock controller for
> > Qualcomm Technology Inc's SM8350 SoCs.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
> >  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 +++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > index 9ebcb1943b0a..4090cc7ea2ae 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > @@ -20,6 +20,7 @@ description: |
> >      dt-bindings/clock/qcom,gpucc-sm6350.h
> >      dt-bindings/clock/qcom,gpucc-sm8150.h
> >      dt-bindings/clock/qcom,gpucc-sm8250.h
> > +    dt-bindings/clock/qcom,gpucc-sm8350.h
> >
> >  properties:
> >    compatible:
> > @@ -31,6 +32,7 @@ properties:
> >        - qcom,sm6350-gpucc
> >        - qcom,sm8150-gpucc
> >        - qcom,sm8250-gpucc
> > +      - qcom,sm8350-gpucc
> >
> >    clocks:
> >      items:
> > diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> > new file mode 100644
> > index 000000000000..d2294e0d527e
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>
> QCom reviewed and approved the license on this, right?
>
> Dual license.

Ah, yes. I'll change the license in v4 to:

/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

>
> > +/*
> > + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> > +#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> > +
> > +/* GPU_CC clocks */
> > +#define GPU_CC_AHB_CLK                       0
> > +#define GPU_CC_CB_CLK                        1
> > +#define GPU_CC_CRC_AHB_CLK           2
> > +#define GPU_CC_CX_APB_CLK            3
> > +#define GPU_CC_CX_GMU_CLK            4
> > +#define GPU_CC_CX_QDSS_AT_CLK                5
> > +#define GPU_CC_CX_QDSS_TRIG_CLK              6
> > +#define GPU_CC_CX_QDSS_TSCTR_CLK     7
> > +#define GPU_CC_CX_SNOC_DVM_CLK               8
> > +#define GPU_CC_CXO_AON_CLK           9
> > +#define GPU_CC_CXO_CLK                       10
> > +#define GPU_CC_FREQ_MEASURE_CLK              11
> > +#define GPU_CC_GMU_CLK_SRC           12
> > +#define GPU_CC_GX_GMU_CLK            13
> > +#define GPU_CC_GX_QDSS_TSCTR_CLK     14
> > +#define GPU_CC_GX_VSENSE_CLK         15
> > +#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK       16
> > +#define GPU_CC_HUB_AHB_DIV_CLK_SRC   17
> > +#define GPU_CC_HUB_AON_CLK           18
> > +#define GPU_CC_HUB_CLK_SRC           19
> > +#define GPU_CC_HUB_CX_INT_CLK                20
> > +#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC        21
> > +#define GPU_CC_MND1X_0_GFX3D_CLK     22
> > +#define GPU_CC_MND1X_1_GFX3D_CLK     23
> > +#define GPU_CC_PLL0                  24
> > +#define GPU_CC_PLL1                  25
> > +#define GPU_CC_SLEEP_CLK             26
> > +
> > +/* GPU_CC resets */
> > +#define GPUCC_GPU_CC_ACD_BCR         0
> > +#define GPUCC_GPU_CC_CB_BCR          1
> > +#define GPUCC_GPU_CC_CX_BCR          2
> > +#define GPUCC_GPU_CC_FAST_HUB_BCR    3
> > +#define GPUCC_GPU_CC_GFX3D_AON_BCR   4
> > +#define GPUCC_GPU_CC_GMU_BCR         5
> > +#define GPUCC_GPU_CC_GX_BCR          6
> > +#define GPUCC_GPU_CC_XO_BCR          7
> > +
> > +/* GPU_CC GDSCRs */
> > +#define GPU_CX_GDSC                  0
> > +#define GPU_GX_GDSC                  1
> > +
> > +#endif
> > --
> > 2.34.1
> >
> >
