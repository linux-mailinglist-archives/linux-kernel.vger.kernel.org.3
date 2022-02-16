Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199724B8D25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiBPQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiBPQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:01:13 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862A2A797D;
        Wed, 16 Feb 2022 08:00:59 -0800 (PST)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MF2YC-1nVND72TaS-00FTOC; Wed, 16 Feb 2022 17:00:57 +0100
Received: by mail-wm1-f41.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso4078885wmq.4;
        Wed, 16 Feb 2022 08:00:57 -0800 (PST)
X-Gm-Message-State: AOAM530bMVy0vUFejYhe04jDZlXPh7tfRhhsSeuEKIGqyiYor+fy9QN9
        3yOZ6Ic+qIc6yGyzKA+EGHe4/ojh4C5l+5HCYRA=
X-Google-Smtp-Source: ABdhPJynoAxya4wFmgdnms1koLXV7kTRWWb6Nv7KnLWbKzdNWIAOdEAPUd2d50HQv+qDZHVfp/C/GrTxO6eYP671+Xg=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr2278615wms.82.1645027256708; Wed, 16
 Feb 2022 08:00:56 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216153632.40981-1-nick.hawkins@hpe.com>
In-Reply-To: <20220216153632.40981-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Feb 2022 17:00:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0NmyxrzxgfwfDXuFvhmc3OL_-yBj8PDdEHh-2qm4NVkw@mail.gmail.com>
Message-ID: <CAK8P3a0NmyxrzxgfwfDXuFvhmc3OL_-yBj8PDdEHh-2qm4NVkw@mail.gmail.com>
Subject: Re: [PATCH] [v3] arch: arm: boot: dts: Create HPE GXP Device Tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EMJdAVKLc4N1yMTu2eQdABxnav7GEg/oYQnkn7fIIvVf3cAE8zM
 XpcEN8IPwJbl0ZT/VSLZYZujju2p+z9AMl994FKrs0iwNN+nXn14I+6sdZMk/queE4aZkBE
 VZdMoyYTPAkcHNjoNb6zYkLA8i//JFjue9tJ9DPH37XyQ30DJMv3X4OSYJKoBrF4n8Kli19
 X82jh9+zcBhnmdot3rknw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xZqbrBQB08=:wS+06g5uZJY0VzhUP0TZj8
 wKPinOk8PeJsuh9AmBpRAPgoyPuGQKpApbTqN4dN5P6VYsECV3h9qxTlpkJPZozdFHfKfQeJC
 6cCNqtSuy3JuGKoVpVNET57EiFLZUyOtaW5L2y6MV5/PaI3lYh0PzDKSF2oocfLOMK5sL/5W0
 xJ1mrAmkSp2r0T3BdrEfcoKxwCpWu2mG9ZLLIwhWWky4cQ0PiAC46pq0zaRkFdZuqfJuCqDYO
 ZF394En7kdJEPW2l/qBOyQELtXrX4XVxRGTDzMNm4O+k4wCeZhrT5duhbhuWmJ7R/DHz3o3CF
 mj57XZB/weJX7xnL4K0ZkkwKgGH3me0a2rilmEsspNucrzqvYKRHixDOd91FZN5GcXV6DaCKR
 gXA9RXdCJy228siCkdwy6J8RDMQu3ecM05qN5ioc3UmhZ/WtBpPbstAc3RE/L1JwiY/mY25tM
 g4EqA8U+8FiC2vmnW9035dh/pyqofKi/wolkg2klJCfWv9M3o6VDLw7C90YrQYLK5mfuKy5iU
 Rghuj4VYk0iQsFfq6hFtSRC0HDMcGo0rpS1bm26wC/yeHV1tvGHwqEA4IKcBlY1ld6KWsfkZu
 90hAaFH9N5jqxi0rsYreyprjwj61BBqQNaJprBYkw2KZbgRbRX3gWDyMobZoeJbGqHYGsQE58
 k6PEE+q9TtLiJue9zmMQu+Zty9a7e+LaJxoTSmOoUBmDNHQmaKKY01JkhW5XVWa//bpQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 4:36 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Description: Originally this was of a larger patch
> HPE BMC GXP SUPPORT that was rejected for being to big.
> This is why the label v3 is being used.
> This patch Create a basic device tree layout that
>  will allow the HPE GXP to boot. The undocumented
>  bindings hpe,gxp-wdt and hpe,gxp-timer are being
>  documented in patches:
>   [v1] dt-bindings: timer: Add HPE GXP Timer binding
>   [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
>   [v1]dt-bindings: vendor-prefixes: add HPE Prefix
>  that are currently out for review.
> The dts file is largely empty for this initial patch but
> follow up patches will add more content.
>
> Information: GXP is the name of the HPE SoC.
>  This SoC is used to implement BMC features of HPE servers
>   (all ProLiant, Synergy, and many Apollo, and Superdome machines)
>    It does support many features including:
>         ARMv7 architecture, and it is based on a Cortex A9 core
>         Use an AXI bus to which
>                 a memory controller is attached, as well as
>                  multiple SPI interfaces to connect boot flash,
>                  and ROM flash, a 10/100/1000 Mac engine which
>                  supports SGMII (2 ports) and RMII
>                 Multiple I2C engines to drive connectivity with a
>                                  host infrastructure
>                 A video engine which support VGA and DP, as well as
>                  an hardware video encoder
>                 Multiple PCIe ports
>                 A PECI interface, and LPC eSPI
>                 Multiple UART for debug purpose, and Virtual UART for
>                  host connectivity
>                 A GPIO engine.

Something happened to the linewrapping here.

>
> +GXP ARM ARCHITECTURE
> +M:     Nick Hawkins <nick.hawkins@hpe.com>
> +M:     Jean-Marie <verdun@hpe.com>

It looks like you are missing the family name here.

> +S:     Maintained
> +F:     arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> +F:     arch/arm/boot/dts/hpe-gxp.dtsi
> +

I would make a single entry for the platform with all the drivers here. Please
keep the MAINTAINERS file patch separate from the devicetree patch though.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 235ad559acb2..a96b4d5b7f68 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1549,3 +1549,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-vegman-n110.dtb \
>         aspeed-bmc-vegman-rx20.dtb \
>         aspeed-bmc-vegman-sx20.dtb
> +dtb-$(CONFIG_ARCH_HPE_GXP) += \
> +       hpe-bmc-dl360gen10.dtb

This Kconfig symbol does not yet exist

> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> new file mode 100644
> index 000000000000..179de6945e3f
> --- /dev/null
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE DL360Gen10
> + */
> +
> +/include/ "hpe-gxp.dtsi"
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "hpe,gxp";

No board specific compatible string? Also, this value is not
documented anywhere.

> +       model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";

> +               bootargs = "earlyprintk console=ttyS0,115200 user_debug=31";

'earlyprintk' and 'user_debug' should not go into the .dts, set these from
the boot loader when you are debugging.

You probably want to add some aliases, to assign fixed numbers to
the uart and mmc controller among other things.

> +               timer0: timer@c0000080 {
> +                       compatible = "hpe,gxp-timer";
> +                       reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
> +                       interrupts = <0>;
> +                       interrupt-parent = <&vic0>;
> +                       clock-frequency = <400000000>;
> +               };
> +
> +               watchdog: watchdog@c0000090 {
> +                       compatible = "hpe,gxp-wdt";
> +                       reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
> +               };

As mentioned in a previous review, it would be helpful to have the drivers
and bindings together in the same series for easier review.

> +               uartc: serial@c00000f0 {
> +                       compatible = "ns16550a";
> +                       reg = <0xc00000f0 0x8>;
> +                       interrupts = <19>;
> +                       interrupt-parent = <&vic0>;
> +                       clock-frequency = <1846153>;
> +                       reg-shift = <0>;
> +               };
> +
> +               usb0: ehci@cefe0000 {
> +                       compatible = "generic-ehci";
> +                       reg = <0xcefe0000 0x100>;
> +                       interrupts = <7>;
> +                       interrupt-parent = <&vic0>;
> +               };

The ehci is almost never completely generic, I would recommend defining a
SoC specific compatible string as well, so you can add quirks later if you
find a problem. Having the generic string as a fallback is a good idea though,
as that means you can just use the normal driver as long as there are no
special requirements.

To a lesser degree, the same is true for the uart.

Please check the devicetree files in order to validate the bindings. In
this case, you should get a warning about the 'ehci@' name being
non-standard. The normal name is usb@

> +               sram@d0000000 {
> +                       compatible = "mtd-ram";
> +                       reg = <0xd0000000 0x80000>;
> +                       bank-width = <1>;
> +                       erase-size =<1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       partition@0 {
> +                               label = "host-reserved";
> +                               reg = <0x0 0x10000>;
> +                       };
> +                       partition@10000 {
> +                               label = "nvram";
> +                               reg = <0x10000 0x70000>;
> +                       };
> +               };

What device is this exactly? The name indicates an sram, which would
use the compatible="mmio-sram" binding instead of "mtd-ram", but then
the partition has an "nvram" label that indicates that this is an nvmem
type device. "mtd-ram" is probably not what you want though.

> +
> +               vrom@58000000 {
> +                       compatible = "mtd-ram";

Same thing here, "vrom" is clearly not a standard name.

       Arnd
