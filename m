Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6844570EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiGLAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGLANq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19491CFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584825; x=1689120825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1VeSJDIT9XeF1FzLfvrql3G8Neer6XxZf/wBpgqjdM=;
  b=PxAfizZL0RehlnxEvZPcsTKsQADYPi2gMnRfEuQCUo0SPbD8R/Wnf9Dz
   P6ViITFciGkIWFEw6WWnf94bc8EGlwMKXFHmMD0U8aSUgLwLOezT3aQqL
   Cuylr7XJPn5bGM7WhOLZHKqTM2/glmV/rU0dN9BIzrGQybsruAvlHLChK
   P/5D0b8/YzTq1TiLEcy5Wa+4FBNKXiO1efg22eUZY45wA4xrAnElYamDl
   rJw5TSXZQfJpiirJNCC7Ad6vU13e1Hr4lgthe+gVO+KgvgEfK5jPw7Ikm
   tpYlGDGttYVGVUgHryZY8jMOScrgz9oW7kr25a9VuBhSMxDRzlqmytkJO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827889"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445694"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] drm/i915: Remove unnecessary include
Date:   Tue, 12 Jul 2022 08:08:47 +0800
Message-Id: <20220712000908.3431936-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel-iommu.h is not needed in drm/i915 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-5-baolu.lu@linux.intel.com
---
 drivers/gpu/drm/i915/display/intel_display.c   | 1 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 806d50b302ab..493421759afa 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -27,7 +27,6 @@
 #include <acpi/video.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/intel-iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-resv.h>
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 30fe847c6664..193c7c83c70f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -6,7 +6,6 @@
 
 #include <linux/dma-resv.h>
 #include <linux/highmem.h>
-#include <linux/intel-iommu.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>
 
-- 
2.25.1

