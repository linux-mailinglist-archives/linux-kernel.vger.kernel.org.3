Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAA4B0E40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiBJNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:18:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiBJNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:18:22 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAF24F;
        Thu, 10 Feb 2022 05:18:22 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 306B92223A;
        Thu, 10 Feb 2022 14:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644499101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C8tNsmFwAl/pwyP5rr2PBLk9G+wdOYB4a+CNX0oUTrA=;
        b=CXnAG7GsSE+J7GEhexQn4K1g1eXywqfzbKUxHfsKGFsaUe1ojQ45MZirgpuLaCSIBCEBY5
        n3QH0BipSvwW2oC4lJuZWSaSg6wne6ipyAAwuL1ibPXKak/nJcK90a4gTOqAZWSivKvXmo
        l1Aw5eoKBszuy816tvAjgIdz69l+Ivw=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] dt-bindings: arm: at91: add Kontron's new KSwitches
Date:   Thu, 10 Feb 2022 14:18:17 +0100
Message-Id: <20220210131817.484922-1-michael@walle.cc>
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
changes since v1:
 - just use one entry with an enum, thanks Krzysztof

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index c612e1f48dba..9d46ff78739f 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -174,6 +174,15 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Kontron KSwitch D10 MMT series
+        items:
+          - enum:
+              - kontron,kswitch-d10-mmt-8g
+              - kontron,kswitch-d10-mmt-6g-2gs
+          - const: kontron,s1921
+          - const: microchip,lan9668
+          - const: microchip,lan966
+
       - items:
           - enum:
               - atmel,sams70j19
-- 
2.30.2

