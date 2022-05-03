Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA8518434
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiECM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiECM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:27:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4CE1FA65
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:23:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g6so33141650ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1+B0nDSelxPWBKeFfyRMZYaCgDIYB4AAPe14B7+Vz4E=;
        b=Nq6gKXjCnhJbwyezIt3Nz5aUKU9CQkaKn1KS85YpIE/HGNvvbyjxmIwG1vBOQ6xm6n
         iIFZXpaaIjmrrf/1Xo0aHiYZRQ7/KjU2cC7wsdSpRSueROUQ+Y4GXHYFcqYHg5i4255s
         s3zIJyZ2sY3Mv6lK8QUvv7Jj5DMfsUXCQcrAuTqQa6K+332zH5ynu/2NLdgPseVqNmS8
         79FZuyKNvnhMAhnNqekydF/KqC3YGtPIXdzDEBkWb/lCpVObE2ufIOuKn5kou4By3rjT
         8LfnbipANv3e5rwfREo0KPr7twucvaFgQ7Xl0fbh2u928zpsZXzLVAWBjv7NlDzmPi2M
         NY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1+B0nDSelxPWBKeFfyRMZYaCgDIYB4AAPe14B7+Vz4E=;
        b=JW2zEwTJaXB1ZjD+VHvmmEsJsASgEGkjPSCEtzjD0Vd5JaWwcM101QQ6qgS/PUbGDp
         6L444iSJjo+oReub9lygdHcc1vpB1ODLUGac/Wqi0+UEI6e45/aAvp/S/9aPW2wTpk/H
         BTT6G0gPn8eRg3mA/H9w6+4i+lf2wF9+oO5fI+0IhmGYyGDne9nWvB47EjghG3dwpWR1
         uddXNnjyO6/8TscoMuYJm24KlUMgthn0e3KFGMiX/Ss/FElUa7w82FH7D77i7hPSBc83
         WkRjO/FE6pEbmD1uq0sIPH4GifVNkRqQJrBz8uSAD9mOiTvwQpFgdbrjvTgUFzqFAZBy
         rY5w==
X-Gm-Message-State: AOAM531d1EVqZm2N1OImYLSAfV/FcVJJNssZVEotZ4MKo5SC55I5ROwv
        U/v+4SefGpWY+ZstCwja/On/xQ==
X-Google-Smtp-Source: ABdhPJxZ+H08qPQ20bNY26ofF/QfZilqLtIYkSJAGvGJKzajufuYx5Jh4Ht0ribtEK3RmbE2ZTRyxA==
X-Received: by 2002:a17:906:5793:b0:6f3:d546:1764 with SMTP id k19-20020a170906579300b006f3d5461764mr16045203ejq.247.1651580637319;
        Tue, 03 May 2022 05:23:57 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e00sm4561289ejc.102.2022.05.03.05.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:23:56 -0700 (PDT)
Message-ID: <e549b689-4043-e689-d0b0-f274ed08a665@linaro.org>
Date:   Tue, 3 May 2022 14:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dinguyen@vger.kernel.org,
        robh+dt@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 18:58, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |  1 +
>  .../boot/dts/intel/socfpga_agilex_n6000.dts   | 77 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 0b5477442263..1425853877cc 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
>  				socfpga_agilex_socdk_nand.dtb \
> +				socfpga_agilex_n6000.dtb \
>  				socfpga_n5x_socdk.dtb
>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> new file mode 100644
> index 000000000000..07f5a5983e5c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier:     GPL-2.0

Except what Rob said: remove the indentation before license.

> +/*
> + * Copyright (C) 2021-2022, Intel Corporation
> + */
> +#include "socfpga_agilex.dtsi"
> +
> +/ {
> +	model = "SoCFPGA Agilex n6000";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart0;
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		ethernet2 = &gmac2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0 0 0 0>;
> +	};
> +
> +	soc {
> +		clocks {
> +			osc1 {
> +				clock-frequency = <25000000>;

This does not look like SoC property... If it is part of Soc, why it is
not provided by clock controller? Where compatible?

If you intended to override nodes, override by label, not by path.

Best regards,
Krzysztof
