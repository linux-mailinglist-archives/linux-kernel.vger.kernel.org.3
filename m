Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292C4677C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380974AbhLCNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:02:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbhLCNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:02:58 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdf3x-1mKLVU1TP7-00Zglw; Fri, 03 Dec 2021 13:59:33 +0100
Received: by mail-wm1-f53.google.com with SMTP id o29so2291713wms.2;
        Fri, 03 Dec 2021 04:59:33 -0800 (PST)
X-Gm-Message-State: AOAM531gMx3wv85iQEZSTtKcdwWCyL/OU3refkuj+Hz7mgEu9yeHGr0D
        ylAhIjkdAiz/lvAsxt0q0j/7RdrMEeg63tlwLoI=
X-Google-Smtp-Source: ABdhPJyX6CJeai+XlcUbCUwAknx/CsVUVihzpPVX1b5BV3lc0keaqgZHkLPlFaoWVjc6mXCowzLPsQd2AP0COFBqS8Y=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr15201503wmn.98.1638536372919;
 Fri, 03 Dec 2021 04:59:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638515726.git.qinjian@cqplus1.com> <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
In-Reply-To: <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Dec 2021 13:59:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
Message-ID: <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mIPXg2LMYtDEByuHDLalLd/K8sf9pr4S5TrX60AZ0iBJFffwV7t
 uY+sD8kzZPszA57BmjN4u/0klp3dEA508k6ich7vodzSJoBA1SYECIOysvZXOtqsg+s9uA0
 rlYGZHgCZ39kQjiCoglXSJqE2vbIUzcHMgak2fm8SiO5xsCCQ9MEAB8De9a6iSGXERmc1yN
 Cugcrb9i/bkDygVIhpY5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+VvMNvIVBvE=:4XRsltvYstP7/MgxHZ2zjh
 hZXKodpj8eRgwlnpWvdr43vyTjt1dxCJ3jlDPYoJ7eP4bGbQVLbfqjJwv5BapKIGDC1dy3H8K
 8pLOftLuE1AG5SLRcvMPgpSXbzXZdP7LxUeFvW0rAgDwsz/jkjV+LXbpTO4k8PkYRKlwuBvLL
 ZRtr9RYZaeWLVEeW7c50pTgjq53sfBqotzRAPQ5WwVfbMNcg45gi+U+U64jibVxS29bKuewGh
 G4Sjz7yRqBE3L/A5w+wNw0R1VnqIWaAWwT48COX6BowgX66Xf0yJVdPcUhUoODM0CVzQrZoma
 RVRpfbGPwjm6U9L4SDa7ieR0gQThSlIDPNiVDZM75X3W3pZXBCFenZ3ubqOvbbLzIo/QfU2nc
 5Idi2g5OWfgGCvn8LEisywuOvnodubuZHQq60MwTIIKn0fxRbHfS3rvUJZgyA+Q4p9vG8Kry8
 YVd+pwUWk7ixfSwV8OtDJ6QK9fAqzSYzoY11LAVngWSY5IjrthCLVsIDSIfD8lW94EQS5Ai5x
 LcQL3pAFlRKe2OL7yZJc/zGa/ISK1ierkm3INinDwrb0mzw384Uyw/Vw8V1xh7h06Q5+47LhW
 eDzb/LyiaCYtFHSDnB2gPLetWGuZfWKwnBpf0h1EUkFtgmUD89YF3+sBELVQ3srZXR/2ygV/p
 YULCXss2YEKVZBhaMUtNloycXq1vYxEnzj991A2EJn9YOHy05UxYbaz2n8r0KR8tP0f2qdg8O
 ro5+nrIj3Yk6jtsXWTLrQIQAZJbHK3g4TVCaQ3VorthwJhpf2C93gP3xSObVEA7lQWePROzPk
 P766VP+9s0hwO1ub4xUpuX4lb7b0X2+LPX+AM4BnNx8nWFOfEg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:34 AM Qin Jian <qinjian@cqplus1.com> wrote:

> @@ -487,6 +487,22 @@ config ARCH_S3C24XX
>           (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
>           Samsung SMDK2410 development board (and derivatives).
>
> +config ARCH_SUNPLUS
> +       bool "Sunplus SoCs"
> +       select CLKSRC_OF
> +       select COMMON_CLK
> +       select GENERIC_CLOCKEVENTS
> +       select GENERIC_IRQ_CHIP
> +       select GENERIC_IRQ_MULTI_HANDLER
> +       select USE_OF
> +       select RTC_CLASS
> +       select RESET_SUNPLUS

This is in the wrong place: move the Kconfig entry into
arch/arm/mach-sunplus/Kconfig
and make it 'depends on ARCH_MULTI_V7'.

I think you can remove all the 'select' lines as well because they are
either implied by
ARCH_MULTI_V7 or not actually necessary.

> @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> +textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000

What is this needed for? If it boots without this line, better avoid
adding it, because
it will increase the kernel size for everyone else (unless they also enable
AXXIA).

> +config SOC_SP7021
> +       bool "Sunplus SP7021 SoC support"
> +       default y

No 'default y' here. You can probably remove this option completely
and fold it into
ARCH_SUNPLUS.

> +       select CPU_V7
> +       select ARM_GIC
> +       select SUNPLUS_SP7021_INTC
> +       select HAVE_SMP
> +       select ARM_PSCI
> +       select COMMON_CLK_SP7021
> +       select PINCTRL
> +       select PINCTRL_SPPCTL
> +       select OF_OVERLAY
> +       select GPIOLIB
> +       help

Again, most of these should be implied by ARCH_MULTI_V7, so remove those.
For individual drivers, try to avoid the 'select' unless this is required by
the respective driver subsystem.

> diff --git a/arch/arm/mach-sunplus/Makefile.boot b/arch/arm/mach-sunplus/Makefile.boot
> new file mode 100644
> index 000000000..401c30840
> --- /dev/null
> +++ b/arch/arm/mach-sunplus/Makefile.boot
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +zreladdr-$(CONFIG_ARCH_SUNPLUS) := 0x00308000

This should not be needed any more.

       Arnd
