Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDA575FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGOLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGOLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:03:43 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CC639D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:03:40 -0700 (PDT)
Received: from lemmy.home.8bytes.org (p4ff2bb8b.dip0.t-ipconnect.de [79.242.187.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id D95CB49B;
        Fri, 15 Jul 2022 13:03:38 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
Date:   Fri, 15 Jul 2022 13:03:34 +0200
Message-Id: <20220715110334.6969-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Robin has been acting as a reviewer of the IOMMU Subsystem for a long
time. He is also defacto maintaining the IOMMU DMA-API Layer, so make
both roles official by adding Robin to the MAINTAINERS file.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f9ed151ad4c..029f49f29982 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10448,9 +10448,20 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 F:	fs/iomap/
 F:	include/linux/iomap.h
 
-IOMMU DRIVERS
+IOMMU DMA-API LAYER
+M:	Robin Murphy <robin.murphy@arm.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+F:	drivers/iommu/dma-iommu.c
+F:	drivers/iommu/iova.c
+F:	include/linux/dma-iommu.h
+F:	include/linux/iova.h
+
+IOMMU SUBSYSTEM
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
+R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
-- 
2.36.1

