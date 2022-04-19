Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F042A50770B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356179AbiDSSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiDSSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:08:23 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235F3C4BB;
        Tue, 19 Apr 2022 11:05:40 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id e4so18990291oif.2;
        Tue, 19 Apr 2022 11:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1O+KyyhxbKVGh/D16i1ET31wxfeZw0J9Z5ULpq64bTk=;
        b=awXoQMNj7gfpFS3wKKx5DRvuwrABKjqFC0djqVwyobaehNoVYzkV/V1Za8S8FHxc08
         oVsNriNZSzcNktXkz6M3qQMU3m1/AKTg0/DRvNNQIWe6MPaa+DDaQellm14WiRzPNXL0
         xLIg2CeZtVV24Hde0lu8vz3ISXu8Bx9e6/J7U/PZj2F5UIwvtvkhyTITRT2UdvEgr4jD
         mG16D8+600qqzl+jvPXt31nxUoXBeWqulyAyj/+qk6WeUbkXqn6aStBxui8HeY+1kJJT
         abt3oMtieaWrSZynVyhb337kv4JOXpoTNqJ/+kQRuTih+5xjArN9pg/DOepqksRkC1pP
         M1wg==
X-Gm-Message-State: AOAM530HyVWA+dHURDjwQJJhHs65geCQPQf5yjHzO6KHfo7AUtRX3B2d
        TqQ+OC7nA3tjJbLIncBEFw==
X-Google-Smtp-Source: ABdhPJzFDWZidT+kxj6ha1sr2oIoRXGgkoEbccfVw9/gVPmUJO5HKTGUHtPk1/R9599eDC8/tUF0eg==
X-Received: by 2002:a05:6808:2ce:b0:2f7:2327:5205 with SMTP id a14-20020a05680802ce00b002f723275205mr10426857oid.289.1650391540040;
        Tue, 19 Apr 2022 11:05:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a7505000000b0033a47bb6a74sm948330ooc.47.2022.04.19.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:05:39 -0700 (PDT)
Received: (nullmailer pid 3069490 invoked by uid 1000);
        Tue, 19 Apr 2022 18:05:38 -0000
Date:   Tue, 19 Apr 2022 13:05:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>, erkin.bozoglu@xeront.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 13/14] dt-bindings: pinctrl: add binding for Ralink
 RT305X pinctrl
Message-ID: <Yl758u9iIMnhYPz2@robh.at.kernel.org>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-14-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414173916.5552-14-arinc.unal@arinc9.com>
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

On Thu, Apr 14, 2022 at 08:39:15PM +0300, Arınç ÜNAL wrote:
> Add binding for the Ralink RT305X pin controller for RT3050, RT3052,
> RT3350, RT3352 and RT5350 SoCs.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
> new file mode 100644
> index 000000000000..425401c54269
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/ralink,rt305x-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ralink RT305X Pin Controller
> +
> +maintainers:
> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description:
> +  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
> +  SoCs.
> +  The pin controller can only set the muxing of pin groups. Muxing individual
> +  pins is not supported. There is no pinconf support.
> +
> +properties:
> +  compatible:
> +    const: ralink,rt305x-pinctrl

You should have a compatible for each SoC unless these are all just 
fused or package varients of the same chip.

> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    patternProperties:
> +      '^(.*-)?pinmux$':
> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#
> +
> +        properties:
> +          groups:
> +            description: The pin group to select.
> +            enum: [
> +              # For RT3050, RT3052 and RT3350 SoCs
> +              i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite,
> +
> +              # For RT3352 SoC
> +              i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1, uartf,
> +              uartlite,
> +
> +              # For RT5350 SoC
> +              i2c, jtag, led, spi, spi_cs1, uartf, uartlite,
> +            ]
> +
> +          function:
> +            description: The mux function to select.
> +            enum: [
> +              # For RT3050, RT3052 and RT3350 SoCs
> +              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio, pcm gpio,
> +              pcm i2s, pcm uartf, rgmii, sdram, spi, uartf, uartlite,
> +
> +              # For RT3352 SoC
> +              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna, mdio,
> +              pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1, uartf,
> +              uartlite, wdg_cs1,
> +
> +              # For RT5350 SoC
> +              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, pcm gpio,
> +              pcm i2s, pcm uartf, spi, spi_cs1, uartf, uartlite, wdg_cs1,
> +            ]
> +
> +        required:
> +          - groups
> +          - function
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  # Pinmux controller node
> +  - |
> +    pinctrl {
> +      compatible = "ralink,rt305x-pinctrl";
> +
> +      i2c_pins: i2c0-pins {
> +        pinmux {
> +          groups = "i2c";
> +          function = "i2c";
> +        };
> +      };
> +    };
> -- 
> 2.25.1
> 
> 
