Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9389B5607D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiF2RyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiF2Rx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:53:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CF25280
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:53:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so34059782eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QsHsxpU9tGa+aGdcCbpe2HZGvXnqiXDrYeH5Rg2GOUk=;
        b=vG58x7LD00TJa1n7JuY60BzBXWFJUi5zUQ77KSsQuEUpqFoHVsSDm2YyEVYRl6DmH/
         Lxo1qAYH3+jsRqEGAT6LxB+rAIn5Vh4H7IUQebGk6ProtaluAvIJD990qvlXRNy70gIu
         X4m8EWzrBNvc9v83/T14RtP+3frVt0MmOeaRPpqg7xQSd4/rzrr5tWbv/nLw5DCpTtty
         D8JQuXuPNqXGbXGHAQz2e8KKX3u1sVpEQ2MXr9OBSMvZMlf/hNtrZaOpWt04oqzT7RlO
         aBaAYWD9T3wO4xpKaV1nfgTHBHYG4bi7U5SYDseQSk4x1LfMfDc4oaG0PD6SvzerXtpU
         /OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QsHsxpU9tGa+aGdcCbpe2HZGvXnqiXDrYeH5Rg2GOUk=;
        b=mBS5rPaEjQifyxDz9/npllZcjLr/9FbJlmUOp9u4FjqbBBfshHRxJNukBkNrlzLV80
         s4FYUBNgaGTd2HnOpFJxZg5fzxG1BcRV/UsF+ItoTNDvXeWbndE2zhtWCElqYit/1+Yo
         szF9oe+J2McrHyzPgDVU5a20hF5KzG2AhG0yZaaI3y+WrN9u5iPX2ju7YlEMo/e4lxsM
         22Igeun2zc++rkDDOVDbiisaVtl6oJTIqc/i7ziu/k+8SaNhWnHkI4HYRdqIIsrOrWP5
         B0988HHrEp36MTqYN+INhq0C7NY6dH14f1Y9Qd/CsST/xW+J+Ma6P5S6H8vujUabY6f/
         Q8lg==
X-Gm-Message-State: AJIora8UP622k0omX2l3V0cPZVL4yUM91xAh6sX2HAEvsoJXYebMZaRv
        vrv/4eSG2zT/C1K9Xk3AZU3Bxg==
X-Google-Smtp-Source: AGRyM1vFxZYGaApgEoUtkfHlAZbHmIOcpnhnleQF5yU3f85m0ctcUX/QttAdVsVjma8DmeXr0JpoUw==
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr4558594ejc.71.1656525233471;
        Wed, 29 Jun 2022 10:53:53 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709061b5700b0070e3f58ed5csm8008044ejg.48.2022.06.29.10.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:53:53 -0700 (PDT)
Message-ID: <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
Date:   Wed, 29 Jun 2022 19:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-3-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-3-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'iomux/pinctrl' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> new file mode 100644
> index 000000000000..76a2e7b28172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  This binding uses the i.MX common pinctrl binding.
> +  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

Don't mix the quotes. You changed them to ', so stick with it.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-iomuxc
> +      - fsl,imx8qxp-iomuxc
> +      - fsl,imx8dxl-iomuxc
> +
> +patternProperties:
> +  'grp$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      fsl,pins:
> +        description:
> +          each entry consists of 3 integers and represents the pin ID, the mux value
> +          and config setting for the pin. The first 2 integers - pin_id and mux_val - are
> +          specified using a PIN_FUNC_ID macro, which can be found in
> +          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer CONFIG is
> +          the pad setting value like pull-up on this pin. Please refer to the
> +          appropriate i.MX8 Reference Manual for detailed CONFIG settings.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix

Look at fsl,imx8mq-pinctrl.yaml. Each item is described (items under items).

> +
> +    required:
> +      - fsl,pins
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
> +    pinctrl {
> +        compatible = "fsl,imx8qxp-iomuxc";
> +
> +        pinctrl_lpuart0: lpuart0grp {
> +            fsl,pins = <
> +                111 0 0x06000020
> +                112 0 0x06000020
> +            >;
> +        };
> +    };


Best regards,
Krzysztof
