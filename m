Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4B5285DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiEPNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiEPNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:49:03 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036153A198;
        Mon, 16 May 2022 06:48:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5ukJ-1nfw1Y1Kpt-00xosc;
 Mon, 16 May 2022 15:48:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] ARM: dts: imx7-colibri: add ethernet aliases
Date:   Mon, 16 May 2022 15:47:18 +0200
Message-Id: <20220516134734.493065-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:06s0GLfGsN4wSHAFVUljIbyxlOAiw6HaWWbYqR+39cEKSNe34Be
 gZcUEh62acuDbWmkKiW4qxbP9+YRWf2BNVykJksEFp/gWEJ+NCEUtoJOuJb1fwgXKCM+Dwg
 3LWI1VtEcnCnHS7MTf4gmJV4qsDYD+wwSQrmeM/hIKpqewWTnILOSieRm3AWpDZz9Ec+RfK
 eIPrN1+9wwhwN9umlnnag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kas3Xe1GRJ0=:zBPXG2E4kc1dWsy5SN+38P
 zLSqfi3h6mFDcFq1+nleUcCbmd4fLTJI7/w/yaQaJ3jsib3r67ojN0mUWiugAdEXNMF0kGPQD
 JveF0BW1DOwZRE13dQ/PQ4z4+ps8q1YVJoX2+YZwspKlpBwe9bj77ZXxXzV0BV0zjpCiA5h9E
 GMP40zFt0TWxOhU0Z8FFzYTZCKd4K/ozDGZg+Y2RTcP4UkvrAC8m9MJp6vzCY8A1Rp1lXtRmB
 sOEHMDQHfj4K4yQ8ST/B36tpUymercbdsgIDPghqnbaNjGUbDBYjdei7rqddA08tgo53lEBgo
 l1ae+XOUYFDPfVDuHyt/BCepp+SBTazk6zUd4NxwMMH6meD51Q5ALVXkf7KrOM1kunAON+oL3
 Ckv6/OLXDjMrakeja/Vv6p7mwIZy3HvHiXPUFXz1WYujliVvBm0HqWtnGtKvG+WkHtDdvkFkA
 3ioqPuCO54XKtuI1/2/neE2ARa6FNht3/iPw5IoRHQupWANObB3rO3EWQmOnVbsKLo1v9v7Qm
 eq9BVTkTY5HYfFEaAFMdKOGUuuw4ssyuopQ2HcCKltRAQu8u5K8THyAY21HeYcY74pWVXlKlt
 Q44VzYUn5o4MRs4J48YPYlK1nfv2KZ1a88kS03ccb+SL+TVGei7Dlfcf1m8Q7J8fJsUqZEQM4
 l/W4q7rTYWGCvx2vDtWnvd3uVnQ8DyZ8sx/TcqU2eSJebqksNZNLgue/lXJ7qPsLvDzHOUX1U
 KsqtH166pS7MP8Kj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Add Ethernet aliases which is required to properly pass MAC address
from bootloader.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi | 6 ++++++
 arch/arm/boot/dts/imx7d-colibri.dtsi      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 198e08409d59..e77f0b26b6fb 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -7,6 +7,12 @@
 #include "imx7-colibri.dtsi"
 
 / {
+	aliases {
+		/* Required to properly pass MAC addresses from bootloader. */
+		ethernet0 = &fec1;
+		ethernet1 = &fec2;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 90d25c604de2..48993abacae4 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -7,6 +7,12 @@
 #include "imx7-colibri.dtsi"
 
 / {
+	aliases {
+		/* Required to properly pass MAC addresses from bootloader. */
+		ethernet0 = &fec1;
+		ethernet1 = &fec2;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
-- 
2.35.1

