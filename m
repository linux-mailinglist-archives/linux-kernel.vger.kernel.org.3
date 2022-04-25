Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96B50E5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiDYQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbiDYQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:34 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF912010C;
        Mon, 25 Apr 2022 09:24:26 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MItSh-1nlULQ4Brd-002Xyr;
 Mon, 25 Apr 2022 18:24:10 +0200
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
Subject: [PATCH v2 01/14] ARM: dts: imx6ull-colibri: use pull-down for adc pins
Date:   Mon, 25 Apr 2022 18:23:43 +0200
Message-Id: <20220425162356.176665-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ioYDyEmp+YzqCsQRQ3ZsrSpMMbKSFnOrfoMcKlNjRnxQYGxwkBf
 Nc75AcaqESLP9FCxwUfDkOYhSIeL+nGlew5otZ3PyVcPt41TsMgtTnAQ2qnW4xzp0cWQ244
 MciDJtjHxM+TLIN1jx8+XTrm+r9HCC+9vpJaQLcCuO0rBiXeDcFPvK0ATkxZzMi1hh9+XK9
 Ad1wL/h6CQ2CI5OsuPOPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaMUM9+/O8I=:3xhg8ACPhzRPpUOC2+rR1I
 IKQFiPACAJqH1hAKRxXo4YzsJx+f5scjdZCjAclwfi9ymhN6Iq4XUd1KFbBQEgoquhdk5p8ms
 GfRWngkq9iX/5X6wQkP3O7+Kp2lfoxn4kpvljp0A00XJWMwMVDH/m81PnM0Opiwu5x8/8/hio
 TPStyYDW8anZebKX9etVpa1Oodm0nVS7Ja3EtV43tEhoR1A79J8M/8mSYeAcpIKBDnXLL4ByM
 uCHmB2xodfdHc+eUmU2S6Mb9zNwDEkShC6FTJTTNj5JTg8WSqsWsCS5H+e3PWHSjFKLTrHNwa
 78fm0dvTC+/qbJHZLI2Fx2YbM/XjBp5uoEwSpAqGlbqgQrLifsHCrj4r9yM+tb5FbNKXbXk1q
 cg9AEd9Lm2auw3Yaoe17F3nert8vqBoUMxaAjqN4TjcLFCn14LyGTD28bKgkQmf8OaDFdlaax
 +ELCZJJkwKB+jvdKDY7I7Z//a3I7sVx+P4JN5PpRBdMCug498IAt1N+eIGKSb5VGFr5ayZJy5
 IaLkLNvwRynrti4NqiO+6GTs1Mp47E3S+hUiA2e1UOTD4EWjuRJZoweop8pzcg5NyX6RtKbSv
 lONSIv8ARwRUUX2qC8YeXBRJmSndnBlNdAyOV6flODYwa2BpJbu7hBkxy7I4HKDl8N6q//JGm
 aGCNVNSeNm0ORKtfBDcIJ0oYmqiyfRqKxte5bPGmuqC/o8Gy9LQn6iTxhfTmneFsgOm8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
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
index 951a2a6c5a65..eb13ed60d2e4 100644
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

