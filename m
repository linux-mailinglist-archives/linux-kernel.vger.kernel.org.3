Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9C51819B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiECJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiECJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:51:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082B340DB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:48:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p18so19229948edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ia83NWe8LX9zGfMIBGWxWbf+jhXbsrN3kDN4N4rBK0Y=;
        b=hk7HN11Jv7N88CzppbvASPBZp9ZpBdDXCQRf7G19x30QvRcEuhRcRQRGepvwNsHqla
         6RplJLMdOo3CBysoleUkcwEEqJl+yKoLf9sYQYZgcMWXAelOe2j8KYMjSpN4uQ28V9Iy
         4Mu5J8SCb4o3E5zHKXxoM2AJM9GN+lI5+P6IWawVR+alB7/EKQgk75UMPnIthh0hXhd0
         ezeHYwD1TAyg0Av7SQ9QBPhdm7LGuXkytGf9vjGi3SYsKphKXgpWvUoaObK7FRTGOV/R
         krXVbyJgO5MfS5GzgkJMsvBArVpW9kaVWxEAr4Yf+qifdZehj+WNx+mQLO65MixBl8bL
         6hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ia83NWe8LX9zGfMIBGWxWbf+jhXbsrN3kDN4N4rBK0Y=;
        b=BpmU1zPmO2QwX8bDROicscTTG80ZdLedypaul/sLA2HEi2NCyMTTbCJEWQX9f+d100
         +5CcriLOMIva7boutgCE0+dTH6Dss4d1F6nIPTWY6nGM06aRUXdunq+4o62zsr5zF49G
         Cq/Tt0ooG+a6jcGgkeNWp62EZQewaBnF+PspJSL7acOydlX5z/BvG4DZfQ/uDKMIy3WE
         P/jwVgxXwU7XlQoWKj3+TyUwlOGM8RRVdZG6pvbK4bD2mzebxrxPZcbQbioLqkOKA8I/
         bPqFLMe2SfWH2NWigogAA6aPpVRRU0Iwul11E9eUGtm+0qhr55PpoKdPZphHXJrnHwKm
         izpg==
X-Gm-Message-State: AOAM533BhutXUqOJ2uQuupSAFtOiuPa7+7rO36RHcPJeuruIMiihbXZd
        oHisIGklv7CaVnD6YDSTY3SldQ==
X-Google-Smtp-Source: ABdhPJyRBzzlCNn9yAoYuCi1t/fyhNT55q/wMox/p3Nsux+wm2joqDdAE60nwyosH7YQ3InoEUEoQw==
X-Received: by 2002:a05:6402:28b1:b0:425:c39e:b773 with SMTP id eg49-20020a05640228b100b00425c39eb773mr16587869edb.237.1651571291277;
        Tue, 03 May 2022 02:48:11 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zp1-20020a17090684e100b006f3ef214defsm4408678ejb.85.2022.05.03.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:48:10 -0700 (PDT)
Message-ID: <9110244a-9e75-40e6-4c82-d2ef149e0e6a@linaro.org>
Date:   Tue, 3 May 2022 11:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: mfd: Add bindings child nodes for the
 Mediatek MT6360
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
References: <20220503062843.12516-1-gene.chen.richtek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503062843.12516-1-gene.chen.richtek@gmail.com>
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

On 03/05/2022 08:28, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings child nodes for the Mediatek MT6360
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Link: https://lore.kernel.org/all/YmqTzlrVL5KaVPuz@robh.at.kernel.org/
> ---
>  .../bindings/mfd/mediatek,mt6360.yaml         | 212 +++++++++++++++++-
>  1 file changed, 201 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
> index 4d8769f3748c..b3eecf661bc1 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
> @@ -37,6 +37,18 @@ properties:
>      description:
>        The first cell is the IRQ number.
>  
> +  regulators:
> +    $ref: ../regulator/mt6360-regulator.yaml
> +
> +  charger:
> +    $ref: ../power/supply/mt6360_charger.yaml
> +
> +  tcpc:
> +    $ref: ../usb/mediatek,mt6360-tcpc.yaml
> +
> +  led-controller:
> +    $ref: ../leds/leds-mt6360.yaml

Full paths everywhere here, so:
/schemas/leds/leds-mt6360.yaml#

> +
>  required:
>    - compatible
>    - reg
> @@ -51,17 +63,195 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +    #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/usb/pd.h>
>      i2c {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -
> -        pmic@34 {
> -            compatible = "mediatek,mt6360";
> -            reg = <0x34>;
> -            wakeup-source;
> -            interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> -            interrupt-names = "IRQB";
> -            interrupt-controller;
> -            #interrupt-cells = <1>;

Previous indentation was correct, don't change it from 4 spaces.

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      mt6360@34 {

What is the reason to change correct name to wrong name when adding ONLY
child nodes?

Please split any unrelated changes to separate patches, if they are
reasonable. Using wrong node name is not reasonable.

(...)

> +              port@2 {
> +                reg = <2>;
> +                endpoint {
> +                  remote-endpoint = <&dp_aux>;
> +                };
> +              };
> +            };
> +          };
> +        };
> +

no need for blank line

> +      };
>      };


Best regards,
Krzysztof
