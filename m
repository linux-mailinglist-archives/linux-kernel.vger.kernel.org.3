Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362344D356C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiCIQei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiCIQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:27:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D015E0C5;
        Wed,  9 Mar 2022 08:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C4A561926;
        Wed,  9 Mar 2022 16:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1388C340EC;
        Wed,  9 Mar 2022 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646842949;
        bh=maNPFsOfxCoxNyk7Q8rtmn1q5ZcMSPw7wkd2w6CgCZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnBH4zRe1w6Jo4FjdWuK3E/YLBMOg82oenux7AOJaZ4YFb3Ac9vepEuWhHqMDH71P
         9swqipYfjx5+OYIHZnEBE3+WVUGUvH2rqSc9ArZ3kdmdUM9BXc3u4FNjqAPcfaRf8U
         rtoO/pWIlbaUsxXXX/+txweqNpo4/5WSLVmVWyW3kkZFHQNHxWPRMqH82XbXc5yN2P
         3TGzmmClpTFqQDjy+zz0dM9FEyDkfQqO/6+2Et54ozPRLpSVtLfkjhydZ4DpihwMfn
         MgHm2aHnKqL9hKIAHTwdF2a4pATcPf5bsTf5e6fgPrjHvKQBubEmKcvNt3n1k+zFNQ
         rVAgXtBbL5gig==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nRz50-00E6Ar-FX; Wed, 09 Mar 2022 17:22:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 4/5] media: dvb-frontend: remove TUNER_ from some DVB frontend Kconfig options
Date:   Wed,  9 Mar 2022 17:22:24 +0100
Message-Id: <7693cc128d3cc469d06daa33518edc2298f4de01.1646842741.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646842741.git.mchehab@kernel.org>
References: <cover.1646842741.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a handful of DVB tuners have TUNER_ on its Kconfig option.

Get rid on it, in order to use a more standard namespace

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1646842741.git.mchehab@kernel.org/

 drivers/media/common/b2c2/Kconfig     | 4 ++--
 drivers/media/dvb-frontends/Kconfig   | 8 ++++----
 drivers/media/dvb-frontends/Makefile  | 8 ++++----
 drivers/media/dvb-frontends/cx24113.h | 2 +-
 drivers/media/dvb-frontends/dib0070.h | 2 +-
 drivers/media/dvb-frontends/dib0090.h | 2 +-
 drivers/media/dvb-frontends/itd1000.h | 2 +-
 drivers/media/pci/cx23885/Kconfig     | 2 +-
 drivers/media/usb/dvb-usb/Kconfig     | 6 +++---
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/common/b2c2/Kconfig b/drivers/media/common/b2c2/Kconfig
index 27284797e755..ab8a33a85c81 100644
--- a/drivers/media/common/b2c2/Kconfig
+++ b/drivers/media/common/b2c2/Kconfig
@@ -13,12 +13,12 @@ config DVB_B2C2_FLEXCOP
 	select DVB_BCM3510 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_LGDT330X if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_S5H1420 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_ITD1000 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_ITD1000 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_ISL6421 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_CX24120 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_CX24123 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_SIMPLE if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_CX24113 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_CX24113 if MEDIA_SUBDRV_AUTOSELECT
 
 # Selected via the PCI or USB flexcop drivers
 config DVB_B2C2_FLEXCOP_DEBUG
diff --git a/drivers/media/dvb-frontends/Kconfig b/drivers/media/dvb-frontends/Kconfig
index 2c1ed98d43c5..3d44fdbc0163 100644
--- a/drivers/media/dvb-frontends/Kconfig
+++ b/drivers/media/dvb-frontends/Kconfig
@@ -232,14 +232,14 @@ config DVB_VES1X93
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_TUNER_ITD1000
+config DVB_ITD1000
 	tristate "Integrant ITD1000 Zero IF tuner for DVB-S/DSS"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_TUNER_CX24113
+config DVB_CX24113
 	tristate "Conexant CX24113/CX24128 tuner for DVB-S/DSS"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
@@ -764,7 +764,7 @@ config DVB_PLL
 	  This module drives a number of tuners based on PLL chips with a
 	  common I2C interface. Say Y when you want to support these tuners.
 
-config DVB_TUNER_DIB0070
+config DVB_DIB0070
 	tristate "DiBcom DiB0070 silicon base-band tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
@@ -773,7 +773,7 @@ config DVB_TUNER_DIB0070
 	  This device is only used inside a SiP called together with a
 	  demodulator for now.
 
-config DVB_TUNER_DIB0090
+config DVB_DIB0090
 	tristate "DiBcom DiB0090 silicon base-band tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
diff --git a/drivers/media/dvb-frontends/Makefile b/drivers/media/dvb-frontends/Makefile
index d32e4c0be576..659e01f140d5 100644
--- a/drivers/media/dvb-frontends/Makefile
+++ b/drivers/media/dvb-frontends/Makefile
@@ -66,16 +66,16 @@ obj-$(CONFIG_DVB_ISL6421) += isl6421.o
 obj-$(CONFIG_DVB_TDA10086) += tda10086.o
 obj-$(CONFIG_DVB_TDA826X) += tda826x.o
 obj-$(CONFIG_DVB_TDA8261) += tda8261.o
-obj-$(CONFIG_DVB_TUNER_DIB0070) += dib0070.o
-obj-$(CONFIG_DVB_TUNER_DIB0090) += dib0090.o
+obj-$(CONFIG_DVB_DIB0070) += dib0070.o
+obj-$(CONFIG_DVB_DIB0090) += dib0090.o
 obj-$(CONFIG_DVB_TUA6100) += tua6100.o
 obj-$(CONFIG_DVB_S5H1409) += s5h1409.o
-obj-$(CONFIG_DVB_TUNER_ITD1000) += itd1000.o
+obj-$(CONFIG_DVB_ITD1000) += itd1000.o
 obj-$(CONFIG_DVB_AU8522) += au8522_common.o
 obj-$(CONFIG_DVB_AU8522_DTV) += au8522_dig.o
 obj-$(CONFIG_DVB_AU8522_V4L) += au8522_decoder.o
 obj-$(CONFIG_DVB_TDA10048) += tda10048.o
-obj-$(CONFIG_DVB_TUNER_CX24113) += cx24113.o
+obj-$(CONFIG_DVB_CX24113) += cx24113.o
 obj-$(CONFIG_DVB_S5H1411) += s5h1411.o
 obj-$(CONFIG_DVB_LGS8GL5) += lgs8gl5.o
 obj-$(CONFIG_DVB_TDA665x) += tda665x.o
diff --git a/drivers/media/dvb-frontends/cx24113.h b/drivers/media/dvb-frontends/cx24113.h
index c5460c2aec7b..67c561b8aef0 100644
--- a/drivers/media/dvb-frontends/cx24113.h
+++ b/drivers/media/dvb-frontends/cx24113.h
@@ -16,7 +16,7 @@ struct cx24113_config {
 	u32 xtal_khz;
 };
 
-#if IS_REACHABLE(CONFIG_DVB_TUNER_CX24113)
+#if IS_REACHABLE(CONFIG_DVB_CX24113)
 extern struct dvb_frontend *cx24113_attach(struct dvb_frontend *,
 	const struct cx24113_config *config, struct i2c_adapter *i2c);
 
diff --git a/drivers/media/dvb-frontends/dib0070.h b/drivers/media/dvb-frontends/dib0070.h
index ae5c44e9b1e6..874bdb56aaa9 100644
--- a/drivers/media/dvb-frontends/dib0070.h
+++ b/drivers/media/dvb-frontends/dib0070.h
@@ -45,7 +45,7 @@ struct dib0070_config {
 	u8 vga_filter;
 };
 
-#if IS_REACHABLE(CONFIG_DVB_TUNER_DIB0070)
+#if IS_REACHABLE(CONFIG_DVB_DIB0070)
 extern struct dvb_frontend *dib0070_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct dib0070_config *cfg);
 extern u16 dib0070_wbd_offset(struct dvb_frontend *);
 extern void dib0070_ctrl_agc_filter(struct dvb_frontend *, u8 open);
diff --git a/drivers/media/dvb-frontends/dib0090.h b/drivers/media/dvb-frontends/dib0090.h
index e5cb311694d9..e205ad785089 100644
--- a/drivers/media/dvb-frontends/dib0090.h
+++ b/drivers/media/dvb-frontends/dib0090.h
@@ -72,7 +72,7 @@ struct dib0090_config {
 	u8 force_crystal_mode;
 };
 
-#if IS_REACHABLE(CONFIG_DVB_TUNER_DIB0090)
+#if IS_REACHABLE(CONFIG_DVB_DIB0090)
 extern struct dvb_frontend *dib0090_register(struct dvb_frontend *fe, struct i2c_adapter *i2c, const struct dib0090_config *config);
 extern struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_adapter *i2c, const struct dib0090_config *config);
 extern void dib0090_dcc_freq(struct dvb_frontend *fe, u8 fast);
diff --git a/drivers/media/dvb-frontends/itd1000.h b/drivers/media/dvb-frontends/itd1000.h
index 3539c69ce20a..5a5bcee6914c 100644
--- a/drivers/media/dvb-frontends/itd1000.h
+++ b/drivers/media/dvb-frontends/itd1000.h
@@ -15,7 +15,7 @@ struct itd1000_config {
 	u8 i2c_address;
 };
 
-#if IS_REACHABLE(CONFIG_DVB_TUNER_ITD1000)
+#if IS_REACHABLE(CONFIG_DVB_ITD1000)
 extern struct dvb_frontend *itd1000_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct itd1000_config *cfg);
 #else
 static inline struct dvb_frontend *itd1000_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct itd1000_config *cfg)
diff --git a/drivers/media/pci/cx23885/Kconfig b/drivers/media/pci/cx23885/Kconfig
index 926da881929d..33bc08bfeb91 100644
--- a/drivers/media/pci/cx23885/Kconfig
+++ b/drivers/media/pci/cx23885/Kconfig
@@ -43,7 +43,7 @@ config VIDEO_CX23885
 	select MEDIA_TUNER_XC5000 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_SI2157 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_M88RS6000T if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  This is a video4linux driver for Conexant 23885 based
 	  TV cards.
diff --git a/drivers/media/usb/dvb-usb/Kconfig b/drivers/media/usb/dvb-usb/Kconfig
index 7498110142e4..ed3114c2d7e3 100644
--- a/drivers/media/usb/dvb-usb/Kconfig
+++ b/drivers/media/usb/dvb-usb/Kconfig
@@ -89,8 +89,8 @@ config DVB_USB_DIB0700
 	select DVB_S5H1411 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_LGDT3305 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_MN88472 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0090 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB0090 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_MT2266 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_XC2028 if MEDIA_SUBDRV_AUTOSELECT
@@ -129,7 +129,7 @@ config DVB_USB_CXUSB
 	select DVB_MT352 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_ZL10353 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_DIB7000P if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_ATBM8830 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_LGS8GXX if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
-- 
2.35.1

