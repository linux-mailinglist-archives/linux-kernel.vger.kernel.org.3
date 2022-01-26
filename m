Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFF49C018
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiAZAWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:22:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:33541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiAZAWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:22:45 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mekzb-1meYNS2RHB-00aiK6; Wed, 26 Jan 2022 01:22:43 +0100
Received: by mail-wr1-f53.google.com with SMTP id l25so22781106wrb.13;
        Tue, 25 Jan 2022 16:22:43 -0800 (PST)
X-Gm-Message-State: AOAM530RPwVOwARmZg1kOWWExd1Js5E/8xtkMEcpC6mVH0y//eZbbOSF
        ahwW4TZYCB9VxqzWnzG/syYRUOCBC+txvAd5KIg=
X-Google-Smtp-Source: ABdhPJw8xL5fP5ImHwVQxAhRwGshiRGsLE9PJc/f7ObQjiNeALTrvvCzKw1NaLGtZgfcZ06SL7/hHTHSlA15h93mLHs=
X-Received: by 2002:adf:fd05:: with SMTP id e5mr20174849wrr.192.1643156563174;
 Tue, 25 Jan 2022 16:22:43 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220125194609.32314-1-nick.hawkins@hpe.com>
In-Reply-To: <20220125194609.32314-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Jan 2022 01:22:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
Message-ID: <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9YTmKU0g5XkTW+/PNIPo2UFVxBa1S+LzApisG0m9GZyV9iz24Q/
 CIzZXHf/lWu6qGL1Xa1CASWQJgqMtCCl327475D1fsr+RXqr9/M/8IzmWk8Gs7AZaIxaTU9
 7oMq8pLcBwYynKuUEWE0QIo9BS1inch4dw/vucbzaGp7qz0A2k2kjqbsVao0TOe0LPhz9/E
 92XkOviTWHqjWXCjAS1Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cN2TkLQ7SX0=:0QM7x7Oqmj7YQeiSdey3IO
 foV/rdfeQe6WeRQYPABgCK2Adr61aM4mGYy3UywIhaO9CerHpnfLXuNPAf+jcNATchVDqUnqt
 r/QCxGONon+Fzg6kqoRLnWjQGkF2MbNxHawJwQIYe7gIjAdBAyLbNCuq0XsJ/l2IP79nD11U5
 OomvUoaqGcYDaz6EycuvKnWUda/6LsGMSnc36Ybeqgf4KqiAfSvza0ISFo99/SpYAznviffmS
 o38HRN7JHXslDv6yny92x6sb/pQCvKtvPP3WHBEbne7lNoIOI4MS1pKOvRP6/VplUwv3xXYzA
 bURygDR5rAqyyRyGjWfC9Ie5VtJ9IHY0OkS3SNtH6oQyZ1h3JYCUmluCNelzu0+qYzBDQGNUs
 YvTGf4LBI9urPvgj8yIz/Tyvds23l2yTNYDH+l4ANOddMw20Xq1cH8prxtH7/3if48O7+HmSV
 10EFKGj1dK0jxacdKi6MWwD2LZSmsbuAUnjuNLD7pR3Fh9OxOGJRoxvXtGBHXydBko8AOGncX
 bQ8DXbWV2hBqoIjSQhQraAv9Pond2uKuBTj/GOzVqO/+H3wvuedpJK7qq3fJBdFRHbzs+DAR4
 CFsj5a/yBNO5P+3EW3C6+mn0feqqBfncQMP+6lM1EDvmlLamm1Mn53jsL7oK24bRweLcMuxXg
 8o6RnCAS/vvH0M/dtC9ixD4Uli0iQBoaWQV38svUMcra0M2slTPCPERL1pXSkj2BgAhT7sGuq
 tsXl1or9rRkQjYnusm0Uv3B5IevVja6yf+YgDiqSyrIwLLojn3MI2hde43FNEITE54IW9WGa1
 CASEb5utSrY33ztCHscq0NfTExoIOEnCGEty1mofZnTECDJ9o0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'On Tue, Jan 25, 2022 at 8:46 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Hi Nick,

Thanks for your submission, it's always nice to see support for a new platform.

I assume that you have a number of other drivers that are required for
an initial
support, at least to get you booting into a shell. I recommend to keep
those together
as a series, and we can merge them through the soc tree initially, with an Ack
from the corresponding subsystem maintainers. For later updates to the drivers,
you should send them to the maintainers directly, same for any
non-essential drivers

Krzysztof already commented on most issues I see, here are a few more things
to consider:

>
> +GXP ARCHITECTURE

Make this "ARM/HPE GXP ARCHITECTURE", so it does not get mistaken
for a separate instruction set architecture, or something else with that three
letter acronym.

> +
> +/dts-v1/;
> +/ {
> +  #address-cells = <1>;
> +  #size-cells = <1>;
> +       compatible = "HPE,GXP";
> +       model = "GXP";

Make this the specific machine rather than the SoC, unless you can guarantee
that there won't ever be another board revision made from the same SoC (family).

> +       chosen {
> +               bootargs = "earlyprintk console=ttyS0,115200 user_debug=31";
> +       };

The bootargs should be set by the bootloader. In particular there should be
not 'earlyprintk' by default, and the console should be selected using the
'stdout-path' property.

You seem to be missing CPU nodes.

> +
> +               usb0: ehci@cefe0000 {
> +                       compatible = "generic-ehci";
> +                       reg = <0xcefe0000 0x100>;
> +                       interrupts = <7>;
> +                       interrupt-parent = <&vic0>;
> +               };
> +
> +               usb1: ohci@cefe0100 {
> +                       compatible = "generic-ohci";
> +                       reg = <0xcefe0100 0x110>;
> +                       interrupts = <6>;
> +                       interrupt-parent = <&vic0>;
> +               };

Add a custom compatible string as a specialization in case you ever
need to work around some quirk on these devices.

> +               spifi0: spifi@c0000200 {
> +                       compatible = "hpe,gxp-spifi";
> +                       reg = <0xc0000200 0x80>, <0xc000c000 0x100>, <0xf8000000 0x8000000>;
> +                       interrupts = <20>;
> +                       interrupt-parent = <&vic0>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       flash@0 {
> +                               compatible = "jedec,spi-nor";
> +                               reg = <0>;
> +                               partitions {
> +                                       compatible = "fixed-partitions";
> +                                       #address-cells = <1>;
> +                                       #size-cells = <1>;
> +
> +                                       bmc@0 {
> +                                               label = "bmc";
> +                                               reg = <0x0 0x2000000>;
> +                                       };
> +                                       u-boot@0 {
> +                                               label = "u-boot";
> +                                               reg = <0x0 0x60000>;
> +                                       };


The partitions should ideally be set by the bootloader as well, or
at least be in the .dts file separately from the soc .dtsi file.

> diff --git a/arch/arm/configs/gxp_defconfig b/arch/arm/configs/gxp_defconfig
> new file mode 100644
> index 000000000000..f37c6630e06d
> --- /dev/null
> +++ b/arch/arm/configs/gxp_defconfig

Do you have a strong reason for needing a custom defconfig file?
Usually this should
work with the normal multi_v7_defconfig.


> diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
> new file mode 100644
> index 000000000000..9b27f97c6536
> --- /dev/null
> +++ b/arch/arm/mach-hpe/Kconfig
> @@ -0,0 +1,20 @@
> +menuconfig ARCH_HPE
> +       bool "HPE SoC support"
> +       help
> +         This enables support for HPE ARM based SoC chips
> +if ARCH_HPE
> +
> +config ARCH_HPE_GXP
> +       bool "HPE GXP SoC"
> +       select ARM_VIC
> +       select PINCTRL
> +       select IRQ_DOMAIN
> +       select GENERIC_IRQ_CHIP
> +       select MULTI_IRQ_HANDLER
> +       select SPARSE_IRQ
> +       select CLKSRC_MMIO
> +       depends on ARCH_MULTI_V7


Most of the symbols you select are implied by ARCH_MULTI_V7, so you
can remove them here.

> +#define IOP_REGS_PHYS_BASE 0xc0000000
> +#define IOP_REGS_VIRT_BASE 0xf0000000
> +#define IOP_REGS_SIZE (240*SZ_1M)

We don't normally do custom mappings any more, these should come from
the device tree and get mapped by the corresponding drivers.

> +#define IOP_EHCI_USBCMD 0x0efe0010
> +
> +static struct map_desc gxp_io_desc[] __initdata = {
> +       {
> +       .virtual        = (unsigned long)IOP_REGS_VIRT_BASE,
> +       .pfn            = __phys_to_pfn(IOP_REGS_PHYS_BASE),
> +       .length         = IOP_REGS_SIZE,
> +       .type           = MT_DEVICE,
> +       },
> +};
> +
> +void __init gxp_map_io(void)
> +{
> +       iotable_init(gxp_io_desc, ARRAY_SIZE(gxp_io_desc));
> +}
> +
> +static void __init gxp_dt_init(void)
> +{
> +       //reset EHCI host controller for clear start
> +       __raw_writel(0x00080002,
> +               (void __iomem *)(IOP_REGS_VIRT_BASE + IOP_EHCI_USBCMD));

This belongs into the bootloader, or the EHCI driver, see the comment about a
custom compatible value above ;-)

> +static void gxp_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       pr_info("gpx restart");
> +       __raw_writel(1, (void __iomem *) IOP_REGS_VIRT_BASE);
> +}

This should be a reset driver, see
drivers/power/reset/syscon-reboot.c either as an example, or something you
can use directly.

         Arnd
