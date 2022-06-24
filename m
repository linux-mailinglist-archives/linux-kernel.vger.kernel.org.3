Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6C559766
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiFXKKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiFXKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:10:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051037A6D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:09:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so3699103ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lorZHDjvGx5GD+gar7tqgB1Qj4XdO8WewdyIcYo1mvQ=;
        b=Ti+fVnTmNKYwrAedrBvndCldoW4NlBmv0536IQ1k7OjvfHGtm0ly+8LwT7LHpGHzlz
         LafqDygKvgifpswBtGLrtk9U7xuH7aey9fjumlhSjD2X+iwlgI3p2XPtC7usywyN7xGY
         W2A8LzDsZUGZY5uV7/tcGbZ1zfr+6u4F5Xye6rZDK8hni7hRyauGtjHMj53vdiF4nE9N
         yE03ZJQdZx2IMeDGIfYUqCYHP4GkOp77AX6oMkRLiGOFVczBaH/FqSkmXXaTLaqqI4aU
         ZZfC0gnTBThlESIIWgvLVe41AgjoHBQKfZAsMM2f26Sz4jxuYocBYsA3qE3lyJ7g+E/6
         4bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lorZHDjvGx5GD+gar7tqgB1Qj4XdO8WewdyIcYo1mvQ=;
        b=zxwHRm5nlex18DrjNr3Xfp96RRRZVbnH+ybl8ip4Z6XtQT3+UjFkkVtEIH/ZBYPyg5
         1440lQc83xgOtW+I+6givV5wB5dTUvEYfqLzv982GaYcg/y/a+07jAnEXsCPXhK8H/dt
         HvD5fjh5oKZRDAdQCX21aanp4CHrN7GohGAM1im0dCwSqZjvez4htn9wW0eRvA+VeuZ6
         UidHHzUrVO3vzcoDnZ2D0lp1Cy52fsAY1t08zqupyIW5XKeYMenaSTMZVGivYcuOxNDn
         Q0Hk//axlKQpuzfTR5eUsnGVngi8qvwb5E2/d+U7qgdCVIng/cWwmU0QGZu1RY9OdTCu
         /3oQ==
X-Gm-Message-State: AJIora/eZpqlDxG559Do0ShulkUnw1cHBInBYY3KgoTdxjzw0tDnd8V6
        /A4MQYuTy03+OxpM8qgMnu8TWQ==
X-Google-Smtp-Source: AGRyM1uKgLP0q+F3EV/ZKpI4bKmuL8O9cSoJ6Y20J5j3QtItOyrNB6oS6chuuxpNORk9LaAzvkhBRg==
X-Received: by 2002:a17:907:3f21:b0:722:ca29:7ec9 with SMTP id hq33-20020a1709073f2100b00722ca297ec9mr12231536ejc.417.1656065397338;
        Fri, 24 Jun 2022 03:09:57 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b006ffa19b7782sm841359ejf.74.2022.06.24.03.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:09:56 -0700 (PDT)
Message-ID: <3e8e2ad5-9a1c-44f3-cff9-50ad2124c9f9@linaro.org>
Date:   Fri, 24 Jun 2022 12:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 03/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>,
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
 <20220616164303.790379-4-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-4-viorel.suman@nxp.com>
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

On 16/06/2022 18:42, Viorel Suman wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'iomux/pinctrl' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 47 +++++++++++++++++++

Since this is a conversion, I expect removal of existing bindings. This
applies to each other patch as well.

>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> new file mode 100644
> index 000000000000..7a08c60da66f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> @@ -0,0 +1,47 @@
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
> +properties:
> +  compatible:
> +    items:

You have only one item, so no items.

> +      - enum:
> +          - fsl,imx8qm-iomuxc
> +          - fsl,imx8qxp-iomuxc
> +          - fsl,imx8dxl-iomuxc
> +
> +patternProperties:
> +  "grp$":
> +    type: object

You need to describe the children and then additionalProperties:false.
See other pinctrl bindings for example.

> +
> +required:
> +  - compatible
> +

Missing allOf referencing pinctrl.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
> +    pinctrl {
> +             compatible = "fsl,imx8qxp-iomuxc";
> +
> +             pinctrl_lpuart0: lpuart0grp {
> +                    fsl,pins = <
> +                            IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> +                            IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> +                    >;
> +             };
> +    };


Best regards,
Krzysztof
