Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18FB524FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbiELO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355262AbiELOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:25:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48413F00
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:25:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ch13so10529569ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e7wJLjfJ1iVilvpq3jQ/LuI1I5wd6zNBUq4hxK7yISQ=;
        b=r5ualuxQ0leFqfg+jbNOvJJk8d5rLmW6rQULOQ0IRnTzgGR9H/PIWd9zWwzi3fs9WC
         S1+FtRFMKsim/XCxLByVyAPekRdEM+FkcCbXi0+pkaqQrGQuMKAqH4LWlJgqhnW90b53
         hUcHLI6ng/MAOx3Ixjn4Bte8v2Le82Buhh1GjWKoq0c0Q8nk9dyi3F42U34U10f6fyyO
         +hMWt5oUXdRHyqZvXq4fpzcyQ+u/x9RJ318MWMw/PSTuk7Wo0+iY86IzDn6FKEzxbT8x
         EG0pnu9SrvZgNIOARlKvfuwqyU1AOdJqhDncYUpZLB5LqJs2JwSHle88uuT735DJAPAC
         y0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e7wJLjfJ1iVilvpq3jQ/LuI1I5wd6zNBUq4hxK7yISQ=;
        b=tEuPJxOtOqXZ0JBR3dvrv7rtvqNDhTBGE4kyZSL1QXF288I8h6RsjoxuMvsBZxhJsg
         S8LZUUMcLxadI12RVXAplR3eAdrNg1W2vxkEIwcL0rYcy69qvfycWHnBTz6xGKPaf7rt
         jGAHVfLCAxDAOqOi5ScqQbbIZy/pcLd/BObRjl86wNIOrXCVCQKNusDbgWSfXXOC51gy
         qf8gncYz1ninD4hYKloX9c149rkBk+X9n2ENZoJxOIy4Ss8ZD3yVr3OoK4xUWBwHNMXu
         tMVnHkFhO/nOK9alMY2gdIoGDtVz1lfEf16GfzM+1rHzpoTzkTKCKFcQ/SuAOacEtxa7
         Pdrw==
X-Gm-Message-State: AOAM532ovCHXRe5gBgVKSi1PRFXpUydJA/TvIO0BvpnIiSwiaT7C1P0u
        AxZo+mgBcNe8NUa8M+7iI1nX5qrQuUoBiK91
X-Google-Smtp-Source: ABdhPJxfn8AF52a6nAcaWJI5jbWZNRWTIkVKS2zEyi9i2MQCsxmdkfWrb5DIJvkdV6aURcKf/+NZ2w==
X-Received: by 2002:a17:907:6e88:b0:6fa:888d:74a7 with SMTP id sh8-20020a1709076e8800b006fa888d74a7mr141867ejc.335.1652365553928;
        Thu, 12 May 2022 07:25:53 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906700e00b006f3ef214e34sm2134511ejj.154.2022.05.12.07.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:25:53 -0700 (PDT)
Message-ID: <546ddbd4-927d-2e28-6e82-a67b4584a17f@linaro.org>
Date:   Thu, 12 May 2022 16:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: Add binding document for
 mt6873 thermal controller
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
References: <20220512122433.1399802-1-abailon@baylibre.com>
 <20220512122433.1399802-3-abailon@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512122433.1399802-3-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:24, Alexandre Bailon wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> This patch adds binding document for mt6873 thermal controller.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> ---
>  .../thermal/mediatek-thermal-lvts.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> new file mode 100644
> index 000000000000..69ffe7b14c21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml

filename: vendor,device
so something like mediatek,mt6873-lvts.yaml or
mediatek,mt6873-lvts-thermal.yaml

> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek-thermal-lvts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek SoC LVTS thermal controller (DTS) binding

s/(DTS) binding//
(unless DTS means something related to hardware)

> +
> +maintainers:
> +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> +  - Ben Tseng <ben.tseng@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6873-lvts
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lvts_clk

Skip "_clk" suffix, so just lvts.

> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +required:
> +  - "#thermal-sensor-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

You should reference in allOf therma-sensor.yaml unless this is not a
thermal sensor?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +    dts: lvts@1100b000 {

Generic node name, so thermal-sensor

> +        compatible = "mediatek,mt6873-lvts";
> +        reg = <0x1100b000 0x1000>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        clock-names = "lvts_clk";
> +        #thermal-sensor-cells = <0>;
> +        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +    thermal-zones {
> +        cpu_thermal: cpu-thermal {
> +            polling-delay-passive = <0>;
> +            polling-delay = <0>;
> +
> +            thermal-sensors = <&dts>;
> +            trips {
> +                cpu_alert1: cpu-alert1 {
> +                    temperature = <85000>;
> +                    hysteresis = <0>;
> +                    type = "passive";
> +                };
> +
> +                cpu_crit: cpu-crit {
> +                    temperature = <120000>;
> +                    hysteresis = <0>;
> +                    type = "critical";
> +                };
> +            };
> +
> +            cooling-maps {
> +            };

Empty node? Is it used anyhow here?

> +        };
> +    };
> +...


Best regards,
Krzysztof
