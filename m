Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D06533AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiEYKvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiEYKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:51:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F2C60
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:51:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so40843268ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gPVyJOPCg3ZgGMg0ovPEKPFKhjYsgoChKtc8oyOFFRU=;
        b=XF3wywkotbRkHHTdHn4JfgqG1bqdlal47P4FVCMhsRRvk+snkzg2N0P0Wfql69oUCe
         jXxgfBLYwUNoWQETlZyYg3Qb8ZaZYUW+skbeI7CL4HHbR8ZbFKvs9zM4iGrLKz/GvTNT
         bcXUCd6GYrZDTZYDDYJ+TlgxrpMm8GxDrKY6s25kWZZZXhOy4gceb+OILQfeKbKkMyb0
         PIbQ4oB4/dQAy6nUgdGvMkVl1E3rVss5LzM5kWBCJOFyCHGET1govgboBw8ZTzBm7YaQ
         NnvXJRXeo4lxFa6zR144bKgnr9sMH6bMXZJp5Rfjlk33S9IKDqbrybghoBP3Jk5pW16q
         QjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gPVyJOPCg3ZgGMg0ovPEKPFKhjYsgoChKtc8oyOFFRU=;
        b=KpaaS+QYrDMVpAGCfHksRGuiPoyEGe20moYuAL42yypZPLGh2S/qYs5jmdovvYwn3X
         J0c9xqZOPmixavXn8/BPfc9ykttvGKogXDcHOlV7Cz3CZqFc3xq6of6FXbKn1rqc6TUg
         YSk+pn0H159+ZnxkJBnkoIXaY2Yy0k9cLrG8Y0H7X/9Oz9N0D/Cr/m0NmmjxWeAlDxmi
         DDCunJXYdk8Y4T29yCy2h00imbv7YihKL+qalTUnkohtYITcHtQWQVIsd8fx7jUolhJ0
         POmyj+ZgUtJH/o3H7ZGCAqPYeKChNjjyctQwc1nGBPwWfggydoUhaHsGrZqwBDJ6DCv8
         v/5g==
X-Gm-Message-State: AOAM532c9X4vh7b1LUH7Rncx1DkkhOHU1rcT3yC13EzoQZ5h62xg8CNo
        8miirtKDF2X7Oqmaj2rJb1usCw==
X-Google-Smtp-Source: ABdhPJyIJ0Pos6hMRgwgrSOuuvY86WS/3f7LaN1bSAlLoJJbFB4jHmVwfJhBDUFl1RoFEkvDTb+A1Q==
X-Received: by 2002:a17:906:328a:b0:6f4:8045:3fe3 with SMTP id 10-20020a170906328a00b006f480453fe3mr29838810ejw.752.1653475889405;
        Wed, 25 May 2022 03:51:29 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qf24-20020a1709077f1800b006f3ef214dc3sm1336744ejc.41.2022.05.25.03.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:51:29 -0700 (PDT)
Message-ID: <4826e2e5-83c0-3d9a-8451-af042d64e94e@linaro.org>
Date:   Wed, 25 May 2022 12:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220525093927.368131-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525093927.368131-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 11:39, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> ---
> 
> v3
> - Adjustment entries are ordered by name.
> - Remove the bootargs property and modify the stdout-path property.
> - Group multiple LED devices into a group.
> - Modify the "gpio3_71" node name format.
> - Delete unneeded blank line at the end.
> 
> v2
> - Disable empty i2c bus.
> - Remove gfx node because aspeed-g6.dtsi isn't supported.
> - Modify the led format and add some properties.
> - Fix wrong indentation.
> - Add stdout property in chosen node.
> - Rename temp to temperature-sensor in i2c bus 0.
> 
> ---
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 442 ++++++++++++++++++
>  2 files changed, 443 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7c16f8a2b738..5339e9339ce4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1543,6 +1543,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> +	aspeed-bmc-jabil-rubypass.dtb \
>  	aspeed-bmc-lenovo-hr630.dtb \
>  	aspeed-bmc-lenovo-hr855xg2.dtb \
>  	aspeed-bmc-microsoft-olympus.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> new file mode 100644
> index 000000000000..3a835f31a1b2
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Jabil rbp";
> +	compatible = "aspeed,ast2600";

What happened here? Why the compatible is removed? You received a
comment from Joel to add it, so silently reversing back is not a proper
approach.

I wrote last time:
"You need to document the new compatible."

> +
> +	chosen {
> +		stdout-path = "/uart5:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	vcc_sdhci0: regulator-vcc-sdhci0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDHCI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +

Just one blank line.

> +	vccq_sdhci0: regulator-vccq-sdhci0 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "SDHCI0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	vcc_sdhci1: regulator-vcc-sdhci1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDHCI1 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci1: regulator-vccq-sdhci1 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "SDHCI1 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			label = "identify";
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			retain-state-shutdown;
> +			gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			label = "status_amber";
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			label = "status_green";
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "keep";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			label = "status_susack";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4{

Missing space

> +			label = "power-amber";
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> +		};
> +

...

> +
> +&kcs3 {
> +	aspeed,lpc-io-reg = <0xCA2>;
> +	status = "okay";
> +};
> +
> +&kcs4 {
> +	aspeed,lpc-io-reg = <0xCA4>;
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> \ No newline at end of file

Now you miss a new line at end of file...


Best regards,
Krzysztof
