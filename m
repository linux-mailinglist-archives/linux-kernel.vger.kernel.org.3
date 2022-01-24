Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F24977FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiAXEON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXEOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:14:11 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D9C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:14:10 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so3959475plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4f3ldNMeuSPeTOiEzGgOIMF6haAK3h0UmvLV3HEKjE=;
        b=iTdnij9Mqd36WHjFwbv6DAt3tbb0SwwRQOzgjFKkDUHZSY5kShPCVxTZWMKkMd9FPw
         rr4PohxFMhtSOFU/XEjjFl3OkWNOOkrJw1hNAshW+3toZccgqwAn67UnoYJb0jhc1EaW
         OlyXw+GG8e6GTxMdWXTT6+SFZ8n/5RS7UyFntMKpBBIL74vfanzQLwp7Yrr2cyAXdx25
         iH7NRPtOv/fgoC3KPEeGDTKqZhO0DvGyNc/7+mJ+ZO05mpq4zqkTY78Of8TxsoE9MwBs
         ccU5IXGPvoFNZ76VHYkOIqMZAyzSGjPLYQ89Dw4aPl+Ii6/nr6Xw+YNQY+S7gzkE7xx3
         jpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4f3ldNMeuSPeTOiEzGgOIMF6haAK3h0UmvLV3HEKjE=;
        b=CE3ljkjaRYc1A8M3Y/AuinqE28K4fXMMl1zmEHimlW4+/v0AvsLbVHymCoIrR+6iaP
         41183gC4j/dvqYfCgVr20xQleyEDqFZUjqfZfHLSHsrDK3Rw6Ypq2wdYaWkcgc2nFRrc
         aJz8A+dOomM5LfPLAMdd64orE66u8G6my7V5kzTrXpiB8Ec4tTkIKGPYFBCpRBJqYe27
         AennvUo8uEKG7AKAynMgSfXezg15kgieC0wMc/hx5Uck+sYJPaYELS4zsjb20pG7Xo7G
         8kfDDzVIaectLHP2YPrzxeu/XXmCJIilyPpWiUNnKzJdnH2MT4vm6Wv1Mq/7V3yaXoHU
         PLVQ==
X-Gm-Message-State: AOAM530go/BS76bco6iCZjVKFOQkJWYuJ9DCaPeCbJT9/ml0jQJXPGcC
        FlOZlhTixy2+tdp3DGJtdQA=
X-Google-Smtp-Source: ABdhPJz9stJV6Io229P2Rn9iq32hJy/FzMLiiC281/30n/I5V17L0IMVWQBT8y0QG4+68wCDc1JEJA==
X-Received: by 2002:a17:90b:4c91:: with SMTP id my17mr156555pjb.121.1642997649738;
        Sun, 23 Jan 2022 20:14:09 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id k15sm1717800pff.39.2022.01.23.20.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 20:14:09 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:14:04 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: pi433: add debugfs interface
Message-ID: <20220124041404.GA4063@mail.google.com>
References: <20220123073855.GA79453@mail.google.com>
 <20220123074029.GA79722@mail.google.com>
 <Ye06GfUzwzQBvfLy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye06GfUzwzQBvfLy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 12:20:57PM +0100, Greg KH wrote:
> On Sun, Jan 23, 2022 at 08:40:29PM +1300, Paulo Miguel Almeida wrote:
> > This adds debugfs interface that can be used for debugging possible
> > hardware/software issues.
> > 
> > It currently exposes the following debugfs entries for each SPI device
> > probed:
> > 
> >   /sys/kernel/debug/pi433/<DEVICE>/regs
> >   ...
> > 
> > The 'regs' file contains all rf69 uC registers values that are useful
> > for troubleshooting misconfigurations between 2 devices. It contains one
> > register per line so it should be easy to use normal filtering tools to
> > find the registers of interest if needed.
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Meta-comments:
> > 
> > - I'm not entirely sure if I'm allowed to add additional dependencies to Kconfig
> > the way I did or if I should surround debugfs routines with 
> > #ifdef CONFIG_DEBUG_FS. I saw both approaches couldn't put my finger on which 
> > one is the 'right' way here. I'm taking suggestions :)
> 
> Neither is really needed at all.  The debugfs api will work properly if
> the main config option is not enabled, and the code will be compiled
> away properly.
> 
> So no need to add any dependancy to your driver at all.
> 
> debugfs was designed to be simple to use, and adding dependancies is not
> simple.  Same goes for my comments below, the goal is to keep it simple
> and not worry about any error handling.
> 
> > - I saw that in some other drivers there is a tendency to have debugfs routines
> > in a separate file such as debugfs.c and in that way this allows for smaller 
> > files (which I do like) and Makefile that build files based on selected 
> > configs such as:
> > 
> > pi433-$(CONFIG_DEBUG_FS) += debugfs.o 
> 
> Again, not needed.
> 
> > The only way I could achieve such thing would be if I moved pi433_device struct
> > to pi433_if.h but I wanted to double check if reviewers would agree with this 
> > approach first.
> > 
> > ---
> >  drivers/staging/pi433/Kconfig    |  2 +-
> >  drivers/staging/pi433/pi433_if.c | 82 ++++++++++++++++++++++++++++++++
> >  drivers/staging/pi433/rf69.c     |  2 +-
> >  drivers/staging/pi433/rf69.h     |  1 +
> >  4 files changed, 85 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
> > index dd9e4709d1a8..9a8b7ef3e670 100644
> > --- a/drivers/staging/pi433/Kconfig
> > +++ b/drivers/staging/pi433/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  config PI433
> >  	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
> > -	depends on SPI
> > +	depends on SPI && DEBUG_FS
> 
> You can drop this.
> 
> >  	help
> >  	  This option allows you to enable support for the radio module Pi433.
> >  
> > diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> > index 17ff51f6a9da..e3a0d78385c0 100644
> > --- a/drivers/staging/pi433/pi433_if.c
> > +++ b/drivers/staging/pi433/pi433_if.c
> > @@ -41,6 +41,9 @@
> >  #ifdef CONFIG_COMPAT
> >  #include <linux/compat.h>
> >  #endif
> > +#include <linux/debugfs.h>
> > +#include <linux/seq_file.h>
> > +
> >  
> >  #include "pi433_if.h"
> >  #include "rf69.h"
> > @@ -56,6 +59,8 @@ static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
> >  
> >  static struct class *pi433_class; /* mainly for udev to create /dev/pi433 */
> >  
> > +static struct dentry *dbgfs_root_entry;
> 
> There is no need for this dentry.  Just look it up if you care about it.
> 
> > +
> >  /*
> >   * tx config is instance specific
> >   * so with each open a new tx config struct is needed
> > @@ -103,6 +108,9 @@ struct pi433_device {
> >  	bool			rx_active;
> >  	bool			tx_active;
> >  	bool			interrupt_rx_allowed;
> > +
> > +	/* debug fs */
> > +	struct dentry		*entry;
> 
> Again, no need for this, look it up if you need it.
> 
> >  };
> >  
> >  struct pi433_instance {
> > @@ -1102,6 +1110,72 @@ static const struct file_operations pi433_fops = {
> >  	.llseek =	no_llseek,
> >  };
> >  
> > +static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> > +{
> > +	struct pi433_device *dev;
> > +	u8 reg_data[114];
> > +	size_t i;
> > +	char *fmt = "0x%02x, 0x%02x\n";
> > +
> > +	// obtain pi433_device reference
> > +	dev = m->private;
> 
> That is not a "reference", that is just a normal empty pointer.  No need
> to call it something else, that's just confusing.
> 
> > +
> > +	// acquire locks to avoid race conditions
> > +	mutex_lock(&dev->tx_fifo_lock);
> > +	mutex_lock(&dev->rx_lock);
> > +
> > +	// wait for on-going operations to finish
> > +	if (dev->tx_active)
> > +		wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
> > +
> > +	if (dev->rx_active)
> > +		wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
> > +
> > +	// read contiguous regs
> > +	// skip FIFO register (0x0) otherwise this can affect some of uC ops
> > +	for (i = 1; i < 0x50; i++)
> > +		reg_data[i] = rf69_read_reg(dev->spi, i);
> > +
> > +	// read non-contiguous regs
> > +	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
> > +	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
> > +	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
> > +	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
> > +	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
> > +
> > +	seq_puts(m, "# reg, val\n");
> > +
> > +	// print contiguous regs
> > +	for (i = 1; i < 0x50; i++)
> > +		seq_printf(m, fmt, i, reg_data[i]);
> > +
> > +	// print non-contiguous regs
> > +	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
> > +	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
> > +	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
> > +	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
> > +	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
> > +
> > +	// release locks
> > +	mutex_unlock(&dev->tx_fifo_lock);
> > +	mutex_unlock(&dev->rx_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
> > +{
> > +	return single_open(filp, pi433_debugfs_regs_show, inode->i_private);
> > +}
> > +
> > +static const struct file_operations debugfs_fops = {
> > +	.llseek =	seq_lseek,
> > +	.open =		pi433_debugfs_regs_open,
> > +	.owner =	THIS_MODULE,
> > +	.read =		seq_read,
> > +	.release =	single_release
> > +};
> > +
> >  /*-------------------------------------------------------------------------*/
> >  
> >  static int pi433_probe(struct spi_device *spi)
> > @@ -1256,6 +1330,10 @@ static int pi433_probe(struct spi_device *spi)
> >  	/* spi setup */
> >  	spi_set_drvdata(spi, device);
> >  
> > +	/* debugfs setup */
> > +	device->entry = debugfs_create_dir(dev_name(device->dev), dbgfs_root_entry);
> 
> Make "entry" a local variable, and then pass it to the next call.
> 
> And look up dbgfs_root_entry as well.  This can be rewritten as:
> 	entry = debugfs_create_dir(dev_name(device->dev,
> 					    debugfs_lookup("pi433", NULL);
> 
> > +	debugfs_create_file("regs", 0400, device->entry, device, &debugfs_fops);
> 
> When do you ever remove the debugfs entry for the device?  I do not see
> that in any release function here.  Did you forget about that?
> 
> > +
> >  	return 0;
> >  
> >  del_cdev:
> > @@ -1353,6 +1431,8 @@ static int __init pi433_init(void)
> >  		return PTR_ERR(pi433_class);
> >  	}
> >  
> > +	dbgfs_root_entry = debugfs_create_dir("pi433", NULL);
> 
> Again, no need to keep this around, see above.
> 
> > +
> >  	status = spi_register_driver(&pi433_spi_driver);
> >  	if (status < 0) {
> >  		class_destroy(pi433_class);
> > @@ -1370,6 +1450,8 @@ static void __exit pi433_exit(void)
> >  	spi_unregister_driver(&pi433_spi_driver);
> >  	class_destroy(pi433_class);
> >  	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
> > +	debugfs_remove_recursive(dbgfs_root_entry);
> 
> Can be rewritten as:
> 	debugfs_remove_recursive(debugfs_lookup("pi433", NULL));
> 
> Or better yet:
> 	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODULE_NAME, NULL));
> 
> thanks,
> 
> greg k-h

thanks for taking the time to review this patchset. 

you are right, I will make the changes you pointed out and submit a new 
version of the patchset shortly.

thanks,

Paulo Almeida
