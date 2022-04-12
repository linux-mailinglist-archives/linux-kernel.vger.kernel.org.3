Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0307D4FDFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiDLMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357097AbiDLMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:20:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3C4AE2A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:27:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b15so21966867edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fTL0LuyHJP55C0ZkxhV5JJZCHR1IVobkoraz2H3z7k0=;
        b=jVUvZd+C01riSCcHtgCctzSsElQtUk8vtWMbSMQ0kpaIrv7jqatQzCEI1qVasdJKjA
         tyd1W6KKLu/n4MpTQQjVjZuXwZceAITHCEa7JFYmr0IASwv0/vqIswXQozv9oeFlVdAW
         rp+FXno2KJShW9hFRtGloTdd3C4UdkVpfL0CmNpja33fk/9f0SywNlRw6Y0daKipBVwh
         oqCi0qvHdK7l8oDZb8B0X4961KVVr/XYmYa4YgepQ+s9l5f7HL2JZvtTyotQxZg0XWH/
         tU8tr5syoz9+QUIP4mtfvULYsZXF69MvqlZhiw1QBIiJriOQenmWYGIC52R93R7ITyO4
         qD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fTL0LuyHJP55C0ZkxhV5JJZCHR1IVobkoraz2H3z7k0=;
        b=HCaeR6jylts3+/VNtDNrHPVR6DpRX5mI+MZeoz5zNrGIBH7PAxMWbyleeeQWD9YCOi
         pefSe4sPQ/YL8D+rE4d5ZZmLQgxIkUmDf58+JfrekW7cfWr+4FuPdDjFdPAa2DYP7Zpj
         Gi8Ea/bwWywMpanw0l7DoqNoX/CRU4eN4L0ulRAaJdxmVDGTqleWxi8nWLjJArQbwdvM
         gPvYtYRHIQwV5bJQtUerT+vXe6Mbh+OLVP7vbCTF0qWHm/e7hNCPd63QcH1UHkhtdhdW
         XFIjbq7TRo5lBUpE5rW6LMLm+3AMP41AL18nVHb26NbH71Uk+rX7VeHOf3YRvhDVh9Dc
         aAEQ==
X-Gm-Message-State: AOAM5330Lc/COPYKqjnn1T++VHfsSvmsR37CWApkhlyFG/ZmmUdKA9G9
        7vyNWakvc6Ey7c5obenfviVChA==
X-Google-Smtp-Source: ABdhPJxieY0YdmARZCcyw24ryB8+AJrHlDefLmPsyvARI8OPfb3IKN7u+coH1M9vVUt+9v2SWeq++g==
X-Received: by 2002:a05:6402:4414:b0:419:28bc:55dc with SMTP id y20-20020a056402441400b0041928bc55dcmr38705253eda.130.1649762864946;
        Tue, 12 Apr 2022 04:27:44 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm13167937ejy.37.2022.04.12.04.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:27:44 -0700 (PDT)
Message-ID: <ed806d35-3613-4f9c-54ba-b31fc5ed91c8@linaro.org>
Date:   Tue, 12 Apr 2022 13:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] ARM: dts: add dts files for bcmbca soc 47622
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     Samyon Furman <samyon.furman@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Tomer Yacoby <tomer.yacoby@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
References: <20220411172815.20916-1-william.zhang@broadcom.com>
 <20220411172815.20916-4-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411172815.20916-4-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 19:28, William Zhang wrote:
> Add dts for ARMv7 based broadband SoC BCM47622. bcm47622.dtsi is the
> SoC description dts header and bcm947622.dts is a simple dts file for
> Broadcom BCM947622 Reference board that only enable the UART port.
> 


Thank you for your patch. There is something to discuss/improve.

> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "brcm,bcm47622";

This does not match your bindings. Even if it is not used.

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CA7_0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		CA7_1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x1>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +		CA7_2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x2>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +		CA7_3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x3>;
> +			next-level-cache = <&L2_0>;
> +			enable-method = "psci";
> +		};
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&CA7_0>, <&CA7_1>,
> +			<&CA7_2>, <&CA7_3>;
> +	};
> +
> +	clocks: clocks {
> +		periph_clk: periph_clk {

No underscores in node names.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};
> +		uart_clk: uart_clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clocks = <&periph_clk>;
> +			clock-div = <4>;
> +			clock-mult = <1>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +		cpu_off = <1>;
> +		cpu_on = <2>;
> +	};
> +
> +	axi@81000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x81000000 0x818000>;
> +
> +		gic: interrupt-controller@1000 {
> +			compatible = "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x1000 0x1000>,
> +				<0x2000 0x2000>;
> +		};
> +	};
> +
> +	periph-bus@ff800000 {

just "bus" to be generic?



Best regards,
Krzysztof
