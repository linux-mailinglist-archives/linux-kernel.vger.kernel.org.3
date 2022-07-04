Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C476256560D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGDMw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiGDMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:52:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91511A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:52:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so15574771lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hj8neQLJfqo9uelctMjuqwVeaGvU4fbX0ySCCTdGLQ0=;
        b=rCF3HO11LMvLYZgntxKd9nVcQZuQ2JrE22AfbOg2cCEucCM528YfDfx6+dVK5QtBgd
         lAx69ir2Q3wdEz7stPBtyh8Jnt5hzkt4MTPCRNSrYF7KqI0mx1tIGvgF8OfOLhIS4Lzt
         2ajUcfTK+cqBVlFbUd7nGsZ56rhNMlBPvbd65/Le/YrlGf9Skyqk5zu47nEMWB2UEpBX
         T+yj462pIP/n2sUfpCy/koaoSuG5FZHP7ulviHpguMxYaIuxnc2XRR6aHVk28bJkF5Wh
         KpSDAyPCQBmV7uMwKcu08Ca8SjvT/5MF/NAaDwwB+Ncf4/LXO1EEo69JQIpQIwQD1aVJ
         j4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hj8neQLJfqo9uelctMjuqwVeaGvU4fbX0ySCCTdGLQ0=;
        b=gOpz6QIezCQflTXWcr5lOX7kt6XugfSUSkt3vRmfKtY00BtTsQGWMgb3gK5pqv+2z5
         XM1WA6ujtCfSOGU37MVjRmrQ7bT30IbHHdjWlRxjrzMdqX0mJYCER1Ha2XWwVra2Xjz3
         g8+BKvTbIkOPTXI40v5kpAlwkfNH2cLM3QZv2fdLI2p4YXwR3Xf0molD3xvQ+SNOWGyo
         twuRwT3Zr6WFcEQ5fRRcFdXFrrmib3UUnupfKZjVDdLyxt1GYW699N0wes0KUjAQfw7O
         P4T42NC/d8gBb/LQnGAE+3YyOFnMdGFCxCuiqYudLPcqeGP4qEzhj3+2/SHblPAbxDmg
         9+uQ==
X-Gm-Message-State: AJIora9AAoGlobzvFP+MlZkHWp2LTIfQbz6HIOWoaSeLjuph0uszzVYB
        2Gh9465UMfXnDP2qLASZsIKfFw==
X-Google-Smtp-Source: AGRyM1tEppgpdqoiN+Rh5X15WeLGEfmy5Rvw6ovMjRtWYH0OKR+gfHQYdvoliJvdPTnoX+f2fvGRQg==
X-Received: by 2002:a05:6512:7b:b0:47f:6568:a143 with SMTP id i27-20020a056512007b00b0047f6568a143mr19466951lfo.485.1656939149040;
        Mon, 04 Jul 2022 05:52:29 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b0047f77cc3287sm5109436lfn.274.2022.07.04.05.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:52:28 -0700 (PDT)
Message-ID: <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
Date:   Mon, 4 Jul 2022 14:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        tudor.ambarus@microchip.com
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704083143.56150-1-sergiu.moga@microchip.com>
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

On 04/07/2022 10:31, Sergiu Moga wrote:
> Convert SPI DT binding for Atmel/Microchip SoCs to YAML schema.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> v1 -> v2:
> - change subject headline prefix from "dt-bindings: spi" to "spi: atmel"

Should be:
spi: dt-bindings: atmel,spi: convert to json-schema
(or to DT schema)


> - change maintainer
> - kept the compatbile as items (instead of switching to enums) and at91rm9200
> as fallback for sam9x60, since the evolution of IP's is incremental.
> - removed unnecessay "cs-gpios" property and descriptions
> - added min/max for fifo-size property.
> 
> 
>  .../devicetree/bindings/spi/atmel,spi.yaml    | 77 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi_atmel.txt     | 36 ---------
>  2 files changed, 77 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,spi.yaml b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
> new file mode 100644
> index 000000000000..d627fc9315bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
> @@ -0,0 +1,77 @@
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
> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200-spi
> +      - items:
> +          - const: microchip,sam9x60-spi
> +          - const: atmel,at91rm9200-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    contains:
> +      const: spi_clk
> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum number of data the RX and TX FIFOs can store for FIFO
> +      capable SPI controllers.
> +    minimum: 16
> +    maximum: 32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks

In properties it's clock-names followed by clocks, so better to keep
same order here.

> +
> +unevaluatedProperties: false
> +



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
