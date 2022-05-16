Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3E5286B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiEPONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiEPONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:13:10 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2341393D4;
        Mon, 16 May 2022 07:13:09 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LhPqo-1nUl6x3I6C-00mdzP;
 Mon, 16 May 2022 16:12:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 23/24] dt-bindings: arm: fsl: add toradex,colibri-imx7s/d/d-emmc-iris/-v2
Date:   Mon, 16 May 2022 16:12:37 +0200
Message-Id: <20220516141237.494514-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QXZsBH9AP8Ag+GcUc3c97MC0S70wiijv0zXp7qIC0zM+kGYldlq
 HMKA3tcL3/3wTst65F2eMkht4sUQQlRb1DNxi3QGdM+pjTuV7RDC3QCRTORwxAAbH/ME02U
 JPtYxGoJsUn4jIRHsgj7T6qlF6YWyU4By3ANnfvKKIzS2u/PBBPaKmBQvTLeIiNAx+dai2z
 EpAZJkXaKxljTLv/49CAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJqGSkfmk1Q=:vxPKyZai4WyVoLpTsaHRS/
 DOf9Mtc9MoENGm03sR8gQtrXOSV5V5uCV1zFxwr3hxo24lNIZ1jTBIUMkFVA3zXbJJtfY/JvX
 o8kUoNkBxs4kx9zSoYiD3pR0Hn4dMr/IDDvGyTilpDeKJJ4op8WCA8b9bs8kDsa8jIL09oVuf
 eO6lJqYCZeLjhqAMu/3NpOjH/fotyGvXFSIXZcPjv1OBEmBcQ/5DFUMF1MOBtUlsibFpVneKr
 kIU0V3/vh8AaH8CYTr7nyMw/WaPptFW27JwfjJDO44lA+bYT2dpOe7S/F28kMIRS+a+evut4f
 cPoYBjecRN7CcQWHF0kHxD75I9NZH2U99KvXDPQCoyWVqP+Yo/qOGH1cRiX8rJC5EJxks7jYW
 68Ps+5VoMJih8YlBCgoJ/PqydUPRvsVsxDIt6XGtkfXreyuoXWH91zFnAF/9aE3Iz9P4fx3lT
 toOmXHpzgSWVNtvrZDAzcM+qyOv9f1847W80nV5l5OD48PLlbVkT984a7+7Z3O3Xx+e9RvN9h
 vLt6ULfH3AhVNLkY8v8lprhLSGtk7JaI3XI/xR7P0qcHz0kLIB5PQjFxiHOYrQPU4d4p2dK2T
 SQbk8CntVnza/KIPL+UHOesoPzbq+RfAwuYBJE8oSae18/Ya2p6L5yZadUTg/ADx3nrAU6xlB
 ODvurm8moLehHPuy//JN7YfHUGNmux1H3xV772y+8TRRY/9edB2Kg53OMJQYdXsGh6Ps=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Based on toradex,colibri-imx7s, toradex,colibri-imx7d and
toradex,colibri-imx7d-emmc module device trees add iris and iris-v2 for
carrier board dts.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- Add Krzysztof's acked-by. Thanks!

 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..17f38cc8d5ee 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -738,6 +738,8 @@ properties:
           - enum:
               - toradex,colibri-imx7s-aster     # Module on Aster Carrier Board
               - toradex,colibri-imx7s-eval-v3   # Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7s-iris      # Module on Iris Carrier Board
+              - toradex,colibri-imx7s-iris-v2   # Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7s
           - const: fsl,imx7s
 
@@ -791,6 +793,8 @@ properties:
           - enum:
               - toradex,colibri-imx7d-aster   # Colibri iMX7D Module on Aster Carrier Board
               - toradex,colibri-imx7d-eval-v3 # Colibri iMX7D Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-iris    # Colibri iMX7D Module on Iris Carrier Board
+              - toradex,colibri-imx7d-iris-v2 # Colibri iMX7D Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7d
           - const: fsl,imx7d
 
@@ -799,6 +803,8 @@ properties:
           - enum:
               - toradex,colibri-imx7d-emmc-aster    # Module on Aster Carrier Board
               - toradex,colibri-imx7d-emmc-eval-v3  # Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-emmc-iris     # Module on Iris Carrier Board
+              - toradex,colibri-imx7d-emmc-iris-v2  # Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7d-emmc
           - const: fsl,imx7d
 
-- 
2.35.1

