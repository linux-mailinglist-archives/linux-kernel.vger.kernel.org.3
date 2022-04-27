Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CC511A68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiD0N7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiD0N7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:13 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683881FCDD;
        Wed, 27 Apr 2022 06:56:00 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.156.240])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id DDE1D23D674;
        Wed, 27 Apr 2022 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.16) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 15:55:56 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux@roeck-us.net>, <wim@linux-watchdog.org>,
        <geert+renesas@glider.be>, <tzungbi@kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1
Date:   Wed, 27 Apr 2022 15:55:30 +0200
Message-ID: <20220427135531.708279-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427135531.708279-1-jjhiblot@traphandler.com>
References: <20220427135531.708279-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.16]
X-ClientProxiedBy: DAG8EX1.emp2.local (172.16.2.81) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5435281801727326673
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the WDT hardware in the RZ/N1 series.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index d060438e1402..e929d17ac995 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -19,6 +19,11 @@ properties:
               - renesas,r7s9210-wdt      # RZ/A2
           - const: renesas,rza-wdt       # RZ/A
 
+      - items:
+          - enum:
+              - renesas,r9a06g032-wdt    # RZ/N1D
+          - const: renesas,rzn1-wdt      # RZ/N1
+
       - items:
           - enum:
               - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
@@ -94,6 +99,7 @@ allOf:
             contains:
               enum:
                 - renesas,rza-wdt
+                - renesas,rzn1-wdt
     then:
       required:
         - power-domains
-- 
2.25.1

