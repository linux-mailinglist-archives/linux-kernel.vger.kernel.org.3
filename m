Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9890536D63
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiE1O7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiE1O7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:59:37 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366BBE2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:59:34 -0700 (PDT)
Received: from pop-os.home ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uxucnzi3ok3ICuxucniOfF; Sat, 28 May 2022 16:59:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 28 May 2022 16:59:32 +0200
X-ME-IP: 90.11.191.102
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tglx@linutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] USB: Follow-up to SPDX identifiers addition - remove now useless comments
Date:   Sat, 28 May 2022 16:59:17 +0200
Message-Id: <0266c8467148794219b69b7bf8a8dd968a89ad24.1653749875.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these files have been updated in the commit given in the Fixes: tag
below.

When the SPDX-License-Identifier: has been added, the corresponding text at
the beginning of the files has not been deleted.
All these texts are about GPL-2.0, with different variation in the wording.

Remove these now useless lines to save some LoC.

Fixes: 5fd54ace4721 ("USB: add SPDX identifiers to all remaining files in drivers/usb/")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/usb/audio-v2.h      |  3 ---
 include/linux/usb/audio.h         |  3 ---
 include/linux/usb/cdc-wdm.h       |  4 ----
 include/linux/usb/cdc.h           |  4 ----
 include/linux/usb/gadget.h        |  2 --
 include/linux/usb/input.h         |  4 ----
 include/linux/usb/isp1301.h       | 10 ----------
 include/linux/usb/m66592.h        | 14 --------------
 include/linux/usb/of.h            |  2 --
 include/linux/usb/r8a66597.h      | 14 --------------
 include/linux/usb/serial.h        |  5 -----
 include/linux/usb/storage.h       |  2 --
 include/linux/usb/tegra_usb_phy.h | 10 ----------
 include/linux/usb/ulpi.h          |  4 ----
 include/linux/usb/xhci-dbgp.h     |  4 ----
 15 files changed, 85 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 8fc2abd7aecb..ca796dc1a984 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -2,9 +2,6 @@
 /*
  * Copyright (c) 2010 Daniel Mack <daniel@caiaq.de>
  *
- * This software is distributed under the terms of the GNU General Public
- * License ("GPL") version 2, as published by the Free Software Foundation.
- *
  * This file holds USB constants and structures defined
  * by the USB Device Class Definition for Audio Devices in version 2.0.
  * Comments below reference relevant sections of the documents contained
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 170acd500ea1..0747b24a1a7c 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -6,9 +6,6 @@
  * Developed for Thumtronics by Grey Innovation
  * Ben Williamson <ben.williamson@greyinnovation.com>
  *
- * This software is distributed under the terms of the GNU General Public
- * License ("GPL") version 2, as published by the Free Software Foundation.
- *
  * This file holds USB constants and structures defined
  * by the USB Device Class Definition for Audio Devices.
  * Comments below reference relevant sections of that document:
diff --git a/include/linux/usb/cdc-wdm.h b/include/linux/usb/cdc-wdm.h
index 9f5a51f79ba5..85417f00a89a 100644
--- a/include/linux/usb/cdc-wdm.h
+++ b/include/linux/usb/cdc-wdm.h
@@ -3,10 +3,6 @@
  * USB CDC Device Management subdriver
  *
  * Copyright (c) 2012  Bjørn Mork <bjorn@mork.no>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_USB_CDC_WDM_H
diff --git a/include/linux/usb/cdc.h b/include/linux/usb/cdc.h
index 35d784cf32a4..0af0db51bc89 100644
--- a/include/linux/usb/cdc.h
+++ b/include/linux/usb/cdc.h
@@ -3,10 +3,6 @@
  * USB CDC common helpers
  *
  * Copyright (c) 2015 Oliver Neukum <oneukum@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
  */
 #ifndef __LINUX_USB_CDC_H
 #define __LINUX_USB_CDC_H
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 3ad58b7a0824..dc3092cea99e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -10,8 +10,6 @@
  *
  * (C) Copyright 2002-2004 by David Brownell
  * All Rights Reserved.
- *
- * This software is licensed under the GNU GPL version 2.
  */
 
 #ifndef __LINUX_USB_GADGET_H
diff --git a/include/linux/usb/input.h b/include/linux/usb/input.h
index 974befa72ac0..5e759b2cf551 100644
--- a/include/linux/usb/input.h
+++ b/include/linux/usb/input.h
@@ -1,10 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2005 Dmitry Torokhov
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef __LINUX_USB_INPUT_H
diff --git a/include/linux/usb/isp1301.h b/include/linux/usb/isp1301.h
index dedb3b2473e8..fa986b926a12 100644
--- a/include/linux/usb/isp1301.h
+++ b/include/linux/usb/isp1301.h
@@ -3,16 +3,6 @@
  * NXP ISP1301 USB transceiver driver
  *
  * Copyright (C) 2012 Roland Stigge <stigge@antcom.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #ifndef __LINUX_USB_ISP1301_H
diff --git a/include/linux/usb/m66592.h b/include/linux/usb/m66592.h
index 2dfe68183495..5f04de2b47fd 100644
--- a/include/linux/usb/m66592.h
+++ b/include/linux/usb/m66592.h
@@ -3,20 +3,6 @@
  * M66592 driver platform data
  *
  * Copyright (C) 2009  Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __LINUX_USB_M66592_H
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index dba55ccb9b53..98487fd7ab11 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * OF helpers for usb devices.
- *
- * This file is released under the GPLv2
  */
 
 #ifndef __LINUX_USB_OF_H
diff --git a/include/linux/usb/r8a66597.h b/include/linux/usb/r8a66597.h
index c0753d026bbf..f0fa7ddadbaa 100644
--- a/include/linux/usb/r8a66597.h
+++ b/include/linux/usb/r8a66597.h
@@ -5,20 +5,6 @@
  * Copyright (C) 2009  Renesas Solutions Corp.
  *
  * Author : Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef __LINUX_USB_R8A66597_H
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 16ea5a4cc586..8ea319f89e1f 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -4,11 +4,6 @@
  *
  *	Copyright (C) 1999 - 2012
  *	    Greg Kroah-Hartman (greg@kroah.com)
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; version 2 of the License.
- *
  */
 
 #ifndef __LINUX_USB_SERIAL_H
diff --git a/include/linux/usb/storage.h b/include/linux/usb/storage.h
index e0240f864548..2827ce72e502 100644
--- a/include/linux/usb/storage.h
+++ b/include/linux/usb/storage.h
@@ -9,8 +9,6 @@
  *
  * This file contains definitions taken from the
  * USB Mass Storage Class Specification Overview
- *
- * Distributed under the terms of the GNU GPL, version two.
  */
 
 /* Storage subclass codes */
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index d3e65eb9e16f..46e73584b6e6 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -1,16 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #ifndef __TEGRA_USB_PHY_H
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index 36c2982780ad..5050f502c1ed 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -3,10 +3,6 @@
  * ulpi.h -- ULPI defines and function prorotypes
  *
  * Copyright (C) 2010 Nokia Corporation
- *
- * This software is distributed under the terms of the GNU General
- * Public License ("GPL") as published by the Free Software Foundation,
- * version 2 of that License.
  */
 
 #ifndef __LINUX_USB_ULPI_H
diff --git a/include/linux/usb/xhci-dbgp.h b/include/linux/usb/xhci-dbgp.h
index 01fe768873f9..171fd74b1cfc 100644
--- a/include/linux/usb/xhci-dbgp.h
+++ b/include/linux/usb/xhci-dbgp.h
@@ -5,10 +5,6 @@
  * Copyright (C) 2016 Intel Corporation
  *
  * Author: Lu Baolu <baolu.lu@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_XHCI_DBGP_H
-- 
2.34.1

