Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8623497083
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiAWHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiAWHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:40:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F4C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:40:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q63so8542322pja.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=iIZAUjxhwvJ8R25ya418ZhGBq/ZBs7/5y004Pepqq80=;
        b=cOMm5MEVT0i93HCloB8IaY7oqI9utUbFo0nF9Hvyi1P0x39mLdyVjZydTVFnQKHnSm
         RgmK096oSVrjlwwi77wsRxauu49GFqVgixXOT54XOvXx/Hk5jpKMBOzO8Irdbd4q0E78
         OqhKZ7E+HxNS4K1kAWrrvunbKWozjf/+q6N1KYaICwncU2voLdP9bu2kaVsmDnOBS4H8
         sjcyA3f98fiY+mX/HkfSD5MMMT6Ls/SGKKG32BrvGrfWj4q+UfNnmr1E5vbRvdveENds
         PI1pgqx5DQrumaEEEYCrRd3rx7/w3nj7KRP6zP5EhDXQZCWXKXKwgLiYvGnYZNCOpB+0
         45xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=iIZAUjxhwvJ8R25ya418ZhGBq/ZBs7/5y004Pepqq80=;
        b=wAvvoX+76ZUrUrfFERlupaSYSoztgIFmuLVDTY7bdXld8FBpsX/D892NTmNQjZQf0t
         kO6RptcEPaiMZaD+09nWYFyTtu47OAjNueAoMnECpkk45ZYfhYrxFqj+jQDxZsA3UVpb
         MKOjmp8HChQ1GNsDN8rz1Y+fqxU2q7R5diKAFnj2e2g8hZoCwmgAEGDTf9sIEEYMxWLU
         gImd/a/wbMJf4z4TYgtcrFIh+nVRmQC6wUnChc42Sn139dXfkjQskJGDohpa+3OI3x/l
         E1ba40aHNCsqFKPBlIih3RtHtINY972ElLJaaZO2NQ7gdBRN5t9hJEDIUzvN3i8ILD2W
         66cQ==
X-Gm-Message-State: AOAM531xRoJpDOHUFTcP+Qo29WmLTMjunF+Ka9/1d1/3RKN2UgRa2RRS
        e+CK4YKRvrsSHExFqCFfVeU=
X-Google-Smtp-Source: ABdhPJxX73IiZXFzY1UsK6eHAaEi9YK0lSE7hf050sm/IAwBGK1y00TpiiY288V4ls4LfEDVFshKCw==
X-Received: by 2002:a17:90a:6409:: with SMTP id g9mr7931490pjj.108.1642923634561;
        Sat, 22 Jan 2022 23:40:34 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id u17sm8785961pgi.14.2022.01.22.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 23:40:34 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:40:29 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: pi433: add debugfs interface
Message-ID: <20220123074029.GA79722@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123073855.GA79453@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds debugfs interface that can be used for debugging possible
hardware/software issues.

It currently exposes the following debugfs entries for each SPI device
probed:

  /sys/kernel/debug/pi433/<DEVICE>/regs
  ...

The 'regs' file contains all rf69 uC registers values that are useful
for troubleshooting misconfigurations between 2 devices. It contains one
register per line so it should be easy to use normal filtering tools to
find the registers of interest if needed.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

- I'm not entirely sure if I'm allowed to add additional dependencies to Kconfig
the way I did or if I should surround debugfs routines with 
#ifdef CONFIG_DEBUG_FS. I saw both approaches couldn't put my finger on which 
one is the 'right' way here. I'm taking suggestions :)

- I saw that in some other drivers there is a tendency to have debugfs routines
in a separate file such as debugfs.c and in that way this allows for smaller 
files (which I do like) and Makefile that build files based on selected 
configs such as:

pi433-$(CONFIG_DEBUG_FS) += debugfs.o 

The only way I could achieve such thing would be if I moved pi433_device struct
to pi433_if.h but I wanted to double check if reviewers would agree with this 
approach first.

---
 drivers/staging/pi433/Kconfig    |  2 +-
 drivers/staging/pi433/pi433_if.c | 82 ++++++++++++++++++++++++++++++++
 drivers/staging/pi433/rf69.c     |  2 +-
 drivers/staging/pi433/rf69.h     |  1 +
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index dd9e4709d1a8..9a8b7ef3e670 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PI433
 	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
-	depends on SPI
+	depends on SPI && DEBUG_FS
 	help
 	  This option allows you to enable support for the radio module Pi433.
 
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 17ff51f6a9da..e3a0d78385c0 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -41,6 +41,9 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 #endif
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
 
 #include "pi433_if.h"
 #include "rf69.h"
@@ -56,6 +59,8 @@ static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
 
 static struct class *pi433_class; /* mainly for udev to create /dev/pi433 */
 
+static struct dentry *dbgfs_root_entry;
+
 /*
  * tx config is instance specific
  * so with each open a new tx config struct is needed
@@ -103,6 +108,9 @@ struct pi433_device {
 	bool			rx_active;
 	bool			tx_active;
 	bool			interrupt_rx_allowed;
+
+	/* debug fs */
+	struct dentry		*entry;
 };
 
 struct pi433_instance {
@@ -1102,6 +1110,72 @@ static const struct file_operations pi433_fops = {
 	.llseek =	no_llseek,
 };
 
+static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
+{
+	struct pi433_device *dev;
+	u8 reg_data[114];
+	size_t i;
+	char *fmt = "0x%02x, 0x%02x\n";
+
+	// obtain pi433_device reference
+	dev = m->private;
+
+	// acquire locks to avoid race conditions
+	mutex_lock(&dev->tx_fifo_lock);
+	mutex_lock(&dev->rx_lock);
+
+	// wait for on-going operations to finish
+	if (dev->tx_active)
+		wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
+
+	if (dev->rx_active)
+		wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
+
+	// read contiguous regs
+	// skip FIFO register (0x0) otherwise this can affect some of uC ops
+	for (i = 1; i < 0x50; i++)
+		reg_data[i] = rf69_read_reg(dev->spi, i);
+
+	// read non-contiguous regs
+	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
+	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
+	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
+	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
+	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
+
+	seq_puts(m, "# reg, val\n");
+
+	// print contiguous regs
+	for (i = 1; i < 0x50; i++)
+		seq_printf(m, fmt, i, reg_data[i]);
+
+	// print non-contiguous regs
+	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
+	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
+	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
+	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
+	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
+
+	// release locks
+	mutex_unlock(&dev->tx_fifo_lock);
+	mutex_unlock(&dev->rx_lock);
+
+	return 0;
+}
+
+static ssize_t pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, pi433_debugfs_regs_show, inode->i_private);
+}
+
+static const struct file_operations debugfs_fops = {
+	.llseek =	seq_lseek,
+	.open =		pi433_debugfs_regs_open,
+	.owner =	THIS_MODULE,
+	.read =		seq_read,
+	.release =	single_release
+};
+
 /*-------------------------------------------------------------------------*/
 
 static int pi433_probe(struct spi_device *spi)
@@ -1256,6 +1330,10 @@ static int pi433_probe(struct spi_device *spi)
 	/* spi setup */
 	spi_set_drvdata(spi, device);
 
+	/* debugfs setup */
+	device->entry = debugfs_create_dir(dev_name(device->dev), dbgfs_root_entry);
+	debugfs_create_file("regs", 0400, device->entry, device, &debugfs_fops);
+
 	return 0;
 
 del_cdev:
@@ -1353,6 +1431,8 @@ static int __init pi433_init(void)
 		return PTR_ERR(pi433_class);
 	}
 
+	dbgfs_root_entry = debugfs_create_dir("pi433", NULL);
+
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
 		class_destroy(pi433_class);
@@ -1370,6 +1450,8 @@ static void __exit pi433_exit(void)
 	spi_unregister_driver(&pi433_spi_driver);
 	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
+	debugfs_remove_recursive(dbgfs_root_entry);
+
 }
 module_exit(pi433_exit);
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d60514a840c2..b1a3382f4042 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -24,7 +24,7 @@
 
 /*-------------------------------------------------------------------------*/
 
-static u8 rf69_read_reg(struct spi_device *spi, u8 addr)
+u8 rf69_read_reg(struct spi_device *spi, u8 addr)
 {
 	int retval;
 
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c25942f142a6..3ff5609ecf2e 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -17,6 +17,7 @@
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
+u8 rf69_read_reg(struct spi_device *spi, u8 addr);
 int rf69_get_version(struct spi_device *spi);
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
-- 
2.25.4

