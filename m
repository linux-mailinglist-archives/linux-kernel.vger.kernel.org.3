Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAF53FBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiFGKoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiFGKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:43:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C01FCFE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u26so26922550lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfeUV1AwNiT/W19hxcj/NliOzzEK95QXMUgUDGQeGVM=;
        b=mklHMeniN+Ch9TA/pHudegQh81MPjZetIIdfVLjDQbypod4GCI5NH296O4xL3oLXX5
         EtSB95qGej4GPTANqSeLL+ml3+OGdRkpbbQd3nd+tb1z5QHIZPdeWwIy9GjH8pZQc50C
         zDzkcvE0nFPpibbibIYz2TxiRK0MjxayLE0RrcacIAZUSgfhpanYLUuZ1lZQ1ef4w2AN
         GiIxg3XVYvrQR5k8hBIPZ4uPZx8rnz0rqd6kA63O1jDWdVd1H7Bm+5fqY5eA5Cc5zfC6
         0g0oy8babwOZ1jqtD/zY3rQIq6OWxFbiaf+s/hVixKGFRHrlCVFvTyQvlxMm1WKzXD6V
         Wjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfeUV1AwNiT/W19hxcj/NliOzzEK95QXMUgUDGQeGVM=;
        b=KwE6qSKoNRM2/6CMzx77hUh30z4NhH18WNIGwrb4OjBr2N0qLPcnQrGNAYmWbEztCD
         Scl+gkI8uU2ayE6rlyG0Ogxy/IGHO9Bj8xnTN/H72V/usr12ceHlM5m9gUDZQqmLrPVq
         Ciucv3SP2nn+DJSpvqDBlCvmzM3qg2lcmFjY4zaezljtt8ED9+bbfWLy/S5SWcvkHu9+
         oyqg3/XfEXRly+5N4jLp5fFc8i6t38T3EdyH6YKcwbHtOp2LSPkE8TwYUWvHw+28hBKY
         nhyc7016GiW2KW61xEgRarX9QCYZJicfGdr6RNgpbyBC5UUJNs/1anOAujoWjWKb5VQe
         vNpw==
X-Gm-Message-State: AOAM532rpWs5kSWfgXtbMUGtIf2jjaTBGuoXCsLv/X65aJMfyGenoj+S
        1J6r6twWfAQ37FNeyct96cXxEXQF8P15iMsIV31PtA==
X-Google-Smtp-Source: ABdhPJzPGTimBB70OBlGTNcTyqnDOsp8/I8NBiCevRFSY/lrkvKnq2LAYOlDrii5/PhsOwu2dbZ17DoYgnn4hQ42m3A=
X-Received: by 2002:ac2:54b9:0:b0:479:a29:c1ec with SMTP id
 w25-20020ac254b9000000b004790a29c1ecmr17619658lfk.358.1654598632532; Tue, 07
 Jun 2022 03:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606201343.514391-1-mail@conchuod.ie> <20220606201343.514391-2-mail@conchuod.ie>
In-Reply-To: <20220606201343.514391-2-mail@conchuod.ie>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:15 +0200
Message-ID: <CAPDyKFqvo3qf+tK2p-Vkk8=7TGAaAKjAsJvsh=rKYBB_vxpB4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mmc: convert mmc-spi-slot to yaml
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 at 22:14, Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Convert the mmc-spi-slot text based binding doc to yaml,
> with the side effect of cleaning up some of the riscv
> dtbs_check warnings.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/mmc-spi-slot.txt  | 29 -------
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> deleted file mode 100644
> index 5e74db69f581..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -MMC/SD/SDIO slot directly connected to a SPI bus
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties used by the mmc_spi driver.
> -
> -Required properties:
> -- spi-max-frequency : maximum frequency for this device (Hz).
> -
> -Optional properties:
> -- voltage-ranges : two cells are required, first cell specifies minimum
> -  slot voltage (mV), second cell specifies maximum slot voltage (mV).
> -  Several ranges could be specified. If not provided, 3.2v..3.4v is assumed.
> -- gpios : may specify GPIOs in this order: Card-Detect GPIO,
> -  Write-Protect GPIO. Note that this does not follow the
> -  binding from mmc.txt, for historical reasons.
> -
> -Example:
> -
> -       mmc-slot@0 {
> -               compatible = "fsl,mpc8323rdb-mmc-slot",
> -                            "mmc-spi-slot";
> -               reg = <0>;
> -               gpios = <&qe_pio_d 14 1
> -                        &qe_pio_d 15 0>;
> -               voltage-ranges = <3300 3300>;
> -               spi-max-frequency = <50000000>;
> -               interrupts = <42>;
> -               interrupt-parent = <&PIC>;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> new file mode 100644
> index 000000000000..c45b91099325
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-spi-slot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC/SD/SDIO slot directly connected to a SPI bus
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +
> +description: |
> +  The extra properties used by an mmc connected via SPI.
> +
> +properties:
> +  compatible:
> +    const: mmc-spi-slot
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  voltage-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Two cells are required, first cell specifies minimum slot voltage (mV),
> +      second cell specifies maximum slot voltage (mV).
> +    items:
> +      - description: |
> +          value for minimum slot voltage in mV
> +        default: 3200
> +      - description: |
> +          value for maximum slot voltage in mV
> +        default: 3400
> +
> +  gpios:
> +    description: |
> +      For historical reasons, this does not follow the generic mmc-controller
> +      binding.
> +    minItems: 1
> +    items:
> +      - description: Card-Detect GPIO
> +      - description: Write-Protect GPIO
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      mmc@0 {
> +        compatible = "mmc-spi-slot";
> +        reg = <0>;
> +        gpios = <&gpio 14 GPIO_ACTIVE_LOW>, <&gpio 15 GPIO_ACTIVE_HIGH>;
> +        voltage-ranges = <3300 3300>;
> +        spi-max-frequency = <50000000>;
> +        interrupts = <42>;
> +        interrupt-parent = <&PIC>;
> +      };
> +    };
> +
> +...
> --
> 2.36.1
>
