Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BA48C7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354929AbiALQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:05:06 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349654AbiALQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:05:03 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUTxo-1mymAW3XSi-00QX2d; Wed, 12 Jan 2022 17:05:00 +0100
Received: by mail-wr1-f51.google.com with SMTP id d19so5218282wrb.0;
        Wed, 12 Jan 2022 08:05:00 -0800 (PST)
X-Gm-Message-State: AOAM532fEFC7+q8fAs2J4GS8beF+63w22k222x57JixMLXUiFv5jaCFK
        0FM5r9StM58LN6Pfdxq7JFi8DSFYuKHz4c6I/jo=
X-Google-Smtp-Source: ABdhPJwxDiNjuYbWLVY7t/HnE/b6lwh+fnY5dRvYsPdOtZoOHc+AaageW7dUz2/7e+9onzGuGMB9DjgqyRi5twekUIc=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr352566wrw.219.1642003500106;
 Wed, 12 Jan 2022 08:05:00 -0800 (PST)
MIME-Version: 1.0
References: <266065918e47e8965bb6a0ab486da070278788e4.1641996057.git.geert+renesas@glider.be>
 <BY3PR18MB47375336D4AC1FE79D493945C6529@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47375336D4AC1FE79D493945C6529@BY3PR18MB4737.namprd18.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jan 2022 17:04:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2jLgtcuJ6MD7LmJzagiRQSk85eL3tiHDmB33i_n3CZ2w@mail.gmail.com>
Message-ID: <CAK8P3a2jLgtcuJ6MD7LmJzagiRQSk85eL3tiHDmB33i_n3CZ2w@mail.gmail.com>
Subject: Re: [EXT] [PATCH] hwrng: cn10k - HW_RANDOM_CN10K should depend on ARCH_THUNDER
To:     Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:b5qf4fSrYaOSl0TY/67lJGFRyt7/kIn9f92D3rCPV0N+4k1YFSI
 ctF3btkrrmxhGf1ZD/EiK1+MfXbjSeJlK3YKpBkxpX2nnma+YSe1/QOeGg1/jL9kYooxPse
 oxZS20NSOOxw+J9Ku+3q7FUhbQ+H+DQE8Rgidt3V8NzKNfbrqTdZfEXYYYBRfwy+tEK4WN+
 yziu4hm7pRzVTJ4NgWkGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CK+vVeUYYN8=:uYVV6LTf5d6eyPfRqYdKfx
 fLTpQ7Tpj0AzMYab02YykBYox8A2CDqoEQjlDLhc5iNhZkkJF5Z5BBDf5iRT/y1E1Hg0KCmMU
 JVCav3x9+9eBMTlS1hK9pfSWlbYvU6UwfHG2kpZ3dimeMqu899umOOy14tezlFInENOl1U5Ab
 iAU+G/X9lv9W7BvT1dAMvBuaTFLkIkZg3OUQraSPuVF2qdioK5KjKgnMXbA1FS5lbrCuovfrF
 GZtE6FjHZyZEiaZ6kwEcjyAwi5IpG3sbxX9ZX8evw8CD/U4EUe6VkCJ1knwydwIAMWGTNm5e9
 Bh6apuCCy2EbUjqfXtAj1SteBQq4aDOtYvJWehrjxhap5L6eGvwpENtKPUSRLB6UrQAeHs9x2
 b/5sXEQ/uWGfrXa19CPwvcg3W8rcWU2HODHKRAqDmevwmXwVJnCuw5naSvq46dKRrPcuYvuBR
 y4iip5733G9vFd/pKJGHzL6L5Rh9bp/RsVURhCIICiO39LZulxi/S32YVzQPr7PNvFvB8g3g3
 5H9tAniSagpDLfU7nnPwXDtMcQ7tyONc9gZxVHFAZ2a9bc8FT0ufEY0ZqCf2eNnRxWdF56qQt
 vVSmBmh9N6ZWDFABbONDu1+S5Id9jtxx6cjlfB1IcQS4kJPZ/6/pBiibx/KTi4SuWHtbM/Azu
 DE3+jL2bujdaWKeX3no1RxtHFQhkmiqKad6OoYC0q8tKE36djBajWHuzDtEKQY3LH8Y4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 4:55 PM Sunil Kovvuri Goutham
<sgoutham@marvell.com> wrote:
>
> >From: Geert Uytterhoeven <geert+renesas@glider.be>
> >Sent: Wednesday, January 12, 2022 7:33 PM
> >To: Herbert Xu <herbert@gondor.apana.org.au>; Sunil Kovvuri Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>; Joseph Longever <jlongever@marvell.com>
> >Cc: Arnd Bergmann <arnd@arndb.de>; linux-crypto@vger.kernel.org <linux-crypto@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>
> >Subject: [EXT] [PATCH] hwrng: cn10k - HW_RANDOM_CN10K should depend on ARCH_THUNDER
>
> >The Marvell CN10K True Random Number generator is only present on
> >Marvell CN10K SoCs, and not available as an independent PCIe endpoint.
> >Hence add a dependency on ARCH_THUNDER, to prevent asking the user about
> >this driver when configuring a kernel without Cavium Thunder (incl.
> >Marvell CN10K) SoC support.
> >
> >Fixes: 38e9791a02090414 ("hwrng: cn10k - Add random number generator support")
> >Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >---
> >drivers/char/hw_random/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> >index c91cb48a1db168dd..b33c01e9935336f7 100644
> >--- a/drivers/char/hw_random/Kconfig
> >+++ b/drivers/char/hw_random/Kconfig
> >@@ -540,7 +540,7 @@ config HW_RANDOM_ARM_SMCCC_TRNG
> >
> > config HW_RANDOM_CN10K
> >        tristate "Marvell CN10K Random Number Generator support"
> >-       depends on HW_RANDOM && PCI && ARM64
> >+       depends on HW_RANDOM && PCI && ARCH_THUNDER
> >        default HW_RANDOM
> >        help
> >          This driver provides support for the True Random Number
>
> Nack.
> ARCH_THUNDER/THUNDER2 are old Cavium server class silicon series
> which are not related to Marvell CN10K silicon.

Can you tell me where you would draw the line? Based on a discussion we had on
IRC, I was going to send a patch to rename ARCH_THUNDER to ARCH_OCTEON
and clarify how it relates to the other families. Here is what I
understood it should be:

config ARCH_OCTEON
        bool "Marvell OCTEON and ThunderX data processing units"
        help
          This enables support for Marvell (formerly Cavium) OCTEON
          Family of DPUs and SoCs, including OCTEON 10, Octeon TX2
          CN92xx/CN96xx/CN98xx, OcteonTX CN8xxx, ThunderX CN88xx, and
          Octeon Fusion products.

          Note: these are unrelated to the similarly named ThunderX2
          CN99xx server processors, the Octeon TX2 91xx SoCs and the
          Armada processors.

config ARCH_THUNDER2
        bool "Marvell/Cavium ThunderX2 Server Processors"
        select GPIOLIB
        help
          This enables support for Marvell's discontinued ThunderX2
          CN99XX family of server processors, originally sold by Cavium.

          Note: these do not include the unrelated ThunderX CN88xx or
          OCTEON TX2 processors, despite the similarities in naming.

config ARCH_MVEBU
        bool "Marvell EBU SoC Family"
        help
          This enables support for Marvell EBU familly, including:
           - Armada 3700 SoC Family
           - Armada 7K SoC Family
           - Armada 8K SoC Family
           - Octeon TX2 CN91xx Family

If that's not the correct interpretation, does that mean that OCTEON 10
and Octeon TX2 CN92xx/CN96xx/CN98xx are a different family from
Octeon/TX CN8xxx and ThunderX CN88xx and should have a fourth
symbol, or are they part of the Armada family?


      Arnd
