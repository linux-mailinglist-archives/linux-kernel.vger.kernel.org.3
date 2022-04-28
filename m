Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39F513EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353207AbiD1XNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353173AbiD1XNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:13:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF624C42D0;
        Thu, 28 Apr 2022 16:09:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B054C11FB;
        Thu, 28 Apr 2022 16:09:51 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086B63F5A1;
        Thu, 28 Apr 2022 16:09:49 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/6] dt-bindings: arm: sunxi: Add two H616 board compatible strings
Date:   Fri, 29 Apr 2022 00:09:31 +0100
Message-Id: <20220428230933.15262-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220428230933.15262-1-andre.przywara@arm.com>
References: <20220428230933.15262-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the two board compatible strings of two boards with the
Allwinner H616 SoC. One is a development board from OrangePi, the other
some TV box from some formerly unused vendor. Add that vendor to the
vendor list on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml       | 10 ++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 086c68771d2b..539af752dd27 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -858,6 +858,11 @@ properties:
           - const: yones-toptech,bs1078-v2
           - const: allwinner,sun6i-a31s
 
+      - description: X96 Mate TV box
+        items:
+          - const: hechuang,x96-mate
+          - const: allwinner,sun50i-h616
+
       - description: Xunlong OrangePi
         items:
           - const: xunlong,orangepi
@@ -958,4 +963,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..eb50ff3487a7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -503,6 +503,8 @@ patternProperties:
     description: Haoyu Microelectronic Co. Ltd.
   "^hardkernel,.*":
     description: Hardkernel Co., Ltd
+  "^hechuang,.*":
+    description: Shenzhen Hechuang Intelligent Co.
   "^hideep,.*":
     description: HiDeep Inc.
   "^himax,.*":
-- 
2.35.3

