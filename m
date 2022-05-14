Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A97526F75
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiENC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiENC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598EF2FCF32
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492819; x=1684028819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KozZnrzYJ+0UFKmzjAu1U8Z4jZPTgTst8scozy/7ge4=;
  b=TmghDWk5tOHj020pqWxmaQ6uZU3iYV6Hd521KYNRC5XUaDY+R2AjxQ2Q
   jiA/h0WWzlHiM++m82pNel9w95az0D4+hf8EPv45K1gjXT83PMijxIdYP
   n2uJ1BY4cwYnK3Jl73dRBU1mOpKeGiBqjG1zx2AvgdoO8Ey294zlh0Tt+
   NW3xswwxvphR5gFzT9A8WLY5uhvDwqt5ZVuo9IAA2wzby9vmpHVu1tJXb
   vO6dpKEcocCkH1PHvOaEPrq0G4m674Xpmz9VFHAx9DkgogwfllvxD1yUp
   L9bhrcB/lLX9lmYVTg65KBVYxl55owLbrMSjl36/pkJizOO47UgzVYoZy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270126964"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270126964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630801"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/7] drm/i915: Remove unnecessary include
Date:   Sat, 14 May 2022 09:43:19 +0800
Message-Id: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel-iommu.h is not needed in drm/i915 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h                | 1 -
 drivers/gpu/drm/i915/display/intel_display.c   | 1 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index fa14da84362e..f2a6982c3bef 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -36,7 +36,6 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
-#include <linux/intel-iommu.h>
 #include <linux/pm_qos.h>
 
 #include <drm/drm_connector.h>
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 7dfeb458aa65..686ddbeebadc 100644
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
index d42f437149c9..c9823528ea94 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -4,7 +4,6 @@
  * Copyright © 2008,2010 Intel Corporation
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/dma-resv.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>
-- 
2.25.1

