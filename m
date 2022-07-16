Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8995799C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiGSMG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiGSMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:04:09 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205845048
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:59:54 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658231978t4u9l6dy
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 19:59:36 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 3uhoZqdeMHMkGTYpkkjDgOhxGAR++wlBx2LmCDenBU68zf3/NsGKrawlk8a1s
        3GQwHzKIHhUpq7Vu+NnGP8opGQyr2IOdnZl4QEr4ZnffrQzsOtA5tEIu5VtWrr5Rr6nZWth
        DVpxdk96/GLl1wgNxcXRsGDK8r0iIgh8XYuTEbPY8wfMDnaGvH1r/tzbSSVawuNaqL81awY
        ctlUKbRpH0G+drjgv+GDGXQJ9uQNVinQtZrDe5Xe+mpHq7lRvDeGgdR+UFuf5WNoyPSDNL7
        3m++iuZYOAm1S/vXw0mj0PYzFxWxnYKuTFtA/YBZa/6juNsubDupYkhSUC56oBtoXH7BdRw
        XPBh/SripEEQzVeC6jDZLqNXIUb2C9k8gNDGXOm9strZoQEVCV72qy1+f5oZw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/radeon: Fix comment typo
Date:   Sat, 16 Jul 2022 11:57:32 +0800
Message-Id: <20220716035732.30449-1-wangborong@cdjrlc.com>
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

