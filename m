Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D2479297
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhLQROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbhLQROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:14:41 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E826C061574;
        Fri, 17 Dec 2021 09:14:41 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so8542564ybn.0;
        Fri, 17 Dec 2021 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA0xG8dA9Nu56obiYQj3jLuC1P0ALdAAr9itcwXT//I=;
        b=Y+cmkUQ1O8t4fN5TncrfNEwwcJVx7h7q38dAL4Lc9IzY+EDjRLuu3W/UKGD5XTkSdN
         /rSMVdrL6caJdNH52czQNfQ6bQeDa/ycCqhiSunhXjcS6fqj9Ttr8cPW5TvC3rccVuPB
         7V+iPSj5gfu8hBL5VbDWXnMVLcnY2fwF3tY/rnLzUm4itXusSnJ0dh/mbhFRMWGxHUeB
         AZP1H+2WH+EUiLzuO/0ppkaJhkJaKQIOLf8mttNyuqvuD3+wen4kSwbjmPiAgQq99J7T
         HFG2mMNWKVNEI/nVmq/+4bRf50VvbFLCIzzmaUAJKy6eN1CTdWMK49wwTsiqZPFE/HeE
         ycRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA0xG8dA9Nu56obiYQj3jLuC1P0ALdAAr9itcwXT//I=;
        b=AGQ1tQma1nfysK8Km9tgyG2YCmkJkbrzH9Hg6BHN8PeFJuUgBu6DA89K7GtiFRH+tO
         JOXbpZGVI9MtG1M/r2mYpYjjBa81YIq6oHs7Bews01eQez7ylSRmbqOLXb+AhGB+uFFT
         9ZlwJTSR9cazz9QVjUQkAIjrbJUZs221/M1PIObmJqZYknq/XqKys5I654UaKODab0Dp
         RikEBLOvYE+P0vkgIqDLJslHJ/hvTnC7da5HpdkNULZ6TpE9kowkdBSM3wYvIayXIUdq
         lgmFxwXCxBjCtuRl/igC1TETqII8IFtoQHDGyjx2MQUDlrRufCKn3k3VkaD+F1lf0w+w
         qYIw==
X-Gm-Message-State: AOAM532gB748rVEvMemBpiceSBmeurJvUnxCi04YdxFQYZIjXRULljHe
        4LOiOrNs2n6C9QwnzqKvU/FXqUcTokV75csv6Xkj2LFuHMAK9g==
X-Google-Smtp-Source: ABdhPJzQQHKZoS8Gl/zop+ogkPzrj/dRc0Kb9iDNg5NVBJKCRwzsVnD8XMA7bkFjfdrjSchVFWAzKkpi5KEiS5fBbwU=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr5400397ybe.422.1639761280532;
 Fri, 17 Dec 2021 09:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_Jsq+a94CE5iPF5oDznV8vzBaX=tVnbEOPn-zuKd5CnS6ViA@mail.gmail.com>
 <CA+V-a8ta2Bpp=3dwc2tB-Np+whGqg=92E4pRLp=a7KzwCGAz=w@mail.gmail.com> <CAL_JsqJtoZzF5yDOQ5yvf-a-1edrhWG1L-qpGgNGDgcJ4J1bOg@mail.gmail.com>
In-Reply-To: <CAL_JsqJtoZzF5yDOQ5yvf-a-1edrhWG1L-qpGgNGDgcJ4J1bOg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Dec 2021 17:14:14 +0000
Message-ID: <CA+V-a8v9FBgR4-+J++Nsfgpa56hk44GzLgKcfhnVVGtrSSQmyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 5:04 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Dec 17, 2021 at 10:42 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Dec 17, 2021 at 2:50 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, Dec 17, 2021 at 8:17 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > Merge the OF pata_of_platform driver into pata_platform.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/ata/Kconfig            |   3 +-
> > > >  drivers/ata/Makefile           |   1 -
> > > >  drivers/ata/pata_of_platform.c |  90 ---------------
> > > >  drivers/ata/pata_platform.c    | 199 +++++++++++++++++++++++++--------
> > > >  include/linux/ata_platform.h   |   9 --
> > > >  5 files changed, 153 insertions(+), 149 deletions(-)
> > > >  delete mode 100644 drivers/ata/pata_of_platform.c
> > > >
> > > > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > > > index a7da8ea7b3ed..0fab5cae45d5 100644
> > > > --- a/drivers/ata/Kconfig
> > > > +++ b/drivers/ata/Kconfig
> > > > @@ -1122,7 +1122,8 @@ config PATA_PLATFORM
> > > >
> > > >  config PATA_OF_PLATFORM
> > > >         tristate "OpenFirmware platform device PATA support"
> > > > -       depends on PATA_PLATFORM && OF
> > > > +       depends on OF
> > > > +       select PATA_PLATFORM
> > >
> > > Can't we just kill the kconfig option?
> > >
> > No, as there are a couple defconfigs which have this option enabled.
> > So the plan is once this patch is merged for the send in the patches
> > for defconfig files for next release and a release later we can safely
> > drop this. So that we don't break anything.
>
> Wouldn't they all be fine since they already have
> CONFIG_PATA_PLATFORM=y as well?
>
I didn't realize all those defconfigs already have
CONFIG_PATA_PLATFORM enabled. So in that case PATA_OF_PLATFORM can be
wiped out.

> Either way, that's fine.
>
> >
> > > >         help
> > > >           This option enables support for generic directly connected ATA
> > > >           devices commonly found on embedded systems with OpenFirmware
> > >
> > >
> > > > diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> > > > index cb3134bf88eb..b8d8d51bc562 100644
> > > > --- a/drivers/ata/pata_platform.c
> > > > +++ b/drivers/ata/pata_platform.c
> > > > @@ -11,21 +11,42 @@
> > > >   * License.  See the file "COPYING" in the main directory of this archive
> > > >   * for more details.
> > > >   */
> > > > -#include <linux/kernel.h>
> > > > -#include <linux/module.h>
> > > > -#include <linux/blkdev.h>
> > > > -#include <scsi/scsi_host.h>
> > > >  #include <linux/ata.h>
> > > > +#include <linux/ata_platform.h>
> > > > +#include <linux/blkdev.h>
> > > > +#include <linux/kernel.h>
> > > >  #include <linux/libata.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_address.h>
> > > >  #include <linux/platform_device.h>
> > > > -#include <linux/ata_platform.h>
> > > > +#include <scsi/scsi_host.h>
> > > >
> > > >  #define DRV_NAME "pata_platform"
> > > >  #define DRV_VERSION "1.2"
> > > >
> > > >  static int pio_mask = 1;
> > > >  module_param(pio_mask, int, 0);
> > > > -MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default");
> > > > +MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");
> > > > +
> > > > +/**
> > > > + * struct pata_platform_priv - Private info
> > > > + * @io_res: Resource representing I/O base
> > > > + * @ctl_res: Resource representing CTL base
> > > > + * @irq_res: Resource representing IRQ and its flags
> > > > + * @ioport_shift: I/O port shift
> > > > + * @mask: PIO mask
> > > > + * @sht: scsi_host_template to use when registering
> > > > + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > > > + */
> > > > +struct pata_platform_priv {
> > > > +       struct resource *io_res;
> > > > +       struct resource *ctl_res;
> > > > +       struct resource *irq_res;
> > > > +       unsigned int ioport_shift;
> > > > +       int mask;
> > > > +       struct scsi_host_template *sht;
> > > > +       bool use16bit;
> > > > +};
> > > >
> > > >  /*
> > > >   * Provide our own set_mode() as we don't want to change anything that has
> > > > @@ -66,15 +87,9 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
> > > >  }
> > > >
> > > >  /**
> > > > - *     __pata_platform_probe           -       attach a platform interface
> > > > + *     pata_platform_host_activate - attach a platform interface
> > > >   *     @dev: device
> > > > - *     @io_res: Resource representing I/O base
> > > > - *     @ctl_res: Resource representing CTL base
> > > > - *     @irq_res: Resource representing IRQ and its flags
> > > > - *     @ioport_shift: I/O port shift
> > > > - *     @__pio_mask: PIO mask
> > > > - *     @sht: scsi_host_template to use when registering
> > > > - *     @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > > > + *     @priv: Pointer to struct pata_platform_priv
> > > >   *
> > > >   *     Register a platform bus IDE interface. Such interfaces are PIO and we
> > > >   *     assume do not support IRQ sharing.
> > > > @@ -94,10 +109,7 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
> > > >   *
> > > >   *     If no IRQ resource is present, PIO polling mode is used instead.
> > > >   */
> > > > -int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > > -                         struct resource *ctl_res, struct resource *irq_res,
> > > > -                         unsigned int ioport_shift, int __pio_mask,
> > > > -                         struct scsi_host_template *sht, bool use16bit)
> > > > +static int pata_platform_host_activate(struct device *dev, struct pata_platform_priv *priv)
> > > >  {
> > > >         struct ata_host *host;
> > > >         struct ata_port *ap;
> > > > @@ -108,15 +120,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > >         /*
> > > >          * Check for MMIO
> > > >          */
> > > > -       mmio = (( io_res->flags == IORESOURCE_MEM) &&
> > > > -               (ctl_res->flags == IORESOURCE_MEM));
> > > > +       mmio = ((priv->io_res->flags == IORESOURCE_MEM) &&
> > > > +               (priv->ctl_res->flags == IORESOURCE_MEM));
> > > >
> > > >         /*
> > > >          * And the IRQ
> > > >          */
> > > > -       if (irq_res && irq_res->start > 0) {
> > > > -               irq = irq_res->start;
> > > > -               irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> > > > +       if (priv->irq_res && priv->irq_res->start > 0) {
> > > > +               irq = priv->irq_res->start;
> > > > +               irq_flags = (priv->irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> > > >         }
> > > >
> > > >         /*
> > > > @@ -131,12 +143,12 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > >         ap->ops->inherits = &ata_sff_port_ops;
> > > >         ap->ops->cable_detect = ata_cable_unknown;
> > > >         ap->ops->set_mode = pata_platform_set_mode;
> > > > -       if (use16bit)
> > > > +       if (priv->use16bit)
> > > >                 ap->ops->sff_data_xfer = ata_sff_data_xfer;
> > > >         else
> > > >                 ap->ops->sff_data_xfer = ata_sff_data_xfer32;
> > > >
> > > > -       ap->pio_mask = __pio_mask;
> > > > +       ap->pio_mask = priv->mask;
> > > >         ap->flags |= ATA_FLAG_SLAVE_POSS;
> > > >
> > > >         /*
> > > > @@ -151,15 +163,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > >          * Handle the MMIO case
> > > >          */
> > > >         if (mmio) {
> > > > -               ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
> > > > -                               resource_size(io_res));
> > > > -               ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
> > > > -                               resource_size(ctl_res));
> > > > +               ap->ioaddr.cmd_addr = devm_ioremap(dev, priv->io_res->start,
> > > > +                                                  resource_size(priv->io_res));
> > > > +               ap->ioaddr.ctl_addr = devm_ioremap(dev, priv->ctl_res->start,
> > > > +                                                  resource_size(priv->ctl_res));
> > > >         } else {
> > > > -               ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
> > > > -                               resource_size(io_res));
> > > > -               ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
> > > > -                               resource_size(ctl_res));
> > > > +               ap->ioaddr.cmd_addr = devm_ioport_map(dev, priv->io_res->start,
> > > > +                                                     resource_size(priv->io_res));
> > > > +               ap->ioaddr.ctl_addr = devm_ioport_map(dev, priv->ctl_res->start,
> > > > +                                                     resource_size(priv->ctl_res));
> > > >         }
> > > >         if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
> > > >                 dev_err(dev, "failed to map IO/CTL base\n");
> > > > @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > >
> > > >         ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
> > > >
> > > > -       pata_platform_setup_port(&ap->ioaddr, ioport_shift);
> > > > +       pata_platform_setup_port(&ap->ioaddr, priv->ioport_shift);
> > > >
> > > >         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> > > > -                     (unsigned long long)io_res->start,
> > > > -                     (unsigned long long)ctl_res->start);
> > > > +                     (unsigned long long)priv->io_res->start,
> > > > +                     (unsigned long long)priv->ctl_res->start);
> > > >
> > > >         /* activate */
> > > >         return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> > > > -                                irq_flags, sht);
> > > > +                                irq_flags, priv->sht);
> > > >  }
> > > > -EXPORT_SYMBOL_GPL(__pata_platform_probe);
> > > >
> > > > -static int pata_platform_probe(struct platform_device *pdev)
> > > > +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> > > > +                                     struct pata_platform_priv *priv)
> > > >  {
> > > > -       struct resource *io_res;
> > > > +       struct device_node *dn = ofdev->dev.of_node;
> > > >         struct resource *ctl_res;
> > > >         struct resource *irq_res;
> > > > +       struct resource *io_res;
> > > > +       int pio_mode = 0;
> > > > +       int irq;
> > > > +       int ret;
> > > > +
> > > > +       ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> > > > +       io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> > > > +       irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> > > > +       if (!ctl_res || !io_res || !irq_res)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       ret = of_address_to_resource(dn, 0, io_res);
> > > > +       if (ret) {
> > > > +               dev_err(&ofdev->dev, "can't get IO address from device tree\n");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       priv->io_res = io_res;
> > > > +
> > > > +       ret = of_address_to_resource(dn, 1, ctl_res);
> > > > +       if (ret) {
> > > > +               dev_err(&ofdev->dev, "can't get CTL address from device tree\n");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       priv->ctl_res = ctl_res;
> > > > +
> > > > +       irq = platform_get_irq_optional(ofdev, 0);
> > > > +       if (irq <= 0 && irq != -ENXIO)
> > > > +               return irq ? irq : -ENXIO;
> > > > +
> > > > +       if (irq > 0) {
> > > > +               irq_res->start = irq;
> > > > +               irq_res->end = irq;
> > > > +               irq_res->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > >
> > > Though of_irq_to_resource() does the same thing, I think the irq code
> > > handles the flags automatically for DT.
> > >
> > sorry you mean to drop the flags?
>
> Right.
>
Ok, I will drop it.

Cheers,
Prabhakar
