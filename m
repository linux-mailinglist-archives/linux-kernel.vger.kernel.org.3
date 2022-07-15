Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2993575F61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiGOKam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGOKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:30:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35383F1C;
        Fri, 15 Jul 2022 03:30:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9BC86601A54;
        Fri, 15 Jul 2022 11:30:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657881036;
        bh=dCWvFXNI2rIY5yBkfjhQbWu/2lwIl+50fVwcfisytEU=;
        h=From:To:Cc:Subject:Date:From;
        b=VMXBCUuenjDeMlHlJ/LcKhsNYLtz7OrbcEnGYXzDF9OzwDi8txzxX30LInO6OlyuO
         8lfcUPs3tlaI0FXkN/euk048aFe+qIO75+HKm7smmo7wkPN6zNxJScqX4UCasS7zm+
         gHe7lINPLlfLagCf8elXNEFL9nhVInxizV1w3y+Y970RMnbjH49GUW1fzfeNLDDjbj
         iARmCY+C53JdG5IHgR74mc+7dUdVWr0P0n/O9z6ACbJD8uAUzrBRO8ZkM/s2VNuoB0
         GS2x1gOIlnBUfhG9PwdhT9T04UAfoPeapGo74kllbcki2mtYgRVo1XfSpYt7NF1MdT
         /66HTbEX/FPdQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: mt8195: Use drive-strength-microamp in examples
Date:   Fri, 15 Jul 2022 12:30:29 +0200
Message-Id: <20220715103029.204500-1-angelogioacchino.delregno@collabora.com>
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

The property mediatek,drive-strength-adv was deprecated: change the
example for i2c0-pins to use drive-strength-microamp.

Fixes: b6d9af2c6b69 ("dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 85e96a5e1708..66fe17e9e4d3 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -281,7 +281,7 @@ examples:
           pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
                    <PINMUX_GPIO9__FUNC_SCL0>;
           bias-disable;
-          mediatek,drive-strength-adv = <7>;
+          drive-strength-microamp = <1000>;
         };
       };
     };
-- 
2.35.1

