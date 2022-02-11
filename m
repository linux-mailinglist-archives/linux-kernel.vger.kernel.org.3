Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852434B25A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiBKM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:27:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbiBKM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB11DF57;
        Fri, 11 Feb 2022 04:27:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2711509;
        Fri, 11 Feb 2022 04:27:04 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7A03F70D;
        Fri, 11 Feb 2022 04:27:03 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 08/18] dt-bindings: arm: sunxi: Add two H616 board compatible strings
Date:   Fri, 11 Feb 2022 12:26:33 +0000
Message-Id: <20220211122643.1343315-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211122643.1343315-1-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index c8a3102c0fde..185ced5da6b8 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -853,6 +853,11 @@ properties:
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
@@ -953,4 +958,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
-- 
2.25.1

