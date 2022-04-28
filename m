Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09DA512876
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiD1BHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiD1BHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:07:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1E245A1;
        Wed, 27 Apr 2022 18:04:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 33D725C01FE;
        Wed, 27 Apr 2022 21:04:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Apr 2022 21:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1651107854; x=1651194254; bh=0qHdH/aUtGspfDKe2hAdz5hp/
        F+OiM7JmLMvDU3bPw4=; b=Qa28EnWDuDVWE2ISFELEF+hZAOOuNnx4LInuXphKn
        H1tjGCJMYJ0jM/tdY9JPWkv4EEXHipesTIpusxShqL5Lopwb0PXAU145bMomsQcV
        Tj6TeXWwGyIY+rbKE+ESln/OoadnhFtIv1YNhF7PlifvZ23JCBBdjQ9KNeWe1QNf
        9XUy88nvNi0nOSHLpynCXXITZ+0LsDoEtOwOGUgUIFpughHOz/kQJTrbB53H5LHZ
        7YV4Ms6ryf9DMCIYHflnD2nCOdGQzHiGfMRC8scneBfqwGsI87apyefWfE85in+e
        SgWpryrnxXYG3BzRnAMvn7nUtzymaekqmATypbmMZSZ+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1651107854; x=1651194254; bh=0
        qHdH/aUtGspfDKe2hAdz5hp/F+OiM7JmLMvDU3bPw4=; b=Ctd+nXjDrJF93m8q9
        4884fI2HuMUVHTvS6OtjPjdMMxeb0mEmgV+TPRLvLGtsNoMHC24RE20Q/TEGsSoY
        QFfblIOpzH/qMYi5r3gfDnm3PmPX6XpUsDamHP+avlKHe4j9XcWJN2FWi4k+Mq0j
        Jo5YlPsa7Ir6PrLSU6UDHIj8fARHn+K7jhmKduNWNgq7JM1enqBIVXtwBLGxjHji
        Go30TSjwQdbzeWCc7ImiTjnnBXpPyPpYZwaj5SXmaDLNYqYwzm9X5mWC3ItSxd4s
        Pw6m9R86aXO7vTHKkaMiN+XSwdY6UM4snaHfMlkE/u1/mhoGVDnDPI5N/2ke9gSY
        prpOw==
X-ME-Sender: <xms:DehpYgeX_6qKGPT47LkRTAxskuWuvflZBFo8DTLOIZ-wqmhlam6w4g>
    <xme:DehpYiO07QSZn8XPFn0EvZb7XC4Qi6XFx6zmqkGJ6xUrfUZgPgv9zs8-XIBGdBy1k
    pjW5SuWE-tIoXJgHQ>
X-ME-Received: <xmr:DehpYhh9sQrossGblUCj8_sceKYCBQz42FGoOTKrRbV4nznjL6SWjCxThwgAaAPy3U5mQ-7yfnqvOy_K6G5vMgyBw2WHvhc3Mhk_vvQtKVcNndjCOYPigrF5yF8Bma6PUKM5Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:DehpYl8_-WowG7fkI6O-QXUCLtoSPUeqfwvx8KHTQSYsO4MaDGM6UA>
    <xmx:DehpYssZ54RJ-1okNWK10aSS7CN9KCr8SDVPpimMJoicfMXN6PY26w>
    <xmx:DehpYsH5nIk5ujCBidCy3LPs5K6a206BePOBxlCcgNme2XlsqWsTuA>
    <xmx:DuhpYgN-GY3Ca7ikOxOHItuiVkzGBL_JVDGjnAqDaVj1oL-3ZbcVAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:12 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/5] iommu/sun50i: Allwinner D1 support
Date:   Wed, 27 Apr 2022 20:03:55 -0500
Message-Id: <20220428010401.11323-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

D1 is a RISC-V SoC from Allwinner's sunxi family. This series adds IOMMU
binding and driver support.

One piece is still missing to use the IOMMU for DMA allocations: a call
to iommu_setup_dma_ops(). On ARM64 this is handled by the architecture's
code. RISC-V does not currently select ARCH_HAS_SETUP_DMA_OPS, but it
will once Zicbom support[1] is merged.

[1]: https://lore.kernel.org/lkml/20220307224620.1933061-2-heiko@sntech.de/

So I cannot follow virtio-iommu.c and call iommu_setup_dma_ops() when
ARCH_HAS_SETUP_DMA_OPS=n. However, if I apply the following patch on top
of Heiko's non-coherent DMA series, the display engine successfully uses
the IOMMU to allocate its framebuffer:

--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -6,6 +6,7 @@
  */

 #include <linux/dma-direct.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>

@@ -53,4 +54,7 @@
 {
 	/* If a specific device is dma-coherent, set it here */
 	dev->dma_coherent = coherent;
+
+	if (iommu)
+		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 }


Samuel Holland (5):
  dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
  iommu/sun50i: Support variants without an external reset
  iommu/sun50i: Ensure bypass is disabled
  iommu/sun50i: Add support for the D1 variant
  iommu/sun50i: Ensure the IOMMU can be used for DMA

 .../iommu/allwinner,sun50i-h6-iommu.yaml      | 16 +++++++++++--
 drivers/iommu/Kconfig                         |  1 +
 drivers/iommu/sun50i-iommu.c                  | 24 +++++++++++++++++--
 3 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.35.1

