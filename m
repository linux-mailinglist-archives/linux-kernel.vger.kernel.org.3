Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A604D62F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbiCKOJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349066AbiCKOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB960A81;
        Fri, 11 Mar 2022 06:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30306B82C15;
        Fri, 11 Mar 2022 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03324C36AE2;
        Fri, 11 Mar 2022 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=TDVfs3xtXeHTNTBofq+Sc6rDRvUt94A2YcmX99wBb6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch8TovVgsLvdYeSagd2Ta38YYl0bdAMTvCVXSXIvPCaOcrcGqnOl0GVGRTpaVY4eR
         eG15FvPJWlqEMzzhom+sWQ8lVGWqfPrTa7VCg9yL1qA9YGXHVqFckpR8ihZXIjbPDc
         1HPZXeVPI3PdgLuBXmhcoFpBenk3PC2RGGkPZLLx4a6TWnHNiCcJx8TEjsoLBCRGwH
         Mnbfam+3I8GNlrcRJpNGIVzOjDdnihZOwm/yHkzmVQV2FuT1+v2KiVs7viHyu832GL
         lqmPtD8H2hvdeOHRbM5hoJes5VFX8CmNOfBI8+QVtyXfgugR/NgpNPPyFPy/OP9MYW
         G7kOrphugU7QA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvt-000lAh-KK; Fri, 11 Mar 2022 15:07:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Voronov <avv.0@ya.ru>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mans Rullgard <mans@mansr.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Young <sean@mess.org>, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 03/38] media: Makefiles: sort entries where it fits
Date:   Fri, 11 Mar 2022 15:07:16 +0100
Message-Id: <a65c7574e544301c95b76950d96773f1477e840d.1647006877.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
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

Alphabetically sort entries at the Makefiles.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/common/Makefile           |   4 +-
 drivers/media/common/videobuf2/Makefile |   6 +-
 drivers/media/dvb-frontends/Makefile    | 192 ++++++++++++------------
 drivers/media/pci/Makefile              |  18 ++-
 drivers/media/radio/Makefile            |  42 +++---
 drivers/media/rc/Makefile               |  45 +++---
 drivers/media/rc/keymaps/Makefile       |  33 ++--
 drivers/media/spi/Makefile              |   5 +-
 drivers/media/test-drivers/Makefile     |   9 +-
 drivers/media/tuners/Makefile           |  66 ++++----
 drivers/media/usb/Makefile              |  17 ++-
 drivers/media/v4l2-core/Makefile        |  29 ++--
 12 files changed, 241 insertions(+), 225 deletions(-)

diff --git a/drivers/media/common/Makefile b/drivers/media/common/Makefile
index 55b5a1900124..2e3cc25c5695 100644
--- a/drivers/media/common/Makefile
+++ b/drivers/media/common/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += b2c2/ saa7146/ siano/ v4l2-tpg/ videobuf2/
+
+# Please keep it alphabetically sorted
 obj-$(CONFIG_VIDEO_CX2341X) += cx2341x.o
-obj-$(CONFIG_VIDEO_TVEEPROM) += tveeprom.o
 obj-$(CONFIG_CYPRESS_FIRMWARE) += cypress_firmware.o
 obj-$(CONFIG_TTPCI_EEPROM) += ttpci-eeprom.o
+obj-$(CONFIG_VIDEO_TVEEPROM) += tveeprom.o
diff --git a/drivers/media/common/videobuf2/Makefile b/drivers/media/common/videobuf2/Makefile
index 54306f8d096c..7036e5d56e04 100644
--- a/drivers/media/common/videobuf2/Makefile
+++ b/drivers/media/common/videobuf2/Makefile
@@ -7,9 +7,9 @@ ifeq ($(CONFIG_TRACEPOINTS),y)
 endif
 
 obj-$(CONFIG_VIDEOBUF2_CORE) += videobuf2-common.o
-obj-$(CONFIG_VIDEOBUF2_V4L2) += videobuf2-v4l2.o
-obj-$(CONFIG_VIDEOBUF2_MEMOPS) += videobuf2-memops.o
-obj-$(CONFIG_VIDEOBUF2_VMALLOC) += videobuf2-vmalloc.o
 obj-$(CONFIG_VIDEOBUF2_DMA_CONTIG) += videobuf2-dma-contig.o
 obj-$(CONFIG_VIDEOBUF2_DMA_SG) += videobuf2-dma-sg.o
 obj-$(CONFIG_VIDEOBUF2_DVB) += videobuf2-dvb.o
+obj-$(CONFIG_VIDEOBUF2_MEMOPS) += videobuf2-memops.o
+obj-$(CONFIG_VIDEOBUF2_V4L2) += videobuf2-v4l2.o
+obj-$(CONFIG_VIDEOBUF2_VMALLOC) += videobuf2-vmalloc.o
diff --git a/drivers/media/dvb-frontends/Makefile b/drivers/media/dvb-frontends/Makefile
index d32e4c0be576..2cb52330fba3 100644
--- a/drivers/media/dvb-frontends/Makefile
+++ b/drivers/media/dvb-frontends/Makefile
@@ -10,126 +10,128 @@ ifdef CONFIG_DVB_RTL2832_SDR
 	ccflags-y += -I$(srctree)/drivers/media/usb/dvb-usb-v2
 endif
 
-stb0899-objs := stb0899_drv.o stb0899_algo.o
-stv0900-objs := stv0900_core.o stv0900_sw.o
-drxd-objs := drxd_firm.o drxd_hard.o
 cxd2820r-objs := cxd2820r_core.o cxd2820r_c.o cxd2820r_t.o cxd2820r_t2.o
+drxd-objs := drxd_firm.o drxd_hard.o
 drxk-objs := drxk_hard.o
+stb0899-objs := stb0899_drv.o stb0899_algo.o
+stv0900-objs := stv0900_core.o stv0900_sw.o
 
-obj-$(CONFIG_DVB_PLL) += dvb-pll.o
-obj-$(CONFIG_DVB_STV0299) += stv0299.o
-obj-$(CONFIG_DVB_STB0899) += stb0899.o
-obj-$(CONFIG_DVB_STB6100) += stb6100.o
+# Please keep it alphabetically sorted
+
+obj-$(CONFIG_DVB_A8293) += a8293.o
+obj-$(CONFIG_DVB_AF9013) += af9013.o
+obj-$(CONFIG_DVB_AF9033) += af9033.o
+obj-$(CONFIG_DVB_AS102_FE) += as102_fe.o
+obj-$(CONFIG_DVB_ASCOT2E) += ascot2e.o
+obj-$(CONFIG_DVB_ATBM8830) += atbm8830.o
+obj-$(CONFIG_DVB_AU8522) += au8522_common.o
+obj-$(CONFIG_DVB_AU8522_DTV) += au8522_dig.o
+obj-$(CONFIG_DVB_AU8522_V4L) += au8522_decoder.o
+obj-$(CONFIG_DVB_BCM3510) += bcm3510.o
 obj-$(CONFIG_DVB_CX22700) += cx22700.o
-obj-$(CONFIG_DVB_S5H1432) += s5h1432.o
+obj-$(CONFIG_DVB_CX22702) += cx22702.o
 obj-$(CONFIG_DVB_CX24110) += cx24110.o
-obj-$(CONFIG_DVB_TDA8083) += tda8083.o
-obj-$(CONFIG_DVB_L64781) += l64781.o
+obj-$(CONFIG_DVB_CX24116) += cx24116.o
+obj-$(CONFIG_DVB_CX24117) += cx24117.o
+obj-$(CONFIG_DVB_CX24120) += cx24120.o
+obj-$(CONFIG_DVB_CX24123) += cx24123.o
+obj-$(CONFIG_DVB_CXD2099) += cxd2099.o
+obj-$(CONFIG_DVB_CXD2820R) += cxd2820r.o
+obj-$(CONFIG_DVB_CXD2841ER) += cxd2841er.o
+obj-$(CONFIG_DVB_CXD2880) += cxd2880/
 obj-$(CONFIG_DVB_DIB3000MB) += dib3000mb.o
 obj-$(CONFIG_DVB_DIB3000MC) += dib3000mc.o dibx000_common.o
 obj-$(CONFIG_DVB_DIB7000M) += dib7000m.o dibx000_common.o
 obj-$(CONFIG_DVB_DIB7000P) += dib7000p.o dibx000_common.o
 obj-$(CONFIG_DVB_DIB8000) += dib8000.o dibx000_common.o
 obj-$(CONFIG_DVB_DIB9000) += dib9000.o dibx000_common.o
-obj-$(CONFIG_DVB_MT312) += mt312.o
-obj-$(CONFIG_DVB_VES1820) += ves1820.o
-obj-$(CONFIG_DVB_VES1X93) += ves1x93.o
-obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
-obj-$(CONFIG_DVB_SP887X) += sp887x.o
-obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
-obj-$(CONFIG_DVB_MT352) += mt352.o
-obj-$(CONFIG_DVB_ZL10036) += zl10036.o
-obj-$(CONFIG_DVB_ZL10039) += zl10039.o
-obj-$(CONFIG_DVB_ZL10353) += zl10353.o
-obj-$(CONFIG_DVB_CX22702) += cx22702.o
+obj-$(CONFIG_DVB_DRX39XYJ) += drx39xyj/
 obj-$(CONFIG_DVB_DRXD) += drxd.o
-obj-$(CONFIG_DVB_TDA10021) += tda10021.o
-obj-$(CONFIG_DVB_TDA10023) += tda10023.o
-obj-$(CONFIG_DVB_STV0297) += stv0297.o
-obj-$(CONFIG_DVB_NXT200X) += nxt200x.o
-obj-$(CONFIG_DVB_OR51211) += or51211.o
-obj-$(CONFIG_DVB_OR51132) += or51132.o
-obj-$(CONFIG_DVB_BCM3510) += bcm3510.o
-obj-$(CONFIG_DVB_S5H1420) += s5h1420.o
-obj-$(CONFIG_DVB_LGDT330X) += lgdt330x.o
+obj-$(CONFIG_DVB_DRXK) += drxk.o
+obj-$(CONFIG_DVB_DS3000) += ds3000.o
+obj-$(CONFIG_DVB_DUMMY_FE) += dvb_dummy_fe.o
+obj-$(CONFIG_DVB_EC100) += ec100.o
+obj-$(CONFIG_DVB_GP8PSK_FE) += gp8psk-fe.o
+obj-$(CONFIG_DVB_HELENE) += helene.o
+obj-$(CONFIG_DVB_HORUS3A) += horus3a.o
+obj-$(CONFIG_DVB_ISL6405) += isl6405.o
+obj-$(CONFIG_DVB_ISL6421) += isl6421.o
+obj-$(CONFIG_DVB_ISL6423) += isl6423.o
+obj-$(CONFIG_DVB_IX2505V) += ix2505v.o
+obj-$(CONFIG_DVB_L64781) += l64781.o
+obj-$(CONFIG_DVB_LG2160) += lg2160.o
 obj-$(CONFIG_DVB_LGDT3305) += lgdt3305.o
 obj-$(CONFIG_DVB_LGDT3306A) += lgdt3306a.o
-obj-$(CONFIG_DVB_MXL692) += mxl692.o
-obj-$(CONFIG_DVB_LG2160) += lg2160.o
-obj-$(CONFIG_DVB_CX24123) += cx24123.o
+obj-$(CONFIG_DVB_LGDT330X) += lgdt330x.o
+obj-$(CONFIG_DVB_LGS8GL5) += lgs8gl5.o
+obj-$(CONFIG_DVB_LGS8GXX) += lgs8gxx.o
 obj-$(CONFIG_DVB_LNBH25) += lnbh25.o
 obj-$(CONFIG_DVB_LNBH29) += lnbh29.o
 obj-$(CONFIG_DVB_LNBP21) += lnbp21.o
 obj-$(CONFIG_DVB_LNBP22) += lnbp22.o
-obj-$(CONFIG_DVB_ISL6405) += isl6405.o
-obj-$(CONFIG_DVB_ISL6421) += isl6421.o
-obj-$(CONFIG_DVB_TDA10086) += tda10086.o
-obj-$(CONFIG_DVB_TDA826X) += tda826x.o
-obj-$(CONFIG_DVB_TDA8261) += tda8261.o
-obj-$(CONFIG_DVB_TUNER_DIB0070) += dib0070.o
-obj-$(CONFIG_DVB_TUNER_DIB0090) += dib0090.o
-obj-$(CONFIG_DVB_TUA6100) += tua6100.o
+obj-$(CONFIG_DVB_M88DS3103) += m88ds3103.o
+obj-$(CONFIG_DVB_M88RS2000) += m88rs2000.o
+obj-$(CONFIG_DVB_MB86A16) += mb86a16.o
+obj-$(CONFIG_DVB_MB86A20S) += mb86a20s.o
+obj-$(CONFIG_DVB_MN88443X) += mn88443x.o
+obj-$(CONFIG_DVB_MN88472) += mn88472.o
+obj-$(CONFIG_DVB_MN88473) += mn88473.o
+obj-$(CONFIG_DVB_MT312) += mt312.o
+obj-$(CONFIG_DVB_MT352) += mt352.o
+obj-$(CONFIG_DVB_MXL5XX) += mxl5xx.o
+obj-$(CONFIG_DVB_MXL692) += mxl692.o
+obj-$(CONFIG_DVB_NXT200X) += nxt200x.o
+obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
+obj-$(CONFIG_DVB_OR51132) += or51132.o
+obj-$(CONFIG_DVB_OR51211) += or51211.o
+obj-$(CONFIG_DVB_PLL) += dvb-pll.o
+obj-$(CONFIG_DVB_RTL2830) += rtl2830.o
+obj-$(CONFIG_DVB_RTL2832) += rtl2832.o
+obj-$(CONFIG_DVB_RTL2832_SDR) += rtl2832_sdr.o
 obj-$(CONFIG_DVB_S5H1409) += s5h1409.o
-obj-$(CONFIG_DVB_TUNER_ITD1000) += itd1000.o
-obj-$(CONFIG_DVB_AU8522) += au8522_common.o
-obj-$(CONFIG_DVB_AU8522_DTV) += au8522_dig.o
-obj-$(CONFIG_DVB_AU8522_V4L) += au8522_decoder.o
-obj-$(CONFIG_DVB_TDA10048) += tda10048.o
-obj-$(CONFIG_DVB_TUNER_CX24113) += cx24113.o
 obj-$(CONFIG_DVB_S5H1411) += s5h1411.o
-obj-$(CONFIG_DVB_LGS8GL5) += lgs8gl5.o
-obj-$(CONFIG_DVB_TDA665x) += tda665x.o
-obj-$(CONFIG_DVB_LGS8GXX) += lgs8gxx.o
-obj-$(CONFIG_DVB_ATBM8830) += atbm8830.o
-obj-$(CONFIG_DVB_DUMMY_FE) += dvb_dummy_fe.o
-obj-$(CONFIG_DVB_AF9013) += af9013.o
-obj-$(CONFIG_DVB_CX24116) += cx24116.o
-obj-$(CONFIG_DVB_CX24117) += cx24117.o
-obj-$(CONFIG_DVB_CX24120) += cx24120.o
-obj-$(CONFIG_DVB_SI21XX) += si21xx.o
+obj-$(CONFIG_DVB_S5H1420) += s5h1420.o
+obj-$(CONFIG_DVB_S5H1432) += s5h1432.o
+obj-$(CONFIG_DVB_S921) += s921.o
+obj-$(CONFIG_DVB_SI2165) += si2165.o
 obj-$(CONFIG_DVB_SI2168) += si2168.o
-obj-$(CONFIG_DVB_STV0288) += stv0288.o
+obj-$(CONFIG_DVB_SI21XX) += si21xx.o
+obj-$(CONFIG_DVB_SP2) += sp2.o
+obj-$(CONFIG_DVB_SP887X) += sp887x.o
+obj-$(CONFIG_DVB_STB0899) += stb0899.o
 obj-$(CONFIG_DVB_STB6000) += stb6000.o
-obj-$(CONFIG_DVB_S921) += s921.o
-obj-$(CONFIG_DVB_STV6110) += stv6110.o
+obj-$(CONFIG_DVB_STB6100) += stb6100.o
+obj-$(CONFIG_DVB_STV0288) += stv0288.o
+obj-$(CONFIG_DVB_STV0297) += stv0297.o
+obj-$(CONFIG_DVB_STV0299) += stv0299.o
+obj-$(CONFIG_DVB_STV0367) += stv0367.o
 obj-$(CONFIG_DVB_STV0900) += stv0900.o
 obj-$(CONFIG_DVB_STV090x) += stv090x.o
-obj-$(CONFIG_DVB_STV6110x) += stv6110x.o
-obj-$(CONFIG_DVB_M88DS3103) += m88ds3103.o
-obj-$(CONFIG_DVB_MN88472) += mn88472.o
-obj-$(CONFIG_DVB_MN88473) += mn88473.o
-obj-$(CONFIG_DVB_ISL6423) += isl6423.o
-obj-$(CONFIG_DVB_EC100) += ec100.o
-obj-$(CONFIG_DVB_DS3000) += ds3000.o
-obj-$(CONFIG_DVB_TS2020) += ts2020.o
-obj-$(CONFIG_DVB_MB86A16) += mb86a16.o
-obj-$(CONFIG_DVB_DRX39XYJ) += drx39xyj/
-obj-$(CONFIG_DVB_MB86A20S) += mb86a20s.o
-obj-$(CONFIG_DVB_IX2505V) += ix2505v.o
-obj-$(CONFIG_DVB_STV0367) += stv0367.o
-obj-$(CONFIG_DVB_CXD2820R) += cxd2820r.o
-obj-$(CONFIG_DVB_CXD2841ER) += cxd2841er.o
-obj-$(CONFIG_DVB_DRXK) += drxk.o
-obj-$(CONFIG_DVB_TDA18271C2DD) += tda18271c2dd.o
 obj-$(CONFIG_DVB_STV0910) += stv0910.o
+obj-$(CONFIG_DVB_STV6110) += stv6110.o
+obj-$(CONFIG_DVB_STV6110x) += stv6110x.o
 obj-$(CONFIG_DVB_STV6111) += stv6111.o
-obj-$(CONFIG_DVB_MXL5XX) += mxl5xx.o
-obj-$(CONFIG_DVB_SI2165) += si2165.o
-obj-$(CONFIG_DVB_A8293) += a8293.o
-obj-$(CONFIG_DVB_SP2) += sp2.o
-obj-$(CONFIG_DVB_TDA10071) += tda10071.o
-obj-$(CONFIG_DVB_RTL2830) += rtl2830.o
-obj-$(CONFIG_DVB_RTL2832) += rtl2832.o
-obj-$(CONFIG_DVB_RTL2832_SDR) += rtl2832_sdr.o
-obj-$(CONFIG_DVB_M88RS2000) += m88rs2000.o
-obj-$(CONFIG_DVB_AF9033) += af9033.o
-obj-$(CONFIG_DVB_AS102_FE) += as102_fe.o
-obj-$(CONFIG_DVB_GP8PSK_FE) += gp8psk-fe.o
 obj-$(CONFIG_DVB_TC90522) += tc90522.o
-obj-$(CONFIG_DVB_MN88443X) += mn88443x.o
-obj-$(CONFIG_DVB_HORUS3A) += horus3a.o
-obj-$(CONFIG_DVB_ASCOT2E) += ascot2e.o
-obj-$(CONFIG_DVB_HELENE) += helene.o
+obj-$(CONFIG_DVB_TDA10021) += tda10021.o
+obj-$(CONFIG_DVB_TDA10023) += tda10023.o
+obj-$(CONFIG_DVB_TDA10048) += tda10048.o
+obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
+obj-$(CONFIG_DVB_TDA10071) += tda10071.o
+obj-$(CONFIG_DVB_TDA10086) += tda10086.o
+obj-$(CONFIG_DVB_TDA18271C2DD) += tda18271c2dd.o
+obj-$(CONFIG_DVB_TDA665x) += tda665x.o
+obj-$(CONFIG_DVB_TDA8083) += tda8083.o
+obj-$(CONFIG_DVB_TDA8261) += tda8261.o
+obj-$(CONFIG_DVB_TDA826X) += tda826x.o
+obj-$(CONFIG_DVB_TS2020) += ts2020.o
+obj-$(CONFIG_DVB_TUA6100) += tua6100.o
+obj-$(CONFIG_DVB_TUNER_CX24113) += cx24113.o
+obj-$(CONFIG_DVB_TUNER_DIB0070) += dib0070.o
+obj-$(CONFIG_DVB_TUNER_DIB0090) += dib0090.o
+obj-$(CONFIG_DVB_TUNER_ITD1000) += itd1000.o
+obj-$(CONFIG_DVB_VES1820) += ves1820.o
+obj-$(CONFIG_DVB_VES1X93) += ves1x93.o
 obj-$(CONFIG_DVB_ZD1301_DEMOD) += zd1301_demod.o
-obj-$(CONFIG_DVB_CXD2099) += cxd2099.o
-obj-$(CONFIG_DVB_CXD2880) += cxd2880/
+obj-$(CONFIG_DVB_ZL10036) += zl10036.o
+obj-$(CONFIG_DVB_ZL10039) += zl10039.o
+obj-$(CONFIG_DVB_ZL10353) += zl10353.o
diff --git a/drivers/media/pci/Makefile b/drivers/media/pci/Makefile
index 984fa247096d..b234a5d78777 100644
--- a/drivers/media/pci/Makefile
+++ b/drivers/media/pci/Makefile
@@ -17,19 +17,21 @@ obj-y        +=	ttpci/		\
 		netup_unidvb/	\
 		intel/
 
-obj-$(CONFIG_VIDEO_IVTV) += ivtv/
+obj-$(CONFIG_STA2X11_VIP) += sta2x11/
+
+# Please keep it alphabetically sorted
+obj-$(CONFIG_VIDEO_BT848) += bt8xx/
+obj-$(CONFIG_VIDEO_COBALT) += cobalt/
 obj-$(CONFIG_VIDEO_CX18) += cx18/
 obj-$(CONFIG_VIDEO_CX23885) += cx23885/
 obj-$(CONFIG_VIDEO_CX25821) += cx25821/
 obj-$(CONFIG_VIDEO_CX88) += cx88/
-obj-$(CONFIG_VIDEO_BT848) += bt8xx/
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
-obj-$(CONFIG_VIDEO_SAA7164) += saa7164/
-obj-$(CONFIG_VIDEO_TW68) += tw68/
-obj-$(CONFIG_VIDEO_TW686X) += tw686x/
 obj-$(CONFIG_VIDEO_DT3155) += dt3155/
+obj-$(CONFIG_VIDEO_IVTV) += ivtv/
 obj-$(CONFIG_VIDEO_MEYE) += meye/
-obj-$(CONFIG_STA2X11_VIP) += sta2x11/
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
+obj-$(CONFIG_VIDEO_SAA7164) += saa7164/
 obj-$(CONFIG_VIDEO_SOLO6X10) += solo6x10/
-obj-$(CONFIG_VIDEO_COBALT) += cobalt/
 obj-$(CONFIG_VIDEO_TW5864) += tw5864/
+obj-$(CONFIG_VIDEO_TW686X) += tw686x/
+obj-$(CONFIG_VIDEO_TW68) += tw68/
diff --git a/drivers/media/radio/Makefile b/drivers/media/radio/Makefile
index 53c7ae135460..615070803429 100644
--- a/drivers/media/radio/Makefile
+++ b/drivers/media/radio/Makefile
@@ -3,36 +3,38 @@
 # Makefile for the kernel character device drivers.
 #
 
-obj-$(CONFIG_RADIO_ISA) += radio-isa.o
+shark2-objs := radio-shark2.o radio-tea5777.o
+
+# Please keep it alphabetically sorted
 obj-$(CONFIG_RADIO_AZTECH) += radio-aztech.o
+obj-$(CONFIG_RADIO_CADET) += radio-cadet.o
+obj-$(CONFIG_RADIO_GEMTEK) += radio-gemtek.o
+obj-$(CONFIG_RADIO_ISA) += radio-isa.o
+obj-$(CONFIG_RADIO_MAXIRADIO) += radio-maxiradio.o
+obj-$(CONFIG_RADIO_MIROPCM20) += radio-miropcm20.o
 obj-$(CONFIG_RADIO_RTRACK2) += radio-rtrack2.o
+obj-$(CONFIG_RADIO_RTRACK) += radio-aimslab.o
+obj-$(CONFIG_RADIO_SAA7706H) += saa7706h.o
 obj-$(CONFIG_RADIO_SF16FMI) += radio-sf16fmi.o
 obj-$(CONFIG_RADIO_SF16FMR2) += radio-sf16fmr2.o
-obj-$(CONFIG_RADIO_CADET) += radio-cadet.o
-obj-$(CONFIG_RADIO_TYPHOON) += radio-typhoon.o
-obj-$(CONFIG_RADIO_TERRATEC) += radio-terratec.o
-obj-$(CONFIG_RADIO_MAXIRADIO) += radio-maxiradio.o
-obj-$(CONFIG_RADIO_SHARK) += radio-shark.o
 obj-$(CONFIG_RADIO_SHARK2) += shark2.o
-obj-$(CONFIG_RADIO_RTRACK) += radio-aimslab.o
-obj-$(CONFIG_RADIO_ZOLTRIX) += radio-zoltrix.o
-obj-$(CONFIG_RADIO_GEMTEK) += radio-gemtek.o
-obj-$(CONFIG_RADIO_TRUST) += radio-trust.o
-obj-$(CONFIG_RADIO_SI476X) += radio-si476x.o
-obj-$(CONFIG_RADIO_MIROPCM20) += radio-miropcm20.o
-obj-$(CONFIG_USB_DSBR) += dsbr100.o
+obj-$(CONFIG_RADIO_SHARK) += radio-shark.o
 obj-$(CONFIG_RADIO_SI470X) += si470x/
 obj-$(CONFIG_RADIO_SI4713) += si4713/
-obj-$(CONFIG_USB_MR800) += radio-mr800.o
-obj-$(CONFIG_USB_KEENE) += radio-keene.o
-obj-$(CONFIG_USB_MA901) += radio-ma901.o
+obj-$(CONFIG_RADIO_SI476X) += radio-si476x.o
+obj-$(CONFIG_RADIO_TEA575X) += tea575x.o
 obj-$(CONFIG_RADIO_TEA5764) += radio-tea5764.o
-obj-$(CONFIG_RADIO_SAA7706H) += saa7706h.o
 obj-$(CONFIG_RADIO_TEF6862) += tef6862.o
+obj-$(CONFIG_RADIO_TERRATEC) += radio-terratec.o
 obj-$(CONFIG_RADIO_TIMBERDALE) += radio-timb.o
+obj-$(CONFIG_RADIO_TRUST) += radio-trust.o
+obj-$(CONFIG_RADIO_TYPHOON) += radio-typhoon.o
 obj-$(CONFIG_RADIO_WL1273) += radio-wl1273.o
 obj-$(CONFIG_RADIO_WL128X) += wl128x/
-obj-$(CONFIG_RADIO_TEA575X) += tea575x.o
+obj-$(CONFIG_RADIO_ZOLTRIX) += radio-zoltrix.o
+
+obj-$(CONFIG_USB_DSBR) += dsbr100.o
+obj-$(CONFIG_USB_KEENE) += radio-keene.o
+obj-$(CONFIG_USB_MA901) += radio-ma901.o
+obj-$(CONFIG_USB_MR800) += radio-mr800.o
 obj-$(CONFIG_USB_RAREMONO) += radio-raremono.o
-
-shark2-objs := radio-shark2.o radio-tea5777.o
diff --git a/drivers/media/rc/Makefile b/drivers/media/rc/Makefile
index 378d62d21e06..be8657391f74 100644
--- a/drivers/media/rc/Makefile
+++ b/drivers/media/rc/Makefile
@@ -2,51 +2,54 @@
 
 obj-y += keymaps/
 
-obj-$(CONFIG_RC_CORE) += rc-core.o
 rc-core-y := rc-main.o rc-ir-raw.o
 rc-core-$(CONFIG_LIRC) += lirc_dev.o
 rc-core-$(CONFIG_MEDIA_CEC_RC) += keymaps/rc-cec.o
 rc-core-$(CONFIG_BPF_LIRC_MODE2) += bpf-lirc.o
+
+obj-$(CONFIG_RC_CORE) += rc-core.o
+
+# IR decoders - please keep it alphabetically sorted
+obj-$(CONFIG_IR_IMON_DECODER) += ir-imon-decoder.o
+obj-$(CONFIG_IR_JVC_DECODER) += ir-jvc-decoder.o
+obj-$(CONFIG_IR_MCE_KBD_DECODER) += ir-mce_kbd-decoder.o
 obj-$(CONFIG_IR_NEC_DECODER) += ir-nec-decoder.o
 obj-$(CONFIG_IR_RC5_DECODER) += ir-rc5-decoder.o
 obj-$(CONFIG_IR_RC6_DECODER) += ir-rc6-decoder.o
-obj-$(CONFIG_IR_JVC_DECODER) += ir-jvc-decoder.o
-obj-$(CONFIG_IR_SONY_DECODER) += ir-sony-decoder.o
+obj-$(CONFIG_IR_RCMM_DECODER) += ir-rcmm-decoder.o
 obj-$(CONFIG_IR_SANYO_DECODER) += ir-sanyo-decoder.o
 obj-$(CONFIG_IR_SHARP_DECODER) += ir-sharp-decoder.o
-obj-$(CONFIG_IR_MCE_KBD_DECODER) += ir-mce_kbd-decoder.o
+obj-$(CONFIG_IR_SONY_DECODER) += ir-sony-decoder.o
 obj-$(CONFIG_IR_XMP_DECODER) += ir-xmp-decoder.o
-obj-$(CONFIG_IR_IMON_DECODER) += ir-imon-decoder.o
-obj-$(CONFIG_IR_RCMM_DECODER) += ir-rcmm-decoder.o
 
-# stand-alone IR receivers/transmitters
-obj-$(CONFIG_RC_ATI_REMOTE) += ati_remote.o
+# stand-alone IR receivers/transmitters  - please keep it alphabetically sorted
+obj-$(CONFIG_IR_ENE) += ene_ir.o
+obj-$(CONFIG_IR_FINTEK) += fintek-cir.o
+obj-$(CONFIG_IR_GPIO_CIR) += gpio-ir-recv.o
+obj-$(CONFIG_IR_GPIO_TX) += gpio-ir-tx.o
 obj-$(CONFIG_IR_HIX5HD2) += ir-hix5hd2.o
+obj-$(CONFIG_IR_IGORPLUGUSB) += igorplugusb.o
+obj-$(CONFIG_IR_IGUANA) += iguanair.o
+obj-$(CONFIG_IR_IMG) += img-ir/
 obj-$(CONFIG_IR_IMON) += imon.o
 obj-$(CONFIG_IR_IMON_RAW) += imon_raw.o
 obj-$(CONFIG_IR_ITE_CIR) += ite-cir.o
 obj-$(CONFIG_IR_MCEUSB) += mceusb.o
-obj-$(CONFIG_IR_FINTEK) += fintek-cir.o
 obj-$(CONFIG_IR_MESON) += meson-ir.o
 obj-$(CONFIG_IR_MESON_TX) += meson-ir-tx.o
+obj-$(CONFIG_IR_MTK) += mtk-cir.o
 obj-$(CONFIG_IR_NUVOTON) += nuvoton-cir.o
-obj-$(CONFIG_IR_ENE) += ene_ir.o
+obj-$(CONFIG_IR_PWM_TX) += pwm-ir-tx.o
 obj-$(CONFIG_IR_REDRAT3) += redrat3.o
 obj-$(CONFIG_IR_RX51) += ir-rx51.o
+obj-$(CONFIG_IR_SERIAL) += serial_ir.o
 obj-$(CONFIG_IR_SPI) += ir-spi.o
 obj-$(CONFIG_IR_STREAMZAP) += streamzap.o
+obj-$(CONFIG_IR_SUNXI) += sunxi-cir.o
+obj-$(CONFIG_IR_TOY) += ir_toy.o
+obj-$(CONFIG_IR_TTUSBIR) += ttusbir.o
 obj-$(CONFIG_IR_WINBOND_CIR) += winbond-cir.o
+obj-$(CONFIG_RC_ATI_REMOTE) += ati_remote.o
 obj-$(CONFIG_RC_LOOPBACK) += rc-loopback.o
-obj-$(CONFIG_IR_GPIO_CIR) += gpio-ir-recv.o
-obj-$(CONFIG_IR_GPIO_TX) += gpio-ir-tx.o
-obj-$(CONFIG_IR_PWM_TX) += pwm-ir-tx.o
-obj-$(CONFIG_IR_IGORPLUGUSB) += igorplugusb.o
-obj-$(CONFIG_IR_IGUANA) += iguanair.o
-obj-$(CONFIG_IR_TTUSBIR) += ttusbir.o
 obj-$(CONFIG_RC_ST) += st_rc.o
-obj-$(CONFIG_IR_SUNXI) += sunxi-cir.o
-obj-$(CONFIG_IR_IMG) += img-ir/
-obj-$(CONFIG_IR_SERIAL) += serial_ir.o
-obj-$(CONFIG_IR_MTK) += mtk-cir.o
 obj-$(CONFIG_RC_XBOX_DVD) += xbox_remote.o
-obj-$(CONFIG_IR_TOY) += ir_toy.o
diff --git a/drivers/media/rc/keymaps/Makefile b/drivers/media/rc/keymaps/Makefile
index 5fe5c9e1a46d..a7e34ed39424 100644
--- a/drivers/media/rc/keymaps/Makefile
+++ b/drivers/media/rc/keymaps/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
+
+# Please keep keymaps alphabetically sorted
+obj-$(CONFIG_RC_MAP) += \
+			rc-adstech-dvb-t-pci.o \
 			rc-alink-dtu-m.o \
 			rc-anysee.o \
 			rc-apac-viewcomp.o \
@@ -9,17 +12,17 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-ati-tv-wonder-hd-600.o \
 			rc-ati-x10.o \
 			rc-avermedia-a16d.o \
-			rc-avermedia.o \
 			rc-avermedia-cardbus.o \
 			rc-avermedia-dvbt.o \
 			rc-avermedia-m135a.o \
 			rc-avermedia-m733a-rm-k6.o \
+			rc-avermedia.o \
 			rc-avermedia-rm-ks.o \
 			rc-avertv-303.o \
 			rc-azurewave-ad-tu700.o \
 			rc-beelink-gs1.o \
-			rc-behold.o \
 			rc-behold-columbus.o \
+			rc-behold.o \
 			rc-budget-ci-old.o \
 			rc-cinergy-1400.o \
 			rc-cinergy.o \
@@ -39,8 +42,8 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-dvico-portable.o \
 			rc-em-terratec.o \
 			rc-encore-enltv2.o \
-			rc-encore-enltv.o \
 			rc-encore-enltv-fm53.o \
+			rc-encore-enltv.o \
 			rc-evga-indtube.o \
 			rc-eztv.o \
 			rc-flydvb.o \
@@ -50,6 +53,7 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-geekbox.o \
 			rc-genius-tvgo-a11mce.o \
 			rc-gotview7135.o \
+			rc-hauppauge.o \
 			rc-hisi-poplar.o \
 			rc-hisi-tv-demo.o \
 			rc-imon-mce.o \
@@ -67,14 +71,14 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-leadtek-y04g0051.o \
 			rc-lme2510.o \
 			rc-manli.o \
-			rc-mecool-kii-pro.o \
 			rc-mecool-kiii-pro.o \
-			rc-medion-x10.o \
+			rc-mecool-kii-pro.o \
 			rc-medion-x10-digitainer.o \
+			rc-medion-x10.o \
 			rc-medion-x10-or2x.o \
 			rc-minix-neo.o \
-			rc-msi-digivox-ii.o \
 			rc-msi-digivox-iii.o \
+			rc-msi-digivox-ii.o \
 			rc-msi-tvanywhere.o \
 			rc-msi-tvanywhere-plus.o \
 			rc-nebula.o \
@@ -87,20 +91,20 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-pinnacle-color.o \
 			rc-pinnacle-grey.o \
 			rc-pinnacle-pctv-hd.o \
-			rc-pixelview.o \
-			rc-pixelview-mk12.o \
 			rc-pixelview-002t.o \
+			rc-pixelview-mk12.o \
 			rc-pixelview-new.o \
+			rc-pixelview.o \
 			rc-powercolor-real-angel.o \
 			rc-proteus-2309.o \
 			rc-purpletv.o \
 			rc-pv951.o \
-			rc-hauppauge.o \
 			rc-rc6-mce.o \
 			rc-real-audio-220-32-keys.o \
 			rc-reddo.o \
 			rc-snapstream-firefly.o \
 			rc-streamzap.o \
+			rc-su3000.o \
 			rc-tanix-tx3mini.o \
 			rc-tanix-tx5max.o \
 			rc-tbs-nec.o \
@@ -109,16 +113,16 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-terratec-cinergy-c-pci.o \
 			rc-terratec-cinergy-s2-hd.o \
 			rc-terratec-cinergy-xs.o \
-			rc-terratec-slim.o \
 			rc-terratec-slim-2.o \
+			rc-terratec-slim.o \
 			rc-tevii-nec.o \
 			rc-tivo.o \
-			rc-total-media-in-hand.o \
 			rc-total-media-in-hand-02.o \
+			rc-total-media-in-hand.o \
 			rc-trekstor.o \
 			rc-tt-1500.o \
-			rc-twinhan-dtv-cab-ci.o \
 			rc-twinhan1027.o \
+			rc-twinhan-dtv-cab-ci.o \
 			rc-vega-s9x.o \
 			rc-videomate-m1f.o \
 			rc-videomate-s350.o \
@@ -128,8 +132,7 @@ obj-$(CONFIG_RC_MAP) += rc-adstech-dvb-t-pci.o \
 			rc-wetek-play2.o \
 			rc-winfast.o \
 			rc-winfast-usbii-deluxe.o \
-			rc-su3000.o \
+			rc-x96max.o \
 			rc-xbox-360.o \
 			rc-xbox-dvd.o \
-			rc-x96max.o \
 			rc-zx-irdec.o
diff --git a/drivers/media/spi/Makefile b/drivers/media/spi/Makefile
index 9f45787d680d..3c7c67cd048e 100644
--- a/drivers/media/spi/Makefile
+++ b/drivers/media/spi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_VIDEO_GS1662) += gs1662.o
-obj-$(CONFIG_CXD2880_SPI_DRV) += cxd2880-spi.o
 
 ccflags-y += -I $(srctree)/drivers/media/dvb-frontends/cxd2880
+
+obj-$(CONFIG_CXD2880_SPI_DRV) += cxd2880-spi.o
+obj-$(CONFIG_VIDEO_GS1662) += gs1662.o
diff --git a/drivers/media/test-drivers/Makefile b/drivers/media/test-drivers/Makefile
index 1e64e05c1f22..b0951a57dcc0 100644
--- a/drivers/media/test-drivers/Makefile
+++ b/drivers/media/test-drivers/Makefile
@@ -3,8 +3,11 @@
 # Makefile for the test drivers.
 #
 
+# Please keep it alphabetically sorted
+
+obj-$(CONFIG_DVB_VIDTV) += vidtv/
+
+obj-$(CONFIG_VIDEO_VICODEC) += vicodec/
+obj-$(CONFIG_VIDEO_VIM2M) += vim2m.o
 obj-$(CONFIG_VIDEO_VIMC) += vimc/
 obj-$(CONFIG_VIDEO_VIVID) += vivid/
-obj-$(CONFIG_VIDEO_VIM2M) += vim2m.o
-obj-$(CONFIG_VIDEO_VICODEC) += vicodec/
-obj-$(CONFIG_DVB_VIDTV) += vidtv/
diff --git a/drivers/media/tuners/Makefile b/drivers/media/tuners/Makefile
index abcad519a4f9..3657e89acdd1 100644
--- a/drivers/media/tuners/Makefile
+++ b/drivers/media/tuners/Makefile
@@ -3,46 +3,46 @@
 # Makefile for common V4L/DVB tuners
 #
 
+ccflags-y += -I$(srctree)/drivers/media/dvb-frontends
 tda18271-objs := tda18271-maps.o tda18271-common.o tda18271-fe.o
 
-obj-$(CONFIG_MEDIA_TUNER_XC2028) += xc2028.o
-obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-simple.o
-# tuner-types will be merged into tuner-simple, in the future
-obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-types.o
-obj-$(CONFIG_MEDIA_TUNER_MT20XX) += mt20xx.o
-obj-$(CONFIG_MEDIA_TUNER_TDA8290) += tda8290.o
-obj-$(CONFIG_MEDIA_TUNER_TEA5767) += tea5767.o
-obj-$(CONFIG_MEDIA_TUNER_TEA5761) += tea5761.o
-obj-$(CONFIG_MEDIA_TUNER_TDA9887) += tda9887.o
-obj-$(CONFIG_MEDIA_TUNER_TDA827X) += tda827x.o
-obj-$(CONFIG_MEDIA_TUNER_TDA18271) += tda18271.o
-obj-$(CONFIG_MEDIA_TUNER_XC5000) += xc5000.o
-obj-$(CONFIG_MEDIA_TUNER_XC4000) += xc4000.o
-obj-$(CONFIG_MEDIA_TUNER_MSI001) += msi001.o
-obj-$(CONFIG_MEDIA_TUNER_MT2060) += mt2060.o
-obj-$(CONFIG_MEDIA_TUNER_MT2063) += mt2063.o
-obj-$(CONFIG_MEDIA_TUNER_MT2266) += mt2266.o
-obj-$(CONFIG_MEDIA_TUNER_QT1010) += qt1010.o
-obj-$(CONFIG_MEDIA_TUNER_MT2131) += mt2131.o
-obj-$(CONFIG_MEDIA_TUNER_MXL5005S) += mxl5005s.o
-obj-$(CONFIG_MEDIA_TUNER_MXL5007T) += mxl5007t.o
-obj-$(CONFIG_MEDIA_TUNER_MC44S803) += mc44s803.o
-obj-$(CONFIG_MEDIA_TUNER_MAX2165) += max2165.o
-obj-$(CONFIG_MEDIA_TUNER_TDA18218) += tda18218.o
-obj-$(CONFIG_MEDIA_TUNER_TDA18212) += tda18212.o
+# Please keep it alphabetically sorted
+
 obj-$(CONFIG_MEDIA_TUNER_E4000) += e4000.o
-obj-$(CONFIG_MEDIA_TUNER_FC2580) += fc2580.o
-obj-$(CONFIG_MEDIA_TUNER_TUA9001) += tua9001.o
-obj-$(CONFIG_MEDIA_TUNER_SI2157) += si2157.o
 obj-$(CONFIG_MEDIA_TUNER_FC0011) += fc0011.o
 obj-$(CONFIG_MEDIA_TUNER_FC0012) += fc0012.o
 obj-$(CONFIG_MEDIA_TUNER_FC0013) += fc0013.o
+obj-$(CONFIG_MEDIA_TUNER_FC2580) += fc2580.o
 obj-$(CONFIG_MEDIA_TUNER_IT913X) += it913x.o
-obj-$(CONFIG_MEDIA_TUNER_R820T) += r820t.o
+obj-$(CONFIG_MEDIA_TUNER_M88RS6000T) += m88rs6000t.o
+obj-$(CONFIG_MEDIA_TUNER_MAX2165) += max2165.o
+obj-$(CONFIG_MEDIA_TUNER_MC44S803) += mc44s803.o
+obj-$(CONFIG_MEDIA_TUNER_MSI001) += msi001.o
+obj-$(CONFIG_MEDIA_TUNER_MT2060) += mt2060.o
+obj-$(CONFIG_MEDIA_TUNER_MT2063) += mt2063.o
+obj-$(CONFIG_MEDIA_TUNER_MT20XX) += mt20xx.o
+obj-$(CONFIG_MEDIA_TUNER_MT2131) += mt2131.o
+obj-$(CONFIG_MEDIA_TUNER_MT2266) += mt2266.o
 obj-$(CONFIG_MEDIA_TUNER_MXL301RF) += mxl301rf.o
-obj-$(CONFIG_MEDIA_TUNER_QM1D1C0042) += qm1d1c0042.o
+obj-$(CONFIG_MEDIA_TUNER_MXL5005S) += mxl5005s.o
+obj-$(CONFIG_MEDIA_TUNER_MXL5007T) += mxl5007t.o
 obj-$(CONFIG_MEDIA_TUNER_QM1D1B0004) += qm1d1b0004.o
-obj-$(CONFIG_MEDIA_TUNER_M88RS6000T) += m88rs6000t.o
+obj-$(CONFIG_MEDIA_TUNER_QM1D1C0042) += qm1d1c0042.o
+obj-$(CONFIG_MEDIA_TUNER_QT1010) += qt1010.o
+obj-$(CONFIG_MEDIA_TUNER_R820T) += r820t.o
+obj-$(CONFIG_MEDIA_TUNER_SI2157) += si2157.o
+obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-simple.o
+obj-$(CONFIG_MEDIA_TUNER_SIMPLE) += tuner-types.o
+obj-$(CONFIG_MEDIA_TUNER_TDA18212) += tda18212.o
+obj-$(CONFIG_MEDIA_TUNER_TDA18218) += tda18218.o
 obj-$(CONFIG_MEDIA_TUNER_TDA18250) += tda18250.o
-
-ccflags-y += -I$(srctree)/drivers/media/dvb-frontends
+obj-$(CONFIG_MEDIA_TUNER_TDA18271) += tda18271.o
+obj-$(CONFIG_MEDIA_TUNER_TDA827X) += tda827x.o
+obj-$(CONFIG_MEDIA_TUNER_TDA8290) += tda8290.o
+obj-$(CONFIG_MEDIA_TUNER_TDA9887) += tda9887.o
+obj-$(CONFIG_MEDIA_TUNER_TEA5761) += tea5761.o
+obj-$(CONFIG_MEDIA_TUNER_TEA5767) += tea5767.o
+obj-$(CONFIG_MEDIA_TUNER_TUA9001) += tua9001.o
+obj-$(CONFIG_MEDIA_TUNER_XC2028) += xc2028.o
+obj-$(CONFIG_MEDIA_TUNER_XC4000) += xc4000.o
+obj-$(CONFIG_MEDIA_TUNER_XC5000) += xc5000.o
diff --git a/drivers/media/usb/Makefile b/drivers/media/usb/Makefile
index 65521f4921e3..f3daa71e8396 100644
--- a/drivers/media/usb/Makefile
+++ b/drivers/media/usb/Makefile
@@ -7,20 +7,21 @@
 obj-y += ttusb-dec/ ttusb-budget/ dvb-usb/ dvb-usb-v2/ siano/ b2c2/
 obj-y += zr364xx/ stkwebcam/ s2255/
 
-obj-$(CONFIG_USB_VIDEO_CLASS) += uvc/
-obj-$(CONFIG_USB_GSPCA) += gspca/
-obj-$(CONFIG_USB_PWC) += pwc/
+# Please keep it alphabetically sorted
+obj-$(CONFIG_DVB_AS102) += as102/
 obj-$(CONFIG_USB_AIRSPY) += airspy/
+obj-$(CONFIG_USB_GSPCA) += gspca/
 obj-$(CONFIG_USB_HACKRF) += hackrf/
 obj-$(CONFIG_USB_MSI2500) += msi2500/
-obj-$(CONFIG_VIDEO_CPIA2) += cpia2/
+obj-$(CONFIG_USB_PWC) += pwc/
+obj-$(CONFIG_USB_VIDEO_CLASS) += uvc/
 obj-$(CONFIG_VIDEO_AU0828) += au0828/
+obj-$(CONFIG_VIDEO_CPIA2) += cpia2/
+obj-$(CONFIG_VIDEO_CX231XX) += cx231xx/
+obj-$(CONFIG_VIDEO_EM28XX) += em28xx/
+obj-$(CONFIG_VIDEO_GO7007) += go7007/
 obj-$(CONFIG_VIDEO_HDPVR) += hdpvr/
 obj-$(CONFIG_VIDEO_PVRUSB2) += pvrusb2/
 obj-$(CONFIG_VIDEO_STK1160) += stk1160/
-obj-$(CONFIG_VIDEO_CX231XX) += cx231xx/
 obj-$(CONFIG_VIDEO_TM6000) += tm6000/
-obj-$(CONFIG_VIDEO_EM28XX) += em28xx/
 obj-$(CONFIG_VIDEO_USBTV) += usbtv/
-obj-$(CONFIG_VIDEO_GO7007) += go7007/
-obj-$(CONFIG_DVB_AS102) += as102/
diff --git a/drivers/media/v4l2-core/Makefile b/drivers/media/v4l2-core/Makefile
index 83fac5c746f5..b7440f0a6710 100644
--- a/drivers/media/v4l2-core/Makefile
+++ b/drivers/media/v4l2-core/Makefile
@@ -3,37 +3,34 @@
 # Makefile for the V4L2 core
 #
 
+ccflags-y += -I$(srctree)/drivers/media/dvb-frontends
+ccflags-y += -I$(srctree)/drivers/media/tuners
+
 tuner-objs	:=	tuner-core.o
 
 videodev-objs	:=	v4l2-dev.o v4l2-ioctl.o v4l2-device.o v4l2-fh.o \
 			v4l2-event.o v4l2-subdev.o v4l2-common.o \
 			v4l2-ctrls-core.o v4l2-ctrls-api.o \
 			v4l2-ctrls-request.o v4l2-ctrls-defs.o
+
 videodev-$(CONFIG_COMPAT) += v4l2-compat-ioctl32.o
-videodev-$(CONFIG_TRACEPOINTS) += v4l2-trace.o
 videodev-$(CONFIG_MEDIA_CONTROLLER) += v4l2-mc.o
 videodev-$(CONFIG_SPI) += v4l2-spi.o
+videodev-$(CONFIG_TRACEPOINTS) += v4l2-trace.o
 videodev-$(CONFIG_VIDEO_V4L2_I2C) += v4l2-i2c.o
 
-obj-$(CONFIG_VIDEO_V4L2) += videodev.o
-obj-$(CONFIG_V4L2_FWNODE) += v4l2-fwnode.o
 obj-$(CONFIG_V4L2_ASYNC) += v4l2-async.o
-obj-$(CONFIG_VIDEO_V4L2) += v4l2-dv-timings.o
-
-obj-$(CONFIG_VIDEO_TUNER) += tuner.o
-
-obj-$(CONFIG_V4L2_MEM2MEM_DEV) += v4l2-mem2mem.o
-obj-$(CONFIG_V4L2_H264) += v4l2-h264.o
-obj-$(CONFIG_V4L2_VP9) += v4l2-vp9.o
-
 obj-$(CONFIG_V4L2_FLASH_LED_CLASS) += v4l2-flash-led-class.o
-
+obj-$(CONFIG_V4L2_FWNODE) += v4l2-fwnode.o
+obj-$(CONFIG_V4L2_H264) += v4l2-h264.o
 obj-$(CONFIG_V4L2_JPEG_HELPER) += v4l2-jpeg.o
+obj-$(CONFIG_V4L2_MEM2MEM_DEV) += v4l2-mem2mem.o
+obj-$(CONFIG_V4L2_VP9) += v4l2-vp9.o
 
-obj-$(CONFIG_VIDEOBUF_GEN) += videobuf-core.o
-obj-$(CONFIG_VIDEOBUF_DMA_SG) += videobuf-dma-sg.o
 obj-$(CONFIG_VIDEOBUF_DMA_CONTIG) += videobuf-dma-contig.o
+obj-$(CONFIG_VIDEOBUF_DMA_SG) += videobuf-dma-sg.o
+obj-$(CONFIG_VIDEOBUF_GEN) += videobuf-core.o
 obj-$(CONFIG_VIDEOBUF_VMALLOC) += videobuf-vmalloc.o
 
-ccflags-y += -I$(srctree)/drivers/media/dvb-frontends
-ccflags-y += -I$(srctree)/drivers/media/tuners
+obj-$(CONFIG_VIDEO_TUNER) += tuner.o
+obj-$(CONFIG_VIDEO_V4L2) += v4l2-dv-timings.o videodev.o
-- 
2.35.1

