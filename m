Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80357C8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGUKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiGUKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:11:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4A4D158;
        Thu, 21 Jul 2022 03:11:20 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c30a:1501:427e:206e:3eb7:267d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CBEF36601AA4;
        Thu, 21 Jul 2022 11:11:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658398279;
        bh=FvIWMrv++CqqvQNdmSKyoDA3d/vJLsiE3FRfXlNHfX4=;
        h=From:To:Cc:Subject:Date:From;
        b=c7XGRPSLyWYooHTCcdT2aRCF+n7W4bhNo2vj/HJuilpF9bniiIu5F+jnW2xe4gxeN
         y+qwfgZxRYbRWsxcmJiVvF/0oTELonAxyHa7Oo492wMYEa7+stt8hGEkYiY8dUn6Hz
         PgQCNU2W1i+/eonxMF3MTZk/RHYxzhgnyi/a+r3aSIJDi/Eeou2J+6vlN8udb+ZVOW
         34B7pNI+fiHAkUi13kxsH92MffFj7HT4l+FKufaVrY73yaeFP/PFEFyLFmIl7aZ+Nz
         115P5807Z5oaz+kf3gI/AfM7R6Nb070Ug1V3jPt83Agpxh88c/Mma3K9jnFGU7INrD
         sjVpguwQshDqw==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Thu, 21 Jul 2022 11:10:49 +0100
Message-Id: <20220721101050.2362811-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..497a137d75f7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -921,6 +921,13 @@ properties:
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

