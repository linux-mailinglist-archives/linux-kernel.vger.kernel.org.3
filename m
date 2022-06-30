Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B0561F56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiF3Pdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiF3Pd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288A3EF26;
        Thu, 30 Jun 2022 08:33:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 730D76601964;
        Thu, 30 Jun 2022 16:33:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603205;
        bh=2tnHNAZaZDCuDnnGZahAxPIq9YXQxYwRpKMSJ0Kgqks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERvWj6dbuEBc2qowvzQ2tnF7WisXmOMOP8kXsmEV4ur1Dx4+bOFAu0+ci1T/Z5xG2
         WHQn4MYcMd890UsLcQjYLUMkSqhWw7rFG6o3os5DYeuqbjsWc1cQJ604jA749oTYlU
         tlMN3b03g4/WWcAAQDRJxv0z06uNkf+4lb6BhecWU4nOdAH1+rxLNTKl+CUXJNfZH7
         FKwIENe5Wo4JezKyqCXE0XzfaKmddcuWJZ0eT9j8HSHR5bgVdXqCCRkkhIhqNFAn2f
         J268ernK4Ujf5CiQq510O8pcUgY/YsdOhpncqF4Dg669rGAFo6qi0SARhBHHjr2vJR
         IF971delu91Fw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 01/11] dt-bindings: arm: mediatek: Add MT8195 Cherry Tomato Chromebooks
Date:   Thu, 30 Jun 2022 17:33:06 +0200
Message-Id: <20220630153316.308767-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
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

Document board compatibles for the MT8195 Cherry platform's
Tomato Chromebooks, at the time of writing composed of four
revisions (r0, r1, r2, r3-r4).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index dd6c6e8011f9..3e0afa17ed2e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -144,6 +144,19 @@ properties:
           - const: google,spherion-rev0
           - const: google,spherion
           - const: mediatek,mt8192
+      - description: Google Tomato (Acer Chromebook Spin 513)
+        items:
+          - enum:
+              - google,tomato-rev2
+              - google,tomato-rev1
+          - const: google,tomato
+          - const: mediatek,mt8195
+      - description: Google Tomato (rev3 - 4)
+        items:
+          - const: google,tomato-rev4
+          - const: google,tomato-rev3
+          - const: google,tomato
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8186-evb
-- 
2.35.1

