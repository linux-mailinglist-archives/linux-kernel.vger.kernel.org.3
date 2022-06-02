Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27A53BB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbiFBOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiFBOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:52:31 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672C20C24E;
        Thu,  2 Jun 2022 07:52:30 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id l9-20020a056830268900b006054381dd35so3569770otu.4;
        Thu, 02 Jun 2022 07:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xvvfawWm5X1twO4EnB/xWzAQ4yEKRuDN2cLLmmv1+fU=;
        b=Ew2M+BUEnDaq3CdachfsNQoB3rUEQbtS2FIVYGZ0un8Y/WN6YcN9I6Q3MsKqnp7Zj9
         uXVAMZfeb74j6u79uaCGfkXtwvVEz5Puu2SPP+843SFkpqlz9/ykWT4M9MqmobJwSrCB
         PUHy3So1ejN+ljf+ZFNOYccxpnX1wYkTvaBp1oLx+AmGUImvhJfLUT7X1BrlSrHsosoy
         GUCtL/RnwKmhDBOS7G5T1QDhxJAF2WeJBkPQH1XpC7mfRoyNT0bD42hlqLyxrKdipd6G
         izbcYo2RdVA03+/n12Xfs4Kp2cY2tF7WsSTyrQbdeW53M7AUc2wa+K/l0cyQS/7NIZdC
         OX4g==
X-Gm-Message-State: AOAM531A7gET2TKDBqD/1lPyd14/lsffxOFjXCpa8UN+///SmqV3N0jX
        qIxcLIvzdNQx1P34GOJkHA==
X-Google-Smtp-Source: ABdhPJzHheYS5doODCbTZIpyfvT9xN3ZXsg6csctxCmLI8AtyteXUO3GqJ+daAiy8HGrs+5YliHazA==
X-Received: by 2002:a9d:694d:0:b0:60b:1efd:bd60 with SMTP id p13-20020a9d694d000000b0060b1efdbd60mr2271309oto.380.1654181549716;
        Thu, 02 Jun 2022 07:52:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a54460e000000b003289f51c2d7sm2345890oip.34.2022.06.02.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:52:29 -0700 (PDT)
Received: (nullmailer pid 2301579 invoked by uid 1000);
        Thu, 02 Jun 2022 14:52:28 -0000
Date:   Thu, 2 Jun 2022 09:52:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Subject: Re: [PATCH v4 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Message-ID: <20220602145228.GA2299532-robh@kernel.org>
References: <20220601124250.60968-1-robert.foss@linaro.org>
 <20220601124250.60968-4-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601124250.60968-4-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:42:47PM +0200, Robert Foss wrote:
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> ---
> 
> Changes since v3
>  - Separate from qcom,gpucc
>  - Remove clock-names
>  - Make example sm8350 based
>  - Changed author to me due to size of changes
> 
> 
>  .../bindings/clock/qcom,gpucc-sm8350.yaml     | 72 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 ++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
> new file mode 100644
> index 000000000000..0a0546c079a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gpucc-sm8350.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Graphics Clock & Reset Controller Binding
> +
> +maintainers:
> +  - Robert Foss <robert.foss@linaro.org>
> +
> +description: |
> +  Qualcomm graphics clock control module which supports the clocks, resets and
> +  power domains on Qualcomm SoCs.
> +
> +  See also:
> +    dt-bindings/clock/qcom,gpucc-sm8350.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8350-gpucc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: GPLL0 main branch source
> +      - description: GPLL0 div branch source
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@3d90000 {
> +            compatible = "qcom,sm8350-gpucc";
> +            reg = <0 0x03d90000 0 0x9000>;
> +            clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> +                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +            #power-domain-cells = <1>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> new file mode 100644
> index 000000000000..d2294e0d527e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

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
> -- 
> 2.34.1
> 
> 
