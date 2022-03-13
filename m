Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE934D737D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiCMHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiCMHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2F194565;
        Sat, 12 Mar 2022 23:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E080BB80B06;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41963C340E8;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=8jiH/roSA+ENXOrqEKGa5oaeY8Ium9QvjUrwMjk8dyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHw100dlT64i23hyMPZ7ttZQN6/h5erq5cDQbacZIMSM1tTXHd/VZmqoxYMKIWGCC
         HupqIEd3MdB+sRLEuxfc79LEd5qw4r9V5r0/HB2o3/HESQnOdBMx+2zfqQUdyGxFdb
         Qy50S7NBrHYPYtDS08BOehEdW2jQZhCBn+/4CUliHD375vc7l+DJvbOhYXCVyLXAC3
         mdNLil/iUiWzHqe6pLBrF3pVoEZYgiXs1a+FrUu8jPu53+Xm9i4YcrqaBANkDtZJqD
         m3hE6ujZWOubbgDHghF2Vv94l/6U267QkMl5Ey2PKT1zeY/MVKk3ZpLNedYmjJjS0p
         O1CoI1TbLw4cA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012vY-0j; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Leon Romanovsky <leon@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Scott K Logan <logans@cottsay.net>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 01/39] media: xc2028: rename the driver from tuner-xc2028
Date:   Sun, 13 Mar 2022 08:21:10 +0100
Message-Id: <d76231e460fbaba7115212bf55f1eab35aba6223.1647155572.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647155572.git.mchehab@kernel.org>
References: <cover.1647155572.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only tuner driver that has "tuner-" on its name.

Rename it, in order to match all the other tuner drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 Documentation/admin-guide/media/i2c-cardlist.rst            | 2 +-
 MAINTAINERS                                                 | 2 +-
 drivers/media/pci/cx18/cx18-driver.c                        | 2 +-
 drivers/media/pci/cx18/cx18-dvb.c                           | 2 +-
 drivers/media/pci/cx18/cx18-gpio.c                          | 2 +-
 drivers/media/pci/cx23885/cx23885-cards.c                   | 2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c                     | 2 +-
 drivers/media/pci/cx23885/cx23885-video.c                   | 2 +-
 drivers/media/pci/cx88/cx88.h                               | 2 +-
 drivers/media/pci/ivtv/ivtv-driver.c                        | 2 +-
 drivers/media/pci/ivtv/ivtv-gpio.c                          | 2 +-
 drivers/media/pci/saa7134/saa7134-cards.c                   | 2 +-
 drivers/media/pci/saa7134/saa7134-dvb.c                     | 2 +-
 drivers/media/tuners/Makefile                               | 2 +-
 drivers/media/tuners/tuner-types.c                          | 2 +-
 .../media/tuners/{tuner-xc2028-types.h => xc2028-types.h}   | 6 +++---
 drivers/media/tuners/{tuner-xc2028.c => xc2028.c}           | 6 +++---
 drivers/media/tuners/{tuner-xc2028.h => xc2028.h}           | 2 +-
 drivers/media/tuners/xc4000.c                               | 2 +-
 drivers/media/usb/dvb-usb/cxusb.c                           | 2 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c                 | 2 +-
 drivers/media/usb/em28xx/em28xx-i2c.c                       | 2 +-
 drivers/media/usb/em28xx/em28xx.h                           | 2 +-
 drivers/media/usb/tm6000/tm6000-cards.c                     | 2 +-
 drivers/media/usb/tm6000/tm6000-dvb.c                       | 2 +-
 drivers/media/usb/tm6000/tm6000-i2c.c                       | 2 +-
 drivers/media/v4l2-core/tuner-core.c                        | 2 +-
 27 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/media/tuners/{tuner-xc2028-types.h => xc2028-types.h} (96%)
 rename drivers/media/tuners/{tuner-xc2028.c => xc2028.c} (99%)
 rename drivers/media/tuners/{tuner-xc2028.h => xc2028.h} (99%)

diff --git a/Documentation/admin-guide/media/i2c-cardlist.rst b/Documentation/admin-guide/media/i2c-cardlist.rst
index db17f39b56cf..ef3b5fff3b01 100644
--- a/Documentation/admin-guide/media/i2c-cardlist.rst
+++ b/Documentation/admin-guide/media/i2c-cardlist.rst
@@ -284,7 +284,7 @@ tda9887       TDA 9885/6/7 analog IF demodulator
 tea5761       TEA 5761 radio tuner
 tea5767       TEA 5767 radio tuner
 tua9001       Infineon TUA9001 silicon tuner
-tuner-xc2028  XCeive xc2028/xc3028 tuners
+xc2028        XCeive xc2028/xc3028 tuners
 xc4000        Xceive XC4000 silicon tuner
 xc5000        Xceive XC5000 silicon tuner
 ============  ==================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index ae55cd558d95..1a9fb0615925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21049,7 +21049,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/tuners/tuner-xc2028.*
+F:	drivers/media/tuners/xc2028.*
 
 XDP (eXpress Data Path)
 M:	Alexei Starovoitov <ast@kernel.org>
diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 1be9672ae9d4..84260972c343 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -23,7 +23,7 @@
 #include "cx18-mailbox.h"
 #include "cx18-ioctl.h"
 #include "cx18-controls.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include <linux/dma-mapping.h>
 #include <media/tveeprom.h>
 
diff --git a/drivers/media/pci/cx18/cx18-dvb.c b/drivers/media/pci/cx18/cx18-dvb.c
index 4c57a294b9fa..33e5a5b5fab4 100644
--- a/drivers/media/pci/cx18/cx18-dvb.c
+++ b/drivers/media/pci/cx18/cx18-dvb.c
@@ -22,7 +22,7 @@
 #include <linux/firmware.h>
 #include "mt352.h"
 #include "mt352_priv.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 
 DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 
diff --git a/drivers/media/pci/cx18/cx18-gpio.c b/drivers/media/pci/cx18/cx18-gpio.c
index cf7cfda94107..160c8377e352 100644
--- a/drivers/media/pci/cx18/cx18-gpio.c
+++ b/drivers/media/pci/cx18/cx18-gpio.c
@@ -12,7 +12,7 @@
 #include "cx18-io.h"
 #include "cx18-cards.h"
 #include "cx18-gpio.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 
 /********************* GPIO stuffs *********************/
 
diff --git a/drivers/media/pci/cx23885/cx23885-cards.c b/drivers/media/pci/cx23885/cx23885-cards.c
index 0160f909f38c..9244b4320558 100644
--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -15,7 +15,7 @@
 #include <linux/firmware.h>
 #include <misc/altera.h>
 
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "netup-eeprom.h"
 #include "netup-init.h"
 #include "altera-ci.h"
diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 45c2f4afceb8..8fd5b6ef2428 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -28,7 +28,7 @@
 #include "xc5000.h"
 #include "max2165.h"
 #include "tda10048.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "tuner-simple.h"
 #include "dib7000p.h"
 #include "dib0070.h"
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index a380e0920a21..3d03f5e95786 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -24,7 +24,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-event.h>
 #include "cx23885-ioctl.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 
 #include <media/drv-intf/cx25840.h>
 
diff --git a/drivers/media/pci/cx88/cx88.h b/drivers/media/pci/cx88/cx88.h
index ce4acf6de6aa..2ff3226a52ec 100644
--- a/drivers/media/pci/cx88/cx88.h
+++ b/drivers/media/pci/cx88/cx88.h
@@ -28,7 +28,7 @@
 #include <media/i2c/wm8775.h>
 
 #include "cx88-reg.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 
 #include <linux/mutex.h>
 
diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index 57d4d5485d7a..f5846c22c799 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -57,7 +57,7 @@
 #include <linux/dma-mapping.h>
 #include <media/tveeprom.h>
 #include <media/i2c/saa7115.h>
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include <uapi/linux/sched/types.h>
 
 /* If you have already X v4l cards, then set this to X. This way
diff --git a/drivers/media/pci/ivtv/ivtv-gpio.c b/drivers/media/pci/ivtv/ivtv-gpio.c
index 856e7ab7f33e..6434c0d03a6d 100644
--- a/drivers/media/pci/ivtv/ivtv-gpio.c
+++ b/drivers/media/pci/ivtv/ivtv-gpio.c
@@ -10,7 +10,7 @@
 #include "ivtv-driver.h"
 #include "ivtv-cards.h"
 #include "ivtv-gpio.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include <media/tuner.h>
 #include <media/v4l2-ctrls.h>
 
diff --git a/drivers/media/pci/saa7134/saa7134-cards.c b/drivers/media/pci/saa7134/saa7134-cards.c
index 0d82a4b27d5b..99be59af3560 100644
--- a/drivers/media/pci/saa7134/saa7134-cards.c
+++ b/drivers/media/pci/saa7134/saa7134-cards.c
@@ -15,7 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include <media/v4l2-common.h>
 #include <media/tveeprom.h>
 #include "tea5767.h"
diff --git a/drivers/media/pci/saa7134/saa7134-dvb.c b/drivers/media/pci/saa7134/saa7134-dvb.c
index d17a1b15faee..9c6cfef03331 100644
--- a/drivers/media/pci/saa7134/saa7134-dvb.c
+++ b/drivers/media/pci/saa7134/saa7134-dvb.c
@@ -26,7 +26,7 @@
 #include "mt352_priv.h" /* FIXME */
 #include "tda1004x.h"
 #include "nxt200x.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "xc5000.h"
 
 #include "tda10086.h"
diff --git a/drivers/media/tuners/Makefile b/drivers/media/tuners/Makefile
index 7b4f8423501e..abcad519a4f9 100644
--- a/drivers/media/tuners/Makefile
+++ b/drivers/media/tuners/Makefile
@@ -5,7 +5,7 @@
 
 tda18271-objs := tda18271-maps.o tda18271-common.o tda18271-fe.o
 
-obj-$(CONFIG_MEDIA_TUNER_XC2028) += tuner-xc2028.o
+obj-$(CONFIG_MEDIA_TUNER_XC2028) += xc2028.o
 obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-simple.o
 # tuner-types will be merged into tuner-simple, in the future
 obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-types.o
diff --git a/drivers/media/tuners/tuner-types.c b/drivers/media/tuners/tuner-types.c
index 0ed2c5bc082e..ff5a6c0acdd4 100644
--- a/drivers/media/tuners/tuner-types.c
+++ b/drivers/media/tuners/tuner-types.c
@@ -1831,7 +1831,7 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_XC2028] = { /* Xceive 2028 */
 		.name   = "Xceive xc2028/xc3028 tuner",
-		/* see tuner-xc2028.c for details */
+		/* see xc2028.c for details */
 	},
 	[TUNER_THOMSON_FE6600] = { /* Thomson PAL / DVB-T */
 		.name   = "Thomson FE6600",
diff --git a/drivers/media/tuners/tuner-xc2028-types.h b/drivers/media/tuners/xc2028-types.h
similarity index 96%
rename from drivers/media/tuners/tuner-xc2028-types.h
rename to drivers/media/tuners/xc2028-types.h
index fcca39d3e006..63a03de1e97b 100644
--- a/drivers/media/tuners/tuner-xc2028-types.h
+++ b/drivers/media/tuners/xc2028-types.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * tuner-xc2028_types
+ * xc2028_types
  *
- * This file includes internal tipes to be used inside tuner-xc2028.
- * Shouldn't be included outside tuner-xc2028
+ * This file includes internal tipes to be used inside xc2028.
+ * Shouldn't be included outside xc2028
  *
  * Copyright (c) 2007-2008 Mauro Carvalho Chehab <mchehab@kernel.org>
  */
diff --git a/drivers/media/tuners/tuner-xc2028.c b/drivers/media/tuners/xc2028.c
similarity index 99%
rename from drivers/media/tuners/tuner-xc2028.c
rename to drivers/media/tuners/xc2028.c
index 574c3bb135d7..69c2e1b99bf1 100644
--- a/drivers/media/tuners/tuner-xc2028.c
+++ b/drivers/media/tuners/xc2028.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// tuner-xc2028
+// xc2028
 //
 // Copyright (c) 2007-2008 Mauro Carvalho Chehab <mchehab@kernel.org>
 //
@@ -16,8 +16,8 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 #include "tuner-i2c.h"
-#include "tuner-xc2028.h"
-#include "tuner-xc2028-types.h"
+#include "xc2028.h"
+#include "xc2028-types.h"
 
 #include <linux/dvb/frontend.h>
 #include <media/dvb_frontend.h>
diff --git a/drivers/media/tuners/tuner-xc2028.h b/drivers/media/tuners/xc2028.h
similarity index 99%
rename from drivers/media/tuners/tuner-xc2028.h
rename to drivers/media/tuners/xc2028.h
index 2dd45d0765d7..072faae7a954 100644
--- a/drivers/media/tuners/tuner-xc2028.h
+++ b/drivers/media/tuners/xc2028.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * tuner-xc2028
+ * xc2028
  *
  * Copyright (c) 2007-2008 Mauro Carvalho Chehab <mchehab@kernel.org>
  */
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index d9606738ce43..a04dfd5799f7 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -22,7 +22,7 @@
 
 #include "xc4000.h"
 #include "tuner-i2c.h"
-#include "tuner-xc2028-types.h"
+#include "xc2028-types.h"
 
 static int debug;
 module_param(debug, int, 0644);
diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index 7707de7bae7c..265b960db499 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -35,7 +35,7 @@
 #include "mt352.h"
 #include "mt352_priv.h"
 #include "zl10353.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "tuner-simple.h"
 #include "mxl5005s.h"
 #include "max2165.h"
diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index 710c1afe3e85..08fcf120daf1 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -12,7 +12,7 @@
 #include "dib9000.h"
 #include "mt2060.h"
 #include "mt2266.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "xc5000.h"
 #include "xc4000.h"
 #include "s5h1411.h"
diff --git a/drivers/media/usb/em28xx/em28xx-i2c.c b/drivers/media/usb/em28xx/em28xx-i2c.c
index 255395959255..b9a8d3fbad1a 100644
--- a/drivers/media/usb/em28xx/em28xx-i2c.c
+++ b/drivers/media/usb/em28xx/em28xx-i2c.c
@@ -26,7 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/jiffies.h>
 
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include <media/v4l2-common.h>
 #include <media/tuner.h>
 
diff --git a/drivers/media/usb/em28xx/em28xx.h b/drivers/media/usb/em28xx/em28xx.h
index ab167cd1f400..7fc0b68a4a22 100644
--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -41,7 +41,7 @@
 #include <media/v4l2-fh.h>
 #include <media/i2c/ir-kbd-i2c.h>
 #include <media/rc-core.h>
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "xc5000.h"
 #include "em28xx-reg.h"
 
diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm6000/tm6000-cards.c
index 5358cd8c4603..98f4a63adc2a 100644
--- a/drivers/media/usb/tm6000/tm6000-cards.c
+++ b/drivers/media/usb/tm6000/tm6000-cards.c
@@ -17,7 +17,7 @@
 
 #include "tm6000.h"
 #include "tm6000-regs.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "xc5000.h"
 
 #define TM6000_BOARD_UNKNOWN			0
diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm6000/tm6000-dvb.c
index 4990fa886d7a..8c2725e4105b 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -16,7 +16,7 @@
 
 #include <media/tuner.h>
 
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "xc5000.h"
 
 MODULE_DESCRIPTION("DVB driver extension module for tm5600/6000/6010 based TV cards");
diff --git a/drivers/media/usb/tm6000/tm6000-i2c.c b/drivers/media/usb/tm6000/tm6000-i2c.c
index b37782d6f79c..7554b93b82e6 100644
--- a/drivers/media/usb/tm6000/tm6000-i2c.c
+++ b/drivers/media/usb/tm6000/tm6000-i2c.c
@@ -15,7 +15,7 @@
 #include "tm6000-regs.h"
 #include <media/v4l2-common.h>
 #include <media/tuner.h>
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 
 
 /* ----------------------------------------------------------- */
diff --git a/drivers/media/v4l2-core/tuner-core.c b/drivers/media/v4l2-core/tuner-core.c
index 12d1e0c33c3c..ad9224a18853 100644
--- a/drivers/media/v4l2-core/tuner-core.c
+++ b/drivers/media/v4l2-core/tuner-core.c
@@ -35,7 +35,7 @@
 #include "tda8290.h"
 #include "tea5761.h"
 #include "tea5767.h"
-#include "tuner-xc2028.h"
+#include "xc2028.h"
 #include "tuner-simple.h"
 #include "tda9887.h"
 #include "xc5000.h"
-- 
2.35.1

