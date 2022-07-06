Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F45568C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiGFPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiGFPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:22:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6013D0E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:22:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx13so18895582ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+mU56Z0jln9tpZcCLBMTlNZ0DlKw6qLIcuR6s049GPk=;
        b=vShMHcD/GMWr3dbVy8g+QKecwTcuyMMhc5OSwqdKK3JXCju22+2a197RniNwmYGEbC
         egQW6E6eN+93TQbnli2LcQ/zei2/nAkyiZdLhPH1LNxI42wOmkc+haHgKbMBBA/eZTbO
         FUPS81v7+jfisZRrRVv2L2EEWsNBQjWtH7lvxUGdsmKmWEm1bVjhA0fYG2FwgaJ0+0FQ
         fqjhPDvPhVUzusff7LGhjS5B6xOsGi+vdi52eZXRht8y/NHpCxfs69c3pnU0ni2lhUoJ
         7L91oCQG6lFv6tGF7p1hexhsmdQJlm8gRSBpcH7hjgodUB7fURteQoDcMxSn28EcpoVN
         Cdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+mU56Z0jln9tpZcCLBMTlNZ0DlKw6qLIcuR6s049GPk=;
        b=Xm0+WNSim6dN9GtBggASP+l617sm4g2iyXdOQSqMBN5Qjx3Xene1k1v7Eay6tVkqL5
         4zJyNI8HaDRwS1MsbKvvTrbsE9zoONzGaC0gfC0dqIANnNSDa9oOprtmup2dy2Maj4KH
         un1TqGmhl4RdXKEsR/m4oQhdXi3E2L+XnZP6wH4v6tcROs8+8fvrZDAWlCtYS53qXegN
         zLzw+CYRk6Gf+Yax6+CdqkGT6xCHaa0eH/j4HdOXNllUGY01+TSo7XPlF08Xz0Ix19xG
         v5O5dPDt1ddjahXylJfzcWPOKAnrAsKdi69okFXc0RSN4GUCzXmaYy7CK2lZRbk4C7t4
         cnqQ==
X-Gm-Message-State: AJIora8Stw/0I1PhKaJptod7Gs16tmmbVJ7AJdxcJeT0CcxaJWL9XXfL
        cHLwd07+qDSBs+KZqNVzalVV8A==
X-Google-Smtp-Source: AGRyM1ucbiikEj80bXWZmGd+F7/xuIxpbwt2UKm2XOLOlDdQ47QQZ5LOsrYW5G39Xi0FO1/mgtQaLw==
X-Received: by 2002:a2e:a483:0:b0:25b:c3c6:8559 with SMTP id h3-20020a2ea483000000b0025bc3c68559mr24099648lji.273.1657120947479;
        Wed, 06 Jul 2022 08:22:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bu35-20020a05651216a300b0047255d211b9sm6325799lfb.232.2022.07.06.08.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:22:27 -0700 (PDT)
Message-ID: <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
Date:   Wed, 6 Jul 2022 17:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
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

On 06/07/2022 13:06, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> 
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is under review).
>    Once that is accepted, I will add back spi example through new patch.
> 
> v4 -> v5:
>  - Fixed indentations.
> 
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
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 74 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ----------------
>  2 files changed, 74 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> new file mode 100644
> index 000000000000..864f490ffb83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
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

As pointed out by Rob's bot - why do you not allow the protocol-specific
children here? spi, serial etc?


Best regards,
Krzysztof
