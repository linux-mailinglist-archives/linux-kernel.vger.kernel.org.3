Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFE57839F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiGRNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiGRNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:22:38 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360E24967
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:22:31 -0700 (PDT)
X-QQ-mid: bizesmtp63t1658150536tprhb7o4
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:22:14 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: 83ShfzFP0oDpLP1Dvu6XTjFDq/dXibZuCtQI2VYFTjiZeRQGYV7RLf9qspcim
        qq/C1MNIzlQ0jHPIGxH0ZfVG4OuI1CBlXF9PyaMDO30BDtDNE4h/YCKmhqpnjoQGK9hMKx+
        5MNuDFqrdXP0ZdWvFnDPhQkO2Y1YaXX8WOOAEFc0V903RuYyp0aNwKOHsR2ZzeaDECVgB4I
        xZtPAG6EBYM1UgW0dKytOsfUroYOlPN+CD0MQ/k+yMMAiOsHBw3owqxqTUdY28t/zJleycA
        UEOOgAEUOePbiFwnQaLMVbvmJi79Ci5LbNN9KTEDOglGXrOoy3Qr1MVnNRILM5o6+fQ2O9V
        ydMOSD/nBdTxSFT8GkFafiBr5+NemBN39NinVMaS6RRoolGODmMIzDmZssHcKpZVi4OHkbk
        GIZhlTZosDI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] dma-buf: Fix comment typo
Date:   Fri, 15 Jul 2022 13:20:17 +0800
Message-Id: <20220715052017.31633-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `have' is duplicated in line 696, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 84843b3b3aef..261fcbae88d7 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -693,7 +693,7 @@ int radeon_gem_va_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* !! DONT REMOVE !!
-	 * We don't support vm_id yet, to be sure we don't have have broken
+	 * We don't support vm_id yet, to be sure we don't have broken
 	 * userspace, reject anyone trying to use non 0 value thus moving
 	 * forward we can use those fields without breaking existant userspace
 	 */
-- 
2.35.1

