Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA8583C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiG1Kow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiG1Ko0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1BB61D73;
        Thu, 28 Jul 2022 03:44:12 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlSFYpmEy93tl7sfw3q5uyLN7zWK4AnXUitoQd8JaFE=;
        b=loxlyM7UYoEez1WCXutW42HVjjQFA0sPCxHJzaYqyvTx7X5nQBKJT+Sl5B/QXhLFb4zvXP
        TP3sF/7hmrnBeXuBL1yuuGBRFZxCKgGOq5d7ujJUWIlAczdFEzwwAO3H9HecDedK/aF97t
        0nmPATBtCzY6wVZk1m6WpOaRqNp2HzcA52i0nfqKSPDYVXepr4cvoibkPZQZclHoFzmVN9
        oUvuWMun0wWxV89q62ooIr0iI1E+lAkPqJ0xjRHVrOpa6PjnhM4/Qxat8pbudPtFerznLg
        FT6/aMiZzUb8+R48K7NxsMatS+9Yk5PR5WXP9j31TdzKSCCWdFhFsKvg5QC/fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlSFYpmEy93tl7sfw3q5uyLN7zWK4AnXUitoQd8JaFE=;
        b=ntTe3yHTlAb7F27imv0QV4l9mc7y9JVR3V5PmMkTzEqaNRkWnlSAWVjTuoV5B2EuNvJv3m
        fzqMYFTcZ7AGaaBA==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
References: <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165900504942.15455.13494792082103291421.tip-bot2@tip-bot2>
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

Commit-ID:     bd0ed737d5fda2ec55f915ed2c4f586363f71129
Gitweb:        https://git.kernel.org/tip/bd0ed737d5fda2ec55f915ed2c4f586363f71129
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Wed, 13 Jul 2022 12:06:02 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jul 2022 22:55:14 +02:00

dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family. Hence move its compatible value to the R-Car Gen4 section.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220713100603.3391-3-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 7cc1ec4..433ddb4 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -80,11 +80,11 @@ properties:
               - renesas,r8a77980-cmt0     # 32-bit CMT0 on R-Car V3H
               - renesas,r8a77990-cmt0     # 32-bit CMT0 on R-Car E3
               - renesas,r8a77995-cmt0     # 32-bit CMT0 on R-Car D3
-              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
           - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
 
       - items:
           - enum:
+              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
               - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
           - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
 
@@ -102,11 +102,11 @@ properties:
               - renesas,r8a77980-cmt1     # 48-bit CMT on R-Car V3H
               - renesas,r8a77990-cmt1     # 48-bit CMT on R-Car E3
               - renesas,r8a77995-cmt1     # 48-bit CMT on R-Car D3
-              - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
 
       - items:
           - enum:
+              - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
               - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
           - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
 
