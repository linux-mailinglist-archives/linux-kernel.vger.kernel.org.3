Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C00510A35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354864AbiDZUT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354899AbiDZUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A271B3B1;
        Tue, 26 Apr 2022 13:15:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 11B505C00FF;
        Tue, 26 Apr 2022 16:15:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 16:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004153; x=
        1651090553; bh=gu8wjFAZS//ewmI6BDwb6NDbCp4RXdlDD2CfzD/0XzY=; b=S
        zwzOMT1tPSRi5s5VrAwaWpvIPdBYeWKZNlcTvYbWLGQCmT4vTOF1jpbunibHD1SK
        jgNVwIrF3JsC/rgyxzBGVyLs/ssqjzooNKW92nrGuo2V/CJYxdmTS7h/un6b1OMl
        l4wKRTYmCTbq8pNLK3dR5/ysRBH1hcn7/HoDeWFECxQKI/mR8Qsq6S6icc12kIPE
        qkNXAG5egl1ZYfWtLImhWTxe3NMteqd0PTqywWKBDI06IpW7FjPtonQqYG+NWn7+
        VXo9vk/vQjiYYWoRXtLiNCSodDvEpM4YQyYQZ69AkCBYFeHAPzD6ZSZ4m0dtuyLB
        R2epG2Wn9a9R6o5G9Pnlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1651004153; x=1651090553; bh=gu8wjFAZS//ewmI6BDwb6NDbCp4RXdlDD2C
        fzD/0XzY=; b=JeJ7VkHKXvxWiPhVb/mq4l1aiKyD91OBCx4FV7QSTbczY8ARInl
        hmdpSM7CC/pqunoIJaxOWRMl5V+EajyqFdpAQ6HtG6gpIfdu6WVIh9cqkuTq2Qi7
        w5Yb4niSTOH6PrHFV73Ega66iphw0z0D630ezA1dfcyFfqVkTf/0lP3almXktA6E
        7n4hs75Eaa3LeufdsgYSe4j0s1JOOI/HTP28Y96b91QueNSpJRkR8Nwfm16NXUyH
        IwY0kGPtoUKEL+NjRo2ipOE3ZLc3uor4HDT263Zfw7AjXAZ1m3YZD3PKLUIV439i
        KIL9arLxuhS0bZlv45k/EojrAiXP0GkfxIA==
X-ME-Sender: <xms:-FJoYv74w3jFjCzKCYqzdg778nCFpvhNP4IoUWOXVxwjuIXv2781Vg>
    <xme:-FJoYk5UQ5Oqk85xs32MYcexc6lTSuGQ03FHSI9HMdc61HpPhpJvu1nSTX16aeSFc
    wUMLVgqRFdsNizS_Cw>
X-ME-Received: <xmr:-FJoYmdRsYRvEwwYZEGLMee-jqz9Rgxnfc3rKzcKRQGlfd6KpBFIJ9qB1C1Orz_73u9XiMlBnH5EnbW7BkjSG8t3rJREyantK_UrK3azCEw4ERzMLPdhRhh1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpefhueffgfffgedtfefhfeeujeefgffhleekteduvdffieegffeuvdejgeduleei
    leenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:-FJoYgKfeXBue2qa2QZS0VCdjTryr6AV9xmCDTBbnV6RJCmvTzSOTg>
    <xmx:-FJoYjJEwLbp-wlblpXNCrRSlgCVF-dsV5_vxs3CvAUMEnht2KoZiQ>
    <xmx:-FJoYpyRIEi_DH4eX_Pm7B29ZaTM5LnUBDwbwL40N8UrLWAenTcmQg>
    <xmx:-VJoYk6RXDx2OJ1n2K__Y6dASNSj6pH8Bjv_7kK8MLxdIG0OuYWRHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:50 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: iommu: Add Apple SART DMA address filter
Date:   Tue, 26 Apr 2022 22:15:34 +0200
Message-Id: <20220426201539.12829-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v2 -> v3:
  - Added Rob's r-b tag
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

