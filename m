Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F55500AA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383670AbiFQXUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383598AbiFQXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:19:58 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E468674CA;
        Fri, 17 Jun 2022 16:19:52 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id a10so5958629ioe.9;
        Fri, 17 Jun 2022 16:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/crESimSLz2PKIuHtassqXLrE43lm+c6M6EBrH0uI4o=;
        b=drVwfnmQZnzDQMuusdpjk0zwoyFHLV2+2y45FaW6qqkhaxKEnQHn/AFUIUg/pl5qTA
         oCha5N4jjIEbBV2EJ+PZEG4sXV51rh2JcNLjIe9LPBLpPLuW+wmNVIi5iEeUO1Zn1WSE
         RfZPsxQsFST8AdIjEGpcaBUUHZG2+Eb8I77g4V8tSc3nTX5YysI/ooarZHCWepHNvpta
         Ks9c9sdOvjqcd+eWw6k2RxaW4QDrIXr0xk90dkWUc5c1lXuxu36E5PN5r2eYoapMfZSs
         LLVzuh7YxkpY1tZ2EW4/IzKL85oKwpQfirk3tKKbAq+hrJwIQdNwILNDccf5oFqxt9sB
         U+Ew==
X-Gm-Message-State: AJIora+79M4I7bTFqn5KHtjzuJ+nLCn90QjM4eTcZvgO17HQdq8ZGjo2
        2UYu4Z4OggBCP51qf8VZeA==
X-Google-Smtp-Source: AGRyM1unOGWunO2EfAbWBeq3icSNHgtCgY3RGjLRyleqmzS6wLBurHQ477wfdd4ml3xSivplblwTGQ==
X-Received: by 2002:a05:6638:19c8:b0:331:e614:461 with SMTP id bi8-20020a05663819c800b00331e6140461mr6856926jab.76.1655507991237;
        Fri, 17 Jun 2022 16:19:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e020c2a00b002cde6e352d4sm2870483ilg.30.2022.06.17.16.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:19:50 -0700 (PDT)
Received: (nullmailer pid 2624510 invoked by uid 1000);
        Fri, 17 Jun 2022 23:19:49 -0000
Date:   Fri, 17 Jun 2022 17:19:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, krzk+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Message-ID: <20220617231949.GA2613244-robh@kernel.org>
References: <20220614154245.354167-1-jjhiblot@traphandler.com>
 <20220614154245.354167-2-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614154245.354167-2-jjhiblot@traphandler.com>
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

On Tue, Jun 14, 2022 at 05:42:43PM +0200, Jean-Jacques Hiblot wrote:
> Add bindings documentation for the TLC5925 LED controller.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  .../devicetree/bindings/leds/ti,tlc5925.yaml  | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> new file mode 100644
> index 000000000000..12a71e48f854
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> @@ -0,0 +1,107 @@
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
> +  ti,shift-register-length:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    description: |

Don't need '|' if no formatting to preserve.

> +      The length of the shift register. If several TLC5925 are chained,
> +      shift_register_length should be set to 16 times the number of TLC5925.
> +      The value must be a multiple of 8.

multipleOf: 8

Though I'm confused why it's not 16.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  output-enable-b-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Already has a type.

> +    description: |
> +      Optional GPIO pins to enable/disable the parallel output. They describe
> +      the GPIOs connected to the OE/ pin of the TLC5925s.
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    $ref: common.yaml#

       unevaluatedProperties: false

> +
> +    properties:
> +      reg:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type here.

> +        description: |
> +          LED pin number (must be lower than ti,shift-register-length).
> +          The furthest LED down the chain has the pin number 0.
> +
> +    required:
> +      - reg
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ti,shift-register-length

Is there not a default when not chained? 

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    spi0 {

spi {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        leds@2 {
> +            compatible = "ti,tlc5925";
> +            reg = <0x02>;
> +            spi-max-frequency = <30000000>;
> +            ti,shift-register-length = <32>;
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
