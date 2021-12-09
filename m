Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532CF46E5A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhLIJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLIJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:38:15 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA9C061746;
        Thu,  9 Dec 2021 01:34:42 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id s1so3334148vks.9;
        Thu, 09 Dec 2021 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhbqZ44Km3hEMJLOIn/JDHsMPBI8wkTXvJV+6dMhhMQ=;
        b=g2werV/yPRPpqRsZC5IrmbY5rAfQt8mhW5Y58O0JrasPd2GVoruVkWjrfQFdJuOilx
         bKqYnEjOWMDVUK14JJfpWzPOv6D/NtvP3C/IUJ/1mqYoqortzC+ADpsVqEdcLjH//HVs
         CA8+hDJcWXtZudcS0sPq6HiJ6Awk8/VsjFie0U4fT2yVEC1A79mYGatkfXMCTHruxw0y
         i3wP4X2iO/DkSqZ4TkZwW6/jURFFxH4I3w+mvvL+xQK7TytGQ7UTft+lchncOb8R7Q1R
         PI8v47P0UXY6S5bLhOQwXatw933rXnm7aCs2W4dO221WcopCl/Xz3p3SIqeLq2pZAmI1
         c00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhbqZ44Km3hEMJLOIn/JDHsMPBI8wkTXvJV+6dMhhMQ=;
        b=B+NpVDHVOL32/Yc6Ieu38h4LL1CD2nCg5X8JL0Vai75jz7zXQLWetlGHITDEFRt3uC
         bU1+HWlFOkPpXw47NptGL7AJWT43Qx5nREMwAnRL3Ty61g20OShAZTX+eXwjyJ56TWbI
         0mO9pMZXKGYPLl+1wRLxhlOzIeXMvs0Z+tw2hDaH/43rux2ZW+CFASEX0mTNujBKjSUx
         8yQpcpKbiSZjCtE14HoI6FPhKWXoKZ9/dD6zISU+KTkIw7qlgETXXT91MTQ9bXIeyWAS
         Gg0VW+Fjb5VNi8Dy6l3Mo4uZmcsjsFri05KGLdEia/U1EJdtWHwcv073hSSW5MclhgZ8
         Z6Fw==
X-Gm-Message-State: AOAM532VOrIrPAJt6b7iymMag6YAFcf+vbJm//JEM/TIl97mOR2QJguT
        TczT+mfJMkF1s34aRxFV39LZf3e61zMtpP8+BCDDB2rh
X-Google-Smtp-Source: ABdhPJzwcv+tYVjsmpwwOKPKwpei7TkpCFMiuDe0KHOXCUzNVH75bREe6QP7yRoSg7aH+7n0VHUEjtTXKvR62QpwSXU=
X-Received: by 2002:a1f:2849:: with SMTP id o70mr6796277vko.35.1639042481924;
 Thu, 09 Dec 2021 01:34:41 -0800 (PST)
MIME-Version: 1.0
References: <1637139795-3032-1-git-send-email-yangtiezhu@loongson.cn>
 <20211207170603.GA20028@alpha.franken.de> <CAMhs-H-3FRV2hDKbRR=A2M2fsaengTtTBF7HxCnrtGi=fziK-A@mail.gmail.com>
 <20211209092108.GA6981@alpha.franken.de>
In-Reply-To: <20211209092108.GA6981@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 9 Dec 2021 10:34:30 +0100
Message-ID: <CAMhs-H-fKptFQPh4ictcfG5sxB9xi4a1R8h=iwsXodYNWK4bkA@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 10:26 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Dec 08, 2021 at 02:47:56PM +0100, Sergio Paracuellos wrote:
> > > -#endif
> > > -
> > >  #ifdef CONFIG_PCI_DRIVERS_LEGACY
> > >
> > >  /*
> > > diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> > > index 18eb8a453a86..d2d68bac3d25 100644
> > > --- a/arch/mips/pci/pci-generic.c
> > > +++ b/arch/mips/pci/pci-generic.c
> > > @@ -47,6 +47,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> > >         pci_read_bridge_bases(bus);
> > >  }
> > >
> > > +#ifdef pci_remap_iospace
> > >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >  {
> > >         unsigned long vaddr;
> > > @@ -60,3 +61,4 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >         set_io_port_base(vaddr);
> > >         return 0;
> > >  }
> > > +#endif
> >
> > I agree this is cleaner than the CONFIG_MACH_LOONGSON64 ifdef stuff. I
> > have tested this changes in mt7621 ralink platform and all seem to
> > work, so in case you want to include this, feel free to add my:
>
> thank you for testing.
>
> > Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Thomas, if you prefer me to send this as a more formal PATCH, please
> > let me know.
>
> Thiezhu already did, I'll add your tags the new patch.

Perfect, thanks!

Best regards,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
