Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF317560135
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiF2NX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiF2NX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:23:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D25621812
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:23:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g26so32564189ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bTc+9vraxg+Jp5bKZOKnmt3sZm7i9sLfDA3h0E40ZE0=;
        b=kuTZc/BMdKAqCExUt2A8qTipZw8vfXBlk3C1NkvhN1p+yEqZmGRE8a1vRdzbc9HFHw
         sJgEJreP4zorhl7lPCqvI4GvePU7NY9g3Q43XF2R6PBKJq074n7/I59hGjoGUHCDwSN/
         rfAN3r9Ca8oan4l+NphL4xHs+QVMSBYWtqXWY5lHjakGRYWpFPX5iq0K/Oa/So+G7ihV
         dnzn3CEbyb/ECUR/BsKu2rXe+Oc6DXNOB/+wGb4ld0OzLSbl6ipOXyIkekI+eKDJTvNW
         D7WECRmatbLhomSFBeMGgEFnd+JYg7eX/itdHpvb/EmeDTUYbeMfGGFzcWK6vFgtb1bK
         LCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bTc+9vraxg+Jp5bKZOKnmt3sZm7i9sLfDA3h0E40ZE0=;
        b=IbciwgtuzyeO+sPwbk1sW0FbdZcWnaPWsItOwvn+f6JaWAhq4pIgQPTxesQpZK9e2H
         OhaMn3+3uRlqFhBzGF1XXx57K5sx+knMkw5RjpJYXNtwN63d4AB25rQb1NaKe+dm5vvo
         fIt1T+K3w8bfxExcvqg6LOvfZZW8TGYms6WyvfijCAmXEtDeX1XnqCXnK3ftfTeJdquY
         Zr6XCbQl7cpwCIP2ivQGCvfdbn1w1IwfX5XhLJGDGyCF00zQysn6qLzVWxKdKdRulTWG
         VjwtkMlkdXFjzp2qXruZvxMEiRa2VMt9cWwNMLqTkMoJAhqwr3pMbj5AGsD9TqdpnF/w
         vEjg==
X-Gm-Message-State: AJIora+EQC8VqcjYkXjLJ7sLvpU74lNmfATD4IXxlRWS343YzewvjqTy
        TLnEqNSmRFQh0zUcYIKuuuuJQg==
X-Google-Smtp-Source: AGRyM1v11VnSNbZ6+il0NcaTX8oa+GpOwQoB5uOk6h/4PSodDcPkMaY3ClrXxIlnVUVvaEiCBXZdvQ==
X-Received: by 2002:a17:906:58cf:b0:722:e4e1:c174 with SMTP id e15-20020a17090658cf00b00722e4e1c174mr3326097ejs.85.1656509034201;
        Wed, 29 Jun 2022 06:23:54 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i25-20020a056402055900b00435681476c7sm11456559edx.10.2022.06.29.06.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:23:53 -0700 (PDT)
Message-ID: <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
Date:   Wed, 29 Jun 2022 15:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629125804.137099-1-sergiu.moga@microchip.com>
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

On 29/06/2022 14:58, Sergiu Moga wrote:
> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel,spi.yaml    | 82 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi_atmel.txt     | 36 --------
>  2 files changed, 82 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,spi.yaml b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
> new file mode 100644
> index 000000000000..751618a47235
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/atmel,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SPI device
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

This should be rather someone from Microchip.

> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

No need for quotes.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200-spi
> +      - items:

These are not items, just single entry. Should be combined with above
and made an 'enum'.

> +          - const: microchip,sam9x60-spi
> +      - items:
> +          - const: microchip,sam9x60-spi
> +          - const: atmel,at91rm9200-spi

This is wrong. Either this is a fallback or it is not. It's not the
Schroedinger's cat... Maybe your DTS are wrong.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  cs-gpios: true

No need, coming from spi-controller.yaml.

> +
> +  clock-names:
> +    description:
> +      Tuple listing input clock names, "spi_clk" is a required element.

Skip description.

> +    contains:
> +      const: spi_clk
> +    additionalItems: true

no additionalItems.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum number of data the RX and TX FIFOs can store for FIFO
> +      capable SPI controllers.

minimum and maximum for values, if it is known.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi1: spi@fffcc000 {
> +        compatible = "atmel,at91rm9200-spi";
> +        reg = <0xfffcc000 0x4000>;
> +        interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&spi1_clk>;
> +        clock-names = "spi_clk", "str2";

This does not make really sense. You have one clock.

> +        cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
> +        atmel,fifo-size = <32>;
> +
> +        mmc@0 {
> +            compatible = "mmc-spi-slot";
> +            reg = <0>;
> +            gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;    /* CD */
> +            spi-max-frequency = <25000000>;
> +        };


Best regards,
Krzysztof
