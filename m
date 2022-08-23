Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F559E8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiHWRM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbiHWRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:10:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2E753A2;
        Tue, 23 Aug 2022 07:01:47 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:60d6:460b:e0dc:41ba])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74C2C6601DD8;
        Tue, 23 Aug 2022 15:01:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661263306;
        bh=U+314oct9Zu4v5I9Z6fQHhGgVdlqQID9qINoCymOG0M=;
        h=From:To:Cc:Subject:Date:From;
        b=KEI3ObSfikbPPBkGQYCr5s/5lOkKmCmaxjj23ydmdZPlPwTLqbG7dVtgbBhkjbQDD
         UiCBq/F8LGpY0IKeWUsKVhC0pGGv26nhnJnr8cP9sa1bEhJrfIB05/vBLPVFLxiLEL
         s+Tc6rWA65OFDt6oxEHqpONlDZT567Ka9hyu7Y4w6ZYDwkYjjUN6pGVwAmurlF+0xj
         qzuBDnrhS180VCqyMjNgCJ8C8fGpWV5svGZ2cnYpQPEcZk4Vhxj3at75j/fiLoEF/U
         bNKkyY4GM47RHpXEdJZiR1DRQEu0yT72/t1N2Or7JzkY2GRFXlH6Lwmsyv9Q0K+GuP
         9RQ4qg6YW5+Lw==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Tue, 23 Aug 2022 15:01:21 +0100
Message-Id: <20220823140124.1469989-1-martyn.welch@collabora.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
  - New addition

Changes in v3:
  - Switch to avnet vendor
  - Shortened descriptive comment

Changes in v4:
  - No changes

Changes in v5:
  - No changes

Changes in v6:
  - No changes

Changes in v7:
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

