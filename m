Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2151DB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442545AbiEFPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347628AbiEFPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:01:33 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222465D5CE;
        Fri,  6 May 2022 07:57:49 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MQxpY-1nOHFZ2aKM-00UHck;
 Fri, 06 May 2022 16:57:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
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
Subject: [PATCH v1] dt-bindings: arm: fsl: correct 1g vs. 1gb in toradex,colibri-imx6ull-*
Date:   Fri,  6 May 2022 16:57:20 +0200
Message-Id: <20220506145720.291735-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hrTXd9ML7/8mbQ7BFDHnSRwiJvYdsNGQKEJKZTa9KvFBM/NoAUn
 oRodN4cJXoP9pklWV8gbzGYFmvw8VchuxwPfwS0F3qMBDROrTtGVgVpHCqqgc/nmdRC3zh0
 sa7k+tsZe20866nvjIB9/JhDTwrQoFQHK3GN9A02cvtzjj6Z+NNSbIOFE6VJBhPsrtBDFvG
 TR1tb3zjIAq1fIi+lJ04A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jb3f6uUQYhk=:8dJcMqWU+DbWo6I+gdb1YJ
 +1qd50tNI8PYyIHXFTYlm1c4+U+skpnM7YVVIPXI98elt62qOspPjbT9RdSCTX7vM7IfQPqam
 sGWvwHrUbkC0/tBJoNfAmvWaViZ2Ny7GorA868uXQGjhWpy1Ed5ZT39uDdcYOCPXVWijHYgkl
 7dL+xknIuSlBHxivxDp293q+UIzfxcgFjYNuJHAZbs0s4dJnDFKLkNtBofpkvhB6qM+PQTdUB
 1rLHctxB/rl5RGcFGBaCvyDY5V/d/DjYqn5WssEW8psYKI9Qst9UJSz4HqA2lLkH3O2vsvbDS
 B8yfh1W8JOspZvOYWU+Rj4OXK1QALx0IK24pgBNcP2S+dGlduTVCg8GjiZG8p8G0EN2njYpYQ
 SpFE3zf4BHo3WFksJWs/iADBcusCSqbo0xyyVRW7J3VuIhqgPV+DgRx0WMHnBo06MXoNxTDJj
 NFpnHlrtbHeoR9YRlexM4RSjqvld+DqB4E+xdBTAZlacLi/FgVWjCkmV9ijs2uo9obh7kWz5O
 VDYkpUNviVyQBlEBzT5Ah5K1QB7JJCe7MqBKXzSeNL0huiqg8GVnncjuimj7aoWDvNne0RudK
 1NI+j5mThT2oTAO+1blyvG0O7ojiqP+8wdFrAe9u0/dMlQEyDJwLFa3y5NuNg2Cb1+kpUvknD
 5cAzV0UWNsqcvNrmwieU20R/NJkjAT/8Z83VWq5jeaJCDdETohYW9jXGm1NafiqLKzmQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Correct 1G vs. 1GB typo.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..c81a130c3e7e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -680,10 +680,10 @@ properties:
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL 1GB (eMMC) Module
         items:
           - enum:
-              - toradex,colibri-imx6ull-emmc-aster     # Colibri iMX6ULL 1G (eMMC) on Aster Carrier Board
-              - toradex,colibri-imx6ull-emmc-eval      # Colibri iMX6ULL 1G (eMMC) on Colibri Evaluation B. V3
-              - toradex,colibri-imx6ull-emmc-iris      # Colibri iMX6ULL 1G (eMMC) on Iris Carrier Board
-              - toradex,colibri-imx6ull-emmc-iris-v2   # Colibri iMX6ULL 1G (eMMC) on Iris V2 Carrier Board
+              - toradex,colibri-imx6ull-emmc-aster     # Colibri iMX6ULL 1GB (eMMC) on Aster Carrier Board
+              - toradex,colibri-imx6ull-emmc-eval      # Colibri iMX6ULL 1GB (eMMC) on Colibri Evaluation B. V3
+              - toradex,colibri-imx6ull-emmc-iris      # Colibri iMX6ULL 1GB (eMMC) on Iris Carrier Board
+              - toradex,colibri-imx6ull-emmc-iris-v2   # Colibri iMX6ULL 1GB (eMMC) on Iris V2 Carrier Board
           - const: toradex,colibri-imx6ull-emmc        # Colibri iMX6ULL 1GB (eMMC) Module
           - const: fsl,imx6ull
 
-- 
2.35.1

