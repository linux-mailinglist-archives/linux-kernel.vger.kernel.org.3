Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBC550043
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiFQXBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiFQXBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:01:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC15BD28
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:01:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w21so5344174pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=93wBdZyt0imEKAizJmmdZRHrfqjB9zGQ8ys+we3vu+c=;
        b=EZh4M1ycFz6SCAMKiDIl6G6C7BtGjLYr3U1SHSbBAI7Hx4hIP3/kSLL4qbTdBB7Rcs
         UetxzOQ8Rj+JYdwmtCVhgR3tFbYqDh4kZNkbUIDudrauiZgmCcZBDxSY+PFP1H23NNxV
         /1FRA05ZocCSi8M5SJsCC93YGD9PrmhNYF1L1QGTH74wdvpZuZHbqSo7G75iEsrk4Y5/
         qNlEaczBKIrXADwDdzyk3fQP+iApfT33UIyZ5GdYow8P3mguwpyEaqyRep00ES1hBDQ/
         l4rrsBcnKNfMiZ7mLQ13N6kgUsGiKJPkYLsaQWCi6Rf+WmyNilTFLjNhQ59V2vP8qn/P
         zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=93wBdZyt0imEKAizJmmdZRHrfqjB9zGQ8ys+we3vu+c=;
        b=fQRj0iIlurtO90iMUzGX2htHlcRjxCg1UP9kA9xm+ceN+8E1ZEMj/pqUYXv7mC33yW
         DZ8M3skmCoCuMwNVbXO0E0/ffThgRswtQgGedRqtUmk/n9nBeu7I6iaD++pMCZQ/BsvO
         jmp2FDOysht91vAN1jffZNyd3i7fjmDF4uFlVsKOjwZ8ScPGDUJmgRScmrY0vGH97P3X
         +ZJq+Wea12W7Ctc5G/p8EDZKuF5etH2gMjeLhiOKUxSL2eij1S3JBLYXj4BGxn/WqUxR
         Ly4t7xoNNLPGRc5JCpjPtbTeRgWNa9szTeO6ayhfZa10GKPkQK33dLRQj39Pvi8BJhZA
         CwPg==
X-Gm-Message-State: AJIora9rnWQ46MSulH1gbyOpoSmJiEtEch+kZzb0SKhJaUeC4o7YqLNe
        5+Tl/SUvi+cMaVoxnIpXmAKGqw==
X-Google-Smtp-Source: AGRyM1t9pcL+vMaPBY+wtn9GXNBkDXhK2UnNkSWzoYSqeS+3IqXJREXw4pHwGJnOtkHDEhp+2aAgnQ==
X-Received: by 2002:a63:90c7:0:b0:408:9c77:7a7e with SMTP id a190-20020a6390c7000000b004089c777a7emr11180492pge.191.1655506860177;
        Fri, 17 Jun 2022 16:01:00 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b0015e8d4eb2b4sm4061989plk.254.2022.06.17.16.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:00:59 -0700 (PDT)
Message-ID: <1a7fc699-6381-f2db-178f-169bc1ebf064@linaro.org>
Date:   Fri, 17 Jun 2022 16:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski+dt@linaro.org
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 06:07, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
> 
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 104 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
>  2 files changed, 104 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..fdb1645d123f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description:
> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
> +  an I2C controller and an USART. Only one function can be used at a
> +  time and is chosen at boot time according to the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,sama5d2-flexcom
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description:
> +      One range for the full I/O register region. (including USART,
> +      TWI and SPI registers).
> +    items:
> +      maxItems: 3
> +
> +  atmel,flexcom-mode:
> +    description: |
> +      Specifies the flexcom mode as follows:
> +      1: USART
> +      2: SPI
> +      3: I2C.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +
> +patternProperties:
> +  "^serial@[0-9a-f]+$":
> +    description: See atmel-usart.txt for details of USART bindings.
> +    type: object
> +
> +  "^spi@[0-9a-f]+$":
> +    description: See ../spi/spi_atmel.txt for details of SPI bindings.
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: atmel,at91rm9200-spi
> +
> +  "^i2c@[0-9a-f]+$":
> +    description: See ../i2c/i2c-at91.txt for details of I2C bindings.
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - atmel,flexcom-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    flx0: flexcom@f8034000 {
> +          compatible = "atmel,sama5d2-flexcom";

The bindings look good, but you have here weird indentation. I don't
remember if I pointed out this already, so in any case sorry for
bringing it up so late. The indentation should be four spaces which
nicely aligns with " - |".



> +          reg = <0xf8034000 0x200>;
> +          clocks = <&flx0_clk>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges = <0x0 0xf8034000 0x800>;
> +          atmel,flexcom-mode = <2>;
> +
> +          spi0: spi@400 {
> +                compatible = "atmel,at91rm9200-spi";

4 spaces

Rob's bot also complained about compatible. Are you sure you use here
correct compatible?


Best regards,
Krzysztof
