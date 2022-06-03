Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907553C704
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiFCIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbiFCIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:40:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DB36E0C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:39:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so6374693plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCVrRc4NVvmeRfDYNLQpFovvIlkEHz3avyGKdl7f8cs=;
        b=dhDBnMsglw2I4/hKmtWmP3lc9f2wDdTGnFAsg0hC/AKHxqx8EMr0i7zVm9VCgLZoOj
         nZypmTQ+2CrkEDXNTqhDoKJaD9Lbaynr/HDS7RkvH8MYY3YZFSXfUEmY/z4CivzE87Gm
         R5vGkyRV5HFdyGPLUHb6LLxdflRuEfD+SG2B8254kd9G4bsdKOy65XNy7uIO+s1yglv8
         VG8NjTTnLKbBBUz55RKXsUs6v9odihI5GLd4NBw4zvS15L/aeYjl946mvipJhQQ9ppW1
         mVfeClisH1iRvKpEbOSI4q8BM1uIDKMaABAr5yrIdYKBWBaDTbx0YzYGNPjB9PQ/IhJ3
         lWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCVrRc4NVvmeRfDYNLQpFovvIlkEHz3avyGKdl7f8cs=;
        b=fFf15Kzhzscq4jB1llB1NL+YfBGPZqAc4Z8h5ljOKJ3J2dV8Y8nnsgfjGvUFqcoyNh
         t2529kDWOy6LCH1UYlkjqBKO96GwIlbwIetRtEZZzGOuucIi8MCgtNBuC+CiMW3TkNrA
         pVjULKkgd79UVlRE4J97oCN7SsL/Yvu/Nn4wIjUha7L/E0Hlj4Wbb+DtTKKlmu+qLlk1
         euct2gEqF31VKH+GKinRzlfvufWwevcU/kvKPGHp05lO96HQU6hStvx4OtoOlXIAd1zx
         But0pValiSBqHwaxX+FWCzV5AiOWxASYWJrwa4JOzNe6nz43kAw84HQ5wH1qudedIiVU
         3tQA==
X-Gm-Message-State: AOAM530hkRiSRbzR/CvPWl4O18UPKFCUGf96oDJBqT0vgmRZigcEY8/P
        w7ea2TiLx5lHd1sZNGipCrlL8AJqehZvVgg8Z0duuA==
X-Google-Smtp-Source: ABdhPJzo3b5hw6ZjNuMIq2BMHZLSqnWz2D88juzIl0iTFHcs73EzpgDZNfhLrvuJscVMDhvAXKjnmXZkUaozvtIglWU=
X-Received: by 2002:a17:903:1c6:b0:161:9fbc:5a6 with SMTP id
 e6-20020a17090301c600b001619fbc05a6mr9218199plh.65.1654245598449; Fri, 03 Jun
 2022 01:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220601124250.60968-1-robert.foss@linaro.org>
 <20220601124250.60968-4-robert.foss@linaro.org> <20220602145228.GA2299532-robh@kernel.org>
In-Reply-To: <20220602145228.GA2299532-robh@kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 3 Jun 2022 10:39:47 +0200
Message-ID: <CAG3jFyutTWpV06FU4iZrp=TJ3SSr3nAm8AWkEzSbEXjof7Lfvw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Thu, 2 Jun 2022 at 16:52, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:42:47PM +0200, Robert Foss wrote:
> > Add device tree bindings for graphics clock controller for
> > Qualcomm Technology Inc's SM8350 SoCs.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> > ---
> >
> > Changes since v3
> >  - Separate from qcom,gpucc
> >  - Remove clock-names
> >  - Make example sm8350 based
> >  - Changed author to me due to size of changes
> >
> >
> >  .../bindings/clock/qcom,gpucc-sm8350.yaml     | 72 +++++++++++++++++++
> >  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 ++++++++++++++
> >  2 files changed, 124 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
> > new file mode 100644
> > index 000000000000..0a0546c079a9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gpucc-sm8350.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Graphics Clock & Reset Controller Binding
> > +
> > +maintainers:
> > +  - Robert Foss <robert.foss@linaro.org>
> > +
> > +description: |
> > +  Qualcomm graphics clock control module which supports the clocks, resets and
> > +  power domains on Qualcomm SoCs.
> > +
> > +  See also:
> > +    dt-bindings/clock/qcom,gpucc-sm8350.h
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sm8350-gpucc
> > +
> > +  clocks:
> > +    items:
> > +      - description: Board XO source
> > +      - description: GPLL0 main branch source
> > +      - description: GPLL0 div branch source
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - '#clock-cells'
> > +  - '#reset-cells'
> > +  - '#power-domain-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
> > +    #include <dt-bindings/clock/qcom,rpmh.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        clock-controller@3d90000 {
> > +            compatible = "qcom,sm8350-gpucc";
> > +            reg = <0 0x03d90000 0 0x9000>;
> > +            clocks = <&rpmhcc RPMH_CXO_CLK>,
> > +                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> > +                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> > +            #clock-cells = <1>;
> > +            #reset-cells = <1>;
> > +            #power-domain-cells = <1>;
> > +        };
> > +    };
> > +...
> > diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> > new file mode 100644
> > index 000000000000..d2294e0d527e
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>
> Dual license.

Ack.

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
