Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8E4B21B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbiBKJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348643AbiBKJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:53 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47710ED;
        Fri, 11 Feb 2022 01:24:49 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtYx8-1oH7rt0QdA-010pxY;
 Fri, 11 Feb 2022 10:24:21 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/12] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Fri, 11 Feb 2022 10:23:21 +0100
Message-Id: <20220211092322.287487-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MrydoXAxSc71NwC2A6jrWRmmBTErityPIgtP8OHu4eeOEVItLrK
 deBmREHg3VvyhJed+ZHTMG4sDIZ/xY12IEHh3TBNpNEV6FGYhGsC1Gx5nfCwOoh1CGbObwe
 5+vrArzslwXBm9oFIzUhKi96aaFokUZdtRaWz2vlkvWzft4hxgdFz0fbIbjJUckX1NdQ0e1
 6BY6ohZBOF97r2FoHHo1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3OvakXCgjuM=:6O7TJfgzqUpgwQZPFtafBr
 2aNOIdO+ctvW8iJdvqUt3kipi0SXKR9z8lO2CgDDvjQ6Y0wx/sFwdC9qH5utYcMkCIUw1fKhI
 /75J/2jJNJjNPeiqCYi75uaaBjw1shkC/8Ci3og29/wNtX00sSkwuXkON7VIF2slq5caeuojJ
 u6g3zUIHLK8MWBHaYcdLX1RTC36RFWlwcB7Eq/b7q6Ek3rtboVvslfOIVnGUOe4sAQV1Gj7tN
 om6Ke3Xtsmv/ZQxnOZzpCB7yQqY79K/PZ+W+q3wTpoPnNS8KvM4Ph5blgg9fnH5okgh3PyZDz
 No7e35CIqcb2EwGFCs1XFblMa3F5MacKOjEzJbvm6aeIgYzSCgpRMbXsg+BUmsBGH6eCesHwF
 vLzWQSZyTE48P5iz5WWwuwNvh19CkYMt4+XmzJp+4c2eW6Lf4fu62JWH0WdJIIK02LNTRHkjb
 rypuh9XRe0S/jUpU+ff+H8VMc0ocxMaXCKnL3pf2e76edrbjb2RRBRPrwLZ+73yVYeipjwHL2
 q+4PS5LFR0qmHa3sSAeiDYrYfyWh3mUqzbsTLvsGAmbZqKs2BVGggoIUUGMeurFvBMe2D53qe
 DUbudzxJri1iX3y4IIY8FlpM8Aki43ehNmeQBHy3otS1e78DiyrQrgkg51O1s3vGKiJezRZaq
 tgDx9ew+YwhBlOQdkjKcw5y2Zj0Vq65FFu/2Q5e4WnmFyq3RV09McdPqxjdMRjDDp/rtXKMrV
 340r1ZfjhuN+uHlIEiK7HMrrY4bgM4QLiDaM2jvfhDlAV4rtnKTnGJwHt20=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

