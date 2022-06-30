Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B35618B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiF3LFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiF3LFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:05:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67328403F1;
        Thu, 30 Jun 2022 04:05:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1B6C6601948;
        Thu, 30 Jun 2022 12:05:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656587104;
        bh=eGFqIXIFYAXFE4MO2t8tHeXxZXxmMvb3vwAEEfOAIgg=;
        h=From:To:Cc:Subject:Date:From;
        b=axcyMITDCmjnCABiyM0+gfZYWbeDjlhi8gINRkvZHtV86da9BWJ5WPUaHZn8K6JCj
         o+Ry4zGywO+mKDjGqkVyAiN+09ft6LyWNBHyhViJcbCuJfM5YYkwcj3fEfhL+d5pRx
         kpVEvo7WoPkbEJQuXcoIby2bTeRWwR/SnKicegM55mJIK6FmH9LDKrhfOO13iRw3JL
         bVComaH/GB6bw5BBQHJ6FUw2CFPAFZlSzR5lDE8C0eukRQhJTxUz85t2OhlOSfy8tA
         2ot9UJVA4VAhA4BaiF4uVhhjudZHvbjHqOn2/asQKDdlBDt7mAs8u8YdjHdHb+ojXX
         5acWxIqdbo4MQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] dt-bindings: pinctrl: mt8195: Add gpio-line-names property
Date:   Thu, 30 Jun 2022 13:04:53 +0200
Message-Id: <20220630110453.186526-1-angelogioacchino.delregno@collabora.com>
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

Add the 'gpio-line-names' property to mt8195-pinctrl, as this will be
used in devicetrees to describe pin names.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index c5b755514c46..15989743afd2 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -29,6 +29,8 @@ properties:
     description: gpio valid number range.
     maxItems: 1
 
+  gpio-line-names: true
+
   reg:
     description: |
       Physical address base for gpio base registers. There are 8 GPIO
-- 
2.35.1

