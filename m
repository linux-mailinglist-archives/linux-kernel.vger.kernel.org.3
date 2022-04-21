Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3F509F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384479AbiDUM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384458AbiDUM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:29:43 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A94C30F7F;
        Thu, 21 Apr 2022 05:26:52 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 307C983E70;
        Thu, 21 Apr 2022 14:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650544010;
        bh=jTzOrrLX5p76V4PIgn+6DJMA3gnS1BUdXP25NkDtKDY=;
        h=From:To:Cc:Subject:Date:From;
        b=C7yd4Gq8UNjnTG5LEok52Uq7fBN2utEOTkzVVg6xx4vLmLRvh28c44ylhMUUu11AF
         rmXtdv+pglZw6/RxDnf3IlnNEO1rhc/V9+CaZUeIpfyoZIkkML2sy46eacGPBtmYf5
         SBUXtxukX9joNXKcs8Kys11FGQ7xIz7aJbIB9v2pMft5D754kb39H23GKWIE/s3buE
         tCJqe4qMWmwTrLhM893afkonLAAMCj8WXx5NQpAn0AtB8IqP2ddPidt/3fZG6gv1EO
         vJ9Z2SagaVOuweaXGSpWF9APcPcT9VyK2gm9wm4fD+9TO0jOVNvRWAe01vNRmXyRMD
         SjLhlGFxuBFbw==
Received: by janitor.denx.de (Postfix, from userid 108)
        id D7102A020E; Thu, 21 Apr 2022 14:26:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 4234EA0165;
        Thu, 21 Apr 2022 14:26:40 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id BAE283E098D; Thu, 21 Apr 2022 14:26:39 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>,
        Philip Oberfichtner <pro@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: Add bosch acc board
Date:   Thu, 21 Apr 2022 14:26:18 +0200
Message-Id: <20220421122619.1913496-1-pro@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..9deb568761c1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -192,6 +192,7 @@ properties:
         items:
           - enum:
               - auvidea,h100              # Auvidea H100
+              - bosch,imx6q-acc           # Bosch ACC i.MX6 Dual
               - boundary,imx6q-nitrogen6_max
               - boundary,imx6q-nitrogen6_som2
               - boundary,imx6q-nitrogen6x
-- 
2.34.1

