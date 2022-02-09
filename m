Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204394AEF39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiBIKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiBIKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:24:05 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0557E02F6D2;
        Wed,  9 Feb 2022 02:17:46 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MdMsu-1nqnZ63maW-00ZNzq;
 Wed, 09 Feb 2022 11:01:57 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/12] dt-bindings: arm: fsl: add toradex,verdin-imx8mm et al.
Date:   Wed,  9 Feb 2022 11:00:54 +0100
Message-Id: <20220209100055.181389-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R9J0WpfPWK8eDK02AnEuYrjtLmbpeep6TykG3ukhsN7xVZgDhzJ
 wBnLqklk8kEQRTKsCB/rbZUcA39hK1X9fdeG+YgWVwMKO5PcsScZKNXY5OG4c/jUtoMQjv8
 iXz5xYKyk2MILpuHKmEedoZSsTeKkYEtMsltRxXAu0xDGryb+arOqnm+60Y9egU2ZmApKi9
 vwtOmmdaNTy8rAfJOJzuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ioN6GSRhwA=:PI/cbBef8ShmITfzYkOflP
 rpbtVMwznIlTUT+D3jIQ1BmoVRk/lFlfUnRzHNSFqDwlEQVIC/rEQupJJ3y3BGSQMhulGf8lq
 fQrNmx4aRth+jVqk73yAcsj4ldUD1p6LHJZ+EDcTlLcOmMQBKBaOij4hk29UikqvS6zaqWVdS
 H8IO9wrnFZT99d6BmzMOJZqQDPKRe+cSw5uym5H10ItYQTyWD7AI9isWb0l5dEf2Kr3G1N08b
 Q+/BHp3Z66HCFbmUmQWdy/YGoW8JATeivyO6qyOyg6nLq06pVA8vWGDi2E80YbSPgRngk6fg2
 TX8V0Lpiq23Bz6uK38GgvTt1QPk7t2mmBpK1kDGA8v3Ff5MOWX6Gu8OMuQ0jHoG6p1TO5GZ5K
 A9/hIaSj7o4v14fCRKCKtc9Nj0yBVA9n+hedfRKFaaz3hnMNUbSfWPFfCfnRuInd98S+LkgfZ
 uc4yej5U8RSTHTIhFfD3fhBu5k8gVC1yQDU6dtOG4bE1boL97v2Aeoj+eZqscPYIJ1A6L4fbg
 7We5MmVdTgs6J5e3aP9vtWlx28HqfWPW9cUVhI+aa178djOKg2W+zX0mo1ewqErtMmTgcj4iH
 WLN8bHeITVV7yW/lehwSSRkxNreEp5D3OZckVdO918RNdDnrrlc61ZZte3CPBVBAOn6yH4cQ0
 mrvpjJjeAbyBUpg2/SfBXk/SKaWNWrdRKCYj72W1Xl0XJG2jIlkQ6EYsDDUeN6NL/9ssNmG/q
 uojDn5mYfvpZVkkK
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

