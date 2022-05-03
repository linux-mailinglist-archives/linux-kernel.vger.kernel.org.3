Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9B51846E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiECMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiECMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:41:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38137A3C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:37:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so33170058ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dPrQeuK6P2l/MQi8kZ5IFQiJqg+3Zo++ZVRWjbzxpdk=;
        b=EbJRY8g5/Ymg9IhYybRu+dZkkXvfrXTU6vLOc8Hl8+rjE1yZSB56PTq91bLOsLw/Fa
         tFw7VfCJiSq/49WpzEMsmXvfmEHusoM6yM5F6kDnA3QD4UXN6pgejPHGB0Y7V8rt/uRl
         QhnU0yi2g2ZL1Wx96atNNe27DzEeHaGYtghfHTP+V0Oj7l9TB5hC5Ug5GYqLHghiiRCk
         J8S5FIoye8gRzW4fP4nSV1Pj7G5zx8hAFT8CMlEaDrUiBKQC2gWCJBHP4pP5pb3lg0/Z
         l6GrILGO8I2ZUdgn+86/9RznVequiLt1zXCn3+lyPpZXNiWGOHBh4v9g8pU6QlSZwPLI
         c6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dPrQeuK6P2l/MQi8kZ5IFQiJqg+3Zo++ZVRWjbzxpdk=;
        b=CLvePwhLrxNMU9PW30B5dGn5Zi8tX8P9zcvEugWnyXI5R2/z8mqqxvHEckBVwbyJdE
         9kJjLXdezgjmVCShwy2nSsRnFLBFEAnG+SozjhPXHpkaJpxOLWCkTfFZyAGGPS5vS5Kq
         74iZiJz/9UywSe14k4LX/OqgmcHEtFK9zOa8MNmU0qSnP094FIm3DvWgZ9skkmF/KzmP
         Tn4XAoHpeGP8UgZfP2aigzp5PT7e06ycX1LjM8h/gsMuGn7VJp5BH1P7eyqMLjQSZdL8
         97qe0AjeXtK+ZOinNIWKnMGsWNIYO/r8uLehS2GZRrqrHlbcvRLcN9Mty8ikjdQ3YiIr
         lPGA==
X-Gm-Message-State: AOAM531LXXUzS9tk3daqZNg50dTROnIaGQtVzdfUQlzQgPZH9K3+McrZ
        YGGTme7QJ2EKTdCPTm8t+ZLDfw==
X-Google-Smtp-Source: ABdhPJxgFIvvaooQp10isKGsPku1kBvLtp6PTO5Vz0TDeuxXJKo4YvhN8i37iGpgYGnmQ7u2Ii1yeA==
X-Received: by 2002:a17:907:6d9c:b0:6f4:2916:a7d8 with SMTP id sb28-20020a1709076d9c00b006f42916a7d8mr12755574ejc.374.1651581459616;
        Tue, 03 May 2022 05:37:39 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz28-20020a17090775fc00b006f3ef214e40sm4568804ejc.166.2022.05.03.05.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:37:39 -0700 (PDT)
Message-ID: <ae48a426-3cc3-74c7-7e19-3daa8117b522@linaro.org>
Date:   Tue, 3 May 2022 14:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] dt-bindings: mfd: atmel,flexcom: Add lan966
 compatible string and mux properties
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
 <20220503105528.12824-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503105528.12824-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 12:55, Kavyasree Kotagiri wrote:
> Add lan966 flexcom compatible string and flexcom mux
> device tree properties
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,flexcom.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> index 62dea9b891d8..3e056857c44a 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - atmel,sama5d2-flexcom
> +      - microchip,lan966-flexcom
>  
>    reg:
>      minItems: 1
> @@ -45,6 +46,19 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2]
>  
> +  # The following optional mux properties are only for lan966 flexcoms

You need allOf:if:then restricting these per compatible.

> +  mux-controls:
> +    minItems: 1

maxItems instead

> +    description: Phandle to the mux controller to map flexcom chip-select
> +     to flexcom shared pin.
> +
> +  mux-control-names:


It looks like mux-consumer, right? You should instead include (in allOf)
the mux-consumer.yaml.

> +    description: String to label the mux controller.
> +    minItems: 1
> +    items:
> +      - const: cs0
> +      - const: cs1
> +
>  required:
>    - compatible
>    - reg
> @@ -64,5 +78,7 @@ examples:
>            #size-cells = <1>;
>            ranges = <0x0 0xf8034000 0x800>;
>            atmel,flexcom-mode = <2>;
> +          mux-controls = <&mux 0>;
> +          mux-control-names = "cs0";
>      };
>  ...


Best regards,
Krzysztof
