Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F2554D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiFVObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiFVOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:30:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B823DA61
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:30:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6CB3D6E;
        Wed, 22 Jun 2022 07:30:00 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.41.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1083F792;
        Wed, 22 Jun 2022 07:29:59 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Steven Price <steven.price@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] swiotlb: Remove redundant swiotlb_force
Date:   Wed, 22 Jun 2022 15:29:52 +0100
Message-Id: <20220622142952.320057-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable (and enum) was removed in commit c6af2aa9ffc9 ("swiotlb:
make the swiotlb_init interface more useful") but the declaration was
left in swiotlb.h. Tidy up by removing the declaration as well.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/linux/swiotlb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..b1f5ace37502 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -60,8 +60,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 #ifdef CONFIG_SWIOTLB
-extern enum swiotlb_force swiotlb_force;
-
 /**
  * struct io_tlb_mem - IO TLB Memory Pool Descriptor
  *
-- 
2.25.1

