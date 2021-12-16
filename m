Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A704780B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhLPXeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhLPXeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:34:09 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1426C061746
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:34:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id r26so1155750oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVN9Cdst75YteBeeIFGNl0na8PJu1PxWjHvdKRsuLNo=;
        b=HjENK0B9HW76vw8xIIFcJA0IC3D9n2s3W+qR5y0bHYRZNJwAQgqyMg67KQ5oX7Cjpk
         1tBi7NGzC/4YJI3ThIywLGGClCUcnzfkZSq+I0Rs9bz5/xCcm6jl5jr2lPIgSCLbaH2u
         vEl+/iaypGo/qxv816XdLF0aZrgkDlf1X/ADKXOTzwPBCF3n81iMJk0ICHzh1CHFIFir
         W34nfJiJYW+G2E8AA3TI7ZIJNttLnhX7gI2xABw9PaJbkjv/GkYmXEVE77DyRlnyw6dA
         iY2iwcSoDGPe6FyQBPMym3RozkZZbmucrUF21orOEGPqNfx1EdygBBdHg0iFDR+y+yvY
         VAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVN9Cdst75YteBeeIFGNl0na8PJu1PxWjHvdKRsuLNo=;
        b=J6n9FmQcqvlLeer+pGDLes300UaCgzFTyB8fzw1Nz8ZJwuS+gGokHa1tfB1XJrA/Wy
         n0yOeEkgbhjW2nkPXUwbJ0ejXOhqoi2IgufK9Z2PhP7rXcCFIVh8zWFZgtdltbX1sOB+
         hGgay0Hgvx2R0HXU41l1TR2/rtGv8Z2J+GV9jopb8vYUElr8HvUFNk0oV2NRyS5otUnh
         nnIp05JyuR0vaAXxyL5+wqPO+UeGBknc3RugVe1Ny/oTo6GAle92haxUBrwc8TnZKKOH
         aX4uEv0plk4Yp4MhAJrMO/CZ/c3Trum5NiSlKizAywxXZxiNGtEgA7HK5BNiGC2wVTQf
         FtDw==
X-Gm-Message-State: AOAM532DunKChOdomwxjKVaKyn7Usq3h7/mfDiWe1JxRXVIUHF13eaXA
        gWd2sGCYxX/PnRokabD3XL5Rqg==
X-Google-Smtp-Source: ABdhPJzVmPPYwv1YIcyUN6xIib5xQXy6q7OQQrigQ9KAdWSJxAYxjsL16fUSS1c0ugQMQ/lxpItSOQ==
X-Received: by 2002:a05:6808:1597:: with SMTP id t23mr173283oiw.24.1639697648165;
        Thu, 16 Dec 2021 15:34:08 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bi20sm1431910oib.29.2021.12.16.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:34:07 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:35:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add SDX65 pinctrl
 bindings
Message-ID: <YbvNO8uS/x5qFqx8@ripper>
References: <cover.1639696427.git.quic_vamslank@quicinc.com>
 <ff9abf953c274a1e34f59114642f67ecf02acb6f.1639696427.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9abf953c274a1e34f59114642f67ecf02acb6f.1639696427.git.quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Dec 15:18 PST 2021, quic_vamslank@quicinc.com wrote:

> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add device tree binding Documentation details for Qualcomm SDX65
> pinctrl driver.
> 
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 191 ++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
> new file mode 100644
> index 000000000000..cdfcf29dffee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
> @@ -0,0 +1,191 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sdx65-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SDX65 TLMM block
> +
> +maintainers:
> +  - Vamsi krishna Lanka <quic_vamslank@quicinc.com>
> +
> +description:
> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  SDX65 platform.
> +
> +properties:
> +  compatible:
> +    const: qcom,sdx65-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    description: Specifies the PIN numbers and Flags, as defined in
> +      include/dt-bindings/interrupt-controller/irq.h
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description: Specifying the pin number and flags, as defined in
> +      include/dt-bindings/gpio/gpio.h
> +    const: 2
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +  gpio-reserved-ranges:
> +    maxItems: 1
> +
> +#PIN CONFIGURATION NODES
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sdx65-tlmm-state"
> +      - patternProperties:
> +          ".*":
> +            $ref: "#/$defs/qcom-sdx65-tlmm-state"
> +'$defs':
> +  qcom-sdx65-tlmm-state:

Thanks.

This looks good now.

Regards,
Bjorn

> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-7])$"
> +            - enum: [ ufs_reset, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data, sdc1_rclk ]
> +        minItems: 1
> +        maxItems: 150
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins. Functions are only valid for gpio pins.
> +        enum: [ blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
> +                bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
> +                qdss_cti_trig_out_b, bimc_dte0, dac_calib1, qdss_cti_trig_in_b,
> +                dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
> +                blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0, atest_usb12,
> +                mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
> +                atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio, atest_char,
> +                cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8, qdss_tracedata_b,
> +                pll_reset, qdss_stm6, qdss_stm5, qdss_stm4, atest_usb2, cci_i2c,
> +                qdss_stm3, dac_calib3, atest_usb23, atest_char3, dac_calib4,
> +                qdss_stm2, atest_usb22, atest_char2, qdss_stm1, dac_calib5,
> +                atest_usb21, atest_char1, dbg_out, qdss_stm0, dac_calib6,
> +                atest_usb20, atest_char0, dac_calib10, qdss_stm10,
> +                qdss_cti_trig_in_a, cci_timer4, blsp_spi6, blsp_uart6, blsp_uim6,
> +                blsp2_spi, qdss_stm9, qdss_cti_trig_out_a, dac_calib11,
> +                qdss_stm8, cci_timer0, qdss_stm13, dac_calib7, cci_timer1,
> +                qdss_stm12, dac_calib8, cci_timer2, blsp1_spi, qdss_stm11,
> +                dac_calib9, cci_timer3, cci_async, dac_calib12, blsp_i2c6,
> +                qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib14,
> +                dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
> +                dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
> +                dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
> +                dac_calib22, dac_calib23, dac_calib24, tsif1_sync, dac_calib25,
> +                sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
> +                qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, blsp_i2c3,
> +                uim3, blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
> +                blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
> +                qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11, blsp_uart11,
> +                blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a, blsp_i2c11, cri_trng0,
> +                cri_trng1, cri_trng, qdss_stm18, pri_mi2s, qdss_stm17, blsp_spi4,
> +                blsp_uart4, blsp_uim4, qdss_stm16, qdss_stm15, blsp_i2c4,
> +                qdss_stm14, dac_calib26, spkr_i2s, audio_ref, lpass_slimbus,
> +                isense_dbg, tsense_pwm1, tsense_pwm2, btfm_slimbus, ter_mi2s,
> +                qdss_stm22, qdss_stm21, qdss_stm20, qdss_stm19, gcc_gp1_clk_b,
> +                sec_mi2s, blsp_spi5, blsp_uart5, blsp_uim5, gcc_gp2_clk_b,
> +                gcc_gp3_clk_b, blsp_i2c5, blsp_spi12, blsp_uart12, blsp_uim12,
> +                qdss_stm25, qdss_stm31, blsp_i2c12, qdss_stm30, qdss_stm29,
> +                tsif1_clk, qdss_stm28, tsif1_en, tsif1_data, sdc4_cmd, qdss_stm27,
> +                qdss_traceclk_b, tsif2_error, sdc43, vfr_1, qdss_stm26, tsif2_clk,
> +                sdc4_clk, qdss_stm24, tsif2_en, sdc42, qdss_stm23, qdss_tracectl_b,
> +                sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
> +                ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b, blsp11_uart_rx_b,
> +                blsp11_i2c_sda_b, prng_rosc, blsp11_i2c_scl_b, uim2, uim1, uim_batt,
> +                pci_e2, pa_indicator, adsp_ext, ddr_bist, qdss_tracedata_11,
> +                qdss_tracedata_12, modem_tsync, nav_dr, nav_pps, pci_e1, gsm_tx,
> +                qspi_cs, ssbi2, ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2, qspi3,
> +                gpio ]
> +
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.
> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      bias-disable: true
> +
> +      output-high: true
> +
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    tlmm: pinctrl@f100000 {
> +        compatible = "qcom,sdx65-tlmm";
> +        reg = <0x03000000 0xdc2000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 109>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        gpio-wo-subnode-state {
> +            pins = "gpio1";
> +            function = "gpio";
> +        };
> +
> +        uart-w-subnodes-state {
> +            rx {
> +                pins = "gpio4";
> +                function = "blsp_uart1";
> +                bias-pull-up;
> +            };
> +
> +            tx {
> +                pins = "gpio5";
> +                function = "blsp_uart1";
> +                bias-disable;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.33.1
> 
