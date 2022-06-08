Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD725429E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiFHIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiFHIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:51:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32491AFAD4;
        Wed,  8 Jun 2022 01:08:22 -0700 (PDT)
X-UUID: 3c3a4f0d82bf45c38212bc910e100c7c-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:8d42f104-f239-479f-95c7-ff76915e1037,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:79af13e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:1,File:ni
        l,QS:0,BEC:nil
X-UUID: 3c3a4f0d82bf45c38212bc910e100c7c-20220608
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2025737687; Wed, 08 Jun 2022 16:08:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 16:08:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jun 2022 16:08:13 +0800
Message-ID: <1332454e2733d48fdf2396bcaed37bc3e33616b5.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch
 drive-strength-adv for -microamp
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <kernel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 8 Jun 2022 16:08:13 +0800
In-Reply-To: <20220531221954.160036-2-nfraprado@collabora.com>
References: <20220531221954.160036-1-nfraprado@collabora.com>
         <20220531221954.160036-2-nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com
>, kernel@collabora.com, Nícolas F. R. A. Prado <
nfraprado@collabora.com>, Krzysztof Kozlowski <
krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <
matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sean Wang <
sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch drive-
strength-adv for -microamp
Date: Tue, 31 May 2022 18:19:53 -0400

Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
drive-strength-microamp instead of mediatek,drive-strength-adv.

Since there aren't any users of mediatek,drive-strength-adv on mt8192
yet, remove this property and add drive-strength-microamp in its place,
which has a clearer meaning.

While at it, add a new 'if' block to validate that drive-strength and
drive-strength-microamp aren't used together, since they're mutually
exclusive.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <
angelogiocchino.delregno@collabora.com>
---

Changes in v2:
- Added 'if' block to make drive-strength and drive-strength-microamp
  mutually exclusive
- Changed commit title to be more precise
- Dropped Fixes tag

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 35 ++++++-------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-
mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-
mt8192.yaml
index c90a132fbc79..c8092b218f2f 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -80,31 +80,8 @@ patternProperties:
               dt-bindings/pinctrl/mt65xx.h. It can only support
2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
-          mediatek,drive-strength-adv:
-            description: |
-              Describe the specific driving setup property.
-              For I2C pins, the existing generic driving setup can
only support
-              2/4/6/8/10/12/14/16mA driving. But in specific driving
setup, they
-              can support 0.125/0.25/0.5/1mA adjustment. If we enable
specific
-              driving setup, the existing generic setup will be
disabled.
-              The specific driving setup is controlled by E1E0EN.
-              When E1=0/E0=0, the strength is 0.125mA.
-              When E1=0/E0=1, the strength is 0.25mA.
-              When E1=1/E0=0, the strength is 0.5mA.
-              When E1=1/E0=1, the strength is 1mA.
-              EN is used to enable or disable the specific driving
setup.
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

Can't remove mediatek,drive-strength-adv property, I2C pins will ofter
use this property

+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
 
           mediatek,pull-up-adv:
             description: |
@@ -138,6 +115,14 @@ patternProperties:
         required:
           - pinmux
 
+        allOf:
+          - if:
+              required:
+                - drive-strength-microamp
+            then:
+              properties:
+                drive-strength: false
+
         additionalProperties: false
 
Property drive-strength-microamp and drive-strength aren't exclusive,
just i2c pins support drive-strength-microamp property .

 allOf:

