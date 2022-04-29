Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965105158A5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381604AbiD2WsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiD2WsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:48:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC57DCA91
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:44:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q20so5360292wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XbMnSQcsXT3f9/YJ+N4A0JRY+Tt1xV3pSkcn35GFhZo=;
        b=HIT000aEgzs+JS+CUs4j4egCfAGmU3smVafCauajxzPiTGbEe+SbmK75fM487GceKq
         eld1/0Jl0x7WbmYjDTiCeOy6USvtBe1AosWfu979o5zkn8wKYm5BIlDMEsyDAvzxAAPM
         rAVj15bC0N6OM2ZjMcRCxCR0VZYIihtXoFNnxbNYESnj+E6pnjeGuXEPZM+DKYn75lGN
         PA5RpMzA3ReGWxkI4ZxpQuqdr1qQCPHZOdKj/x7dVbJo3bdm2c4XVj2xeGY4NUNQdWB7
         jRmQNDaC8dDMI5Wh5wwpHgA+vRY/XC5/A9O/UvhwoUSi4tU+U4ClSliOd6rIU8GN6rLk
         LCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XbMnSQcsXT3f9/YJ+N4A0JRY+Tt1xV3pSkcn35GFhZo=;
        b=2CM21D5nOYRLxqsw9RA8Yxt+5aeQqAgUeaL9wkVo06o1Gs2eb6VBxgpBrpdc8fbcLQ
         fs447FmGajVBnesdQnoo9WIPdLocoEApYwD7X2Ce6MxePPgdTIVEBUhm7YodEYo1p72G
         mGCqtLZCU+Bzgle4ZLF47DEjNDUPR+IfVbVfDDKG7+7VglAAnIbWfTeEl7js4y4tJUPg
         ggNP5Pcrh2kqukEkqdhx9YbpeinxiiZqDgYEnKilSMHX0VoIn8SPgpRRRb3MsvaRJQ9D
         JNOH/3Sym5dUyx0I4llP4jXBdkZRhgkYLtdxnmmTQ3dWZu90IHmkDTU13Ro+fNeu/DyI
         z8og==
X-Gm-Message-State: AOAM531S3fOnsKnu/S87ElhJiRS93johq3U8pK3kiuPoQeINd1+Qu3gV
        M7af3olC8SMFAHIz6yivq2/dCSSNUDlcKUMD
X-Google-Smtp-Source: ABdhPJxuFHD0FM6rviCIM/LRtQOHwpiLUlWGEwe67Vlyhi6jzgclk++arbz2hSrEEhD9VnMnGNFTSA==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr5194712wmp.22.1651272284521;
        Fri, 29 Apr 2022 15:44:44 -0700 (PDT)
Received: from [192.168.2.222] ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c220100b003942a244ed9sm347944wml.30.2022.04.29.15.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:44:43 -0700 (PDT)
Message-ID: <aec239e1-e7e7-274a-fd2d-a6e3f896c865@conchuod.ie>
Date:   Fri, 29 Apr 2022 23:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 8/8] riscv: dts: microchip: add the sundance polarberry
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20220429104040.197161-1-conor.dooley@microchip.com>
 <20220429104040.197161-9-conor.dooley@microchip.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220429104040.197161-9-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 11:40, Conor Dooley wrote:
> Add a minimal device tree for the PolarFire SoC based Sundance
> PolarBerry.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile        |  1 +
>  .../dts/microchip/mpfs-polarberry-fabric.dtsi | 16 ++++
>  .../boot/dts/microchip/mpfs-polarberry.dts    | 95 +++++++++++++++++++
>  3 files changed, 112 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> 
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> index af3a5059b350..39aae7b04f1c 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
>  obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
> new file mode 100644
> index 000000000000..49380c428ec9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2022 Microchip Technology Inc */
> +
> +/ {
> +	fabric_clk3: fabric-clk3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <62500000>;
> +	};
> +
> +	fabric_clk1: fabric-clk1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> new file mode 100644
> index 000000000000..8c635f3358a5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2022 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "mpfs.dtsi"
> +#include "mpfs-polarberry-fabric.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define MTIMER_FREQ    1000000
> +
> +/ {
> +	model = "Sundance PolarBerry";
> +	compatible = "sundance,polarberry", "microchip,mpfs";
> +
> +	aliases {
> +		 serial0 = &mmuart0;
> +		 ethernet0 = &mac0;

Looks like I got this wrong and it should be mac1

> +	};
> +
> +	chosen {
> +		 stdout-path = "serial0:115200n8";
> +	};
> +
> +	cpus {
> +		 timebase-frequency = <MTIMER_FREQ>;
> +	};
> +
> +	ddrc_cache_lo: memory@80000000 {
> +		 device_type = "memory";
> +		 reg = <0x0 0x80000000 0x0 0x2e000000>;
> +		 status = "okay";
> +	};
> +
> +	ddrc_cache_hi: memory@1000000000 {
> +		 device_type = "memory";
> +		 reg = <0x10 0x00000000 0x0 0xC0000000>;
> +		 status = "okay";
> +	};
> +};
> +
> +&refclk {
> +	clock-frequency = <125000000>;
> +};
> +
> +&mmuart0 {
> +	status = "okay";
> +};
> +
> +&mmc {
> +	status = "okay";
> +	bus-width = <4>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	card-detect-delay = <200>;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy1>;
> +	phy1: ethernet-phy@5 {
> +		 reg = <5>;
> +		 ti,fifo-depth = <0x01>;

Whitespace here needs fixing.

> +	};
> +	phy0: ethernet-phy@4 {
> +		 reg = <4>;
> +		 ti,fifo-depth = <0x01>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy0>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&mbox {
> +	status = "okay";
> +};
> +
> +&syscontroller {
> +	status = "okay";
> +};
