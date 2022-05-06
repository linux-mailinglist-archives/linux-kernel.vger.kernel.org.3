Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21E751DC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443067AbiEFPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442947AbiEFPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:33:08 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BE6D4CF;
        Fri,  6 May 2022 08:29:23 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mde05-1oM3eq45Mv-00ZdTN;
 Fri, 06 May 2022 17:29:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 15/24] ARM: dts: imx7-colibri: disable adc2
Date:   Fri,  6 May 2022 17:28:00 +0200
Message-Id: <20220506152809.295409-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gs+o33e0av+49MlbiGdcvNvTMn81YyAmf9sqr1EWHP0Ruqe9G8V
 n3qpKkkri+qmw+ImwaCGKqOvK7SzZ1VhM5dBvfvekAd+hwnTJiN87j3Wz2J9IqrgTbYKegf
 tuIwUWJOCyjXgBBdATA6vKXBH9FZtihaxRxbaK64/uo3AhA+FRqSrT/t2mtJ1HWdnkJvsAh
 q4cF+OOLQmTwlJTlsNs/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYbCvDuXquo=:PAHMVa0aikw0+D748eFZ4m
 IF3fNqWYNs+jvmoYNs4FpC3XnXbJdect5hOaPGlxiqPY+atvX7cf4SHNMB12PfHVXAXWbhsy5
 NXO3GIqDnT0m0alj5Rn4azZBuGeF0zA571SviorjHqXp30THuqYo0RDIVqukUg00a8X0z6OfZ
 aDYSeVuP9IM8Fm5psA87LzQAPdtSh+SisHFUXPFf7nuJYA3j7G1ef9zQL5OD/hlUyLifmV4F5
 fVcjvfdsM3vKDH2YMNBwaEX1Hma4eG/cKrb6zQT2UI0kbVISaD+YFb7jouSpq0Ie4Nf+oFAfG
 j6f/uJCplCC5HeWfwoqmDRZUmvRxaXgoyZaF3asyPSMGWRSYIjbzo7u9xHnr7cybEYuoWXSmV
 LYHDAjw/QtB3VQBF1dppQ6jyY+wqEgqR3vrMFXZNlOTWv6ywRbTbn2E4Xs8jBiwsWN5aZG04r
 Gs53yYvtcM9Te852CeSMECvaAOHlBLMlrVbUVtPAKCZ8/VlE4aSb3cDqXqrQk0K9pWXJyefsN
 qSoLhgDfwjaAXZuyvFT6FxGf9AR/49K+I1TXpJFt1LE+sH3FxRmHu3ATLaoo95m9vno74QCPO
 Bgd+hNZA4DkMsAMNoFFRFo93tBob7NUznUJLxP99nYXvTZGw+ipmuqYzfzwpFKskIGTz+Cmjr
 vUgamscyOfAfLollV/+Wam0Ijol+0r7/HCov1ON5CbFH64n3kYEVDw2jkCGQAH+SpbiI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

ADC2 is not available as it conflicts with the AD7879 resistive
touchscreen.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 8 --------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 4 ----
 arch/arm/boot/dts/imx7-colibri.dtsi         | 3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index 9796bfabe241..a89c868ff3ed 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -7,14 +7,6 @@ &adc1 {
 	status = "okay";
 };
 
-/*
- * ADC2 is not available on the Aster board and
- * conflicts with AD7879 resistive touchscreen.
- */
-&adc2 {
-	status = "disabled";
-};
-
 &fec1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 069f56272546..6ae38c1f38d4 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -16,10 +16,6 @@ &adc1 {
 	status = "okay";
 };
 
-&adc2 {
-	status = "okay";
-};
-
 /*
  * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
  * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index da3df00c7d67..0fc4b33d97be 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -137,8 +137,9 @@ &adc1 {
 	vref-supply = <&reg_DCDC3>;
 };
 
+/* ADC2 is not available as it conflicts with AD7879 resistive touchscreen. */
 &adc2 {
-	vref-supply = <&reg_DCDC3>;
+	status = "disabled";
 };
 
 &cpu0 {
-- 
2.35.1

