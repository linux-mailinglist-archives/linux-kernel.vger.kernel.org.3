Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53157327D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiGMJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiGMJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A67F2E0D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C1961CA1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D05C341C0;
        Wed, 13 Jul 2022 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704621;
        bh=oMqR086Sh4/11DEbRL1QYHjCa4npxyd592GKCoYy7dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgEhUNPjQ6hv/NsRUJVgEJP4P8zctXjwJ7IsMcn8R6KW67CXZpEX0jKlUTwKqp0JS
         tciXxSP/G1wxho/bwQ7rMbRvSPmpUMFYYDEDg0fdE6AVvxl9Va7CMkP/muPH7cDfpt
         HwKQW2kntXRpUYZYG8EZAS0lIbPzI7cc5Xb/+uB5YdtRkn+8Y1ju7riT8VTAv21rQZ
         3VxqsY700jJAwuLy/AonV1jz+DhCgmmxX05KBhnC5DcT74zI6ZCu5UfnDqbPeeqVaB
         oJl7PZFDWBhrXF462nvFRujzYXeEp5bb9CllQp5YQWqAwmE3kLZiG8tYIsHH9pITGZ
         M+qgLV+iXacdg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050LF-IC;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] drm/i915/gt: document with_intel_gt_pm_if_awake()
Date:   Wed, 13 Jul 2022 10:29:59 +0100
Message-Id: <e9bea6ef2c3ea37440b6b50794ed9785f8ea0acd.1657703926.git.mchehab@kernel.org>
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

Add a kernel-doc markup to document this new macro.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/21] at: https://lore.kernel.org/all/cover.1657703926.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gt/intel_gt_pm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
index a334787a4939..4d4caf612fdc 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
@@ -55,6 +55,13 @@ static inline void intel_gt_pm_might_put(struct intel_gt *gt)
 	for (tmp = 1, intel_gt_pm_get(gt); tmp; \
 	     intel_gt_pm_put(gt), tmp = 0)
 
+/**
+ * with_intel_gt_pm_if_awake - if GT is PM awake, get a reference to prevent
+ *	it to sleep, run some code and then put the reference away.
+ *
+ * @gt: pointer to the gt
+ * @wf: pointer to a temporary wakeref.
+ */
 #define with_intel_gt_pm_if_awake(gt, wf) \
 	for (wf = intel_gt_pm_get_if_awake(gt); wf; intel_gt_pm_put_async(gt), wf = 0)
 
-- 
2.36.1

