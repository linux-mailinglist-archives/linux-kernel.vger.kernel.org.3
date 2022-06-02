Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F353BE1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiFBShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiFBShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:37:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F01115C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:37:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 25so7102876edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nxEwqFG0EOGCgU9ZJ7XwRHFl2ED0Wh9INs05c4zZisA=;
        b=ztxVyGN3ZUE9ZA/CtzrH83LM04e5eMnTENPg23hcobEf9lfqAngke8cwpjj2E66BLb
         RQMEzDWPzOFiCIaBbtWfe3DWbPfjeNIfVHzNpIt1nDmCJA5W3vp0RpqWqGKH1lYxJjTS
         wxVVR8qS3i7ImkV5JFz9o3zZHUiuKtnP89gzJA/qsdL0f0Osk5VuXvW0aCAJRxxb4KyZ
         rvR6VXFLz9FlkI5OQEoltmBUD5xvNT1IQKenMyzw65h14S570BnU87Fe8zHapU49P2z8
         jLi10vZBlCmZirIkTTVfNNXK4cXup6Z7u3iQlNVSiG+6bv3Wr6I82sp6n9x+8u/iMXMp
         XE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nxEwqFG0EOGCgU9ZJ7XwRHFl2ED0Wh9INs05c4zZisA=;
        b=q97m7n5XnHRMXpibAcCbw2TKgLdiVqU0T+dM2rzCM0OFy6DrSctX7TuQ7KIG7LSlwD
         sa0gpTtpyANxLvzKB5dwzUFt/tivWg0ULFLuaUoEzUycmlZ8RCV/XG2p8atq5yOv/8pn
         OZizpu0cRZBj8Pi2YyYCwmWqvuZb4pUgHdTR9m1ONmWgAQRvJhBvBcRmtms27OseCndY
         g1WZ9vgVy4VV+kjmGXz2p/6GBG4NHCPiKbaJqdqFj3LopWaHpiVDx2i8f1bRrUgfc68S
         Bfz98Es476L2OjHEtpS4svIcMuhH9eGVAvh081TXOpFzpcEMgi4O+3DFPndV2U/lmdZM
         mRTg==
X-Gm-Message-State: AOAM5338/zSHfcW8OCaB0tvfljTIbS+FsHEoltcqIrz2i4ZFXe1PFjkN
        z58LPbqM8519EdJXSIqGmOZWlw==
X-Google-Smtp-Source: ABdhPJyXuAv9x7LCi4vkAz30UoSFjw+IotiXOHvU+0j7Btu500eY+9krfGA6CYfXdluiFYe8Dngiiw==
X-Received: by 2002:a05:6402:f1b:b0:42d:e92f:c924 with SMTP id i27-20020a0564020f1b00b0042de92fc924mr6836955eda.389.1654195021643;
        Thu, 02 Jun 2022 11:37:01 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id my16-20020a1709065a5000b006fecf74395bsm1985821ejc.8.2022.06.02.11.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 11:37:01 -0700 (PDT)
Message-ID: <86ca80e4-b0de-4a83-f69e-5d15dc16584f@linaro.org>
Date:   Thu, 2 Jun 2022 20:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm64: dts: Add support for Stratix 10 Software
 Virtual Platform
Content-Language: en-US
To:     wen.ping.teh@intel.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220602141151.3431212-1-wen.ping.teh@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220602141151.3431212-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 16:11, wen.ping.teh@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Stratix 10 Software Virtual Platform device tree
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> ---
> 
> changes in v2:
> -remove indentation before GPL
> -change root compatible to "altr,socfpga-stratix10"
> -remove bootargs
> -move clock-frequency to label
> -remove l2-cache
> -remove no longer exist authors from commit message
> 
>  arch/arm64/Kconfig.platforms                  |   3 +-
>  arch/arm64/boot/dts/altera/Makefile           |   3 +-
>  .../dts/altera/socfpga_stratix10_swvp.dts     | 117 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 2 deletions(-)
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
> index 000000000000..93fa5091a6c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022, Intel Corporation
> + */
> +
> +#include "socfpga_stratix10.dtsi"
> +
> +/ {
> +	model = "SOCFPGA Stratix 10 SWVP";
> +	compatible = "altr,socfpga-stratix10";

You cannot use someone else's compatible. You need your own and then
also you need to document it. Check existing sources for examples.

Documentation/devicetree/bindings/arm/altera.yaml

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
> +		stdout-path = "serial1:115200n8";
> +		linux,initrd-start = <0x10000000>;
> +		linux,initrd-end = <0x125c8324>;

Best regards,
Krzysztof
