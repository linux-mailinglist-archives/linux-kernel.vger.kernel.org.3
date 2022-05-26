Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF008534FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiEZNRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEZNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:17:29 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 06:17:27 PDT
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D93C6E42;
        Thu, 26 May 2022 06:17:26 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.8.20) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 26 May 2022
 21:02:19 +0800
From:   Zelong Dong <zelong.dong@amlogic.com>
To:     <devicetree@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH] arm64: dts: meson: add reset controller for Meson-S4 SoC
Date:   Thu, 26 May 2022 21:01:58 +0800
Message-ID: <20220526130158.36651-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.20]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controller device of Meson-S4 SoC family

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 480afa2cc61f..c750bc60786f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -94,6 +94,12 @@ uart_B: serial@7a000 {
 				clocks = <&xtal>, <&xtal>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 			};
+
+			reset: reset-controller@2000 {
+				compatible = "amlogic,meson-s4-reset";
+				reg = <0x0 0x2000 0x0 0x98>;
+				#reset-cells = <1>;
+			};
 		};
 	};
 };
-- 
2.35.1

