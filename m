Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C34B0DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiBJM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:57:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiBJM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:57:15 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4521BD;
        Thu, 10 Feb 2022 04:57:16 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 401852223A;
        Thu, 10 Feb 2022 13:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644497834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CrzK4PGpcNHgTpL3p110IRd0uMzxauCazGL19v9OP+M=;
        b=krl0F7ztyY3olTsgaLNVbVdQ5YmC0qf5hqeFCg6y3f7bFhOrqmNUru4ufq8UE+6ag4+eeH
        TnikmLYkN3dCJCEoLuxoRQKydo34RKkvHLd64z30yfrmd1qYvXfIRq7BCK3jjqzXoLhfgO
        gtCP+4ebGXFqwXFZnqSAXLLCWLN/GKs=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] dt-bindings: arm: at91: add Kontron's new KSwitches
Date:   Thu, 10 Feb 2022 13:57:05 +0100
Message-Id: <20220210125705.481612-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kontron KSwitch D10 MMT series ethernet switches features a LAN9668
SoC with either 8 copper ports or 6 copper port and two SFP cages.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/arm/atmel-at91.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index c612e1f48dba..e019e79f9551 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -174,6 +174,20 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Kontron KSwitch D10 MMT 8G industrial ethernet switch
+        items:
+          - const: kontron,kswitch-d10-mmt-8g
+          - const: kontron,s1921
+          - const: microchip,lan9668
+          - const: microchip,lan966
+
+      - description: Kontron KSwitch D10 MMT 6G-2GS industrial ethernet switch
+        items:
+          - const: kontron,kswitch-d10-mmt-6g-2gs
+          - const: kontron,s1921
+          - const: microchip,lan9668
+          - const: microchip,lan966
+
       - items:
           - enum:
               - atmel,sams70j19
-- 
2.30.2

