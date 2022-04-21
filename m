Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA551509988
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386102AbiDUHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386055AbiDUHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170141A812;
        Thu, 21 Apr 2022 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=B6bUxdK604oMD6IGwRtm3YqcJPw1O1IDlWY25cO5q1Q=; b=J5mWjZNeN3gDIhoMu7QxrZ4R0Y
        UdP+c+b5ibwoOLeK2pKeV+tvv3PWiP5g1GeTv4uP9IN1L2NnTQQpLUZvcagx4gb05i4GB6Ceu/BUq
        zTaaCf9SrNLtADst331hjGNi9saB/qWNKlNcb9GLXcAZpbg6b+iuEKg5MDCL+tbHsGERa6TlkIxy0
        5G+6ig4GvkUJwqKq6qT2Bzh7biQuVzPKZZ8W1wZ7inGxqgtbGXoZWWFUooKvSU+UZbIUt5705ri3T
        t8TctdwahEKw6soNlpESQG3f86LSnfATUf+DOlcJrb46CXT7q7QNNqaeV67fTQRnPhIgJPGL+QJIH
        B7C6safw==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRSE-00C7Wr-CV; Thu, 21 Apr 2022 07:42:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 4/7] ARM: remove the unused virt_to_dma helper
Date:   Thu, 21 Apr 2022 09:42:01 +0200
Message-Id: <20220421074204.1284072-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-direct.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 77fcb7ee5ec90..6fd52713b5d12 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -5,7 +5,7 @@
 #include <asm/memory.h>
 
 /*
- * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -25,14 +25,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
-	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
-}
-
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
-- 
2.30.2

