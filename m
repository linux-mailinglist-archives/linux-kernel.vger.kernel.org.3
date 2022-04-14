Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107265008D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiDNIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiDNIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:14 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2165425;
        Thu, 14 Apr 2022 01:51:48 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N5mzf-1o25E042rz-017H8J;
 Thu, 14 Apr 2022 10:51:32 +0200
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
Subject: [PATCH v1 04/14] ARM: dts: imx6ull-colibri: add phy-supply to fec
Date:   Thu, 14 Apr 2022 10:50:56 +0200
Message-Id: <20220414085106.18621-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PbT02YFtJ+vwl/W84GYuhBhNFhO4lR6ScQtLgXPSJRN9ofOjaHK
 Aor4kPAGhl7vSNTOzEtDrmVoVT0ldq5rw9p0Wjc/ZWZjuqJ43k8l5cxZbRo4D8pa9EWgi2/
 0hE4hrXK+/Twk/lcjyexf4r+EnxZ78AQZmsQ4TPa/8jex5Gnb4EatzmOz+MomasXFN3QqCA
 mW/JAmYrWH1W38ZFhBrcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xLiVqhQHKoA=:HZXUik53/ueD6KZs9UZy/f
 FheHxh02hd1ZxfjLNQVjfnZQYrlOlGbRjtBI3SYPluZNu1Gaq6QplGVYiAoIySxvj1lHfM58V
 IfS9tT2Hw9gYqiUi9Xqvrf4uFZ2Xtya2HbLCYvSZFAhGr6AEICepCo+JfV+QhxRgc6hovH5HZ
 0QuRiabIIh0Y4/hR92TvZUXvDUh0OmzHvNRLBHiUe8vnujqomw9TBmIwXaW0SjUbAfY1qpskv
 WuEsRFzLUZGyaKcVBcp99hr8jp+WcHuTkfmmKQMe7Cb67Jo3apprhgkMYQLGY+KMVVhNckPsX
 uHFi67B1nFFC7RUMscuamSNMgUZHwIQqkbJxvwgIZ7CCLnpSQ6oiFQ9MK7OsUKt7fGL/U10vC
 m0jvSEAu6eP4Z2Iscse1TBtvEQ3RQWqjVDe3ZaZ/M2fMbYAq4BGFQjtNjfFVZTxBgaogoFJly
 4HrvAwR6ydMmwFPt8sxkb83QGVuiKfhOhB8XnoVEeTRJkHZt/cKt+lwPZP/m+8mSpBF1gBUKL
 PtuwOMu51qAQgAkZAA+W+H88p5oq3KN3UvHmf61Lnzb45kEGPiKmSbgijejjrHn9kIDMEjtfk
 y3p0GbzGEFZeqf9osLljPl36IhwAbYQMC2zRwdllws0BryhUUGyi5Xe6uu/UZ4MUQc6TBeXKC
 H/GFOnb3WjPC3XUzxY0yPN1+27YEI1edB+fOelQ35wsgQro7bvT3P4y1BzDlfP0ggBOM=
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

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index bea00cfaa820..e619da3b00b3 100644
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

