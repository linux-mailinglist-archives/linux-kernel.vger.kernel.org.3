Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A073451D900
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392510AbiEFN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392469AbiEFN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C396972A;
        Fri,  6 May 2022 06:24:49 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MNJ6d-1nkW2F4BbN-006xDu;
 Fri, 06 May 2022 15:24:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
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
Subject: [PATCH v3 03/13] ARM: dts: imx6ull-colibri: add phy-supply to fec
Date:   Fri,  6 May 2022 15:24:06 +0200
Message-Id: <20220506132416.273965-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i+gg0Q5Yg19uEoOY40WleSYcCbwOC5ehyKae/LZurq0GtKO8R7N
 RK+MNbyfcrWTOnHLmmvtC4nmsW65lXkPWa/xSApKZly/5N+vwM+MWnWD2kaVdXvg82No77X
 /Dq4ngQYy3VTSuy3oLVNrg3T5fU9YgH0l1/xAoisnTRm1nwtcK5H8ESnneuc65piP90mnIX
 Xf65JUYmChUr0JoSWeKbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YPzXNKuG/3c=:/X3uR9GCNWIyrIRw5RBvQU
 UP2kcPlYBpas9PDKcJynfsO6oRi+MWco2hwpUP54LzxCLBeXeeO5mmj2WKNtpkt9QRCJYx1VJ
 aIgQoLAJK/HOicpTcJoKFi+KDm4684EexEnjDC1Jc1Nx5p5y4IZ/2S+PTzK+Z13Rrv/zO5THT
 FaWz1HHkYSGyJ1SaFw9tcE80A+YRrNe1H0FzS6A57itJx04XCWr2riyQ278l4YDpdZLfOuqlR
 cmM/qSM2ENavPhvVWbJS4n/TDsgePak3f7nAvBhM+QGV/WjsX2cWuCrazv8s1r+hQYnsY2LI0
 lTwt84Rayi4Iw+fR6DGHi805Rp7AZfpvi0EbqMr+WQQp0IkyDTJz1DzyuQqNBmSk8LENZGScj
 1WYme0FyGIT3V1XimwXkLn7QS6qcwmmelUCszvvKdTza4uxmGpQMxj/vrbac6pNvimGFr2oXO
 lLGuJx8dXDkYQCU16o3CBib5j0jwWRfqFeF7rGb9WDj0pyScyNRRBbbFzxuLuFZb/M6BqggUH
 kacZ4IY3ySJ2J66dfESyZq4H+NkX/4TPsE0DUhCJoyWufJnHw/wwNB6+aVNbhy7L0FZxVqqp2
 QiCXtMl83sgiilIGiWmI9KkJitthpQemGnbm0NnP8Y+i/7574/wLHPVnOC0pltYr2hqslOwWK
 DFv2kgm5b9Zmpl9+ESOhalNMPZESC1thEgMmMLu7fzosj5nbwVcRRhn0WjKBR0BZI7mE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This adds the proper phy-supply to the FEC. This supply is actually
switched by a clock that is now properly stated. This has the advantage
to add a delay for that particular regulator which is needed.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index dc947035495b..7cd912df5d19 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -47,6 +47,18 @@ reg_sd1_vmmc: regulator-sd1-vmmc {
 		states = <1800000 0x1 3300000 0x0>;
 		vin-supply = <&reg_module_3v3>;
 	};
+
+	reg_eth_phy: regulator-eth-phy {
+		compatible = "regulator-fixed-clock";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "+V3.3_ETH";
+		regulator-type = "voltage";
+		vin-supply = <&reg_module_3v3>;
+		clocks = <&clks IMX6UL_CLK_ENET2_REF_125M>;
+		startup-delay-us = <150000>;
+	};
 };
 
 &adc1 {
@@ -81,6 +93,7 @@ &fec2 {
 	pinctrl-1 = <&pinctrl_enet2_sleep>;
 	phy-mode = "rmii";
 	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_eth_phy>;
 	status = "okay";
 
 	mdio {
-- 
2.35.1

