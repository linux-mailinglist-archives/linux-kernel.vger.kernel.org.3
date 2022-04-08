Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C64F98D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiDHPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiDHPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:00:17 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8C119242;
        Fri,  8 Apr 2022 07:58:12 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N7hjq-1nzVfg0q4g-014n5Q;
 Fri, 08 Apr 2022 16:57:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
Date:   Fri,  8 Apr 2022 16:57:24 +0200
Message-Id: <20220408145725.812566-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408145725.812566-1-marcel@ziswiler.com>
References: <20220408145725.812566-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2/AsQ6UrVrCDPK0+f9eWxnJSWE1X5spdcfPQ6AtEnJhQEcaX2cE
 0qaYwaripdlAbqs35Nk/iRa1GuA2L3pRgdCNEW+Yk28tkRSsktVzp1O6N1uDr9d1g1AMlsy
 CozFGWnwwi+tvxbba0F0A1K4p+Qu9w6lUkjP8ai6bm6bPRXPy3fzmDU41oZdliOZECjWUDo
 ENXwPNfLTnPCPrTO9JJXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nz+trrcOXbc=:9zlXrl0rSvwaZH3gD//CE4
 KmaPeiSIzH4wWV8b/SD6D4o9MUbHlMv+Fn4ChGRJ+o1fbIpZnwmQiA+/Xm4UUOIGOjqg6PHeQ
 uRR6ZHNxensim3zFkRngK3x+YZRjBXBj9lcmWAlP0etA/mcIvUCE4ZQmZDp/OG9UmPnnbUcaY
 Ff5h1BMKSsRTRsE6EoswHSlEPN1KhVhTYn9ogEv9E7ZZikpoWirkfq1XjKknh/D39yUiAeUbz
 d0eNyh7kpp+hijlbwJgxKmgv7z4CKPJXfPCUnaVAYgFn7vPlukNtXlp/jqDe50lfw5IMDoqy8
 XAEWXBlBxBRq1EZLBwlPV5Y2/7I/Gez84PwrLyv5PZNC+BjgFED5g9m0r8HFM0D9g54/8hgR3
 fcn95VX4UwGIlGqd10lnH6wcR3VLJN3vA0BFBt7Wv0fzFeyzEDS+mLb5OormWdEYQniq4SHHE
 /HU5UfhZ9o1vZq+DDWNXXmxUna6uioTggyNmA/2UnGccY+rvFikWpxkPg4RzrucWxY1+GCOXJ
 IM7xwQwRcEcx74R5kkIz1+nvW9dRtY4mLfObFr7w5NzrBTMGrIeL6Xd7jVMiJWKtUccznJ1E0
 gOAbUJg2XPQP3KQMK566yRXVqUF3y4c9XsPPZ8Dv0H3q2VvulJs7d7/5uuXU4mcIiUDVjbC9d
 28rGqzt9XNm++fUQDMpgrT7knJWAe/4Cxpe9elGGeyVvhqmp0U/2gpCxV+5O9zqQQoN0=
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

(no changes since v2)

Changes in v2:
- Add Krzysztof's reviewed-by tag.

 .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 03b8d8cf2c6b..98722d698253 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -907,6 +907,9 @@ properties:
         items:
           - enum:
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
+              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
+              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
+              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
@@ -915,6 +918,24 @@ properties:
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
2.35.1

