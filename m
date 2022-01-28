Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4149FD8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbiA1QCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:54 -0500
Received: from mout.perfora.net ([74.208.4.194]:41945 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349929AbiA1QCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:02:36 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MQPne-1moIMl2Mk0-00TkUf;
 Fri, 28 Jan 2022 17:02:00 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Fri, 28 Jan 2022 17:00:59 +0100
Message-Id: <20220128160100.1228537-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bAanr1KODr2XuQ8TfSvDmeH0VV+hqXaJhtjCDQAqCc2MDw6ug6A
 iIP14VDjYwimnlwkl+blzzeJLegL1s0uePeTons3RWzR4MaEQ0GQI+ArsaPlk180oHd+jEU
 nBttFH29SYuv3pEGLzBTDTFX8ODwOdqknWG6hl/MGqx9iPu88kSvWz1iWwmFGUINo13PRcV
 VrIb91KXzkxb+IivEPlyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Hu205XtEWI=:UaJAAbqL2Fysl+B5lkudcF
 gZjPjnWrN7tY/rCvteil1633gy2oDjusU92LjZxKe3NdliZVbTCJ2LD0P+FS0caJAQCIkMl5U
 gqQDSBU8cxIDoT395kFTMlx5upSk6b6Gg/J/ux1p7u651Gwdi0WPsFVz/yxzqnPeWYvoFh9kG
 NFvMDUGXWoZm2O1LYrZsVqS5CD/n53QnDa0DnQBccGh6n3C4i0Meei/bz9hAHaFZnl7RzEwN+
 vbku6qcp+2cdCMKY7CDZcStoIaH0fv7ouhJtwyyQNE2ESuuDAFE2iwFbnkrH5Km3WenstUmez
 +o8sIXX//2QPPrL4q38oZevWSrceOS4n2xcwbLFxx9AelIPfKlBUdTc6cSctaIscf+p0MvRBn
 8RoMQZoJQ8+VtCnQcnnuNBPek3q3T/yn1O2tW69hdLbkh2RAmiV9axXqM7grofL6Ut582PDnp
 v8paZWvMb4bhIfHvsY7HxrFejxwwSTzj1C00cf/i7w7go0HV/yz7vjqhEmd7lP7xllpTTG+V6
 RRjtRayMJe6C0dDwbkxGzgkIM0G8+0gjpAtkoLggt4Xvq+u06MF7JwQqeoUIyaP9TttjUV/fg
 xeQXbgPYr9HNFDZ3/mvftPixdk22715APl/q3sgafcfxEMVBIEiWXaNm6sqisfw3waQtT5pfw
 xYHQ0nXKxj9FZFsfBBwcpbrBKaucv3ykODP304kntjgdVGXuZZmrkhdsdPG82SfAwNak=
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

