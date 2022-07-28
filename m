Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893F7583C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiG1KoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiG1KoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57867558CD;
        Thu, 28 Jul 2022 03:44:05 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st4Na396E3whXPgaEVqtSrCAkr8j6tVWc9aWRs4+Y8U=;
        b=Y4oXXFzF7wffX3xM5fKnyqnPIe9Jo0nkTSB7Awbuu6n9BepM0fneZm5QwQJZxqI+4pXSHL
        7RsfsB3QXar9NCu6jXftx+G1DzB/2mxIIJlHKHjV7t2GOzO358MikdJBzRaAFix0jkDvoe
        2f213Q8vSf1IPFG7gF/GHbBu2dFNKdM6jtdDqkSG66FHVV/vUiEihz5hXxEm9JTiUk5Wt8
        Nznrdk3P3hx/iIYeyTuCJvM9trxTA7+OwJbQLRnKsNAOXUEf6G8dc6CA9ko6WcvHknYs1J
        amzBWdHkmZP7ql3XGNWNUu3OgWsl4JzLZwyqIjnlsKzBUwASIA3o/3jfUWKobA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st4Na396E3whXPgaEVqtSrCAkr8j6tVWc9aWRs4+Y8U=;
        b=HCYSN+z3pwFMvNcq0kPlCIDLI/9xs6I+ngGMc+JhyW08+R7lTXXXo6m4LmLLCID8+1UBsB
        TZ6hH7ZbY8glsNAA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2e3863ae32e17d49f41111580f195dd34e2b769d=2E16583?=
 =?utf-8?q?03544=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C2e3863ae32e17d49f41111580f195dd34e2b769d=2E165830?=
 =?utf-8?q?3544=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <165900504266.15455.11509575109230948986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4abb38595b1b116bd1440c76c69c9f0416ec55a4
Gitweb:        https://git.kernel.org/tip/4abb38595b1b116bd1440c76c69c9f0416ec55a4
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 20 Jul 2022 09:53:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:01:52 +02:00

dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out

Restore sort order (by family, followed by type).
Update the conditional sections specifying the number of interrupts.

Fixes: 525b296185b4b0ab ("dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/2e3863ae32e17d49f41111580f195dd34e2b769d.1658303544.git.geert+renesas@glider.be
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 14 ++++---
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 433ddb4..bde6c9b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -84,12 +84,6 @@ properties:
 
       - items:
           - enum:
-              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
-              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
-          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
-
-      - items:
-          - enum:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
               - renesas,r8a774b1-cmt1     # 48-bit CMT on RZ/G2N
               - renesas,r8a774c0-cmt1     # 48-bit CMT on RZ/G2E
@@ -106,6 +100,12 @@ properties:
 
       - items:
           - enum:
+              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
+              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
+
+      - items:
+          - enum:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
               - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
           - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
@@ -145,6 +145,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt0
               - renesas,rcar-gen3-cmt0
+              - renesas,rcar-gen4-cmt0
     then:
       properties:
         interrupts:
@@ -158,6 +159,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt1
               - renesas,rcar-gen3-cmt1
+              - renesas,rcar-gen4-cmt1
     then:
       properties:
         interrupts:
