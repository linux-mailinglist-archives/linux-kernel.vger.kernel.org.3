Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7554559A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiFIU2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiFIU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:28:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80A1E04B1;
        Thu,  9 Jun 2022 13:28:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j20so3816179ljg.8;
        Thu, 09 Jun 2022 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=46OkSZCeD56sfzrRV9ixVa9kbc26s0RkXULJ1qM0uHw=;
        b=Cqo4DSvIxHUHTuqtmXxBEQEss56ECscrzgfl6tFBQQHCwHv4gHc+tfptnqcWotUnwn
         kfM7AqT75NAxphIsW4UmWdx1OMvBH82UlNcB/J3l+xA8Q25UnaHbCypKPUGW1epXcIKW
         3IBLprzy5gOxwNAFx+x8NZCg3gTeT62BvN7F1YSOfoRuJo6+ew2xM1G0cAoCpdUwZ2kp
         kZBttUZCWNmLKpe7pg00P+/0iVJoNtSmAcO2jLvQpGHsCBOGni1DyGQUkMTpo0JoxCH9
         /8y4RA7vHZS/yy51dpCqH9fZ3EATcI+zV+1c4+nvuiJCJ6JNvUwSokhuStUyONTQ67/k
         fLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=46OkSZCeD56sfzrRV9ixVa9kbc26s0RkXULJ1qM0uHw=;
        b=n5x0kifhw/XGnaQXvwgLnhiWKRWXJsclrdhZtZ+MFE3vcDQylP9seGTIosf9sN5kbv
         +uim5SpRX2nxlmpE+Ou1M45OgkF41lo1rrVybdtcZi+gV+1lGdaF19zJpjGQqx0ezvbY
         ckNcJ4vpik7Eqmc3TK+0tLuRgG+K7QniKAZCZeo7u6zpxBdaLmkr5yWB0Kmig+xM4ZId
         aLn1H1VBdJAfzu3JyOYYJmezTf+jrJdLG4p10hGJhppe3BD2dwPMHlJjL53+bp9RMjhp
         xabITciWrpwoimZOHuw/kZ6WHtvVlouZsxXnr0SJ7j5xp9Zuz2o8Fhn3uEqS524q24hC
         42lQ==
X-Gm-Message-State: AOAM533A9J74+6G4MoKKclP9PSKlioUoogoeRoLomiOwvDCDqAFDlp2L
        weYvOrOVrRbXyGVSwLf3LsiSRjVTro0=
X-Google-Smtp-Source: ABdhPJyyeult8NpzAQqn7PaWa4sRx7dCdjWErZ27oucNSpMUlcJj32mPjTi39OlTcDR82vmZrn5E7w==
X-Received: by 2002:a2e:9808:0:b0:255:59c1:3086 with SMTP id a8-20020a2e9808000000b0025559c13086mr27890832ljj.495.1654806498059;
        Thu, 09 Jun 2022 13:28:18 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b004744bfd620fsm198164lfr.236.2022.06.09.13.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:28:17 -0700 (PDT)
Message-ID: <d6d1642c-26b4-e4a8-5ae7-c4b952ae6c62@gmail.com>
Date:   Thu, 9 Jun 2022 22:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] dt-bindings: leds: skyworks,aat1290: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 6/7/22 10:53, Krzysztof Kozlowski wrote:
> Convert the Skyworks Solutions, Inc. AAT1290 Current Regulator bindings
> to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[...]
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    // Ct = 220 nF, Rset = 160 kOhm
> +    led-controller {
> +        compatible = "skyworks,aat1290";
> +        flen-gpios = <&gpj1 1 GPIO_ACTIVE_HIGH>;
> +        enset-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
> +
> +        pinctrl-names = "default", "host", "isp";
> +        pinctrl-0 = <&camera_flash_host>;
> +        pinctrl-1 = <&camera_flash_host>;
> +        pinctrl-2 = <&camera_flash_isp>;
> +
> +        led {
> +            label = "flash";

Why are you adding label? It is deprecated, but has the precedence over
new function and color for backwards compatibility, so it would make
those unused by the driver now. Please drop the label from this example.

> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            led-max-microamp = <520833>;
> +            flash-max-microamp = <1012500>;
> +            flash-max-timeout-us = <1940000>;
> +        };
> +    };

-- 
Best regards,
Jacek Anaszewski
