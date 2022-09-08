Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978055B1BC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiIHLnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIHLnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:43:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87716A0310
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:42:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v6so6154851ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WF6FZwu8DyCERLgytzSwDS5wT3+PZqQFtPxZIYWZZSI=;
        b=Er+nRXg6JfhIKzneVd4TJ5DyvIE+0CcaYRnQLiihVdiBn+uRSeBISV6pB/ueFbfryC
         Sci98ArpAHjsQLaNd92njfIe/9bILN6/zKiQz6FU7mtdnpkaHEmJw48GJZfWLUn6WdLZ
         PQTgxGqbEZZWcZOE9+1Yj+ovCnJ+Q+upda2/TQFeF6GuTOySl60sdghHCBFfIEKuZx0N
         Bv6Y+zeh4ZpHf6rd3P9mrRXzp/UJPseE9tYIjfku6OXRXr3XYd51BqUlASV3DAgitwfT
         x+xPVslva4Xntmr641P4yNDJjoEUqkSRQ91UuYTzDVCRGqmoKI3oHpvBRYYrwGIbOZDD
         040A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WF6FZwu8DyCERLgytzSwDS5wT3+PZqQFtPxZIYWZZSI=;
        b=jcJ6WMlJ300yUb0UuOvCxB+zUAOQ/XjTyjhluftKtUWx5jNIEN/LZjXIobBhvUL7T0
         lQwniuy3Yfr56zhli7TlRz1MvdJkfaalRL1jC7S0MTgeTdbJlfdGoypLG9EuQozPkuyP
         68FZdOrMm2GuDlgmwT1C9MZJwS9ksF7UGUrJ2Ska+EkpOJyg/6KlMLwkZVzEIra7dkKu
         IZuBTQt+WZPLcX/NShOsyD6eMXALrMMHdc6xtaz5N0D7eoLeDWQaBcFWep1B5W/hqe+D
         yW3tP3guBFeBYzlJkATY1Mtcr9MlrXFpa3PfJdzB9lLxbR2RDK1fqHa4+D4Fg+GCwSiM
         YsNg==
X-Gm-Message-State: ACgBeo0PUr6n+UZnN+tbJ9i1xMKpa9BCoE4MzvTDwtLNbSkYCy44R6mI
        YCGweh9pqbyopDh7yBxw6tYc+A==
X-Google-Smtp-Source: AA6agR4HDpuLPswIafbfbiEvr/0gvAUx6LJH5GAQyO/R4H3WeNUsO2c9IDANsAV3fOFK+30UYxqNNQ==
X-Received: by 2002:a2e:a54a:0:b0:261:caa2:8d74 with SMTP id e10-20020a2ea54a000000b00261caa28d74mr2225335ljn.11.1662637377944;
        Thu, 08 Sep 2022 04:42:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f13-20020a05651201cd00b004981dee8540sm377746lfp.260.2022.09.08.04.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:42:57 -0700 (PDT)
Message-ID: <13e94251-6155-df5f-040b-7f3226e9df26@linaro.org>
Date:   Thu, 8 Sep 2022 13:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220902192236.14862-1-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902192236.14862-1-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 21:22, Jerry Ray wrote:
> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
> description yaml file.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v5->v6:
>  - No code change - patch prefix naming modified to match with others.
> v4->v5:
>  - No change
> v3->v4:
>  - No change
> v2->v3:
>  - No change
> v1->v2:
>  - Added Device Tree documentation for Microchip SAMA5D3-EDS board
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 2b7848bb7769..c7f067e13d20 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -139,6 +139,13 @@ properties:
>            - const: atmel,at91sam9g20
>            - const: atmel,at91sam9
>  
> +      - description: Microchip SAMA5D3 Ethernet Development System Board
> +        items:
> +          - const: microchip,sama5d3-eds
> +          - const: atmel,sama5d36
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +

A bit weird order. I would expect this to be after atmel,sama5d3 boards
but before atmel,at91sam9...


Best regards,
Krzysztof
