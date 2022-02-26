Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6C4C588D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiBZWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBZWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:41:41 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CB22E8D7;
        Sat, 26 Feb 2022 14:41:05 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 19ECF3E866;
        Sat, 26 Feb 2022 23:41:03 +0100 (CET)
Date:   Sat, 26 Feb 2022 23:41:01 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Message-ID: <20220226224101.fwp4wvlpsiedtm4m@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220226200911.230030-1-marijn.suijten@somainline.org>
 <20220226200911.230030-3-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226200911.230030-3-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-26 21:09:10, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

This of course lacks the mandatory sign-off after getting permission to
apply my own review and mailing-list review, and resending the patch:

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> new file mode 100644
> index 000000000000..3465042d0d9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock Controller Binding for SM6125
> +
> +maintainers:
> +  - Martin Botka <martin.botka@somainline.org>
> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks and
> +  power domains on SM6125.
> +
> +  See also:
> +    dt-bindings/clock/qcom,dispcc-sm6125.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6125-dispcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Byte clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY1
> +      - description: Link clock from DP PHY
> +      - description: VCO DIV clock from DP PHY
> +      - description: AHB config clock from GCC
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: dsi0_phy_pll_out_byteclk
> +      - const: dsi0_phy_pll_out_dsiclk
> +      - const: dsi1_phy_pll_out_dsiclk
> +      - const: dp_phy_pll_link_clk
> +      - const: dp_phy_pll_vco_div_clk
> +      - const: cfg_ahb_clk
> +
> +  '#clock-cells':
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
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> +    clock-controller@5f00000 {
> +      compatible = "qcom,sm6125-dispcc";
> +      reg = <0x5f00000 0x20000>;
> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +               <&dsi0_phy 0>,
> +               <&dsi0_phy 1>,
> +               <0>,
> +               <&dp_phy 0>,
> +               <&dp_phy 1>,
> +               <&gcc GCC_DISP_AHB_CLK>;
> +      clock-names = "bi_tcxo",
> +                    "dsi0_phy_pll_out_byteclk",
> +                    "dsi0_phy_pll_out_dsiclk",
> +                    "dsi1_phy_pll_out_dsiclk",
> +                    "dp_phy_pll_link_clk",
> +                    "dp_phy_pll_vco_div_clk",
> +                    "cfg_ahb_clk";
> +      #clock-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6125.h b/include/dt-bindings/clock/qcom,dispcc-sm6125.h
> new file mode 100644
> index 000000000000..4ff974f4fcc3
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,dispcc-sm6125.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6125_H
> +#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6125_H
> +
> +#define DISP_CC_PLL0			0
> +#define DISP_CC_MDSS_AHB_CLK		1
> +#define DISP_CC_MDSS_AHB_CLK_SRC	2
> +#define DISP_CC_MDSS_BYTE0_CLK		3
> +#define DISP_CC_MDSS_BYTE0_CLK_SRC	4
> +#define DISP_CC_MDSS_BYTE0_INTF_CLK	5
> +#define DISP_CC_MDSS_DP_AUX_CLK		6
> +#define DISP_CC_MDSS_DP_AUX_CLK_SRC	7
> +#define DISP_CC_MDSS_DP_CRYPTO_CLK	8
> +#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC	9
> +#define DISP_CC_MDSS_DP_LINK_CLK	10
> +#define DISP_CC_MDSS_DP_LINK_CLK_SRC	11
> +#define DISP_CC_MDSS_DP_LINK_INTF_CLK	12
> +#define DISP_CC_MDSS_DP_PIXEL_CLK	13
> +#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC	14
> +#define DISP_CC_MDSS_ESC0_CLK		15
> +#define DISP_CC_MDSS_ESC0_CLK_SRC	16
> +#define DISP_CC_MDSS_MDP_CLK		17
> +#define DISP_CC_MDSS_MDP_CLK_SRC	18
> +#define DISP_CC_MDSS_MDP_LUT_CLK	19
> +#define DISP_CC_MDSS_NON_GDSC_AHB_CLK	20
> +#define DISP_CC_MDSS_PCLK0_CLK		21
> +#define DISP_CC_MDSS_PCLK0_CLK_SRC	22
> +#define DISP_CC_MDSS_ROT_CLK		23
> +#define DISP_CC_MDSS_ROT_CLK_SRC	24
> +#define DISP_CC_MDSS_VSYNC_CLK		25
> +#define DISP_CC_MDSS_VSYNC_CLK_SRC	26
> +#define DISP_CC_XO_CLK			27
> +
> +/* DISP_CC GDSCR */
> +#define MDSS_GDSC			0
> +
> +#endif
> -- 
> 2.35.1
> 
