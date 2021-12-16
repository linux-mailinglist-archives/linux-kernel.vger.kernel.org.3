Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEF4768BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhLPDdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:33:07 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43614 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233379AbhLPDdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:33:06 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvNxts7phuEwBAA--.5634S4;
        Thu, 16 Dec 2021 11:33:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rapidio: remove not used code about RIO_VID_TUNDRA
Date:   Thu, 16 Dec 2021 11:33:01 +0800
Message-Id: <1639625581-22867-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639625581-22867-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639625581-22867-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvNxts7phuEwBAA--.5634S4
X-Coremail-Antispam: 1UD129KBjvAXoW3uF13Aw13ur1kAryrXF4fZrb_yoW8CF1xuo
        WfXw43W3WrWw1xWr4DKrsIqrW3ZFWvyFsxJa15CrZxuasrJFy5XFy7Wana9w15Xr1rKFyr
        ZryfCa9xKa1fJr1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYW7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkaFADUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to https://rapidio.org/vendor-id/, there is no 0x000d vendor id
in the complete and current list of VendorIDs, it means that the related
code is dead code now, so just remove them.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/rapidio/switches/Kconfig  |  11 --
 drivers/rapidio/switches/Makefile |   2 -
 drivers/rapidio/switches/tsi568.c | 195 --------------------
 drivers/rapidio/switches/tsi57x.c | 365 --------------------------------------
 include/linux/rio_ids.h           |   7 -
 5 files changed, 580 deletions(-)
 delete mode 100644 drivers/rapidio/switches/tsi568.c
 delete mode 100644 drivers/rapidio/switches/tsi57x.c

diff --git a/drivers/rapidio/switches/Kconfig b/drivers/rapidio/switches/Kconfig
index 3e18f9c..02771ba 100644
--- a/drivers/rapidio/switches/Kconfig
+++ b/drivers/rapidio/switches/Kconfig
@@ -2,22 +2,11 @@
 #
 # RapidIO switches configuration
 #
-config RAPIDIO_TSI57X
-	tristate "IDT Tsi57x SRIO switches support"
-	help
-	  Includes support for IDT Tsi57x family of serial RapidIO switches.
-
 config RAPIDIO_CPS_XX
 	tristate "IDT CPS-xx SRIO switches support"
 	help
 	  Includes support for IDT CPS-16/12/10/8 serial RapidIO switches.
 
-config RAPIDIO_TSI568
-	tristate "Tsi568 SRIO switch support"
-	default n
-	help
-	  Includes support for IDT Tsi568 serial RapidIO switch.
-
 config RAPIDIO_CPS_GEN2
 	tristate "IDT CPS Gen.2 SRIO switch support"
 	default n
diff --git a/drivers/rapidio/switches/Makefile b/drivers/rapidio/switches/Makefile
index 69e7de3..ef1749a 100644
--- a/drivers/rapidio/switches/Makefile
+++ b/drivers/rapidio/switches/Makefile
@@ -3,8 +3,6 @@
 # Makefile for RIO switches
 #
 
-obj-$(CONFIG_RAPIDIO_TSI57X)	+= tsi57x.o
 obj-$(CONFIG_RAPIDIO_CPS_XX)	+= idtcps.o
-obj-$(CONFIG_RAPIDIO_TSI568)	+= tsi568.o
 obj-$(CONFIG_RAPIDIO_CPS_GEN2)	+= idt_gen2.o
 obj-$(CONFIG_RAPIDIO_RXS_GEN3)	+= idt_gen3.o
diff --git a/drivers/rapidio/switches/tsi568.c b/drivers/rapidio/switches/tsi568.c
deleted file mode 100644
index 103b48a..0000000
--- a/drivers/rapidio/switches/tsi568.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RapidIO Tsi568 switch support
- *
- * Copyright 2009-2010 Integrated Device Technology, Inc.
- * Alexandre Bounine <alexandre.bounine@idt.com>
- *  - Added EM support
- *  - Modified switch operations initialization.
- *
- * Copyright 2005 MontaVista Software, Inc.
- * Matt Porter <mporter@kernel.crashing.org>
- */
-
-#include <linux/rio.h>
-#include <linux/rio_drv.h>
-#include <linux/rio_ids.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include "../rio.h"
-
-/* Global (broadcast) route registers */
-#define SPBC_ROUTE_CFG_DESTID	0x10070
-#define SPBC_ROUTE_CFG_PORT	0x10074
-
-/* Per port route registers */
-#define SPP_ROUTE_CFG_DESTID(n)	(0x11070 + 0x100*n)
-#define SPP_ROUTE_CFG_PORT(n)	(0x11074 + 0x100*n)
-
-#define TSI568_SP_MODE(n)	(0x11004 + 0x100*n)
-#define  TSI568_SP_MODE_PW_DIS	0x08000000
-
-static int
-tsi568_route_add_entry(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table, u16 route_destid, u8 route_port)
-{
-	if (table == RIO_GLOBAL_TABLE) {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPBC_ROUTE_CFG_DESTID, route_destid);
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPBC_ROUTE_CFG_PORT, route_port);
-	} else {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPP_ROUTE_CFG_DESTID(table),
-					route_destid);
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPP_ROUTE_CFG_PORT(table), route_port);
-	}
-
-	udelay(10);
-
-	return 0;
-}
-
-static int
-tsi568_route_get_entry(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table, u16 route_destid, u8 *route_port)
-{
-	int ret = 0;
-	u32 result;
-
-	if (table == RIO_GLOBAL_TABLE) {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPBC_ROUTE_CFG_DESTID, route_destid);
-		rio_mport_read_config_32(mport, destid, hopcount,
-					SPBC_ROUTE_CFG_PORT, &result);
-	} else {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPP_ROUTE_CFG_DESTID(table),
-					route_destid);
-		rio_mport_read_config_32(mport, destid, hopcount,
-					SPP_ROUTE_CFG_PORT(table), &result);
-	}
-
-	*route_port = result;
-	if (*route_port > 15)
-		ret = -1;
-
-	return ret;
-}
-
-static int
-tsi568_route_clr_table(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table)
-{
-	u32 route_idx;
-	u32 lut_size;
-
-	lut_size = (mport->sys_size) ? 0x1ff : 0xff;
-
-	if (table == RIO_GLOBAL_TABLE) {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPBC_ROUTE_CFG_DESTID, 0x80000000);
-		for (route_idx = 0; route_idx <= lut_size; route_idx++)
-			rio_mport_write_config_32(mport, destid, hopcount,
-						SPBC_ROUTE_CFG_PORT,
-						RIO_INVALID_ROUTE);
-	} else {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					SPP_ROUTE_CFG_DESTID(table),
-					0x80000000);
-		for (route_idx = 0; route_idx <= lut_size; route_idx++)
-			rio_mport_write_config_32(mport, destid, hopcount,
-						SPP_ROUTE_CFG_PORT(table),
-						RIO_INVALID_ROUTE);
-	}
-
-	return 0;
-}
-
-static int
-tsi568_em_init(struct rio_dev *rdev)
-{
-	u32 regval;
-	int portnum;
-
-	pr_debug("TSI568 %s [%d:%d]\n", __func__, rdev->destid, rdev->hopcount);
-
-	/* Make sure that Port-Writes are disabled (for all ports) */
-	for (portnum = 0;
-	     portnum < RIO_GET_TOTAL_PORTS(rdev->swpinfo); portnum++) {
-		rio_read_config_32(rdev, TSI568_SP_MODE(portnum), &regval);
-		rio_write_config_32(rdev, TSI568_SP_MODE(portnum),
-				    regval | TSI568_SP_MODE_PW_DIS);
-	}
-
-	return 0;
-}
-
-static struct rio_switch_ops tsi568_switch_ops = {
-	.owner = THIS_MODULE,
-	.add_entry = tsi568_route_add_entry,
-	.get_entry = tsi568_route_get_entry,
-	.clr_table = tsi568_route_clr_table,
-	.set_domain = NULL,
-	.get_domain = NULL,
-	.em_init = tsi568_em_init,
-	.em_handle = NULL,
-};
-
-static int tsi568_probe(struct rio_dev *rdev, const struct rio_device_id *id)
-{
-	pr_debug("RIO: %s for %s\n", __func__, rio_name(rdev));
-
-	spin_lock(&rdev->rswitch->lock);
-
-	if (rdev->rswitch->ops) {
-		spin_unlock(&rdev->rswitch->lock);
-		return -EINVAL;
-	}
-
-	rdev->rswitch->ops = &tsi568_switch_ops;
-	spin_unlock(&rdev->rswitch->lock);
-	return 0;
-}
-
-static void tsi568_remove(struct rio_dev *rdev)
-{
-	pr_debug("RIO: %s for %s\n", __func__, rio_name(rdev));
-	spin_lock(&rdev->rswitch->lock);
-	if (rdev->rswitch->ops != &tsi568_switch_ops) {
-		spin_unlock(&rdev->rswitch->lock);
-		return;
-	}
-	rdev->rswitch->ops = NULL;
-	spin_unlock(&rdev->rswitch->lock);
-}
-
-static const struct rio_device_id tsi568_id_table[] = {
-	{RIO_DEVICE(RIO_DID_TSI568, RIO_VID_TUNDRA)},
-	{ 0, }	/* terminate list */
-};
-
-static struct rio_driver tsi568_driver = {
-	.name = "tsi568",
-	.id_table = tsi568_id_table,
-	.probe = tsi568_probe,
-	.remove = tsi568_remove,
-};
-
-static int __init tsi568_init(void)
-{
-	return rio_register_driver(&tsi568_driver);
-}
-
-static void __exit tsi568_exit(void)
-{
-	rio_unregister_driver(&tsi568_driver);
-}
-
-device_initcall(tsi568_init);
-module_exit(tsi568_exit);
-
-MODULE_DESCRIPTION("IDT Tsi568 Serial RapidIO switch driver");
-MODULE_AUTHOR("Integrated Device Technology, Inc.");
-MODULE_LICENSE("GPL");
diff --git a/drivers/rapidio/switches/tsi57x.c b/drivers/rapidio/switches/tsi57x.c
deleted file mode 100644
index 2717620..0000000
--- a/drivers/rapidio/switches/tsi57x.c
+++ /dev/null
@@ -1,365 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RapidIO Tsi57x switch family support
- *
- * Copyright 2009-2010 Integrated Device Technology, Inc.
- * Alexandre Bounine <alexandre.bounine@idt.com>
- *  - Added EM support
- *  - Modified switch operations initialization.
- *
- * Copyright 2005 MontaVista Software, Inc.
- * Matt Porter <mporter@kernel.crashing.org>
- */
-
-#include <linux/rio.h>
-#include <linux/rio_drv.h>
-#include <linux/rio_ids.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include "../rio.h"
-
-/* Global (broadcast) route registers */
-#define SPBC_ROUTE_CFG_DESTID	0x10070
-#define SPBC_ROUTE_CFG_PORT	0x10074
-
-/* Per port route registers */
-#define SPP_ROUTE_CFG_DESTID(n)	(0x11070 + 0x100*n)
-#define SPP_ROUTE_CFG_PORT(n)	(0x11074 + 0x100*n)
-
-#define TSI578_SP_MODE(n)	(0x11004 + n*0x100)
-#define TSI578_SP_MODE_GLBL	0x10004
-#define  TSI578_SP_MODE_PW_DIS	0x08000000
-#define  TSI578_SP_MODE_LUT_512	0x01000000
-
-#define TSI578_SP_CTL_INDEP(n)	(0x13004 + n*0x100)
-#define TSI578_SP_LUT_PEINF(n)	(0x13010 + n*0x100)
-#define TSI578_SP_CS_TX(n)	(0x13014 + n*0x100)
-#define TSI578_SP_INT_STATUS(n) (0x13018 + n*0x100)
-
-#define TSI578_GLBL_ROUTE_BASE	0x10078
-
-static int
-tsi57x_route_add_entry(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table, u16 route_destid, u8 route_port)
-{
-	if (table == RIO_GLOBAL_TABLE) {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					  SPBC_ROUTE_CFG_DESTID, route_destid);
-		rio_mport_write_config_32(mport, destid, hopcount,
-					  SPBC_ROUTE_CFG_PORT, route_port);
-	} else {
-		rio_mport_write_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_DESTID(table), route_destid);
-		rio_mport_write_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_PORT(table), route_port);
-	}
-
-	udelay(10);
-
-	return 0;
-}
-
-static int
-tsi57x_route_get_entry(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table, u16 route_destid, u8 *route_port)
-{
-	int ret = 0;
-	u32 result;
-
-	if (table == RIO_GLOBAL_TABLE) {
-		/* Use local RT of the ingress port to avoid possible
-		   race condition */
-		rio_mport_read_config_32(mport, destid, hopcount,
-			RIO_SWP_INFO_CAR, &result);
-		table = (result & RIO_SWP_INFO_PORT_NUM_MASK);
-	}
-
-	rio_mport_write_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_DESTID(table), route_destid);
-	rio_mport_read_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_PORT(table), &result);
-
-	*route_port = (u8)result;
-	if (*route_port > 15)
-		ret = -1;
-
-	return ret;
-}
-
-static int
-tsi57x_route_clr_table(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u16 table)
-{
-	u32 route_idx;
-	u32 lut_size;
-
-	lut_size = (mport->sys_size) ? 0x1ff : 0xff;
-
-	if (table == RIO_GLOBAL_TABLE) {
-		rio_mport_write_config_32(mport, destid, hopcount,
-					  SPBC_ROUTE_CFG_DESTID, 0x80000000);
-		for (route_idx = 0; route_idx <= lut_size; route_idx++)
-			rio_mport_write_config_32(mport, destid, hopcount,
-						  SPBC_ROUTE_CFG_PORT,
-						  RIO_INVALID_ROUTE);
-	} else {
-		rio_mport_write_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_DESTID(table), 0x80000000);
-		for (route_idx = 0; route_idx <= lut_size; route_idx++)
-			rio_mport_write_config_32(mport, destid, hopcount,
-				SPP_ROUTE_CFG_PORT(table) , RIO_INVALID_ROUTE);
-	}
-
-	return 0;
-}
-
-static int
-tsi57x_set_domain(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u8 sw_domain)
-{
-	u32 regval;
-
-	/*
-	 * Switch domain configuration operates only at global level
-	 */
-
-	/* Turn off flat (LUT_512) mode */
-	rio_mport_read_config_32(mport, destid, hopcount,
-				 TSI578_SP_MODE_GLBL, &regval);
-	rio_mport_write_config_32(mport, destid, hopcount, TSI578_SP_MODE_GLBL,
-				  regval & ~TSI578_SP_MODE_LUT_512);
-	/* Set switch domain base */
-	rio_mport_write_config_32(mport, destid, hopcount,
-				  TSI578_GLBL_ROUTE_BASE,
-				  (u32)(sw_domain << 24));
-	return 0;
-}
-
-static int
-tsi57x_get_domain(struct rio_mport *mport, u16 destid, u8 hopcount,
-		       u8 *sw_domain)
-{
-	u32 regval;
-
-	/*
-	 * Switch domain configuration operates only at global level
-	 */
-	rio_mport_read_config_32(mport, destid, hopcount,
-				TSI578_GLBL_ROUTE_BASE, &regval);
-
-	*sw_domain = (u8)(regval >> 24);
-
-	return 0;
-}
-
-static int
-tsi57x_em_init(struct rio_dev *rdev)
-{
-	u32 regval;
-	int portnum;
-
-	pr_debug("TSI578 %s [%d:%d]\n", __func__, rdev->destid, rdev->hopcount);
-
-	for (portnum = 0;
-	     portnum < RIO_GET_TOTAL_PORTS(rdev->swpinfo); portnum++) {
-		/* Make sure that Port-Writes are enabled (for all ports) */
-		rio_read_config_32(rdev,
-				TSI578_SP_MODE(portnum), &regval);
-		rio_write_config_32(rdev,
-				TSI578_SP_MODE(portnum),
-				regval & ~TSI578_SP_MODE_PW_DIS);
-
-		/* Clear all pending interrupts */
-		rio_read_config_32(rdev,
-				RIO_DEV_PORT_N_ERR_STS_CSR(rdev, portnum),
-				&regval);
-		rio_write_config_32(rdev,
-				RIO_DEV_PORT_N_ERR_STS_CSR(rdev, portnum),
-				regval & 0x07120214);
-
-		rio_read_config_32(rdev,
-				TSI578_SP_INT_STATUS(portnum), &regval);
-		rio_write_config_32(rdev,
-				TSI578_SP_INT_STATUS(portnum),
-				regval & 0x000700bd);
-
-		/* Enable all interrupts to allow ports to send a port-write */
-		rio_read_config_32(rdev,
-				TSI578_SP_CTL_INDEP(portnum), &regval);
-		rio_write_config_32(rdev,
-				TSI578_SP_CTL_INDEP(portnum),
-				regval | 0x000b0000);
-
-		/* Skip next (odd) port if the current port is in x4 mode */
-		rio_read_config_32(rdev,
-				RIO_DEV_PORT_N_CTL_CSR(rdev, portnum),
-				&regval);
-		if ((regval & RIO_PORT_N_CTL_PWIDTH) == RIO_PORT_N_CTL_PWIDTH_4)
-			portnum++;
-	}
-
-	/* set TVAL = ~50us */
-	rio_write_config_32(rdev,
-		rdev->phys_efptr + RIO_PORT_LINKTO_CTL_CSR, 0x9a << 8);
-
-	return 0;
-}
-
-static int
-tsi57x_em_handler(struct rio_dev *rdev, u8 portnum)
-{
-	struct rio_mport *mport = rdev->net->hport;
-	u32 intstat, err_status;
-	int sendcount, checkcount;
-	u8 route_port;
-	u32 regval;
-
-	rio_read_config_32(rdev,
-			RIO_DEV_PORT_N_ERR_STS_CSR(rdev, portnum),
-			&err_status);
-
-	if ((err_status & RIO_PORT_N_ERR_STS_PORT_OK) &&
-	    (err_status & (RIO_PORT_N_ERR_STS_OUT_ES |
-			  RIO_PORT_N_ERR_STS_INP_ES))) {
-		/* Remove any queued packets by locking/unlocking port */
-		rio_read_config_32(rdev,
-			RIO_DEV_PORT_N_CTL_CSR(rdev, portnum),
-			&regval);
-		if (!(regval & RIO_PORT_N_CTL_LOCKOUT)) {
-			rio_write_config_32(rdev,
-				RIO_DEV_PORT_N_CTL_CSR(rdev, portnum),
-				regval | RIO_PORT_N_CTL_LOCKOUT);
-			udelay(50);
-			rio_write_config_32(rdev,
-				RIO_DEV_PORT_N_CTL_CSR(rdev, portnum),
-				regval);
-		}
-
-		/* Read from link maintenance response register to clear
-		 * valid bit
-		 */
-		rio_read_config_32(rdev,
-			RIO_DEV_PORT_N_MNT_RSP_CSR(rdev, portnum),
-			&regval);
-
-		/* Send a Packet-Not-Accepted/Link-Request-Input-Status control
-		 * symbol to recover from IES/OES
-		 */
-		sendcount = 3;
-		while (sendcount) {
-			rio_write_config_32(rdev,
-					  TSI578_SP_CS_TX(portnum), 0x40fc8000);
-			checkcount = 3;
-			while (checkcount--) {
-				udelay(50);
-				rio_read_config_32(rdev,
-					RIO_DEV_PORT_N_MNT_RSP_CSR(rdev,
-								   portnum),
-					&regval);
-				if (regval & RIO_PORT_N_MNT_RSP_RVAL)
-					goto exit_es;
-			}
-
-			sendcount--;
-		}
-	}
-
-exit_es:
-	/* Clear implementation specific error status bits */
-	rio_read_config_32(rdev, TSI578_SP_INT_STATUS(portnum), &intstat);
-	pr_debug("TSI578[%x:%x] SP%d_INT_STATUS=0x%08x\n",
-		 rdev->destid, rdev->hopcount, portnum, intstat);
-
-	if (intstat & 0x10000) {
-		rio_read_config_32(rdev,
-				TSI578_SP_LUT_PEINF(portnum), &regval);
-		regval = (mport->sys_size) ? (regval >> 16) : (regval >> 24);
-		route_port = rdev->rswitch->route_table[regval];
-		pr_debug("RIO: TSI578[%s] P%d LUT Parity Error (destID=%d)\n",
-			rio_name(rdev), portnum, regval);
-		tsi57x_route_add_entry(mport, rdev->destid, rdev->hopcount,
-				RIO_GLOBAL_TABLE, regval, route_port);
-	}
-
-	rio_write_config_32(rdev, TSI578_SP_INT_STATUS(portnum),
-			    intstat & 0x000700bd);
-
-	return 0;
-}
-
-static struct rio_switch_ops tsi57x_switch_ops = {
-	.owner = THIS_MODULE,
-	.add_entry = tsi57x_route_add_entry,
-	.get_entry = tsi57x_route_get_entry,
-	.clr_table = tsi57x_route_clr_table,
-	.set_domain = tsi57x_set_domain,
-	.get_domain = tsi57x_get_domain,
-	.em_init = tsi57x_em_init,
-	.em_handle = tsi57x_em_handler,
-};
-
-static int tsi57x_probe(struct rio_dev *rdev, const struct rio_device_id *id)
-{
-	pr_debug("RIO: %s for %s\n", __func__, rio_name(rdev));
-
-	spin_lock(&rdev->rswitch->lock);
-
-	if (rdev->rswitch->ops) {
-		spin_unlock(&rdev->rswitch->lock);
-		return -EINVAL;
-	}
-	rdev->rswitch->ops = &tsi57x_switch_ops;
-
-	if (rdev->do_enum) {
-		/* Ensure that default routing is disabled on startup */
-		rio_write_config_32(rdev, RIO_STD_RTE_DEFAULT_PORT,
-				    RIO_INVALID_ROUTE);
-	}
-
-	spin_unlock(&rdev->rswitch->lock);
-	return 0;
-}
-
-static void tsi57x_remove(struct rio_dev *rdev)
-{
-	pr_debug("RIO: %s for %s\n", __func__, rio_name(rdev));
-	spin_lock(&rdev->rswitch->lock);
-	if (rdev->rswitch->ops != &tsi57x_switch_ops) {
-		spin_unlock(&rdev->rswitch->lock);
-		return;
-	}
-	rdev->rswitch->ops = NULL;
-	spin_unlock(&rdev->rswitch->lock);
-}
-
-static const struct rio_device_id tsi57x_id_table[] = {
-	{RIO_DEVICE(RIO_DID_TSI572, RIO_VID_TUNDRA)},
-	{RIO_DEVICE(RIO_DID_TSI574, RIO_VID_TUNDRA)},
-	{RIO_DEVICE(RIO_DID_TSI577, RIO_VID_TUNDRA)},
-	{RIO_DEVICE(RIO_DID_TSI578, RIO_VID_TUNDRA)},
-	{ 0, }	/* terminate list */
-};
-
-static struct rio_driver tsi57x_driver = {
-	.name = "tsi57x",
-	.id_table = tsi57x_id_table,
-	.probe = tsi57x_probe,
-	.remove = tsi57x_remove,
-};
-
-static int __init tsi57x_init(void)
-{
-	return rio_register_driver(&tsi57x_driver);
-}
-
-static void __exit tsi57x_exit(void)
-{
-	rio_unregister_driver(&tsi57x_driver);
-}
-
-device_initcall(tsi57x_init);
-module_exit(tsi57x_exit);
-
-MODULE_DESCRIPTION("IDT Tsi57x Serial RapidIO switch family driver");
-MODULE_AUTHOR("Integrated Device Technology, Inc.");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/rio_ids.h b/include/linux/rio_ids.h
index e74d884..c7e2f21 100644
--- a/include/linux/rio_ids.h
+++ b/include/linux/rio_ids.h
@@ -9,13 +9,6 @@
 #ifndef LINUX_RIO_IDS_H
 #define LINUX_RIO_IDS_H
 
-#define RIO_VID_TUNDRA			0x000d
-#define RIO_DID_TSI568			0x0568
-#define RIO_DID_TSI572			0x0572
-#define RIO_DID_TSI574			0x0574
-#define RIO_DID_TSI577			0x0577
-#define RIO_DID_TSI578			0x0578
-
 #define RIO_VID_IDT			0x0038
 #define RIO_DID_IDT70K200		0x0310
 #define RIO_DID_IDTCPS8			0x035c
-- 
2.1.0

