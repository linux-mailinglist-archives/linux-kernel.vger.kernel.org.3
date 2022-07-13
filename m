Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B445E5732AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiGMJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiGMJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C2F2E0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE08661CBB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B90C341E6;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=CCKKzwB0qHXF+WGVUFGTqABjxYBM8eht5j02XIx4jVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTJLFfDrWmXusPvlk/y7wR2q/VA5ySyre0cG0m02FfgFLLaJ5BrBmOK7FqmakpLJS
         xYVl9PR4l2pc/7fAeiOqKtV17Jx6+jBmlvDzKuRGhYHZyfZ1yaONRl9GyhIJv+USmx
         nOub+MnFujdOK7+c1oh21empX7bgoMedy0TclG2SLbMpSZGbu6P57Oaz6saHaYp8QW
         ZOMi1JMwjeYCR55Z9VEGP+aeUYlnozoMRLjNUjIa9pxNcQCrp3JeZf5bgSTeCpA2Fa
         8UDVuTgFBEOfJXuxw7gg9JfHzm8HER+L562SdDQl8O4iLnZwg5+1vEyB8ybY9c8gnL
         YYenUXTz8VkUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhI-0050MF-04;
        Wed, 13 Jul 2022 10:30:20 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Borislav Petkov <bp@suse.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] drm/i915/guc: describe enum intel_guc_tlb_invalidation_type
Date:   Wed, 13 Jul 2022 10:30:17 +0100
Message-Id: <73d51e0580ba98a466f951473902eda3cfa97053.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657703926.git.mchehab@kernel.org>
References: <cover.1657703926.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description for intel_guc_tlb_invalidation_type enum.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
index 5c019856a269..e97065c62d28 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
@@ -187,6 +187,18 @@ enum intel_guc_state_capture_event_status {
 /* Flush PPC or SMRO caches along with TLB invalidation request */
 #define INTEL_GUC_TLB_INVAL_FLUSH_CACHE (1 << 31)
 
+/**
+ * enum intel_guc_tlb_invalidation_type - type of TLB cache invalidation
+ *
+ * @INTEL_GUC_TLB_INVAL_FULL:
+ *	Global TLB invalidation
+ * @INTEL_GUC_TLB_INVAL_PAGE_SELECTIVE:
+ *	Page-selective TLB cache invalidation
+ * @INTEL_GUC_TLB_INVAL_PAGE_SELECTIVE_CTX:
+ *	Context-selective TLB cache invalidation
+ * @INTEL_GUC_TLB_INVAL_GUC:
+ *	Invalidate TLB on GuC itself
+ */
 enum intel_guc_tlb_invalidation_type {
 	INTEL_GUC_TLB_INVAL_FULL = 0x0,
 	INTEL_GUC_TLB_INVAL_PAGE_SELECTIVE = 0x1,
-- 
2.36.1

