Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990D14FFA67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiDMPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiDMPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:39:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902664713
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:37:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so2839454edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PO/0MDUIRM3Z0h3PU4eYcvsEMMdjUT2V3VaPhr9z/E0=;
        b=uZu249qTy6MNrhwunH7p+LQXhXmrsO80rWgRpnSw5DiD3hbfKGkKdgwP4qCDhJcosG
         1id+AiwWFRQcUvt2is2rxDrfiNygmFCzfPjtkHQyWo9o/8aKwYt2NFGSUaheYFAnv0qw
         G9zfjPYM47uYz8+FcXJPtTEPc/DGp0TCuUDiaHpGYbU1tFZnTCVzfVXxfRBkv760CyRq
         lS+Q++xqPwB0O+09Gie6Y9JUnHWESMIY45tGEWA5ACGtR/BAl6R5tuY6OKbP/gveeIXZ
         rftEEHVAopdd1PKcPDXKBuFXrQORYK+u4GsFj4JYX9g5NALffkMyFfnPBE4fQ8WZLOlh
         +1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PO/0MDUIRM3Z0h3PU4eYcvsEMMdjUT2V3VaPhr9z/E0=;
        b=BaYqmGUzs3ln60e8HE8YtaCUCCsrIDSoMtMuWHwQ+7oUIbzilwX5ZX23aFwxMR6TN9
         9sXFqO0NYYrg2rx/88mPzDZwPvUVfv5EO+vLz04iwWYev+FzpvOiyJfsbCSFxI+VBGfE
         S1uencxtBTE6wiLJj7zDEQPLiJZo+66UQARcVRGjwUhmYuoObyDrfvExU8StEK/cLyAb
         KvCTrH+mY7UpEzf1SAayfAvpPviWyKSghR3LcNFZmnuLdZig0fgMeVHDljhwbe/Uikn+
         f9FhKhWjBuHEOPOIj9VR3lz7LQGfL6P6oZV7lXwCSWU2DGPQNrAg5lznfVN8ravYVfVe
         Y//w==
X-Gm-Message-State: AOAM532gAufucygJMFebWNndT3jPF+c0uM1IC1R8uDlvBz8NCuuHfUVD
        gjXJYlA6GHy0im/PGNwkjiCvcA==
X-Google-Smtp-Source: ABdhPJxyKrAG9rRVE8mRj679SzmDmAD8xVhn9EsmeCnZGHfphrC6B5qUeqw3KRrzN0aSvsQWiRckTA==
X-Received: by 2002:aa7:da8d:0:b0:41d:71be:d8bd with SMTP id q13-20020aa7da8d000000b0041d71bed8bdmr20584914eds.71.1649864252388;
        Wed, 13 Apr 2022 08:37:32 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dn7-20020a17090794c700b006e8b176143bsm102985ejc.155.2022.04.13.08.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:37:31 -0700 (PDT)
Message-ID: <41fa58ee-728b-7f0d-eea7-448c59641d85@linaro.org>
Date:   Wed, 13 Apr 2022 17:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 11/14] dt-bindings: pinctrl: add binding for Ralink MT7620
 pinctrl
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-12-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413060729.27639-12-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 08:07, Arınç ÜNAL wrote:
> Add binding for the Ralink MT7620 pin controller for MT7620, MT7628 and
> MT7688 SoCs.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,mt7620-pinctrl.yaml        | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> new file mode 100644
> index 000000000000..01578b8aa277
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/ralink,mt7620-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ralink MT7620 Pin Controller
> +
> +maintainers:
> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description:
> +  Ralink MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
> +  The pin controller can only set the muxing of pin groups. Muxing indiviual pins

Run spellcheck on original bindings, don't copy same typos.

> +  is not supported. There is no pinconf support.
> +
> +properties:
> +  compatible:
> +    const: ralink,mt7620-pinctrl
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    patternProperties:
> +      '^(.*-)?pinmux$':

Why do you have two levels here? pins->pinmux->actual pin configuration?
Cannot be something like brcm,bcm636x has?

> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#
> +
> +        properties:
> +          groups:
> +            description: The pin group to select.

I wonder where do you configure particular pins because these are
groups... It's a bit confusing to configure "i2c" group into "i2c" -
looks obvious.

> +            enum: [
> +              # For MT7620 SoC
> +              ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi, spi refclk, uartf, uartlite, wdt, wled,
> +
> +              # For MT7628 and MT7688 SoCs
> +              gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
> +              p3led_kn, p4led_an, p4led_kn, perst, pwm0, pwm1, refclk, sdmode, spi, spi cs1, spis, uart0,
> +              uart1, uart2, wdt, wled_an, wled_kn,
> +            ]
> +
> +          function:
> +            description: The mux function to select.
> +            enum: [
> +              # For MT7620 SoC
> +              ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa, pcie refclk, pcie rst,
> +              pcm gpio, pcm i2s, pcm uartf, refclk, rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite,
> +              wdt refclk, wdt rst, wled,
> +
> +              # For MT7628 and MT7688 SoCs
> +              antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
> +              p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1,
> +              pwm_uart2, refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1, spis, sw_r, uart0,
> +              uart1, uart2, utif, wdt, wled_an, wled_kn, -,

All these lines do not fit in 80-character limit. Linux coding style
still expects this in most of cases.

> +            ]
> +

Best regards,
Krzysztof
