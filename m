Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD885543209
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiFHN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiFHN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:58:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0010D304
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:58:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso4488528wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8VISYkcT36CEH8dMwAYw+ltzDmUvfvK80231Ui7esE=;
        b=J7G/eT+pCEdsUdaKgEq2rWy3gbNxitJi8XbpO5rq/p3uX8phRW3JuT9+ipCapfg7L4
         tV3QU9HJCETelVZpmzXAHuIxa3KDPL//3ISMfZBRnO8YKsTV+w0krxqGU0iG/TTyGKwQ
         NAE9MRlK/RdhXSInOE6/zl2arKI6sxoIqC61g5vZV7zqAeYYe/5MZSLvwMvHIDYZP0wg
         n5iGTArVAygP4+qWHfyglNOHscf+GtBuWTbtYDbm9VI2PRS4/ptLk6MbFhJMTdBazsZ7
         Ci2+QSU8MoSBryOZJjrTzAsH3Y1K3iifa1Ctoh/l58ZVmq5+X5ggmTkfOjZKIHXIqeaj
         xmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8VISYkcT36CEH8dMwAYw+ltzDmUvfvK80231Ui7esE=;
        b=3B0AGvG0iWsEIr8+P+pUSb/0SoHY6hG4xHgXBYLjOlM7xY3HAjzc3moUrUvA253DvX
         sfq5OKtUlvwFNy3C9jZ+w3V4MgFHnJEs9NF1nmVj8H5Cz17I6/ninrk1FeygJEpWmQeZ
         y/zB1mD30jBlciWqjoVTphHOUHYv0r+XSHghXjAgp4p1F7F6qvQhE4YmAmwnYB+CWDnv
         Y9AoWcDVL3p1gIe9VP9+fe+GPVDfk679sfEOG1YDCfHFJ3B3KLY+4F26S4xFb6B4QtFL
         y+vmcVQQJlSKEed6xIJH9IVYfrSGjCghLK7UTuoAVoDtH/JjmUn0iHSbxGIKoDLyGMe2
         pwXg==
X-Gm-Message-State: AOAM5335Yc3oyIAHJ8QDqr3mINkB79wInWhCU7b12DPH3Nx8HW8y5Aw/
        3OSypW5nVorCAyeeoRn+aU8omg==
X-Google-Smtp-Source: ABdhPJzezq807irvaFo462Vn31bjZwnJ0ZSAMoyQCnfO++eLUY5d9+VSN4Nt8DFAJeB9pEhbZAASBQ==
X-Received: by 2002:a05:600c:2c46:b0:39c:55a0:9533 with SMTP id r6-20020a05600c2c4600b0039c55a09533mr13137412wmg.104.1654696711042;
        Wed, 08 Jun 2022 06:58:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m125-20020a1ca383000000b0039c5b4ab1b0sm4852519wme.48.2022.06.08.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:58:30 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [RESEND PATCH v3] drm/cma-helper: Describe what a "contiguous chunk" actually means
Date:   Wed,  8 Jun 2022 14:58:21 +0100
Message-Id: <20220608135821.1153346-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's inception in 2012 it has been understood that the DRM GEM CMA
helpers do not depend on CMA as the backend allocator. In fact the first
bug fix to ensure the cma-helpers work correctly with an IOMMU backend
appeared in 2014. However currently the documentation for
drm_gem_cma_create() talks about "a contiguous chunk of memory" without
making clear which address space it will be a contiguous part of.
Additionally the CMA introduction is actively misleading because it only
contemplates the CMA backend.

This matters because when the device accesses the bus through an IOMMU
(and don't use the CMA backend) then the allocated memory is contiguous
only in the IOVA space. This is a significant difference compared to the
CMA backend and the behaviour can be a surprise even to someone who does
a reasonable level of code browsing (but doesn't find all the relevant
function pointers ;-) ).

Improve the kernel doc comments accordingly.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

Notes:
    Am I Cc:ing the correct reviewers/maintainers with this patch? There
    has been no negative feedback but I've been rebasing and re-posting it
    for three kernel cycles now. Do I need to queue it somewhere special or
    get it in front of someone specific?
    
    Either way...
    
    This RESEND is unaltered (except for collecting tags) and is rebased on
    v5.19-rc1.
    
    RESEND for v5.18-rc3
    - Unaltered but rebased on v5.18-rc3
    
    Changes in v3:
    - Rebased on v5.17-rc2
    - Minor improvements to wording.
    
    Changes in v2:
    - Oops. I did a final proof read and accidentally committed these
      changes as a seperate patch. This means that v1 contains only
      one tenth of the actual patch. This is fixed in v2. Many apologies
      for the noise!

 drivers/gpu/drm/drm_gem_cma_helper.c | 39 +++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index f36734c2c9e1..42abee9a0f4f 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -26,12 +26,22 @@
 /**
  * DOC: cma helpers
  *
- * The Contiguous Memory Allocator reserves a pool of memory at early boot
- * that is used to service requests for large blocks of contiguous memory.
+ * The DRM GEM/CMA helpers are a means to provide buffer objects that are
+ * presented to the device as a contiguous chunk of memory. This is useful
+ * for devices that do not support scatter-gather DMA (either directly or
+ * by using an intimately attached IOMMU).
  *
- * The DRM GEM/CMA helpers use this allocator as a means to provide buffer
- * objects that are physically contiguous in memory. This is useful for
- * display drivers that are unable to map scattered buffers via an IOMMU.
+ * Despite the name, the DRM GEM/CMA helpers are not hardwired to use the
+ * Contiguous Memory Allocator (CMA).
+ *
+ * For devices that access the memory bus through an (external) IOMMU then
+ * the buffer objects are allocated using a traditional page-based
+ * allocator and may be scattered through physical memory. However they
+ * are contiguous in the IOVA space so appear contiguous to devices using
+ * them.
+ *
+ * For other devices then the helpers rely on CMA to provide buffer
+ * objects that are physically contiguous in memory.
  *
  * For GEM callback helpers in struct &drm_gem_object functions, see likewise
  * named functions with an _object_ infix (e.g., drm_gem_cma_object_vmap() wraps
@@ -111,8 +121,14 @@ __drm_gem_cma_create(struct drm_device *drm, size_t size, bool private)
  * @drm: DRM device
  * @size: size of the object to allocate
  *
- * This function creates a CMA GEM object and allocates a contiguous chunk of
- * memory as backing store.
+ * This function creates a CMA GEM object and allocates memory as backing store.
+ * The allocated memory will occupy a contiguous chunk of bus address space.
+ *
+ * For devices that are directly connected to the memory bus then the allocated
+ * memory will be physically contiguous. For devices that access through an
+ * IOMMU, then the allocated memory is not expected to be physically contiguous
+ * because having contiguous IOVAs is sufficient to meet a devices DMA
+ * requirements.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
@@ -162,9 +178,12 @@ EXPORT_SYMBOL_GPL(drm_gem_cma_create);
  * @size: size of the object to allocate
  * @handle: return location for the GEM handle
  *
- * This function creates a CMA GEM object, allocating a physically contiguous
- * chunk of memory as backing store. The GEM object is then added to the list
- * of object associated with the given file and a handle to it is returned.
+ * This function creates a CMA GEM object, allocating a chunk of memory as
+ * backing store. The GEM object is then added to the list of object associated
+ * with the given file and a handle to it is returned.
+ *
+ * The allocated memory will occupy a contiguous chunk of bus address space.
+ * See drm_gem_cma_create() for more details.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
--
2.35.1

