Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523D4D769A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiCMP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCMP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:56:20 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482535F4D9;
        Sun, 13 Mar 2022 08:55:12 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id yy13so29074316ejb.2;
        Sun, 13 Mar 2022 08:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lppl2q49qeslrHl4lbbUkfz5RBuPxkaME3WqV+QucHI=;
        b=Aze/xnfgdubpjIVvq27Obt8JzI+LFswuqU6lOMF44goINqDwvlCCJHbGHc8NDxJqo7
         0DXza7DLeIpXDdyi4ptnlpjkQ7ZxjOWShq51HajKr6PfxxvU9hC3IgPz+52sghAE51jW
         lT06Ffvb3cG40bXxWwQioodNE/2eXiIbQv4LGrHAtnDew5un0dGloElMpbD5opftArva
         zAppTplDxzBEXNEAj7v85NqCu2nw09e3iN1fYs+ZkMvKCsgzKOkz80QBg1x3E1wPP75c
         0x+la6BWl5lWancDodJSuXbsy6M8WeM+29Lkibz0XieYlDD1OSSR+JlO7fS3KlgYRXX5
         Ynrw==
X-Gm-Message-State: AOAM532So/U3bks1q7pCYqb5NYalySJj/3og2+3AKbsM4USIUMLGGo1g
        t7pfy7lFdL3uxvvB4Ican4A=
X-Google-Smtp-Source: ABdhPJzy6ExQ70F33nYsMreky8RZw37LDLJGudGbeTrCpk+Nihs/opiYugSPYk3GitqeOuJs+sHjYw==
X-Received: by 2002:a17:907:7845:b0:6cd:f2f4:cf00 with SMTP id lb5-20020a170907784500b006cdf2f4cf00mr15345462ejc.388.1647186910621;
        Sun, 13 Mar 2022 08:55:10 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm6507407edk.13.2022.03.13.08.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 08:55:10 -0700 (PDT)
Message-ID: <869d4fda-e943-1817-17cd-df7b323a1fef@kernel.org>
Date:   Sun, 13 Mar 2022 16:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 8/8] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220313152924.61931-1-michael@walle.cc>
 <20220313152924.61931-9-michael@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220313152924.61931-9-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2022 16:29, Michael Walle wrote:
> Convert the ocelot-pinctrl device tree binding to the new YAML format.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  | 42 ---------
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
> deleted file mode 100644
> index 5d84fd299ccf..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Microsemi Ocelot pin controller Device Tree Bindings
> -----------------------------------------------------
> -
> -Required properties:
> - - compatible		: Should be "mscc,ocelot-pinctrl",
> -			  "mscc,jaguar2-pinctrl", "microchip,sparx5-pinctrl",
> -			  "mscc,luton-pinctrl", "mscc,serval-pinctrl",
> -			  "microchip,lan966x-pinctrl" or "mscc,servalt-pinctrl"
> - - reg			: Address and length of the register set for the device
> - - gpio-controller	: Indicates this device is a GPIO controller
> - - #gpio-cells		: Must be 2.
> -			  The first cell is the pin number and the
> -			  second cell specifies GPIO flags, as defined in
> -			  <dt-bindings/gpio/gpio.h>.
> - - gpio-ranges		: Range of pins managed by the GPIO controller.
> -
> -
> -The ocelot-pinctrl driver uses the generic pin multiplexing and generic pin
> -configuration documented in pinctrl-bindings.txt.
> -
> -The following generic properties are supported:
> - - function
> - - pins
> -
> -Example:
> -	gpio: pinctrl@71070034 {
> -		compatible = "mscc,ocelot-pinctrl";
> -		reg = <0x71070034 0x28>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		gpio-ranges = <&gpio 0 0 22>;
> -
> -		uart_pins: uart-pins {
> -				pins = "GPIO_6", "GPIO_7";
> -				function = "uart";
> -		};
> -
> -		uart2_pins: uart2-pins {
> -				pins = "GPIO_12", "GPIO_13";
> -				function = "uart2";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> new file mode 100644
> index 000000000000..40148aef4ecf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mscc,ocelot-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsemi Ocelot pin controller Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,lan966x-pinctrl
> +      - microchip,sparx5-pinctrl
> +      - mscc,jaguar2-pinctrl
> +      - mscc,luton-pinctrl
> +      - mscc,ocelot-pinctrl
> +      - mscc,serval-pinctrl
> +      - mscc,servalt-pinctrl
> +
> +  reg: true

maxItems

> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-ranges: true
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The GPIO parent interrupt.

Skip description, it's obvious.

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges

Put "required:" after "patternProperties:".

> +patternProperties:
> +  '-pins$':
> +    type: object
> +    allOf:
> +      - $ref: "pinmux-node.yaml"
> +      - $ref: "pincfg-node.yaml"


Best regards,
Krzysztof
