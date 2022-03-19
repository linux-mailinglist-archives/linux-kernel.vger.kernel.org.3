Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21604DE85A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiCSObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiCSObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:31:45 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F942A13;
        Sat, 19 Mar 2022 07:30:24 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id bg10so21999923ejb.4;
        Sat, 19 Mar 2022 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pMCksSCfBCH6lRrr4YOJuMdM6Zq0+qy0cl8Db9Zyz40=;
        b=rTmdonx5AVV0oUi1g+YjztMRLYLQucfw0DVybjiKEmH+rrP7GljFwyd15jYAdceqwF
         lPrsVloxFb/GVZcGHnkjUjvyvBmNtrvaaKdzt4Koi4lveVQ65jUx6yUfSCMXySThmq1r
         RDUygGvffNKUyq4J70ZQkCrBPAcG1fUKnDS4pdXKBsWzYf6A8UvnfXyQzutB0h6Yy9d1
         S/cCn7nR4Iq3pLIukrxY27jJ12x7Duf4ZzJSEGRC/jaFry0oh6wR49xRzLt/bGq0YCSm
         WGQTO1U5S4ocz8CEXb1AfCedVJ/fJyx5SnO9cfmh7ZAVd1GSptimniGJekHugEDFBbCG
         w7BQ==
X-Gm-Message-State: AOAM5331u97Uowx4spgqkFw4TPkcVD1FPrxlkApFs8qxjsDnd2vMa6+c
        hC8xbqzz0s5GEdMhl/ADQdk=
X-Google-Smtp-Source: ABdhPJwfp6apknD6pSBLJZ8KXHAIi455ozkgX7IUny2JLz9DfmRFaZj7Lgh3EL3qwrp2vuVCEwUj2g==
X-Received: by 2002:a17:907:6e93:b0:6df:8c1a:d08b with SMTP id sh19-20020a1709076e9300b006df8c1ad08bmr12438875ejc.557.1647700222339;
        Sat, 19 Mar 2022 07:30:22 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id q5-20020aa7cc05000000b004129baa5a94sm5618401edt.64.2022.03.19.07.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:30:21 -0700 (PDT)
Message-ID: <de57d12e-bb05-fdcb-0072-82d7e33141eb@kernel.org>
Date:   Sat, 19 Mar 2022 15:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 8/8] dt-bindings: pinctrl: convert ocelot-pinctrl to
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
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-9-michael@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318202547.1650687-9-michael@walle.cc>
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

On 18/03/2022 21:25, Michael Walle wrote:
> Convert the ocelot-pinctrl device tree binding to the new YAML format.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |  42 -------
>  .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 108 ++++++++++++++++++
>  2 files changed, 108 insertions(+), 42 deletions(-)
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
> index 000000000000..7149a6655623
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mscc,ocelot-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsemi Ocelot pin controller
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Lars Povlsen <lars.povlsen@microchip.com>
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
> +  reg:
> +    items:
> +      - description: Base address
> +      - description: Extended pin configuration registers
> +    minItems: 1
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
> +
> +  interrupt-controller: true

These three interrupt related properties were not in original bindings.
Is this something new or was actually before, just not documented? In
any case mention it in commit msg.


Best regards,
Krzysztof
