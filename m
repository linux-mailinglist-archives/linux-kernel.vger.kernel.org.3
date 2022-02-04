Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084E4AA3CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbiBDW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:41 -0500
Received: from mout.perfora.net ([74.208.4.196]:39985 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376287AbiBDW6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:58:33 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lpu1h-1mbZRT0MDP-00fmon;
 Fri, 04 Feb 2022 23:58:04 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Fri,  4 Feb 2022 23:57:05 +0100
Message-Id: <20220204225706.1539818-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/8dK2lttyGNtwEk7BClktRjejtZtzP0SVKf7uMGxK8PqSPoMZtu
 lVrjVLsEzowRBYU2UVsOaKmqww5WCFzz+mbQfj5BC9f2/K3HzNXKjFalIii7nAXvzI5T3z5
 GIjqLruOwxabXOkkJTVroJhP9D9CBRQiOG4ROVJXNG2oQGgOuvj9ecj1aSP1+qlIXvUgNy6
 pR2NwL5fCj4FoqBRyt06A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuurbLbyHNE=:1pADT9vcdY6tZWYVZKG8sA
 aUR/a1rjQz16EVg4csDthlgjB5XU6UWeV6BgM9lKuwZzqinZAcN3VCFjhX390AX0WWLcI0aev
 RS9r30Dsem9CeCcRN//n614u+r1Va3V5VZBLbif2QQg/9ypOnL7x0F0ERNF9lFuekwtEqvfBQ
 qMx757kkrL5Y03vKBSBUCMRciMtA8zubEiqE2m6GPzUtrjx03Ydh9Uejenu+cRniBZK9zupB9
 c0k4AMTpSctRKdu9Y8kDSPE3sw776W8SMJu0RUsXJJHmdNFumnKDuS/U+CR1tc/A4jtvZdYLY
 p+z7pDBGprnwAUOzukwl4eQcDypP+gBSszfYJI93N9vF7BXF2u/nzH6JGZwAZ1NPKEFSwyqYd
 VkvW1mpt7vapVgFbhYzaEopTCUdworKRTknfQxwe1C2ZaP7J4KceWcQbLZYHdLkwX9DCQnbYP
 EDzohNbo0i+VWxA2xKY2DZrtcsW9qBCp8+nIPR3Z75eVfLeVbEqzvH78PWXyXs6lxkHuh4tUn
 OLKqAOHpriOHcVBEb/6Fr0BwL9MxVE3OncSibilyewvX1X/Hbjdol4LpzU3o3uZW9XypsLssq
 6e+macXmTk0Lx/acGDdv2wpY27sYwQUyVOoEuFq8REWlv5oLqNukk3PAQxyDG5waAWEtlFX7A
 1yfcbw28B8h8jOGu4sQMGc9tAbzeWrckLfbAYNiVuFjLro2nIPlS3izfVr8RHwvLUg0u68ZWk
 ujy1AuBIeTyWPNmRRkg6h4bwX6gXlRWG8QrqR+9f2Rt5GL4Ar0HK1Xn5l8A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,verdin-imx8mm for our new Verdin iMX8M Mini modules, its
nonwifi and wifi variants and the carrier boards (both Dahlia and the
Verdin Development Board) they may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v2)

Changes in v2:
- Add Rob's acked-by tag.
- Fix Colibri vs. Verdin copy/paste mistake. Thanks to Francesco Dolcini
  <francesco.dolcini@toradex.com> for pointing that out to me.

 .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5075fd8c1b42..4ddeb9b20195 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -770,6 +770,9 @@ properties:
               - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
               - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
+              - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
+              - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modules without Wi-Fi / BT
+              - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
               - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
           - const: fsl,imx8mm
@@ -788,6 +791,24 @@ properties:
           - const: kontron,imx8mm-n801x-som
           - const: fsl,imx8mm
 
+      - description: Toradex Boards with Verdin iMX8M Mini Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mm-nonwifi-dahlia # Verdin iMX8M Mini Module on Dahlia
+              - toradex,verdin-imx8mm-nonwifi-dev    # Verdin iMX8M Mini Module on Verdin Development Board
+          - const: toradex,verdin-imx8mm-nonwifi     # Verdin iMX8M Mini Module without Wi-Fi / BT
+          - const: toradex,verdin-imx8mm             # Verdin iMX8M Mini Module
+          - const: fsl,imx8mm
+
+      - description: Toradex Boards with Verdin iMX8M Mini Wi-Fi / BT Modules
+        items:
+          - enum:
+              - toradex,verdin-imx8mm-wifi-dahlia # Verdin iMX8M Mini Wi-Fi / BT Module on Dahlia
+              - toradex,verdin-imx8mm-wifi-dev    # Verdin iMX8M Mini Wi-Fi / BT M. on Verdin Development B.
+          - const: toradex,verdin-imx8mm-wifi     # Verdin iMX8M Mini Wi-Fi / BT Module
+          - const: toradex,verdin-imx8mm          # Verdin iMX8M Mini Module
+          - const: fsl,imx8mm
+
       - description: Variscite VAR-SOM-MX8MM based boards
         items:
           - const: variscite,var-som-mx8mm-symphony
-- 
2.33.1

