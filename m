Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17A55A6003
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiH3J7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiH3J6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:58:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEEE86B1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:57:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z20so10798633ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kmj0Xve7PzhuEnAE0eUuSiLK/6HmDewHaNe2a46Ej6k=;
        b=HCSqQVG4A1ntcdR+y9sZ9YccYIvP1a++XIv91E8zg0Xl0VhOEVmqogg6gzljVnco1W
         JKBNQBAj1g4LxlihgxmTBlEZ1Q+ExpcpBMXP3E4qWEwRP5DvcETmexHLW1zNW1H3uTdp
         T32xbvwKt89l+cI9Cm7JZeTFN2mEG7A35zDqLfy7BUna4TsNqK/7h4wEp+5ahQWhCroy
         bICBIQcpTtlExRWSzlAgc9ntpH+iO9cVxAH+pvbtMiDJEID0Dc0WJ30lJDITplnA1DYl
         XdrGKAPoF1zStH/9yIxDVj0O/t7tui51WOWgfdMBKqZcjVaXgViQuv2OcDfYmQsGCm7H
         c7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kmj0Xve7PzhuEnAE0eUuSiLK/6HmDewHaNe2a46Ej6k=;
        b=75KdePr7rV+xYG3WPc9aDW7YfawLamSr4nw/xKWMNSwMEogIi2nwVjgpVDyoqjp+va
         IT8Hhd7FSgz24dejnozFbqJ+QKI4feksgDc+t54o5cxB8QW5KKlFoVyGd0dnUqsId6WW
         9LUIzSdn3zHKi9SQixoyfzywr6/L3kmLIOIIkOXwzYgzF4TfE1RI4PdVZUl2VKLZ5jQK
         z2FL4ZXwxz+6r2wIBAMHggMcwm4scf+z7kzSAiAlMJQwz5fWRwWnoJWg2j3LzMGaBmGF
         vhivch5l+VLH8qXrP26jrRI0SWKy/QTc9n+SkFe1lAAAz/YK9JWnPPjjf1L82yWk8p4f
         zk8A==
X-Gm-Message-State: ACgBeo0NQ4j6oezkYwKUrbdsYW6Nm/kX7ElVddP7mKeAQUyE9gVeJJLT
        D/peSiYNIKfeF/yZcmh0EE++Rw==
X-Google-Smtp-Source: AA6agR7wR03gXVIP4KGvGUJ6C9qZaYbod0zvUoe0O3SpvH36KlmnqJ695erWFGW5JyRyQ5Q7kUDC+A==
X-Received: by 2002:a2e:1613:0:b0:267:8c60:148f with SMTP id w19-20020a2e1613000000b002678c60148fmr576335ljd.262.1661853439179;
        Tue, 30 Aug 2022 02:57:19 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id n25-20020a05651203f900b0048abf3a550asm1553056lfq.224.2022.08.30.02.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:57:18 -0700 (PDT)
Message-ID: <323dc2e1-68fb-df0c-38b0-5af6d087248e@linaro.org>
Date:   Tue, 30 Aug 2022 12:57:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] arm64: dts: ti: Add support for AM62A7-SK
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bryan Brattlof <bb@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
 <20220829082200.241653-5-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829082200.241653-5-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 11:22, Vignesh Raghavendra wrote:
> AM62A StarterKit (SK) board is a low cost, small form factor board
> designed for TI’s AM62A7 SoC. It supports the following interfaces:
> * 2 GB LPDDR4 RAM
> * x1 Gigabit Ethernet interface
> * x1 HDMI Port with audio
> * x1 Headphone Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB Type-C DRP Port
> * x1 UHS-1 capable µSD card slot
> * M.2 SDIO Wifi + UART slot
> * 1Gb OSPI NAND flash
> * x4 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * 24-pin header for peripherals in MCU island (I2C, UART, SPI, IO)
> * 20-pin header for Programmable Realtime Unit (PRU) IO pins
> * 40-pin CSI header
> 
> Add basic support for AM62A7-SK.
> 
> Schematics: https://www.ti.com/lit/zip/sprr459
> 
> Co-developed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile         |   2 +
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 224 ++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 02e5d80344d0..4555a5be2257 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -23,3 +23,5 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> +
> +dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> new file mode 100644
> index 000000000000..994ed6865551
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62A SK: https://www.ti.com/lit/zip/sprr459
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-am62a7.dtsi"
> +
> +/ {
> +	compatible =  "ti,am62a7-sk", "ti,am62a7";
> +	model = "Texas Instruments AM62A7 SK";
> +
> +	aliases {
> +		serial2 = &main_uart0;
> +		mmc1 = &sdhci1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 2G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +

No need for blank line.

With that:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
