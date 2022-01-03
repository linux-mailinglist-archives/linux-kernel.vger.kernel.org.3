Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E7F48384C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiACVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiACVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:19:56 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212AC061792
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:19:55 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id y4so3012886uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK8vUKjefX4V+QEcjSy/gyOu0i5yacuW++2f0k6UNoo=;
        b=C06jho+qfyogxVzULzOqaOQd/F3JBJ58PLssf96XY5fAOf1MvYHuZVOfKzQ4cG9WFv
         VaUoBosngZqtAQ54OX/5oYAf/ooc33/C0glhs43yP+UDRhd6NEDmwbOb3v76jxz3/cwS
         5qieec5Mkb0XBMhpjO3fgYeMIBs0Pp+DFJnjQL2uQE9mTZwPIzesdKBalwg82OqV2V95
         uNbEcxSbrI1MYVUDUUNYm5vXSxiPVGGqw81Xx2O6N4F9/X+gpBc029H867m802p0sfyx
         GlY6zS4/9aWryBxeSFwqDx/dPw/GFyGYv5pxHDC5SuzZWtPsWo1PdpK6OJRSfnFW5Gbx
         A1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK8vUKjefX4V+QEcjSy/gyOu0i5yacuW++2f0k6UNoo=;
        b=ev3T+nXNedQokLoulqd0j69M3pE82EE1L1rPzNyHwBV7CoQPqlqDGJRewdF0GQLLHK
         tOUFIbW9nxDvcIK8XQwlnk/t2GfQC/sCjCZhsoK5rGWOrhrC4NKrpwoc6JTO3QzNFne3
         mKgJ5rzkWJm9uyB3zfMWTJHkSsEsE5wbC5rMZ7tUgG2sbSc/e+Tl6I2/ULtkVVG9uwnz
         PFocrNrId+qKLuPgnWfFfUhLjgB37GhRGugU5EUVvN+BpEhmlxhUP4WseGuO6PsVErts
         9lxozYco4l3aRJ6pNBWysW/CQjJ1YyeafDNPn2LbTDDa0FUY6V32W2MeHFMfx6LXvvEK
         tAjg==
X-Gm-Message-State: AOAM531IhuLgF+Nr66QPb+fyMzfGaicdcPLdTPfSMPl5j7xcg/ovk9rz
        D6rLCe7chIz0VHRBj0CvJGSXu7tjvsRti7hF7kKofw==
X-Google-Smtp-Source: ABdhPJwfFn0cpf44wj6UumLoL8R5m+KKN9jkQ5ZNFKO0pB0CFI0BiRplId+PuzZLHYjp6kQDOST+gK1Ol2dobtmeuMw=
X-Received: by 2002:ab0:2b8d:: with SMTP id q13mr14721340uar.139.1641244794569;
 Mon, 03 Jan 2022 13:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231162309.257587-7-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231162309.257587-7-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 3 Jan 2022 23:19:41 +0200
Message-ID: <CAPLW+4kbn9-gCOy3f_ykVN_fbrKvQkYHR_wwj=4ETLS1PHKNFQ@mail.gmail.com>
Subject: Re: [PATCH 24/24] dt-bindings: pinctrl: samsung: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 at 18:23, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) pin
> controller bindings to DT schema format.  Parts of description and DTS
> example was copied from existing sources, so keep the license as
> GPL-2.0-only.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Kudos for doing that, converting and splitting. It's fascinating how
time consuming that bindings conversion work can be (at least for me,
hehe).

>  .../pinctrl/samsung,pinctrl-gpio-bank.yaml    |  52 +++
>  .../pinctrl/samsung,pinctrl-pins-cfg.yaml     |  81 ++++
>  .../samsung,pinctrl-wakeup-interrupt.yaml     |  76 ++++
>  .../bindings/pinctrl/samsung,pinctrl.yaml     | 381 +++++++++++++++++
>  .../bindings/pinctrl/samsung-pinctrl.txt      | 383 ------------------
>  MAINTAINERS                                   |   2 +-
>  6 files changed, 591 insertions(+), 384 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
> new file mode 100644
> index 000000000000..f73348c54748
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/samsung,pinctrl-gpio-bank.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C/S5P/Exynos SoC pin controller - gpio bank
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +  - Tomasz Figa <tomasz.figa@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Samsung S3C/S5P/Exynos SoC pin
> +  controller.
> +
> +  GPIO bank description for Samsung S3C/S5P/Exynos SoC pin controller.
> +
> +  See also Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml for
> +  additional information and example.
> +
> +properties:
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#interrupt-cells':
> +    description:
> +      For GPIO banks supporting external GPIO interrupts or external wake-up
> +      interrupts.
> +    const: 2
> +
> +  interrupt-controller:
> +    description:
> +      For GPIO banks supporting external GPIO interrupts or external wake-up
> +      interrupts.
> +
> +  interrupts:
> +    description:
> +      For GPIO banks supporting direct external wake-up interrupts (without
> +      multiplexing).  Number of interrupts must match number of wake-up capable
> +      pins of this bank.
> +    minItems: 1
> +    maxItems: 8
> +
> +required:
> +  - '#gpio-cells'
> +  - gpio-controller
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
> new file mode 100644
> index 000000000000..637f4c05b344
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/samsung,pinctrl-pins-cfg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C/S5P/Exynos SoC pin controller - pins configuration
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +  - Tomasz Figa <tomasz.figa@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Samsung S3C/S5P/Exynos SoC pin
> +  controller.
> +
> +  Pins configuration for Samsung S3C/S5P/Exynos SoC pin controller.
> +
> +  See also Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml for
> +  additional information and example.
> +
> +  The values used for config properties should be derived from the hardware
> +  manual and these values are programmed as-is into the pin pull up/down and
> +  driver strength register of the pin-controller.
> +  See also include/dt-bindings/pinctrl/samsung.h with useful constants.
> +
> +properties:
> +  samsung,pins:
> +    description: |
> +      List of pins to configure. For initial and sleep states, the maximum
> +      number is one pin. In other cases there is no upper limit.
> +
> +      The pins should use lowercase names matching hardware manual, e.g. for
> +      GPA0 bank: gpa0-0, gpa0-1, gpa0-2.
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  samsung,pin-function:
> +    description: |
> +      The pin function selection that should be applied on the pins listed in the
> +      child node is specified using the "samsung,pin-function" property. The value
> +      of this property that should be applied to each of the pins listed in the
> +      "samsung,pins" property should be picked from the hardware manual of the SoC
> +      for the specified pin group. This property is optional in the child node if
> +      no specific function selection is desired for the pins listed in the child
> +      node. The value of this property is used as-is to program the pin-controller
> +      function selector register of the pin-bank.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +
> +  samsung,pin-drv:
> +    description: Drive strength configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +
> +  samsung,pin-pud:
> +    description: Pull up/down configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  samsung,pin-val:
> +    description: Initial value of pin output buffer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  samsung,pin-con-pdn:
> +    description: Function in power down mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  samsung,pin-pud-pdn:
> +    description: Pull up/down configuration in power down mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +required:
> +  - samsung,pins
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> new file mode 100644
> index 000000000000..eac56a087643
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C/S5P/Exynos SoC pin controller - wakeup interrupt controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +  - Tomasz Figa <tomasz.figa@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Samsung S3C/S5P/Exynos SoC pin
> +  controller.
> +
> +  External wake-up interrupts for Samsung S3C/S5P/Exynos SoC pin controller.
> +  Only one pin-controller device node can include external wakeup interrupts
> +  child node (in other words, only one External wake-up interrupts
> +  pin-controller is supported).
> +
> +  See also Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s3c2410-wakeup-eint
> +      - samsung,s3c2412-wakeup-eint
> +      - samsung,s3c64xx-wakeup-eint
> +      - samsung,s5pv210-wakeup-eint
> +      - samsung,exynos4210-wakeup-eint
> +      - samsung,exynos7-wakeup-eint
> +
> +  interrupts:
> +    description:
> +      Interrupt used by multiplexed external wake-up interrupts.
> +    minItems: 1
> +    maxItems: 6
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s3c2410-wakeup-eint
> +              - samsung,s3c2412-wakeup-eint
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 6
> +          maxItems: 6
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: samsung,s3c64xx-wakeup-eint
> +      then:
> +        properties:
> +          interrupts:
> +            minItems: 4
> +            maxItems: 4
> +      else:
> +        properties:
> +          interrupts:
> +            minItems: 1
> +            maxItems: 1
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
> new file mode 100644
> index 000000000000..37cd03805cab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
> @@ -0,0 +1,381 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/samsung,pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C/S5P/Exynos SoC pin controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +  - Tomasz Figa <tomasz.figa@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Samsung S3C/S5P/Exynos SoC pin
> +  controller.
> +
> +  Pin group settings (like drive strength, pull up/down) are available as
> +  macros in include/dt-bindings/pinctrl/samsung.h.
> +
> +  All the pin controller nodes should be represented in the aliases node using
> +  the following format 'pinctrl{n}' where n is a unique number for the alias.
> +
> +properties:
> +  $nodename:
> +    pattern: "^pinctrl(@.*)?"
> +
> +  compatible:
> +    enum:
> +      - samsung,s3c2412-pinctrl
> +      - samsung,s3c2416-pinctrl
> +      - samsung,s3c2440-pinctrl
> +      - samsung,s3c2450-pinctrl
> +      - samsung,s3c64xx-pinctrl
> +      - samsung,s5pv210-pinctrl
> +      - samsung,exynos3250-pinctrl
> +      - samsung,exynos4210-pinctrl
> +      - samsung,exynos4x12-pinctrl
> +      - samsung,exynos5250-pinctrl
> +      - samsung,exynos5260-pinctrl
> +      - samsung,exynos5410-pinctrl
> +      - samsung,exynos5420-pinctrl
> +      - samsung,exynos5433-pinctrl
> +      - samsung,exynos7-pinctrl
> +      - samsung,exynos7885-pinctrl
> +      - samsung,exynos850-pinctrl
> +      - samsung,exynosautov9-pinctrl
> +
> +  interrupts:
> +    description:
> +      Required for GPIO banks supporting external GPIO interrupts.
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  reg:
> +    description:
> +      Second base address of the pin controller if the specific registers of
> +      the pin controller are separated into the different base address.
> +      Only certain banks of certain pin controller might need it.
> +    minItems: 1
> +    maxItems: 2
> +
> +  wakeup-interrupt-controller:
> +    $ref: samsung,pinctrl-wakeup-interrupt.yaml
> +
> +patternProperties:
> +  "^[a-z]+[0-9]*-gpio-bank$":
> +    description:
> +      Pin banks of the controller are represented by child nodes of the
> +      controller node. Bank name is taken from name of the node.
> +    $ref: samsung,pinctrl-gpio-bank.yaml
> +
> +  "^[a-z0-9-]+-pins$":
> +    oneOf:
> +      - $ref: samsung,pinctrl-pins-cfg.yaml
> +        required:
> +          - samsung,pins
> +      - type: object
> +        patternProperties:
> +          "^[a-z0-9-]+-pins$":
> +            $ref: samsung,pinctrl-pins-cfg.yaml
> +
> +        additionalProperties: false
> +
> +  "^(initial|sleep)-state$":
> +    patternProperties:
> +      "^(pin-[a-z0-9-]+|[a-z0-9-]+-pin)$":
> +        $ref: samsung,pinctrl-pins-cfg.yaml
> +
> +        properties:
> +          samsung,pins:
> +            description: See samsung,pinctrl-pins-cfg.yaml
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            maxItems: 1
> +
> +        required:
> +          - samsung,pins
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos5433-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 2
> +    else:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/samsung.h>
> +
> +    pinctrl@7f008000 {
> +        compatible = "samsung,s3c64xx-pinctrl";
> +        reg = <0x7f008000 0x1000>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <21>;
> +
> +        wakeup-interrupt-controller {
> +            compatible = "samsung,s3c64xx-wakeup-eint";
> +            interrupts-extended = <&vic0 0>,
> +                                  <&vic0 1>,
> +                                  <&vic1 0>,
> +                                  <&vic1 1>;
> +        };
> +
> +        /* Pin bank with external GPIO or muxed external wake-up interrupts */
> +        gpa-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        // ...
> +
> +        uart0-data-pins {
> +            samsung,pins = "gpa-0", "gpa-1";
> +            samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +            samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +        };
> +
> +        // ...
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/samsung.h>
> +
> +    pinctrl@11400000 {
> +        compatible = "samsung,exynos4210-pinctrl";
> +        reg = <0x11400000 0x1000>;
> +        interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&sleep0>;
> +
> +        /* Pin bank with external GPIO or muxed external wake-up interrupts */
> +        gpa0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        // ...
> +
> +        uart0-data-pins {
> +            samsung,pins = "gpa0-0", "gpa0-1";
> +            samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +            samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +            samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +        };
> +
> +        // ...
> +
> +        sleep0: sleep-state {
> +            gpa0-0-pin {
> +                samsung,pins = "gpa0-0";
> +                samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
> +                samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
> +            };
> +
> +            gpa0-1-pin {
> +                samsung,pins = "gpa0-1";
> +                samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT0>;
> +                samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
> +            };
> +
> +            // ...
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/samsung.h>
> +
> +    pinctrl@11000000 {
> +        compatible = "samsung,exynos4210-pinctrl";
> +        reg = <0x11000000 0x1000>;
> +        interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        wakeup-interrupt-controller {
> +            compatible = "samsung,exynos4210-wakeup-eint";
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        /* Pin bank with external GPIO or muxed external wake-up interrupts */
> +        gpj0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        /* Pin bank without external interrupts */
> +        gpy0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +
> +        /* Pin bank with external direct wake-up interrupts */
> +        gpx0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        // ...
> +
> +        sd0-clk-pins {
> +            samsung,pins = "gpk0-0";
> +            samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +            samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +            samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> +        };
> +
> +        sd4-bus-width8-pins {
> +            part-1-pins {
> +                samsung,pins = "gpk0-3", "gpk0-4",
> +                               "gpk0-5", "gpk0-6";
> +                samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +                samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +                samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> +            };
> +
> +            part-2-pins {
> +                samsung,pins = "gpk1-3", "gpk1-4",
> +                               "gpk1-5", "gpk1-6";
> +                samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +                samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +                samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> +            };
> +        };
> +
> +        // ...
> +
> +        otg-gp-pins {
> +            samsung,pins = "gpx3-3";
> +            samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +            samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +            samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +            samsung,pin-val = <0>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/samsung.h>
> +
> +    pinctrl@10580000 {
> +        compatible = "samsung,exynos5433-pinctrl";
> +        reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&initial_alive>;
> +
> +        wakeup-interrupt-controller {
> +            compatible = "samsung,exynos7-wakeup-eint";
> +            interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        /* Pin bank with external direct wake-up interrupts */
> +        gpa0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        // ...
> +
> +        te-irq-pins {
> +            samsung,pins = "gpf1-3";
> +            samsung,pin-function = <0xf>;
> +        };
> +
> +        // ..
> +
> +        initial_alive: initial-state {
> +            gpa0-0-pin {
> +                samsung,pins = "gpa0-0";
> +                samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +                samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +                samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
> +            };
> +
> +            // ...
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/samsung.h>
> +
> +    pinctrl@114b0000 {
> +        compatible = "samsung,exynos5433-pinctrl";
> +        reg = <0x114b0000 0x1000>;
> +        interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&pd_aud>;
> +
> +        /* Pin bank with external GPIO or muxed external wake-up interrupts */
> +        gpz0-gpio-bank {
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +
> +        // ...
> +
> +        i2s0-bus-pins {
> +            samsung,pins = "gpz0-0", "gpz0-1", "gpz0-2", "gpz0-3",
> +                           "gpz0-4", "gpz0-5", "gpz0-6";
> +            samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +            samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +            samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
> +        };
> +
> +        // ...
> +    };
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> deleted file mode 100644
> index 9e70edceb21b..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ /dev/null
> @@ -1,383 +0,0 @@
> -Samsung GPIO and Pin Mux/Config controller
> -
> -Samsung's ARM based SoC's integrates a GPIO and Pin mux/config hardware
> -controller. It controls the input/output settings on the available pads/pins
> -and also provides ability to multiplex and configure the output of various
> -on-chip controllers onto these pads.
> -
> -Required Properties:
> -- compatible: should be one of the following.
> -  - "samsung,s3c2412-pinctrl": for S3C2412-compatible pin-controller,
> -  - "samsung,s3c2416-pinctrl": for S3C2416-compatible pin-controller,
> -  - "samsung,s3c2440-pinctrl": for S3C2440-compatible pin-controller,
> -  - "samsung,s3c2450-pinctrl": for S3C2450-compatible pin-controller,
> -  - "samsung,s3c64xx-pinctrl": for S3C64xx-compatible pin-controller,
> -  - "samsung,s5pv210-pinctrl": for S5PV210-compatible pin-controller,
> -  - "samsung,exynos3250-pinctrl": for Exynos3250 compatible pin-controller.
> -  - "samsung,exynos4210-pinctrl": for Exynos4210 compatible pin-controller.
> -  - "samsung,exynos4x12-pinctrl": for Exynos4x12 compatible pin-controller.
> -  - "samsung,exynos5250-pinctrl": for Exynos5250 compatible pin-controller.
> -  - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
> -  - "samsung,exynos5410-pinctrl": for Exynos5410 compatible pin-controller.
> -  - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
> -  - "samsung,exynos5433-pinctrl": for Exynos5433 compatible pin-controller.
> -  - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
> -  - "samsung,exynos7885-pinctrl": for Exynos7885 compatible pin-controller.
> -  - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
> -  - "samsung,exynosautov9-pinctrl": for ExynosAutov9 compatible pin-controller.
> -
> -- reg: Base address of the pin controller hardware module and length of
> -  the address space it occupies.
> -
> -  - reg: Second base address of the pin controller if the specific registers
> -  of the pin controller are separated into the different base address.
> -
> -       Eg: GPF[1-5] of Exynos5433 are separated into the two base address.
> -       - First base address is for GPAx and GPF[1-5] external interrupt
> -         registers.
> -       - Second base address is for GPF[1-5] pinctrl registers.
> -
> -       pinctrl_0: pinctrl@10580000 {
> -               compatible = "samsung,exynos5433-pinctrl";
> -               reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
> -
> -               wakeup-interrupt-controller {
> -                       compatible = "samsung,exynos7-wakeup-eint";
> -                       interrupts = <0 16 0>;
> -               };
> -       };
> -
> -- Pin banks as child nodes: Pin banks of the controller are represented by child
> -  nodes of the controller node. Bank name is taken from name of the node. Each
> -  bank node must contain following properties:
> -
> -  - gpio-controller: identifies the node as a gpio controller and pin bank.
> -  - #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> -    binding is used, the amount of cells must be specified as 2. See the below
> -    mentioned gpio binding representation for description of particular cells.
> -
> -       Eg: <&gpx2 6 0>
> -       <[phandle of the gpio controller node]
> -       [pin number within the gpio controller]
> -       [flags]>
> -
> -       Values for gpio specifier:
> -       - Pin number: is a value between 0 to 7.
> -       - Flags: 0 - Active High
> -                1 - Active Low
> -
> -- Pin mux/config groups as child nodes: The pin mux (selecting pin function
> -  mode) and pin config (pull up/down, driver strength) settings are represented
> -  as child nodes of the pin-controller node. There should be at least one
> -  child node and there is no limit on the count of these child nodes. It is
> -  also possible for a child node to consist of several further child nodes
> -  to allow grouping multiple pinctrl groups into one. The format of second
> -  level child nodes is exactly the same as for first level ones and is
> -  described below.
> -
> -  The child node should contain a list of pin(s) on which a particular pin
> -  function selection or pin configuration (or both) have to applied. This
> -  list of pins is specified using the property name "samsung,pins". There
> -  should be at least one pin specified for this property and there is no upper
> -  limit on the count of pins that can be specified. The pins are specified
> -  using pin names which are derived from the hardware manual of the SoC. As
> -  an example, the pins in GPA0 bank of the pin controller can be represented
> -  as "gpa0-0", "gpa0-1", "gpa0-2" and so on. The names should be in lower case.
> -  The format of the pin names should be (as per the hardware manual)
> -  "[pin bank name]-[pin number within the bank]".
> -
> -  The pin function selection that should be applied on the pins listed in the
> -  child node is specified using the "samsung,pin-function" property. The value
> -  of this property that should be applied to each of the pins listed in the
> -  "samsung,pins" property should be picked from the hardware manual of the SoC
> -  for the specified pin group. This property is optional in the child node if
> -  no specific function selection is desired for the pins listed in the child
> -  node. The value of this property is used as-is to program the pin-controller
> -  function selector register of the pin-bank.
> -
> -  The child node can also optionally specify one or more of the pin
> -  configuration that should be applied on all the pins listed in the
> -  "samsung,pins" property of the child node. The following pin configuration
> -  properties are supported.
> -
> -  - samsung,pin-val: Initial value of pin output buffer.
> -  - samsung,pin-pud: Pull up/down configuration.
> -  - samsung,pin-drv: Drive strength configuration.
> -  - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
> -  - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
> -
> -  The values specified by these config properties should be derived from the
> -  hardware manual and these values are programmed as-is into the pin
> -  pull up/down and driver strength register of the pin-controller.
> -
> -  Note: A child should include at least a pin function selection property or
> -  pin configuration property (one or more) or both.
> -
> -  The client nodes that require a particular pin function selection and/or
> -  pin configuration should use the bindings listed in the "pinctrl-bindings.txt"
> -  file.
> -
> -External GPIO and Wakeup Interrupts:
> -
> -The controller supports two types of external interrupts over gpio. The first
> -is the external gpio interrupt and second is the external wakeup interrupts.
> -The difference between the two is that the external wakeup interrupts can be
> -used as system wakeup events.
> -
> -A. External GPIO Interrupts: For supporting external gpio interrupts, the
> -   following properties should be specified in the pin-controller device node.
> -
> -   - interrupts: interrupt specifier for the controller. The format and value of
> -     the interrupt specifier depends on the interrupt parent for the controller.
> -
> -   In addition, following properties must be present in node of every bank
> -   of pins supporting GPIO interrupts:
> -
> -   - interrupt-controller: identifies the controller node as interrupt-parent.
> -   - #interrupt-cells: the value of this property should be 2.
> -     - First Cell: represents the external gpio interrupt number local to the
> -       external gpio interrupt space of the controller.
> -     - Second Cell: flags to identify the type of the interrupt
> -       - 1 = rising edge triggered
> -       - 2 = falling edge triggered
> -       - 3 = rising and falling edge triggered
> -       - 4 = high level triggered
> -       - 8 = low level triggered
> -
> -B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
> -   child node representing the external wakeup interrupt controller should be
> -   included in the pin-controller device node.
> -
> -   Only one pin-controller device node can include external wakeup interrupts
> -   child node (in other words, only one External Wakeup Interrupts
> -   pin-controller is supported).
> -
> -   This child node should include following properties:
> -
> -   - compatible: identifies the type of the external wakeup interrupt controller
> -     The possible values are:
> -     - samsung,s3c2410-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung S3C24xx SoCs except S3C2412 and S3C2413,
> -     - samsung,s3c2412-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung S3C2412 and S3C2413 SoCs,
> -     - samsung,s3c64xx-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung S3C64xx SoCs,
> -     - samsung,s5pv210-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung S5Pv210 SoCs,
> -     - samsung,exynos4210-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung Exynos4210 and S5PC110/S5PV210 SoCs.
> -     - samsung,exynos7-wakeup-eint: represents wakeup interrupt controller
> -       found on Samsung Exynos7 SoC.
> -   - interrupts: interrupt used by multiplexed wakeup interrupts.
> -
> -   In addition, following properties must be present in node of every bank
> -   of pins supporting wake-up interrupts:
> -
> -   - interrupt-controller: identifies the node as interrupt-parent.
> -   - #interrupt-cells: the value of this property should be 2
> -     - First Cell: represents the external wakeup interrupt number local to
> -       the external wakeup interrupt space of the controller.
> -     - Second Cell: flags to identify the type of the interrupt
> -       - 1 = rising edge triggered
> -       - 2 = falling edge triggered
> -       - 3 = rising and falling edge triggered
> -       - 4 = high level triggered
> -       - 8 = low level triggered
> -
> -   Node of every bank of pins supporting direct wake-up interrupts (without
> -   multiplexing) must contain following properties:
> -
> -   - interrupts: interrupts of the interrupt parent which are used for external
> -     wakeup interrupts from pins of the bank, must contain interrupts for all
> -     pins of the bank.
> -
> -Aliases:
> -
> -All the pin controller nodes should be represented in the aliases node using
> -the following format 'pinctrl{n}' where n is a unique number for the alias.
> -
> -Aliases for controllers compatible with "samsung,exynos7-pinctrl":
> -- pinctrl0: pin controller of ALIVE block,
> -- pinctrl1: pin controller of BUS0 block,
> -- pinctrl2: pin controller of NFC block,
> -- pinctrl3: pin controller of TOUCH block,
> -- pinctrl4: pin controller of FF block,
> -- pinctrl5: pin controller of ESE block,
> -- pinctrl6: pin controller of FSYS0 block,
> -- pinctrl7: pin controller of FSYS1 block,
> -- pinctrl8: pin controller of BUS1 block,
> -- pinctrl9: pin controller of AUDIO block,
> -
> -Example: A pin-controller node with pin banks:
> -
> -       pinctrl_0: pinctrl@11400000 {
> -               compatible = "samsung,exynos4210-pinctrl";
> -               reg = <0x11400000 0x1000>;
> -               interrupts = <0 47 0>;
> -
> -               /* ... */
> -
> -               /* Pin bank without external interrupts */
> -               gpy0: gpy0 {
> -                       gpio-controller;
> -                       #gpio-cells = <2>;
> -               };
> -
> -               /* ... */
> -
> -               /* Pin bank with external GPIO or muxed wake-up interrupts */
> -               gpj0: gpj0 {
> -                       gpio-controller;
> -                       #gpio-cells = <2>;
> -
> -                       interrupt-controller;
> -                       #interrupt-cells = <2>;
> -               };
> -
> -               /* ... */
> -
> -               /* Pin bank with external direct wake-up interrupts */
> -               gpx0: gpx0 {
> -                       gpio-controller;
> -                       #gpio-cells = <2>;
> -
> -                       interrupt-controller;
> -                       interrupt-parent = <&gic>;
> -                       interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
> -                                    <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>;
> -                       #interrupt-cells = <2>;
> -               };
> -
> -               /* ... */
> -       };
> -
> -Example 1: A pin-controller node with pin groups.
> -
> -       #include <dt-bindings/pinctrl/samsung.h>
> -
> -       pinctrl_0: pinctrl@11400000 {
> -               compatible = "samsung,exynos4210-pinctrl";
> -               reg = <0x11400000 0x1000>;
> -               interrupts = <0 47 0>;
> -
> -               /* ... */
> -
> -               uart0_data: uart0-data {
> -                       samsung,pins = "gpa0-0", "gpa0-1";
> -                       samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> -                       samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -                       samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> -               };
> -
> -               uart0_fctl: uart0-fctl {
> -                       samsung,pins = "gpa0-2", "gpa0-3";
> -                       samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> -                       samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -                       samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> -               };
> -
> -               uart1_data: uart1-data {
> -                       samsung,pins = "gpa0-4", "gpa0-5";
> -                       samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> -                       samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -                       samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> -               };
> -
> -               uart1_fctl: uart1-fctl {
> -                       samsung,pins = "gpa0-6", "gpa0-7";
> -                       samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> -                       samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -                       samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> -               };
> -
> -               i2c2_bus: i2c2-bus {
> -                       samsung,pins = "gpa0-6", "gpa0-7";
> -                       samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> -                       samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> -                       samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> -               };
> -
> -               sd4_bus8: sd4-bus-width8 {
> -                       part-1 {
> -                               samsung,pins = "gpk0-3", "gpk0-4",
> -                                               "gpk0-5", "gpk0-6";
> -                               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> -                               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> -                               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> -                       };
> -                       part-2 {
> -                               samsung,pins = "gpk1-3", "gpk1-4",
> -                                               "gpk1-5", "gpk1-6";
> -                               samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> -                               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> -                               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> -                       };
> -               };
> -       };
> -
> -Example 2: A pin-controller node with external wakeup interrupt controller node.
> -
> -       pinctrl_1: pinctrl@11000000 {
> -               compatible = "samsung,exynos4210-pinctrl";
> -               reg = <0x11000000 0x1000>;
> -               interrupts = <0 46 0>
> -
> -               /* ... */
> -
> -               wakeup-interrupt-controller {
> -                       compatible = "samsung,exynos4210-wakeup-eint";
> -                       interrupt-parent = <&gic>;
> -                       interrupts = <0 32 0>;
> -               };
> -       };
> -
> -Example 3: A uart client node that supports 'default' and 'flow-control' states.
> -
> -       uart@13800000 {
> -               compatible = "samsung,exynos4210-uart";
> -               reg = <0x13800000 0x100>;
> -               interrupts = <0 52 0>;
> -               pinctrl-names = "default", "flow-control;
> -               pinctrl-0 = <&uart0_data>;
> -               pinctrl-1 = <&uart0_data>, <&uart0_fctl>;
> -       };
> -
> -Example 4: Set up the default pin state for uart controller.
> -
> -       static int s3c24xx_serial_probe(struct platform_device *pdev) {
> -               struct pinctrl *pinctrl;
> -
> -               /* ... */
> -
> -               pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -       }
> -
> -Example 5: A display port client node that supports 'default' pinctrl state
> -          and gpio binding.
> -
> -       display-port-controller {
> -               /* ... */
> -
> -               samsung,hpd-gpio = <&gpx2 6 0>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&dp_hpd>;
> -       };
> -
> -Example 6: Request the gpio for display port controller
> -
> -       static int exynos_dp_probe(struct platform_device *pdev)
> -       {
> -               int hpd_gpio, ret;
> -               struct device *dev = &pdev->dev;
> -               struct device_node *dp_node = dev->of_node;
> -
> -               /* ... */
> -
> -               hpd_gpio = of_get_named_gpio(dp_node, "samsung,hpd-gpio", 0);
> -
> -               /* ... */
> -
> -               ret = devm_gpio_request_one(&pdev->dev, hpd_gpio, GPIOF_IN,
> -                                           "hpd_gpio");
> -               /* ... */
> -       }
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ea5655a29c3..33005c10e956 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15242,7 +15242,7 @@ L:      linux-samsung-soc@vger.kernel.org
>  S:     Maintained
>  Q:     https://patchwork.kernel.org/project/linux-samsung-soc/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git
> -F:     Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +F:     Documentation/devicetree/bindings/pinctrl/samsung,pinctrl*yaml
>  F:     drivers/pinctrl/samsung/
>  F:     include/dt-bindings/pinctrl/samsung.h
>
> --
> 2.32.0
>
