Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BED51D8FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392504AbiEFN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbiEFN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:31 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15686830B;
        Fri,  6 May 2022 06:24:48 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M6Bzg-1o39Hj1CFG-00y5m5;
 Fri, 06 May 2022 15:24:29 +0200
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
Subject: [PATCH v3 01/13] ARM: dts: imx6ull-colibri: use pull-down for adc pins
Date:   Fri,  6 May 2022 15:24:04 +0200
Message-Id: <20220506132416.273965-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3VT8w+ktg62MV0eMvjsS2ZfZOqDK2QgsLt+GERFnFjSfhXnZQzg
 gUmsqNMOdt6h7gfCMPj+/PVDT+3mhNw+KenhnnP+l/LtMqnF5UfJBXVNQW7mt1B5UyebP8u
 W536co2WvoBnF0BPvMHmejd7o1xf6H/YJC69kaQIghNFVBrUKVBuTv6pkTn350leZQxj4Uo
 u2cJ9BQzVVoSHeoi1o1Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RNH7X0xkl8E=:Le5VvuRgBR4dLEQ26ZYmdY
 BiqHApNqGiJ8wv7tyBi5MRJ92I8SwLkHf0vzA2WsmebcihmSWzGhqSvoNJ+Facza0Q7O3W0IC
 hEasZC16jJPr8nYbSpMteQrFTahwX5Xx/YcrVDeNvADNbeSvmzBVVJm7KiYVBXob3c+GdX3El
 6RNE29X4CX6hga0JyhAXTWgt2/Y0rr86CmSpAybDixFKzlxiRYmLuW9pt/EX2hPW1xC37C++E
 IsklCq54k+s0zD8WPmt0qq/+Cg5+YpbDP3jEbeouo7thlg37kxLG3aZOG6Os9KNuGgU/659x5
 QxwE2iWG+d+PqNii1PA5bGRpyaLnrU+pK0DVaCP3y/u904PDylVttxYutrrzibJw51MPinKPP
 mth2SQfLa2SsBrAQbKA6Jja5h9m27jPQAXbpyWH37vm69ShRIqZR/fx3Xrius74r/XKIHYHRj
 C4i7uwmpob4hGLV36YDrihfEICf5CbY34A5Iu+quezecXI49PtdSO/cWFj9R2ZJ78tXTFwMjD
 r4xvYQlJUGw8eAPY3+Hm16SO6dNccgu4r5tPxVs1g/8Toxz3PLWs6hBSc4Na0W9ZBxuSvYUeG
 rxWxEaKtpgMz6mK4AQOS/r6DI4MOBGlHJGD/r3dq9d/oIfeA+DC+fjwsAQ1mOwcnxumA7C8Je
 uSZENBIYxNvd5gSkjF/XfTGBzs79MG2NppTp1LpP40PVecBpbuaDeDnrjze40ig3PYNY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

