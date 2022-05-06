Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33251DCA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443231AbiEFQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbiEFQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:00:56 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB596A41C;
        Fri,  6 May 2022 08:57:13 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLeLd-1nnHR63tLf-000ujU;
 Fri, 06 May 2022 17:56:48 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/24] dt-bindings: arm: fsl: add toradex,colibri-imx7s/d/d-emmc-iris/-v2
Date:   Fri,  6 May 2022 17:56:41 +0200
Message-Id: <20220506155641.297635-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MIBq7VmBWdumJlhEmmFZ9pFOrRTLHXH6JSSHx3/t+CQEcsT2SnQ
 VILaYSB4teWeca3P1jB4iw/Wq+2IjELA/IqUEGprZDEDD8HXXrMV26wW6hx73/XJqF6pOyc
 N4hc/J+u7pLenRGlEs1+Hfcu+PAXpBqrRakwLYJzZKXj8Bd9PUvTg70giQaXmYMJ2c+NkqA
 t4zpPWQC20CVcrSGXaNlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dCfLu27PQ+Y=:c7NneQq96GlxozMB52Zibj
 b0E4VroDzijPwuwg7esJtIeUG/h0e/S4uEkG36WwMkGZizz7utrRrFtoNr2vBqqWZ8CR1YXXx
 qjXBtEJl2Qa6IRO7HwjhOH7mwLHidudzErR8vBrZI3DQ/rMzZZYpLzcQMNXp7icJMvp4z4kT3
 KFoIWuUtLCLuZvAc4PYzQOFHT7z4g0xHFUC33eD2bPqU5aR0RZ+/iuThwDhnXHIju+hL1oSxX
 pUYoa3ur1qfUZhni4rU9wpxIhnOyEC8t188zGWHOrltJQflCuYTNPlbY8iLW7cWKUtEpNPoyE
 cVyF4TdibVweo+8p5hzrFRJMtzLxupN0+1yi0Q0mH1gD1igPfehyp57nzzd/Oz/Ie8WXaf10F
 JvcinSFMzKAb3DbVXAYe6HgTdAIPecEy8WyUkj9H9RyK3CIPlnzjxVngFrXGgB3PNjKG0XlnQ
 1vn3jqdY5CTm2E2ogXWPIEQnpIRhfP2DvCc8Z299FdH5OeToutXISHqLiay2IbkIiVWSCodQK
 6knnGD9acTy8vt0AYEWG7tje3hf4/vWqAeSaM6S21l5Gy3VfQNtKEbaBUtb2FAFchYh60PvDd
 ZSvEodxgpqIZwN/I3EBLU2ehdOx3wDYe2EAkQ04bLba1tNd2QJjxW52SDctvMSnj/W5jbF/V5
 rnTn/vaz3F32HFiRh9oESn8z6RGIsVt8y/YC3rAg9otGGiotCglVE9MKB/UOdfIE6OWsgEhAl
 l+Wf+f3R+g6H9B3CXRUCA1K7/uEcZnu4JN0b6HETnX8MeuTcxGYH7sAyL+q4yzA5I7awE+WI5
 3GuDA96HmBmHUiPDFSPvnqshOSD/Q==
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
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..3494a3f2a587 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -687,6 +687,8 @@ properties:
           - enum:
               - toradex,colibri-imx7s-aster     # Module on Aster Carrier Board
               - toradex,colibri-imx7s-eval-v3   # Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7s-iris      # Module on Iris Carrier Board
+              - toradex,colibri-imx7s-iris-v2   # Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7s
           - const: fsl,imx7s
 
@@ -739,6 +741,8 @@ properties:
           - enum:
               - toradex,colibri-imx7d-aster   # Colibri iMX7D Module on Aster Carrier Board
               - toradex,colibri-imx7d-eval-v3 # Colibri iMX7D Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-iris    # Colibri iMX7D Module on Iris Carrier Board
+              - toradex,colibri-imx7d-iris-v2 # Colibri iMX7D Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7d
           - const: fsl,imx7d
 
@@ -747,6 +751,8 @@ properties:
           - enum:
               - toradex,colibri-imx7d-emmc-aster    # Module on Aster Carrier Board
               - toradex,colibri-imx7d-emmc-eval-v3  # Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-emmc-iris     # Module on Iris Carrier Board
+              - toradex,colibri-imx7d-emmc-iris-v2  # Module on Iris Carrier Board V2
           - const: toradex,colibri-imx7d-emmc
           - const: fsl,imx7d
 
-- 
2.35.1

