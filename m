Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8D597F40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiHRHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiHRHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:33:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E182AE32;
        Thu, 18 Aug 2022 00:33:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u14so707601wrq.9;
        Thu, 18 Aug 2022 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oIgYqdGNkUA5Gx3TykaijVXwkHT5fLjGYVPrwst8fQ4=;
        b=BdIwV4Gwv7xMuL7nJhQ19IO17Z4uQBDk4fNHv/fy0kprWDV54FP5dblPBmhiJktcsZ
         LyqUgJ5pxha6Fe6EIVlLsrcE5OURTJEbSYV7l2fUOuzmc919WXJ9VTB+G14H4D7Bp01X
         vty7ILZAQ7aQXqfHyCFwEhiVewXAM5H/yHHYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oIgYqdGNkUA5Gx3TykaijVXwkHT5fLjGYVPrwst8fQ4=;
        b=C63Cg4PvVlL4r7hxeHB2emRMxhmz2Bv4QKZ6Cxt1Rdwq8yUnyYNP9957bsmFidrIxJ
         XdZ5XCnY7b0x9UXx2LKLeKFWzr8zwFdeChGVRn/72dAR6qHpUo0dYtG48J+3fJ9NS804
         XOEMHzJy3txRUi5JOn5XM7YtpXP3kysha6IlyVv4VHuP49FvKlMbo0LXNXVLYRWulAsS
         j+jaYB5NDi8Z9g2EqZ4/DeKkJPc4xq4KK/rUF7HAEUxCj5Um4/c28YmWyuL9iEguD91p
         aTZX4NzWoS763w0vMV0fmveTdmIT0qHo/GHfTMGU5OyiIiJIiQhcC0Jl+fZtQvhqyOkG
         uPLA==
X-Gm-Message-State: ACgBeo1cHjWu/59JhSXYXawpJ01At1837z7kID+PkjihSieV9wD1/DH+
        wnjC5lUN5hsG7T6AA2T05wGim4fWjuCYwIhTsndab87A
X-Google-Smtp-Source: AA6agR5vHsJrsW7GaPRw6kaL1Gh4Sk9kyC9svt+gr56MxZe0Bqob4lEc+/mTIX0viHSgeqH/7+t/o+Dl6/4/1QVfQZ8=
X-Received: by 2002:a5d:47ab:0:b0:223:60ee:6c12 with SMTP id
 11-20020a5d47ab000000b0022360ee6c12mr806586wrb.315.1660808013622; Thu, 18 Aug
 2022 00:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220817071539.176110-1-quan@os.amperecomputing.com> <20220817071539.176110-3-quan@os.amperecomputing.com>
In-Reply-To: <20220817071539.176110-3-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 18 Aug 2022 07:33:20 +0000
Message-ID: <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     openbmc@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 at 07:17, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
> hardware reference platform with AmpereOne(TM) processor.
>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> ---
> v3 :
>   + Fix adc-i2c node to generic "adc" node                [Krzysztof]
>   + Remove unused status property in adc node             [Krzysztof]
>   + Remove trailing blank line at the end of file         [Krzysztof]
>   + Remove the wrong comment on vga_memory nodes             [Andrew]
>   + Remove gpio-keys                                         [Andrew]
>   + Remove the line-name for bmc-debug-mode, eth-phy-rst-n,
>     eth-phy-int-n, bmc-salt12-s0-ssif-n, fpga-program-b,
>     bmc-uart-cts1, bmc-spi-fm-boot-abr-pd, emmc-rst-n gpios  [Andrew]
>   + Update line-name for hs-csout-prochot, s1-spi-auth-fail-n  [Quan]
>   + Add line-name [s0|s1]-heartbeat                            [Quan]
>
> v2 :
>   + Remove bootargs                                       [Krzysztof]
>   + Fix gpio-keys nodes name to conform with device tree binding
>   documents                                               [Krzysztof]
>   + Fix some nodes to use generic name                    [Krzysztof]
>   + Remove unnecessary blank line                         [Krzysztof]
>   + Fix typo "LTC" to "LLC" in license info and corrected license
>   info to GPL-2.0-only
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 546 ++++++++++++++++++
>  2 files changed, 547 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..5d8c6ce49af9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1576,6 +1576,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-ast2600-evb.dtb \
>         aspeed-bmc-amd-ethanolx.dtb \
>         aspeed-bmc-ampere-mtjade.dtb \
> +       aspeed-bmc-ampere-mtmitchell.dtb \
>         aspeed-bmc-arm-stardragon4800-rep2.dtb \
>         aspeed-bmc-asrock-e3c246d4i.dtb \
>         aspeed-bmc-asrock-romed8hm3.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> new file mode 100644
> index 000000000000..606cd4be245a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -0,0 +1,546 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2022, Ampere Computing LLC
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "Ampere Mt.Mitchell BMC";
> +       compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
> +
> +       chosen {
> +               stdout-path = &uart5;

I know you've been told by Arnd and others to remove the default
command line here, but without it your device tree fails to produce
any output in my tests:

qemu-system-arm -M ast2600-evb -nographic -dtb
arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dtb -kernel
arch/arm/boot/zImage

Without a working test, I can't tell the difference between a broken
device tree and one that omits the serial device on the command line.
Can you work with Arnd to come to a solution here?

I would prefer to retain the status quo of having the command line in
the device tree. It's served us well for the past five years. It's
overridden by u-boot in all openbmc systems, so
I don't see the harm in having something to ensure it keeps working.

Aside from that your patch looks ready to merge:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel



> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               gfx_memory: framebuffer {
> +                       size = <0x01000000>;
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +
> +               video_engine_memory: video {
> +                       size = <0x04000000>;
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +
> +               vga_memory: region@bf000000 {
> +                       no-map;
> +                       compatible = "shared-dma-pool";
> +                       reg = <0xbf000000 0x01000000>;  /* 16M */
> +               };
> +       };
> +
> +       voltage_mon_reg: voltage-mon-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "ltc2497_reg";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       gpioI5mux: mux-controller {
> +               compatible = "gpio-mux";
> +               #mux-control-cells = <0>;
> +               mux-gpios = <&gpio0 ASPEED_GPIO(I, 5) GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       adc0mux: adc0mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 0>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc1mux: adc1mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 1>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc2mux: adc2mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 2>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc3mux: adc3mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 3>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc4mux: adc4mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 4>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc5mux: adc5mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 5>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc6mux: adc6mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 6>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc7mux: adc7mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc0 7>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc8mux: adc8mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 0>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc9mux: adc9mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 1>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc10mux: adc10mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 2>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc11mux: adc11mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 3>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc12mux: adc12mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 4>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc13mux: adc13mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 5>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc14mux: adc14mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 6>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       adc15mux: adc15mux {
> +               compatible = "io-channel-mux";
> +               io-channels = <&adc1 7>;
> +               #io-channel-cells = <1>;
> +               io-channel-names = "parent";
> +               mux-controls = <&gpioI5mux>;
> +               channels = "s0", "s1";
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0mux 0>, <&adc0mux 1>,
> +                       <&adc1mux 0>, <&adc1mux 1>,
> +                       <&adc2mux 0>, <&adc2mux 1>,
> +                       <&adc3mux 0>, <&adc3mux 1>,
> +                       <&adc4mux 0>, <&adc4mux 1>,
> +                       <&adc5mux 0>, <&adc5mux 1>,
> +                       <&adc6mux 0>, <&adc6mux 1>,
> +                       <&adc7mux 0>, <&adc7mux 1>,
> +                       <&adc8mux 0>, <&adc8mux 1>,
> +                       <&adc9mux 0>, <&adc9mux 1>,
> +                       <&adc10mux 0>, <&adc10mux 1>,
> +                       <&adc11mux 0>, <&adc11mux 1>,
> +                       <&adc12mux 0>, <&adc12mux 1>,
> +                       <&adc13mux 0>, <&adc13mux 1>,
> +                       <&adc14mux 0>, <&adc14mux 1>,
> +                       <&adc15mux 0>, <&adc15mux 1>,
> +                       <&adc_i2c 0>, <&adc_i2c 1>,
> +                       <&adc_i2c 2>, <&adc_i2c 3>,
> +                       <&adc_i2c 4>, <&adc_i2c 5>,
> +                       <&adc_i2c 6>, <&adc_i2c 7>,
> +                       <&adc_i2c 8>, <&adc_i2c 9>,
> +                       <&adc_i2c 10>, <&adc_i2c 11>,
> +                       <&adc_i2c 12>, <&adc_i2c 13>,
> +                       <&adc_i2c 14>, <&adc_i2c 15>;
> +       };
> +};
> +
> +&mdio0 {
> +       status = "okay";
> +
> +       ethphy0: ethernet-phy@0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mac0 {
> +       status = "okay";
> +
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy0>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +       };
> +
> +       flash@1 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "alt-bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +       };
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +               spi-max-frequency = <20000000>;
> +       };
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       temperature-sensor@2e {
> +               compatible = "adi,adt7490";
> +               reg = <0x2e>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +
> +       psu@58 {
> +               compatible = "pmbus";
> +               reg = <0x58>;
> +       };
> +
> +       psu@59 {
> +               compatible = "pmbus";
> +               reg = <0x59>;
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +
> +       adc_i2c: adc@16 {
> +               compatible = "lltc,ltc2497";
> +               reg = <0x16>;
> +               vref-supply = <&voltage_mon_reg>;
> +               #io-channel-cells = <1>;
> +        };
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c64";
> +               reg = <0x50>;
> +               pagesize = <32>;
> +       };
> +
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9545";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +
> +               i2c4_bus70_chn0: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +
> +                       outlet_temp1: temperature-sensor@48 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x48>;
> +                       };
> +                       psu1_inlet_temp2: temperature-sensor@49 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x49>;
> +                       };
> +               };
> +
> +               i2c4_bus70_chn1: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +
> +                       pcie_zone_temp1: temperature-sensor@48 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x48>;
> +                       };
> +                       psu0_inlet_temp2: temperature-sensor@49 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x49>;
> +                       };
> +               };
> +
> +               i2c4_bus70_chn2: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       pcie_zone_temp2: temperature-sensor@48 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x48>;
> +                       };
> +                       outlet_temp2: temperature-sensor@49 {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x49>;
> +                       };
> +               };
> +
> +               i2c4_bus70_chn3: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       mb_inlet_temp1: temperature-sensor@7c {
> +                               compatible = "microchip,emc1413";
> +                               reg = <0x7c>;
> +                       };
> +                       mb_inlet_temp2: temperature-sensor@4c {
> +                               compatible = "microchip,emc1413";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +       };
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +       rtc@51 {
> +               compatible = "nxp,pcf85063a";
> +               reg = <0x51>;
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +};
> +
> +&i2c14 {
> +       status = "okay";
> +       eeprom@50 {
> +               compatible = "atmel,24c64";
> +               reg = <0x50>;
> +               pagesize = <32>;
> +       };
> +
> +       bmc_ast2600_cpu: temperature-sensor@35 {
> +               compatible = "ti,tmp175";
> +               reg = <0x35>;
> +       };
> +};
> +
> +&adc0 {
> +       ref_voltage = <2500>;
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +               &pinctrl_adc2_default &pinctrl_adc3_default
> +               &pinctrl_adc4_default &pinctrl_adc5_default
> +               &pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +       ref_voltage = <2500>;
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +               &pinctrl_adc10_default &pinctrl_adc11_default
> +               &pinctrl_adc12_default &pinctrl_adc13_default
> +               &pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&vhub {
> +       status = "okay";
> +};
> +
> +&video {
> +       status = "okay";
> +       memory-region = <&video_engine_memory>;
> +};
> +
> +&gpio0 {
> +       gpio-line-names =
> +       /*A0-A7*/       "","","","","","i2c2-reset-n","i2c6-reset-n","i2c4-reset-n",
> +       /*B0-B7*/       "","","","","host0-sysreset-n","host0-pmin-n","","",
> +       /*C0-C7*/       "s0-vrd-fault-n","s1-vrd-fault-n","","",
> +                       "irq-n","","vrd-sel","spd-sel",
> +       /*D0-D7*/       "presence-ps0","presence-ps1","hsc-12vmain-alt2-n","ext-high-temp-n",
> +                       "","bmc-ncsi-txen","","",
> +       /*E0-E7*/       "","","clk50m-bmc-ncsi","","","","","",
> +       /*F0-F7*/       "s0-pcp-oc-warn-n","s1-pcp-oc-warn-n","power-chassis-control",
> +                       "cpu-bios-recover","s0-heartbeat","hs-csout-prochot",
> +                       "s0-vr-hot-n","s1-vr-hot-n",
> +       /*G0-G7*/       "","","hsc-12vmain-alt1-n","","","","","",
> +       /*H0-H7*/       "","","wd-disable-n","power-chassis-good","","","","",
> +       /*I0-I7*/       "","","","","","adc-sw","power-button","rtc-battery-voltage-read-enable",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","s0-ddr-save","soc-spi-nor-access","presence-cpu0",
> +                       "s0-rtc-lock","","","",
> +       /*N0-N7*/       "hpm-fw-recovery","hpm-stby-rst-n","jtag-sel-s0","led-sw-hb",
> +                       "jtag-dbgr-prsnt-n","s1-heartbeat","","",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "ps0-ac-loss-n","ps1-ac-loss-n","","",
> +                       "led-fault","cpld-user-mode","jtag-srst-n","led-bmc-hb",
> +       /*Q0-Q7*/       "","","","","","","","",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","identify-button","led-identify",
> +                       "s1-ddr-save","spi-nor-access","sys-pgood","presence-cpu1",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> +                       "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
> +                       "host0-shd-ack-n","s0-overtemp-n",
> +       /*W0-W7*/       "ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> +                       "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
> +       /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
> +                       "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
> +                       "s1-overtemp-n","s1-spi-auth-fail-n",
> +       /*Y0-Y7*/       "","","","","","","","host0-special-boot",
> +       /*Z0-Z7*/       "reset-button","ps0-pgood","ps1-pgood","","","","","";
> +};
> +
> +&gpio1 {
> +       gpio-line-names =
> +       /*18A0-18A7*/   "","","","","","","","",
> +       /*18B0-18B7*/   "","","","","","","s0-soc-pgood","",
> +       /*18C0-18C7*/   "uart1-mode0","uart1-mode1","uart2-mode0","uart2-mode1",
> +                       "uart3-mode0","uart3-mode1","uart4-mode0","uart4-mode1",
> +       /*18D0-18D7*/   "","","","","","","","",
> +       /*18E0-18E3*/   "","","","";
> +};
> --
> 2.35.1
>
