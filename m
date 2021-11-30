Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E3463C99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhK3RQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbhK3RQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:16:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A248C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:13:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so45993007wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/RzzACEGmvpF3IiOGI/VeVi04SG1oxFn0L0QmRaXOU=;
        b=EDHBCnZV+Wl+S6/VL/Eiow7Rf87bWTxqhf+0uHr57WEzNWkSATf4UO0qpCY8Iy97CC
         TJYxPMSUgDCTum4RriKuoAPtPRpqXLJNSgqMCUfZKggyaPZ1JzgrRiZgHaYuJ3llBNY4
         q5UOM0TlC3qFiTozbSF6V9rwXCw5NqrjOS9nHRdyJia0aLhALTunb8Ypb3oqwskk0tBh
         sTkCvdAVzurcNp22JDLlU9sZMtP1UJT6tktTzABhMQtKcjHkQnlzIG76eX/syvc4lzAu
         ktGbMVPcPFoATkrc/UZmWpv/236DiZXivEvVt0WqkNpls10kohBMwtcTHNZMCBKm9xJO
         UGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/RzzACEGmvpF3IiOGI/VeVi04SG1oxFn0L0QmRaXOU=;
        b=FQgLfCx6K/8P5gefRglfZU3nbwaQo/jfry5B7ChSa92NQafTfrtkOGxlmXk5uMSwLf
         bCMfOUntNTzlFTziHiYd8AjlPRpTmjhqLQ9zMOVpaMOIfXyvSHwlLvLPPAXGuJKGhSET
         7II2Flj78g1lK5BAHiERTELCpVHjkVfGbW42mUNdnCg4wtwwTfFv7pasC8O/SeirIs/j
         yZKS9rGTvi8+OTBsTm5zckzOvIZq65qhtkWS3NGP3iOlACUOilmIkxKRBdcf5uz/JQ4G
         glZzZjCPm4xIduKPGY6u6+BSRgRraJywp6a0b6kL0J0eYa+BXbszt7xUAlDargdmbhXH
         tRBg==
X-Gm-Message-State: AOAM532xFfTllIFtcRsQFYzYRipyeoVJLtKPpAZW9YleJxj1/ay+RQlL
        4YUWm4PVCLfPqVSKi/T0j/4rZg==
X-Google-Smtp-Source: ABdhPJym3UsIoYgofoLQvjSzZVsW6tJDx1MN2tq9DcLrNaC0QZOit3T/fTuKusXLjpplBoXsBqFaJg==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr204682wro.169.1638292379523;
        Tue, 30 Nov 2021 09:12:59 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id n13sm17342354wrt.44.2021.11.30.09.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 09:12:59 -0800 (PST)
Subject: Re: [PATCH v3 1/5] dt-bindings: pinctrl: qcom: Update lpass lpi file
 name to SoC specific
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org>
 <1638179932-3353-2-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <14163c1c-c453-0cec-c7e9-1ff0a8a982d3@linaro.org>
Date:   Tue, 30 Nov 2021 17:12:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638179932-3353-2-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2021 09:58, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.


TBH, for adding sc7820 lpass lpi support, this rename patch is totally 
not necessary.

> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>   .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 ---------------------
>   .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++++++++++++

Consider using "git mv" when renaming files, this would give a better 
diff stat.

--srini
>   2 files changed, 130 insertions(+), 130 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> deleted file mode 100644
> index e47ebf9..0000000
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
> -  Low Power Island (LPI) TLMM block
> -
> -maintainers:
> -  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> -
> -description: |
> -  This binding describes the Top Level Mode Multiplexer block found in the
> -  LPASS LPI IP on most Qualcomm SoCs
> -
> -properties:
> -  compatible:
> -    const: qcom,sm8250-lpass-lpi-pinctrl
> -
> -  reg:
> -    minItems: 2
> -    maxItems: 2
> -
> -  clocks:
> -    items:
> -      - description: LPASS Core voting clock
> -      - description: LPASS Audio voting clock
> -
> -  clock-names:
> -    items:
> -      - const: core
> -      - const: audio
> -
> -  gpio-controller: true
> -
> -  '#gpio-cells':
> -    description: Specifying the pin number and flags, as defined in
> -      include/dt-bindings/gpio/gpio.h
> -    const: 2
> -
> -  gpio-ranges:
> -    maxItems: 1
> -
> -#PIN CONFIGURATION NODES
> -patternProperties:
> -  '-pins$':
> -    type: object
> -    description:
> -      Pinctrl node's client devices use subnodes for desired pin configuration.
> -      Client device subnodes use below standard properties.
> -    $ref: "/schemas/pinctrl/pincfg-node.yaml"
> -
> -    properties:
> -      pins:
> -        description:
> -          List of gpio pins affected by the properties specified in this
> -          subnode.
> -        items:
> -          oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9])$"
> -        minItems: 1
> -        maxItems: 14
> -
> -      function:
> -        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, qua_mi2s_ws,
> -                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, i2s1_clk,
> -                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
> -                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, dmic3_clk,
> -                dmic3_data, i2s2_data ]
> -        description:
> -          Specify the alternative function to be configured for the specified
> -          pins.
> -
> -      drive-strength:
> -        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> -        default: 2
> -        description:
> -          Selects the drive strength for the specified pins, in mA.
> -
> -      slew-rate:
> -        enum: [0, 1, 2, 3]
> -        default: 0
> -        description: |
> -            0: No adjustments
> -            1: Higher Slew rate (faster edges)
> -            2: Lower Slew rate (slower edges)
> -            3: Reserved (No adjustments)
> -
> -      bias-pull-down: true
> -
> -      bias-pull-up: true
> -
> -      bias-disable: true
> -
> -      output-high: true
> -
> -      output-low: true
> -
> -    required:
> -      - pins
> -      - function
> -
> -    additionalProperties: false
> -
> -required:
> -  - compatible
> -  - reg
> -  - clocks
> -  - clock-names
> -  - gpio-controller
> -  - '#gpio-cells'
> -  - gpio-ranges
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -    #include <dt-bindings/sound/qcom,q6afe.h>
> -    lpi_tlmm: pinctrl@33c0000 {
> -        compatible = "qcom,sm8250-lpass-lpi-pinctrl";
> -        reg = <0x33c0000 0x20000>,
> -              <0x3550000 0x10000>;
> -        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> -                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> -        clock-names = "core", "audio";
> -        gpio-controller;
> -        #gpio-cells = <2>;
> -        gpio-ranges = <&lpi_tlmm 0 0 14>;
> -    };
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> new file mode 100644
> index 0000000..e47ebf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
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
> +    const: qcom,sm8250-lpass-lpi-pinctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
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
> +        minItems: 1
> +        maxItems: 14
> +
> +      function:
> +        enum: [ gpio, swr_tx_clk, qua_mi2s_sclk, swr_tx_data, qua_mi2s_ws,
> +                qua_mi2s_data, swr_rx_clk, swr_rx_data, dmic1_clk, i2s1_clk,
> +                dmic1_data, i2s1_ws, dmic2_clk, dmic2_data, i2s1_data,
> +                i2s2_clk, wsa_swr_clk, i2s2_ws, wsa_swr_data, dmic3_clk,
> +                dmic3_data, i2s2_data ]
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
> +    lpi_tlmm: pinctrl@33c0000 {
> +        compatible = "qcom,sm8250-lpass-lpi-pinctrl";
> +        reg = <0x33c0000 0x20000>,
> +              <0x3550000 0x10000>;
> +        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +        clock-names = "core", "audio";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&lpi_tlmm 0 0 14>;
> +    };
> 
