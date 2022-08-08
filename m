Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9844F58C35C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiHHGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiHHGgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:36:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B2BF57
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:35:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r17so11217113lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a7iWV34sdRjFcuLH46dzhG3J7+RLMWe00w1VFvqsozo=;
        b=U31XLI/sGdKcybMHnWpbUA9sgt2x6/SPGA7kAT6jedJmsyQT83egDMru1XmXLzbPWW
         3FWtq0Qu7I7p2nq7B+OARhmlGI82rIw1p+xraC2Vcn2uLyuflCfkkdd7rxCsAsvyl32w
         oO/HljGWbFHldubfTQZ/IMIRY/shdCq14qIRGPA5XJz3j0QbPtnJC4a4l9iPjZNHfMn8
         iXnyf67KsvSVQGOm1v3eZifUnjTH68M3kF0BTp96XGG8MduWb0RjJvJziuN6hr/K/saX
         KvXexNxoAJP/N3KzhfGdHjKvzgvSFRPM3B/pnxuvYsPVU00FGzGeDN7uI5UaPjfqp+sN
         DZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a7iWV34sdRjFcuLH46dzhG3J7+RLMWe00w1VFvqsozo=;
        b=bJ5mcLQCra3Kph19erAgLxutcb5Fr5zeNxKFwybbOq6tcq5DE36Ov5M76NkqQ9nE45
         a0RA2qhEQtDS9w2n/jA2Lb56DXyCR8MgRJ0iBiEtxLoIvchHw8bzU/MhgMtyHYwcl0uP
         mOGxntJRJQ+rrenj0JrvchIDD50exi6kYNJS0noBxT9zEAA59FGWj0wJ17pzTDnNDlzJ
         w9MOV/Gy+Cl3IoV2YOX0bGoObkTax5WSMK8uM7PZM8LWb5dMxcxOfRHpFA92e/JoJ8nz
         iy6CKNGK7S15gup0JWOsYIXjbZqxOXgraJvSMHTvIYRM6UEVLzAvuO982JSsfD3Ir8+3
         mHzg==
X-Gm-Message-State: ACgBeo3/eRD7up41NYR3Y3pj+S0/aC61Icfk3hn7irarMKxn/ABh9gPg
        oTmpGO/KPOS8Mn32usEAqKIFDw==
X-Google-Smtp-Source: AA6agR5ii3yZqNKq4DRXiZbWY4ZF74R+facCrrSILNCCzDBkULKH8Ex1IDQprlCIFxqz6StWhmWl0g==
X-Received: by 2002:a05:6512:32c1:b0:48b:a2bc:d329 with SMTP id f1-20020a05651232c100b0048ba2bcd329mr2512513lfg.487.1659940557764;
        Sun, 07 Aug 2022 23:35:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id o24-20020ac25e38000000b0048cf0fef301sm186440lfg.301.2022.08.07.23.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:35:56 -0700 (PDT)
Message-ID: <6461a695-171a-b160-5406-b8ac31c5ba0e@linaro.org>
Date:   Mon, 8 Aug 2022 09:35:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
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

On 06/08/2022 01:44, Tom Fitzhenry wrote:

Thank you for your patch. There is something to discuss/improve.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> new file mode 100644
> index 0000000000000..f5608487ad58f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -0,0 +1,385 @@
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
> +#include "rk3399.dtsi"
> +#include "rk3399-t-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 PinePhonePro";
> +	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
> +	chassis-type = "handset";
> +
> +	aliases {
> +                mmc0 = &sdio0;
> +                mmc1 = &sdmmc;
> +                mmc2 = &sdhci;
> +        };
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	gpio-key-power {

Just gpio-keys like all sources are doing.

> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn_pin>;
> +
> +		power {

Schema requires generic naming. Either "key" or "key-0" or "key-power"

> +			debounce-interval = <20>;
> +			// Per "PMU Controler", page 4.
> +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	/* Power tree */
> +	/* Root power source */
> +	vcc_sysin: vcc-sysin {

regulator-vcc-sysin

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sysin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	/* Main 3.3v supply */
> +	vcc3v3_sys: wifi_bat: vcc3v3-sys {

regulator-.....

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sysin>;
> +	};
> +
> +	vcca1v8_s3: vcc1v8-s3 {

regulator-.....

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca1v8_s3";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
Best regards,
Krzysztof
