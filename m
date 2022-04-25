Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5786B50E5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbiDYQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiDYQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:53 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97C11F95A;
        Mon, 25 Apr 2022 09:24:48 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lt0Wa-1ntI5U0w4A-012WcU;
 Mon, 25 Apr 2022 18:24:30 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] dt-bindings: arm: fsl: add toradex,colibri-imx6ull
Date:   Mon, 25 Apr 2022 18:23:50 +0200
Message-Id: <20220425162356.176665-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QGn3W3fpuCg72/ljdA8CgDdA35f9/4dCx/JnBmOd/eW57nCgI4i
 ie+NIlll7tBwg7TNidsG7VJBbzrr8tJvhVS9qPz2Od6KkN71qGBZbgJST7vW74+2p9pZFwg
 SDMqAJK6ZWlJkINwfQu0bl7Z+oOBPaLnPVywBQJ9RnJSCBL3MZ02+oHbOU4M8Fij5BiQECo
 84aFZmCgEpgLjrQZ14/yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IiZ+WPH5P9g=:JNNV4Zo4loBqFNBBAOKGSo
 NL/XMUm7KXYTzwtZKhx6JryZD2M5U3CT7iRTGKpUcJgq9HpMZuj/pj0SI4/NCD0Pplo+5NZhS
 /yVkViff51KJzhtXoZoBAhk/5hVnZUCCJ2SpuUfHifyCyNiiwQJzisX20WVDmr/fDQLaOHcaX
 jtQ5nTrQSZQQWTnjqddUaZRDVvVnaYX7MiWVVIfsJ5sNQDnY+jhyCMPxIzpVKU1zFyzdyY6al
 QE/RUMAFG8pgDy5ffTdCzQyUlKXgLB6C6pYOAajkvWxJ2BQ/KgPwnhL1U5hduRAacyAOThdG0
 mgjgnYnQ/Q/9R+b9MU+bB1pYnjQpAg2wS5++3fUz+2VPD9lZ9L+VwM9ZDUzDV5UIMzz2NG0J7
 KfphZMuZQXUYCV7+veccEMTJaq2d6r88Cc8q/iYMfa0kGP7iKc38lAnjMavAuhMgJdEonue73
 Rm/JEIsscY1DHQ/4CG67IQm+SHNfY6rgysAhCrNlv9G9y0IaMEc1JaAp5ymMOpqW5WMeIIWmD
 kITdhOLJOMuQmyq4xheFIDlA9vZoe9/0IRVnSRAHnyZIfyTOCfi+WlBzEGSN5wcP5R09v0/wG
 Sun2av7bMmMEmFPKi5wMABZhAdOiR2U4bC6csaqUBxYLcrijdtwYAEzcElni39CcZHewX92aP
 sHXID61K6ZhraQR4KqcceiBtYbG9J6/+fbWbKdz8AYFKbQS9jPkYuES0atnMB/fwKOGA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Add toradex,colibri-imx6ull for carrier board dts,
including aster, iris and iris-v2 device tree,
wifi and nonwifi variants for NAND and eMMC modules.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fixed long line as pointed out by Rob's bot.
- Added V3 to Colibri Evaluation Board as done elsewhere.

 .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b8b0efa55339..0f0f20ec7b16 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -669,23 +669,32 @@ properties:
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Modules
         items:
           - enum:
-              - toradex,colibri-imx6ull-eval      # Colibri iMX6ULL Module on Colibri Evaluation Board
+              - toradex,colibri-imx6ull-aster     # Colibri iMX6ULL Module on Aster Carrier Board
+              - toradex,colibri-imx6ull-eval      # Colibri iMX6ULL Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx6ull-iris      # Colibri iMX6ULL Module on Iris Carrier Board
+              - toradex,colibri-imx6ull-iris-v2   # Colibri iMX6ULL Module on Iris V2 Carrier Board
           - const: toradex,colibri-imx6ull        # Colibri iMX6ULL Module
-          - const: fsl,imx6dl
+          - const: fsl,imx6ull
 
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL 1GB (eMMC) Module
         items:
           - enum:
-              - toradex,colibri-imx6ull-emmc-eval # Colibri iMX6ULL 1GB (eMMC) M. on Colibri Evaluation Board
-          - const: toradex,colibri-imx6ull-emmc   # Colibri iMX6ULL 1GB (eMMC) Module
-          - const: fsl,imx6dl
+              - toradex,colibri-imx6ull-emmc-aster     # Colibri iMX6ULL 1G (eMMC) on Aster Carrier Board
+              - toradex,colibri-imx6ull-emmc-eval      # Colibri iMX6ULL 1G (eMMC) on Colibri Evaluation B. V3
+              - toradex,colibri-imx6ull-emmc-iris      # Colibri iMX6ULL 1G (eMMC) on Iris Carrier Board
+              - toradex,colibri-imx6ull-emmc-iris-v2   # Colibri iMX6ULL 1G (eMMC) on Iris V2 Carrier Board
+          - const: toradex,colibri-imx6ull-emmc        # Colibri iMX6ULL 1GB (eMMC) Module
+          - const: fsl,imx6ull
 
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Wi-Fi / BT Modules
         items:
           - enum:
-              - toradex,colibri-imx6ull-wifi-eval # Colibri iMX6ULL Wi-Fi / BT M. on Colibri Evaluation Board
-          - const: toradex,colibri-imx6ull-wifi   # Colibri iMX6ULL Wi-Fi / BT Module
-          - const: fsl,imx6dl
+              - toradex,colibri-imx6ull-wifi-eval     # Colibri iMX6ULL Wi-Fi / BT M. on Colibri Eval. B. V3
+              - toradex,colibri-imx6ull-wifi-aster    # Colibri iMX6ULL Wi-Fi / BT M. on Aster Carrier Board
+              - toradex,colibri-imx6ull-wifi-iris     # Colibri iMX6ULL Wi-Fi / BT M. on Iris Carrier Board
+              - toradex,colibri-imx6ull-wifi-iris-v2  # Colibri iMX6ULL Wi-Fi / BT M. on Iris V2 Carrier Board
+          - const: toradex,colibri-imx6ull-wifi       # Colibri iMX6ULL Wi-Fi / BT Module
+          - const: fsl,imx6ull
 
       - description: Kontron N6411 S Board
         items:
-- 
2.35.1

