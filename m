Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF146FFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhLJLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhLJLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:19:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D956C061353
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:16:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p18so6517760wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IOhSVXGZBRSw0zeZakbCs4RekQHf59TTJuB443VB/X0=;
        b=sOwojwxwRqSAzGkkcCUe/en8pI2OP1M5Lj/bQo0avyJySvVz3nr0PB1ppido0+BviE
         Sl82iNIgCjuhF3AdpLKeFgxyMVtwLm5YaEQRjRO52avsvrk2it09+VB7uPArA57QiOmX
         eIkJeVKr4W5p8XOcFuVOjfDnBkU2aGxU999LdphVJO2hVODl0rMO9FykfSFkNN7dDG7Q
         bzg0nEEcsYl+Hh4fiB+xuQ0Xp9B2hycmms6DzBxh5URf4MLt4n2Eki0DRDQ/4f46c3Mq
         SaZCwomh21H+4+kKSioGRAgiY65Af+D3m0+ecxgZnB1TVe9zhzT79FlDF03XylyyyTio
         NJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IOhSVXGZBRSw0zeZakbCs4RekQHf59TTJuB443VB/X0=;
        b=cF6G9UJd6FQevPh3FLmhr7p6UdmUMU8V3nECFjuQrxk8T+40KEaOsJ7uOo7Gb7xBDW
         5Uhn4JeGGKtVJO1aFsI2DPzNZyDN7eHBz/1y/LBRN6bkSZuCnG3jQh6wsDg+XCHDWXWY
         +zzGPmdbzVVZUXTiCBQmheK52rbLXBYHLTlsrg/hvXMNqjk0ZB6tytd9qc9t8Fg31r0p
         NfAZpnkp5IOtaBsOalfa6M9I+iLCIcs7iM/MrocOSQ5WTo00UiABwz7AOpFijX/FUaxB
         qWvNBy87mJslNh0F9hIj60Lwy6hc5geMXAkDvvxrm5jlx6By7Iva1/b1rUIiY9DbSD0a
         z46w==
X-Gm-Message-State: AOAM530aCircfVpwMTHnPeHUHLGx2T5AUgqDiDr6Mwj0UVt2Dvv2EiSh
        J1cjK34fLFI7wSaHQ1MwMNzIqw==
X-Google-Smtp-Source: ABdhPJwg1cz+994oJqx0wivT6WBxwHIqGjHbSVd3ksbvrfChdASE3nwqJIepbQp+Eqtp3wFb/qAplQ==
X-Received: by 2002:a1c:a7c3:: with SMTP id q186mr16341830wme.20.1639134971431;
        Fri, 10 Dec 2021 03:16:11 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:8f9e:94f7:810:211b])
        by smtp.gmail.com with ESMTPSA id w15sm2194819wrk.77.2021.12.10.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:16:10 -0800 (PST)
Date:   Fri, 10 Dec 2021 11:16:06 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <YbM29thQ7U4oUmhi@google.com>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
 <YbIhaWC8b2DV5C7Y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbIhaWC8b2DV5C7Y@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:31:53PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 09, 2021 at 03:11:23PM +0000, David Brazdil wrote:
> > Open Profile for DICE is a protocol for deriving unique secrets at boot
> > used by some Android devices. The firmware/bootloader hands over secrets
> > in a reserved memory region, which this driver takes ownership of and
> > exposes it to userspace via a misc device.
> > 
> > Userspace obtains the region's size using an ioctl and mmaps the memory
> > to its address space. This mapping cannot be write+shared, giving
> > userspace a guarantee that the secrets have not been overwritten by
> > another process.
> > 
> > Userspace can also issue an ioctl requesting that the memory be wiped by
> > the driver. Because both the kernel and userspace mappings use
> > write-combine semantics, all clients will observe the memory as zeroed
> > after the ioctl has returned.
> > 
> > Cc: Andrew Scull <ascull@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  drivers/misc/Kconfig                          |   8 +
> >  drivers/misc/Makefile                         |   1 +
> >  drivers/misc/dice.c                           | 161 ++++++++++++++++++
> 
> Nice, almost 100 lines shorter than before!
> 
> Much better, thanks for the changes, but it can be made simpler, see
> comments below:

Yep, thanks for all the tips!

> 
> >  include/uapi/linux/dice.h                     |  14 ++
> >  5 files changed, 185 insertions(+)
> >  create mode 100644 drivers/misc/dice.c
> >  create mode 100644 include/uapi/linux/dice.h
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index cfe6cccf0f44..4b8bee2ffd1e 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -341,6 +341,7 @@ Code  Seq#    Include File                                           Comments
> >  0xAE  40-FF  linux/kvm.h                                             Kernel-based Virtual Machine
> >                                                                       <mailto:kvm@vger.kernel.org>
> >  0xAE  20-3F  linux/nitro_enclaves.h                                  Nitro Enclaves
> > +0xAE  40-5F  uapi/linux/dice.h                                       Open Profile for DICE driver
> 
> Why the huge range?  You are only really using 40 and 41.  Stick to that
> please.

I understood the comments at the top of this file as encouraging devs to
err on the side of caution and be more liberal with the reservations in
case more ioctls are needed in the future. But I agree that it is highly
unlikely this driver will ever need 32 of them.

> 
> >  0xAF  00-1F  linux/fsl_hypervisor.h                                  Freescale hypervisor
> >  0xB0  all                                                            RATIO devices in development:
> >                                                                       <mailto:vgo@ratio.de>
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 0f5a49fc7c9e..7165f4b6c41b 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -470,6 +470,14 @@ config HISI_HIKEY_USB
> >  	  switching between the dual-role USB-C port and the USB-A host ports
> >  	  using only one USB controller.
> > 
> > +config DICE
> > +	tristate "Open Profile for DICE driver"
> > +	depends on OF_RESERVED_MEM
> > +	help
> > +	  This driver allows to ownership of a reserved memory region
> > +	  containing DICE secrets and expose them to userspace via
> > +	  a character device.
> 
> What is the module name, please add that here.
> 
> And "dice" is a very generic name.  I don't mind, but if you want to
> name it a bit more specific, that might be better.
Does "open-dice" sound good? I think that's the shorthand used on the
official website.

> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index a086197af544..f73c6bb23ccd 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
> >  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> >  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> > +obj-$(CONFIG_DICE)		+= dice.o
> > diff --git a/drivers/misc/dice.c b/drivers/misc/dice.c
> > new file mode 100644
> > index 000000000000..06f3754feb71
> > --- /dev/null
> > +++ b/drivers/misc/dice.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 - Google LLC
> > + * Author: David Brazdil <dbrazdil@google.com>
> > + *
> > + * Driver for Open Profile for DICE.
> > + *
> > + * This driver takes ownership of a reserved memory region containing secrets
> > + * derived following the Open Profile for DICE. The contents of the memory
> > + * region are not interpreted by the kernel but can be mapped into a userspace
> > + * process via a misc device. The memory region can also be wiped, removing
> > + * the secrets from memory.
> > + *
> > + * Userspace can access the data by (w/o error handling):
> > + *
> > + *     int fd = open("/dev/dice", O_RDONLY | O_CLOEXEC);
> > + *     size_t size = ioctl(fd, DICE_GET_SIZE);
> > + *     void *data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> > + *     ioctl(fd, DICE_WIPE);
> > + *     close(fd);
> > + */
> > +
> > +#include <linux/dice.h>
> > +#include <linux/io.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/platform_device.h>
> > +
> > +static int dice_mmap(struct file *filp, struct vm_area_struct *vma);
> > +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> > +
> > +static const struct file_operations dice_fops = {
> > +	.mmap = dice_mmap,
> > +	.unlocked_ioctl = dice_ioctl,
> > +};
> > +
> > +static struct miscdevice dice_misc = {
> > +	.name	= "dice",
> > +	.minor	= MISC_DYNAMIC_MINOR,
> > +	.fops	= &dice_fops,
> > +	.mode	= 0400,
> > +};
> > +
> > +static struct reserved_mem *dice_rmem;
> > +static DEFINE_SPINLOCK(dice_lock);
> 
> These should be per-device, not global, right?  Please put them in a
> local structure that lives off of the platform device.  Then everything
> is dynamic and nothing is static making it all much simpler again.
> 
> Do that and you can get rid of the pre-definitions of dice_mmap() and
> dice_ioctl() above as well.0
Ack

> > +
> > +static int dice_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	/* Do not allow userspace to modify the underlying data. */
> > +	if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
> > +		return -EPERM;
> > +
> > +	/* Create write-combine mapping so all clients observe a wipe. */
> > +	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
> > +	return vm_iomap_memory(vma, dice_rmem->base, dice_rmem->size);
> > +}
> > +
> > +static int dice_wipe(void)
> > +{
> > +	void *kaddr;
> > +
> > +	spin_lock(&dice_lock);
> > +	kaddr = devm_memremap(dice_misc.this_device, dice_rmem->base,
> > +			      dice_rmem->size, MEMREMAP_WC);
> > +	if (IS_ERR(kaddr)) {
> > +		spin_unlock(&dice_lock);
> > +		return PTR_ERR(kaddr);
> > +	}
> > +
> > +	memzero_explicit(kaddr, dice_rmem->size);
> > +	devm_memunmap(dice_misc.this_device, kaddr);
> 
> Do you really need to call memzero_explicit()?  This isn't "local"
> memory, if the compiler "optimizes away" a normal call, it would be
> _VERY_ broken.
I agree that it's not needed here. Seemed in line with other code that
handles secrets but i'm happy to just use memset.

> > +	spin_unlock(&dice_lock);
> > +	return 0;
> > +}
> > +
> > +static long dice_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > +{
> > +	switch (cmd) {
> > +	case DICE_GET_SIZE:
> > +		/* Checked against INT_MAX in dice_probe(). */
> > +		return dice_rmem->size;
> > +	case DICE_WIPE:
> > +		return dice_wipe();
> > +	}
> > +
> > +	return -ENOIOCTLCMD;
> 
> -ENOTTY please.
I have no personal attachment to ENOIOCTLCMD, but it is documented as
"no ioctl command" and converted to ENOTTY before returning to userspace.
That made me think this was the right thing to do.

> As you only have 2 ioctls, why not just use read/write for this?  Write
> would cause dice_wipe() to happen, and read would return the size in the
> buffer provided.  Then no ioctl is needed at all.
Fine by me but does feel like a bit of a hack. Is that a common pattern?

> 
> > +}
> > +
> > +static int __init dice_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *rmem_np;
> > +	struct reserved_mem *rmem;
> > +	int ret;
> > +
> > +	if (dice_rmem) {
> > +		dev_err(dev, "only one instance of device allowed\n");
> 
> Why?  That's a device-specific thing, not a driver-specific thing.  Make
> this all dynamic and you don't need to care about it at all.
> 
> Again, simplification :)
> 
> thanks,
> 
> greg k-h
