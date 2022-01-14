Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8106148EB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiANOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:53 -0500
Received: from mout.perfora.net ([74.208.4.196]:45893 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241497AbiANOQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:16:34 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LzuPF-1mDREb2D3L-014xUh;
 Fri, 14 Jan 2022 15:15:59 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
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
Subject: [PATCH v2 10/11] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Fri, 14 Jan 2022 15:15:06 +0100
Message-Id: <20220114141507.395271-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OR+boG3aUywor6tgQJXpB0l5ojyLb5iPHOorQkSo8FvWDbyOza3
 /QgTrZPTBVykZpWQnHQ9bAWr+m1FlhQTf7VbNd2FWYK3XPG2JIqq0m/RTs3LOitBkW2IngI
 jOQYD0RUEZzvcIg1x+rCRN6DSTtyR62JUPVPeIt9F7KaFhbkJcVQjuDkOd0p6RMFouSahyb
 1lU8qNUQU4R5ubzOe9nXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wTj6mcIvAn4=:DtFxquz8oVvjN7NCGZOHpV
 qvjBmKkuUwQv41QnjIv3lFz0LjO/JDnmHYih748gilh3g/UyZrJ+XxP3BNupw2HyGa7/MVasm
 0WkxBUScazsruqTJfLwq80edltDkZGjFty6TLNsmcA0LlIootmvqaIHgq8HbXPfidnKrVfEbb
 knwCXL59rZnd3AhoVXIrniHbS0okTUfWMfnZCWijQjhUj7tC11bGUfrBPoRSChmj6L85pey1O
 v+NLurkt3Ha+D33FBT9TfICNw49BS2d9N/vWXNpk3qldcNFAC6sGZB/ztgvxEHrHkuLlbm13u
 Z2KaI42mXFlKD607Gyo6IMYsp01wmqn6cTZeMuHdj5d2JMfCXovI5/LFH5lX/+7ZkQBqrgARZ
 yXCsvNBjcmWX3Dr9lu5DBpulXiiHReHRmqrKYsL1Yi24tOAdQMZ2LCA27O2EPoT/GW7rx90zA
 YPots7hfMmz/FYU5s9PbPX32o0ZjH5i4QEfy9pK3CT6nbkgNthG47RW6/sIrjbNsurTV9u7hn
 uBadzYVTs7WIYqCyiwpJcNfub8X+HTijHNjGmAsywJ2VzNmslihCoLz2sxWK9BTWMfwRoNqdx
 ZF2zx6sSfeo0DWJldg5QOguL3Oodg5VV/aAULZS9fN80/ntx/RUQzgg1JkfYeUOWDOfkIScLN
 ajUsigXntXK0PZMROCZoew9B6/ns5B983/jgwhUWkV2ZZ7gmqOPgV7qjItwKSPpMjndjy4cB7
 lxhJFeyTkA/AIaxK
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

Changes in v2:
- Add Rob's acked-by tag.
- Fix Colibri vs. Verdin copy/paste mistake. Thanks to Francesco Dolcini
  <francesco.dolcini@toradex.com> for pointing that out to me.

 .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 97f6eebad76a..7b7b6d3aa16f 100644
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
           - const: fsl,imx8mm
 
@@ -787,6 +790,24 @@ properties:
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

