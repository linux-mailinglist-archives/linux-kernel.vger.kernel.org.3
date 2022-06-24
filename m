Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD7559773
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiFXKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiFXKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:14:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9779459
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:14:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c65so2771680edf.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AcY+HP4cwp4akXGFwkLr6M8Z1HqAMnPM3PSHpw8twr8=;
        b=Cbo/Btoy1nUj2APYAmNR1tjl4VadDRYvTl6d5eSXkjY97RqyFvAeS/n+/rjJfRqV44
         my+kHT5GieN2nuIdqANvs9Rk0+F5bMSByB59RCNq9lzkgPbaHLl5c+gnz3aaHdwW9GBn
         dnFHCt0Qpa1lJa7o42zUAcgXFSzurVtPCjjmYCcap3Vag3qAMiHRqoYGOsFcN4bAihii
         ydqnFULFZcFxhFJ3igfYfhFQTpNubnRFzxC9yvwhdjjlEnQxlM+A9d7QF+BUkVzOwOLx
         EoIUJdrHuPRaiWdsQh/fKtp7kGvXsUGJhpjo0Gy15S1cOi7Qz4ZhpwXhwDriuT6hfD0l
         PG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AcY+HP4cwp4akXGFwkLr6M8Z1HqAMnPM3PSHpw8twr8=;
        b=QTOxrtk7wLiesXPf/K8s4mqkd59CvGiL4P9eOkbsa1R/nEV6Ux90uVkyvJht3si9Dj
         hiNzdDn2NJ0H7gQhhLwAVj3wBG4cuM+XVFQ9ZatDuYBehAXsRb/bWq0adJ3UTPWmucx7
         dOMN7O52k+e5I4PuHX1MaHjzoYWSVJ3fs6k3cOdDQ4nXXGRBGYb6RaBGFX9YvHUck6lf
         Mc2kb5ecDFFfaOvBCBLR0NVsSyVZerfBmZlNUaHu57+gguRTeXhpNbtfOLXky5VmXro3
         KTHZ66aL33wPlyA4JIr7aMHZn+/gbTZVBZXHgxOvDkdpReuvLdc5lSb/HSE0Jm1dSVDk
         UQGg==
X-Gm-Message-State: AJIora+uvAu6GrZxh5WZvPgrxAl/W0mOen8k5ikvNvjYMIbTMNuFay3A
        Dm8orJsL5cbIB3e/YNrCueBs8w==
X-Google-Smtp-Source: AGRyM1trgaQXVxx26CYWrQyfWcG0a6ixDYGE2bgWurlUNVetfe28U9HzJOz6s2Q5led/4U9xLht63Q==
X-Received: by 2002:a05:6402:3594:b0:431:4cb8:c7b6 with SMTP id y20-20020a056402359400b004314cb8c7b6mr16603969edc.334.1656065644733;
        Fri, 24 Jun 2022 03:14:04 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b004355dc75066sm1602589edo.86.2022.06.24.03.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:14:04 -0700 (PDT)
Message-ID: <d4aa419b-201b-46dc-65f2-40333c5b9ac5@linaro.org>
Date:   Fri, 24 Jun 2022 12:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 04/14] dt-bindings: input: Add fsl,scu-key yaml file
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
 <20220616164303.790379-5-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-5-viorel.suman@nxp.com>
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
> separately the 'keys' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/input/fsl,scu-key.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
> new file mode 100644
> index 000000000000..b0f4c5b553ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +allOf:
> +  - $ref: /schemas/input/input.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8qxp-sc-key
> +      - const: fsl,imx-sc-key
> +
> +  linux,keycodes: true

need maxItems

> +
> +required:
> +  - compatible
> +  - linux,keycodes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +
> +    keys {
> +             compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";

Wrong indentation.

> +             linux,keycodes = <KEY_POWER>;
> +    };


Best regards,
Krzysztof
