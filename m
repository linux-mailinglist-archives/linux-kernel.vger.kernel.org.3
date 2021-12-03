Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62854467927
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381365AbhLCOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381241AbhLCOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:14:11 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCCC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:10:47 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by laurent.telenet-ops.be with bizsmtp
        id RqAl2600P3eLghq01qAlpX; Fri, 03 Dec 2021 15:10:45 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9Gv-002Lro-4Z; Fri, 03 Dec 2021 15:10:45 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9Gu-000ll4-JI; Fri, 03 Dec 2021 15:10:44 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2] ARM: dts: motorola-mapphone: Drop second ti,wlcore compatible value
Date:   Fri,  3 Dec 2021 15:10:43 +0100
Message-Id: <17693a54a471c50d2d091d7a65f6571e7b0f7c51.1638540458.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI wlcore DT bindings specify using a single compatible value for
each variant, and the Linux kernel driver matches against the first
compatible value since commit 078b30da3f074f2e ("wlcore: add wl1285
compatible") in v4.13.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
v2:
  - Add Reviewed-by.
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index a4423ff0df39264b..c7a1f3ffc48ca58e 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -310,7 +310,7 @@ &mmc3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
-		compatible = "ti,wl1285", "ti,wl1283";
+		compatible = "ti,wl1285";
 		reg = <2>;
 		/* gpio_100 with gpmc_wait2 pad as wakeirq */
 		interrupts-extended = <&gpio4 4 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1

