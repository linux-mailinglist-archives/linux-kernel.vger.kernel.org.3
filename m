Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5649454F5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382011AbiFQKoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381958AbiFQKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:44:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF456B0A9;
        Fri, 17 Jun 2022 03:44:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hj18so7385748ejb.0;
        Fri, 17 Jun 2022 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=otzMXO+UzjAVntuNvFzmToiaj0Xvl10WTmF2X1x20Gs=;
        b=NbYG0/ltrsRmRfUcWflVhrJw27NKwjWAIJLlH+BtGanROc2UkceKeROAUsMGYNWAYm
         uwjxjB4sww9rCvxZbMcmzK7/o+ko5hPycRmwL9Z41FT2agzVwgKMgk1bJZjOhg7IMdfH
         Erxa5b6ZPlPWptAUQ0GTIFYhFm7r5RO2nMOry269LSBYPA3G/CgBzAvadEGWF8wDHfPR
         IWysUmq0Jnp2S2O9LKnUd9akvLGUdYQOkjkyqzRZXnjMe4/4PuNyQfz0AeY//YMvqjz/
         wlPEWG3jjFg1wxOH2SA3BA0ladlyO8vWZH4kEiXJsrKgFRux5hSNtg4XX8z0Ysl1aCPd
         xEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=otzMXO+UzjAVntuNvFzmToiaj0Xvl10WTmF2X1x20Gs=;
        b=ytRJC8BM69peWevUmlz8wa9HXE+sHcqbZJzvHPKt7U+8OW0JRlAJM79hPZgLB+NF2s
         hEt9M7x9YT4c9DmRDK4VcWsztKJZCJyZUQGJkhLqpVswJm+LlacQNpcD9t7jl01L1nZi
         kHDaYWxfin2IR8eyX92wWjVHthorJZkbRteaX3uFiaXEji/ecbymCPnIu4jsuE/DZEiF
         e/zujuEYEdOrWAahJm+Ed/grBsjxUlcocOmi/W1njTSYrxr3AK++GFGS7qjzccVYQ+l9
         Na3HoBl3gSF8/ewQiH7m5j9WwCZYpwZ6kqnTpkRKvp+tTR3r2ztZshbjws6dkQrxjY4S
         7ImA==
X-Gm-Message-State: AJIora/0QoEEOAuGp6Zvfa0Ui78cgNSS9t/B3S7Sm7yfV75mw5qI5Hl3
        PQ4zMUZzOuccu7HkqPAVf0s=
X-Google-Smtp-Source: AGRyM1tTm4mmAhpPdwZ1D1xqJQ5B0eHb98NUmc1YWQWMSXAhfW1NR8KcCN8FzvGnAS9VZWpLUFAjtQ==
X-Received: by 2002:a17:906:2cc8:b0:6fd:d8d8:b8f3 with SMTP id r8-20020a1709062cc800b006fdd8d8b8f3mr8655303ejr.384.1655462674583;
        Fri, 17 Jun 2022 03:44:34 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id y3-20020a056402358300b0042dc25fdf5bsm3632843edc.29.2022.06.17.03.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:44:33 -0700 (PDT)
Message-ID: <edc8933a-5433-8fe9-f5ab-5efeaa6cde78@gmail.com>
Date:   Fri, 17 Jun 2022 12:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 18/40] ARM: dts: mediatek: align gpio-key node names
 with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-18-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616005333.18491-18-krzysztof.kozlowski@linaro.org>
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
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

> ---
>   arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 4 ++--
>   arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 4 ++--
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 4 ++--
>   arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 4 ++--
>   arch/arm/boot/dts/mt7629-rfb.dts              | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
> index 13c86936d1c8..e8b4b6d30d19 100644
> --- a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
> +++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
> @@ -45,13 +45,13 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&key_pins_a>;
>   
> -		factory {
> +		button-factory {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		wps {
> +		button-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
> index 88d8f0b2f4c2..61f5da68d4b0 100644
> --- a/arch/arm/boot/dts/mt7623a-rfb-nand.dts
> +++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
> @@ -45,13 +45,13 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&key_pins_a>;
>   
> -		factory {
> +		button-factory {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		wps {
> +		button-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 027c1b0c6a98..5008115d2494 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -91,13 +91,13 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&key_pins_a>;
>   
> -		factory {
> +		button-factory {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		wps {
> +		button-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> index 1b9b9a8145a7..bf67a8e9be59 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> @@ -60,13 +60,13 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&key_pins_a>;
>   
> -		factory {
> +		button-factory {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		wps {
> +		button-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
> index eb536cbebd9b..84e14bee7235 100644
> --- a/arch/arm/boot/dts/mt7629-rfb.dts
> +++ b/arch/arm/boot/dts/mt7629-rfb.dts
> @@ -23,13 +23,13 @@ chosen {
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   
> -		reset {
> +		button-reset {
>   			label = "factory";
>   			linux,code = <KEY_RESTART>;
>   			gpios = <&pio 60 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		wps {
> +		button-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 58 GPIO_ACTIVE_LOW>;
