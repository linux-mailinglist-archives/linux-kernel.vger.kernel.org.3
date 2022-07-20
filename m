Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C757B912
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiGTPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiGTPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:00:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9E25C5D;
        Wed, 20 Jul 2022 08:00:20 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c30a:1501:bcb3:2103:84e3:6894])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0ED456601A9E;
        Wed, 20 Jul 2022 16:00:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658329219;
        bh=EPt4sVVg7ns3Kwy/ZCSiTpmmFveF4ifk+wDHrU8RPHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNv6xHVn4kt7OfALnyC7jl7h3zmdqCCotuG4BH38QsEfjix7+W3MsQbOR7T94GFq7
         1pkot+CJkQ3nhyJ5B5Ckwk2rNNK4870U6M3recx/2+qgIQvcNbi55TQwxEBGxQ3edA
         rX4VdbMTERgHeoaA31waJaebuXv8tND6mtUNb8KCixD5jPk+Ie4ow2QveD5eQRSwdE
         O6sZdPhF9jyEYWZWVNl2S50BcVvlGkdPvKjp8oVSA/A3cUur/GEq3JvQKw+eeyTSOa
         cgenfj+WyaIctokIAOcRQSFbMHWl9CB4i2F305cpAGZhyKqKiK50tNs7mpAiWuUk8s
         Mvn3nU6SEx77Q==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Wed, 20 Jul 2022 16:00:04 +0100
Message-Id: <20220720150007.2168051-2-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720150007.2168051-1-martyn.welch@collabora.com>
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
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
the MSC SM2S-IMX8PLUS SoM in combination with the SM2-MB-EP1 carrier
board.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2:
  - New addition

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..49dd358d1b94 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -928,6 +928,13 @@ properties:
           - const: engicam,icore-mx8mp             # i.MX8MP Engicam i.Core MX8M Plus SoM
           - const: fsl,imx8mp
 
+      - description: MSC Boards with SM2S i.MX8M Plus Modules
+        items:
+          - const: msc,sm2s-imx8mp-14N0600E-ep1 # 14N0600E variant of SM2S-IMX8PLUS Module on SM2-MB-EP1 Carrier Board
+          - const: msc,sm2s-imx8mp-14N0600E     # 14N0600E variant of SM2S-IMX8PLUS SoM
+          - const: msc,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
+          - const: fsl,imx8mp
+
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
         items:
           - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK
-- 
2.35.1

