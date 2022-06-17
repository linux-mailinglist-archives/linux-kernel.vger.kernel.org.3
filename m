Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1554F5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382000AbiFQKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382043AbiFQKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:43:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA276B098;
        Fri, 17 Jun 2022 03:43:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 25so5645031edw.8;
        Fri, 17 Jun 2022 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=v5ecjoqfrtonTaDC6C0FL6A10bdamLrdFYiT8G5VOw4=;
        b=i9vP6RSHB3vHCWE4RcV+HJ7iNa3yq76y+QY1jM2hM3XW30wf/IpH2PYhW7PjjWYdPl
         FnqF4MY1FWpWmG/tInRWbGGRUlq5fOUBIRpqGOUPd00Y0fJI+wBSk0Sk/D/TyosFFW5R
         eDf3zmrZD/g1r7hS3VyzLNDAbbkl16Bhal3vADJhDYj3ELdqcONpuYcNn0AfBNvr6vGi
         VBSww3vMhxoeLHx3ZWL2K7B9n0zo1x4SBXkekziqpWI5BcKNBpIH12C66NB/XTdHMMl8
         k4KSyVmEIab/YXL6INbKpXWiiTJuNemZKohU4Afojnen0VzWidI7IsWlIxHRLKMHeyz7
         BIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5ecjoqfrtonTaDC6C0FL6A10bdamLrdFYiT8G5VOw4=;
        b=cXgU7NoOUynSXmfj8MV7B29KsJukY5Ru5lUvw/veYQqMfzNhAziPhwsZ826FtBks8t
         rkHIFjXieZEg8lLNA99XL288v2OerDc2xolN720Y1izNx8lxPw/eYLtXrt5yHnJV/BNb
         3wVHeiNU0H05kMZ7bhSzhTwFI9j2XyaUPudZLQM5uFv1fNturTKEP01XSM4BeFTw2Jfy
         SuvTgZDDS/+zsH8BGREbBi9zJa57J1DXGvTmdYKE+ZBKmE2BxZrgMAyuIvqb+TYSPQXb
         d4Z3owi0PpjIbs7eB/C3hLUDH1qs081qAmiCIUnBi7ETuUVuSewM+NgYlQm9Ap/jV1cR
         K4VA==
X-Gm-Message-State: AJIora9uye3NVUfoGDu/vuB7AylaUlwXkZN96zbJmYTVF8rsfA7Yn7sb
        In8e2jSZ10JFJCkFDgS3oerDYlrIZy3nSw==
X-Google-Smtp-Source: AGRyM1vGje4sUJAcYpjSJzolDvmR/43gla1gcSQu/6kGI0U0BANsb2e78Xdl4mzbofJwfzp3bj4U5w==
X-Received: by 2002:a05:6402:334:b0:435:584e:514c with SMTP id q20-20020a056402033400b00435584e514cmr6465853edw.410.1655462620199;
        Fri, 17 Jun 2022 03:43:40 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7cd90000000b0042fb3badd48sm3464631edv.9.2022.06.17.03.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:43:39 -0700 (PDT)
Message-ID: <7788acc5-a9b9-1be7-0e6f-217e9b54b28f@gmail.com>
Date:   Fri, 17 Jun 2022 12:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 15/40] arm64: dts: mediatek: align gpio-key node names
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
 <20220616005333.18491-15-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616005333.18491-15-krzysztof.kozlowski@linaro.org>
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

Applied, thanks

> ---
>   .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts      |  4 ++--
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts           |  4 ++--
>   arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts  |  6 +++---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi           | 10 +++++-----
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi |  4 ++--
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  |  2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi         |  2 +-
>   arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi       |  4 ++--
>   8 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index 2b9bf8dd14ec..c2311733d2de 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -40,13 +40,13 @@ cpu@1 {
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   
> -		factory {
> +		factory-key {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		wps {
> +		wps-key {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 102 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index 596c073d8b05..c28da9323a9c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -42,13 +42,13 @@ gpio-keys {
>   		compatible = "gpio-keys";
>   		poll-interval = <100>;
>   
> -		factory {
> +		key-factory {
>   			label = "factory";
>   			linux,code = <BTN_0>;
>   			gpios = <&pio 0 0>;
>   		};
>   
> -		wps {
> +		key-wps {
>   			label = "wps";
>   			linux,code = <KEY_WPS_BUTTON>;
>   			gpios = <&pio 102 0>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> index 44f6149c1307..28433b94f7c7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> @@ -21,7 +21,7 @@ cpu_crit: cpu_crit0 {
>   };
>   
>   &gpio_keys {
> -	/delete-node/tablet_mode;
> -	/delete-node/volume_down;
> -	/delete-node/volume_up;
> +	/delete-node/switch-tablet-mode;
> +	/delete-node/switch-volume-down;
> +	/delete-node/switch-volume-up;
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 9c75fbb31f98..d20378758213 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -53,7 +53,7 @@ gpio_keys: gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&gpio_keys_pins>;
>   
> -		lid {
> +		switch-lid {
>   			label = "Lid";
>   			gpios = <&pio 69 GPIO_ACTIVE_LOW>;
>   			linux,code = <SW_LID>;
> @@ -61,7 +61,7 @@ lid {
>   			gpio-key,wakeup;
>   		};
>   
> -		power {
> +		switch-power {
>   			label = "Power";
>   			gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
>   			linux,code = <KEY_POWER>;
> @@ -69,7 +69,7 @@ power {
>   			gpio-key,wakeup;
>   		};
>   
> -		tablet_mode {
> +		switch-tablet-mode {
>   			label = "Tablet_mode";
>   			gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
>   			linux,code = <SW_TABLET_MODE>;
> @@ -77,13 +77,13 @@ tablet_mode {
>   			gpio-key,wakeup;
>   		};
>   
> -		volume_down {
> +		switch-volume-down {
>   			label = "Volume_down";
>   			gpios = <&pio 123 GPIO_ACTIVE_LOW>;
>   			linux,code = <KEY_VOLUMEDOWN>;
>   		};
>   
> -		volume_up {
> +		switch-volume-up {
>   			label = "Volume_up";
>   			gpios = <&pio 124 GPIO_ACTIVE_LOW>;
>   			linux,code = <KEY_VOLUMEUP>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 2d7a193272ae..3ac83be53627 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -73,7 +73,7 @@ volume_buttons: volume-buttons {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&volume_button_pins>;
>   
> -		volume_down {
> +		button-volume-down {
>   			label = "Volume Down";
>   			linux,code = <KEY_VOLUMEDOWN>;
>   			debounce-interval = <100>;
> @@ -81,7 +81,7 @@ volume_down {
>   			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		volume_up {
> +		button-volume-up {
>   			label = "Volume Up";
>   			linux,code = <KEY_VOLUMEUP>;
>   			debounce-interval = <100>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> index 28966a65391b..50a0dd36b5fb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> @@ -45,7 +45,7 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pen_eject>;
>   
> -		pen-insert {
> +		switch-pen-insert {
>   			label = "Pen Insert";
>   			/* Insert = low, eject = high */
>   			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index b035e06840e6..b50261e8b9ed 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -144,7 +144,7 @@ wifi_wakeup: wifi-wakeup {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&wifi_pins_wakeup>;
>   
> -		wowlan {
> +		button-wowlan {
>   			label = "Wake on WiFi";
>   			gpios = <&pio 113 GPIO_ACTIVE_HIGH>;
>   			linux,code = <KEY_WAKEUP>;
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index 7a717f926929..8ee1529683a3 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -28,7 +28,7 @@ gpio-keys {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&gpio_keys_default>;
>   
> -		volume-up {
> +		key-volume-up {
>   			gpios = <&pio 42 GPIO_ACTIVE_LOW>;
>   			label = "volume_up";
>   			linux,code = <115>;
> @@ -36,7 +36,7 @@ volume-up {
>   			debounce-interval = <15>;
>   		};
>   
> -		volume-down {
> +		key-volume-down {
>   			gpios = <&pio 43 GPIO_ACTIVE_LOW>;
>   			label = "volume_down";
>   			linux,code = <114>;
