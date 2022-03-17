Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E34DCAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiCQQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiCQQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:03:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5EE1C16C4;
        Thu, 17 Mar 2022 09:02:22 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LmaZx-1o3O2b0Acd-00aGMe;
 Thu, 17 Mar 2022 17:01:46 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
Date:   Thu, 17 Mar 2022 17:01:21 +0100
Message-Id: <20220317160122.341484-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220317160122.341484-1-marcel@ziswiler.com>
References: <20220317160122.341484-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ams2CG3ed2gw3hclzRgKMrYSeCfSVx52f7cyauVVMqPLm2fYMJz
 isT5IQ1fK9yMVEHPdYL55wFIZhpUNGxxbwnmUWxqv4uYqn3TjdWxNCiJSunuC+qnFhzVaBS
 hFWQTpvM6aYd4Kodw0Zy1Cp4EcqJAG1ZuiT5gFZAos9bXU00Utob6avoQ16pfupm3RrElf4
 Rka9MHV4C9D7eLzooewpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tklSanhWjWM=:ThAQc2zUC2AmlWSJnkFxyT
 CYhrdSa2FzUZ1N/ZIhO1tOlxUqqLtAcEyniCVWyCT7Zv93oO11Mla9CnQooNc2iTyNRT7ht/Q
 RKsZQP4mUW4ZT5aOfGW59XVy9PK25bbxCYsn3J6NMT+2hBhRNkf4fsHS42BpC+CCzE6edhLl9
 nya5hmTLB8HGcLvEUIzek1MdlO4O/OYlZb/Un483BEqm3P4prMX74EcClE0Iyy2VyiCJphH9O
 8x98h1JOOTqJT8+aDmuIgHkwgf7YA540AEQIUpkpe7gIG3dIkKO35t4+qla5ADlycPdqKlvnS
 rsYFnEXRUH1Jyfo6xAmPY8/g0jcxbx++hxPpRIX+KG8FxgPB6edKwe98rxkC7NrVEEqGXzygs
 mhaOo6asTTdGlPzeqfULFcJ3VTjHA1ax4AjRo3Mr6NO3rHym3WDcRaDAtl/LGudlarwpxumhl
 Qt+TRK5BGOu2EdLsjrFT125oCepGcJ1+9h06As+qH6wJWGnWr+CxE4fgOEuB3vjZZyAx5Wxy8
 dI0iNcwEYQqGD4Z6dw1lMo06SQZLsFLzwqdGsaZLKGPKgROgzwhmA4wDp817NlwgRyITfrvkh
 59r6ESkhfJrpqFSjwQHx4dx1fy0zd2qgwi58ftwHaOVxj9vRCwU7ra8y2bDPAxYDnGxulr5kL
 7wNgtg147GCV91GOLJ+mJ8cudtkk0t64PD3XZ+68NmnzPCtGqRRPQ5lurtBPzimBwb5I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
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
---

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
2.33.1

