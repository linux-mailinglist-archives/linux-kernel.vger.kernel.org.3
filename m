Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C39502BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbiDOOXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354507AbiDOOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:23:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87647986F3;
        Fri, 15 Apr 2022 07:21:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AC8F5C01E0;
        Fri, 15 Apr 2022 10:21:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Apr 2022 10:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1650032466; x=
        1650118866; bh=Tkrx4UCsThsuuZmAg3jLgWOGXjOhgnkx7b8zjDQpi8A=; b=m
        F+qBGKDwvkqMNuB5SL3EyoDyCLVEq3w1J7a8UVrzfBmMLg0BjUYA+SR1b6EdSpsQ
        bxR/B44VBg+wM0qGWjOXLMJ7VVXsUUBxXPwwKeNzbObJg1eozP7CDgw9sz5NIUMr
        zlfUq/vjoEY41UXQrukpiiegf5blrD1Zvcord9KgjXhWTCWvk3CNF4a7Mcz7zc5F
        DH7D6FOTSnMujzp91aS3blgHe6FachcbK6Hyr8AF36y3cSNAue5a/0LdVilaZ/n6
        uUwlnfi9P63BTRDsSSKkb0STBMdR15BL2hX1eNS0geKxjNRkk/OqguMSIwncW05o
        EfhhyG/KZDsOuRxa6hGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650032466; x=1650118866; bh=Tkrx4UCsThsuuZmAg3jLgWOGXjOhgnkx7b8
        zjDQpi8A=; b=DhtEoNpgd280U4Fb4Oae++gtIs2iQwoqXpHV5fLHY6GsgZd08x0
        Gke7HlZ0Ad+uIgKoPf9H8PLVySM7W27dhT7COSrcs12BLCkvjycez72S8DHJ7QHS
        rtuOtsThjhKQezyaHCRkJHyP4cVxJ1ecFBF87Ct7OToQaWN5mxmnvxPW7cY+Erfo
        V7Pc8lsL0F4+HX1k1ZwHuDrZw9DFv9rwPv5g3lVJZvbyt+ugsSu5KfFFMsuayjWZ
        WvNxdHuTqRv0HebgRjPsfiGvidFeq5IPA0orF3Msi2Dm6iKm7OLou/YIQQvR/MhR
        uN0pe7cWzAySDMERgPV4lkwIT8bj1bUnqFQ==
X-ME-Sender: <xms:Un9ZYlzVRb6DlE30HqmEEFdrAv-IzjyAKmfwGo36sf36_pA0v9ALTg>
    <xme:Un9ZYlScMoKtxmWZdH_sfLXap1NoOhWkdWD3X3VB-A1Xf3dOWqqZSs2GwWCllz9AL
    j09nVzRfYU_D12pCLY>
X-ME-Received: <xmr:Un9ZYvVf0NTdy-2KJx4rugHEG-keaRz1yn3SwAl3qBeP85g8gVGKhPJ5AWYlrFSHWoNWJq7xTxqptefVsTcAckArxaYPW5R2C4P1UiPxP77z-fBiBwemflB8Fbaaktw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:Un9ZYnhlrgNqxvC2RquyIMgEwI7VbTmFA_CF8LSxX9qCqbcfW8eMDg>
    <xmx:Un9ZYnDIThdLARJLj33INVNZg1UYue4X1o7xj6TQbWQ3csxo0EHIrw>
    <xmx:Un9ZYgKUxhwXbyBaxB8YjgQQrjljK0GXl304ufI3B06hRkW4YI1E4g>
    <xmx:Un9ZYnyywMm_il80ln2cDeO2JkGuYNVUiPRLADsjkHR-BX6nYt54Gg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:04 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: iommu: Add Apple SART DMA address filter
Date:   Fri, 15 Apr 2022 16:20:50 +0200
Message-Id: <20220415142055.30873-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220415142055.30873-1-sven@svenpeter.dev>
References: <20220415142055.30873-1-sven@svenpeter.dev>
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

Apple SoCs such as the M1 come with a simple DMA address filter called
SART. Unlike a real IOMMU no pagetables can be configured but instead
DMA transactions can be allowed for up to 16 paddr regions. The consumer
also needs special support since not all DMA allocations have to be
added to this filter.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
  - Moved to bindings/iommu since it is "Close enough to an IOMMU in
    terms of its purpose" (Rob Herring)

 .../devicetree/bindings/iommu/apple,sart.yaml | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
new file mode 100644
index 000000000000..1524fa3094ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,sart.yaml#
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
+    iommu@7bc50000 {
+      compatible = "apple,t8103-sart";
+      reg = <0x7bc50000 0x4000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..4961da640e82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1836,6 +1836,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
+F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
-- 
2.25.1

