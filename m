Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A354ED93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378708AbiFPWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbiFPWsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:48:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9854AE33
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:48:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso6338367pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D4wYNhCrugPOLx6NQzh5DQYpCR2JYLvdgRSxgN/KnFY=;
        b=NAJ2unUhWosiXfMkbjIrpO0dDiluf91z8///fATeLpwgILwfiE+kM5YBdFpaUIGq17
         5Um6HU+xdw4baxlCIWd0jms6yo85llzLBx9PA94P4f+5xbogFjqL+R9fGYtsmx9TavHG
         4U6P+fkeo1BWzuHlFczZV7V9vLQXom6j4Dgm+ZcAssevg5Lvhzh1Jq3LzX84t3yl6lTX
         fhSPUkSh9H+GQ3sCWePzR9BGpoUAiFh3rDz9jUbV49abC41Pf0U9T9eCCaS3QXXs+/iM
         uRcaJnnBxkLPV6yOfXH1DDlEvA2wCJe5KDfvvp4hgl8Lumv5/dZCJKD28YBg1Ad9RtBr
         sPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4wYNhCrugPOLx6NQzh5DQYpCR2JYLvdgRSxgN/KnFY=;
        b=0QXUWEBrXwqZGbnUrlA66rFBz7dztijDDkFdTraKlguamxIa0O+xk0kiHbzlviS0L/
         ec2Ssc7lBfflYZCWtfmiHTHBLjUXwMoN1VqhNsKUwTSkLI8rbiYlh5m9X/3DypXapLRs
         zobmUs9vzIhht/aaIPDhiuFLd4DteclqRrZl8Oy8See3gGTzmjFwG91H909VxBuzzppH
         BjJj0d2AP80NSwjUWtoNnVucKjGxVGP8ylyVyvNbSNQwOp3RCh6BMkkdC3qQimBwK4t5
         rncKL2fSd3Vnz7VOIlZp9pWPg32KnR2Pk9rF2kBQJj7rQ3BhzvLmRJNPhzhHkq6xJ2qG
         dJ9A==
X-Gm-Message-State: AJIora9usjKDLnnU51RTqUxwM8YnfHlmlPFEOAk1tTaoHR5j0T1vNMmU
        +ccnPY8Ko9sp83uWUAEiltSLHQ==
X-Google-Smtp-Source: AGRyM1vc+vcRuQ2TZeqUJaBdLXB66+ueezXpaJBqAh1uNNDMle811gM+06V92iS2MmAk6l2OcEBXJQ==
X-Received: by 2002:a17:902:8e86:b0:168:d6d6:660f with SMTP id bg6-20020a1709028e8600b00168d6d6660fmr6404813plb.35.1655419683436;
        Thu, 16 Jun 2022 15:48:03 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b0015ee24acf38sm2096401pls.212.2022.06.16.15.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:48:03 -0700 (PDT)
Message-ID: <ddbaa8fa-dff5-671d-c476-fe8fd616587f@linaro.org>
Date:   Thu, 16 Jun 2022 15:48:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: atmel,flexcom: Add new
 compatible string for lan966x
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220612152604.24280-1-kavyasree.kotagiri@microchip.com>
 <20220612152604.24280-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220612152604.24280-3-kavyasree.kotagiri@microchip.com>
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
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v2 -> v3:
>  - Add reg property of lan966x missed in v2.
> 
> v1 -> v2:
>  - Use allOf:if:then for lan966x dt properties
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 75 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> index cee9c93ce4b9..d9b0fe2b0211 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -16,10 +16,13 @@ description:
>  
>  properties:
>    compatible:
> -    enum: atmel,sama5d2-flexcom
> +    enum:
> +      - atmel,sama5d2-flexcom
> +      - microchip,lan966x-flexcom

And here you have correct syntax...

>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    clocks:
>      maxItems: 1
> @@ -46,6 +49,27 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 3]
>  
> +  microchip,flx-shrd-pins:
> +    description: Specify the Flexcom shared pins to be used for flexcom
> +      chip-selects.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 20
> +
> +  microchip,flx-cs:
> +    description: Flexcom chip selects. Here, value of '0' represents "cts" line
> +      of flexcom USART or "cs0" line of flexcom SPI and value of '1' represents
> +      "rts" line of flexcom USART or "cs1" line of flexcom SPI.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 1
> +
>  patternProperties:
>    "^serial@[0-9a-f]+$":
>      description: See atmel-usart.txt for details of USART bindings.
> @@ -72,6 +96,25 @@ required:
>    - ranges
>    - atmel,flexcom-mode
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,lan966x-flexcom
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2

maxItems are not needed here.

> +          items:
> +            - description: Flexcom base regsiters map
> +            - description: Flexcom shared registers map
> +      required:
> +        - microchip,flx-shrd-pins
> +        - microchip,flx-cs

You need "else:" setting reg to maxItems:1 and disallowing the
properties (microchip,flx-cs:false). See for example:
https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/media/renesas,vsp1.yaml#L53



Best regards,
Krzysztof
