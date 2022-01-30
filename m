Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901FC4A368B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiA3N46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354916AbiA3N45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:56:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB1C061714;
        Sun, 30 Jan 2022 05:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 909D6B8293F;
        Sun, 30 Jan 2022 13:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CFEC340EB;
        Sun, 30 Jan 2022 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551014;
        bh=mtArtRxdfzyYRARE8Hm/YmQshbmLOFqK8TABaYcosT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI3Xl5BSUthtIvycI3fPzWvSaJxLenQTli/9DMmN1fjOgB5XHwFyHwTaQF/e0fCPH
         hF1mqP7UELHSJBfYPMmbEzF3SM2ty7l34ckjXiMM4Gn0B6ORt89YDIJdhCrTNgiD7X
         xVwGOei/tJbSYL9MPYY2SOuZAZd985NMhtz0VjicDyTY/4JYZY9FagzYPRkOCzzGxS
         fcHhqeJmRNzTO2klk3HUJc1AUd97FJHq0gZLaSIK81uDwcPAq6NeuJsbA/QZqWhVc+
         RWe4bnW4fXTOhvx/1Zac1NXO7eRWj2v5pGSCRQMDV3r41Ugd+ylEy2cuheef2gRocs
         JQbddqAT+EPNw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V7 1/2] dt-bindings: update riscv plic compatible string
Date:   Sun, 30 Jan 2022 21:56:33 +0800
Message-Id: <20220130135634.1213301-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130135634.1213301-1-guoren@kernel.org>
References: <20220130135634.1213301-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel@sholland.org>
---
 .../sifive,plic-1.0.0.yaml                    | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 28b6b17fe4b2..1fa5aa7e4c2e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,10 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  The thead,c900-plic is different from sifive,plic-1.0.0 in opensbi, the
+  T-HEAD PLIC implementation requires setting a delegation bit to allow access
+  from S-mode. So add thead,c900-plic to distinguish them.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -42,12 +46,17 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-plic
-          - starfive,jh7100-plic
-          - canaan,k210-plic
-      - const: sifive,plic-1.0.0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-plic
+              - starfive,jh7100-plic
+              - canaan,k210-plic
+          - const: sifive,plic-1.0.0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-plic
+          - const: thead,c900-plic
 
   reg:
     maxItems: 1
-- 
2.25.1

