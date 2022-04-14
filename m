Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D835008D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiDNIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiDNIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:43 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53597674E1;
        Thu, 14 Apr 2022 01:52:07 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MORpi-1nJR990LCY-00Pvdi;
 Thu, 14 Apr 2022 10:51:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/14] dt-bindings: arm: fsl: add toradex,colibri-imx6ull
Date:   Thu, 14 Apr 2022 10:51:01 +0200
Message-Id: <20220414085106.18621-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3cQQN0m2Y0acZm4QyHI5m9L3yBmuPxyJkdOaFPRqvlCZ6FG+ify
 cfraR6MPigvPEhSys5XF25FFmS9DsZHFu1l9JqpzSY7SHxJSMiCAaFCdgWXbJOmRvVd664S
 yAcIbq6rcRDSXHk18vMvqknTIINq4gYkTU+is7tfIs9GkaHdjWlzQaossb81xibvAMkdXy0
 TOJ5r1EnJa/aQyeQME0Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:styuX4ejQJ8=:C3fw+7tUZ6SRrQ52eFNohC
 /QwRT9PKnq2DVBnFVL3mEtwSDHocg4tjustQ75FVZBRMIFOZPagvSpUz75GwCPrdpKgzfXMFA
 LwmUGBIQdC2a1OdVVgX5Ulj9zlyPwwGsWERbCY2UD/MjG6E/1LjKKf/lxe5mPS4xB7XeDgIQj
 ygsFDZw8nwaD7Nf0DYR8q1+dtwEJX0igLSsroThBiYK/Vp3nSgGx8mmlOLZxy5o/+1onjBpIO
 ovPCLMuzmr96c9zLbM2y3ZazARLlm2eMj0uOc/4h4kLoCpynNK7L8GHFVgaXKKdyRdEZino1l
 sSeVz4gBPlAcREaRF2amlQwBbwKm+FtUWPe/Dw88Ko0fzIRG/uqo5sSXr6YcxHd8W5N51rzfw
 cNUt/dIpPqYaBPLhfDFWXkz9/U2nIuyFQlzf35k5odUaISbneFlH0kF+G/JeNYTkeS2eBIKzB
 alKhMZXUFwWjGGFZkxnZY1bVjyvmOTgg4dg8H51inhyYic7NUDyyrgSCo6TmDr25eVEU5PEq1
 KCu+vZDHfl/y3V7e0ltIZlO+z9GmefU45uiYIiePqTvfuwYEUJ2ltk6/Pv1JTgiU3zGNGZK4G
 ow8diV52dpqtSNAWa0DN6D7ycgF331QllIhO8k+xz2ejj4kimH+Y3fsBdTxycyC6+SRbMd0gj
 NnwLDsaHGOoa3PUeUwx1cwqoqjTrWgFqKfGb5HA0aLVmDXtFOQ8ilOymWIXUnBySBjYcRdaEY
 r+NiE8q8g8bk+I2X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/arm/fsl.yaml          | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b6cc34115362..7baa854946e6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -674,23 +674,32 @@ properties:
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Modules
         items:
           - enum:
+              - toradex,colibri-imx6ull-aster     # Colibri iMX6ULL Module on Aster Carrier Board
               - toradex,colibri-imx6ull-eval      # Colibri iMX6ULL Module on Colibri Evaluation Board
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
+              - toradex,colibri-imx6ull-emmc-eval      # Colibri iMX6ULL 1G (eMMC) on Colibri Evaluation Board
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
+              - toradex,colibri-imx6ull-wifi-eval     # Colibri iMX6ULL Wi-Fi / BT M. on Colibri Evaluation Board
+              - toradex,colibri-imx6ull-wifi-aster    # Colibri iMX6ULL Wi-Fi / BT M. on Aster Carrier Board
+              - toradex,colibri-imx6ull-wifi-iris     # Colibri iMX6ULL Wi-Fi / BT M. on Iris Carrier Board
+              - toradex,colibri-imx6ull-wifi-iris-v2  # Colibri iMX6ULL Wi-Fi / BT M. on Iris V2 Carrier Board
+          - const: toradex,colibri-imx6ull-wifi       # Colibri iMX6ULL Wi-Fi / BT Module
+          - const: fsl,imx6ull
 
       - description: Kontron N6411 S Board
         items:
-- 
2.35.1

