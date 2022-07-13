Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C95732BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiGMJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiGMJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F911F2E0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E73B8B81D6A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4F2C341D1;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=wMNkL9BlFfZJJ7e12qDIh/CAGTODMlA3hMOonBBSBIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKsBel7mj3ls/9+FJ+M6yCLp7kQw/5gZ8Oo5Lx6pRk+sPzn9/OMRvmuqYB2JC3/RP
         1Eeff3/MjVgHS4owXL61rqiH6ltPLCn59woKSEy2LqneGPjJ7IgwDdfhchFoPm/7Xi
         lMaJquH1VYmkll9JXP3L/hDMAF2ef2zqQZsdIj6HXRo/jZX8Y4zSYIlQKpkFrXoEbA
         Njxr+TLK4PWhC+2O4rIJSnzrQYflxHAC3oHTw2ALP9xQ+z2migkW+KrqFpShl94vJr
         4XT0uidmQk0DHk2q9jrnluZlXlZk4fq0OQTeuRIy/COc2vWXalcxGrqCY1lzizPVfy
         loL0/rQO+F48w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050Ld-Od;
        Wed, 13 Jul 2022 10:30:19 +0100
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
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] drm/i915/guc: use kernel-doc for enum intel_guc_tlb_inval_mode
Date:   Wed, 13 Jul 2022 10:30:07 +0100
Message-Id: <39ff9de11bef9a30205fa340f89fa36de783be55.1657703926.git.mchehab@kernel.org>
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

Transform the comments for intel_guc_tlb_inval_mode into a
kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
index 2e39d8df4c82..14e35a2f8306 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
@@ -190,15 +190,18 @@ enum intel_guc_tlb_invalidation_type {
 	INTEL_GUC_TLB_INVAL_GUC = 0x3,
 };
 
-/*
- * 0: Heavy mode of Invalidation:
+/**
+ * enum intel_guc_tlb_inval_mode - define the mode for TLB cache invlidation
+ *
+ * @INTEL_GUC_TLB_INVAL_MODE_HEAVY: Heavy Invalidation Mode.
  * The pipeline of the engine(s) for which the invalidation is targeted to is
  * blocked, and all the in-flight transactions are guaranteed to be Globally
- * Observed before completing the TLB invalidation
- * 1: Lite mode of Invalidation:
+ * Observed before completing the TLB invalidation.
+ * @INTEL_GUC_TLB_INVAL_MODE_LITE: Light Invalidation Mode.
  * TLBs of the targeted engine(s) are immediately invalidated.
  * In-flight transactions are NOT guaranteed to be Globally Observed before
  * completing TLB invalidation.
+ *
  * Light Invalidation Mode is to be used only when
  * it can be guaranteed (by SW) that the address translations remain invariant
  * for the in-flight transactions across the TLB invalidation. In other words,
-- 
2.36.1

