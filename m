Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02C57161C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiGLJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiGLJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:48:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9EAA2EE6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:48:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so13045080lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/uH8F4Kby+JXg7Mpe1L96lV/BObBUJ58/FjGSd2zwrI=;
        b=GHOwDC5960hhrGAi98lxdFsoVxYhQ2I/DQd5NEQZVKWyX92WrTsf8t2uM3S5O5Pasz
         EaPxmoLo+up67H/T1lw9SK2ICPtDIXbpnFpjwJEtiMkaxLplr6Ne1TOqGXTgTi8dkiJA
         Y+POzrid5V/l1fFk3bQz7NlKDjxL0IasYJ/SW4GtFYSRTmqGaVUb5ssUlJPMjQEp0dX2
         QuR/+sJhEfI6EpUkJFI81oMNUs+Zf4ivdtf7J/KU5ISvA1qtBbwfx5fjRbkU6DYVeBma
         +Chaapuv217t3WUW1yU+2nFRqqg5WTThyOJWMsUVHxYikwNKEpGEhL7fhgjQVQCcgH6f
         yB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/uH8F4Kby+JXg7Mpe1L96lV/BObBUJ58/FjGSd2zwrI=;
        b=p62sR6cvyJ8JSR1EbKrvHxExCzUlycQZ+xvtC5BLLaqeGKtZsjtd8QUxdkEti75Nbw
         Z3+WchTc9SE9ly8lDM3DL6Zog3Isjh/GefQ5Tu4coWmSqU1C1utKOFkoGZvniSkjTvzK
         2PEBrj5r4jC1+2ECFtrM6xsYEDYt4SZloqFwuRN6IC53rW4Cor6Mdjyl4if0ybYeEXd9
         hVvlvKT4of/6sw2VaSPJn6ars/GpUbTxKOPA/gi7lHw74MYIorI47h4VqDvGQfiZksKx
         SLOcqjuxsoV4U+k/fnJhQ3H843goGIga5UYErsFjom4uOlIqjsxPtm0nyMAYpgILy+AC
         2bZQ==
X-Gm-Message-State: AJIora+G2Nyz/CFEM0Gg8zeGioTW2sgDVKhNuGvKgpI5kpyQjJgASa3P
        7QGn96YmgJzeN1Juad3A4sCChg==
X-Google-Smtp-Source: AGRyM1uRD8Jy2As78zbcShpLvk3bPyap8hDx7k+p73eBuiJheG1Djr3s1kq+1523oqqWLjtGEhb0lQ==
X-Received: by 2002:a05:6512:3b91:b0:489:e63f:47b1 with SMTP id g17-20020a0565123b9100b00489e63f47b1mr4117169lfv.410.1657619333888;
        Tue, 12 Jul 2022 02:48:53 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s3-20020ac24643000000b0047255d2111csm2073378lfo.75.2022.07.12.02.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:48:53 -0700 (PDT)
Message-ID: <8b1393e4-275b-6791-ad71-2edfeacd0a63@linaro.org>
Date:   Tue, 12 Jul 2022 11:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220710102110.39748-1-tmaimon77@gmail.com>
 <20220710102110.39748-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710102110.39748-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2022 12:21, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 205 ++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> new file mode 100644
> index 000000000000..6395ef2bf5b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> @@ -0,0 +1,205 @@
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

ranges without reg? Does it even work? Did you test the bindings?

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^gpio@":
> +    type: object
> +
> +    description:
> +      Eight GPIO banks that each contain between 32 GPIOs.
> +
> +    properties:
> +

No blank line.

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
> +  "-pin":
> +    $ref: pinmux-node.yaml#

Shouldn't this be under bank?

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

This is almost the same as previous property. Confusing and I think it
does not work.

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
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'

Missing allOf with ref to pinctrl.yaml.

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
> +
> +        gpio0: gpio@f0010000 {
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          reg = <0x0 0xB0>;
> +          interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +          gpio-ranges = <&pinctrl 0 0 32>;
> +        };
> +
> +        fanin0_pin: fanin0-pin {
> +          groups = "fanin0";
> +          function = "fanin0";
> +        };
> +
> +        pin34_slew: pin34-slew {

and how does it pass your checks?

Did you test the bindings?



Best regards,
Krzysztof
