Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABC59C897
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiHVTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbiHVTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:20:49 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D54F672;
        Mon, 22 Aug 2022 12:19:43 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 53-20020a9d0838000000b006371d896343so8349852oty.10;
        Mon, 22 Aug 2022 12:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RZ1oGebuMKpJEbiPzGnoljYw5urwJldyFB+scivuSGA=;
        b=J82D8BoNx8nY5YAT05F57vtD23DoQL5hq63k8TB6ClweDHPX8oKZdyEoqt4Ay/OHrR
         qcgC59QwDI6A4fp00S8cRXwQbCjwZDBvpaqezCn0Z7hSAaFaLbPwf/YSPLktHcZH9dkM
         WprT+m1RL5Vk665ruTBBgtmF3rYomZFW/v7BNcW1oS28pqhYMkdTL+4KV2Br/PcQSnaX
         gF2NHAPAbK6k/DW++PsAvzLcMz55R/9NCDbFfNgIhC9xxBru6Xat/zX7psiApmq99DBP
         eBpf9ASbNOxDlBvQhStgIwsXHPZVOh1CL6z7nFN4Lf35aiHYYqYgG2wRP/obN5M6r/ER
         l3XA==
X-Gm-Message-State: ACgBeo0//PG61Eq4U+qlCBxUwsNXKaLp9HE2XDzwCJCo2kHO4NEidrMx
        eCRxquZ+viAMNfbKsoXG7A==
X-Google-Smtp-Source: AA6agR7jg9n404zse1cC27270kM/5YJfT5XwC0i0bGLJFJD/IXgbOA6s+I+Nbp/hMQQGJ1ESzcH1bg==
X-Received: by 2002:a05:6830:56:b0:639:bbb:f0cf with SMTP id d22-20020a056830005600b006390bbbf0cfmr5802691otp.161.1661195983103;
        Mon, 22 Aug 2022 12:19:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w16-20020a4a3550000000b00435785e7b49sm2599297oog.19.2022.08.22.12.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:19:42 -0700 (PDT)
Received: (nullmailer pid 278879 invoked by uid 1000);
        Mon, 22 Aug 2022 19:19:41 -0000
Date:   Mon, 22 Aug 2022 14:19:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: add QCOM SM6115 display clock
 bindings
Message-ID: <20220822191941.GA262452-robh@kernel.org>
References: <20220819201231.23474-1-a39.skl@gmail.com>
 <20220819201231.23474-2-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819201231.23474-2-a39.skl@gmail.com>
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

On Fri, Aug 19, 2022 at 10:12:21PM +0200, Adam Skladowski wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6115 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/clock/qcom,sm6115-dispcc.yaml    | 88 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm6115-dispcc.h    | 36 ++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> new file mode 100644
> index 000000000000..c9b97281171c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6115-dispcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock Controller Binding for SM6115
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

As of today, bouncing...

Otherwise, looks fine.

> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks and
> +  power domains on SM6115.
> +
> +  See also:
> +    dt-bindings/clock/qcom,sm6115-dispcc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6115-dispcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Byte clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY0
> +      - description: GPLL0 clock from GCC
> +      - description: GPLL0 div clock from GCC
> +      - description: Board sleep clock
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: dsi0_phy_pll_out_byteclk
> +      - const: dsi0_phy_pll_out_dsiclk
> +      - const: gcc_disp_gpll0_clk_src
> +      - const: gcc_disp_gpll0_div_clk_src
> +      - const: sleep_clk
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
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
> +    clock-controller@5f00000 {
> +      compatible = "qcom,sm6115-dispcc";
> +      reg = <0x5f00000 0x20000>;
> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +               <&dsi0_phy 0>,
> +               <&dsi0_phy 1>,
> +               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
> +               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
> +               <&sleep_clk>;
> +      clock-names = "bi_tcxo",
> +                    "dsi0_phy_pll_out_byteclk",
> +                    "dsi0_phy_pll_out_dsiclk",
> +                    "gcc_disp_gpll0_clk_src",
> +                    "gcc_disp_gpll0_div_clk_src",
> +                    "sleep_clk";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm6115-dispcc.h b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
> new file mode 100644
> index 000000000000..d1a6c45b5029
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
> +#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
> +
> +/* DISP_CC clocks */
> +#define DISP_CC_PLL0			0
> +#define DISP_CC_PLL0_OUT_MAIN		1
> +#define DISP_CC_MDSS_AHB_CLK		2
> +#define DISP_CC_MDSS_AHB_CLK_SRC	3
> +#define DISP_CC_MDSS_BYTE0_CLK		4
> +#define DISP_CC_MDSS_BYTE0_CLK_SRC	5
> +#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC	6
> +#define DISP_CC_MDSS_BYTE0_INTF_CLK	7
> +#define DISP_CC_MDSS_ESC0_CLK		8
> +#define DISP_CC_MDSS_ESC0_CLK_SRC	9
> +#define DISP_CC_MDSS_MDP_CLK		10
> +#define DISP_CC_MDSS_MDP_CLK_SRC	11
> +#define DISP_CC_MDSS_MDP_LUT_CLK	12
> +#define DISP_CC_MDSS_NON_GDSC_AHB_CLK	13
> +#define DISP_CC_MDSS_PCLK0_CLK		14
> +#define DISP_CC_MDSS_PCLK0_CLK_SRC	15
> +#define DISP_CC_MDSS_ROT_CLK		16
> +#define DISP_CC_MDSS_ROT_CLK_SRC	17
> +#define DISP_CC_MDSS_VSYNC_CLK		18
> +#define DISP_CC_MDSS_VSYNC_CLK_SRC	19
> +#define DISP_CC_SLEEP_CLK		20
> +#define DISP_CC_SLEEP_CLK_SRC		21
> +
> +/* DISP_CC GDSCR */
> +#define MDSS_GDSC			0
> +
> +#endif
> -- 
> 2.25.1
> 
> 
