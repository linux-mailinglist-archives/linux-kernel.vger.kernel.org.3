Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FF4EEBF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiDALFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbiDALFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:05:05 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123426F907;
        Fri,  1 Apr 2022 04:03:15 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 1 Apr 2022
 19:03:12 +0800
From:   Shunzhou Jiang <shunzhou.jiang@amlogic.com>
To:     <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <narmstrong@baylibre.com>, <khilman@baylibre.com>
CC:     <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shunzhou.jiang@amlogic.com>
Subject: [PATCH V0] arm64: dts: add support for S4 power domain controller
Date:   Fri, 1 Apr 2022 19:03:06 +0800
Message-ID: <20220401110306.3364551-1-shunzhou.jiang@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable power domain controller for Meson s4 SoC

Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index bf9ae1e1016b..96ea95ea5eb9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -60,6 +60,12 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	pwrc: power-controller {
+		compatible = "amlogic,meson-s4-pwrc";
+		#power-domain-cells = <1>;
+		status = "okay";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;

base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915
-- 
2.34.1

