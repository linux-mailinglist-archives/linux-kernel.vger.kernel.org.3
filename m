Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4912652958E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350482AbiEPXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiEPXvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:51:01 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA3167FB;
        Mon, 16 May 2022 16:50:59 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id z15-20020a9d65cf000000b00605f064482cso11151959oth.6;
        Mon, 16 May 2022 16:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hAZlTfSrsJjd8YPKa5lPR+jdJB2otw3VfDdAjcUM/Tk=;
        b=JSiYyPOvqXYIc+lsEaXefJ80fl3bS/BshdFe7Q0v+s0uFJ4EeSCupzNVSgnFnfJf7v
         4OJ92mEHll1rLUK1c2twPtMMmSTHQ9oLfsvQXmuFDAEurFVmlPflCr7dNClz/l6QVf0d
         W+ssskUEDNCFiVwoDwFbzZqabxaAxs6wNxCr/gMElnxFhEmk3VNnat9jWEKqArE92M2+
         L10Hp9mbNQMBZAUlXf6GLURCGEddSqqM1Aur2lrJzzfhCsQLkxWr5B9IapJIAFkco6Bq
         0dlPZ8Bj92hyScf2hnZ11D8UBK9YMmNSWWeqRce9Cfnp973Khil59aCNFJ72/D3gyE6S
         np0g==
X-Gm-Message-State: AOAM5330+hFZBbKQrxepHRtn+HkHeNaeYFl210jbeSMWrALE/W75yB1r
        YDaX4Y5VCZ48z4jmOpL2ug==
X-Google-Smtp-Source: ABdhPJzCJr7RYLgraF/mlXq4mT3z7F4FFe2icQKEADzp0aPIlGvnKD6HvdtYUeFqKhg515C24pSyYg==
X-Received: by 2002:a05:6830:2093:b0:605:6f01:1ed1 with SMTP id y19-20020a056830209300b006056f011ed1mr7220064otq.166.1652745058730;
        Mon, 16 May 2022 16:50:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w195-20020aca30cc000000b0032906c0eab0sm735758oiw.31.2022.05.16.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:50:58 -0700 (PDT)
Received: (nullmailer pid 3566937 invoked by uid 1000);
        Mon, 16 May 2022 23:50:57 -0000
Date:   Mon, 16 May 2022 18:50:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
        jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Message-ID: <20220516235057.GA3564535-robh@kernel.org>
References: <20220504122725.179262-1-robert.foss@linaro.org>
 <20220504122725.179262-4-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504122725.179262-4-robert.foss@linaro.org>
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

On Wed, May 04, 2022 at 02:27:22PM +0200, Robert Foss wrote:
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
>  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 9ebcb1943b0a..4090cc7ea2ae 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -20,6 +20,7 @@ description: |
>      dt-bindings/clock/qcom,gpucc-sm6350.h
>      dt-bindings/clock/qcom,gpucc-sm8150.h
>      dt-bindings/clock/qcom,gpucc-sm8250.h
> +    dt-bindings/clock/qcom,gpucc-sm8350.h
>  
>  properties:
>    compatible:
> @@ -31,6 +32,7 @@ properties:
>        - qcom,sm6350-gpucc
>        - qcom,sm8150-gpucc
>        - qcom,sm8250-gpucc
> +      - qcom,sm8350-gpucc
>  
>    clocks:
>      items:
> diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> new file mode 100644
> index 000000000000..d2294e0d527e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

QCom reviewed and approved the license on this, right?

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
