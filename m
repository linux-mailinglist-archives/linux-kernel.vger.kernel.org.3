Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8553A537159
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiE2O0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiE2O0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:26:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C965E156
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:26:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y13so16591693eje.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3JaAWKa1bZRwQXdiutq3KI0xLzzTpwZUulcAkJ3MYjM=;
        b=KRMv70BYNXO5K4g2IQQvfaI/pcabvXgzAfht622ys8tKYzwvf3ofKMlRf6PdjuwS/9
         X5abjnqdqyAcufM080Z4QbIOUIoWwMYVWdWsNwIRmj+tL5LFL+ntX9DgRCQrOs109ovN
         E35I9HBfy6NOdqQFKyX8T7zNFQMUqWGueuOQkQtZE3pEsyVxwFA2ahAmDZReu0fcIqms
         fiu0eK/aDeoFamLT1/pdTcYrp07T+7/9Vv3JtgDsVqMgoMlU9REYuKcL4lsteUnfbh61
         cPqJcPG81LCrK7PoY1jke+x7BjpcoVgO7f9PxmNYBdMewrjn8eBEPidomKsHpNEVoEmn
         bU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3JaAWKa1bZRwQXdiutq3KI0xLzzTpwZUulcAkJ3MYjM=;
        b=gIB3ri+W+Z8H+tZlS46Ni77rNOcUC4Yin9Rr7F+QmIo1bCvpniSRHNawsrNrfEB5Jj
         2DUuMgXjTMZsVkDXxJcTbV3BkAyQZrgXS3gU/lhFp0abfyiVV2NX2/3zt4Sq9j2o3tu/
         iSNJTNJabZw6fvljrwzxVSfUYUxpepf0hzAEFZUMCeWPfanPynp+TjhIDPwvt//RFv3T
         BYaJh4Zw9kLZ9vY+djtc8R358wc1xjoq9ZbzMg2DuZNcWyUQzMXXaBTwYGOhMgS5ILkd
         FibXGXdQ1R4syQauj7l2vzK998qCDvoPg3fDc2qEjxzJQAsPDkfwQ0ImRzxSKxmowkA1
         DkAw==
X-Gm-Message-State: AOAM5307/oamJbjJnHO2L5s/1wiUJGs0vAcUb5CnoA/MwlweJSEucnLT
        tPOYiiubOL7rreR69H6FMtPQQg==
X-Google-Smtp-Source: ABdhPJySVlVvENmtWvnwL1k/sepyDlzyv6YTdAOFbHANvVoWjCkbv8v/KqvZg0t+m68ewWBbun5GaQ==
X-Received: by 2002:a17:907:7256:b0:6ff:2ed0:95d with SMTP id ds22-20020a170907725600b006ff2ed0095dmr12654168ejc.452.1653834369795;
        Sun, 29 May 2022 07:26:09 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a92-20020a509ee5000000b0042dbc55f6e4sm2231061edf.7.2022.05.29.07.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 07:26:09 -0700 (PDT)
Message-ID: <8123f029-8d0b-be52-ba8d-8458f424ee32@linaro.org>
Date:   Sun, 29 May 2022 16:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Ondrej Jirman <megous@megous.com>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
 <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2022 05:17, Tom Fitzhenry wrote:
> This is a basic DT that includes only features that are already
> supported by mainline drivers.
> 
> Tested to work: booting from eMMC, WiFi, charging.
> 
> Future patches will flesh out the DT. Some components, e.g. the panel,
> are awaiting driver mainlining.
> 
> This is derived from a combination of https://gitlab.com/pine64-org/linux
> and https://megous.com/git/linux.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Co-developed-by: Ondrej Jirman <megous@megous.com>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3399-pinephone-pro.dts     | 939 ++++++++++++++++++
>  2 files changed, 940 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 4ae9f35434b8..c00e7922d974 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinephone-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> new file mode 100644
> index 000000000000..b1a486db1dfe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -0,0 +1,939 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
> + * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
> + */
> +
> +// PinePhone Pro datasheet: https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> +
> +/dts-v1/;
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/usb/pd.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 PinePhonePro";
> +	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
> +
> +	chosen {
> +		bootargs = "earlycon=uart8250,mmio32,0xff1a0000";

earlycon is debugging piece so it should not be in generic DTS.

Best regards,
Krzysztof
