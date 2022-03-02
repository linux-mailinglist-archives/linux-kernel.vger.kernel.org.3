Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F04CA625
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiCBNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiCBNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:37:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E000C1173
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:36:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8434E619FE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC543C340F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646228206;
        bh=f04GDmgC8466f+8FoC5+tuDMcDRUkObyck2M5ZGfqyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X4gGjccvTZxy04lZncmOPd8t3SCaUlqpAtLXs7StLyY0ZIn85GYwwQBtHNpBfyY9y
         LDoMV/NBSktERb3gMl7bojkCpeIvX5DFEVSdOTvztrK/CuGjP5Uk1VwjbgQE8T+7Qk
         iRW/5k3YYTasjB0mwX9S4ebO82XcE1w3NIEuX6wdmnWQ882EDoo9SnP3zxJV6GN9+C
         yinL/iw+Wa22WJEl+Hd75+jVat/4qadRDnA2Z8MtgJkwiOaLl4LAF6PSwNjj07IFiu
         WPrGM3HZLhLjiiu+TvJcByo+hI9qHxeqcXMMUEZ1cRnAKO+HWBDQPOc3qAd/WySSM/
         LkxEnWNkTxWvg==
Received: by mail-ej1-f54.google.com with SMTP id p15so3794268ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:36:46 -0800 (PST)
X-Gm-Message-State: AOAM532Am5XXYnkYpUreYtmXcsINiendHlhAExmML/IcFXv7o1ixZbWP
        slcrroe2IMZEAeZ3IWREts5Eqhcz9uUROhZKKg==
X-Google-Smtp-Source: ABdhPJz0DfNqNHHMlx6i691xLWqjOTACC866P4RugyQ7NRgCiix5CvPcSauJJdPF3vacbkNmSd5tkwFzmZw+OO/JHsM=
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id
 w4-20020a170906d20400b006d6df17835emr7757449ejz.20.1646228204961; Wed, 02 Mar
 2022 05:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20220302044406.63401-1-ash@heyquark.com> <20220302044406.63401-3-ash@heyquark.com>
In-Reply-To: <20220302044406.63401-3-ash@heyquark.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Mar 2022 07:36:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ej_vZHRfjNk61ogEstsqwJXx8bkRJa4vhnQss1bzYSA@mail.gmail.com>
Message-ID: <CAL_Jsq+ej_vZHRfjNk61ogEstsqwJXx8bkRJa4vhnQss1bzYSA@mail.gmail.com>
Subject: Re: [PATCH 02/12] powerpc: wiiu: device tree
To:     Ash Logan <ash@heyquark.com>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 10:44 PM Ash Logan <ash@heyquark.com> wrote:
>
> Add a device tree source file for the Nintendo Wii U video game console.

Test this with 'make W=1 dtbs_checks'.

>
> Signed-off-by: Ash Logan <ash@heyquark.com>
> Co-developed-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
> Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
> Co-developed-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  arch/powerpc/boot/dts/wiiu.dts | 327 +++++++++++++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/wiiu.dts
>
> diff --git a/arch/powerpc/boot/dts/wiiu.dts b/arch/powerpc/boot/dts/wiiu.dts
> new file mode 100644
> index 000000000000..aaf264963f61
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/wiiu.dts
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0

What about non-GPL environments?

> +/*
> + * Nintendo Wii U Device Tree Source
> + *
> + * Copyright (C) 2022 The linux-wiiu Team
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "nintendo,wiiu";
> +       compatible = "nintendo,wiiu";
> +
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       chosen {
> +               bootargs = "root=/dev/sda1 rootwait";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x00000000 0x02000000    /* MEM1 - 32MiB */
> +                      0x08000000 0x00300000    /* MEM0 - 3MiB  */
> +                      0x10000000 0x80000000>;  /* MEM2 - 2GiB  */
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               /* TODO: Add SMP */
> +               PowerPC,espresso@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       clock-frequency = <1243125000>;         /* 1.243125GHz */
> +                       bus-frequency = <248625000>;            /* 248.625MHz core-to-bus 5x */
> +                       timebase-frequency = <62156250>;        /* 1/4 of the bus clock */
> +                       i-cache-size = <32768>; /* 32K icache */
> +                       i-cache-line-size = <32>;
> +                       i-cache-block-size = <32>;
> +                       i-cache-sets = <128>;
> +                       d-cache-size = <32768>; /* 32K dcache */
> +                       d-cache-line-size = <32>;
> +                       d-cache-block-size = <32>;
> +                       d-cache-sets = <128>;
> +                       next-level-cache = <&L2_0>;
> +                       L2_0:l2-cache {
> +                               compatible = "cache";
> +                               cache-level = <2>;
> +                               cache-unified;
> +                               cache-size = <0x80000>; /* 512KB L2 */
> +                               cache-line-size = <64>;
> +                               cache-block-size = <32>;
> +                               cache-sets = <2048>;
> +                       };
> +               };
> +       };
> +
> +       latte {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "nintendo,latte";
> +               ranges = <0x0c000000 0x0c000000 0x00400000      /* Espresso-only registers */
> +                         0x0d000000 0x0d000000 0x00200000      /* Latte AHB deivces */
> +                         0x0d800000 0x0d800000 0x00800000>;    /* Latte SoC registers */
> +
> +               gpu7@c200000 {

gpu@...

> +                       compatible = "nintendo,latte-gpu7";
> +                       reg = <0x0c200000 0x80000>;
> +                       interrupts = <2>;
> +                       interrupt-parent = <&espresso_pic>;
> +               };
> +
> +               espresso_pic: pic@c000078 {
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +
> +                       compatible = "nintendo,espresso-pic";
> +                       reg = <0x0c000078 0x18>;
> +               };
> +
> +               latte_dsp: dsp@c005000 {
> +                       compatible = "nintendo,latte-dsp";
> +                       reg = <0x0c005000 0x200>;
> +               };
> +
> +               ehci_0: usb@d040000 {
> +                       compatible = "nintendo,latte-usb-ehci", "usb-ehci";
> +                       reg = <0x0d040000 0x100>;
> +                       interrupts = <4>;
> +                       interrupt-parent = <&latte_pic>;
> +                       big-endian-regs;
> +               };
> +
> +               ohci_0_0: usb@d050000 {
> +                       compatible = "nintendo,latte-usb-ohci";
> +                       reg = <0x0d050000 0x100>;
> +                       interrupts = <5>;
> +                       interrupt-parent = <&latte_pic>;
> +
> +                       big-endian-regs;
> +               };
> +
> +               ohci_0_1: usb@d060000 {
> +                       compatible = "nintendo,latte-usb-ohci";
> +                       reg = <0x0d060000 0x100>;
> +                       interrupts = <6>;
> +                       interrupt-parent = <&latte_pic>;
> +
> +                       big-endian-regs;
> +               };
> +
> +               ehci_1: usb@d120000 {
> +                       compatible = "nintendo,latte-usb-ehci", "usb-ehci";
> +                       reg = <0x0d120000 0x100>;
> +                       interrupts = <16>;
> +                       interrupt-parent = <&latte_pic>;
> +                       big-endian-regs;
> +               };
> +
> +               ohci_1_0: usb@d130000 {
> +                       compatible = "nintendo,latte-usb-ohci";
> +                       reg = <0x0d130000 0x100>;
> +                       interrupts = <35>;
> +                       interrupt-parent = <&latte_pic>;
> +
> +                       big-endian-regs;
> +               };
> +
> +               ehci_2: usb@d140000 {
> +                       compatible = "nintendo,latte-usb-ehci", "usb-ehci";
> +                       reg = <0x0d140000 0x100>;
> +                       interrupts = <36>;
> +                       interrupt-parent = <&latte_pic>;
> +                       big-endian-regs;
> +               };
> +
> +               ohci_2_0: usb@d150000 {
> +                       compatible = "nintendo,latte-usb-ohci";
> +                       reg = <0x0d150000 0x100>;
> +                       interrupts = <37>;
> +                       interrupt-parent = <&latte_pic>;
> +
> +                       big-endian-regs;
> +               };
> +
> +               sdcard_0: sdhci@d070000 {
> +                       compatible = "nintendo,latte-sdhci","sdhci";
> +                       reg = <0x0d070000 0x200>;
> +                       interrupts = <7>;
> +                       interrupt-parent = <&latte_pic>;
> +               };
> +
> +               wifi_0: sdhci@d080000 {
> +                       compatible = "nintendo,latte-sdhci","sdhci";
> +                       reg = <0x0d080000 0x200>;
> +                       interrupts = <8>;
> +                       interrupt-parent = <&latte_pic>;
> +               };
> +
> +               legacy_ipc: ipc@d800000 {
> +                       compatible = "nintendo,latte-ipc","nintendo,hollywood-ipc";

space between compatibles needed.

> +                       reg = <0x0d800000 0x10>;
> +                       interrupts = <30 31>;
> +                       interrupt-parent = <&latte_pic>;
> +               };
> +
> +               latte_otp: otp@d8001ec {
> +                       compatible = "nintendo,latte-otp";
> +                       reg = <0x0d8001ec 0x8>;
> +               };
> +
> +               sata: ahci@d160400 {
> +                       compatible = "nintendo,latte-ahci";
> +                       reg = <0x0d160400 0x808>;
> +
> +                       interrupt-parent = <&latte_pic>;
> +                       interrupts = <38 28>;
> +               };
> +
> +               latte_pic: pic@d800440 {
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +
> +                       compatible = "nintendo,latte-pic";
> +                       reg = <0x0d800440 0x30>;
> +                       interrupt-parent = <&espresso_pic>;
> +                       interrupts = <24>;
> +               };
> +
> +               gpio: gpio@d8000c0 {
> +                       #gpio-cells = <2>;
> +                       compatible = "nintendo,latte-gpio", "nintendo,hollywood-gpio";
> +
> +                       reg = <0x0d8000c0 0x40>;
> +                       gpio-controller;
> +                       /* TODO: There are actually 31 AHBALL GPIOs */
> +                       ngpios = <24>;
> +
> +                       gpio-line-names =
> +                               "POWER", "DWIFI", "FAN", "DC_DC",
> +                               "", "Esp10WorkAround", "", "",
> +                               "PADPD", "", "EEP_CS", "EEP_CLK",
> +                               "EEP_MOSI", "EEP_MISO", "AVE_SCL", "AVE_SDA",
> +                               "DEBUG0", "DEBUG1", "DEBUG2", "DEBUG3",
> +                               "DEBUG4", "DEBUG5", "DEBUG6", "DEBUG7";
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +                       interrupts = <10>;
> +                       interrupt-parent = <&latte_pic>;
> +               };
> +
> +               spi_gpio: spi-gpio {

Move this to root level. It's not on the 'latte' bus.

> +                       compatible = "spi-gpio";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "okay";

Not needed, that's the default.

> +
> +                       cs-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> +                       gpio-sck = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +                       gpio-mosi = <&gpio 12 GPIO_ACTIVE_HIGH>;
> +                       gpio-miso = <&gpio 13 GPIO_ACTIVE_HIGH>;
> +                       num-chipselects = <1>;
> +
> +                       seeprom@0 {

eeprom@0

> +                               compatible = "atmel,at93c66";
> +                               reg = <0>;
> +                               spi-max-frequency = <1000000>;
> +                               spi-cs-high;
> +                               /* TODO: wiiubrew says this is 16-bit, but I only get the correct
> +                                * values in 8-bit...
> +                                */
> +                               data-size = <8>;
> +                               read-only;
> +
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +
> +                               /* https://wiiubrew.org/wiki/Hardware/SEEPROM */
> +                               rng_seed: rng@12 { reg = <0x012 8>; };
> +                               ppc_pvr: pvr@20 { reg = <0x020 4>; };
> +                               seeprom_ver_str: sver-str@24 { reg = <0x024 6>; };
> +                               seeprom_ver: sver@2a { reg = <0x02A 2>; };
> +                               otp_ver: over@2c { reg = <0x02C 2>; };
> +                               otp_rev: orev@2e { reg = <0x02E 2>; };
> +                               otp_ver_str: over-str@30 { reg = <0x030 8>; };
> +
> +                               bc_crc: bc-crc@38 { reg = <0x038 4>; };
> +                               bc_sz: bc-sz@3c { reg = <0x03C 2>; };
> +                               bc_ver: bc-ver@3e { reg = <0x03E 2>; };
> +                               bc_boardtype: boardtype@42 { reg = <0x042 2>; };
> +                               bc_boardrev: boardrev@44 { reg = <0x044 2>; };
> +                               bc_bootsource: bootsource@46 { reg = <0x046 2>; };
> +                               bc_ddr3size: ddr3size@48 { reg = <0x048 2>; };
> +                               bc_ddr3speed: ddr3speed@4a { reg = <0x04A 2>; };
> +                               bc_ppcclockmul: ppcclockmul@4c { reg = <0x04C 2>; };
> +                               bc_iopclockmul: iopclockmul@46 { reg = <0x04E 2>; };
> +                               bc_video1080p: video1080p@50 { reg = <0x050 2>; };
> +                               bc_ddr3vendor: ddr3vendor@52 { reg = <0x052 2>; };
> +                               bc_movpassivereset: movpassivereset@54 { reg = <0x054 2>; };
> +                               bc_syspllspd: syspllspd@56 { reg = <0x056 2>; };
> +                               bc_satadevice: satadevice@58 { reg = <0x058 2>; };
> +                               bc_consoletype: consoletype@5a { reg = <0x05A 2>; };
> +                               bc_deviceprescence: deviceprescence@5c { reg = <0x05C 2>; };
> +
> +                               drive_key: drvkey@80 { reg = <0x080 16>; };
> +                               factory_key: fackey@90 { reg = <0x090 16>; };
> +                               shdd_key: shddkey@a0 { reg = <0x0A0 16>; };
> +                               usb_key_seed: usbkeyseed@b0 { reg = <0x0B0 16>; };
> +                               drive_key_flag: drvkeyf@c0 { reg = <0x0C0 2>; };
> +                               usb_key_flag: udbkeyf@c2 { reg = <0x0C2 2>; };
> +                               shdd_key_flag: shddkeyf@c4 { reg = <0x0C4 2>; };
> +
> +                               sysprod_version: sp_ver@140 { reg = <0x140 4>; };
> +                               sysprod_eeprom_version: sp_ee_ver@144 { reg = <0x144 4>; };
> +                               sysprod_product_area: sp_parea@148 { reg = <0x148 4>; };
> +                               sysprod_game_region: sp_region@14c { reg = <0x14C 4>; };
> +                               sysprod_ntsc_pal: sp_ntscpal@150 { reg = <0x150 4>; };
> +                               sysprod_5ghz_country: sp_5ghz_c@154 { reg = <0x154 2>; };
> +                               sysprod_5ghz_country_rev: sp_5ghz_crev@156 { reg = <0x156 2>; };
> +                               sysprod_code: sp_code@158 { reg = <0x158 8>; };
> +                               sysprod_serial: sp_serial@160 { reg = <0x160 16>; };
> +                               sysprod_model: sp_model@170 { reg = <0x170 16>; };
> +
> +                               prod_year: pyear@188 { reg = <0x188 2>; };
> +                               prod_date: pdate@18a { reg = <0x18A 2>; };
> +                               prod_time: ptime@18c { reg = <0x18C 2>; };
> +
> +                               boot_params: boot_params@1c0 { reg = <0x1C0 48>; };
> +                       };
> +               };
> +
> +               /* TODO make this gpio-keyed once hollywood-gpio supports interrupts */
> +               gpio-keys-polled {

This too.

> +                       poll-interval = <50>;
> +                       compatible = "gpio-keys-polled";
> +
> +                       power {
> +                               label = "Power Button";
> +                               gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
> +                               linux,code = <KEY_POWER>;
> +                       };
> +               };
> +
> +               gpio2: gpio2@d8000c0 {

gpio@d800520

> +                       #gpio-cells = <2>;
> +                       compatible = "nintendo,latte-gpio", "nintendo,hollywood-gpio";
> +
> +                       reg = <0x0d800520 0x40>;
> +                       gpio-controller;
> +                       ngpios = <7>;
> +
> +                       gpio-line-names =
> +                               "FANSPEED", "SMC_SCL", "SMC_SDA", "DC_DC2",
> +                               "AVE_INT", "", "AVE_RESET";
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +                       interrupts = <10>;
> +                       interrupt-parent = <&latte_pic>;
> +               };
> +       };
> +};
> --
> 2.35.1
>
