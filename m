Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47EC5285EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiEPNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiEPNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:01 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0D3AA72;
        Mon, 16 May 2022 06:49:03 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0fge-1nbord2lCw-00uoTl;
 Mon, 16 May 2022 15:48:52 +0200
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
Subject: [PATCH v2 15/24] ARM: dts: imx7-colibri: disable adc2
Date:   Mon, 16 May 2022 15:47:25 +0200
Message-Id: <20220516134734.493065-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UCzKwp417L3+0KQVmWWfLw5+flFvh9WL5KMFeTAcdbfiXkn2kw5
 t0CSb00CXI8Z0k9AFraAesMKF4ZDJr/R0uFLMULgwxQHusfYA0etWsC+hLLD/+S1jEUIiB0
 Rf/CBnkL8cRyZr6w8jejnBFlzBzkfosun1zvz4+c7ljGJgE7wWTWk47/QxulH/U8gsTpXYd
 H17PB8TFLLl+lPFA15q3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uPvbg2xJebk=:hiHbPKPtgtHieTIPfbfaVQ
 P2fvatHfkxZJqNEs+xEKvP8BeL8m5FoBFHEG1rsaN6ptdvZtbHczFC5WUc68j3HeJk6VwiF8U
 izk56jzCbWc+gPVEUGVF/7WKc7RZBRnPXCw7lIkdYujs+PWt/ATGqh2CHjic+5fQqBekxOKg1
 QAQJ52a/P3rlyvGCdKyQez2LNOmYqHkaSvvKPi1SuraI2iWA3451/rnq3/Vv4F0zPXxQuK9Rq
 vzzLUwVh+VQVD9Myg0TU2JAlvTxMOZk+oDqfC+YxVh6nOSu6xqIygsytDUpwWNAXVRKX8RgwM
 NV0zb6/KNs8gL9UYGbuH3lylTKn5zh+PN2kV9ZgoJjsaJeKbcRtOze5b1eSFv58Rj52gv37oC
 /x4MwuZlesOrZUX2V+g2S9K1z4F0hqrURxdXde541ePvRougfaYkjgNdhsxgOVsZ+wwRsa9/m
 o01hB/XCqAeta6XVxHvxcTybp0UY/PQDasni2u6YVaBcXN0aXXS6yFtpLq5A/NMM7Cpr4I25J
 aRUQROkYTvftp4nz5mUnx7CkNYTrvK1n58Hd86YYoy+kF9MsPmtcZyXXjfKnnj1MMdjgTqjxR
 k6LZyAfICqXcvxkXkRsW76oxYVVeGkc0YgwlhY+KlDXE8YExPx/Mg0R6ebKpogf2HaUU5d+i4
 zehDqb7UUHOarjDSC/g8/IB6ONxnQirvGuYLz4Frb9pB6zoGwvXXrf3wtyE/5of/Du+qcaERX
 b/qsC+g+PIfxCAJB
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

(no changes since v1)

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

