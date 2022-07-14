Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46CD574AED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiGNKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiGNKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:41:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3B2B62E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:41:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w17so1671389ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C8CvhNa0+ZVCQpOMfkAiiXSqKl0f4IhSMmX8m0rrST8=;
        b=BQTmx9g7xNGdgaTGyEk7Z7os4c0w8530TS8aIQJM6Gs+qdKQSSg4esh3elB8d5Es/H
         RGHpEvb2bBHUVT56CUZOVE07HwZ11gRWxrxMJnAeBZwYfZaymr51mMveqsdcDxeWsC2z
         NLQvpNLu77VXRS1VVLPgkA6+1XhVye3oxSxLYyeFivXab06ieuXguZb/8yLPOV+OaFj8
         FiBYhTZdUAEk77a7/ZkNo4ksPtyVwoaCh9avzkgeI9/YFufw00BUyasyjyI0XACYWDci
         UPN7lPuf9syGA51vBdNpL+HMmnYYA9hTKr3CGCO0j9PVmIdDUHA6WRr5HXin8XDXQPJ9
         sBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8CvhNa0+ZVCQpOMfkAiiXSqKl0f4IhSMmX8m0rrST8=;
        b=S8wkmPIZT4xkZbTJkl50lZyorypSrCQCQgJwftNp00BEV5aPzTAiCN0Jl2DCFJRGeP
         BdIoMTwUESBqTtq0mAqeuq+GJuGnvAYKwadDidGVX7r8Ua5idGHeB7nsfYfmsvJbe2/t
         ON0ICeGiV1vjLXdF1ojMnDGtZycplR76qIcDKvjQVEL+7Z3DCDF36/Q0YfCBse874iud
         I4Zfk1+FVSNzViFHxi68gsXci3VOlyo7UN1EO2BnF40ADCAJ8GaQoV+cXJVkUz0TKTjE
         WTnoryY1M3cvBrp0JxPAUt0o5wyPG0SQSQerA2j9HF5hNU06didaA99IFQlr24ByoYLa
         KK4w==
X-Gm-Message-State: AJIora9qgVW2BXXJZtEHQRqcL4olIT4lEp3sCv/aBuESHjldXN6XZ+uf
        BHZZpQNB92nMnzES8faruiluUw==
X-Google-Smtp-Source: AGRyM1uUgqu8jCuqmv6DYP9omOKmzkRlajVMY/Ho/tM0y/cmJS8OPaNxw2wv2XW7TCkhHeEplk4WlQ==
X-Received: by 2002:a2e:9b0b:0:b0:25d:5ae6:4286 with SMTP id u11-20020a2e9b0b000000b0025d5ae64286mr4017670lji.148.1657795265748;
        Thu, 14 Jul 2022 03:41:05 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f03000000b00478fe3327aasm288132lfq.217.2022.07.14.03.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:41:05 -0700 (PDT)
Message-ID: <df017bc8-3aa3-18e6-9632-94eb071afe68@linaro.org>
Date:   Thu, 14 Jul 2022 12:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: dt-bindings: atmel,at91sam9-wdt: convert to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        eugen.hristev@microchip.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220714101242.103521-1-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714101242.103521-1-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 12:12, Sergiu Moga wrote:
> Convert at91sam9 WDT binding for Atmel/Microchip SoCs to Device Tree
> Schema format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/watchdog/atmel,at91sam9-wdt.yaml | 127 ++++++++++++++++++
>  .../bindings/watchdog/atmel-wdt.txt           |  51 -------
>  2 files changed, 127 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
> new file mode 100644
> index 000000000000..b3f7cbe913a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/atmel,at91sam9-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Watchdog Timers
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +  - if:
> +      properties:
> +        atmel,reset-type:
> +          enum:
> +            - all
> +            - proc
> +    then:
> +      properties:
> +        atmel,watchdog-type:
> +          const: hardware

Entire allOf in such case goes after "required:".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
