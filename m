Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526E04698D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbhLFO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:29:43 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:13946 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344259AbhLFO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:29:40 -0500
Received: from localhost.localdomain (unknown [10.0.30.84])
        by uho.ysoft.cz (Postfix) with ESMTP id 9136EA22D9;
        Mon,  6 Dec 2021 15:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1638800769;
        bh=EwWBPVjwFWUEpxAXGfNoM0zA1YudXlRd/su3eJhTQA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jug6j8+QHhumQGEgLs4N8AluV4gN7a/8iR91CZ7EU/8yiN7jy+FtggLMNG3gpMMHl
         t6yT9lNNaiVpzWZHm5r+F2tAPxXMotz4Vjd4JCtQmb+3UMcOcu+kYoIZ8as8JdqzqU
         Fx2ORqBU32uOE92UBWGtloSDpCJfIcs1EYOP/l3E=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Remove not-yet added support for sound from Crux
Date:   Mon,  6 Dec 2021 15:26:01 +0100
Message-Id: <20211206142601.373807-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202112061855.SidQyicE-lkp@intel.com>
References: <202112061855.SidQyicE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mistakingly added support for audio codec. We support the coded
by our downstream patches but the appropriate driver and bindings are not
in mainline yet.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a4d744ac2bab ("ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ board")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6q-yapp4-crux.dts       | 22 --------------------
 arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts | 22 --------------------
 2 files changed, 44 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-yapp4-crux.dts b/arch/arm/boot/dts/imx6q-yapp4-crux.dts
index deb18c57cf18..15f4824a5142 100644
--- a/arch/arm/boot/dts/imx6q-yapp4-crux.dts
+++ b/arch/arm/boot/dts/imx6q-yapp4-crux.dts
@@ -17,22 +17,10 @@ memory@10000000 {
 	};
 };
 
-&audmux {
-	status = "okay";
-};
-
-&codec {
-	status = "okay";
-};
-
 &gpio_oled {
 	status = "okay";
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &leds {
 	status = "okay";
 };
@@ -49,16 +37,6 @@ &reg_usb_h1_vbus {
 	status = "okay";
 };
 
-&sound {
-	audio-routing =
-		   "Ext Spk", "LSOUT";
-	status = "okay";
-};
-
-&ssi2 {
-	status = "okay";
-};
-
 &touchkeys {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts b/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
index a450a77f920f..cea165f2161a 100644
--- a/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
+++ b/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
@@ -17,22 +17,10 @@ memory@10000000 {
 	};
 };
 
-&audmux {
-	status = "okay";
-};
-
-&codec {
-	status = "okay";
-};
-
 &gpio_oled {
 	status = "okay";
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &leds {
 	status = "okay";
 };
@@ -49,16 +37,6 @@ &reg_usb_h1_vbus {
 	status = "okay";
 };
 
-&sound {
-	audio-routing =
-		   "Ext Spk", "LSOUT";
-	status = "okay";
-};
-
-&ssi2 {
-	status = "okay";
-};
-
 &touchkeys {
 	status = "okay";
 };
-- 
2.25.1

