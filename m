Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948805998F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347625AbiHSJoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiHSJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:44:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D24AD63;
        Fri, 19 Aug 2022 02:44:24 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.55.225.138]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MGTcU-1oBnG52lV2-00DHxp; Fri, 19 Aug 2022 11:44:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: vf610: ddr pinmux
Date:   Fri, 19 Aug 2022 11:43:54 +0200
Message-Id: <20220819094354.247273-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+kwEpCR2FMedMP8II0ZiZZWP/w6ychwvgRYCvG4l1RpzTRuEcJW
 U+VeTwdN0SX91wFuVeaJe0mGBABRrDDn0ga+guMmj/apHj7Uhdybn2iq4Rbtz/t05gZSELM
 u+cZzp2FJLruwibDBFUdoadZzTtPlR46PrfxQMTXMwEX4CX3ejQ7zOz8BqtnWXsOliCCJAM
 QsrHow8or+WFQD7FIXZKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3OYq7tY+gQw=:MfcKlhbf3BAUk3g+hI+O9j
 GlhV6wUYW6FkTlP4GBqLbXN8TxdggD0FJMyngKh3bwjZytBDZOAIpgL3d8G+xR3vi2S2mXZHX
 SPsQXeZXata8g0/fUXi8ZCeHs3puyNh47vn6lGlG7z5rLhy1ttBb+YTZ8GKBIfjN6DShyP+Cw
 wdF2MtoTQ0pDAzFjx4rGYAkRywJlj07maGU7hP7foJrBVTrSJ5GAdJ16YtzrGfYl5Fz35z7tw
 2BNd8IiRccMOOqmQa1+MfSodfeyZ0K4+DEeNrttI7e6J0IEqurVpmw+tOVGePa+bi36J96IRS
 9U+KNIIQRWvKYIqArgtEC/Qj5dYPK8DNfb6LtjRrUp/KlIkFoEmGsoNcsq4ON4VMM9sptrbwr
 XF8vBI7GZnvfNP+Up+POhw4NP56mUJXRVwxOw/pZMk9VJwi8vZ9szQKiaZcPSXUJbGIN8IXAR
 /LDpl3JQKWanMIy7mNnYGflygTEEoU+87h6dVe+7hqx+U9CqU2evNK0KwrcYDyk4K1Pe7zHIn
 JO2ERqcSniasWWhsppBau9Uo6RcSpcMjr/shmPMoOs4xnii6YOjZKzbb2jeHtBGjREBCv8cng
 p3KEQyNqDZDax6BXiBx5cyOsu/lWwtCFcrsjA8JFhWrLE1seyPvK/sTGu+M/7yq2n/YdXOWDA
 L/rVLtdDRD92F/XELSQbj5PWn6p9LHMffNsj2QQ9IeSuNxW7VFgbEzddeQFfx6+PGa1+sepdO
 cfB84mJ31mFZENTJE5hBy0eq7EZDOpYkmlNoQb7B7UBt1zOLgQ61pWN8W6I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add DDR pinmux which may be used in U-Boot after synchronising all
them device trees (and includes) from Linux.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/vf610-pinfunc.h | 52 ++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
index f1e5a7cf58a9..b7b7322a2d1b 100644
--- a/arch/arm/boot/dts/vf610-pinfunc.h
+++ b/arch/arm/boot/dts/vf610-pinfunc.h
@@ -420,7 +420,7 @@
 #define VF610_PAD_PTD29__FTM3_CH2		0x104 0x000 ALT4 0x0
 #define VF610_PAD_PTD29__DSPI2_SIN		0x104 0x000 ALT5 0x0
 #define VF610_PAD_PTD29__DEBUG_OUT11		0x104 0x000 ALT7 0x0
-#define VF610_PAD_PTD28__GPIO_66	 	0x108 0x000 ALT0 0x0
+#define VF610_PAD_PTD28__GPIO_66		0x108 0x000 ALT0 0x0
 #define VF610_PAD_PTD28__FB_AD28		0x108 0x000 ALT1 0x0
 #define VF610_PAD_PTD28__NF_IO12		0x108 0x000 ALT2 0x0
 #define VF610_PAD_PTD28__I2C2_SCL		0x108 0x34C ALT3 0x1
@@ -802,5 +802,55 @@
 #define VF610_PAD_PTE28__EWM_OUT		0x214 0x000 ALT7 0x0
 #define VF610_PAD_PTA7__GPIO_134		0x218 0x000 ALT0 0x0
 #define VF610_PAD_PTA7__VIU_PIX_CLK		0x218 0x3AC ALT1 0x1
+#define VF610_PAD_DDR_RESETB			0x21c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A15__DDR_A_15		0x220 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A14__DDR_A_14		0x224 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A13__DDR_A_13		0x228 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A12__DDR_A_12		0x22c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A11__DDR_A_11		0x230 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A10__DDR_A_10		0x234 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A9__DDR_A_9		0x238 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A8__DDR_A_8		0x23c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A7__DDR_A_7		0x240 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A6__DDR_A_6		0x244 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A5__DDR_A_5		0x248 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A4__DDR_A_4		0x24c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A3__DDR_A_3		0x250 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A2__DDR_A_2		0x254 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A1__DDR_A_1		0x258 0x000 ALT0 0x0
+#define VF610_PAD_DDR_A0__DDR_A_0		0x25c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_BA2__DDR_BA_2		0x260 0x000 ALT0 0x0
+#define VF610_PAD_DDR_BA1__DDR_BA_1		0x264 0x000 ALT0 0x0
+#define VF610_PAD_DDR_BA0__DDR_BA_0		0x268 0x000 ALT0 0x0
+#define VF610_PAD_DDR_CAS__DDR_CAS_B		0x26c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_CKE__DDR_CKE_0		0x270 0x000 ALT0 0x0
+#define VF610_PAD_DDR_CLK__DDR_CLK_0		0x274 0x000 ALT0 0x0
+#define VF610_PAD_DDR_CS__DDR_CS_B_0		0x278 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D15__DDR_D_15		0x27c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D14__DDR_D_14		0x280 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D13__DDR_D_13		0x284 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D12__DDR_D_12		0x288 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D11__DDR_D_11		0x28c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D10__DDR_D_10		0x290 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D9__DDR_D_9		0x294 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D8__DDR_D_8		0x298 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D7__DDR_D_7		0x29c 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D6__DDR_D_6		0x2a0 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D5__DDR_D_5		0x2a4 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D4__DDR_D_4		0x2a8 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D3__DDR_D_3		0x2ac 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D2__DDR_D_2		0x2b0 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D1__DDR_D_1		0x2b4 0x000 ALT0 0x0
+#define VF610_PAD_DDR_D0__DDR_D_0		0x2b8 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DQM1__DDR_DQM_1		0x2bc 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DQM0__DDR_DQM_0		0x2c0 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DQS1__DDR_DQS_1		0x2c4 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DQS0__DDR_DQS_0		0x2c8 0x000 ALT0 0x0
+#define VF610_PAD_DDR_RAS__DDR_RAS_B		0x2cc 0x000 ALT0 0x0
+#define VF610_PAD_DDR_WE__DDR_WE_B		0x2d0 0x000 ALT0 0x0
+#define VF610_PAD_DDR_ODT1__DDR_ODT_0		0x2d4 0x000 ALT0 0x0
+#define VF610_PAD_DDR_ODT0__DDR_ODT_1		0x2d8 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DDRBYTE1__DDR_DDRBYTE1	0x2dc 0x000 ALT0 0x0
+#define VF610_PAD_DDR_DDRBYTE2__DDR_DDRBYTE2	0x2e0 0x000 ALT0 0x0
 
 #endif
-- 
2.36.1

