Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51F59E858
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbiHWRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiHWQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:29 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9D9E8A6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:13:17 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661263987tvsjyje9
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:13:05 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 7jw2iSiCazoxMSclW6PN5wLbkkpq/R/rMTmC0eGoqLvPIJxpBnLVIzRsLMAg/
        upG5xdRWhzuj9O0nPaTVSO+OI3lrvUEnp9WpqnqTthEkrwUURNEGbpaYoCZ7rtwovfvk+d0
        sDnB8ApoYGIhjNvKFOtxLg9yLays9Ruy2jmZLSPxUOufAhRnywTbUqFWtxt+UHZwSW+d4qT
        Tr4WE5j+9d8c1Xmb3EgV+EglZn3gQBWC0AaKk2JC+DhOZ7plUL9CB2zHD7Vt+8xiRaxf7fB
        XPqmCOUnLMqzfHxndgC80hitO3yB3cNr7JL+hlvtMkGrW1jo2ac9y6JKpqq3L2rQAY/zqCY
        rMa19kO8NGxjxOqjF7pFpAsgkojSVwxAlqYaVri4P2Mg9Fn/rEN5i0ebm4/5Q==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, irlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:12:59 +0800
Message-Id: <20220823141259.10668-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/drm_rect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
index 0460e874896e..8873922d6dee 100644
--- a/drivers/gpu/drm/drm_rect.c
+++ b/drivers/gpu/drm/drm_rect.c
@@ -81,7 +81,7 @@ static u32 clip_scaled(int src, int dst, int *clip)
  * @clip: clip rectangle
  *
  * Clip rectangle @dst by rectangle @clip. Clip rectangle @src by the
- * the corresponding amounts, retaining the vertical and horizontal scaling
+ * corresponding amounts, retaining the vertical and horizontal scaling
  * factors from @src to @dst.
  *
  * RETURNS:
-- 
2.36.1

