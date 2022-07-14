Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B42574CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiGNMGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiGNMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF55C9D1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0AFE61E38
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B28FC341CE;
        Thu, 14 Jul 2022 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800390;
        bh=KmRjlo5sbsszPv9K0jtghWeUlvqMrr55yKQvb6zPzNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSjp5jx6cfCt///J1mo3XF+62gpUWYsvyei5+wgUOyi1B4GEPSi3FNgzxaO+43X30
         dy9gGoFW4i556U0vDALNE3JH+GUIUkI+6Ajg12NgdVK0EFd+0Ljp3eNA6e/3yRTq0o
         ol1ONHJpYnXa7v1Cr0dXzU50cjxyLYXae4e3Jc8cBtO8wWcyBNykHLH1lDoth2bShZ
         1n2gKfMTWEXeK95IdhFjyqUiKXle8E1ZD2LsZ9Thswxq2E91MUHuytjx+NsnRslYFQ
         ApJO6ZgwdNXNin9b1yGWB1OiyIK5XMV4TJLSbSR5eVMZlplvw0q/jhkTuJ1jvnqpEl
         nf1kWQdUFsNWA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBxbv-0059sY-Q8;
        Thu, 14 Jul 2022 13:06:27 +0100
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
Subject: [PATCH v2 02/21] drm/i915/gt: document with_intel_gt_pm_if_awake()
Date:   Thu, 14 Jul 2022 13:06:07 +0100
Message-Id: <1ed105f9fd605e1ccdaecc18c394c17eaec1035e.1657800199.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657800199.git.mchehab@kernel.org>
References: <cover.1657800199.git.mchehab@kernel.org>
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

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/21] at: https://lore.kernel.org/all/cover.1657800199.git.mchehab@kernel.org/

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

