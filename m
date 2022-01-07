Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE96A487BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348835AbiAGSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:05:00 -0500
Received: from mout.perfora.net ([74.208.4.197]:56853 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348755AbiAGSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:54 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MofY5-1mZ60n17uL-00p0bS;
 Fri, 07 Jan 2022 19:04:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>, Lucas Stach <dev@lynxeye.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/14] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Fri,  7 Jan 2022 19:03:13 +0100
Message-Id: <20220107180314.1816515-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZKZwjWFlgsp7DNNGN8MO5NSM/LD76WhbxctU0bRAEmeUrOjtr1d
 o6H5ytZtz3lxJQ6BzQfFbEqectq87wkfZoGWBK5RGjgoEeDMkXcHJ3QpLdEk3GfcaOQx301
 EISYB3UO/tBdQiULajoKA6Y9vAbrH6T7787uLndjtTonBV8vBrLTJ5xaNYU6pHayUZ+7I0o
 XEWngGY1HqycDbGBQITzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9VObreZRg2Q=:d8xEy8w26OcrD3O1qS95Hs
 BfOQTfQijQJ5Kq6ftIqm2qj0rMeBd38EqPw1Dde4bRLUfMMdSI+i2iPaImluiWD+Ber03qAik
 3qJarNBSFXAAiGF6XFmbMY74v8sZARPUDCijQDHejUaDNIjgsvZuDsTMHbEvN9/STPe/wQjtO
 47jKxNfi58p2IfwIUKjMHvBhUQ9uJD3x1POiWDIph/0RMqCODt8TECWepwvJf6QOHbQ6RLhqt
 ImDKKfjQ7p9afvEvGVltt/uE18CJt0AnIcFqvqFnev7jgTQ8cYbSzIWEpVSooUhkMnHP+ltBW
 EGpCBRB3VUuk1vEDljKw6t8VFrnNqrrBjHwu5ZcmGOOe+YnfplUts7jXXrcC8Pv9ysqMr9ED2
 XwfV35/+TskVhsJM25FtL8TB9Lgu2eWac1RmiOIZ9xwnWm449L7BvsEsH8r0+PyOZoxGrLNTn
 WBLip02gworU9ohGd9OxKJjkqiyhheXRv7rqcoE8LnT0nHO/ByQXNmU6sO1yvSXR1+9ufm3Hz
 +/Smu2ijZ5XeJpgvl8tXljPypErzrLm/3xdWjT27xUlF5lpVWEZmRFjn3raqab6hNl51wl+wN
 N3DKR+HloIEZelKkveP7zbnSh3RFuK7bGun/X6eH/Gk0mEimF4i26UrTU17Lq/kC4mo7E0FVV
 OQVb29y8PXli4OgzVorWuBboELC5bquxqt2JxPT+FYAe5aqsh0lvX08lL9f4sexJkROEajyhA
 R2UxA7zfEp4tlb2p
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,verdin-imx8mm for our new Verdin iMX8M Mini modules, its
nonwifi and wifi variants and the carrier boards (both Dahlia and the
Verdin Development Board) they may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 97f6eebad76a..9ed61591c6aa 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -770,6 +770,9 @@ properties:
               - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
               - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
+              - toradex,verdin-imx8mm     # Colibri iMX8M Mini Modules
+              - toradex,verdin-imx8mm-nonwifi  # Colibri iMX8M Mini Modules without Wi-Fi / BT
+              - toradex,verdin-imx8mm-wifi  # Colibri iMX8M Mini Wi-Fi / BT Modules
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
@@ -787,6 +790,24 @@ properties:
           - const: kontron,imx8mm-n801x-som
           - const: fsl,imx8mm
 
+      - description: Toradex Boards with Verdin iMX8M Mini Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mm-nonwifi-dahlia # Verdin iMX8M Mini Module on Dahlia
+              - toradex,verdin-imx8mm-nonwifi-dev    # Verdin iMX8M Mini Module on Verdin Development Board
+          - const: toradex,verdin-imx8mm-nonwifi     # Colibri iMX8M Mini Module without Wi-Fi / BT
+          - const: toradex,verdin-imx8mm             # Colibri iMX8M Mini Module
+          - const: fsl,imx8mm
+
+      - description: Toradex Boards with Verdin iMX8M Mini Wi-Fi / BT Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mm-wifi-dahlia # Verdin iMX8M Mini Wi-Fi / BT Module on Dahlia
+              - toradex,verdin-imx8mm-wifi-dev    # Verdin iMX8M Mini Wi-Fi / BT M. on Verdin Development B.
+          - const: toradex,verdin-imx8mm-wifi     # Colibri iMX8M Mini Wi-Fi / BT Module
+          - const: toradex,verdin-imx8mm          # Colibri iMX8M Mini Module
+          - const: fsl,imx8mm
+
       - description: Variscite VAR-SOM-MX8MM based boards
         items:
           - const: variscite,var-som-mx8mm-symphony
-- 
2.33.1

