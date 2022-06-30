Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0385624DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiF3VIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiF3VIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:08:52 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7B1E3F0;
        Thu, 30 Jun 2022 14:08:51 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id d3so394885ioi.9;
        Thu, 30 Jun 2022 14:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OlkG5d3SBHOeWSJIz3gFTBLiUAyuGYv/0tzGunrQ1ho=;
        b=IQNewkJFRU3NJxQ4MMkLAdrcNCunzW/DivwfE95lnOlkn89BSQuJ4sUGfVb86OhaHd
         FMJLkVojd/ZJ8xK1046eitZY/lbCiGEKLAlro9murmeVCW6CqfSDhQqzaPoSNIZYNueC
         paJaSaYqrkAgJgjRXI5e5AISJSJdkoNm7yMpjsJ5CWQCeuGSodXOb/XpJ6H3GqEBnz8q
         xf21TQ855iA0OXmP32MBhW+2VzCMLJBdcKhGOrQRiWclJvVw3/wgZ5EvZQvh6GlXUwKu
         rrH5URqGes5gnM+8hgkwxxyM52higR0KQGayplQZlSjyX3835cWHqm7LfZLB40+MDkpb
         U/Rg==
X-Gm-Message-State: AJIora/QDLEaIbQOuheFlUUrkDG1/rPVv4Oi+TNJBuVhWukDZAbVEgBq
        8AAuUcNOStG3a93+7d+zjw==
X-Google-Smtp-Source: AGRyM1vhC2i4RNNi7xljmoIcx+S2hlEw3OGseJQIbqK34sO+w9ryaKyF/3rtri9PGpQCo1akU3lV8A==
X-Received: by 2002:a02:a809:0:b0:339:e6ba:dee1 with SMTP id f9-20020a02a809000000b00339e6badee1mr6511943jaj.1.1656623330778;
        Thu, 30 Jun 2022 14:08:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r20-20020a5d9b94000000b0066952cfe3e2sm9437564iom.39.2022.06.30.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:08:50 -0700 (PDT)
Received: (nullmailer pid 3300975 invoked by uid 1000);
        Thu, 30 Jun 2022 21:08:48 -0000
Date:   Thu, 30 Jun 2022 15:08:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi
 pinctrl bindings
Message-ID: <20220630210848.GA3295428-robh@kernel.org>
References: <20220629091716.68771-1-srinivas.kandagatla@linaro.org>
 <20220629091716.68771-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629091716.68771-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:17:15AM +0100, Srinivas Kandagatla wrote:
> Add device tree binding Documentation details for Qualcomm SM8450
> LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> new file mode 100644
> index 000000000000..b49d70b9ba9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
> +  Low Power Island (LPI) TLMM block
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  LPASS LPI IP on most Qualcomm SoCs
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8450-lpass-lpi-pinctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

What is each entry?

> +
> +  clocks:
> +    items:
> +      - description: LPASS Core voting clock
> +      - description: LPASS Audio voting clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: audio
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
> +#PIN CONFIGURATION NODES
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "/schemas/pinctrl/pincfg-node.yaml"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9])$"

Don't need oneOf with only 1.

> +        minItems: 1
> +        maxItems: 23
> +
> +      function:
> +        enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
> +                dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic4_clk,
> +                dmic4_data, i2s2_clk, i2s2_ws, dmic3_clk, dmic3_data,
> +                qua_mi2s_sclk, qua_mi2s_ws, qua_mi2s_data, i2s1_clk, i2s1_ws,
> +                i2s1_data, wsa_swr_clk, wsa_swr_data, wsa2_swr_clk,
> +                wsa2_swr_data, i2s2_data, i2s4_ws, i2s4_clk, i2s4_data,
> +                slimbus_clk, i2s3_clk, i2s3_ws, i2s3_data, slimbus_data,
> +                ext_mclk1_c, ext_mclk1_b, ext_mclk1_a, ext_mclk1_d,
> +                ext_mclk1_e ]
> +
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.
> +
> +      slew-rate:
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +        description: |
> +            0: No adjustments
> +            1: Higher Slew rate (faster edges)
> +            2: Lower Slew rate (slower edges)
> +            3: Reserved (No adjustments)

Indent should be 2 more, not 4.

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
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/sound/qcom,q6afe.h>
> +    lpi_tlmm: pinctrl@3440000 {
> +        compatible = "qcom,sm8450-lpass-lpi-pinctrl";
> +        reg = <0x3440000 0x20000>,
> +              <0x34d0000 0x10000>;
> +        clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +                 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +        clock-names = "core", "audio";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&lpi_tlmm 0 0 23>;
> +    };
> -- 
> 2.25.1
> 
> 
