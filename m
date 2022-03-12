Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02584D6E91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiCLMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:05:39 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D636680;
        Sat, 12 Mar 2022 04:04:30 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id u1so16724792wrg.11;
        Sat, 12 Mar 2022 04:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QUQq53RJ2QMDT09MUiSe/e+qE5E8hxdGSmBgzwvHli4=;
        b=zimpqOKowyXC4DngUFuCYqE0LkaCxRsbn0v39cYIk4V+fyLyvlkc0yyct2X4NmgdeF
         jUoa+iZJJLOqoODKkkcZo4JLgh9tXkaqPWzIc0d86+9vq10w1YGTByaoOwR+/jq11ffo
         HZr/Mbu0Qs6Liq91zmG3VUNYzuS//yTXQ7KQqjJHzL89Ie6+6t7A9OQWAYMZl8VreJYK
         XpQZmmOxR/Cs/5ukM5nKy5gRLxorvNjSYA9gYKmbHmsAfclSRbKBaO16/IRC68HNdvlO
         8xUyH9XNtWUxD3b6u04exlbdcwSc7jjKkYvw4RapBALIc7sBugS230dE6y/hgifi8kTD
         TleQ==
X-Gm-Message-State: AOAM530FHSO5WOhVavUSkbKTZtDiHts5R2b+8+BmKEfnF3oAz3p9Z3dw
        nYG4nGaZoEcTgj1M6xgMeZg=
X-Google-Smtp-Source: ABdhPJw4QLZG1kUHXhCll4RO9sx8FKewFjzFryMAaiHI2HhqyHsPQxBBnuIomX/Go23HRPxguAB9tw==
X-Received: by 2002:a5d:6c69:0:b0:203:78af:48b2 with SMTP id r9-20020a5d6c69000000b0020378af48b2mr10511331wrz.123.1647086668977;
        Sat, 12 Mar 2022 04:04:28 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm25188353wmq.27.2022.03.12.04.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 04:04:28 -0800 (PST)
Message-ID: <49daf501-3d01-b772-2173-df3f3ac3e6db@kernel.org>
Date:   Sat, 12 Mar 2022 13:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6010
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312080717.1528401-1-niravkumar.l.rabara@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220312080717.1528401-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 09:07, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add a dts file for the Silicom FPGA SmartNIC N6010/N6011,
> which is based on the Intel Agliex platform.
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

It's a v1, so did Dinh ack it off-line?

> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |  1 +
>  .../boot/dts/intel/socfpga_agilex_n6010.dts   | 83 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 0b5477442263..a05a610a4006 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
>  				socfpga_agilex_socdk_nand.dtb \
> +				socfpga_agilex_n6010.dtb \

Put the names in alphabetical order.

>  				socfpga_n5x_socdk.dtb
>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
> new file mode 100644
> index 000000000000..c105f0621eb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2022, Intel Corporation
> + */
> +#include "socfpga_agilex.dtsi"
> +
> +/ {
> +	model = "SoCFPGA Agilex n6010";

You missed here compatible and respective bindings change.

> +
> +	aliases {
> +		serial0 = &uart0;
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

Override with labels, not by full path. See other code as examples. Try
coding in similar way how it is in Linux kernel - it is a great way to
learn.

> +				clock-frequency = <25000000>;


> +			};
> +		};
> +                agilex_hps_bridges: bridge@80000000 {

Weird indentation.

> +                        compatible = "simple-bus";
> +                        reg = <0x80000000 0x60000000>,
> +                                <0xf9000000 0x00100000>;
> +                        reg-names = "axi_h2f", "axi_h2f_lw";
> +                        #address-cells = <0x2>;
> +                        #size-cells = <0x1>;

No need for hex numbers

> +                        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>,
> +                                <0x00000001 0x02001000 0x82001000 0x00000800>,
> +                                <0x00000001 0x02080000 0x82080000 0x00004000>,
> +                                <0x00000001 0x02100000 0x82100000 0x00080000>,
> +                                <0x00000001 0x02000040 0x82000040 0x00000020>,
> +                                <0x00000001 0x02000800 0x82000800 0x00000020>,
> +                                <0x00000001 0x02000820 0x82000820 0x00000020>,
> +                                <0x00000001 0x02000900 0x82000900 0x00000020>,
> +                                <0x00000001 0x02000920 0x82000920 0x00000020>,
> +                                <0x00000001 0x02000940 0x82000940 0x00000020>,
> +                                <0x00000001 0x00000300 0xf9000300 0x00000010>,
> +                                <0x00000001 0x02000000 0x82000000 0x00000010>;
> +
> +                        uio_cp_eng@0xf9000000 {
> +                                compatible = "generic-uio";
> +                                reg = <0x00000000 0x00000000 0x00001000>;
> +                                status = "okay";
> +                        };
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	spidev: spidev@0 {
> +		status = "okay";
> +		compatible = "linux,spidev";

No, for multiple reasons:
1. Did you see anywhere such usage?
2. Did you see compatible documented?
3. Did you see the warning when booting the kernel?

> +		spi-max-frequency = <25000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&watchdog0 {
> +	status = "okay";
> +};
> +
> +&fpga_mgr {
> +	status = "disabled";
> +};


Best regards,
Krzysztof
