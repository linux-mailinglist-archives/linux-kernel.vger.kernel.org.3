Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396B9590231
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiHKQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiHKQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:05:14 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E38286D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:52:10 -0700 (PDT)
X-QQ-mid: bizesmtp66t1660233114trxafeml
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:51:48 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: Q4gfBD3K7t8iW+F0xuDf5mMaMd6N4pAHBcC2EIS+5calpQO2x1oVsk6bfAZ7T
        Y3M9N0LHD/A7CX2f15X93XNw2oLcl4+dZhLAAP2ybCUI9NNj3f4n/l+DdizVNlNpTHu3fBc
        mYUCafzJUS7gAynGqW+FCRy0nwYLdgUawc7a1z5SHfqX3sgG/fDy9x7OXv7/3FngzIvwk94
        yLKz4wG0hxRveyx09ui9CSvqw8GthCeIC2BCxpJnSmU1hgR4tJxg3SLGh88qtm4rH8CrhvA
        xjfUyAxRm3Xs6lXZtd/ELaxtSjw/Lsba+6g8vsUUz44xycfR4JbFviwEO2Jj1h5q/XGzNID
        hrfjjaYJDDQkXHPVSIwk02SSCkLuf06ub/BE/NiDLQMZ9i7anMhTCqA7ZH146aBjfmpmARo
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/vmwgfx: Fix comment typo
Date:   Thu, 11 Aug 2022 23:51:36 +0800
Message-Id: <20220811155136.13526-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in line 384, remove one,The double `to' is duplicated in line 412, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index d49de4905efa..82b9d33ecc84 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -381,7 +381,7 @@ static int vmw_execbuf_res_noctx_val_add(struct vmw_sw_context *sw_context,
 }
 
 /**
- * vmw_view_res_val_add - Add a view and the surface it's pointing to to the
+ * vmw_view_res_val_add - Add a view and the surface it's pointing to the
  * validation list
  *
  * @sw_context: The software context holding the validation list.
@@ -409,7 +409,7 @@ static int vmw_view_res_val_add(struct vmw_sw_context *sw_context,
 
 /**
  * vmw_view_id_val_add - Look up a view and add it and the surface it's pointing
- * to to the validation list.
+ * to the validation list.
  *
  * @sw_context: The software context holding the validation list.
  * @view_type: The view type to look up.
-- 
2.17.1

