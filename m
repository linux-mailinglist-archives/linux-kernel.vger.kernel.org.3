Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B324542D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiFHKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiFHKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:19:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDE34BB8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:06:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so40450877eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3J02Cy+NQfGm8eV9KXhCD+MqMYdiX+58OLIgnc/8epc=;
        b=IMJozpnrngI0y4iXwqWP72b84kfB4aNdhVQEbM8V/kkVCEolj6yjfMGAfBxkFB1cNQ
         xQNoHORJyBpbstcHefYhvnN2pvdrhUXXseBwJ0ONtoIi02CV9fa7yedi6l54sewGvk8j
         TN3TIX5Hejet+8VZroyCyUobF3JFKxK/iEApe/3CSgLAB3Po09mYcdpCLf+ZvjEPKGyl
         DqZfgw00JleReC4QKzzWGH7wFevd7z305S6FE1TaMTmmjwN4JvBFRfbr34UI8HZiCXGy
         Fev4FGzYiRF/p4JYukVG3FNQqICash3M96PZ5mqEj+LVVPQuga/aSPhYcHdYYAd+C895
         BrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3J02Cy+NQfGm8eV9KXhCD+MqMYdiX+58OLIgnc/8epc=;
        b=lGiAQRAJt5X5a7Ae5LzjNtsd8y+iVsl0+lcawO4DYF852ywIjFbQ1m4jpKJq3gd01l
         nfk8qhMACgwP2NKEksfPGgLWk+1bOdvTxXDNTsaVba3zIIXCauuAzsOBbu110PYnmeEb
         roKRULBu9g+uLHiXrMxB4rGZo9XbPWAVK31NAMwDf9CRlgI0rNMDMXo128ZiMJ2IIjut
         pPlOSXUe1hbbqgwgJ5ioRZWJB9Ntcv02vGfwadQRghhw0nlB8vj/5wemXGm8bIqgEraP
         rC3EYTyWpimDwmSexKTUxwKeokiM3yR4zvjm49YM15yLnera3p0CZz7F1uxCUujdhZzE
         Eb9w==
X-Gm-Message-State: AOAM531dYxJLj3hhZCD5dMEe+XOTYHZnyKyUbQ5XMtlRnfCgrpxU8O3y
        5436t4OVGyqfSZPtBq+WjF4sfg==
X-Google-Smtp-Source: ABdhPJxsAIrFE3btqqb5RrORPvxSxuVZHyAl3KpL5wCgHxpsvLqD8dGERxMUjIqaeaFK4tHV94VjMw==
X-Received: by 2002:a17:906:4785:b0:6fe:f8ac:2494 with SMTP id cw5-20020a170906478500b006fef8ac2494mr30359804ejc.199.1654682779982;
        Wed, 08 Jun 2022 03:06:19 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709066ac100b006feed212f50sm8856606ejs.184.2022.06.08.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:06:19 -0700 (PDT)
Message-ID: <bf4284de-6c20-a378-99f6-439e6abcbbd5@linaro.org>
Date:   Wed, 8 Jun 2022 12:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 09/20] dt-bindings: reset: npcm: add GCR syscon
 property
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-10-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-10-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Describe syscon property that handles general
> control registers(GCR) in Nuvoton BMC NPCM
> reset driver.

I already asked about this.

Could you please implement the comments you receive? It's not just one,
it's several of them have to be repeated.

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,npcm-reset.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> index 0998f481578d..c6bbc1589ab9 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> @@ -19,6 +19,10 @@ properties:
>    '#reset-cells':
>      const: 2
>  
> +  nuvoton,sysgcr:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Skip quotes.

> +    description: a phandle to access GCR registers.
> +
>    nuvoton,sw-reset-number:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 1
> @@ -31,6 +35,7 @@ required:
>    - compatible
>    - reg
>    - '#reset-cells'
> +  - nuvoton,sysgcr

Aren't you breaking existing DTBs?

>  
>  additionalProperties: false
>  
> @@ -41,6 +46,7 @@ examples:
>          compatible = "nuvoton,npcm750-reset";
>          reg = <0xf0801000 0x70>;
>          #reset-cells = <2>;
> +        nuvoton,sysgcr = <&gcr>;
>          nuvoton,sw-reset-number = <2>;
>      };
>  


Best regards,
Krzysztof
