Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF2590D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiHLIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiHLIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:41:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89E37195;
        Fri, 12 Aug 2022 01:41:31 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:fef:5a97:8fe5:76f7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B89016601ABA;
        Fri, 12 Aug 2022 09:41:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660293690;
        bh=kQnVG46Iq1TZy3eTGNfTZKCU8sKIx1ObwVt3cazLhmM=;
        h=From:To:Cc:Subject:Date:From;
        b=hVOb+6ulm+fUsDbAemeTLOJqxKCg8V7pvW76m+WRpZ/R6G5Er8tVenSW96RIMo7bh
         71l+P0LTzXG+uJbrVTVzEzx578Rl3vs7FDaq+Z64Km6SjHvkd+3Z0qhRzITycFPONd
         9Y4JJmIoVduU5U+VwfxhRuGrAfrITWwLzWY+wUqQmwZ1nAAMi8BaKJdwZuGN8PYCAd
         2cRphtz9hxRAF/qCPzxTREiAG2dtI2/InBX+lvddLAHEL26jBSAO4KogEOsrfLuslV
         Fu0l50OiD4oNYdBIfdpwYLRnxd1SnJHaXZvUqpk9OGSbc25+mAUd+wKHmMTOZlQIz4
         rJwFXOR1223VQ==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Fri, 12 Aug 2022 09:41:18 +0100
Message-Id: <20220812084120.376042-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible strings for a combination of the 14N0600E variant of
the Avnet (MSC branded) SM2S-IMX8PLUS SoM on it's own and in combination
with the SM2-MB-EP1 carrier board.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2:
  - New addition

Changes in v3:
  - Switch to avnet vendor
  - Shortened descriptive comment

Changes in v4:
  - No changes

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..81d90dc83385 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -936,6 +936,13 @@ properties:
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
+      - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
+        items:
+          - const: avnet,sm2s-imx8mp-14N0600E-ep1 # SM2S-IMX8PLUS-14N0600E on SM2-MB-EP1 Carrier Board
+          - const: avnet,sm2s-imx8mp-14N0600E     # 14N0600E variant of SM2S-IMX8PLUS SoM
+          - const: avnet,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
+          - const: fsl,imx8mp
+
       - description: Engicam i.Core MX8M Plus SoM based boards
         items:
           - enum:
-- 
2.35.1

