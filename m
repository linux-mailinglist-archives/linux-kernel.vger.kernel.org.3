Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8056171D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiF3KC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiF3KCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670343EE1;
        Thu, 30 Jun 2022 03:02:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 45AE05C02FD;
        Thu, 30 Jun 2022 06:02:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Jun 2022 06:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656583365; x=1656669765; bh=jG
        T1Aqlir5YOa1Jj4uzaGOcAcI5p24r4qplRnLJRGKg=; b=fcCNrVvXTX6sbQWXOz
        XgFHYeoXDAa8AsgCaykTShC7Es1q0IyE4mNzgHmZS9FSBqnf3wr+vVZrqAweM2Cr
        dFkt4u2J5pRvcskcE4634YBITKiUouz4I3LTBAtW6Ngbhhk2DAeJM2xH7AgAGxeS
        wGVboHYxYxFC89gprbIAxePHmJOG0fu3+KITl9lHQh3JCn4jvBcoMXqEuF3azH63
        tVmwqo2JEDfBSBmFGiwi6Xl8RYnWGGAy5j9xTH7LLCn/VcZDRZfPNaoaoS4MiEyk
        bFjV+gaS2Mfrd1ViULbmz5FCU6B8gPURlEiJBDpdldC5kUzs23TGuiKttiU6eVbI
        UODA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656583365; x=1656669765; bh=jGT1Aqlir5YOa
        1Jj4uzaGOcAcI5p24r4qplRnLJRGKg=; b=GQJGimhtOtvdoO64hV8J8zap0HtLT
        LY/KQjNVqaBYJIeLBBrQy/tnO4m1I5xWtrFjIYjXpxyizg0KhQV5N3olgZz3j9on
        25pseu6P57ekwCFNZ2Omxr1TpUUdH13IzoCgqqrj+lZUvaLNrghBwn37pKtWr1s8
        AA11Mc1GsdA6oHZuDF+HB8sd48wgEGLOqoXe8BZV+zwxnJcSLqyvzha3xEP+B4M1
        yBmXag/0QO6jC8JVGi2kRK+CZ0LwQk+rjKGe17QrmbgijLwPxligfuI873PCkwoy
        t4BcyZFeC6H2afRZvNUDGq7BmUvsT+KjUcqNAGo6L82Hy/Cvkr3/R0UmQ==
X-ME-Sender: <xms:xXS9YmqUD1ncfYiaqK8HOp0zxfBm5EQ3xWDhpihl7KP9ybH0FhbPTg>
    <xme:xXS9YkqJp_C7dcPOOXu1UUcL8b5oDT0zkLSCG-3PIuIaRtXMipnK70KXtOY1Vj88z
    gWoU9BZcyCEG2JIBQ>
X-ME-Received: <xmr:xXS9YrNIRrDH-u3alBqCK2f4driRDxWFJgnCUOWf_M5FUVsqXZaWGtCLgnDsv_NZ0F9uCTnK2MXgJrIFL-S0bl0sCe18i9Ep-_Gl5-bsKF-55572C7VQ5aW0qREg4PShbn61Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xXS9Yl4yJbfIVW4KE82vLq8YfImSXuOMw0dIeY2tKMwjuA2jLidYgA>
    <xmx:xXS9Yl6qApWMkArsgucJuaFxDeVIN65iWcTHPV5N0ZwqZQFsh5EBSw>
    <xmx:xXS9YliaweoJ1kd05BbU58DVCrH5AYA3OQFo_O7jmF8_GrfhxK_yFQ>
    <xmx:xXS9YsoAU5ZbKv1hbRVP0uYorZfni2VcGi2et4h4yIPyw3AGbQVoIQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 06:02:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Five SoC
Date:   Thu, 30 Jun 2022 05:02:38 -0500
Message-Id: <20220630100241.35233-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630100241.35233-1-samuel@sholland.org>
References: <20220630100241.35233-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Renesas RZ/Five (R9A07G043) SoC is equipped with NCEPLIC100 RISC-V
platform level interrupt controller from Andes Technology. NCEPLIC100
ignores subsequent EDGE interrupts until the previous EDGE interrupt is
completed, due to this issue we have to follow different interrupt flow
for EDGE and LEVEL interrupts.

This patch documents Renesas RZ/Five (R9A07G043) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Add a more detailed explanation for why #interrupt-cells differs
 - Add andestech,nceplic100 as a fallback compatible
 - Separate the conditional part of the binding into two blocks (one for
   the PLIC implementation and the other for the SoC integration)

 .../sifive,plic-1.0.0.yaml                    | 64 +++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6a86c4..cd2b8bcaec3b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -26,9 +26,14 @@ description:
   with priority below this threshold will not cause the PLIC to raise its
   interrupt line leading to the context.
 
-  While the PLIC supports both edge-triggered and level-triggered interrupts,
-  interrupt handlers are oblivious to this distinction and therefore it is not
-  specified in the PLIC device-tree binding.
+  The PLIC supports both edge-triggered and level-triggered interrupts. For
+  edge-triggered interrupts, the RISC-V PLIC spec allows two responses to edges
+  seen while an interrupt handler is active; the PLIC may either queue them or
+  ignore them. In the first case, handlers are oblivious to the trigger type, so
+  it is not included in the interrupt specifier. In the second case, software
+  needs to know the trigger type, so it can reorder the interrupt flow to avoid
+  missing interrupts. This special handling is needed by at least the Renesas
+  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100).
 
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -47,6 +52,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-plic
+          - const: andestech,nceplic100
       - items:
           - enum:
               - sifive,fu540-c000-plic
@@ -64,8 +73,7 @@ properties:
   '#address-cells':
     const: 0
 
-  '#interrupt-cells':
-    const: 1
+  '#interrupt-cells': true
 
   interrupt-controller: true
 
@@ -82,6 +90,12 @@ properties:
     description:
       Specifies how many external interrupts are supported by this controller.
 
+  clocks: true
+
+  power-domains: true
+
+  resets: true
+
 required:
   - compatible
   - '#address-cells'
@@ -91,6 +105,46 @@ required:
   - interrupts-extended
   - riscv,ndev
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - andestech,nceplic100
+
+    then:
+      properties:
+        '#interrupt-cells':
+          const: 2
+
+    else:
+      properties:
+        '#interrupt-cells':
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-plic
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        power-domains:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+      required:
+        - clocks
+        - power-domains
+        - resets
+
 additionalProperties: false
 
 examples:
-- 
2.35.1

