Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1424EAED4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiC2Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiC2NwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:52:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FB19059D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ODMBabnsXoaSPQ4J62+3KQQ9EqF6RtG+JR584HtkzK4=; b=VVb09FbrukffSXfPwT0Cd2Ue23
        F8NA988Wzmuv2kVkdI7kL8O619md0CaBEj69NYvCSjiKDkhZk76ZPTvfnFsOoaX5AKivqz7rlkiVQ
        jfmNy7Ho+j3YsoYgoEqqVjVUU33yY2svthZnW5nvDNe/YKS1WmeqoX2KYgQaQiB/jg/3vqbJ2aFbf
        O7FratjUm9+R0GHsdApXhgiv14LlbjGmiavwpoZ+q+7k2myzVOZGPfCcCZQDVNxPaGEU8qYJDKxYT
        F/mU3nmGSIM1WoH7YHmpuyKzntTAsyfYjGaEP0rMwUBO3F52PbYQ7m2IIvfnzg9VvqZ8B4gw6Cp0i
        PBZXK8HA==;
Received: from [2001:4bb8:18c:41aa:1dc5:164d:d6fd:e657] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZCEx-00CQJ4-A3; Tue, 29 Mar 2022 13:50:31 +0000
Date:   Tue, 29 Mar 2022 15:50:24 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for Linux 5.18
Message-ID: <YkMOoNaIpyQf/LKL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8:

  Merge tag 'nfs-for-5.17-1' of git://git.linux-nfs.org/projects/anna/linux-nfs (2022-01-25 20:16:03 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18

for you to fetch changes up to 8ddde07a3d285a0f3cec14924446608320fdc013:

  dma-mapping: benchmark: extract a common header file for map_benchmark definition (2022-03-10 07:41:14 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 5.18

 - do not zero buffer in set_memory_decrypted (Kirill A. Shutemov)
 - fix return value of dma-debug __setup handlers (Randy Dunlap)
 - swiotlb cleanups (Robin Murphy)
 - remove most remaining users of the pci-dma-compat.h API
   (Christophe JAILLET)
 - share the ABI header for the DMA map_benchmark with userspace
   (Tian Tao)
 - update the maintainer for DMA MAPPING BENCHMARK (Xiang Chen)
 - remove CONFIG_DMA_REMAP (me)

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-mapping: remove CONFIG_DMA_REMAP

Christophe JAILLET (5):
      alpha: Remove usage of the deprecated "pci-dma-compat.h" API
      agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
      sparc: Remove usage of the deprecated "pci-dma-compat.h" API
      rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
      media: v4l2-pci-skeleton: Remove usage of the deprecated "pci-dma-compat.h" API

Kirill A. Shutemov (1):
      swiotlb: do not zero buffer in set_memory_decrypted()

Randy Dunlap (1):
      dma-debug: fix return value of __setup handlers

Robin Murphy (3):
      swiotlb: simplify debugfs setup
      swiotlb: tidy up includes
      swiotlb: simplify array allocation

Tian Tao (1):
      dma-mapping: benchmark: extract a common header file for map_benchmark definition

Xiang Chen (1):
      MAINTAINERS: update maintainer list of DMA MAPPING BENCHMARK

 MAINTAINERS                                     |  2 +-
 arch/alpha/include/asm/floppy.h                 |  7 ++-
 arch/alpha/kernel/pci_iommu.c                   | 12 ++--
 arch/arm/Kconfig                                |  2 +-
 arch/sparc/kernel/ioport.c                      |  2 +-
 arch/xtensa/Kconfig                             |  2 +-
 drivers/char/agp/intel-gtt.c                    | 26 ++++-----
 drivers/iommu/dma-iommu.c                       | 14 ++---
 drivers/rapidio/devices/tsi721.c                |  8 +--
 include/linux/map_benchmark.h                   | 31 ++++++++++
 kernel/dma/Kconfig                              |  7 +--
 kernel/dma/Makefile                             |  2 +-
 kernel/dma/debug.c                              |  4 +-
 kernel/dma/direct.c                             | 18 +++---
 kernel/dma/map_benchmark.c                      | 25 +-------
 kernel/dma/swiotlb.c                            | 76 ++++++++-----------------
 samples/v4l/v4l2-pci-skeleton.c                 |  2 +-
 tools/testing/selftests/dma/dma_map_benchmark.c | 25 +-------
 18 files changed, 105 insertions(+), 160 deletions(-)
 create mode 100644 include/linux/map_benchmark.h
