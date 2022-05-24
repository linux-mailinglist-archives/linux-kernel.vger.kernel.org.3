Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB1532EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiEXQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEXQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:25:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C6703E6;
        Tue, 24 May 2022 09:25:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 1so8164394ljh.8;
        Tue, 24 May 2022 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=zPhxllF5F1ooqZ+DM4FsM6x7x43t9cFm5fBSj3CxD4Q=;
        b=S55iNL+8PY7rVBoofEDi3fJqqGQJ6ApbFqqPziO0izR32OJLbK5eU2uoWBKSd7EwxC
         DeZggB2DBY0zlsZuYZT2GodrcXla14OxtK2TtcdaU2qwBPqk436/r3QmX1vXwvC8dQrB
         VW1vztvCV8RuPmAVbYVmUhdCC2y+fB/ddNhDy3APq4SGOgdJnHes2MjgbcQUX2Y0+WqZ
         C/58VX+6v7h4AvdD7TNcv1LePOMJDhxKo63DCRossWpdua9D4v7jnRuIDbdMU13hKv+q
         rZhL3qUuIGnF2Y7noEgRYdgWLVqn5T5CYCLy9ylEqlcTXYId5pCXZsOBJuOdpVlauopc
         H5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=zPhxllF5F1ooqZ+DM4FsM6x7x43t9cFm5fBSj3CxD4Q=;
        b=yOagLhCaNF6hOoU31aAtS92lmZsL0uPlIrvb0E0oWrDd1YKOwsYnMWSNeppfSbtJ2b
         v8chEWA47aYKfinNOn3QhUBis2jGPRut0yU8YmakyOSPb9VAEzmlnVCfngFfffH94hqL
         Vh+LLAJajhteVvz5O+N0RzVy6F9etO0lqs7hnajwaa2X4YvS3Rpb6gTPBkoWExemYdjU
         n4jWx00S7V11sXqMCrYonA8SR3hhp0TY7ioz+Ae1OUsowPgoqYZ3pCYwno2lwUGzBZNH
         ZDI2pGeeURZvFLyjXqW/w9eJfViMI3/m+bpdyZBOr/Xuyv0VH/8VpQEyXQp2Qy/K+URG
         y2oQ==
X-Gm-Message-State: AOAM530kEccQfNkBvNBM5khFx47r2DomuRrP0zFi8mmLtFaQPDHzKWtE
        iru4R+xQ+oeq+/FWY+f2Lzo8IUJrjEc=
X-Google-Smtp-Source: ABdhPJyAZc/ON5OOBWibR/N9LwVRZtM3ezCnB1vGjRewCWxsmR57W4Sf5Ot0PYCw4OjfQ2L3LK03jg==
X-Received: by 2002:a2e:555:0:b0:253:c8a6:6dfa with SMTP id 82-20020a2e0555000000b00253c8a66dfamr16468981ljf.240.1653409544829;
        Tue, 24 May 2022 09:25:44 -0700 (PDT)
Received: from crux (31-208-28-24.cust.bredband2.com. [31.208.28.24])
        by smtp.gmail.com with ESMTPSA id z17-20020ac25df1000000b0047255d210e4sm2606848lfq.19.2022.05.24.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 09:25:43 -0700 (PDT)
Date:   Tue, 24 May 2022 18:25:40 +0200
From:   Artur Bujdoso <artur.bujdoso@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon-usb: move driver out of staging
Message-ID: <Yo0HBIlSXOBM+//9@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Octeon usb driver has been in staging for a long time and used in
Ubiquiti routers for a while now.
It's been built and then tested on real hardware with several usb devices
and it is proven to be stable and ready to be moved to its proper place
in the kernel tree.

Move it to drivers/usb/host and adjust its Makefile, Kconfig and defconfig
dependencies.

Many thanks to the developers who made it happen.

Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
---
Changes in v2:
  - Write a better changelog.

 arch/mips/configs/cavium_octeon_defconfig             |  2 +-
 drivers/staging/Kconfig                               |  2 --
 drivers/staging/Makefile                              |  1 -
 drivers/staging/octeon-usb/Kconfig                    | 11 -----------
 drivers/staging/octeon-usb/Makefile                   |  2 --
 drivers/staging/octeon-usb/TODO                       |  8 --------
 drivers/usb/host/Kconfig                              | 10 ++++++++++
 drivers/usb/host/Makefile                             |  1 +
 drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c |  0
 drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h |  0
 10 files changed, 12 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/staging/octeon-usb/Kconfig
 delete mode 100644 drivers/staging/octeon-usb/Makefile
 delete mode 100644 drivers/staging/octeon-usb/TODO
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c (100%)
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h (100%)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index b6695367aa33..97ceaf080c0c 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -134,7 +134,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
-CONFIG_OCTEON_USB=y
+CONFIG_USB_OCTEON_HCD=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 0a993c47273e..3bd80f9695ac 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -42,8 +42,6 @@ source "drivers/staging/rts5208/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
 
-source "drivers/staging/octeon-usb/Kconfig"
-
 source "drivers/staging/vt6655/Kconfig"
 
 source "drivers/staging/vt6656/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2800ab9b2d1d..1d9ae39fea14 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_R8712U)		+= rtl8712/
 obj-$(CONFIG_R8188EU)		+= r8188eu/
 obj-$(CONFIG_RTS5208)		+= rts5208/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
-obj-$(CONFIG_OCTEON_USB)	+= octeon-usb/
 obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme_user/
diff --git a/drivers/staging/octeon-usb/Kconfig b/drivers/staging/octeon-usb/Kconfig
deleted file mode 100644
index 6a5d842ee0f2..000000000000
--- a/drivers/staging/octeon-usb/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config OCTEON_USB
-	tristate "Cavium Networks Octeon USB support"
-	depends on CAVIUM_OCTEON_SOC && USB
-	help
-	  This driver supports USB host controller on some Cavium
-	  Networks' products in the Octeon family.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called octeon-hcd.
-
diff --git a/drivers/staging/octeon-usb/Makefile b/drivers/staging/octeon-usb/Makefile
deleted file mode 100644
index 9873a0130ad5..000000000000
--- a/drivers/staging/octeon-usb/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-${CONFIG_OCTEON_USB} := octeon-hcd.o
diff --git a/drivers/staging/octeon-usb/TODO b/drivers/staging/octeon-usb/TODO
deleted file mode 100644
index 2b29acca5caa..000000000000
--- a/drivers/staging/octeon-usb/TODO
+++ /dev/null
@@ -1,8 +0,0 @@
-This driver is functional and has been tested on EdgeRouter Lite,
-D-Link DSR-1000N and EBH5600 evaluation board with USB mass storage.
-
-TODO:
-	- kernel coding style
-	- checkpatch warnings
-
-Contact: Aaro Koskinen <aaro.koskinen@iki.fi>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 57ca5f97a3dc..4acf3987bfd2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -306,6 +306,16 @@ config USB_EHCI_MV
 	  Dova, Armada 370 and Armada XP. See "Support for Marvell EBU
 	  on-chip EHCI USB controller" for those.
 
+config USB_OCTEON_HCD
+	tristate "Cavium Networks Octeon USB support"
+	depends on CAVIUM_OCTEON_SOC && USB
+	help
+	  This driver supports USB host controller on some Cavium
+	  Networks' products in the Octeon family.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called octeon-hcd.
+
 config USB_CNS3XXX_EHCI
 	bool "Cavium CNS3XXX EHCI Module (DEPRECATED)"
 	depends on ARCH_CNS3XXX || COMPILE_TEST
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 2948983618fb..2c8a61be7e46 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 obj-$(CONFIG_USB_OHCI_HCD_PXA27X)	+= ohci-pxa27x.o
 obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
+obj-$(CONFIG_USB_OCTEON_HCD)	+= octeon-hcd.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
similarity index 100%
rename from drivers/staging/octeon-usb/octeon-hcd.c
rename to drivers/usb/host/octeon-hcd.c
diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/usb/host/octeon-hcd.h
similarity index 100%
rename from drivers/staging/octeon-usb/octeon-hcd.h
rename to drivers/usb/host/octeon-hcd.h
-- 
2.30.2

