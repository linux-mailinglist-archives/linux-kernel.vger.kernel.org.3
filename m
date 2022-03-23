Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217664E5454
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiCWOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244808AbiCWOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:38:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B17CDE9;
        Wed, 23 Mar 2022 07:36:56 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MhBdX-1nk0eB3QKf-00MJ53;
 Wed, 23 Mar 2022 15:36:27 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
Date:   Wed, 23 Mar 2022 15:35:59 +0100
Message-Id: <20220323143600.170778-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323143600.170778-1-marcel@ziswiler.com>
References: <20220323143600.170778-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vclFs1HnQuF0XgFbLNUAeVgTIOMAKqQIZG86XuNxLCyjeQJnCp4
 eg6kqAZp/JcSyuCekyASYdNIvOs1ZaZyaYefXeHoWq4zvsOgXS/z1jnbYaWuecJIMU9eTK1
 NoNWQmqPA1s6Bxn9Jsz3HZ7Bit5b+E75JtJ0uywADX9OmhjTrzJWdkK8F+2A76+nCySZoPq
 IGUAnJIUKuJaiZQ1HP/yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EL4T77FQsZY=:ygvOU1V9vXEsUZxVP13BIp
 mA8A4peB3rt6bhva2wcKGRKGgf5PrnsKq368gVMbsgAYSF2LSJ8bIT9gCayUWFuI5RIGuXTMn
 yB/RKb+M+8ayDG/4P2G1s+QV956DqWxbcwYuzWaXjTn6c0ocI0E6gUQWX7sN95jHwwEsEOw+l
 kfPOs9o/f3ymMGUuhyxEaex/8ZRuTHbTTGCOdXELXgZfCxVbCNIyLgeEVPIaNQkl8icOB7o+7
 sZCidxo3uq6UxSTuekP/JZd+77jrWRuIvmjPlSBJGsO2HzHm+iig9kVkuOD07de+OpEts94Jf
 /VCa+DSOUJeD5F+UESJ24FiWDJyrojpvv/wyl4iK9kR9u08ntXgr/IVvdEbwTunzob21Fa/pA
 pkLcyk94eOXeeRMJlntylZ1efTWEm09ATCZgz+MwP6rVCCSxif9uR7HLK4P9vNH03GRfYiJYg
 IOjkboJ6rZZej1sdMN2hFFBPpkdhG7kccgKtALZ9wJniE1MVsUcFqXUx56Du+hDU8z0XUyrBe
 xbQ/TBLGW27xUK/a01zlfp3QkCe3nY+zKf6W10wVpB2xcPT1FR1vaeeiYNRzkNDw6+/RSUrmz
 L1VdDwYLRcIYwk1lRn1oYsOdF1iWRbsbk/lcdq0wu5MQl0QIIT/6OaYp4Gk8ydW8FcIdFmqH7
 QyTQJp1SfQMFhapiatXT5sHm5++s6wJVN/jELQ3hGbnJSb/mx6mHAYh7Q8tAw5PBVIfk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,verdin-imx8mp for the Verdin iMX8M Plus modules, its nonwifi
and wifi variants and the carrier boards (both Dahlia and the Verdin
Development Board) they may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
- Add Krzysztof's reviewed-by tag.

 .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..8e42ae52a77a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -860,6 +860,9 @@ properties:
         items:
           - enum:
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
+              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
+              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
+              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
@@ -868,6 +871,24 @@ properties:
           - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
           - const: fsl,imx8mp
 
+      - description: Toradex Boards with Verdin iMX8M Plus Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mp-nonwifi-dahlia # Verdin iMX8M Plus Module on Dahlia
+              - toradex,verdin-imx8mp-nonwifi-dev    # Verdin iMX8M Plus Module on Verdin Development Board
+          - const: toradex,verdin-imx8mp-nonwifi     # Verdin iMX8M Plus Module without Wi-Fi / BT
+          - const: toradex,verdin-imx8mp             # Verdin iMX8M Plus Module
+          - const: fsl,imx8mp
+
+      - description: Toradex Boards with Verdin iMX8M Plus Wi-Fi / BT Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mp-wifi-dahlia # Verdin iMX8M Plus Wi-Fi / BT Module on Dahlia
+              - toradex,verdin-imx8mp-wifi-dev    # Verdin iMX8M Plus Wi-Fi / BT M. on Verdin Development B.
+          - const: toradex,verdin-imx8mp-wifi     # Verdin iMX8M Plus Wi-Fi / BT Module
+          - const: toradex,verdin-imx8mp          # Verdin iMX8M Plus Module
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.34.1

