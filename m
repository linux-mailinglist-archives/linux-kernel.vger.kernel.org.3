Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E94E1B26
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiCTK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiCTK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:56:07 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA6419A4;
        Sun, 20 Mar 2022 03:54:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id g20so14952437edw.6;
        Sun, 20 Mar 2022 03:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DoyDLcneBed/lxmrHnHYG/MOmh/NiMvZkZDcOvMscXc=;
        b=gnc4bfrWBvpS5qFmT3uS9pkqTMi2Zfk8OKf57gAXSV1hCffjRbdLVUSmA8YYRJ5TFC
         hmLFkJ90gqboXdQVxFc92lq7ppIW5XmCk8z0UAwTSDZGawSTepUcDh8VQMu+0P/Qc44j
         OPx53De17oeq32H8MBOCanaQcR3pen8UjO7EL2EaKPZpWMv6hvsKe9CsAM8Tl1TrQVs8
         AdrxhZQQsspTtZZMsHadDNZ2rRjaLAbAW1Wa8q8ln8cRqVAVQaWswIOEQkekoXDhZE48
         VI9co/iasNr2cIVOxihGNV/Ob2F8A8whqUpZay4bKQaKzA5pqqbXPIk/z2E07dveantR
         8Qhg==
X-Gm-Message-State: AOAM531xJhR2rvJZw/kDiB2pcCeyMbqTA3TblttbqnlyKLWi3DDzZna7
        qbR761jJLuntBrs7sSTqD3Q=
X-Google-Smtp-Source: ABdhPJxRIf8p/xeRo0ISGGexM1bBEv6iPxznNuiPCRws8lrVQk+QCr+5/1RPN3EyO6HOz5GsSH1T7Q==
X-Received: by 2002:a50:e081:0:b0:401:8823:c9a8 with SMTP id f1-20020a50e081000000b004018823c9a8mr18092848edl.401.1647773681899;
        Sun, 20 Mar 2022 03:54:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm5699993ejp.223.2022.03.20.03.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 03:54:41 -0700 (PDT)
Message-ID: <89f9b797-e4b8-139a-d9e6-ebe71779b943@kernel.org>
Date:   Sun, 20 Mar 2022 11:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to
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
References: <20220319204628.1759635-1-michael@walle.cc>
 <20220319204628.1759635-7-michael@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220319204628.1759635-7-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 21:46, Michael Walle wrote:
> Convert the ocelot-pinctrl device tree binding to the new YAML format.
> 
> Additionally to the original binding documentation, add interrupt
> properties which are optional and already used on several SoCs like
> SparX-5, Luton, Ocelot and LAN966x but were not documented before.
> 
> Also, on the sparx5 and the lan966x SoCs there are two items for the
> reg property.
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
> +
> +  "#interrupt-cells":
> +    const: 2

Thanks for the changes in other files, but I think you did not respond
to my comments here. Can you address them?


Best regards,
Krzysztof
