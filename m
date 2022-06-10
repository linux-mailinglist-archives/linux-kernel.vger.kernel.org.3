Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4147546322
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347914AbiFJKGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348679AbiFJKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:05:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C74B57B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:05:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h19so34630250edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Q5vsmxWtwaYG8oW1AvQlgwQ8iE5Q0pMcGpxfbWiaZG0=;
        b=mAwnc2FFbtLQIpZr3EhYJcGHEjUDTrbX5Jx0lJTRxxZ0qBjgwzPJoDo1t/rjo0CWE3
         yerDl7ktV0DQWz4+QGdECsB949KbT+RbfG3jjSbSDHNcLk/Qq32eONfK5Y+syiadgwxc
         ksxL5klIEiyxCxjJvC8ufzFhxN2Xdp4ryDJ2tg7eEFag1jBlUpf70OVlutNMCQvvFixk
         895brrs4P/H1ae1l2GIH/45CaIzX/PQ3r60ns2tsqGQzOzuj0bVlcbrTvxO6/D2WULPH
         VqEwY5ydtSucv3FLVw+nIzGu2j0Jn0IuF9KeJQMxm25MK3JNOoeX21Lku7r4L+7+wnEq
         em5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q5vsmxWtwaYG8oW1AvQlgwQ8iE5Q0pMcGpxfbWiaZG0=;
        b=EJpF7TDB2LxcIelFelVN4lsKj5p3CZYIGh53KhMCUXEcOS2Ry8DHy3ovW/bZ9yticd
         kcYDeh/26SIuwchLBtfNL1afTjxBHv484SuBi1wAKi5jYc4bnN9/47qdDL/5Fi/VG2az
         EHmwiQmehT4xNH+S/4rGSZgjcVZT3lB06LNvyNMOdz+HKLQMUJa4z1Bik8mxif29V2jn
         HF3BglXJPe97Qh6yxsSmSVctAU8IsUH9GUVsoXd7QJKgLCsWCxeMYeqc4n58ATdVqHCO
         ZJFBL2chW5WEsIldKAsfGv5H/I8bhjrffaB3bRQmMCqlyfEcRv9Q3gNZqOE321asLcWT
         mUeg==
X-Gm-Message-State: AOAM5312aHMyOsWAq1JsRrSHlLyhICzG2AOmLMr/vtS44AXhxZwbpfJK
        /9euY1n8pfQ8ry5bOZEvN/+vKw==
X-Google-Smtp-Source: ABdhPJw+10Yv7YpKYQWS1YFaBYbE6qXvaEMzJNgXTJK+zRmZH81nGhz+1LAX3otPNb4lPpztjPphrw==
X-Received: by 2002:a05:6402:50:b0:431:69fc:eff4 with SMTP id f16-20020a056402005000b0043169fceff4mr26419944edu.243.1654855553741;
        Fri, 10 Jun 2022 03:05:53 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm9834067ejp.96.2022.06.10.03.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:05:53 -0700 (PDT)
Message-ID: <537986d4-376e-d787-1581-cf0b0d525daa@linaro.org>
Date:   Fri, 10 Jun 2022 12:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 44/48] ARM: dts: at91: align gpio-key node names with
 dtschema
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, arnd@arndb.de, olof@lixom.net,
        arm@kernel.org, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, peda@axentia.se,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609114047.380793-5-krzysztof.kozlowski@linaro.org>
 <42e8f573-cfc2-dfa4-1740-b0a29521628e@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <42e8f573-cfc2-dfa4-1740-b0a29521628e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 09:12, Claudiu.Beznea@microchip.com wrote:

>>                 compatible = "gpio-keys";
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pinctrl_key_gpio_default>;
>>                 status = "okay";
>>
>> -               sw1 {
>> +               switch-1 {
> 
> This is acutally a button labeled on board as SW1. It has been wrongly
> carried over from older DTSes. Maybe it would worth to have it now here as
> button instead of switch.

Sure, I'll name it "button-1". Could be also "button-sw1" if ou prefer.

> 
>>                         label = "SW1";
>>                         gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
>>                         linux,code=<KEY_PROG1>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> index 08f0d4b995ff..96c9290007a8 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
>> @@ -478,13 +478,13 @@ can1: can@fc050000 {
>>                 };
>>         };
>>
>> -       gpio_keys {
>> +       gpio-keys {
>>                 compatible = "gpio-keys";
>>
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pinctrl_key_gpio_default>;
>>
>> -               pb4 {
>> +               button {
>>                         label = "USER";
>>                         gpios = <&pioA PIN_PA29 GPIO_ACTIVE_LOW>;
>>                         linux,code = <KEY_PROG1>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> index 5e8755f22784..d5652c974748 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
>> @@ -26,14 +26,14 @@ chosen {
>>                 stdout-path = "serial0:115200n8";
>>         };
>>
>> -       gpio_keys {
>> +       gpio-keys {
>>                 compatible = "gpio-keys";
>>
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pinctrl_key_gpio_default>;
>>                 status = "okay";
>>
>> -               sw4 {
>> +               switch-4 {
> 
> Same here, this is a button not a switch.

Sure, then button-1 or button-sw4

> 
>>                         label = "USER BUTTON";
>>                         gpios = <&pioA PIN_PB2 GPIO_ACTIVE_LOW>;
>>                         linux,code = <KEY_PROG1>;
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
>> index 806eb1d911d7..d7b59e16a081 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
>> @@ -42,14 +42,14 @@ main_xtal {
>>                 };
>>         };
>>
>> -       gpio_keys {
>> +       gpio-keys {
>>                 compatible = "gpio-keys";
>>
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&pinctrl_key_gpio_default>;
>>                 status = "okay";
>>
>> -               sw4 {
>> +               switch-4 {
> 
> Same here, button not switch.
> 
> Other than this, looks good to me.

Thanks for checking


Best regards,
Krzysztof
