Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E774707CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbhLJR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:58:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244855AbhLJR6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:58:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B380813D5;
        Fri, 10 Dec 2021 09:55:05 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 224493F73B;
        Fri, 10 Dec 2021 09:55:04 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 02/11] gpu: host1x: Add missing DMA API include
Date:   Fri, 10 Dec 2021 17:54:43 +0000
Message-Id: <cba5353b636117835512fab7646788d89db033bf.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639157090.git.robin.murphy@arm.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host1x seems to be relying on picking up dma-mapping.h transitively from
iova.h, which has no reason to include it in the first place. Fix the
former issue before we totally break things by fixing the latter one.

CC: Thierry Reding <thierry.reding@gmail.com>
CC: Mikko Perttunen <mperttunen@nvidia.com>
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/gpu/host1x/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 218e3718fd68..881fad5c3307 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
 #include <linux/host1x.h>
 #include <linux/of.h>
 #include <linux/seq_file.h>
-- 
2.28.0.dirty

