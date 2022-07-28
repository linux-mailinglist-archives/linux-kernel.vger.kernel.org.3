Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F1583C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiG1Koy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiG1Ko1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C15C369;
        Thu, 28 Jul 2022 03:44:13 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLdEDtMDv2f28r0mMALslYNuMci8ykm6/nOfguPXoa4=;
        b=q78KRdy8zqL4eGOz8aAh9bq3kzNJXbtkplep7ahTmTpi134Oi0wnt66k7ho0F8SbaYJDaY
        JI+t4mB6KyBoTy/qr50n1M5+WiLy3M11tl8i/rrunAx38qs3U+hDrNPYreDlwzeBuT4OPX
        JCggNJpV9a5AZOJVT7xqjrtHcTCiOPR3ijfAPnKKz6d9zYwBVxT9stifPZwg5Ce3TkeoSW
        ov+gwMwX70pGbsDBDf4iJXKPRbHM4mHokomJyU+fsrUojWrDei1s5fxPwEyLPuskP+3cGr
        bDdf5CX5VF+EymBWNP2iq/0602smpted6NZEnB8Ie/H2gu8YrbSDXCYLp4Pfqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLdEDtMDv2f28r0mMALslYNuMci8ykm6/nOfguPXoa4=;
        b=03FAgI75URz9irwsb6rgCWiiMNYoqORBXaMir2tyFmLZcWQAU86KlyxER/II21NrCkLY0G
        hPGvCShPXxobkACw==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: Add r8a779f0 and
 generic Gen4 CMT support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
References: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165900505035.15455.4848266440813874174.tip-bot2@tip-bot2>
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

Commit-ID:     525b296185b4b0abab0d35a7143fc5a99c385230
Gitweb:        https://git.kernel.org/tip/525b296185b4b0abab0d35a7143fc5a99c385230
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Wed, 13 Jul 2022 12:06:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jul 2022 22:55:14 +02:00

dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT support

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220713100603.3391-2-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 10 +++++++-
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 53dd6d9..7cc1ec4 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -85,6 +85,11 @@ properties:
 
       - items:
           - enum:
+              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
+
+      - items:
+          - enum:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
               - renesas,r8a774b1-cmt1     # 48-bit CMT on RZ/G2N
               - renesas,r8a774c0-cmt1     # 48-bit CMT on RZ/G2E
@@ -100,6 +105,11 @@ properties:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
+
   reg:
     maxItems: 1
 
