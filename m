Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC9509EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388849AbiDULjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDULjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:39:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44FB422284
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:37:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42741FB;
        Thu, 21 Apr 2022 04:37:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB60A3F5A1;
        Thu, 21 Apr 2022 04:37:02 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] More ARM DMA ops cleanup
Date:   Thu, 21 Apr 2022 12:36:56 +0100
Message-Id: <cover.1650539846.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thanks to Christoph's latest series, I'm reminded that, if we're going
to give the ARM DMA ops some cleanup this cycle, it's as good a time as
any to dust off these old patches and add them on top as well. I've
based these on the arm-dma-direct branch which I assume matches the
patches posted at [1].

Cheers,
Robin.

[1] https://lore.kernel.org/linux-arm-kernel/20220421074204.1284072-1-hch@lst.de/


Robin Murphy (3):
  ARM/dma-mapping: Drop .dma_supported for IOMMU ops
  ARM/dma-mapping: Consolidate IOMMU ops callbacks
  ARM/dma-mapping: Merge IOMMU ops

 arch/arm/mm/dma-mapping.c | 286 +++++++++-----------------------------
 1 file changed, 62 insertions(+), 224 deletions(-)

-- 
2.35.3.dirty

