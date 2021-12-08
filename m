Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F746D001
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhLHJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:28:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B9C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:24:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so2878847wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mFT/g8kDKWO3RXXQBJgCEppq9+tS0OcXbhAndJlbwc=;
        b=WHRXXER2O3rJ4A2VcAWr/DwhUSR5L/tE4J5yUMThcd01KomQLmU3zFWdohVBwpg8Ll
         sC79Ur1YnCEod0L4D9AXUhM5EiPedIUoI5X/y7p4FqNf3W7oGxw+W8QOWUB8CHCvga1x
         Q9NAFxhBNCQuz+g8fu60utXMrEmJx7ln/ElzigSgVCTn1eGLw/fm2x/fpzxAMvSOIv4V
         YPiBbFLUwSxgLEZ4paCOLhWRq4qxoIxqxQW93TRL+yfvQW9yd8slq936wB60hw9fZvpd
         9ZOhmduuctSkUCTAmJF01x4/OUzT7ol58tRmm8Iu/3MVkTLK4/HQQzzhKY1Un7+6wobr
         Qexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mFT/g8kDKWO3RXXQBJgCEppq9+tS0OcXbhAndJlbwc=;
        b=19IR3HlK1NxDFXylghIMvTMG/L7ff+KtibNYCjh9AsU2HeRaIkTf/h5P1Tv/WLX2C4
         l4OcoS3DvIwmMRwepTSVcwa44o61A0EyTmZ/N9p9whH5DJDz4o8XuAJdyFonBFitFcVM
         aeis3cQ6eXIitJwhPuWBJQcqNmKdL84up8AilNsqS5i3gHYI8SElW6bxXvU8gUC5rAx+
         3tvedZ579JxGuL/3L5wCdZ6ezej8DWaUbZt2/lnUHoCdGPhscfNdg8p/bvhnA6pVrhZq
         Yft4YapYgE1MIbdANi/DdL7G6fBKD71l81W+nrQE6GuQrYdEMCimPEKSzS07wuumgwVy
         51sg==
X-Gm-Message-State: AOAM533m8C5sKSR3FlTD1I4Yac1a/aZzEIx67P6tNd/kDUFnnzGeZAXT
        aAJMcJuqt/40tUAJPZHRYJLzuQ==
X-Google-Smtp-Source: ABdhPJz4c9t4wMsA/G3koT+zmv/oSJewsTgYyqs8g57t6he/F8MwgK+Mv6qagBFmdxpLd0ECZWxfGg==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr58385764wrv.606.1638955482132;
        Wed, 08 Dec 2021 01:24:42 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id ay21sm5088751wmb.7.2021.12.08.01.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 01:24:41 -0800 (PST)
Subject: Re: [PATCH v5 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi
 pinctrl bindings
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7ae29aa1-34da-c362-5712-4b787474d7f2@linaro.org>
Date:   Wed, 8 Dec 2021 09:24:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2021 15:35, Srinivasa Rao Mandadapu wrote:
> Add device tree binding Documentation details for Qualcomm SC7280
> LPASS LPI pinctrl driver.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---


I remember in my previous review that I requested you to use git mv for 
renaming this

If you do that you will endup diff stat something like this:

------------------------->cut<-----------------------------
diff --git 
a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml 
b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
similarity index 97%
rename from 
Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
rename to 
Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index e47ebf934daf..76f205a47640 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
+++ 
b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -1,7 +1,7 @@
  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
  %YAML 1.2
  ---
-$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#
+$id: 
http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#
  $schema: http://devicetree.org/meta-schemas/core.yaml#

  title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
------------------------->cut<-----------------------------

--srini

>   .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 +++++++++++++++++++++
>   1 file changed, 115 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> new file mode 100644
> index 0000000..d32ee32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
> +  Low Power Island (LPI) TLMM block
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  LPASS LPI IP on most Qualcomm SoCs
> +
> +properties:
> +  compatible:
> +    const: qcom,sc7280-lpass-lpi-pinctrl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
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
> +        maxItems: 15
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
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lpass_tlmm: pinctrl@33c0000 {
> +        compatible = "qcom,sc7280-lpass-lpi-pinctrl";
> +        reg = <0x33c0000 0x20000>,
> +              <0x3550000 0x10000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&lpass_tlmm 0 0 15>;
> +    };
> 
