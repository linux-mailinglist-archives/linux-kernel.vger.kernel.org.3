Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E14FE0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353754AbiDLMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353898AbiDLMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:42:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6742DD1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:06:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c6so6932515edn.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hc3hJzzcC4rxfq/Wm1m02VMwP6AM+k8j0LB5pY+4um8=;
        b=Kkrkl9jK9ioUkCwZ8J7Ws81Yvys20F3b57Rkqr36ePxZTE4if+64SKIq2JFxYAoBIB
         IXHl8reCWkS2mQ/Ov3b+s3ZSeRmOvzOnPu2CxiohJ0l+eOMB6IIif337JxQjbkZJUCig
         b/vEEKSNw294cuJt6NPxKfTOa1RTK+LHbOeL9iz0ib8dTKAMKFMfqZ/pNHMHAp8xxm/d
         YAs1Seuy9FrR6kcMIsJy9rBxCYhz857ozhsEeAwCVjjaUDbAo3TJE+ydwzFxI7IvYY1K
         zoq8qznpV/nXNTL3TQ6uiYm3IDhw8UgPBjv0RnYaDZCacUv2G8MU1fAl4XWy1gnqIGX4
         9aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hc3hJzzcC4rxfq/Wm1m02VMwP6AM+k8j0LB5pY+4um8=;
        b=rKQdczkEgt244JzPVJoU2UNLvFax1pQUk9Gr2yLuoaPO3QwwnRAK99G3ENqQ7P1UJC
         GlwT55qPDw+2aLaRuqchIjYJ/ovQCXlAtFnW0ogJDiZGEhjaw8XgV++s1PNYr5+oqgjL
         6tBdtOmUVZjMn3D+4SKlJcH5o5V9pS5Zo1K0VY2Wz6K6SCxtN0PCQCvnnk/HInX17tBY
         V9NiAUDP0gBPzrABwMTxDQmUgMZ9hfj8R19AmeCVHQRR77L4sANOD0CwSbwJac8mGout
         MNKmX7T24MQu4jhps64ons4RJ5oYlQYBrox5OfqjZBWFoY0WSdn0pO4/FGZkTwS+uUrv
         nW+w==
X-Gm-Message-State: AOAM532L2o1t5bwgCRQvgI6I22LjIuHx3ZfvHT+buS+q5CidJoMTYc0T
        z7dOszCwog2zxB2WeGDPHrvTyw==
X-Google-Smtp-Source: ABdhPJw1+fn4L3/9KnSUAOGZMWbMxDlB6+K6ZqEZZgJu2zH/gn+0JE6RHZnqYBHYxnu0m3IYGndO0g==
X-Received: by 2002:a05:6402:14b:b0:418:d06e:5d38 with SMTP id s11-20020a056402014b00b00418d06e5d38mr37384606edu.90.1649765202629;
        Tue, 12 Apr 2022 05:06:42 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm13079003ejp.20.2022.04.12.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:06:42 -0700 (PDT)
Message-ID: <dee496ce-5e74-4a53-c783-6420b2391387@linaro.org>
Date:   Tue, 12 Apr 2022 14:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add TI K3 RTC devicetree bindings
 documentation
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-2-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412073138.25027-2-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 09:31, Nishanth Menon wrote:
> This adds the documentation for the devicetree bindings of the Texas
> Instruments RTC modules on K3 family of SoCs such as AM62x SoCs or
> newer.
> 

Thank you for your patch. There is something to discuss/improve.

(...)

> +properties:
> +  compatible:
> +    items:

No need for items. Just enum under the compatible.

> +      - enum:
> +          - ti,am62-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: VBUS Interface clock
> +      - description: 32k Clock source (external or internal).
> +
> +  clock-names:
> +    items:
> +      - const: "vbus"
> +      - const: "osc32k"

No quotes.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  assigned-clocks:
> +    description: |
> +      override default osc32k parent clock reference to the osc32k clock entry
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    description: |
> +      override default osc32k parent clock phandle of the new parent clock of osc32k
> +    maxItems: 1

Usually assigned-clockXXX are not needed in the bindings. Is here
something different? They are put only to indicate something special.

> +
> +  wakeup-source: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    rtc@2b1f0000 {
> +        compatible = "ti,am62-rtc";
> +        reg = <0x2b1f0000 0x100>;
> +        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&bar 0>;
> +        clocks = <&foo 0>, <&foo 1>;
> +        clock-names = "vbus", "osc32k";
> +        wakeup-source;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    rtc@2b1f0000 {
> +        compatible = "ti,am62-rtc";
> +        reg = <0x2b1f0000 0x100>;
> +        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&bar 0>;
> +        clocks = <&foo 0>, <&foo 1>;
> +        clock-names = "vbus", "osc32k";
> +        wakeup-source;
> +        assigned-clocks = <&foo 1>;
> +        assigned-clock-parents = <&foo 2>;
> +

Unneeded blank line.

> +    };


Best regards,
Krzysztof
