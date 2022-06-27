Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717955B703
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiF0FNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiF0FNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:13:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F013888;
        Sun, 26 Jun 2022 22:13:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 005F65C019D;
        Mon, 27 Jun 2022 01:13:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 01:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656306780; x=
        1656393180; bh=6AYLrxKS1kGzYaCKlRypTFspscTKmPnJSs3erP6wz1w=; b=k
        dOF4mlRrncMvmxqTBXFJv0uZzvqiAuA+WGEzPTn1W4cS/eLTvrJDBvrEZZp2bSwZ
        u8/u7FBDthN7jNyokEAYT9XDrp57cBNVFkxbzELBBeVpTl4PKRfPYfZ9EWzrEvEL
        mNapWNuvdj65vengO3Q33z9Csoim9rZ6aUYx704JQrdrzeLc5j3/X9MJBwD30gOl
        OT2ZdySuFgrZag3Fum3cqIQn9DrkZq+1gt27KmR/m6kLAhRtJOEfCAwabJpC5+Y2
        jewJHdzY51M/RV1VykQ5FcXQ4+7H9mFxrN2Q7apOUOEKd3Y5GmtI6diXBfjG0NFw
        DGTU/YyVdMUZBHPvUadfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656306780; x=
        1656393180; bh=6AYLrxKS1kGzYaCKlRypTFspscTKmPnJSs3erP6wz1w=; b=E
        shgTd6PCY3pBsBTMsG1M4fmh046VCXqVhwm76Mn1oFAI53fiehbtRxEGH/xj4jYt
        Rq6Vmk1fh56mWkECA6TugPJBhiw3PhdDjUHnkmc/Cm4gNf8Y/QJII1XuFmYJ0aqu
        LUUSJ8feloAHkrGq7CcT82KL3D6QtvDmdTUn3r/EODHfQ8vsGfl0sJneLiqsk/Zb
        wc9Q53+dZpq2hcqlBA72o4jBWK4yvXNrEJUGcEqysqs+jmx47CIv3/Aa0BJ29EYw
        fz+aIJCmbX5bcqZLtZxJd45PiZ3s1JRDT1dFE0V9Wlu71zB9T0XDb/kGGe/QfQcu
        n0YFwQ+R+SYDG8WmW8xzg==
X-ME-Sender: <xms:XDy5YtH9pZjtNAbxdV8mzNlzyPlr9SoC1l0TGKm5nBiHiPe3z6YXGA>
    <xme:XDy5YiX0WKOg7d2xAURsJHyKVc4AB4n5PiuYGOLmzZbm4rZAlUPDfwaIvPejbWMxy
    fbxYmrobAhNNnVJHw>
X-ME-Received: <xmr:XDy5YvKJtZemoheUFT4GqId1D9TNB2iHUP1gH0Xm3pDj2zckJ8tr8uK1NYBWJbCVxUy7mnGERCwOWI9ZKvxiI6oiNBHfqIpnU_AEqmcdX9e4bmVc16cFX3_AUI8XOxVg7KprZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefueevueeffeelheelhfelgeelgffgieekffevteefveejueei
    teeugfefieehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:XDy5YjGUNv6nFuvTlJww6T9FPCa7tspQXaKLIUtomJ0SPQYv1eBsoA>
    <xmx:XDy5YjXj0J0WGxBSFnpA3vK_3OVY5VRh_2qlm6r975-bvx8prT-dQQ>
    <xmx:XDy5YuP31Mll77E93ALVaCbQA1YXz9Xg--LM768PxgtEFDa5V-RpmA>
    <xmx:XDy5YnnirgDeDCNioq19GZoXn0Y0BRU7ntHSG0MkcYfYU6dbvmT1xg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 01:13:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/3] dt-bindings: interrupt-controller: Require trigger type for T-HEAD PLIC
Date:   Mon, 27 Jun 2022 00:12:55 -0500
Message-Id: <20220627051257.38543-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220627051257.38543-1-samuel@sholland.org>
References: <20220627051257.38543-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The RISC-V PLIC specification unfortunately allows PLIC implementations
to ignore edges seen while an edge-triggered interrupt is being handled:

  Depending on the design of the device and the interrupt handler,
  in between sending an interrupt request and receiving notice of its
  handler’s completion, the gateway might either ignore additional
  matching edges or increment a counter of pending interrupts.

For PLICs with that misfeature, software needs to know the trigger type
of each interrupt. This allows it to work around the issue by completing
edge-triggered interrupts before handling them. Such a workaround is
required to avoid missing any edges.

The T-HEAD C9xx PLIC is an example of a PLIC with this behavior.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../sifive,plic-1.0.0.yaml                    | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6a86c4..3c589cbca851 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -26,9 +26,13 @@ description:
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
+  missing interrupts.
 
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -65,7 +69,8 @@ properties:
     const: 0
 
   '#interrupt-cells':
-    const: 1
+    minimum: 1
+    maximum: 2
 
   interrupt-controller: true
 
@@ -91,6 +96,24 @@ required:
   - interrupts-extended
   - riscv,ndev
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - thead,c900-plic
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
 additionalProperties: false
 
 examples:
-- 
2.35.1

