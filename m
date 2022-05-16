Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957955285D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiEPNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbiEPNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F63917D;
        Mon, 16 May 2022 06:48:27 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lb44F-1nSr6m1rWT-00kk0I;
 Mon, 16 May 2022 15:48:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
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
Subject: [PATCH v2 06/24] ARM: dts: imx7-colibri: improve wake-up with gpio key
Date:   Mon, 16 May 2022 15:47:16 +0200
Message-Id: <20220516134734.493065-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/ponqe1H3vjWt2YFBxn3029qEl7K0GNOHiM0G3kQYKbz8vORuas
 vNCrh8JPHZ/po0uB1H2UhjIayfrRD8thP/SvG4HQYeO3NPIqgL6guVInHsIR7QM9A93A+EH
 tjOzBOips5ct+XLosB9wBd3b/DO+uzPETN+oGZ1otJLAqtRjfIxrW5drSW+iYmm8Nj98ca9
 Jg7Y/QlMhMcJYmPheW90g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6RXeQ9k9M8=:s2u3Y6s22Dh8v2+pj97wU9
 b8RT5XGKR0yDuLGGAtBaTsqicUwhl5fbYFkNvZSmegSnqF3eq5wclmhvhicuDYUhhEefnPbg8
 9LJw0d9tPFjcTOcHWD/bK/2jGV62Xl0Km24m3++L/WVgPS2BpextPxiB0EZCKRnhyuoM1z1xP
 VgH5A3MsaSZuJ68G7P6MN/BlsSAKJdGPdxaONcaH2NabbomQN1ZFvTuz5gqtuvsBA4HDZSuP9
 nvzpSFeShokPTvB+9BA1NqsZ67rDayvWtVfx1R76+lo46WA/JMcVPK67t231GDkw695llMKua
 tDVdd8n/vhSB9oAvyHu+SqzduxkzMyJlMaypnNwV6V7G3ZbyU5He0x+WEQatLTuGy2lAdhxUH
 anLac2pj4M30BS89CO7zJhasWNjH1OlB2KK0qmrzLqCfrgcVRJ8qq3TOvn0sl1Qat4Hl+7x2X
 R/NsFVMcaQIPNyV0ofd56ZH28oJRnbtfLle3CZleBnO+dhdjtcZz8Nv3d5y2mNHhK6L4MH32w
 iKZO+fpyBoJLwahzmdUrnLC573TwhA+0/0MeyEN0fyFntbEB9dChUMfVckct9W5inc0Cq0yBs
 u7J0EwjiVvY4aROIusVm0/bnDdBY3geM/UG7L5WNL27ZTibs6dknuVXlzxLqqjG5OJb6Cc4BD
 wRMJPa+JpotSsCPeN2C2Tb+jE6OJwJKKhUiZxWqDVpdm2VGqdlQPHnnhgXLzk1z+M87/vAVZK
 K7DkVbvrPmyeuJvx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The pin GPIO1_IO01 externally pulls down, it is required to sequentially
connect this pin (signal WAKE_MICO#) to +3v3 and then disconnect it to
trigger a wakeup interrupt.
Adding the flag GPIO_PULL_DOWN allows the system to be woken up just
connecting the pin GPIO1_IO01 to +3v3.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 2 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index bfadb3a3124a..9148c54403f3 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -15,7 +15,7 @@ gpio-keys {
 
 		power {
 			label = "Wake-Up";
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
 			linux,code = <KEY_WAKEUP>;
 			debounce-interval = <10>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 074c96f09191..4a7e593e9ac6 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -34,7 +34,7 @@ gpio-keys {
 
 		power {
 			label = "Wake-Up";
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
 			linux,code = <KEY_WAKEUP>;
 			debounce-interval = <10>;
 			wakeup-source;
-- 
2.35.1

