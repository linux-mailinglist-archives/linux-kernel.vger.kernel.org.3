Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4E528689
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiEPOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbiEPOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:10:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0F3AA48;
        Mon, 16 May 2022 07:10:26 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lj04u-1nKHo13zmI-00dIkY;
 Mon, 16 May 2022 16:10:08 +0200
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
Subject: [PATCH v2 19/24] ARM: dts: imx7-colibri: clean-up device enabling/disabling
Date:   Mon, 16 May 2022 16:09:38 +0200
Message-Id: <20220516140938.494289-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f4KTShYxaHiJIBPORmg1zxtwPgLmVUsBya8yEKgOKdtcDIxhrHA
 KK6p8q/Z424xAxuGhIMU1g98ApfBG+aGNb1NvvLThFnxXP7WoXrNCI1fw/EX0C88p9qsqqK
 2aXrvEakbUayRIr87JvL01QuQB5UzyLtwjdUrLchAQXwOdz25ahFaX+nz8NuYNssRi1ybIY
 YQvvZ+am18mx6MTtitDAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c9RdkB/YBJ8=:qzurQjombKI4eec/3WsQS4
 tMH0TXcoQjADBqPt+TqQc6lidlGS+uoUjqYx9mIVoEEfsrUTSjt7SXT9XjAkdOl+LRZNMst5N
 qzrqwoyyT3lHxqY9MkkZttxwQ2+fmwA2YSbvmt22s79z7YxTyV7IX5prOCYJQG6HIanoOLmQk
 uN0oJrrwB4VH8VDALYzvblki3lvuJfcxNpJAjaVoYaoXEsNywr+u8Un9/ryuzFxeE3Er+I007
 8QtQzex8L+7uy0GYflL3GTD8li17ZxIsfXqfJmvsj42gmbnaL6qDX+5S2JkG0QvDs5nsBnUd2
 vTDZDze7MBLv30gTawiGuTzGmVs2TkKu7KW/RFW3DqgN6WkU4bmixCkRI/YOdFfOi6fwjzD0R
 QLGmIWgeEoinr7OFtT4Pz9J02m32js0YIeHcXRU3R3G0uZXqaHs4IDP1VbTdq7yT9R3hOldon
 Rj4S1P1T5um5FQDrT8UePJpvvTAtivKY0+yPdNQBKrSEfHYi8uVX2xr5w81yUVKx3xyXz9Ye6
 mDRyrziYHI6gZo3DJuT2MLMLERjWN7Kiyf0dAQ8HWS+5+yzZmnSXgREz0rHvrHlRgUI3NnIVj
 jSYrEvE+wbkSNgpBLTrLdmjaDIEzDv08x/5URvXMp9pblHfYawzNdWbeT9m9bcuOBmcQyN4KY
 QaHr75jPPNrRr/BD6xdv5gLYRi8KHSAWoPuBD8cODz/IcK6NvgeFyBeqdqcwWa8RHyhgNmEjh
 pNLm5BDnasCe1lI49b3TLTJL+KVWDS2dS37XZR/wlNU1unvxml0ei9JKvixV0ATUOyzrSohxa
 OQl8ilN/OinOjka/N6D5eUGw09DpqLIRS9ht7FQH3DEygTTEl2DK6tjpb2zXWc/4iMz1peX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Disable most nodes on module-level to be enabled on carrier board-level.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 1 -
 arch/arm/boot/dts/imx7-colibri.dtsi         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index fea6e4c0d4d6..826f13da5b81 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -44,7 +44,6 @@ mcp2515: can@0 {
 		spi-max-frequency = <10000000>;
 		vdd-supply = <&reg_3v3>;
 		xceiver-supply = <&reg_5v0>;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f29096fca54d..065d8f55f326 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -140,9 +140,6 @@ &adc1 {
 };
 
 /* ADC2 is not available as it conflicts with AD7879 resistive touchscreen. */
-&adc2 {
-	status = "disabled";
-};
 
 &cpu0 {
 	cpu-supply = <&reg_DCDC2>;
@@ -191,13 +188,11 @@ ethphy0: ethernet-phy@0 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "disabled";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	status = "disabled";
 };
 
 &gpio1 {
-- 
2.35.1

