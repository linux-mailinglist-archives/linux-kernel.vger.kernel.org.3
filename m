Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF035340D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbiEYP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbiEYP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:57:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0D60073;
        Wed, 25 May 2022 08:57:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id CCF8D1F45159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653494243;
        bh=KsiEYfGpxg0O1y1KjTtQ242A3Duo08kD4AXp8U0Hc0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+VX70OMMYa1KMnuEIF7mYLU973wrz8OAvlyiDiy/UivnsZSnWQmH+D4532vb9MN1
         XcK44xZap/3ZSDQW8TkgmjVoVaZ/Ua4mUadChfoWBVVBbfwvvtnSuJsRHc3MnxFS2O
         dFNw+COY5gsY0cPPRcOPsG9QgjLiFGM9FHXxiFD1TAI1TEFX2y1nDvEw3NCFFKwrmS
         EL6w6imihlGytimwVmB2RM2apTjF/iNALVbN+aXwkjhK8lzJ5F6eiCWa+RBesinoGh
         8h46Qroc3DFeFFhh20UhRdcX1fADM4Gf/MvdNXYkaiS5dyjD9r1LFfwn2QiM/1Ffwx
         hqmswncX+O6Sg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 1/2] dt-bindings: pinctrl: mt8192: Add drive-strength-microamp
Date:   Wed, 25 May 2022 11:57:13 -0400
Message-Id: <20220525155714.1837360-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525155714.1837360-1-nfraprado@collabora.com>
References: <20220525155714.1837360-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
drive-strength-microamp instead of mediatek,drive-strength-adv.

Since there aren't any users of mediatek,drive-strength-adv on mt8192
yet, remove this property and add drive-strength-microamp in its place,
which has a clearer meaning.

Fixes: 4ac68333ff6d ("dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 27 ++-----------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index c90a132fbc79..8ede8b750237 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -80,31 +80,8 @@ patternProperties:
               dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
-          mediatek,drive-strength-adv:
-            description: |
-              Describe the specific driving setup property.
-              For I2C pins, the existing generic driving setup can only support
-              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
-              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
-              driving setup, the existing generic setup will be disabled.
-              The specific driving setup is controlled by E1E0EN.
-              When E1=0/E0=0, the strength is 0.125mA.
-              When E1=0/E0=1, the strength is 0.25mA.
-              When E1=1/E0=0, the strength is 0.5mA.
-              When E1=1/E0=1, the strength is 1mA.
-              EN is used to enable or disable the specific driving setup.
-              Valid arguments are described as below:
-              0: (E1, E0, EN) = (0, 0, 0)
-              1: (E1, E0, EN) = (0, 0, 1)
-              2: (E1, E0, EN) = (0, 1, 0)
-              3: (E1, E0, EN) = (0, 1, 1)
-              4: (E1, E0, EN) = (1, 0, 0)
-              5: (E1, E0, EN) = (1, 0, 1)
-              6: (E1, E0, EN) = (1, 1, 0)
-              7: (E1, E0, EN) = (1, 1, 1)
-              So the valid arguments are from 0 to 7.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3, 4, 5, 6, 7]
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
 
           mediatek,pull-up-adv:
             description: |
-- 
2.36.1

