Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1F54F5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382008AbiFQKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382005AbiFQKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:43:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526306B098;
        Fri, 17 Jun 2022 03:43:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n20so1213445ejz.10;
        Fri, 17 Jun 2022 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=AiGd/G18mnXfAnwyT/vN2yw57fx/1UEELfONJBgsPiU=;
        b=VJGDBaLwKCaTN0E3YXVF9jHgxLrlNG7667EGq4tM8lH0Jj5v9IeJ8Bp5VWKq5NMyYb
         5iMXOXz2KivIOmNkOxjk4YgJL5l3L9HKBsazeqCv8lVt/dcBtU8qfDqfmHEQZZQdetrq
         97mTgq9S+mBB4iprd0LRRQxKEmQGn6d9auRVXTdQ3HImBt3EiTBui/aJIK98KA5pph6p
         OZNU0KgucPKhFX8qM53dhe3LQUOFyJCpS/tcexfirlbNPevl5K7UwUwf92nmrtSCtUHL
         t+BKrJoviExSkCSNDQLMaY3h82RHo66dvs7SjNMGC6SKbB9SZexPspyWcaBwwm7yTdJ/
         UKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AiGd/G18mnXfAnwyT/vN2yw57fx/1UEELfONJBgsPiU=;
        b=P/bF1ATpoe1nzYyDfgCY6iojSQO9SncUMLldgj4V58HeSEo/sNhfXR5v19TJfjhq2Z
         CxGW0kDvybarokjC8xMODMNhD/Hk0vlMR5FYrek6tg0SsebQjPerQafcexZctikdkV7e
         tYBAvEPtDwrPAhAzBOxPUktmWCWbDffpMZs9oznI2rR9BQniy/hfhU339M2KILBguTxO
         HPmWF4nIa6yD7pLBqie5QsbZ1Y5XVB0YsLUpaLuuqxOJM2lv9ZOck8nWDK5HcfCQBWj8
         vJX0kD5K+KCzybr4liK+w6Na1/kIdRELxG4/5aOSuBhrxTI9XSBQ5hZE03cQaxF05Gqi
         tiiw==
X-Gm-Message-State: AJIora91KBL80RTh3Ms0YuwvuANO/6vQjZJnqPUu5E/j89HOlUIwOTYd
        9zv3vD6QCNYXL8mddWZwP94=
X-Google-Smtp-Source: AGRyM1u5wVHvSt+IqLZK0au6HLE1grAgjeBZEKVVVQaH/p4dMq24y0opu3PhRSo42Jyp+s1jT4scDg==
X-Received: by 2002:a17:906:7a57:b0:711:faf1:587d with SMTP id i23-20020a1709067a5700b00711faf1587dmr8328834ejo.581.1655462628898;
        Fri, 17 Jun 2022 03:43:48 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042dcac2afc6sm3425003edu.72.2022.06.17.03.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:43:47 -0700 (PDT)
Message-ID: <8f9d7850-fe31-41b3-cded-63a020356e13@gmail.com>
Date:   Fri, 17 Jun 2022 12:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 16/40] arm64: dts: mediatek: mt7622-bananapi-bpi-r64:
 align led node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-16-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616005333.18491-16-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> with 'led'.  Use generic color properties instead of the node name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index c2311733d2de..7d1ecf72a6c3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -8,6 +8,7 @@
>   /dts-v1/;
>   #include <dt-bindings/input/input.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>   
>   #include "mt7622.dtsi"
>   #include "mt6380.dtsi"
> @@ -56,14 +57,16 @@ wps-key {
>   	leds {
>   		compatible = "gpio-leds";
>   
> -		green {
> +		led-0 {
>   			label = "bpi-r64:pio:green";
> +			color = <LED_COLOR_ID_GREEN>;
>   			gpios = <&pio 89 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
>   
> -		red {
> +		led-1 {
>   			label = "bpi-r64:pio:red";
> +			color = <LED_COLOR_ID_RED>;
>   			gpios = <&pio 88 GPIO_ACTIVE_HIGH>;
>   			default-state = "off";
>   		};
