Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E946D4C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhLHNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhLHNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:51:38 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D3C061746;
        Wed,  8 Dec 2021 05:48:06 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id y5so4757553ual.7;
        Wed, 08 Dec 2021 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGXi/fNH001qhXdMcg6qOY+4P7hDYY+RIUSw/c5qmqw=;
        b=KiMok9ROe7qbeOI1XoEmtLIBIAbRVxhhTgTvLs3GTHIn+PnHKF7k9FgPoIj7Gq+9AP
         0ZZ8cDkvlMOXaqQgpdxBt1tMNdBxYSI+ifssXmyA7FLBrVwdXou45aeTwbR4oLYDg4sm
         olHb7fvsMjJnw8Zw5K1t7DWXH4NoSoYQVcMJo64dmdmpYSkTwEVeAeBYd2XQT7qeblUJ
         APLB1ohyfrL1dYQyhM1wCf1QVkdJIiOzpw06Gs0RpV+1I7jZ1MuMv71NQoY8xGfPS5/Q
         h0ZsI8TwLO2BCuYaW9N5maDwilxm/IPP3nwPlcwqM0isxO1Enh+oWvCCt2lC4FT/OUFP
         4j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGXi/fNH001qhXdMcg6qOY+4P7hDYY+RIUSw/c5qmqw=;
        b=uI5SbG94p2tTVQmLWv2U8z83GcO2jnkwc3P55tuj48xkT2vmdZqH8GrmgrPNqeVOpB
         /tNdndSOjuLePKwJnngzIb0PR/GuWfGzc3tESyR54DRsJnwZWnpT8vfBY/C+15Wf/Hxw
         +nfRdONW45I0pbbLU9C4Yd0XcP2xgb6j1wfzWKcA0oq4rOCzRRHkKAd8fuCHWTnjvGhw
         O9HNb92hGxwBmNYojHqhCgh50fFrkqkKYBaNjickcxLA0yGDSK6bqhNbT+eZUB9z1Rke
         31UkqvbjirO6eM5BESmPJuDsUNSSdgUjfE7c+Re8LT1C5+i/h0MP/lSR4WOpuSqccg1u
         SsRw==
X-Gm-Message-State: AOAM5335xh3Yv22emutCsBhKxQtcVImXhOTJWC4L7h6BRmOtO++5IT4h
        30f4NJCHjtxLmi1xykrgp3kjsDefqjtfb4FH1mYkBLdS0ks=
X-Google-Smtp-Source: ABdhPJzwMkWmZSPZme+s7WBC8q+JzZV/IlVqJvfGYqKLBAVRaiCoPTgAUM5+VJra2puzHNwpoCyUyuB19RJ1e2uCuiM=
X-Received: by 2002:a67:de12:: with SMTP id q18mr49671551vsk.17.1638971285853;
 Wed, 08 Dec 2021 05:48:05 -0800 (PST)
MIME-Version: 1.0
References: <1637139795-3032-1-git-send-email-yangtiezhu@loongson.cn> <20211207170603.GA20028@alpha.franken.de>
In-Reply-To: <20211207170603.GA20028@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 8 Dec 2021 14:47:56 +0100
Message-ID: <CAMhs-H-3FRV2hDKbRR=A2M2fsaengTtTBF7HxCnrtGi=fziK-A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Do not define pci_remap_iospace() under MACH_LOONGSON64
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sorry I totally missed this patch.

On Wed, Dec 8, 2021 at 5:04 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Nov 17, 2021 at 05:03:15PM +0800, Tiezhu Yang wrote:
> > After commit 9f76779f2418 ("MIPS: implement architecture-specific
> > 'pci_remap_iospace()'"), there exists the following warning on the
> > Loongson64 platform:
> >
> >     loongson-pci 1a000000.pci:       IO 0x0018020000..0x001803ffff -> 0x0000020000
> >     loongson-pci 1a000000.pci:      MEM 0x0040000000..0x007fffffff -> 0x0040000000
> >     ------------[ cut here ]------------
> >     WARNING: CPU: 2 PID: 1 at arch/mips/pci/pci-generic.c:55 pci_remap_iospace+0x84/0x90
> >     resource start address is not zero
> >     ...
> >     Call Trace:
> >     [<ffffffff8020dc78>] show_stack+0x40/0x120
> >     [<ffffffff80cf4a0c>] dump_stack_lvl+0x58/0x74
> >     [<ffffffff8023a0b0>] __warn+0xe0/0x110
> >     [<ffffffff80cee02c>] warn_slowpath_fmt+0xa4/0xd0
> >     [<ffffffff80cecf24>] pci_remap_iospace+0x84/0x90
> >     [<ffffffff807f9864>] devm_pci_remap_iospace+0x5c/0xb8
> >     [<ffffffff808121b0>] devm_of_pci_bridge_init+0x178/0x1f8
> >     [<ffffffff807f4000>] devm_pci_alloc_host_bridge+0x78/0x98
> >     [<ffffffff80819454>] loongson_pci_probe+0x34/0x160
> >     [<ffffffff809203cc>] platform_probe+0x6c/0xe0
> >     [<ffffffff8091d5d4>] really_probe+0xbc/0x340
> >     [<ffffffff8091d8f0>] __driver_probe_device+0x98/0x110
> >     [<ffffffff8091d9b8>] driver_probe_device+0x50/0x118
> >     [<ffffffff8091dea0>] __driver_attach+0x80/0x118
> >     [<ffffffff8091b280>] bus_for_each_dev+0x80/0xc8
> >     [<ffffffff8091c6d8>] bus_add_driver+0x130/0x210
> >     [<ffffffff8091ead4>] driver_register+0x8c/0x150
> >     [<ffffffff80200a8c>] do_one_initcall+0x54/0x288
> >     [<ffffffff811a5320>] kernel_init_freeable+0x27c/0x2e4
> >     [<ffffffff80cfc380>] kernel_init+0x2c/0x134
> >     [<ffffffff80205a2c>] ret_from_kernel_thread+0x14/0x1c
> >     ---[ end trace e4a0efe10aa5cce6 ]---
> >     loongson-pci 1a000000.pci: error -19: failed to map resource [io  0x20000-0x3ffff]
> >
> > We can see that the resource start address is 0x0000020000, because
> > the ISA Bridge used the zero address which is defined in the dts file
> > arch/mips/boot/dts/loongson/ls7a-pch.dtsi:
> >
> >     ISA Bridge: /bus@10000000/isa@18000000
> >     IO 0x0000000018000000..0x000000001801ffff  ->  0x0000000000000000
> >
> > The architecture-independent function pci_remap_iospace() works well
> > for Loongson64, so just do not define architecture-specific function
> > pci_remap_iospace() under MACH_LOONGSON64.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/mips/include/asm/pci.h | 2 ++
> >  arch/mips/pci/pci-generic.c | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> > index 421231f..5d647cb 100644
> > --- a/arch/mips/include/asm/pci.h
> > +++ b/arch/mips/include/asm/pci.h
> > @@ -21,8 +21,10 @@
> >  #include <linux/of.h>
> >
> >  #ifdef CONFIG_PCI_DRIVERS_GENERIC
> > +#ifndef CONFIG_MACH_LOONGSON64
> >  #define pci_remap_iospace pci_remap_iospace
> >  #endif
> > +#endif

I am not sure but maybe just remove the WARN_ON and the if from the
implementation allow also this platform to work with specific MIPS
helper? The only problem I initially see is that the loongson64 puts
isa bridge resource in 0x0 and thus the warning appears. I have to
mention because I don't know other MIPS based SoCs with PCI but
'pci_remap_iospace()' should properly fit all of them... Is a kind of
generic implementation using MIPS 'set_io_port_base()' and 'ioremap()'
for properly remapping things...

>
> I prefer a version without new CONFIG_MACH_LOONGSON64 ifdefery. Something
> like:
>
>
> diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
> index 05d14c21c417..f7af11ea2d61 100644
> --- a/arch/mips/include/asm/mach-ralink/spaces.h
> +++ b/arch/mips/include/asm/mach-ralink/spaces.h
> @@ -6,5 +6,7 @@
>  #define PCI_IOSIZE     SZ_64K
>  #define IO_SPACE_LIMIT (PCI_IOSIZE - 1)
>
> +#define pci_remap_iospace pci_remap_iospace
> +
>  #include <asm/mach-generic/spaces.h>
>  #endif
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 421231f55935..9ffc8192adae 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -20,10 +20,6 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>
> -#ifdef CONFIG_PCI_DRIVERS_GENERIC
> -#define pci_remap_iospace pci_remap_iospace
> -#endif
> -
>  #ifdef CONFIG_PCI_DRIVERS_LEGACY
>
>  /*
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index 18eb8a453a86..d2d68bac3d25 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -47,6 +47,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>         pci_read_bridge_bases(bus);
>  }
>
> +#ifdef pci_remap_iospace
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  {
>         unsigned long vaddr;
> @@ -60,3 +61,4 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>         set_io_port_base(vaddr);
>         return 0;
>  }
> +#endif

I agree this is cleaner than the CONFIG_MACH_LOONGSON64 ifdef stuff. I
have tested this changes in mt7621 ralink platform and all seem to
work, so in case you want to include this, feel free to add my:

Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thomas, if you prefer me to send this as a more formal PATCH, please
let me know.

Best regards,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
