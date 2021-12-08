Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85546D820
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhLHQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbhLHQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:32:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B4C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:28:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so3242905otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uojmEd83LkJuzCYT6podOVDiCxgCvMKz9HRzNZD9MY=;
        b=AxhCixMlmNZ/PTZOHbbF1wFDPddUi6YRqetROQzhA1iabJnNk1vIbl0cW1+PFlYtHg
         VEIvFrYuVZTbSZXE0ECPRMPgMVVzPJgeUQZ81su5/4DJWxbGRW72oJQwM0BTb79f/qlP
         iUByQXI0brVZLSUcmhku6RnYtGKJJtbHnt6qfN1XuLaQ5oVYaB0hJpZDfsX1h20p0ZUV
         x9yZHRSPWwXIA1sxc9LNBg2xT6o+glgO2agkDrY6IIVdnle476kqREw4cA0ARHVWk22I
         i+23PtpdBDozZmiuc1FyGTy9LPkLVvo3ecQW59Wr9Hn2Eg30OrUz5GCit99Y+t2sv1XF
         t+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uojmEd83LkJuzCYT6podOVDiCxgCvMKz9HRzNZD9MY=;
        b=Qt3N+gROnI1jdaIqTUepsOg6CQDSyyz7hYLxkud9zFD+JgGolSuk9uEfD3KOdDJrUD
         1MrBC58d5g8iWIKIM5e/e9MQz5W0B7E/dG5X8lmT4T6qipjFzGxJvId14mmX0epZxxNl
         6HAD8g2Y1ydtl6pD/C8dobQ9Fks4JYyj5swhgH+FW7yaeUfVq2EQl5xodsSPsQKJ+O6D
         X1s0ygjMH/hLo8xLDgdEGq2mjiI8/Zw28g0dqK/PH220tQT/JxzhRP8Ru/YnqtOL0YM9
         gP6D5Ldzyc6rfYkL6fmW2EF7Jl07D5PI6gBCS/LFxkMIqzGq11SOLJgFmmuhaJZeo0jC
         y0gg==
X-Gm-Message-State: AOAM531yzEZFm5hBQ2LezzVEK7zkk5y3wLQ2RJxIIB3PbnEMILvgyjCS
        lKNOaxkKXz1rE3g34vCleU8WCsRsBjBIyA==
X-Google-Smtp-Source: ABdhPJzxeuG+wEfmBti/OH0rRqnpL9CyfVvwdbxvKCiXcuU4YQtjtCJxFoyuWwVl6g9gwc/PSVd6NQ==
X-Received: by 2002:a05:6830:2712:: with SMTP id j18mr490847otu.302.1638980930305;
        Wed, 08 Dec 2021 08:28:50 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bh12sm745103oib.25.2021.12.08.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:28:49 -0800 (PST)
Date:   Wed, 8 Dec 2021 08:30:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SM8450 pinctrl
 bindings
Message-ID: <YbDdmHnHTU45OOXI@ripper>
References: <20211201072434.3968768-1-vkoul@kernel.org>
 <20211201072434.3968768-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072434.3968768-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Nov 23:24 PST 2021, Vinod Koul wrote:

> Add device tree binding Documentation details for Qualcomm SM8450
> TLMM device
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
> new file mode 100644
> index 000000000000..9c891246245b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SM8450 TLMM block
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer (TLMM) block found
> +  in the SM8450 platform.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8450-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  gpio-reserved-ranges: true
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm8450-tlmm-state"
> +      - patternProperties:
> +          ".*":
> +            $ref: "#/$defs/qcom-sm8450-tlmm-state"
> +
> +$defs:
> +  qcom-sm8450-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
> +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ aon_cam, atest_char, atest_usb, audio_ref, cam_mclk, cci_async,
> +                cci_i2c, cci_timer, cmu_rng, coex_uart1, coex_uart2, cri_trng,
> +                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
> +                ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1, gcc_gp2, gcc_gp3,
> +                gpio, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1,
> +                mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck,
> +                mi2s0_ws, mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws,
> +                mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
> +                mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6,
> +                mss_grfc7, mss_grfc8, mss_grfc9, nav, pcie0_clkreqn,
> +                pcie1_clkreqn, phase_flag, pll_bist, pll_clk, pri_mi2s,
> +                prng_rosc, qdss_cti, qdss_gpio, qlink0_enable, qlink0_request,
> +                qlink0_wmss, qlink1_enable, qlink1_request, qlink1_wmss,
> +                qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
> +                qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11,
> +                qup12, qup13, qup14, qup15, qup16, qup17, qup18, qup19, qup2,
> +                qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup_l4,
> +                qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk,
> +                sdc4_cmd, sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2,
> +                tgu_ch3, tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3,
> +                tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
> +                uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset,
> +                usb2phy_ac, usb_phy, vfr_0, vfr_1, vsense_trigger ]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        pinctrl@f100000 {
> +                compatible = "qcom,sm8450-tlmm";
> +                reg = <0x0f100000 0x300000>;
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-ranges = <&tlmm 0 0 211>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                gpio-wo-subnode-state {
> +                        pins = "gpio1";
> +                        function = "gpio";
> +                };
> +
> +                uart-w-subnodes-state {
> +                    rx {
> +                            pins = "gpio26";
> +                            function = "qup7";
> +                            bias-pull-up;
> +                    };
> +
> +                    tx {
> +                            pins = "gpio27";
> +                            function = "qup7";
> +                            bias-disable;
> +                    };
> +               };
> +        };
> +...
> -- 
> 2.31.1
> 
