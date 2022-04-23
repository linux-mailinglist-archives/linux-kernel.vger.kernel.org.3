Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50150C90A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiDWKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDWKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:10:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BDF1B2B00
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:07:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id el3so8350563edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fg4f1I3ghx0/KVyE5VZCYPv9D9SX7g8jd1zZokiQ29A=;
        b=uSBMpS/AKQcMFs2W4M1dofXhfEhs3MYXdjs3RAb+3mi/UsnNu/k3utDpyE38B2euWP
         1uIFkxNvv0Iu6dkaoCw0vAEVT1haxPoLhjrOb8p6HV6NEEpSmSRnMfe95NecMS+kR5Ig
         eKVZ6Y8eubZt5o95ybwH442YWPy/fD5WyzeGlBeR76ivgM7LJaUomaJ2CKpShDHz+iB4
         2ZLDefsrnklOZS1BqwhIzunq8dQ99Fm8iAqW7wyPd3QbJ/0bqbw1LMorZsy4HigGEXW8
         TMSlRS/D7EnXd55cIJxJKc6I009HsW9iK4zTh/PvkelqtoVQhf+YhI0CYKKpxXD1+lWC
         8fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fg4f1I3ghx0/KVyE5VZCYPv9D9SX7g8jd1zZokiQ29A=;
        b=477hOgYRSxyU+X7nBy/FprQKU+mGDdtjywp4yHQUOhM6zvljJ7QB/TnKYtBc/UJESt
         5eva6ytZbe97JM17xDmL5l/6J8cYegYNUfmbym7oLhfDEkmDzBXbqn9fFhuDxO8YeTM9
         c+xQvwXH9d9h4QcIncJz6dVfGy6XRoQY0SDpLy6T+NPSAkcJ0wZmRYctqeerfOTj/OYc
         rkdgsurdxDqXb2Jy5VQQPje7r49w/P2nyUxdFtWn14kybbCbQyLM4x72BoCTDS5C2pIT
         R5RYXT7+IllERkwtz88P6xVmA5wkkf7k4P/Ud3tvR6hymPo39inkPlEohd7z7o3R29K1
         BDkQ==
X-Gm-Message-State: AOAM530DKno9G8n+xh9Q1+8xHkS3U93mnvQJMm6nUq/UWfg0q1e/rmnR
        dYES3ZWMJo6Htp3WIGSIyFTEVQ==
X-Google-Smtp-Source: ABdhPJyKnnAzcHVAg01zAFGOji92P8ff6zdAF/h+x/p/Sln8gc+Fxos95ajNoWv34ODIv1qu01zEwg==
X-Received: by 2002:a05:6402:2318:b0:413:7645:fa51 with SMTP id l24-20020a056402231800b004137645fa51mr9539154eda.201.1650708457556;
        Sat, 23 Apr 2022 03:07:37 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm1549268ejc.66.2022.04.23.03.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:07:37 -0700 (PDT)
Message-ID: <bb988637-ecdd-008b-8a28-80d5c94cfd8d@linaro.org>
Date:   Sat, 23 Apr 2022 12:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 18/19] arm64: dts: rockchip: Add base DT for rk3588 SoC
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-19-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-19-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:

Thank you for your patch. There is something to discuss/improve.

> +
> +	clocks {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

There are no children with unit addresses... this should not be a simple
bus.

> +
> +		spll: spll {

Generic node names please, so either "clock-0" or "spll-clock" etc.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <702000000>;
> +			clock-output-names = "spll";
> +		};
> +
> +		xin24m: xin24m {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-output-names = "xin24m";
> +		};
> +
> +		xin32k: xin32k {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +			clock-output-names = "xin32k";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_l0>;
> +				};
> +			};
> +		};
> +
> +		cpu_l0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l0>;
> +			#cooling-cells = <2>;
> +			dynamic-power-coefficient = <228>;
> +		};
> +
> +		l2_cache_l0: l2-cache-l0 {
> +			compatible = "cache";
> +			cache-size = <131072>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l3_cache: l3-cache {
> +			compatible = "cache";
> +			cache-size = <3145728>;
> +			cache-line-size = <64>;
> +			cache-sets = <4096>;
> +		};
> +	};
> +
> +	arm-pmu {

Generic node name, so just "pmu" unless there is goign to be a another
PMU node?

> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu_l0>;
> +	};
> +
> +	firmware {
> +		optee: optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			shmem = <&scmi_shmem>;
> +			arm,smc-id = <0x82000010>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +
> +				assigned-clocks = <&scmi_clk SCMI_SPLL>;
> +				assigned-clock-rates = <700000000>;
> +			};
> +
> +			scmi_reset: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +		};
> +
> +		sdei: sdei {
> +			compatible = "arm,sdei-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	sram@10f000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x0010f000 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x0010f000 0x100>;
> +
> +		scmi_shmem: sram@0 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x100>;
> +		};
> +	};
> +
> +	php_grf: syscon@fd5b0000 {
> +		compatible = "rockchip,rk3588-php-grf", "syscon";
> +		reg = <0x0 0xfd5b0000 0x0 0x1000>;
> +	};
> +
> +	ioc: syscon@fd5f0000 {
> +		compatible = "rockchip,rk3588-ioc", "syscon";
> +		reg = <0x0 0xfd5f0000 0x0 0x10000>;
> +	};
> +
> +	syssram: sram@fd600000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0xfd600000 0x0 0x100000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0xfd600000 0x100000>;

No children here, so why do you need it?

> +	};
> +

Best regards,
Krzysztof
