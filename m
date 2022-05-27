Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50473535B47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348808AbiE0ISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiE0ISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:18:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF7EC3F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:18:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so4924741wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=Mlq0w9Sq3JAXLiq6IKhnHlUUJ+iRXBtNrFRhNgWew5s=;
        b=rqDgQ/xG2NU4MxSBvqKUCi8BfTiMBmKzGuJqymLNx/P6r8Ygk6b/uNL7tAFv3T/Pl9
         hHkuZ5L1OoGwXcznnrPtr5IIKBdU2UfgPoMa4hLydT6SBOQZ7+X7xK2t4Z9K3UnDSito
         6UxRheR447juFCnK1od/iMsKLAmWlkjbAJYXi0QnO2MmqL3ZJ/Vj99HB5HH0GxBz/xM+
         dFUyhfC0oVDkB3rbWbon/vFqxJI5VaHfFgmgFHMrIxT15SbCtYS/PkXEc8mSGg96ilAA
         rDavvVRqb3fIqM4xEmJF319s4jfwUl198h+I+E+BpdMR0D6D/B3K8qec81fmXDny0aNR
         ub6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Mlq0w9Sq3JAXLiq6IKhnHlUUJ+iRXBtNrFRhNgWew5s=;
        b=fecyhBUj9XXmUr+qIdFuHHMlT0humSDkF39DiWCfcde2h9rWASh28zNZ75P0s3eP+U
         4aOH55FgghR4G26eeUjez14XUsaZmgLPUWg9jS8fClMHqtYv7Be4XYzwb3W8dtqD8bwO
         q6Xj2RoQsYmUrNtOlqd3BgezgyicOZOosNHvXhMMJ973YPJGmIxtPK6mHqDyAYFAQDNx
         uMi7MRftFQNFQxK1KU7aJgU6OFfIMwVVctVXHrpsZQ4ag4TAmH6jkjSTXSrcVLfUrN9J
         iIdJO3P6+rBxqDYDoQgZ8oLn+OfmgCXVhSL0r5tVSpH7xbDmwYwYPYUcNg1SwjUOZYSf
         ICXw==
X-Gm-Message-State: AOAM530fLQbdPLG+lQJyWoZG7KMwnZr0Oxwd8Vf42ADKvsp28FrZohqe
        Bjznz+gi4WDGy3yciPFDjfY4dg==
X-Google-Smtp-Source: ABdhPJyYzDfcTwaDTmQ8hJx/lTQ/NCKoiSSHk/AYU3xNnZteyuNsH7HPgEVmJ+crsBlwaPJ1cqlX9g==
X-Received: by 2002:a5d:6041:0:b0:20d:8e4:7bb8 with SMTP id j1-20020a5d6041000000b0020d08e47bb8mr33591979wrt.652.1653639507562;
        Fri, 27 May 2022 01:18:27 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:f081:5ded:fc86:365d? ([2001:861:44c0:66c0:f081:5ded:fc86:365d])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm1439480wmc.47.2022.05.27.01.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 01:18:27 -0700 (PDT)
Message-ID: <4b3aa028-fd29-0053-e8d3-ce16c5d4b078@baylibre.com>
Date:   Fri, 27 May 2022 10:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64: dts: amlogic: adjust whitespace around '='
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 22:45, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Output compared with dtx_diff and fdtdump.
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi                      | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi                       | 2 +-
>   .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 3f5254eeb47b..04f797b5a012 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1535,7 +1535,7 @@ aobus: bus@ff800000 {
>   
>   			sysctrl_AO: sys-ctrl@0 {
>   				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
> -				reg =  <0x0 0x0 0x0 0x100>;
> +				reg = <0x0 0x0 0x0 0x100>;
>   
>   				clkc_AO: clock-controller {
>   					compatible = "amlogic,meson-axg-aoclkc";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index aa14ea017a61..023a52005494 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -450,7 +450,7 @@ aobus: bus@c8100000 {
>   
>   			sysctrl_AO: sys-ctrl@0 {
>   				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
> -				reg =  <0x0 0x0 0x0 0x100>;
> +				reg = <0x0 0x0 0x0 0x100>;
>   
>   				clkc_AO: clock-controller {
>   					compatible = "amlogic,meson-gx-aoclkc";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index fcb304c5a40f..6831137c5c10 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -216,7 +216,7 @@ &uart_A {
>   
>   	bluetooth {
>   		compatible = "realtek,rtl8822cs-bt";
> -		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>   		host-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
>          };
>   };

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
