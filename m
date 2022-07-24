Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D157F3C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiGXHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiGXHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:39:32 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E613F30
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:39:27 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658648357tnyquacb
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:39:16 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: TXoNPSSaW4mNzmGZcubrXkzakWZSv2BucF8BlpBbW7QbtIbl1t+jzX3FJ+cT6
        FTE1gmNTsd4afLdOZZlklAlQm7ytCv3CKyKh98e+mY0pWl3MWinQbqdMQGzTp5oPfD5RPy8
        MfVajVY2J/sh9IWZSpS0y8dyfhHFNJIZsuQfI0TXZwlHmNdi0e3WDVR7FbiXAUR2fjgCP3Y
        wA7uZWy6EwGiwhDfebyDfU33j0jw3aci3pI/xrrRMpJzT1e/dPKEY8r4BGQkFpfG0MLBLz+
        OKCQTjPqySWTJAtajaaRWA8a4sF4Wd45jtBymRFgPH4rpQKa44DONFW8qpZpb0Fxj82pBnl
        aCkVqdbnUUQ3YzXYoAaCqfALnrGYNAl8xs9Hx6ZaGK7cXegR5IVOBUxLF10LA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, irlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:39:09 +0800
Message-Id: <20220724073909.17164-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 4562a8b86579..1ece22e7b6cb 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -935,7 +935,7 @@ EXPORT_SYMBOL(drm_framebuffer_unregister_private);
  * the id and get back -EINVAL. Obviously no concern at driver unload time.
  *
  * Also, the framebuffer will not be removed from the lookup idr - for
- * user-created framebuffers this will happen in in the rmfb ioctl. For
+ * user-created framebuffers this will happen in the rmfb ioctl. For
  * driver-private objects (e.g. for fbdev) drivers need to explicitly call
  * drm_framebuffer_unregister_private.
  */
-- 
2.36.1


