Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E7489911
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiAJNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiAJNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:00 -0500
Date:   Mon, 10 Jan 2022 12:59:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ6Ye0uuFdMst4rEudlCTppY20fijxX/9cct2ksf7Sw=;
        b=NPckK+Dm2BwGwXfLaQwMn/k9W48Y8CMJcCy4xfgTeHfxxZwyCNsf+8TqXr7vrrrc7g7kbU
        faJBcUx93J1SsAwm0Un+bu0DERvdwsrZhLtZBJfsJJ9igDqpZ6M7/F5Huu8YOrYr9jNgQL
        NKBQ6KnQzgjC+9fy4BrVFvO/TL1VCoS1mLA9ekyUIBD8E0XMdG1MPOhGMlxiTFpCoK7UGd
        HNOMcp0GO0U9owH9IZVh1AkeJccYumsSLzgwLBoalXZYYU4jyAwXyKxmcu8aoDe19idmyj
        Ghyp41NiUjPdhBml0bwXCIQ1o5W+LmL4axIHjy5TjvGosdJ+5vmswILGnULDvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ6Ye0uuFdMst4rEudlCTppY20fijxX/9cct2ksf7Sw=;
        b=09GCh5YCSpiumtTqOxH5OfXo965CnNuOMz5Nn+LUWWGcpkuPvuOp1Gip9OvAGm8L7r64Bd
        6tyHSYEbqYtVZQDw==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas: ostm: Document
 Renesas RZ/G2L OSTM
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112184413.4391-3-biju.das.jz@bp.renesas.com>
References: <20211112184413.4391-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164181959725.16921.15084822049529058224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     92d06a3f67ad809649d26aa7698e4d42362585a8
Gitweb:        https://git.kernel.org/tip/92d06a3f67ad809649d26aa7698e4d42362585a8
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 12 Nov 2021 18:44:11 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 14:05:20 +01:00

dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2L OSTM

Document the General Timer Module(a.k.a OSTM) found on the RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211112184413.4391-3-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 20 +++++--
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 600d47a..7fa7f97 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -21,9 +21,10 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r7s72100-ostm # RZ/A1H
-          - renesas,r7s9210-ostm  # RZ/A2M
-      - const: renesas,ostm       # Generic
+          - renesas,r7s72100-ostm  # RZ/A1H
+          - renesas,r7s9210-ostm   # RZ/A2M
+          - renesas,r9a07g044-ostm # RZ/G2{L,LC}
+      - const: renesas,ostm        # Generic
 
   reg:
     maxItems: 1
@@ -37,6 +38,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -44,6 +48,16 @@ required:
   - clocks
   - power-domains
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r9a07g044-ostm
+then:
+  required:
+    - resets
+
 additionalProperties: false
 
 examples:
