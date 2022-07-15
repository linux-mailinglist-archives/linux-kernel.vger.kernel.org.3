Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD757839C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiGRNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiGRNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:22:18 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4E5248E4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:22:14 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658150513tr550luw
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:21:50 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000000
X-QQ-FEAT: +bXiSo2NuBd9WaWHuSP8maq7+K/rGilFjsIUzYuFnDmWeFbwKfnBWyLGSaW0c
        QzQ6SoGrFLGaTk/aAEo6aRhsijiMnWswHxW2xm6ECEjkYlSGuxOOtl4q39CpaQXQI3o2hWg
        YlTZhn+IhNbF2YCkBnHB7h8GU2/ImkgSxyYuL9EPJgOJXQy3WPIvDCbygBKmhJgUc+v8Jja
        D8MJlXlImEKhTa7tkS7L8CAJj4IJiWZjHS1T7k/BEweihd7DyntgWcqs6MmI19sd6eJOtRI
        meNjgZ1FBBrO2s/qDCLB6rNKXm0FHXMtreIbcuaJEQil7xqF2hWpe6LKbO3d+yfIhhs9RZV
        D513iq8u95mrc9V36UDPbyNQzAcJg3FWmmJI8dmN6j2xwrtW6CTPf5mOeXHF3mVfYtY3LSU
        1XWntNTeBbo=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, John.C.Harrison@Intel.com,
        matthew.d.roper@intel.com, matthew.brost@intel.com,
        andi.shyti@linux.intel.com, michal.winiarski@intel.com,
        zhou1615@umn.edu, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/i915/selftests: Fix comment typo
Date:   Fri, 15 Jul 2022 13:19:53 +0800
Message-Id: <20220715051953.31424-1-wangborong@cdjrlc.com>
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

The double `wait' is duplicated in line 974, remove one.

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

