Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AF4F824D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiDGPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiDGPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:00:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4B1EF9C8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:58:16 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncTaI-0001MW-Sq; Thu, 07 Apr 2022 16:58:06 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: Drop the hisilicon,hi6220-reset binding
Date:   Thu,  7 Apr 2022 16:58:02 +0200
Message-Id: <20220407145802.4060130-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hisilicon,hi6220-sysctrl, hisilicon,hi6220-mediactrl, and
hisilicon,hi6220-aoctrl controllers are already described in:

  Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
  Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/reset/hisilicon,hi6220-reset.txt | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
deleted file mode 100644
index ea0a6a9734c1..000000000000
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Hisilicon System Reset Controller
-======================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-The reset controller registers are part of the system-ctl block on
-hi6220 SoC.
-
-Required properties:
-- compatible: should be one of the following:
-  - "hisilicon,hi6220-sysctrl", "syscon" : For peripheral reset controller.
-  - "hisilicon,hi6220-mediactrl", "syscon" : For media reset controller.
-  - "hisilicon,hi6220-aoctrl", "syscon" : For ao reset controller.
-- reg: should be register base and length as documented in the
-  datasheet
-- #reset-cells: 1, see below
-
-Example:
-sys_ctrl: sys_ctrl@f7030000 {
-	compatible = "hisilicon,hi6220-sysctrl", "syscon";
-	reg = <0x0 0xf7030000 0x0 0x2000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
-
-Specifying reset lines connected to IP modules
-==============================================
-example:
-
-        uart1: serial@..... {
-                ...
-                resets = <&sys_ctrl PERIPH_RSTEN3_UART1>;
-                ...
-        };
-
-The index could be found in <dt-bindings/reset/hisi,hi6220-resets.h>.
-- 
2.30.2

