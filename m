Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9717478E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhLQOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhLQOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:50:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E256C061574;
        Fri, 17 Dec 2021 06:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ABA62243;
        Fri, 17 Dec 2021 14:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129CBC36AE7;
        Fri, 17 Dec 2021 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639752615;
        bh=viUxoT/2r3lETLZyJXth+vblln3i81mX7XVB8BK5GUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t+q/pjVmUj3hZZ1ApKBVRumDnb+6HeuxDKMdBnZWuF4uY4mH0YNRSgbG9FniPhRe5
         SJ70rMZAcypwccKV53FpUZOQ5eqPOgeX7Et5hxHAYPadQxBKBsjkGb+y6+WR6dfAFi
         B2XpXIT+5OTr4QbTIfyxZ7h0KybxK9p9GgkHgQhQsvj7zYdwmpBzqGhjAv0aVWuBaF
         2X3gfRLQg79I/u756dzhY1DMgZg8ZtpaCA+3GbO0vtBtYojgR9NFs+NN9YsGPaRRuR
         ublWUHAhUz636emYc4nHTrh8jyl3o7YI8cySQd0Cdi+nmK/FMPLRv2C9rxfofuNmlg
         /TiAU8b8bUkPQ==
Received: by mail-ed1-f51.google.com with SMTP id o20so8664756eds.10;
        Fri, 17 Dec 2021 06:50:14 -0800 (PST)
X-Gm-Message-State: AOAM533j0zCF6zDpytcAeZWBuR5aertMJYWhonMgY3m9920kecwCAuBf
        NNkDLHEZsv9L6p8q9TPDXAGZzebmnmfPKTV2BA==
X-Google-Smtp-Source: ABdhPJw/vE+TR1HESO1by8p6/bvZPlnosiHar9TIrILCMtaOTI7VyXSpAl1jw66Yn77GXvkEw5w+PUMRP2tVuHzunu8=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr3137320edt.201.1639752613286;
 Fri, 17 Dec 2021 06:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Dec 2021 08:50:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a94CE5iPF5oDznV8vzBaX=tVnbEOPn-zuKd5CnS6ViA@mail.gmail.com>
Message-ID: <CAL_Jsq+a94CE5iPF5oDznV8vzBaX=tVnbEOPn-zuKd5CnS6ViA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:17 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Merge the OF pata_of_platform driver into pata_platform.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/ata/Kconfig            |   3 +-
>  drivers/ata/Makefile           |   1 -
>  drivers/ata/pata_of_platform.c |  90 ---------------
>  drivers/ata/pata_platform.c    | 199 +++++++++++++++++++++++++--------
>  include/linux/ata_platform.h   |   9 --
>  5 files changed, 153 insertions(+), 149 deletions(-)
>  delete mode 100644 drivers/ata/pata_of_platform.c
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index a7da8ea7b3ed..0fab5cae45d5 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1122,7 +1122,8 @@ config PATA_PLATFORM
>
>  config PATA_OF_PLATFORM
>         tristate "OpenFirmware platform device PATA support"
> -       depends on PATA_PLATFORM && OF
> +       depends on OF
> +       select PATA_PLATFORM

Can't we just kill the kconfig option?

>         help
>           This option enables support for generic directly connected ATA
>           devices commonly found on embedded systems with OpenFirmware


> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index cb3134bf88eb..b8d8d51bc562 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -11,21 +11,42 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/blkdev.h>
> -#include <scsi/scsi_host.h>
>  #include <linux/ata.h>
> +#include <linux/ata_platform.h>
> +#include <linux/blkdev.h>
> +#include <linux/kernel.h>
>  #include <linux/libata.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
> +#include <scsi/scsi_host.h>
>
>  #define DRV_NAME "pata_platform"
>  #define DRV_VERSION "1.2"
>
>  static int pio_mask = 1;
>  module_param(pio_mask, int, 0);
> -MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default");
> +MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");
> +
> +/**
> + * struct pata_platform_priv - Private info
> + * @io_res: Resource representing I/O base
> + * @ctl_res: Resource representing CTL base
> + * @irq_res: Resource representing IRQ and its flags
> + * @ioport_shift: I/O port shift
> + * @mask: PIO mask
> + * @sht: scsi_host_template to use when registering
> + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> + */
> +struct pata_platform_priv {
> +       struct resource *io_res;
> +       struct resource *ctl_res;
> +       struct resource *irq_res;
> +       unsigned int ioport_shift;
> +       int mask;
> +       struct scsi_host_template *sht;
> +       bool use16bit;
> +};
>
>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
> @@ -66,15 +87,9 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
>  }
>
>  /**
> - *     __pata_platform_probe           -       attach a platform interface
> + *     pata_platform_host_activate - attach a platform interface
>   *     @dev: device
> - *     @io_res: Resource representing I/O base
> - *     @ctl_res: Resource representing CTL base
> - *     @irq_res: Resource representing IRQ and its flags
> - *     @ioport_shift: I/O port shift
> - *     @__pio_mask: PIO mask
> - *     @sht: scsi_host_template to use when registering
> - *     @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> + *     @priv: Pointer to struct pata_platform_priv
>   *
>   *     Register a platform bus IDE interface. Such interfaces are PIO and we
>   *     assume do not support IRQ sharing.
> @@ -94,10 +109,7 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
>   *
>   *     If no IRQ resource is present, PIO polling mode is used instead.
>   */
> -int __pata_platform_probe(struct device *dev, struct resource *io_res,
> -                         struct resource *ctl_res, struct resource *irq_res,
> -                         unsigned int ioport_shift, int __pio_mask,
> -                         struct scsi_host_template *sht, bool use16bit)
> +static int pata_platform_host_activate(struct device *dev, struct pata_platform_priv *priv)
>  {
>         struct ata_host *host;
>         struct ata_port *ap;
> @@ -108,15 +120,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>         /*
>          * Check for MMIO
>          */
> -       mmio = (( io_res->flags == IORESOURCE_MEM) &&
> -               (ctl_res->flags == IORESOURCE_MEM));
> +       mmio = ((priv->io_res->flags == IORESOURCE_MEM) &&
> +               (priv->ctl_res->flags == IORESOURCE_MEM));
>
>         /*
>          * And the IRQ
>          */
> -       if (irq_res && irq_res->start > 0) {
> -               irq = irq_res->start;
> -               irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
> +       if (priv->irq_res && priv->irq_res->start > 0) {
> +               irq = priv->irq_res->start;
> +               irq_flags = (priv->irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
>         }
>
>         /*
> @@ -131,12 +143,12 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>         ap->ops->inherits = &ata_sff_port_ops;
>         ap->ops->cable_detect = ata_cable_unknown;
>         ap->ops->set_mode = pata_platform_set_mode;
> -       if (use16bit)
> +       if (priv->use16bit)
>                 ap->ops->sff_data_xfer = ata_sff_data_xfer;
>         else
>                 ap->ops->sff_data_xfer = ata_sff_data_xfer32;
>
> -       ap->pio_mask = __pio_mask;
> +       ap->pio_mask = priv->mask;
>         ap->flags |= ATA_FLAG_SLAVE_POSS;
>
>         /*
> @@ -151,15 +163,15 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>          * Handle the MMIO case
>          */
>         if (mmio) {
> -               ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
> -                               resource_size(io_res));
> -               ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
> -                               resource_size(ctl_res));
> +               ap->ioaddr.cmd_addr = devm_ioremap(dev, priv->io_res->start,
> +                                                  resource_size(priv->io_res));
> +               ap->ioaddr.ctl_addr = devm_ioremap(dev, priv->ctl_res->start,
> +                                                  resource_size(priv->ctl_res));
>         } else {
> -               ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
> -                               resource_size(io_res));
> -               ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
> -                               resource_size(ctl_res));
> +               ap->ioaddr.cmd_addr = devm_ioport_map(dev, priv->io_res->start,
> +                                                     resource_size(priv->io_res));
> +               ap->ioaddr.ctl_addr = devm_ioport_map(dev, priv->ctl_res->start,
> +                                                     resource_size(priv->ctl_res));
>         }
>         if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
>                 dev_err(dev, "failed to map IO/CTL base\n");
> @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>
>         ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
>
> -       pata_platform_setup_port(&ap->ioaddr, ioport_shift);
> +       pata_platform_setup_port(&ap->ioaddr, priv->ioport_shift);
>
>         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> -                     (unsigned long long)io_res->start,
> -                     (unsigned long long)ctl_res->start);
> +                     (unsigned long long)priv->io_res->start,
> +                     (unsigned long long)priv->ctl_res->start);
>
>         /* activate */
>         return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
> -                                irq_flags, sht);
> +                                irq_flags, priv->sht);
>  }
> -EXPORT_SYMBOL_GPL(__pata_platform_probe);
>
> -static int pata_platform_probe(struct platform_device *pdev)
> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
> +                                     struct pata_platform_priv *priv)
>  {
> -       struct resource *io_res;
> +       struct device_node *dn = ofdev->dev.of_node;
>         struct resource *ctl_res;
>         struct resource *irq_res;
> +       struct resource *io_res;
> +       int pio_mode = 0;
> +       int irq;
> +       int ret;
> +
> +       ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
> +       io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
> +       irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
> +       if (!ctl_res || !io_res || !irq_res)
> +               return -ENOMEM;
> +
> +       ret = of_address_to_resource(dn, 0, io_res);
> +       if (ret) {
> +               dev_err(&ofdev->dev, "can't get IO address from device tree\n");
> +               return -EINVAL;
> +       }
> +       priv->io_res = io_res;
> +
> +       ret = of_address_to_resource(dn, 1, ctl_res);
> +       if (ret) {
> +               dev_err(&ofdev->dev, "can't get CTL address from device tree\n");
> +               return -EINVAL;
> +       }
> +       priv->ctl_res = ctl_res;
> +
> +       irq = platform_get_irq_optional(ofdev, 0);
> +       if (irq <= 0 && irq != -ENXIO)
> +               return irq ? irq : -ENXIO;
> +
> +       if (irq > 0) {
> +               irq_res->start = irq;
> +               irq_res->end = irq;
> +               irq_res->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);

Though of_irq_to_resource() does the same thing, I think the irq code
handles the flags automatically for DT.

> +               priv->irq_res = irq_res;
> +       } else {
> +               devm_kfree(&ofdev->dev, io_res);

Is this supposed to be irq_res? Otherwise, there shouldn't be any need
to free a devres allocation.

> +       }
> +
> +       of_property_read_u32(dn, "reg-shift", &priv->ioport_shift);
> +
> +       if (!of_property_read_u32(dn, "pio-mode", &pio_mode)) {
> +               if (pio_mode > 6) {
> +                       dev_err(&ofdev->dev, "invalid pio-mode\n");
> +                       return -EINVAL;
> +               }
> +       } else {
> +               dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
> +       }
> +
> +       priv->use16bit = of_property_read_bool(dn, "ata-generic,use16bit");
> +
> +       priv->mask = 1 << pio_mode;
> +       priv->mask |= (1 << pio_mode) - 1;
> +
> +       return 0;
> +}
> +
> +static int pata_platform_get_pdata(struct platform_device *pdev,
> +                                  struct pata_platform_priv *priv)
> +{
>         struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
>
>         /*
> @@ -198,32 +270,63 @@ static int pata_platform_probe(struct platform_device *pdev)
>         /*
>          * Get the I/O base first
>          */
> -       io_res = platform_get_mem_or_io(pdev, 0);
> -       if (unlikely(!io_res))
> +       priv->io_res = platform_get_mem_or_io(pdev, 0);
> +       if (unlikely(!priv->io_res))
>                 return -EINVAL;
>
>         /*
>          * Then the CTL base
>          */
> -       ctl_res = platform_get_mem_or_io(pdev, 1);
> -       if (unlikely(!ctl_res))
> +       priv->ctl_res = platform_get_mem_or_io(pdev, 1);
> +       if (unlikely(!priv->ctl_res))
>                 return -EINVAL;
>
>         /*
>          * And the IRQ
>          */
> -       irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       priv->irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +
> +       priv->ioport_shift = pp_info ? pp_info->ioport_shift : 0;
> +       priv->mask = pio_mask;
> +       priv->use16bit = false;
>
> -       return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
> -                                    pp_info ? pp_info->ioport_shift : 0,
> -                                    pio_mask, &pata_platform_sht, false);
> +       return 0;
> +}
> +
> +static int pata_platform_probe(struct platform_device *pdev)
> +{
> +       struct pata_platform_priv *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       if (!dev_of_node(&pdev->dev))
> +               ret = pata_platform_get_pdata(pdev, priv);
> +       else
> +               ret = pata_of_platform_get_pdata(pdev, priv);
> +
> +       if (ret)
> +               return ret;
> +
> +       priv->sht = &pata_platform_sht;
> +
> +       return pata_platform_host_activate(&pdev->dev, priv);
>  }
>
> +static const struct of_device_id pata_of_platform_match[] = {
> +       { .compatible = "ata-generic", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, pata_of_platform_match);
> +
>  static struct platform_driver pata_platform_driver = {
>         .probe          = pata_platform_probe,
>         .remove         = ata_platform_remove_one,
>         .driver = {
>                 .name           = DRV_NAME,
> +               .of_match_table = pata_of_platform_match,
>         },
>  };
>
> diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
> index 9cafec92282d..91b8529e6712 100644
> --- a/include/linux/ata_platform.h
> +++ b/include/linux/ata_platform.h
> @@ -13,15 +13,6 @@ struct pata_platform_info {
>
>  struct scsi_host_template;
>
> -extern int __pata_platform_probe(struct device *dev,
> -                                struct resource *io_res,
> -                                struct resource *ctl_res,
> -                                struct resource *irq_res,
> -                                unsigned int ioport_shift,
> -                                int __pio_mask,
> -                                struct scsi_host_template *sht,
> -                                bool use16bit);
> -
>  /*
>   * Marvell SATA private data
>   */
> --
> 2.17.1
>
