Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1176A4E2E88
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbiCUQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCUQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:23 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCB174B8B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:51:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 04C2D32004CE;
        Mon, 21 Mar 2022 12:51:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=9y3qY8wrWheTjT
        yFytvtK0+0Iv19bnWaSl3QfjKyhtE=; b=ISBoBUMMt3OzLno+nSYoFli65K1ZSz
        AbdaLKHSwbymZunFKAyQYGiQBTTbK0RTc7lxD7MEheSKcLRR51CX5p38FmvlJ+cj
        hEj3/K/psPOfJ9IyFrIb8Bye44kElVoFb7I4nAP8k8/ESli4W6O4JKtSkjNan/lw
        TVndVZXWyhZtnYMlOopvgqDBo316+XeE1ttHovZmT0TmBViK9XHx0aK8TV+Rb86g
        Dbf5LYKwwQrpNsjcOYUclQrrJV+KC2RFe6RQlvdPPpK9EFQ66DAhpniEQ9Zz+d83
        KeFx1FTUDzISoTOrthEYZzlSBIDc731uLWLrOS3g3QfJdEzjN1yKCohw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9y3qY8
        wrWheTjTyFytvtK0+0Iv19bnWaSl3QfjKyhtE=; b=X2haQ2aO9+NkS8qcP9sWqk
        FdHkclNHA73VxP5HDKLh0XdAICTW0TqDAC4+sfL2OhTmx8fEnXEZrvHaxgTy368P
        LYO8a3+FPqg+5hbWZ7tITE7tMlXxFsVy6eHgObOJOr0ZlIVMbYRaZU2sDKDBfNGu
        2agmDFEeKIPLju6USst975OCpYi5dIWr1RreUkpasQMiqgPb1JciQhty2hEVGs0z
        759oUJ+kBEnJWKqZ57QP98uaNJX3slSS6PCYnZDfbJ4pEvCFqpJe0F4CivIjQDQ6
        uJre0OpG+8bvUFDesCZcRxFAGnNw+Q+9Ii85Jw1hugPww34YJH3+BeABL95HAO7A
        ==
X-ME-Sender: <xms:K604YtKw3LNSvCW-p4QK8A4wxSyUcAxB5u1gcgdMmYhv2wutDFO0JA>
    <xme:K604YpIRYkGR_tGGu-U4j7d354UtTzYjzMkeScTl-zamAceexg1B6QceuuZK6K509
    mCBPDv3F8C80gVhsWU>
X-ME-Received: <xmr:K604Ylv_gri0bH2MLg9pZA89456qZho5LtWdHZz9MONTSc92pAC00IjeBG4AhduUU8i9agHiGsZwYPtfL8ndGn_eP1kxWUiNwcVf027hs6DQiV-dTJLiiz3SUvDq1ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:K604Yubn-ddi9FXPSqQwJaI04ArdpYP1RjMfYbHRza6cp71cjdBDFQ>
    <xmx:K604YkYlDPR1e4ybUFR41YkFviNzrbWw5qbLqWhex6ln366RaFtrcA>
    <xmx:K604YiBfF2RpT-OBkePv-njusnqzQ_lT49WvL8WV6gp7i1zg4CCmbA>
    <xmx:K604YgSoBBN6cPNB8AJnCh9i95TLbs_nIV-lqTbhhjuIry0SxlVtAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:51:53 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/9] dt-bindings: soc: apple: Add Apple SART
Date:   Mon, 21 Mar 2022 17:50:41 +0100
Message-Id: <20220321165049.35985-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs such as the M1 come with a simple DMA address filter called
SART. Unlike a real IOMMU no pagetables can be configured but instead
DMA transactions can be allowed for up to 16 paddr regions.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/soc/apple/apple,sart.yaml        | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,sart.yaml

diff --git a/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
new file mode 100644
index 000000000000..d8177b3a3fba
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/apple/apple,sart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SART DMA address filter
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  Apple SART is a simple address filter for DMA transactions. Regions of
+  physical memory must be added to the SART's allow list before any
+  DMA can target these. Unlike a proper IOMMU no remapping can be done and
+  special support in the consumer driver is required since not all DMA
+  transactions of a single device are subject to SART filtering.
+
+  SART1 has first been used since at least the A11 (iPhone 8 and iPhone X)
+  and allows 36 bit of physical address space and filter entries with sizes
+  up to 24 bit.
+
+  SART2, first seen in A14 and M1, allows 36 bit of physical address space
+  and filter entry size up to 36 bit.
+
+  SART3, first seen in M1 Pro/Max, extends both the address space and filter
+  entry size to 42 bit.
+
+properties:
+  compatible:
+    enum:
+      - apple,t6000-sart
+      - apple,t8103-sart
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    sart@7bc50000 {
+      compatible = "apple,t8103-sart";
+      reg = <0x7bc50000 0x4000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a34a..027c3b4ad61c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1774,6 +1774,7 @@ F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/soc/apple/*
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
-- 
2.25.1

