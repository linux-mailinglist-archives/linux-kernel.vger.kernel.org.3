Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0124A532878
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiEXLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiEXLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:04:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC374DE7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:04:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so30205129lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hPNoCC9bCYBSqlvmlNYnCR/CEL5z/MBO4GRQRBu2SQ4=;
        b=dA4KevZFwM0GA6ikLM4CQSpLnMQZoHGlBfnsB4u4wf26cUuuFTFQ7Lmwehv5yWosP1
         +erWYpxy1I6uy+YdTsSqf5HzY47VmUtyNZBzCM34NH1TQIjnXK2VVq6jGfTllnLlTxA1
         w9Ky2l4IeFehM0AEjfpz+F8eJrEgswepUjtHnlwoksmNRbHum8BENMOVbYVmTkUIX/kG
         CvOp1RGolCVyVjX9JZx0z54FP8xB+Wk/rBMJfoDUh1fBGqtK1MgOrUXGBdEhddDRbW2o
         S+jgCSu5bJHprvsFz98itVCR0GJEi7zM+COaK4rmJk+WSfaQjII0DBA4XZ+cc4AKj6Sx
         ANOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hPNoCC9bCYBSqlvmlNYnCR/CEL5z/MBO4GRQRBu2SQ4=;
        b=4EV/9Y0cO1AH/Oe8u+iksTC1BMAC6L1H02/iMOe1oKxwwpPhbtT+HEjv50uXhijQMq
         l+VchE62CIA+KHg/iSBHrWAQMfDhFKcXaxCIEkG5Yu/FHgJgl8vMPGDAvt7BdfnaeOFq
         QLIfnAj7fyRsUSkigCqp9h6qdlrbISCavAFYgqUo+ewaE4hsc38+MG/R8myMLkh9wSnH
         +SRFhSK5COK6utGem/fZasfkeDFJqoV4KHhtQmsi3Sw5BI88LvQJH9WtHG8ACPpU3TPM
         IrT/1ys1qnEF1jV4btE8BSdFZl9MxtldQHV5H8HjIp40C6nxbewDkIZ/vZldaJ9q5iJ5
         fOeA==
X-Gm-Message-State: AOAM533DdGszMMnSTmrqRuTbhmpieOUoMbCL/+hxpvTTEYCEsN9OuaQC
        r5LYntsKvSoJsyXq2am6E3F45w==
X-Google-Smtp-Source: ABdhPJw2upydtAoXKYn4a3Gqa3QqfoUFFOC52J/y7lFhp6vDr43KdpAMMfe6F1biVkI4W6nLqT/LfQ==
X-Received: by 2002:a05:6512:201a:b0:478:5adc:fbbb with SMTP id a26-20020a056512201a00b004785adcfbbbmr12704734lfb.687.1653390255946;
        Tue, 24 May 2022 04:04:15 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id d22-20020a2e3316000000b00253deeaeb3dsm2313662ljc.131.2022.05.24.04.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 04:04:15 -0700 (PDT)
Message-ID: <2cf38dea-0754-e63b-4832-a0b2aa966c61@linaro.org>
Date:   Tue, 24 May 2022 13:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual
 Platform
Content-Language: en-US
To:     wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yves Vandervennet <yvanderv@opensource.altera.com>,
        Dinh Nguyen <dinguyen@opensource.altera.com>
References: <20220524102912.792968-1-wen.ping.teh@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524102912.792968-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 12:29, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Stratix 10 Software Virtual Platform device tree
> 
> Signed-off-by: Yves Vandervennet <yvanderv@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> ---
>  arch/arm64/Kconfig.platforms                  |   3 +-
>  arch/arm64/boot/dts/altera/Makefile           |   3 +-
>  .../dts/altera/socfpga_stratix10_swvp.dts     | 131 ++++++++++++++++++
>  3 files changed, 135 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index de9a18d3026f..48abe5dafaae 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -249,7 +249,8 @@ config ARCH_INTEL_SOCFPGA
>  	bool "Intel's SoCFPGA ARMv8 Families"
>  	help
>  	  This enables support for Intel's SoCFPGA ARMv8 families:
> -	  Stratix 10 (ex. Altera), Agilex and eASIC N5X.
> +	  Stratix 10 (ex. Altera), Stratix10 Software Virtual Platform,
> +	  Agilex and eASIC N5X.
>  
>  config ARCH_SYNQUACER
>  	bool "Socionext SynQuacer SoC Family"
> diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
> index 4db83fbeb115..1bf0c472f6b4 100644
> --- a/arch/arm64/boot/dts/altera/Makefile
> +++ b/arch/arm64/boot/dts/altera/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_stratix10_socdk.dtb \
> -				socfpga_stratix10_socdk_nand.dtb
> +				socfpga_stratix10_socdk_nand.dtb \
> +				socfpga_stratix10_swvp.dtb
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> new file mode 100644
> index 000000000000..209e26d3611b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier:     GPL-2.0

No need for indentation before GPL.

> +/*
> + * Copyright (C) 2022, Intel Corporation
> + */
> +
> +#include "socfpga_stratix10.dtsi"
> +
> +/ {
> +	model = "SOCFPGA Stratix 10 SWVP";
> +	compatible = "arm,foundation-aarch64", "arm,vexpress";

Does not look like compatible for stratix at all... Please do not invent
stuff but take a look at existing code and customize it.

> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +
> +		timer0 = &timer0;
> +		timer1 = &timer1;
> +		timer2 = &timer2;
> +		timer3 = &timer3;
> +
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		ethernet2 = &gmac2;
> +	};
> +
> +	chosen {
> +		bootargs = "rdinit=/sbin/init ip=dhcp mem=2048M";

Bo bootargs,

> +		stdout-path = "serial1:115200n8";
> +		linux,initrd-start = <0x10000000>;
> +		linux,initrd-end = <0x125c8324>;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	soc {
> +		clocks {
> +			osc1 {
> +				clock-frequency = <25000000>;

Override by label.

> +			};
> +		};
> +


Best regards,
Krzysztof
