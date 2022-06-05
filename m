Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9353DED8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbiFEXAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFEXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:00:39 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01E4D62E;
        Sun,  5 Jun 2022 16:00:38 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so9647567otq.1;
        Sun, 05 Jun 2022 16:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cuos8gspcI8YFcAvEdhtAno3qJ/kq97L2Lmz0j3/73g=;
        b=o+p/CD7K3vTrtujbiekwl99V5ztUE5ezj5JNJQ/LZypoQLeiyZNEtYafkuNazpCRsr
         GaQ6hRQb3l99GifS5mDKdtLRJCTAGlb+4xN7TDBUrt6xJ3IV9MOBUjCQBUC2WDdA6HlW
         MmXSh/Z8moQHJK6WxGUXfO8sAmictwq+D16OoQLrR1OplMoE7fyac0+OLZbJu/EQqgQL
         znDLiOcGIKr+vk5huHc5D7qS11Qc6WNnUOgcDBwd4AokU1a5JbwShXC8gCkucUA42CMC
         BOQT0APOODij9biXhRJk+2scaUmaIu+82s5gtJAt6ObcjaIARPsthjk4+EwKzzpwUiJI
         RsJA==
X-Gm-Message-State: AOAM5338pUdY8xWp6yPM726KnEZtA2YoNGOati4UIBESi7KLvHXkuEhO
        HaGZe7RmErYkuzcop2TV6A==
X-Google-Smtp-Source: ABdhPJznM9+rNipHLJAjX2e4WzlxR5Zn3vCxW/fLOCOCn6Ty6pXQW+geIqZSW8hxsAkTqqcwkkBjjw==
X-Received: by 2002:a9d:69da:0:b0:60b:1218:19ba with SMTP id v26-20020a9d69da000000b0060b121819bamr8646715oto.92.1654470038148;
        Sun, 05 Jun 2022 16:00:38 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056808301f00b00328c9e63389sm7675173oib.11.2022.06.05.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 16:00:37 -0700 (PDT)
Received: (nullmailer pid 3689236 invoked by uid 1000);
        Sun, 05 Jun 2022 23:00:34 -0000
Date:   Sun, 5 Jun 2022 18:00:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, krzk+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Message-ID: <20220605230034.GA3683670-robh@kernel.org>
References: <20220603155332.112272-1-jjhiblot@traphandler.com>
 <20220603155332.112272-2-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603155332.112272-2-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:53:30PM +0200, Jean-Jacques Hiblot wrote:
> Add bindings documentation for the TLC5925 LED controller.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  .../devicetree/bindings/leds/ti,tlc5925.yaml  | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> new file mode 100644
> index 000000000000..379ade094fd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/ti,tlc5925.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LEDs connected to TI TLC5925 controller
> +
> +maintainers:
> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> +
> +description: |
> +  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
> +  It is controlled through a SPI interface.
> +  It is built around a shift register and latches which convert serial
> +  input data into a parallel output. Several TLC5925 can be chained to
> +  control more than 16 LEDs with a single chip-select.
> +  The brightness level cannot be controlled, each LED is either on or off.
> +
> +  Each LED is represented as a sub-node of the ti,tlc5925 device.
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,tlc5925
> +
> +  shift-register-length:

Not a common property. Needs a vendor prefix and type.

> +    minimum: 8
> +    description: |
> +      The length of the shift register. If several TLC5925 are chained,
> +      shift_register_length should be set to 16 times the number of TLC5925.
> +      The value must be a multiple of 8.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  output-enable-b-gpios:
> +    description: |
> +      Optional GPIO pins to enable/disable the parallel output. They describe
> +      the GPIOs connected to the OE/ pin of the TLC5925s.
> +
> +patternProperties:
> +  "@[0-9a-z]+$":

Unit addresses are typically hex (a-f).

> +    type: object
> +    $ref: common.yaml#
> +
> +    description: |
> +      LED pin number (must be lower than shift_register_length).
> +      The furthest LED down the chain has the pin number 0.
> +
> +    properties:
> +      reg:
> +        minimum: 0

0 is always the minimum.

> +
> +    required:
> +      - reg
> +
> +additionalProperties: true

Not allowed except for common schemas. Must be false. Since you have a 
$ref, you probably want 'unevaluatedProperties: false' instead.


> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - shift_register_length
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        leds@2 {
> +            compatible = "ti,tlc5925";
> +            reg = <0x02>;
> +            spi-max-frequency = <30000000>;
> +            shift_register_length = <32>;
> +            output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            led@0 {
> +                reg = <0>;
> +                function = LED_FUNCTION_STATUS;
> +                color = <LED_COLOR_ID_GREEN>;
> +            };
> +
> +            led@4 {
> +                reg = <4>;
> +                function = LED_FUNCTION_STATUS;
> +                color = <LED_COLOR_ID_RED>;
> +            };
> +
> +            led@1f {
> +                reg = <31>;
> +                function = LED_FUNCTION_PANIC;
> +                color = <LED_COLOR_ID_RED>;
> +            };
> +        };
> +
> +    };
> -- 
> 2.25.1
> 
> 
