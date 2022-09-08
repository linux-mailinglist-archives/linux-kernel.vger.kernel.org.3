Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFA5B1D17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIHMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIHMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:33:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91D31316DB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:33:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y29so7104843ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Qyru9SAfxdnNAoiz22FTxnAwNC5Cr+8SPNsc9ocSsIc=;
        b=f7wa2z+PB3fEAcSD3njThDARidFNQguSSunU6swdNpXzExqTrXH4PJgNHVhFxxvqct
         lYKOp2jWPUSJltKRlEsrvQexdKtaQT3i3dwr0iztMGW7jS+Jy927WOXT4DbmDQiFreKV
         wAFzs2TPxXf+6O0lIn3hJ0uB9wzGMAhxGSyuJqAFow8FmDkHjGTyCz33v9pZRtLLU8Bp
         iT+q+odD5f59VF/J/8iP35GYJflHIc0y0E8ANwCol0kCp0FhPGNJhjXrQdxmgI5UxSLS
         qhUTBv86bbgKwFlQZW7ELbvbwQ+MCIt2FPQpkGroIuea5QJ8BX/ZhbN4GghfQdEw8UZ1
         Qdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qyru9SAfxdnNAoiz22FTxnAwNC5Cr+8SPNsc9ocSsIc=;
        b=w0a/SaEIz0lkzys8OVNwCedVPzi9wnrGPzw/oyIBNEERZYPo2HrHd2MAUGzDZdrIrs
         hQBH4eSheh3DW8e60eUMl3pA3x67MnmonAMfZdMe0nwIh+rfHRf8m45LtV/pcRl7Urk4
         QaGEjVOG9AjcSmMz5uxZtm+ath/akCWxMbbt5OI4Hj1VAE4GEfgPSF9YzTq7Y+w1FsLJ
         p/bdlUegfu30x/Qaw9jTQ+BgxPHfAKXeSz4tgIT508lC/i6AaW/Ry3PPU4rYXH/vsvX0
         FSd1TfJQiv6XEauozYCifOl4FGAD/tsuSACV24KJSLr4iDU/eOt/G9XhNhYDiUGEMcZR
         r+PA==
X-Gm-Message-State: ACgBeo2xWutg7vPjS+H2vYHgJWQ41U2g7hyAqTe7G7gOi+YIRxwts6PT
        JOKSfwMIcBr9DGrR1CFtJfXGEg==
X-Google-Smtp-Source: AA6agR7V97zwiD9pYqVJ0dFEam4iMWv2WsE07yb8VQiXEY40nYMp8wnTZhtCr1GIsKgf9/LZQCcqVg==
X-Received: by 2002:a2e:b16d:0:b0:26a:d1da:db8 with SMTP id a13-20020a2eb16d000000b0026ad1da0db8mr1709534ljm.217.1662640385823;
        Thu, 08 Sep 2022 05:33:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b0048b17852938sm145414lfr.162.2022.09.08.05.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:33:05 -0700 (PDT)
Message-ID: <633c8aa3-cc05-b855-24db-110a4863ff75@linaro.org>
Date:   Thu, 8 Sep 2022 14:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 07/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add
 USART child node ref binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-8-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-8-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 15:55, Sergiu Moga wrote:
> FLEXCOM, among other functionalities, has the ability to offer the USART
> serial communication protocol. To have the FLEXCOM binding properly
> validate its USART children nodes, we must reference the correct binding.
> To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
> mode, use the clock-names property, since the latter's respective
> property is supposed to contain the "usart" string.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing
> 
> 
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml      | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> index 0db0f2728b65..b5fb509f07ec 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -72,13 +72,21 @@ properties:
>  
>  patternProperties:
>    "^serial@[0-9a-f]+$":
> -    type: object
> +    $ref: /schemas/serial/atmel,at91-usart.yaml
>      description:
> -      Child node describing USART. See atmel-usart.txt for details
> -      of USART bindings.
> +      Child node describing USART.
>  
>    "^spi@[0-9a-f]+$":
> -    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
> +    allOf:
> +      - if:
> +          properties:
> +            clock-names:
> +              contains:
> +                const: usart

Devices are not different because they have or have not clock. Devices
are different... because they are simply different models, so this
should be different compatible.

Best regards,
Krzysztof
