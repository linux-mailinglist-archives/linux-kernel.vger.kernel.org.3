Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67667479256
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhLQREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:04:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46364 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhLQREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:04:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8EAB829C4;
        Fri, 17 Dec 2021 17:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D145AC36AE1;
        Fri, 17 Dec 2021 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639760669;
        bh=aw9+og464mFBxOR5/J3/T5JSL/VHHP21aHx0UbGc/sc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UC8z9gi2dvAKygtpFd5ZWd0qFz3tLm3+PHrF7q6spL1IXQaPHtuS0NLTaNd8yqVC6
         RJHkSXr9K5p3LW4C6onjyCCEn0G9UMEpFZhOVkPkaaIIMR3Y47B3cFBkKbmPR7YjCr
         DHrPWD/eUVfF2xT2XB3lvtLpwwQBbaVPkDY7rP0WxAVPXirx4S/zZqpQNqpJQvjFiS
         5kKZo45JP/yi4Sk4Yj+pUsEqGm1CmZql44sPdDAXRfxjw4ubNWgcj8uQnfSqE5UVyN
         lqmIT1LAH2CbXpd8xjGRlAGffRwATo0N+mmA/GIBZcPh9b3xpiePyAOQ/3JsTyWWR+
         +XZ73D7xY3qJw==
Received: by mail-ed1-f41.google.com with SMTP id y22so10353196edq.2;
        Fri, 17 Dec 2021 09:04:29 -0800 (PST)
X-Gm-Message-State: AOAM5331++sWppsccbv/+g3AlDjp9SQVtwhqmp0cFHJk7qRyA2ZnQPxj
        Rx0j+JuEisdhAlyzlMx499JhepHndS/Edo62YQ==
X-Google-Smtp-Source: ABdhPJxoyix+q4b7WdGzxh8z/07qgwU3bU85A+kpz3cckVdXq/g6ifdxb7KHGabQvZ4PZz2sMcc0dOpEgxi/Y2hZJN4=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr3239259eja.264.1639760668019;
 Fri, 17 Dec 2021 09:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_Jsq+a94CE5iPF5oDznV8vzBaX=tVnbEOPn-zuKd5CnS6ViA@mail.gmail.com> <CA+V-a8ta2Bpp=3dwc2tB-Np+whGqg=92E4pRLp=a7KzwCGAz=w@mail.gmail.com>
In-Reply-To: <CA+V-a8ta2Bpp=3dwc2tB-Np+whGqg=92E4pRLp=a7KzwCGAz=w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Dec 2021 11:04:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJtoZzF5yDOQ5yvf-a-1edrhWG1L-qpGgNGDgcJ4J1bOg@mail.gmail.com>
Message-ID: <CAL_JsqJtoZzF5yDOQ5yvf-a-1edrhWG1L-qpGgNGDgcJ4J1bOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:42 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Rob,
>
> On Fri, Dec 17, 2021 at 2:50 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Dec 17, 2021 at 8:17 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Merge the OF pata_of_platform driver into pata_platform.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/ata/Kconfig            |   3 +-
> > >  drivers/ata/Makefile           |   1 -
> > >  drivers/ata/pata_of_platform.c |  90 ---------------
> > >  drivers/ata/pata_platform.c    | 199 +++++++++++++++++++++++++--------
> > >  include/linux/ata_platform.h   |   9 --
> > >  5 files changed, 153 insertions(+), 149 deletions(-)
> > >  delete mode 100644 drivers/ata/pata_of_platform.c
> > >
> > > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > > index a7da8ea7b3ed..0fab5cae45d5 100644
> > > --- a/drivers/ata/Kconfig
> > > +++ b/drivers/ata/Kconfig
> > > @@ -1122,7 +1122,8 @@ config PATA_PLATFORM
> > >
> > >  config PATA_OF_PLATFORM
> > >         tristate "OpenFirmware platform device PATA support"
> > > -       depends on PATA_PLATFORM && OF
> > > +       depends on OF
> > > +       select PATA_PLATFORM
> >
> > Can't we just kill the kconfig option?
> >
> No, as there are a couple defconfigs which have this option enabled.
> So the plan is once this patch is merged for the send in the patches
> for defconfig files for next release and a release later we can safely
> drop this. So that we don't break anything.

Wouldn't they all be fine since they already have
CONFIG_PATA_PLATFORM=y as well?

Either way, that's fine.

>
> > >         help
> > >           This option enables support for generic directly connected ATA
> > >           devices commonly found on embedded systems with OpenFirmware
> >
> >
> > > diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> > > index cb3134bf88eb..b8d8d51bc562 100644
> > > --- a/drivers/ata/pata_platform.c
> > > +++ b/drivers/ata/pata_platform.c
> > > @@ -11,21 +11,42 @@
> > >   * License.  See the file "COPYING" in the main directory of this archive
> > >   * for more details.
> > >   */
> > > -#include <linux/kernel.h>
> > > -#include <linux/module.h>
> > > -#include <linux/blkdev.h>
> > > -#include <scsi/scsi_host.h>
> > >  #include <linux/ata.h>
> > > +#include <linux/ata_platform.h>
> > > +#include <linux/blkdev.h>
> > > +#include <linux/kernel.h>
> > >  #include <linux/libata.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_address.h>
> > >  #include <linux/platform_device.h>
> > > -#include <linux/ata_platform.h>
> > > +#include <scsi/scsi_host.h>
> > >
> > >  #define DRV_NAME "pata_platform"
> > >  #define DRV_VERSION "1.2"
> > >
> > >  static int pio_mask = 1;
> > >  module_param(pio_mask, int, 0);
> > > -MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default");
> > > +MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");
> > > +
> > > +/**
> > > + * struct pata_platform_priv - Private info
> > > + * @io_res: Resource representing I/O base
> > > + * @ctl_res: Resource representing CTL base
> > > + * @irq_res: Resource representing IRQ and its flags
> > > + * @ioport_shift: I/O port shift
> > > + * @mask: PIO mask
> > > + * @sht: scsi_host_template to use when registering
> > > + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > > + */
> > > +struct pata_platform_priv {
> > > +       struct resource *io_res;
> > > +       struct resource *ctl_res;
> > > +       struct resource *irq_res;
> > > +       unsigned int ioport_shift;
> > > +       int mask;
> > > +       struct scsi_host_template *sht;
> > > +       bool use16bit;
> > > +};
> > >
> > >  /*
> > >   * Provide our own set_mode() as we don't want to change anything that has
> > > @@ -66,15 +87,9 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
> > >  }
> > >
> > >  /**
> > > - *     __pata_platform_probe           -       attach a platform interface
> > > + *     pata_platform_host_activate - attach a platform interface
> > >   *     @dev: device
> > > - *     @io_res: Resource representing I/O base
> > > - *     @ctl_res: Resource representing CTL base
> > > - *     @irq_res: Resource representing IRQ and its flags
> > > - *     @ioport_shift: I/O port shift
> > > - *     @__pio_mask: PIO mask
> > > - *     @sht: scsi_host_template to use when registering
> > > - *     @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > > + *     @priv: Pointer to struct pata_platform_priv
> > >   *
> > >   *     Register a platform bus IDE interface. Such interfaces are PIO and we
> > >   *     assume do not support IRQ sharing.
> > > @@ -94,10 +109,7 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
> > >   *
> > >   *     If no IRQ resource is present, PIO polling mode is used instead.
> > >   */
> > > -int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > > -                         struct resource *ctl_res, struct resource *irq_res,
> > > -                         unsigned int ioport_shift, int __pio_mask,
> > > -                         struct scsi_host_template *sht, bool use16bit)
> > > +static int pata_platform_host_activate(struct device *dev, struct pata_platform_priv *priv)
> > >  {
> > >         struct ata_host *host;
> > >         struct ata_port *ap;
> > > @@ -108,15 +120,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > >         /*
> > >          * Check for MMIO
> > >          */
> > > -       mmio = (( io_res->flags == IORESOURCE_MEM) &&
> > > -               (ctl_res->flags == IORESOURCE_MEM));
> > > +       mmio = ((priv->io_res->flags == IORESOURCE_MEM) &&
> > > +               (priv->ctl_res->flags == IORESOURCE_MEM));
> > >
> > >         /*
> > >          * And the IRQ
> > >          */
> > > -       if (irq_res && irq_res->start > 0) {
> > > -               irq = irq_res->start;
> > > -               irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> > > +       if (priv->irq_res && priv->irq_res->start > 0) {
> > > +               irq = priv->irq_res->start;
> > > +               irq_flags = (priv->irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> > >         }
> > >
> > >         /*
> > > @@ -131,12 +143,12 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > >         ap->ops->inherits = &ata_sff_port_ops;
> > >         ap->ops->cable_detect = ata_cable_unknown;
> > >         ap->ops->set_mode = pata_platform_set_mode;
> > > -       if (use16bit)
> > > +       if (priv->use16bit)
> > >                 ap->ops->sff_data_xfer = ata_sff_data_xfer;
> > >         else
> > >                 ap->ops->sff_data_xfer = ata_sff_data_xfer32;
> > >
> > > -       ap->pio_mask = __pio_mask;
> > > +       ap->pio_mask = priv->mask;
> > >         ap->flags |= ATA_FLAG_SLAVE_POSS;
> > >
> > >         /*
> > > @@ -151,15 +163,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > >          * Handle the MMIO case
> > >          */
> > >         if (mmio) {
> > > -               ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
> > > -                               resource_size(io_res));
> > > -               ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
> > > -                               resource_size(ctl_res));
> > > +               ap->ioaddr.cmd_addr = devm_ioremap(dev, priv->io_res->start,
> > > +                                                  resource_size(priv->io_res));
> > > +               ap->ioaddr.ctl_addr = devm_ioremap(dev, priv->ctl_res->start,
> > > +                                                  resource_size(priv->ctl_res));
> > >         } else {
> > > -               ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
> > > -                               resource_size(io_res));
> > > -               ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
> > > -                               resource_size(ctl_res));
> > > +               ap->ioaddr.cmd_addr = devm_ioport_map(dev, priv->io_res->start,
> > > +                                                     resource_size(priv->io_res));
> > > +               ap->ioaddr.ctl_addr = devm_ioport_map(dev, priv->ctl_res->start,
> > > +                                                     resource_size(priv->ctl_res));
> > >         }
> > >         if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
> > >                 dev_err(dev, "failed to map IO/CTL base\n");
> > > @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> > >
> > >         ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
> > >
> > > -       pata_platform_setup_port(&ap->ioaddr, ioport_shift);
> > > +       pata_platform_setup_port(&ap->ioaddr, priv->ioport_shift);
> > >
> > >         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> > > -                     (unsigned long long)io_res->start,
> > > -                     (unsigned long long)ctl_res->start);
> > > +                     (unsigned long long)priv->io_res->start,
> > > +                     (unsigned long long)priv->ctl_res->start);
> > >
> > >         /* activate */
> > >         return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> > > -                                irq_flags, sht);
> > > +                                irq_flags, priv->sht);
> > >  }
> > > -EXPORT_SYMBOL_GPL(__pata_platform_probe);
> > >
> > > -static int pata_platform_probe(struct platform_device *pdev)
> > > +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> > > +                                     struct pata_platform_priv *priv)
> > >  {
> > > -       struct resource *io_res;
> > > +       struct device_node *dn = ofdev->dev.of_node;
> > >         struct resource *ctl_res;
> > >         struct resource *irq_res;
> > > +       struct resource *io_res;
> > > +       int pio_mode = 0;
> > > +       int irq;
> > > +       int ret;
> > > +
> > > +       ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> > > +       io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> > > +       irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> > > +       if (!ctl_res || !io_res || !irq_res)
> > > +               return -ENOMEM;
> > > +
> > > +       ret = of_address_to_resource(dn, 0, io_res);
> > > +       if (ret) {
> > > +               dev_err(&ofdev->dev, "can't get IO address from device tree\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       priv->io_res = io_res;
> > > +
> > > +       ret = of_address_to_resource(dn, 1, ctl_res);
> > > +       if (ret) {
> > > +               dev_err(&ofdev->dev, "can't get CTL address from device tree\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       priv->ctl_res = ctl_res;
> > > +
> > > +       irq = platform_get_irq_optional(ofdev, 0);
> > > +       if (irq <= 0 && irq != -ENXIO)
> > > +               return irq ? irq : -ENXIO;
> > > +
> > > +       if (irq > 0) {
> > > +               irq_res->start = irq;
> > > +               irq_res->end = irq;
> > > +               irq_res->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> >
> > Though of_irq_to_resource() does the same thing, I think the irq code
> > handles the flags automatically for DT.
> >
> sorry you mean to drop the flags?

Right.

Rob
