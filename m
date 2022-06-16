Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B524D54ED7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379090AbiFPWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiFPWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:45:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8F62130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:45:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y6so2655186pfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L3HdybHGUtNACL7l/Pk8oMmY4aoVEX/SxxB7u2X+yMM=;
        b=IxehsYAyj3S6S9LPLwFh3RZTGkD3A8CJr0/4sQIlV0K6bW5S8wMRKfY1J0/3Oo8hMt
         TPnNyVeFt6I3DWs6ouz5XkMlxWmwY6MKffRmIfFTenG4344Sq7nolpkFdT8t1UJ28XER
         egpJAMNhPLtXYhQuTluRQwSapOh6LYKG2Q0xfEz8hpPvPoeDKNN7WQYADpholuOIQMoD
         LdBbY+QumHJBban2LuEHz28MhqqnzKDirFuV9/L55Z1zwHfm/kvTAXxWTXz+w543ZfFL
         0tZ99oDPkKEI5xKbHsXbB9e8n4gGz4JIUHWZeDK1/7AgB9YrmtZDZCyIdNhfZUDwK2fY
         rlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L3HdybHGUtNACL7l/Pk8oMmY4aoVEX/SxxB7u2X+yMM=;
        b=eA+GwV7WC5VyZS2XoJsjwADGzNjWhrQ45qrjmCHhp1s6nMl/0k5FMEcWV6omhDGyfb
         W4k2TPXtmDJ79wXB0yyCevI2AMoq48eCmsMX1dK1EqjQA5101KFOiNxS0RBxDmxqViLX
         d9Wv5AfYjVb2jToEbPRdWQoitVxau3X6ziYwN8cj0qX5hmJslTADPohiQicFg1ypj6zr
         hnZJpB5GvmEu4T1ZiLWDBQORTuQxTxKpDKFYcsnMchQQngYTh//vMhougGQaZJo7MYfn
         GJNGfOHxDjPkUcQ/VGZIt+JgoHkJ5ku1xcRpCc09q4P9kFAOxzO2h68OYt92EJwzqEm+
         CQeg==
X-Gm-Message-State: AJIora+yL6RSIQ/R0D40LMfP9N87WZ0pomsuUSHutqB4lJLixfv7IN2F
        BnVbe0LZ4xh9nNfC4cyVTm1JWA==
X-Google-Smtp-Source: AGRyM1vQLIwZzEZ5T+MW897jGjrH5RpIeWnJX/eon8DHTxeHY8/I1G1vCX/YcGBLONlhCCz3eVZ6qg==
X-Received: by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP id s30-20020a056a00179e00b005189e1d1cbdmr6983483pfg.12.1655419507895;
        Thu, 16 Jun 2022 15:45:07 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001678dcb4c5asm2152309plj.100.2022.06.16.15.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:45:07 -0700 (PDT)
Message-ID: <3cf1540f-7185-96dc-7691-fb9ce6bfc566@linaro.org>
Date:   Thu, 16 Jun 2022 15:45:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com>
 <20220612152604.24280-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220612152604.24280-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2022 08:26, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 103 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
>  2 files changed, 103 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> new file mode 100644
> index 000000000000..cee9c93ce4b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -0,0 +1,103 @@
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
> +    enum: atmel,sama5d2-flexcom

This is not correct syntax. Use `git grep -C` to find nice examples.


Best regards,
Krzysztof
