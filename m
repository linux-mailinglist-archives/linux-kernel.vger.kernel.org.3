Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4615008CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiDNIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiDNIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:06 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E23EA94;
        Thu, 14 Apr 2022 01:51:41 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N7AIq-1o1oFJ2LiG-017Xqa;
 Thu, 14 Apr 2022 10:51:22 +0200
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
Subject: [PATCH v1 01/14] ARM: dts: imx6ull-colibri: use pull-down for adc pins
Date:   Thu, 14 Apr 2022 10:50:53 +0200
Message-Id: <20220414085106.18621-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BhzF50BZrqTaFPK0TpbYgRjwA8MPxd+Lqnmvn5FVujauxewFtUF
 HIYR6EiL014ufeAi6FnMd7jSE3ANCnQRdmnGKq+uinhcoF7f8toXm3a7Yl5MBXVrmCRqbC4
 qGjoImiiAZdwibOei2tdiE8by+QASeY5nBpZluVd4hvudr7KT5JpDLI6s7nAOXJtWLIxmGX
 F4eA+tZ/McnYoxpO7rY/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4t6I8We6k4=:4GFKaWyaB/ahbiT3gHFgFZ
 Qnd0pkV+bN2I9uH2u4P3PmOKo6HPLP31ToGdVSUnLT0LKUoR6SqF9y6V5OpCaqQzngg7uVk92
 oOZiEswCcIhS8XeN3mQsdOdx8Kym/Jw8HyrsN31x0AEFSEHYnZ6DTU3oR2BwU7hafDwJZEnmU
 g+riishafP+AVs3mkD6SkT2IFmknINJZVmN8Txysi7qVPH0N53WmVdC7FAl0CzMnwargWAG6X
 EID03O3P5LtUuVBn0yKsQPE10kQExCW9CnccsfCG/rP+BeLLxLxGubwv75skpLID+TGWoXhut
 Q3wmKOhDgIrzCS8QhsCP1dUR6KBWVSBCy65zK97SCgCev3kmqozmsjv4s94qq3lgYp1Cckaut
 Z5TYFzHRw8Y8EhKmjCauLHHvGZPru5ZPDvQCYHXdlDw7+pcKvRQOj+uyBlU5yKS/xfRWz7OGw
 NaO5w0R2RCRWAUh5tDt2pqr3FOWbwxhX1No/OSXPLiJOyVUDVRetNQ8O492AhwH/eCAR732Kn
 knHYMKuxiVE7SgBQdFw3XnLvvcJD2aD/lyt6pG0b9lx6n64qx2GUxcWlPkCFM1v9b/aQG0lmx
 +8Ffw02RIR3FEzN5oS7OKqmk6e4XCVUHaEQuevWUo8E779969kR423hzY+fu531fmhOwElLkO
 AE1QZJvD44qxTgdc/fhbD+JFJOwF2yCOG0uZ6WhqJ/iTc7gF/hsS7Iz1bmY1Sc5S85W4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Disable the keeper and enable a 100k pull-down on the ADC pins as per
the following note in section 13.2 of the i.MX 6ULL Application
Processor Reference Manual, Rev. 1, 11/2017 [1]:

The keeper causes an undesired jump behavior in ADC. To avoid the
problem, disable keeper before starting ADC.

[1] https://www.nxp.com/webapp/Download?colCode=IMX6ULLRM

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 7f35a06dff95..84bb7574d211 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -52,6 +52,8 @@ reg_sd1_vmmc: regulator-sd1-vmmc {
 &adc1 {
 	num-channels = <10>;
 	vref-supply = <&reg_module_3v3_avdd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc1>;
 };
 
 &can1 {
@@ -214,6 +216,16 @@ &wdog1 {
 };
 
 &iomuxc {
+
+	pinctrl_adc1: adc1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00        0x3000 /* SODIMM 8 */
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0x3000 /* SODIMM 6 */
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08        0x3000 /* SODIMM 4 */
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x3000 /* SODIMM 2 */
+		>;
+	};
+
 	pinctrl_can_int: canint-grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x13010	/* SODIMM 73 */
-- 
2.35.1

