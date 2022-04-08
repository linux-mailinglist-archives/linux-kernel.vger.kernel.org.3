Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED84F8F71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiDHHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDHHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:24:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667A02AEE2C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:22:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v20-20020a05600c15d400b0038e9a88aee7so1802776wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=HwBqnOa1E0VlKqSq871tPPYQ3FcLKgr7WO5uW7Uw2Eo=;
        b=qPq7Ttkmagr0EKp8wlqfUPgVgLcoiaYn151NPeEAixOI0CRtf6dSduscBxufr4uM3v
         KH6eA4pvw+dWR78LOfdNN3ZtNEJvK9JgmWh+P3Id3JnSiC8VHbS2bobN47ktnZqN4erm
         gkjunFOKEuN8yf5oKbBjkvN05FLNImEXRVs+M3d9bSHAS0o6sw8eOUHHsYH4ib2rYcox
         U2WB+xTfDCb08r5MdnH5hAOrC9iKJ0kiGkUPozet3TWbUZ/lcY89Ljhj06OuvuhzHjkg
         wRCx7lS1XnZj1hc7nQ1OUw0t7TR8l+wWoGeOpAOib2Cw8qHXfPhiWeORgGFqh/nCNT7j
         b65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HwBqnOa1E0VlKqSq871tPPYQ3FcLKgr7WO5uW7Uw2Eo=;
        b=CAggfA2N/hNb+TSlwJUHan5O0CgWiC3eXdiIGcr6NnlNcJNdfV5/9RtPbCsuVttfJq
         x6hcbZl5v2Y/dJyIgWctlHxTQ2ScUFd4fg+4W+64ZlgZSW79l5iZB1T09035P5zCGvDE
         jAJFQN9zhZ3bgmdgtEFvB7Zc41IejRR0duiZQUcjD+Ou+CEJ9hN0hzLs5gp4AwCsrW3D
         l+E+baC2sxlBawrVKtyAHoVTR9ZDMt2AHWQmDAsAq1tAfJKiD6Qz3Ewxg5zILRx+YYwC
         GRO8/r90DD2xm2a4S2y0iuJjStxjEf/hejOnU8d1qLdRmRQ5PLqaYsoysfg6X90NXLk2
         obSQ==
X-Gm-Message-State: AOAM532kE7i6e3mQwrpisPNOgjubUWUywaGS2+Lrww3VZS93l8f7O8nk
        yibOLyYnZSSd1LDyt4qYNJeoIw==
X-Google-Smtp-Source: ABdhPJww8AuspZpWbFyeaKBTt1PnhZvYHHposZmg6lmxyzorxCgMnc8+vMSOdc3trfi2NWE+I3bmpA==
X-Received: by 2002:a05:600c:3b8c:b0:38c:b365:7220 with SMTP id n12-20020a05600c3b8c00b0038cb3657220mr15632000wms.120.1649402523902;
        Fri, 08 Apr 2022 00:22:03 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm14084506wmb.36.2022.04.08.00.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:22:03 -0700 (PDT)
Message-ID: <56595ef2-a0fa-a92f-596b-511828295229@baylibre.com>
Date:   Fri, 8 Apr 2022 09:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: meson: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
 <20220407142159.293836-2-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220407142159.293836-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 16:21, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi          | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts    | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts           | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi              | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts            | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
> index 2d7032f41e4b..bcdf55f48a83 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
> @@ -416,7 +416,7 @@ &spifc {
>   	pinctrl-names = "default";
>   	status = "okay";
>   
> -	gd25lq128: spi-flash@0 {
> +	gd25lq128: flash@0 {
>   		compatible = "jedec,spi-nor";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
> index 2d769203f671..213a0705ebdc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
> @@ -298,7 +298,7 @@ &spifc {
>   	pinctrl-0 = <&nor_pins>;
>   	pinctrl-names = "default";
>   
> -	w25q32: spi-flash@0 {
> +	w25q32: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "jedec,spi-nor";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> index 93d8f8aff70d..874f91c348ec 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> @@ -284,7 +284,7 @@ &spifc {
>   	pinctrl-0 = <&nor_pins>;
>   	pinctrl-names = "default";
>   
> -	nor_4u1: spi-flash@0 {
> +	nor_4u1: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "jedec,spi-nor";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 86bdc0baf032..f43c45daf7eb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -374,7 +374,7 @@ &spifc {
>   	pinctrl-0 = <&nor_pins>;
>   	pinctrl-names = "default";
>   
> -	w25q32: spi-flash@0 {
> +	w25q32: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "winbond,w25q16", "jedec,spi-nor";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 3cf4ecb6d52e..c9705941e4ab 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -458,7 +458,7 @@ &spifc {
>   	pinctrl-0 = <&nor_pins>;
>   	pinctrl-names = "default";
>   
> -	w25q128: spi-flash@0 {
> +	w25q128: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "winbond,w25q128fw", "jedec,spi-nor";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
> index f3f953225bf5..e3486f60645a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
> @@ -121,7 +121,7 @@ &spifc {
>   	pinctrl-0 = <&nor_pins>;
>   	pinctrl-names = "default";
>   
> -	spi-flash@0 {
> +	flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "jedec,spi-nor";

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
