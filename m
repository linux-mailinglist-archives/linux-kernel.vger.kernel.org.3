Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DB4A9FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiBDTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiBDTJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:09:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F00C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:09:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j16so5956331plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1KAlS0foegi6uIMKFRwVhhPIkm2Ca6A2MrpbuqwKCs=;
        b=l4pIsX0WasL7qN0Uw4Yk3KUhsu3PE9g98DI8UK3YlQeYa5rJ+7FCS+c4Ixok4098Gs
         fKt9tz5iKy++kwPAiYFmRwHI1z/f0NBbf5Tsz/NlVn5Q3sYivPMV/Cnz9wQTyJsDnRUl
         mLzycSyMJd1gsx0zcffcCqxudH6JkV8tVS25/OFoC2n02yIJs/z2cCQk7R4+Umttj8CV
         xeACbJDKPraKVv7PftXpoV+7SNzjkPM9QomrD3AglL8Xav+0rMJPzGC6sP0jAe1LPkON
         5nN9iW1vvM+skB5Nv/4R1BtstbjuFxWGK4eD+8B7KbCj2Mb2HpP6g+bcyJZjl0E5PiMC
         X3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1KAlS0foegi6uIMKFRwVhhPIkm2Ca6A2MrpbuqwKCs=;
        b=bRaEGfILFYG1MrylAjyzQ6lcpme4tu2q+/CD2PSSF6vkyupa4iE65TAnchWU4VNCnd
         wLcmqUTHRqmVLzaHO14o/oi9NGV6U3FyCh55Er0SkL/pjOWO7ZMWpzyLeBy7HBj0xY6I
         xe28kSXT+jrhIAo+BeDr7vXG+qqSXT6EUjb3ySybGXkM+by3JknLy2cuhJEbYn5GG4k5
         z4sCo0Dv/VSpF7ZravzBthN9jCJLfhPvCey5juZbLskaOy0tq40O/IvV6F9grEjkzAOM
         hy7czTPeJexfGi72z4T8eow3ZMFuCbTnptjxIiN5Q2DyLVA1BycklDiFiRl/6rsJelCw
         FZeA==
X-Gm-Message-State: AOAM531vCCoeSUNTnPLE2Nv33TIkR5GX+LlPTlLrJwVbopKZmHcnL/Hm
        NV1bf+5qEEhiBjKKvfZZ11I=
X-Google-Smtp-Source: ABdhPJzkOy/7m33XBo0iGT1xKSrggB+oYHFQaj2Jl7TjKrkTwK9CzIaE30AvJbUe8B1z8PfniCvIhQ==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr4696080pjb.109.1644001755853;
        Fri, 04 Feb 2022 11:09:15 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id n4sm7507465pjf.0.2022.02.04.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:09:15 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     insop.song@gainspeed.com, devel@driverdev.osuosl.org,
        dan.carpenter@oracle.com
Subject: [PATCH] staging: drop fpgaboot driver
Date:   Fri,  4 Feb 2022 11:08:35 -0800
Message-Id: <20220204190847.3809405-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yf025dphJw2rUVR5@kroah.com>
References: <Yf025dphJw2rUVR5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gs_fpgaboot driver is totally broken since 2014 and no one even
noticed the driver is not probing. Given the quality of the driver
and its current state it makes sense to drop it.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/Kconfig                   |   2 -
 drivers/staging/Makefile                  |   1 -
 drivers/staging/gs_fpgaboot/Kconfig       |   8 -
 drivers/staging/gs_fpgaboot/Makefile      |   3 -
 drivers/staging/gs_fpgaboot/README        |  70 ----
 drivers/staging/gs_fpgaboot/TODO          |   7 -
 drivers/staging/gs_fpgaboot/gs_fpgaboot.c | 394 ----------------------
 drivers/staging/gs_fpgaboot/gs_fpgaboot.h |  41 ---
 drivers/staging/gs_fpgaboot/io.c          | 105 ------
 drivers/staging/gs_fpgaboot/io.h          |  73 ----
 10 files changed, 704 deletions(-)
 delete mode 100644 drivers/staging/gs_fpgaboot/Kconfig
 delete mode 100644 drivers/staging/gs_fpgaboot/Makefile
 delete mode 100644 drivers/staging/gs_fpgaboot/README
 delete mode 100644 drivers/staging/gs_fpgaboot/TODO
 delete mode 100644 drivers/staging/gs_fpgaboot/gs_fpgaboot.c
 delete mode 100644 drivers/staging/gs_fpgaboot/gs_fpgaboot.h
 delete mode 100644 drivers/staging/gs_fpgaboot/io.c
 delete mode 100644 drivers/staging/gs_fpgaboot/io.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 8d41fdd40657..d1ce500c0319 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -66,8 +66,6 @@ source "drivers/staging/gdm724x/Kconfig"
 
 source "drivers/staging/fwserial/Kconfig"
 
-source "drivers/staging/gs_fpgaboot/Kconfig"
-
 source "drivers/staging/unisys/Kconfig"
 
 source "drivers/staging/clocking-wizard/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 02b01949b94e..82e912a7586f 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_STAGING_BOARD)	+= board/
 obj-$(CONFIG_LTE_GDM724X)	+= gdm724x/
 obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
-obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpgaboot/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
diff --git a/drivers/staging/gs_fpgaboot/Kconfig b/drivers/staging/gs_fpgaboot/Kconfig
deleted file mode 100644
index 968a153c4ab6..000000000000
--- a/drivers/staging/gs_fpgaboot/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# "xilinx FPGA firmware download, fpgaboot"
-#
-config GS_FPGABOOT
-	tristate "Xilinx FPGA firmware download module"
-	help
-	  Xilinx FPGA firmware download module
diff --git a/drivers/staging/gs_fpgaboot/Makefile b/drivers/staging/gs_fpgaboot/Makefile
deleted file mode 100644
index 33e238be63d6..000000000000
--- a/drivers/staging/gs_fpgaboot/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-gs_fpga-y	+= gs_fpgaboot.o io.o
-obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpga.o
diff --git a/drivers/staging/gs_fpgaboot/README b/drivers/staging/gs_fpgaboot/README
deleted file mode 100644
index ec1235a21bcc..000000000000
--- a/drivers/staging/gs_fpgaboot/README
+++ /dev/null
@@ -1,70 +0,0 @@
-==============================================================================
-Linux Driver Source for Xilinx FPGA firmware download
-==============================================================================
-
-
-TABLE OF CONTENTS.
-
-1.  SUMMARY
-2.  BACKGROUND
-3.  DESIGN
-4.  HOW TO USE
-5.  REFERENCE
-
-1. SUMMARY
-
-	- Download Xilinx FPGA firmware
-	- This module downloads Xilinx FPGA firmware using gpio pins.
-
-2. BACKGROUND
-
-	An FPGA (Field Programmable Gate Array) is a programmable hardware that is
-	used in various applications. Hardware design needs to programmed through
-	a dedicated device or CPU assisted way (serial or parallel).
-	This driver provides a way to download FPGA firmware.
-
-3. DESIGN
-
-	- load Xilinx FPGA bitstream format[1] firmware image file using
-	  kernel firmware framework, request_firmware()
-	- program the Xilinx FPGA using SelectMAP (parallel) mode [2]
-	- FPGA prgram is done by gpio based bit-banging, as an example
-	- platform independent file: gs_fpgaboot.c
-	- platform dependent file: io.c
-
-4. HOW TO USE
-
-	$ insmod gs_fpga.ko file="xlinx_fpga_top_bitstream.bit"
-	$ rmmod gs_fpga
-
-5. USE CASE (from a mailing list discussion with Greg)
-
-	a. As an FPGA development support tool,
-	During FPGA firmware development, you need to download a new FPGA
-	image frequently.
-	You would do that with a dedicated JTAG, which usually a limited
-	resource in the lab.
-	However, if you use my driver, you don't have to have a dedicated JTAG.
-	This is a real gain :)
-
-	b. For the FPGA that runs without config after the download, which
-	doesn't talk to any of Linux interfaces (such as PCIE).
-
-	We download FPGA firmware from user triggered or some other way, and that's it.
-	Since that FPGA runs on its own, it doesn't require a linux driver
-	after the download.
-
-	c. For the FPGA that requires config after the download, which talk to
-	any of linux interfaces (such as PCIE)
-
-	Then, this type of FPGA config can be put into device tree and have a
-	separate driver (pcie or others), then THAT driver calls my driver to
-	download FPGA firmware during the Linux boot, the take over the device
-	through the interface.
-
-6. REFERENCE
-
-	1. Xilinx APP NOTE XAPP583:
-	  https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
-	2. bitstream file info:
-	  http://home.earthlink.net/~davesullins/software/bitinfo.html
diff --git a/drivers/staging/gs_fpgaboot/TODO b/drivers/staging/gs_fpgaboot/TODO
deleted file mode 100644
index 2d9fb17d606d..000000000000
--- a/drivers/staging/gs_fpgaboot/TODO
+++ /dev/null
@@ -1,7 +0,0 @@
-TODO:
-	- get bus width input instead of hardcoded bus width
-	- get it reviewed
-
-Please send any patches for this driver to Insop Song<insop.song@gainspeed.com>
-and Greg Kroah-Hartman <gregkh@linuxfoundation.org>.
-And please CC to "Staging subsystem" mail list <devel@driverdev.osuosl.org> too.
diff --git a/drivers/staging/gs_fpgaboot/gs_fpgaboot.c b/drivers/staging/gs_fpgaboot/gs_fpgaboot.c
deleted file mode 100644
index 3e154562c64d..000000000000
--- a/drivers/staging/gs_fpgaboot/gs_fpgaboot.c
+++ /dev/null
@@ -1,394 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/firmware.h>
-#include <asm/unaligned.h>
-
-#include "gs_fpgaboot.h"
-#include "io.h"
-
-#define DEVICE_NAME "device"
-#define CLASS_NAME  "fpgaboot"
-
-static u8 bits_magic[] = {
-	0x0, 0x9, 0xf, 0xf0, 0xf, 0xf0,
-	0xf, 0xf0, 0xf, 0xf0, 0x0, 0x0, 0x1};
-
-/* fake device for request_firmware */
-static struct platform_device	*firmware_pdev;
-
-static char	*file = "xlinx_fpga_firmware.bit";
-module_param(file, charp, 0444);
-MODULE_PARM_DESC(file, "Xilinx FPGA firmware file.");
-
-static void read_bitstream(u8 *bitdata, u8 *buf, int *offset, int rdsize)
-{
-	memcpy(buf, bitdata + *offset, rdsize);
-	*offset += rdsize;
-}
-
-static int readinfo_bitstream(u8 *bitdata, u8 *buf, int size, int *offset)
-{
-	u8 tbuf[2];
-	u16 len;
-
-	/* read section char */
-	read_bitstream(bitdata, tbuf, offset, 1);
-
-	/* read length */
-	read_bitstream(bitdata, tbuf, offset, 2);
-
-	len = get_unaligned_be16(tbuf);
-	if (len >= size) {
-		pr_err("error: readinfo buffer too small\n");
-		return -EINVAL;
-	}
-
-	read_bitstream(bitdata, buf, offset, len);
-	buf[len] = '\0';
-
-	return 0;
-}
-
-/*
- * read bitdata length
- */
-static int readlength_bitstream(u8 *bitdata, int *lendata, int *offset)
-{
-	u8 tbuf[4];
-
-	/* read section char */
-	read_bitstream(bitdata, tbuf, offset, 1);
-
-	/* make sure it is section 'e' */
-	if (tbuf[0] != 'e') {
-		pr_err("error: length section is not 'e', but %c\n", tbuf[0]);
-		return -EINVAL;
-	}
-
-	/* read 4bytes length */
-	read_bitstream(bitdata, tbuf, offset, 4);
-
-	*lendata = get_unaligned_be32(tbuf);
-
-	return 0;
-}
-
-/*
- * read first 13 bytes to check bitstream magic number
- */
-static int readmagic_bitstream(u8 *bitdata, int *offset)
-{
-	u8 buf[13];
-	int r;
-
-	read_bitstream(bitdata, buf, offset, 13);
-	r = memcmp(buf, bits_magic, 13);
-	if (r) {
-		pr_err("error: corrupted header\n");
-		return -EINVAL;
-	}
-	pr_info("bitstream file magic number Ok\n");
-
-	*offset = 13;	/* magic length */
-
-	return 0;
-}
-
-/*
- * NOTE: supports only bitstream format
- */
-static enum fmt_image get_imageformat(void)
-{
-	return f_bit;
-}
-
-static void gs_print_header(struct fpgaimage *fimage)
-{
-	pr_info("file: %s\n", fimage->filename);
-	pr_info("part: %s\n", fimage->part);
-	pr_info("date: %s\n", fimage->date);
-	pr_info("time: %s\n", fimage->time);
-	pr_info("lendata: %d\n", fimage->lendata);
-}
-
-static int gs_read_bitstream(struct fpgaimage *fimage)
-{
-	u8 *bitdata;
-	int offset;
-	int err;
-
-	offset = 0;
-	bitdata = (u8 *)fimage->fw_entry->data;
-
-	err = readmagic_bitstream(bitdata, &offset);
-	if (err)
-		return err;
-
-	err = readinfo_bitstream(bitdata, fimage->filename, MAX_STR, &offset);
-	if (err)
-		return err;
-	err = readinfo_bitstream(bitdata, fimage->part, MAX_STR, &offset);
-	if (err)
-		return err;
-	err = readinfo_bitstream(bitdata, fimage->date, MAX_STR, &offset);
-	if (err)
-		return err;
-	err = readinfo_bitstream(bitdata, fimage->time, MAX_STR, &offset);
-	if (err)
-		return err;
-
-	err = readlength_bitstream(bitdata, &fimage->lendata, &offset);
-	if (err)
-		return err;
-
-	fimage->fpgadata = bitdata + offset;
-
-	return 0;
-}
-
-static int gs_read_image(struct fpgaimage *fimage)
-{
-	int img_fmt;
-	int err;
-
-	img_fmt = get_imageformat();
-
-	switch (img_fmt) {
-	case f_bit:
-		pr_info("image is bitstream format\n");
-		err = gs_read_bitstream(fimage);
-		if (err)
-			return err;
-		break;
-	default:
-		pr_err("unsupported fpga image format\n");
-		return -EINVAL;
-	}
-
-	gs_print_header(fimage);
-
-	return 0;
-}
-
-static int gs_load_image(struct fpgaimage *fimage, char *fw_file)
-{
-	int err;
-
-	pr_info("load fpgaimage %s\n", fw_file);
-
-	err = request_firmware(&fimage->fw_entry, fw_file, &firmware_pdev->dev);
-	if (err != 0) {
-		pr_err("firmware %s is missing, cannot continue.\n", fw_file);
-		return err;
-	}
-
-	return 0;
-}
-
-static int gs_download_image(struct fpgaimage *fimage, enum wbus bus_bytes)
-{
-	u8 *bitdata;
-	int size, i, cnt;
-
-	cnt = 0;
-	bitdata = (u8 *)fimage->fpgadata;
-	size = fimage->lendata;
-
-#ifdef DEBUG_FPGA
-	print_hex_dump_bytes("bitfile sample: ", DUMP_PREFIX_OFFSET,
-			     bitdata, 0x100);
-#endif /* DEBUG_FPGA */
-	if (!xl_supported_prog_bus_width(bus_bytes)) {
-		pr_err("unsupported program bus width %d\n",
-		       bus_bytes);
-		return -EINVAL;
-	}
-
-	/* Bring csi_b, rdwr_b Low and program_b High */
-	xl_program_b(1);
-	xl_rdwr_b(0);
-	xl_csi_b(0);
-
-	/* Configuration reset */
-	xl_program_b(0);
-	msleep(20);
-	xl_program_b(1);
-
-	/* Wait for Device Initialization */
-	while (xl_get_init_b() == 0)
-		;
-
-	pr_info("device init done\n");
-
-	for (i = 0; i < size; i += bus_bytes)
-		xl_shift_bytes_out(bus_bytes, bitdata + i);
-
-	pr_info("program done\n");
-
-	/* Check INIT_B */
-	if (xl_get_init_b() == 0) {
-		pr_err("init_b 0\n");
-		return -EIO;
-	}
-
-	while (xl_get_done_b() == 0) {
-		if (cnt++ > MAX_WAIT_DONE) {
-			pr_err("init_B %d\n", xl_get_init_b());
-			break;
-		}
-	}
-
-	if (cnt > MAX_WAIT_DONE) {
-		pr_err("fpga download fail\n");
-		return -EIO;
-	}
-
-	pr_info("download fpgaimage\n");
-
-	/* Compensate for Special Startup Conditions */
-	xl_shift_cclk(8);
-
-	return 0;
-}
-
-static int gs_release_image(struct fpgaimage *fimage)
-{
-	release_firmware(fimage->fw_entry);
-	pr_info("release fpgaimage\n");
-
-	return 0;
-}
-
-/*
- * NOTE: supports systemmap parallel programming
- */
-static int gs_set_download_method(struct fpgaimage *fimage)
-{
-	pr_info("set program method\n");
-
-	fimage->dmethod = m_systemmap;
-
-	pr_info("systemmap program method\n");
-
-	return 0;
-}
-
-static int init_driver(void)
-{
-	firmware_pdev = platform_device_register_simple("fpgaboot", -1,
-							NULL, 0);
-	return PTR_ERR_OR_ZERO(firmware_pdev);
-}
-
-static int gs_fpgaboot(void)
-{
-	int err;
-	struct fpgaimage	*fimage;
-
-	fimage = kmalloc(sizeof(*fimage), GFP_KERNEL);
-	if (!fimage)
-		return -ENOMEM;
-
-	err = gs_load_image(fimage, file);
-	if (err) {
-		pr_err("gs_load_image error\n");
-		goto err_out1;
-	}
-
-	err = gs_read_image(fimage);
-	if (err) {
-		pr_err("gs_read_image error\n");
-		goto err_out2;
-	}
-
-	err = gs_set_download_method(fimage);
-	if (err) {
-		pr_err("gs_set_download_method error\n");
-		goto err_out2;
-	}
-
-	err = gs_download_image(fimage, bus_2byte);
-	if (err) {
-		pr_err("gs_download_image error\n");
-		goto err_out2;
-	}
-
-	err = gs_release_image(fimage);
-	if (err) {
-		pr_err("gs_release_image error\n");
-		goto err_out1;
-	}
-
-	kfree(fimage);
-	return 0;
-
-err_out2:
-	err = gs_release_image(fimage);
-	if (err)
-		pr_err("gs_release_image error\n");
-err_out1:
-	kfree(fimage);
-
-	return err;
-}
-
-static int __init gs_fpgaboot_init(void)
-{
-	int err;
-
-	pr_info("FPGA DOWNLOAD --->\n");
-
-	pr_info("FPGA image file name: %s\n", file);
-
-	err = init_driver();
-	if (err) {
-		pr_err("FPGA DRIVER INIT FAIL!!\n");
-		return err;
-	}
-
-	err = xl_init_io();
-	if (err) {
-		pr_err("GPIO INIT FAIL!!\n");
-		goto errout;
-	}
-
-	err = gs_fpgaboot();
-	if (err) {
-		pr_err("FPGA DOWNLOAD FAIL!!\n");
-		goto errout;
-	}
-
-	pr_info("FPGA DOWNLOAD DONE <---\n");
-
-	return 0;
-
-errout:
-	platform_device_unregister(firmware_pdev);
-
-	return err;
-}
-
-static void __exit gs_fpgaboot_exit(void)
-{
-	platform_device_unregister(firmware_pdev);
-	pr_info("FPGA image download module removed\n");
-}
-
-module_init(gs_fpgaboot_init);
-module_exit(gs_fpgaboot_exit);
-
-MODULE_AUTHOR("Insop Song");
-MODULE_DESCRIPTION("Xlinix FPGA firmware download");
-MODULE_LICENSE("GPL");
diff --git a/drivers/staging/gs_fpgaboot/gs_fpgaboot.h b/drivers/staging/gs_fpgaboot/gs_fpgaboot.h
deleted file mode 100644
index 5cf12c14cca4..000000000000
--- a/drivers/staging/gs_fpgaboot/gs_fpgaboot.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#include <linux/firmware.h>
-
-#define	MAX_STR	256
-
-enum fmt_image {
-	f_bit,	/* only bitstream is supported */
-	f_rbt,
-	f_bin,
-	f_mcs,
-	f_hex,
-};
-
-enum mdownload {
-	m_systemmap,	/* only system map is supported */
-	m_serial,
-	m_jtag,
-};
-
-/*
- * xilinx fpgaimage information
- * NOTE: use MAX_STR instead of dynamic alloc for simplicity
- */
-struct fpgaimage {
-	enum fmt_image	fmt_img;
-	enum mdownload	dmethod;
-
-	const struct	firmware	*fw_entry;
-
-	/*
-	 * the following can be read from bitstream,
-	 * but other image format should have as well
-	 */
-	char	filename[MAX_STR];
-	char	part[MAX_STR];
-	char	date[MAX_STR];
-	char	time[MAX_STR];
-	int	lendata;
-	u8	*fpgadata;
-};
diff --git a/drivers/staging/gs_fpgaboot/io.c b/drivers/staging/gs_fpgaboot/io.c
deleted file mode 100644
index 80903ec36b76..000000000000
--- a/drivers/staging/gs_fpgaboot/io.c
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/firmware.h>
-#include <linux/io.h>
-
-#include "io.h"
-
-static inline void byte0_out(unsigned char data);
-static inline void byte1_out(unsigned char data);
-static inline void xl_cclk_b(int32_t i);
-
-/* Assert and Deassert CCLK */
-void xl_shift_cclk(int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++) {
-		xl_cclk_b(1);
-		xl_cclk_b(0);
-	}
-}
-
-int xl_supported_prog_bus_width(enum wbus bus_bytes)
-{
-	switch (bus_bytes) {
-	case bus_1byte:
-		break;
-	case bus_2byte:
-		break;
-	default:
-		pr_err("unsupported program bus width %d\n", bus_bytes);
-		return 0;
-	}
-
-	return 1;
-}
-
-/* Serialize byte and clock each bit on target's DIN and CCLK pins */
-void xl_shift_bytes_out(enum wbus bus_byte, unsigned char *pdata)
-{
-	/*
-	 * supports 1 and 2 bytes programming mode
-	 */
-	if (likely(bus_byte == bus_2byte))
-		byte0_out(pdata[0]);
-
-	byte1_out(pdata[1]);
-	xl_shift_cclk(1);
-}
-
-/*
- * generic bit swap for xilinx SYSTEMMAP FPGA programming
- */
-void xl_program_b(int32_t i)
-{
-}
-
-void xl_rdwr_b(int32_t i)
-{
-}
-
-void xl_csi_b(int32_t i)
-{
-}
-
-int xl_get_init_b(void)
-{
-	return -1;
-}
-
-int xl_get_done_b(void)
-{
-	return -1;
-}
-
-static inline void byte0_out(unsigned char data)
-{
-}
-
-static inline void byte1_out(unsigned char data)
-{
-}
-
-static inline void xl_cclk_b(int32_t i)
-{
-}
-
-/*
- * configurable per device type for different I/O config
- */
-int xl_init_io(void)
-{
-	return -1;
-}
diff --git a/drivers/staging/gs_fpgaboot/io.h b/drivers/staging/gs_fpgaboot/io.h
deleted file mode 100644
index 9bd86a92e90f..000000000000
--- a/drivers/staging/gs_fpgaboot/io.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#define GPDIR	0
-#define GPCFG	4	/* open drain or not */
-#define GPDAT	8
-
-/*
- * gpio port and pin definitions
- * NOTE: port number starts from 0
- */
-#define	XL_INITN_PORT	1
-#define	XL_INITN_PIN	14
-#define	XL_RDWRN_PORT	1
-#define	XL_RDWRN_PIN	13
-#define	XL_CCLK_PORT	1
-#define	XL_CCLK_PIN	10
-#define	XL_PROGN_PORT	1
-#define	XL_PROGN_PIN	25
-#define	XL_CSIN_PORT	1
-#define	XL_CSIN_PIN	26
-#define	XL_DONE_PORT	1
-#define	XL_DONE_PIN	27
-
-/*
- * gpio mapping
- *
-	XL_config_D0 – gpio1_31
-	Xl_config_d1 – gpio1_30
-	Xl_config_d2 – gpio1_29
-	Xl_config_d3 – gpio1_28
-	Xl_config_d4 – gpio1_27
-	Xl_config_d5 – gpio1_26
-	Xl_config_d6 – gpio1_25
-	Xl_config_d7 – gpio1_24
-	Xl_config_d8 – gpio1_23
-	Xl_config_d9 – gpio1_22
-	Xl_config_d10 – gpio1_21
-	Xl_config_d11 – gpio1_20
-	Xl_config_d12 – gpio1_19
-	Xl_config_d13 – gpio1_18
-	Xl_config_d14 – gpio1_16
-	Xl_config_d15 – gpio1_14
-*
-*/
-
-/*
- * program bus width in bytes
- */
-enum wbus {
-	bus_1byte	= 1,
-	bus_2byte	= 2,
-};
-
-#define MAX_WAIT_DONE	10000
-
-struct gpiobus {
-	int	ngpio;
-	void __iomem *r[4];
-};
-
-int xl_supported_prog_bus_width(enum wbus bus_bytes);
-
-void xl_program_b(int32_t i);
-void xl_rdwr_b(int32_t i);
-void xl_csi_b(int32_t i);
-
-int xl_get_init_b(void);
-int xl_get_done_b(void);
-
-void xl_shift_cclk(int count);
-void xl_shift_bytes_out(enum wbus bus_byte, unsigned char *pdata);
-
-int xl_init_io(void);
-- 
2.25.1

