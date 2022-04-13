Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080CC4FF102
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiDMH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiDMH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:56:16 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DBB48324
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:53:55 -0700 (PDT)
X-UUID: 4f4dd76025a040fc9a9547678a9023db-20220413
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 80
        audit/email.address 1
        meta/cnt.alert 1
X-UUID: 4f4dd76025a040fc9a9547678a9023db-20220413
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 746439929; Wed, 13 Apr 2022 15:25:17 +0800
X-ns-mid: postfix-62567B23-7805395805
Received: from localhost.localdomain (unknown [172.20.12.219])
        by cs2c.com.cn (NSMail) with ESMTPA id 82A1F383C64D;
        Wed, 13 Apr 2022 07:26:27 +0000 (UTC)
From:   Cong Liu <liucong2@kylinos.cn>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH] drm/i915: Remove intel_gvt_init_host declaration
Date:   Wed, 13 Apr 2022 15:24:15 +0800
Message-Id: <20220413072415.27231-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this function has been deleted since commit 9bdb073464d6 ("drm/i915/gvt:
Change KVMGT as self load module"), remove the deprecated function
declaration.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/gpu/drm/i915/intel_gvt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
index d7d3fb6186fd..daaf0957ebbc 100644
--- a/drivers/gpu/drm/i915/intel_gvt.h
+++ b/drivers/gpu/drm/i915/intel_gvt.h
@@ -31,7 +31,6 @@ int intel_gvt_init(struct drm_i915_private *dev_priv);
 void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
 int intel_gvt_init_device(struct drm_i915_private *dev_priv);
 void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
-int intel_gvt_init_host(void);
 void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
 void intel_gvt_resume(struct drm_i915_private *dev_priv);
 #else
-- 
2.25.1

