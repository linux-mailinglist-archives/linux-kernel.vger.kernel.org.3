Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1951847D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiECMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiECMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:45:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24271C909
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:42:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p18so19687970edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vDef1SK1QpCNUsFT8uzf/dvy81BNz2EqEvHCQZi+2aU=;
        b=xXy1l8LJBmAi7/DduD9i8lwP/MEfNrt5EwnARXauXu/S0j6E8oPuzvzf1GhgMhGXJm
         K29O3L3uc3aMBROVmU9iS0NXA9gv/F+KjSZX8xDkurfr5+hbjb/XOjnGQqiMU3h5Qvgo
         J09PXlrCam2fm1xio2CiLFHmEPgwrwJzhtXCOGecmDv3auHjQ1/4VBg3KEvPiVWpxxQz
         tURCIkBw5hKPxlJVT9ue2ljn6oyFHfkKkhUdyQChcGhf/XSqclItReCPEDqp++0Y2jLS
         FcqWqdKxjmmNI+Hfd/Qi9o6ViT5j9w0K6MP5K+oLcVv8L2hhnOxbVO+cgRGDfJGjLvg/
         sZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vDef1SK1QpCNUsFT8uzf/dvy81BNz2EqEvHCQZi+2aU=;
        b=l3qw+JBXOg9upOfiaP3juWxBFM5N1zBYiFSw3a73cQubpTEqJlEWvUa8g3O8xY5xip
         3aieVXKaeS0AVV4XZzmq/m4yVxo46GmO+RXM8gBT0BhtMuLzl6oRNpV3Yfw92/FIaFFz
         Z9CjaqPBaGm8XxHaVYcRl45qS8kvrtr494wbJtbl15GRCKjqpDj+fhiD/Co+0KGBaEPp
         EYsp693vAkTUcmDH9M69BlAA5AJpV1woFND/nqAPLqYnzDy5crOzKa89SGZkPkKbVIC9
         LlXqUxIeEaAJeynjZXNtwZv9SmgVWRsNnzqK6B3jLNTDD0A0QWR724vV4w5ggqzUCWHX
         P3vg==
X-Gm-Message-State: AOAM533dS00hzkuvz4dEJzzutvKuN2m21W5MjVKIU83axr4Mne/fJ3bW
        RMH0FAL7dMSKNy4vWSJDyJPA9FVUQQX2og==
X-Google-Smtp-Source: ABdhPJwjAgAVqgoZvGgvMgqFx99L1dBNuaD8f2PZmRj0EJxLcQDm1B+v2wNC1JrxKr6OeNwlV5yvWA==
X-Received: by 2002:a05:6402:4252:b0:426:3f66:9599 with SMTP id g18-20020a056402425200b004263f669599mr17376815edb.193.1651581727460;
        Tue, 03 May 2022 05:42:07 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv7-20020a1709072bc700b006f3ef214dbbsm4600703ejc.33.2022.05.03.05.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:42:07 -0700 (PDT)
Message-ID: <a872dbc4-3c6e-c0d5-3465-0c8e9122610a@linaro.org>
Date:   Tue, 3 May 2022 14:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dt-bindings: mux: Add lan966 flexcom mux controller
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
 <20220503105528.12824-4-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503105528.12824-4-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 12:55, Kavyasree Kotagiri wrote:
> This adds DT bindings documentation for lan966 flexcom
> mux controller.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../mux/microchip,lan966-flx-mux.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
> new file mode 100644
> index 000000000000..8b20f531781a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mux/microchip,lan966-flx-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: microchip Lan966 Flexcom multiplexer bindings
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description: |+
> +  The Microchip Lan966 have 5 Flexcoms. Each flexcom has 2 chip-selects
> +  when operating in USART and SPI modes.
> +  Each chip select of each flexcom can be mapped to 21 flexcom shared pins.
> +  Define register offset and pin number to map a flexcom chip-select
> +  to flexcom shared pin.
> +
> +properties:

Usually you need allOf referencing mux-controller.

> +  compatible:
> +    enum:
> +      - microchip,lan966-flx-mux
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#mux-control-cells':
> +    const: 1
> +
> +  mux-offset-pin:
> +    description: an array of register offset and flexcom shared pin(0-20).
> +
> +required:
> +  - compatible
> +  - '#mux-control-cells'
> +  - mux-offset-pin

and reg?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mux: mux-controller@e2004168 {
> +        compatible = "microchip,lan966-flx-mux";
> +        reg = <0xe2004168 0x8>;
> +        #mux-control-cells = <1>;
> +        mux-offset-pin =
> +                <0x18 9>; /* 0: flx3 cs0 offset, pin-9 */

You could put it in one line, I think.

> +    };
> +
> +    flx3 {
> +        atmel,flexcom-mode = <2>;
> +        mux-controls = <&mux 0>;
> +        mux-control-names = "cs0";
> +    };

No need for example for typical consumers. They are obvious and already
documented.

> +...


Best regards,
Krzysztof
