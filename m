Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2C46C6C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhLGViw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:38:52 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38455 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:38:51 -0500
Received: by mail-ot1-f51.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso602724ota.5;
        Tue, 07 Dec 2021 13:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPx+eTE6N+Hk3WB8seNtV8XIHyxqNCIylaG8xZ2m35A=;
        b=RQ6bKDs7QHZ1bD652dNyYsYaV08oLYo3tOSXV91YByKZ0dWCLiKUsKPpxo/qcmBneR
         h8YFISZV2Q/93TlXTISKBvMIuMOAXHoNlrLDDkShax3PVJcyxqygr9IjOEXWmh5eljit
         gAnwZjE9MFG6xB+rPsKs6I9HbfumQZJVWi7zleMdtlAVhcysOo345r0tYjHlGoJMs2na
         cs8015sYMkcUgfr5lHvlLW99TBr59Pl9Zy6QHPttdRAta3kzgs78igvVNrfCuhaGdezK
         LZI5fiVZ3kSkMhhV+n+KkFZ4FvXJnusIZHeamqGNwzjXisG8ZboQnqGL7j3w6R2L6fAZ
         O5YA==
X-Gm-Message-State: AOAM532ya0tQOi9w6EApYW2HSNc91+goFCLUbd8zpRCiHu6mlVLL30Ki
        QCRCW5rSIxSZ7NkheBlsaSOAiqdK4w==
X-Google-Smtp-Source: ABdhPJwgwmB70lqkzQaDLgW4DOjxX0TRuR5RVmn6ooyilF6HdvKdcqSmVvry3XRN6RLXpkqgXYdtSg==
X-Received: by 2002:a05:6830:12c8:: with SMTP id a8mr37257210otq.52.1638912920369;
        Tue, 07 Dec 2021 13:35:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e21sm144061ote.72.2021.12.07.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:35:19 -0800 (PST)
Received: (nullmailer pid 874575 invoked by uid 1000);
        Tue, 07 Dec 2021 21:35:18 -0000
Date:   Tue, 7 Dec 2021 15:35:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Message-ID: <Ya/Tlsr7NnoZLD7p@robh.at.kernel.org>
References: <20211130212137.25303-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130212137.25303-1-martin.botka@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:21:32PM +0100, Martin Botka wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> new file mode 100644
> index 000000000000..971a72bbb631
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
> +               <&dsi1_phy 0>,
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
> index 000000000000..d3fa45aa0e83
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,dispcc-sm6125.h
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Dual license please.

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
> 2.34.0
> 
> 
