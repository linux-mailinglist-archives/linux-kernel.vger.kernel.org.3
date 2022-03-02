Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF04CA550
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbiCBMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiCBMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:55:06 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BE2A66D2;
        Wed,  2 Mar 2022 04:54:21 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 773963F817;
        Wed,  2 Mar 2022 13:54:18 +0100 (CET)
Date:   Wed, 2 Mar 2022 13:54:17 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
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
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Message-ID: <20220302125417.iu52rvdxrmo25wwt@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220226200911.230030-1-marijn.suijten@somainline.org>
 <20220226200911.230030-3-marijn.suijten@somainline.org>
 <ea5d34c6-fe75-c096-d5b2-6a327c9d0ae5@canonical.com>
 <62ebb074-b8de-0dc3-2bbc-e43dca9d2ced@linaro.org>
 <05310308-b0ff-56a0-83ac-855b1b795936@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05310308-b0ff-56a0-83ac-855b1b795936@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28 10:23:19, Krzysztof Kozlowski wrote:
> On 27/02/2022 22:43, Dmitry Baryshkov wrote:
> > On 27/02/2022 13:03, Krzysztof Kozlowski wrote:
> >> On 26/02/2022 21:09, Marijn Suijten wrote:
> >>> From: Martin Botka <martin.botka@somainline.org>
> >>>
> >>> Add device tree bindings for display clock controller for
> >>> Qualcomm Technology Inc's SM6125 SoC.
> >>>
> >>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>> ---
> >>>   .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
> >>>   .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
> >>>   2 files changed, 128 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>> new file mode 100644
> >>> index 000000000000..3465042d0d9f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>> @@ -0,0 +1,87 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Qualcomm Display Clock Controller Binding for SM6125
> >>> +
> >>> +maintainers:
> >>> +  - Martin Botka <martin.botka@somainline.org>
> >>> +
> >>> +description: |
> >>> +  Qualcomm display clock control module which supports the clocks and
> >>> +  power domains on SM6125.
> >>> +
> >>> +  See also:
> >>> +    dt-bindings/clock/qcom,dispcc-sm6125.h
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - qcom,sm6125-dispcc
> >>> +
> >>> +  clocks:
> >>> +    items:
> >>> +      - description: Board XO source
> >>> +      - description: Byte clock from DSI PHY0
> >>> +      - description: Pixel clock from DSI PHY0
> >>> +      - description: Pixel clock from DSI PHY1
> >>> +      - description: Link clock from DP PHY
> >>> +      - description: VCO DIV clock from DP PHY
> >>> +      - description: AHB config clock from GCC
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: bi_tcxo
> >>> +      - const: dsi0_phy_pll_out_byteclk
> >>> +      - const: dsi0_phy_pll_out_dsiclk
> >>> +      - const: dsi1_phy_pll_out_dsiclk
> >>> +      - const: dp_phy_pll_link_clk
> >>> +      - const: dp_phy_pll_vco_div_clk
> >>> +      - const: cfg_ahb_clk
> >>> +
> >>> +  '#clock-cells':
> >>> +    const: 1
> >>> +
> >>> +  '#power-domain-cells':
> >>> +    const: 1
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - clocks
> >>> +  - clock-names
> >>> +  - '#clock-cells'
> >>> +  - '#power-domain-cells'
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> >>> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> >>> +    clock-controller@5f00000 {
> >>> +      compatible = "qcom,sm6125-dispcc";
> >>> +      reg = <0x5f00000 0x20000>;
> >>> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>> +               <&dsi0_phy 0>,
> >>> +               <&dsi0_phy 1>,
> >>> +               <0>,
> >>
> >> This does not look like a valid phandle. This clock is required, isn't it?

I remember it being used like this before, though upon closer inspection
only qcom,gcc-msm8998.yaml uses it as example.

The clock should be optional, in that case it is perhaps desired to omit
it from clock-names instead, or pretend there's a `dsi1_phy 1`?

> > 
> > Not, it's not required for general dispcc support.
> > dispcc uses DSI and DP PHY clocks to provide respective pixel/byte/etc 
> > clocks. However if support for DP is not enabled, the dispcc can work 
> > w/o DP phy clock. Thus we typically add 0 phandles as placeholders for 

Is there any semantic difference between omitting the clock from DT (in
clocks= /and/ clock-names=) or setting it to a 0 phandle?

> > DSI/DP clock sources and populate them as support for respective 
> > interfaces gets implemented.
> > 
> 
> Then the clock is optional, isn't it? While not modeling it as optional?

It looks like this should be modelled using minItems: then, and
"optional" text/comment? Other clocks are optional as well, we don't
have DSI 1 in downstream SM6125 DT sources and haven't added the DP PLL
in our to-be-upstreamed mainline tree yet.

- Marijn
