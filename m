Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF00535B49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiE0ISl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348906AbiE0ISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:18:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163BBED8F2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:18:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q20so351566wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=ZkFo19yN9FE8l6w1oc0IJiQl2EoWP33mdxcOBd2mVFc=;
        b=Fq9c32hxcx2ufnuS5yUUdwgf84fJ2V+HR5zXjKcBgRRQOBn4Oo+Y8PIBAAJ0eAGKis
         BFq8Tk+WkMh/OpMKqPxu/qDH20z/0g2Bu6S8gNtK+qUGjyVeDQ+QCHdDUEIhiM69KTww
         kB3Put3kNcCckMhB+JJdnh7Xq3M0LVZC8tIFMlpEgP3SxokQvFGjVw/RAL3kY8sTL1Kh
         pqEWSwQcYGhjLE01TMhH1jN7uXz6ebJsZ4yeKtRSOIOJpljU58WV9IlzyfOLS+A16ABz
         9GQnTG5cJGDEJHaTbumnaHlKut9Gc/NSmWOT5otOpcjqqnNXttpKcqTJXWtIV6XqOQYg
         iHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZkFo19yN9FE8l6w1oc0IJiQl2EoWP33mdxcOBd2mVFc=;
        b=xoD6/3uAF6go1gG1j+r+X4ai+qiwB3j8AyODcVDT6uGgqOK0XFAwmp/EtwNzdXhlW0
         CN8vZS9H5+aeVFIOBM+mAxtOTS0Kzo1hIhktt4zbMuNW1gWH/y3cvEaY+6zwwywBiVgl
         pGqp/7oS4y5eBd41UbIN9yfIOVAH6DoGpPFiaoNaIt+bL3r3CFgebFaqEBBqRYSiJSUX
         dZGXWb0Npfx0W6ue8Xhkmj9i20IIN495Rbk6FwmiI21bVmgKMQOyttnw8JcDnir/g5ak
         D7k/K8LiXBcoy/+NiBlZYZRGawlwgl7tZGuEIaMDEq/PFOAgwRZsYPmrZQ9nly+1xDaP
         /U/A==
X-Gm-Message-State: AOAM532brWX8anv2TlU8PZTspK/StPyMRrLv655Il7uvckWeo4GzfF99
        MBgOpGwQXbFPNuyWcpQ8ASd/xw==
X-Google-Smtp-Source: ABdhPJz+oqbBEG4R4LguW/AlVaAt1T7SUCg4RxJCopLYPsk+CUpf7UJyCqHBCjs0nVw/onX+8/KQFA==
X-Received: by 2002:adf:e28a:0:b0:210:b31:722 with SMTP id v10-20020adfe28a000000b002100b310722mr5408462wri.65.1653639515570;
        Fri, 27 May 2022 01:18:35 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:f081:5ded:fc86:365d? ([2001:861:44c0:66c0:f081:5ded:fc86:365d])
        by smtp.gmail.com with ESMTPSA id v18-20020adfebd2000000b0020c5253d8besm1130050wrn.10.2022.05.27.01.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 01:18:35 -0700 (PDT)
Message-ID: <19a9260c-322b-10e1-e361-cc2d5fdd8ff9@baylibre.com>
Date:   Fri, 27 May 2022 10:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] ARM: dts: meson: adjust whitespace around '='
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
 <20220526204552.832961-2-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220526204552.832961-2-krzysztof.kozlowski@linaro.org>
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
>   arch/arm/boot/dts/meson.dtsi   | 4 ++--
>   arch/arm/boot/dts/meson8.dtsi  | 2 +-
>   arch/arm/boot/dts/meson8b.dtsi | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index 26eaba3fa96f..8e3860d5d916 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -214,14 +214,14 @@ aobus: aobus@c8100000 {
>   			ranges = <0x0 0xc8100000 0x100000>;
>   
>   			ao_arc_rproc: remoteproc@1c {
> -				compatible= "amlogic,meson-mx-ao-arc";
> +				compatible = "amlogic,meson-mx-ao-arc";
>   				reg = <0x1c 0x8>, <0x38 0x8>;
>   				reg-names = "remap", "cpu";
>   				status = "disabled";
>   			};
>   
>   			ir_receiver: ir-receiver@480 {
> -				compatible= "amlogic,meson6-ir";
> +				compatible = "amlogic,meson6-ir";
>   				reg = <0x480 0x20>;
>   				interrupts = <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>;
>   				status = "disabled";
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 9997a5d0333a..0f8bac8bac8b 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -430,7 +430,7 @@ mux {
>   };
>   
>   &ao_arc_rproc {
> -	compatible= "amlogic,meson8-ao-arc", "amlogic,meson-mx-ao-arc";
> +	compatible = "amlogic,meson8-ao-arc", "amlogic,meson-mx-ao-arc";
>   	amlogic,secbus2 = <&secbus2>;
>   	sram = <&ao_arc_sram>;
>   	resets = <&reset RESET_MEDIA_CPU>;
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 94f1c03decce..cf9c04a61ba3 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -384,7 +384,7 @@ mux {
>   };
>   
>   &ao_arc_rproc {
> -	compatible= "amlogic,meson8b-ao-arc", "amlogic,meson-mx-ao-arc";
> +	compatible = "amlogic,meson8b-ao-arc", "amlogic,meson-mx-ao-arc";
>   	amlogic,secbus2 = <&secbus2>;
>   	sram = <&ao_arc_sram>;
>   	resets = <&reset RESET_MEDIA_CPU>;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
