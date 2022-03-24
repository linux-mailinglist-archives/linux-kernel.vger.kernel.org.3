Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE994E668B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351467AbiCXP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351457AbiCXP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2009AC938;
        Thu, 24 Mar 2022 08:57:22 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MiJ6Q-1o1VSB08ta-00fO2O;
 Thu, 24 Mar 2022 16:57:05 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] arm64: dts: imx8mm-verdin: multi-line comment style
Date:   Thu, 24 Mar 2022 16:56:41 +0100
Message-Id: <20220324155649.285924-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wvi0prXOYPBSWTZce9X2feg/3PZvyzv+6A/IKxq+AX1CZzBajY/
 c42xNq0r81Bz5yD1UY7PCNe3bdqp6F5JWmFm3mEd/YrEPAZmgrEOJepCdUIoiz+RuBkyXlV
 A8eN8lcyuQ1XKQ/H95nEDAju0WZ9mTQZXyDD/ncUQ4N0nj0Ec7QKSCJUk6uT/afabWi7xsK
 Oo9Chq4We7LeCqYtSKKlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MAC35HeqeY8=:D9Ivn30Ph/CSMvH/LzqsMy
 nqhkBa5xClyfLZJ64o3AvAIwXbPwXI6Am3B7UiIdfB4ncacpGyDk+6OGvOfoh2/V8mFUS/7Kc
 6qIyDYa4GCdSZpTjhELGlz91l9sDU6s++ORVPQc3uBuJi3iII9SXI9M2zcuaqPbLZTiPbcDHC
 dy1H55VVzSzd7/H2XfzeHHUx46RK40JyRIWymOJlEBl+98ZGA7d3XUl6Jg5RavHjmCOqw74w4
 2BXej/VBPp4As1oxiKaJ5ybPhKPThwkj6zbBtJfG6UO/u7SggIBYdSCHbUBFcySM4TbUZL+za
 nj2Gtv6OkpQCpYX50ohmRBFsHrOTgNACXmkxKAakEHH7BzVoYJrkEtwc0D1J3x8wIo7hJuftU
 KBrac85RxhsGaWjL7feWPiRfzMRvO7wueUkm128wCIpgiyyxftjdPdBL3ygYpRCFAaxMLmLgl
 w6AqpICGB+yD2JBPdwr7Vy4kkFSbB9c3R3dU/VMLIj6jZUqGjOv8SJ8XQ6VszCfdjsheNX5cL
 b4/QTIj0Z2h/M/81/uxaRhXIbnvWmHo7sqNWMGJXNPrDu94Vm0iJ3CjmPDNo0X2SEYSCinuU6
 If13vnnFkJbmnk4LOYD0Yj2Urdfy5QnXzpXB9VqSB99RLROFdafHf9gb2iSlqPxsSiaHDpnyQ
 meRN1HS+GkM54n5jYS+btjESlztDTlCR+dZNv+ep4Vps2Iqw3Nbsxccx3vjNQ0xDKdAc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix multi-line comment style.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index f70782d2a23d..de811be435d0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -580,8 +580,10 @@ hdmi_lontium_lt8912: hdmi@48 {
 
 	atmel_mxt_ts: touch@4a {
 		compatible = "atmel,maxtouch";
-		/* Verdin GPIO_9_DSI */
-		/* (TOUCH_INT#, SODIMM 17, also routed to SN65dsi83 IRQ albeit currently unused) */
+		/*
+		 * Verdin GPIO_9_DSI
+		 * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI83 IRQ albeit currently unused)
+		 */
 		interrupt-parent = <&gpio3>;
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
@@ -695,8 +697,8 @@ &uart3 {
 	uart-has-rtscts;
 };
 
-/* Verdin UART_4 */
 /*
+ * Verdin UART_4
  * Resource allocated to M4 by default, must not be accessed from Cortex-A35 or you get an OOPS
  */
 &uart4 {
@@ -1205,8 +1207,10 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
 	};
 
-	/* On-module Wi-Fi/BT or type specific SDHC interface */
-	/* (e.g. on X52 extension slot of Verdin Development Board) */
+	/*
+	 * On-module Wi-Fi/BT or type specific SDHC interface
+	 * (e.g. on X52 extension slot of Verdin Development Board)
+	 */
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =
 			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190>,
-- 
2.34.1

