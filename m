Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE178578C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGRVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiGRVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:10:50 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D93138E;
        Mon, 18 Jul 2022 14:10:49 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id u20so10350109iob.8;
        Mon, 18 Jul 2022 14:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpUuLsV/NZEoKVzCvz3mdd+f2fFBiw12CBsoruMcI+s=;
        b=zuWOqF5YI04M9e82xaM3LnHQ6Mg7TmFV436LJblDOsa2BSVAmKbHqb7t7GEoDuxYL/
         c6kytOTTC0rXiuufdJlNZmM9wc1x1uoJAcqw3m8mQMT4MIBWelTAvGUzrKQVyxRNdfhJ
         GvvjkeIBX708hHcdPRsZPJJlTvhavUewdpNCy0ViilCo2iiN8jV/6Eo3UYqQzhQ9z7Xo
         6FV3nKieZyC7oAmbuTX9Ka0tIJ6EcIs6Z9TwoD6SxYqITMEFtZWPnTLizfWoDE9xd6r1
         S21cc8ea6NW3xiFGzXIEbT98tjj4Ha2HZgygKeSoH7FdH2SnwcGQ923kTXCSdatbzQX/
         Vq/g==
X-Gm-Message-State: AJIora82V6g5WeaO5Z/uLRNcp+1kBCLPWyKXf+j3lr8AE/0D5gTsRnJU
        HBBGdqQHzWxLjyNmGGNx0A==
X-Google-Smtp-Source: AGRyM1ugFb7o8ZwabLbYyAtq1Lvc2rxKJ6evG3Y+xSJ4naWExaHPxTQSqPzdHSM3pptip9e4d4SFrQ==
X-Received: by 2002:a05:6638:2613:b0:33f:eb09:8e08 with SMTP id m19-20020a056638261300b0033feb098e08mr13788459jat.269.1658178648767;
        Mon, 18 Jul 2022 14:10:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bw7-20020a056638460700b00331c58086d8sm5958736jab.147.2022.07.18.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:10:48 -0700 (PDT)
Received: (nullmailer pid 3562214 invoked by uid 1000);
        Mon, 18 Jul 2022 21:10:46 -0000
Date:   Mon, 18 Jul 2022 15:10:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        j.neuschaefer@gmx.net, zhengbin13@huawei.com,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Message-ID: <20220718211046.GA3547663-robh@kernel.org>
References: <20220714122322.63663-1-tmaimon77@gmail.com>
 <20220714122322.63663-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714122322.63663-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:23:21PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> new file mode 100644
> index 000000000000..104766f7acc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM845 Pin Controller and GPIO
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description:
> +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
> +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
> +  and multiple functions that directly connect the pin to different
> +  hardware blocks.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,npcm845-pinctrl
> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  nuvoton,sysgcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to access GCR registers.
> +
> +patternProperties:
> +  "^gpio@":
> +    type: object
> +
> +    description:
> +      Eight GPIO banks that each contain between 32 GPIOs.

'each contain between 32'?

> +
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      gpio-ranges:
> +        maxItems: 1
> +
> +    required:
> +      - gpio-controller
> +      - '#gpio-cells'
> +      - reg
> +      - interrupts
> +      - gpio-ranges
> +
> +  "-mux":

'-mux$'? Something like 'foo-muxbar' is needed?

> +    $ref: pinmux-node.yaml#
> +
> +    properties:
> +      groups:
> +        description:
> +          One or more groups of pins to mux to a certain function
> +        items:
> +          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> +                  smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> +                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> +                  smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> +                  spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> +                  bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> +                  rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> +                  fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> +                  fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> +                  r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> +                  rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> +                  smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> +                  smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> +                  pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> +                  serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> +                  spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> +                  smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> +                  smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> +                  hgpio4, hgpio5, hgpio6, hgpio7 ]
> +
> +      function:
> +        description:
> +          The function that a group of pins is muxed to
> +        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> +                smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> +                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> +                smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> +                spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> +                bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> +                rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> +                fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> +                fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> +                r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> +                rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> +                smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> +                smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> +                pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> +                serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> +                spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> +                smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> +                smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> +                hgpio4, hgpio5, hgpio6, hgpio7 ]
> +
> +    dependencies:
> +      groups: [ function ]
> +      function: [ groups ]
> +
> +    additionalProperties: false
> +
> +  "^pin":
> +    $ref: pincfg-node.yaml#
> +
> +    properties:
> +      pins:
> +        description:
> +          A list of pins to configure in certain ways, such as enabling
> +          debouncing
> +
> +      bias-disable: true
> +
> +      bias-pull-up: true
> +
> +      bias-pull-down: true
> +
> +      input-enable: true
> +
> +      output-low: true
> +
> +      output-high: true
> +
> +      drive-push-pull: true
> +
> +      drive-open-drain: true
> +
> +      input-debounce:
> +        description:
> +          Debouncing periods in microseconds, one period per interrupt
> +          bank found in the controller
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 4
> +
> +      slew-rate:
> +        description: |
> +          0: Low rate
> +          1: High rate
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +      drive-strength:
> +        enum: [ 0, 1, 2, 4, 8, 12 ]
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +  - nuvoton,sysgcr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pinctrl: pinctrl@f0800000 {
> +        compatible = "nuvoton,npcm845-pinctrl";
> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        nuvoton,sysgcr = <&gcr>;
> +
> +        gpio0: gpio@f0010000 {

gpio@0

Is this really a child block of the pinctrl? Doesn't really look like it 
based on addressess. Where are the pinctrl registers? In the sysgcr? If 
so, then pinctrl should be a child of it. But that doesn't really work 
too well with gpio child nodes...

Rob
