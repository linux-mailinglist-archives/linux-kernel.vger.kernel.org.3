Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A985685AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiGFKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiGFKdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:33:50 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36A326544
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:33:48 -0700 (PDT)
Received: from lemmy.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de [91.0.108.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id AA1CE219;
        Wed,  6 Jul 2022 12:33:46 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Remove iommu@lists.linux-foundation.org
Date:   Wed,  6 Jul 2022 12:33:31 +0200
Message-Id: <20220706103331.10215-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The IOMMU mailing list has moved to iommu@lists.linux.dev
and the old list should bounce by now. Remove it from the
MAINTAINERS file.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66bffb24a348..ead381fdfc5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,7 +426,6 @@ F:	drivers/acpi/*thermal*
 ACPI VIOT DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	linux-acpi@vger.kernel.org
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/acpi/viot.c
@@ -960,7 +959,6 @@ F:	drivers/video/fbdev/geode/
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -5979,7 +5977,6 @@ DMA MAPPING HELPERS
 M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -5992,7 +5989,6 @@ F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
 M:	Xiang Chen <chenxiang66@hisilicon.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
@@ -7577,7 +7573,6 @@ F:	drivers/gpu/drm/exynos/exynos_dp*
 
 EXYNOS SYSMMU (IOMMU) driver
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
@@ -9999,7 +9994,6 @@ F:	drivers/hid/intel-ish-hid/
 INTEL IOMMU (VT-d)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Lu Baolu <baolu.lu@linux.intel.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -10379,7 +10373,6 @@ F:	include/linux/iomap.h
 IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -12539,7 +12532,6 @@ F:	drivers/i2c/busses/i2c-mt65xx.c
 
 MEDIATEK IOMMU DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -16591,7 +16583,6 @@ F:	drivers/i2c/busses/i2c-qcom-cci.c
 
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
@@ -19217,7 +19208,6 @@ F:	arch/x86/boot/video*
 
 SWIOTLB SUBSYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -21893,7 +21883,6 @@ XEN SWIOTLB SUBSYSTEM
 M:	Juergen Gross <jgross@suse.com>
 M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 F:	arch/x86/xen/*swiotlb*
-- 
2.36.1

