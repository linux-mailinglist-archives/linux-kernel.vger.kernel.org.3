Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5911B579CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiGSMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiGSMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:39:20 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595C4598D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:15:37 -0700 (PDT)
X-QQ-mid: bizesmtp65t1658232442ts1nmbp7
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:07:20 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: 3auutXC5AV+cOmKb/kyVFRYpEkBj9pk0YN38xAWBRX2vjduB3o0pX5BXL9f11
        iio/MpUwcAHR4nVFKa6lCgXdpC0GQzr6oCENhz/8zFiVEUDtO6xiHb92QdWnWjTrrgPoxBq
        44WwVHrvoasWDuB5uVCcLdZizf88muRTpgM2ZUVrS05HfV5KcRS72DdlCtEyG/+MUV23CBY
        /43Z9gwgmTHDGT6TacYkq7x7mdAvIW6RwYsiyljEqQIotnQOJBzs13RP2/6fmPVM96fV5hZ
        DHiw1d2pOtOs8HWLman7e4HjANUPJyk8GRpgGy0jyn13NIHrm95pzWfEfs/aVIzkimxuQLG
        jfXztTDBkec51/GzuAg6Xc1fwSZYTrxqaWU9561ZHNEOHfj66byjgNKYBJ2RCuKOgSJtoIH
        Ev8G9mlWhfo=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, John.C.Harrison@Intel.com,
        matthew.d.roper@intel.com, matthew.brost@intel.com,
        andi.shyti@linux.intel.com, zhou1615@umn.edu,
        michal.winiarski@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/i915/selftests: Fix comment typo
Date:   Sat, 16 Jul 2022 12:05:20 +0800
Message-Id: <20220716040520.31676-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the double `wait' typo in comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/i915/selftests/i915_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index c56a0c2cd2f7..ec05f578a698 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -971,7 +971,7 @@ static struct i915_vma *empty_batch(struct drm_i915_private *i915)
 	if (err)
 		goto err;
 
-	/* Force the wait wait now to avoid including it in the benchmark */
+	/* Force the wait now to avoid including it in the benchmark */
 	err = i915_vma_sync(vma);
 	if (err)
 		goto err_pin;
-- 
2.35.1

