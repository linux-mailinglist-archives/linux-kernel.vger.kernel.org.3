Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56524EF8EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350034AbiDAR1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349931AbiDAR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:27:15 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90261B8FF0;
        Fri,  1 Apr 2022 10:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648833899; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=A+qVXCI8B/v/0h/89awxMV8kULVcp1PZrXFsVavkmLBPAOtWtHKYGp85PIeX0eaIPrp+0+PgKMfjJPGLAGKiTY+7aoTerK7WPmkpcq5w6bT+wxnnb287rT0/QZ6DoUmCNKWnTPzjakm6N5pjwhkEoVAcFEFn3ar+EQI38Ypazy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648833899; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=o5HN4+D5UQ9euR0BVh4ZToQJDW/64+Gz9slpGZrQ7b0=; 
        b=guv5aZD5o1M2LJfUSxYNJxrYsHvldaMeCw6hTDtLB1eoZ9nF+Mv3+60XJnQ2TFDhA8fff6rMRp2HBmuBRhP0pth5XesgIFjxSOU/YrbPrLqMK7eFOExjliXDnucdjYAXOvlvky3jf+b/5dqThNUwom/8izBcZI2a2XGbemrkHTI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648833899;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=o5HN4+D5UQ9euR0BVh4ZToQJDW/64+Gz9slpGZrQ7b0=;
        b=IXK/gkmJRb7yKtYwtcMvkRYxsiqUITMf3libtsxsaO+jpZASqrRFCoZhmHkiGRrs
        BJa1f89MdYmryvNK5tZQv3lsycDtG6+lM4Nat5O8Vj/7VdU+6ZIDjX9U5jpEbiWU9kJ
        uH30VD3/MqHez5BhjM4GcSGkFcpTSINUjk2Af+fo=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648833897593238.78338422234162; Fri, 1 Apr 2022 10:24:57 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH 1/2] dt-bindings: arm: bcm: fix BCM53012 and BCM53016 SoC strings
Date:   Fri,  1 Apr 2022 20:24:27 +0300
Message-Id: <20220401172427.2806-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inaccurate SoC strings brcm,brcm53012 and brcm,brcm53016 to respectively
brcm,bcm53012 and brcm,bcm53016.

Create a new description for BCM53016 and move Meraki MR32 under it.

Fixes: 4cb5201fcb5d ("dt-bindings: arm: bcm: Convert BCM4708 to YAML")
Fixes: a2e385f5374d ("dt-bindings: ARM: add bindings for the Meraki MR32")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
brcm,bcm53012 string was silently changed to brcm,brcm53012 after
converting to YAML. Let me know if this was intentional.

Arınç
---
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml        | 9 +++++++--
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts               | 2 +-
 arch/arm/boot/dts/bcm953012er.dts                        | 2 +-
 arch/arm/boot/dts/bcm953012hr.dts                        | 2 +-
 arch/arm/boot/dts/bcm953012k.dts                         | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 434d3c6db61e..8a97ee048053 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -83,9 +83,14 @@ properties:
               - brcm,bcm953012er
               - brcm,bcm953012hr
               - brcm,bcm953012k
+          - const: brcm,bcm53012
+          - const: brcm,bcm4708
+
+      - description: BCM53016 based boards
+        items:
+          - enum:
               - meraki,mr32
-          - const: brcm,brcm53012
-          - const: brcm,brcm53016
+          - const: brcm,bcm53016
           - const: brcm,bcm4708
 
 additionalProperties: true
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index 66c64a6ec414..daca63f25134 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/leds/common.h>
 
 / {
-	compatible = "meraki,mr32", "brcm,brcm53016", "brcm,bcm4708";
+	compatible = "meraki,mr32", "brcm,bcm53016", "brcm,bcm4708";
 	model = "Meraki MR32";
 
 	chosen {
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index 52feca0fb906..dd63a148a16b 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Enterprise Router (BCM953012ER)";
-	compatible = "brcm,bcm953012er", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012er", "brcm,bcm53012", "brcm,bcm4708";
 
 	memory@0 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 9140be7ec053..b070b69466bd 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar HR (BCM953012HR)";
-	compatible = "brcm,bcm953012hr", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012hr", "brcm,bcm53012", "brcm,bcm4708";
 
 	aliases {
 		ethernet0 = &gmac0;
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index de40bd59a5fa..f1e6bcaa1edd 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -36,7 +36,7 @@
 
 / {
 	model = "NorthStar SVK (BCM953012K)";
-	compatible = "brcm,bcm953012k", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012k", "brcm,bcm53012", "brcm,bcm4708";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.25.1

