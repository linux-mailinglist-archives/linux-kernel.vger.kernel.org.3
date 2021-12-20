Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5847A9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhLTMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhLTMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:34:57 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:34:56 -0800 (PST)
Received: from cap.home.8bytes.org (p5b0066e4.dip0.t-ipconnect.de [91.0.102.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 11C5228D;
        Mon, 20 Dec 2021 13:34:54 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/iova: Temporarily include dma-mapping.h from iova.h
Date:   Mon, 20 Dec 2021 13:34:48 +0100
Message-Id: <20211220123448.19996-1-joro@8bytes.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Some users of iova.h still expect that dma-mapping.h is also included.
Re-add the include until these users are updated to fix compile
failures in the iommu tree.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iova.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 0abd48c5e622..cea79cb9f26c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
+#include <linux/dma-mapping.h>
 
 /* iova structure */
 struct iova {
-- 
2.34.1

