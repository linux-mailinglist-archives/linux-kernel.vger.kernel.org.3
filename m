Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E648051DC13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442923AbiEFPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442862AbiEFPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:43 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E96D1AD;
        Fri,  6 May 2022 08:29:00 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MdMsu-1oMKdT3TH6-00ZMUS;
 Fri, 06 May 2022 17:28:48 +0200
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
Subject: [PATCH v1 08/24] ARM: dts: imx7-colibri: add ethernet aliases
Date:   Fri,  6 May 2022 17:27:53 +0200
Message-Id: <20220506152809.295409-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PralARl5o4qQHPIuqbUqwDauOLVU7LfUChvAPJiv78F3TE5M6AJ
 iH3efrItR/7j5GfWNCE+DjCfjLjwv1LlpamPC6WvXxQ55NpkZ2zdorM2K8pC7bPn3Hsb7y4
 uNjNpMHtoZWQKB61LbzaVMN3kk+WSBNPK+pyDu9PvbplL+kDAD/SD8OYfVVFjSaGr3AnxZS
 eNCFsHpDiuFDOOXfCi3uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z0WLNH5mE6s=:7RzR7BRhToveoPCVX69iR9
 Y9RjGxTNZhQnkOfBf1uY9liEwpIJBo3jnhPxLMinIEdP4P6+EIGf1RzEg/QR6diPl7d5WWFeJ
 EbAg9mVEWEMpcjF8o8SSoUEMZQUCSHUnemosKcv2PWmjgn0U8TrlXQrAxHI9Q+tNAg6MFgGLg
 2tBaoAH/REKPVvXwnAOJh13YuUaiAFmn4BBECWVj+bFKc0ROMPTEtWAheiH0AdIU/AIMz1WXf
 sI84jOqrsIdtf/dprAs0DAFFgWG/Tec0Ko5BWaqBx35oAxVLZnFxR4nlt2I9qJlQhhVneCPGD
 +S2a9rPnFabUiW+uKVineMU4XC+BiUeE8e8fhCKGNU23Er61Bs3ASZMRmMsJ8ttg8iyYj8dmw
 iM/d6RtjWTy30L1H6Bf6vmnqrr2RYTE+ZbJ4gdMr0XH9ctYMAy+mWjNujZN6v32udhPvsyjkE
 KZ+0XY4qwBxU2SPzwVSjSEUFppGM1Zik/vDqeQ3N7M3wtWIICRkSQ6T57ApUAl8N/kNaYXUYd
 8AHIZgsM2I/8kRNbO8IUhIzHGPRw4XQAYRLff90X6M3pmYkd17kcTf0L9pSVraUn764N9t4D9
 RMy6LRCsDDSdfMmN2Bn8JAJ8TVbKSDRs+V8xjDbdBK74GWDtLJFQBUqFwpmXlUeMbgagobuDZ
 +6gwtduYtG3pAXBZOp422S2gX5j0yvlm5beWam9kjGFc1b7DpdeDty9dlMbpvekhc/4EREE1T
 liH/N/sjqYPs8k5m
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

