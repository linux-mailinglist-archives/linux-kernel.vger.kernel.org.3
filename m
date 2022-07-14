Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF345752DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbiGNQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiGNQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:33:27 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 09:33:27 PDT
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FA65D78
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:33:27 -0700 (PDT)
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 4CED3A08FD;
        Thu, 14 Jul 2022 18:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1657815936;
        bh=Zm5jim8AZMOa7t15V1eFzaZWY0d9aU4B/ymOzF5a0V8=;
        h=From:To:Cc:Subject:Date:From;
        b=YXWlbOs4ed+SKp6yDU6N6Y2COyPQSZ0uMDsSA3b6q+RIiaj3aptBXpSnen9Z7PG7N
         Kf3MjgSenlmPPpkl8VQgsko0Rfa7NJ7v00/9Bh7ei+Pd8RjwEO2cICTn/VbbUhnH4M
         bbR8TbVXIeEQ3CD5O74TLx07ncgzv8fJIQeEOjqs=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Bind the backlight controller to the LCD panel
Date:   Thu, 14 Jul 2022 18:25:15 +0200
Message-Id: <1657815915-1872-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add connection between the backlight controller and LCD panel.
With that the backlight is automatically switched on when the panel
is on or switched off when the panel is blanked.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 5054e4ab82e2..0afd6647484a 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -55,6 +55,7 @@
 	panel: panel {
 		compatible = "dataimage,scf0700c48ggu18";
 		power-supply = <&sw2_reg>;
+		backlight = <&backlight>;
 		status = "disabled";
 
 		port {
-- 
2.1.4

