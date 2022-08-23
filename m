Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E859E79B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiHWQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245033AbiHWQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:38:47 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230B94132
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:42:31 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661265747tekdczxu
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:42:26 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: XBN7tc9DADLs2cWmlMMHERuY/4kGu39ow3FoW3pTTJNMOMh1dmzmH5e3TMtEi
        Fi2gaXKCT2Vv6tSwMVJE237q81IsjE5S/GRXvuL3iZRDfY5Cl1wZuy+esE8l5f+tDdve8oL
        mfZsZJh8LTrko9NI0b3Gbpemu9Ke7oCIGzDdYRz8sz4bwzmEbEROU0aUgzCPQvQcjEJAxlo
        A0mBPMp7G7vbbfK1tP2Y2PdzUb08rE8J7AjNJlkAofNMeIIvP0HUGzqUyE+9SUcc9Vjf3vr
        fWVhO7Y9ViwsgbGj4IPoChBtfu1ULbBe5Bad3zuIonUQofdrv3EdUBSg6Y7GHVv8ZGciwE3
        N8Wawy2n7Xl3lbNFReRtirpuIANLrbjCITEDLpgb5VJOSSUPWahUwO6ZTWjXQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org, peter.ujfalusi@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] ti/omap: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:42:19 +0800
Message-Id: <20220823144219.32381-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/platform/ti/omap/omap_voutlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
index 480a7e95533d..9b4aa5d84873 100644
--- a/drivers/media/platform/ti/omap/omap_voutlib.c
+++ b/drivers/media/platform/ti/omap/omap_voutlib.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL_GPL(omap_vout_try_window);
 /* Given a new render window in new_win, adjust the window to the
  * nearest supported configuration.  The image cropping window in crop
  * will also be adjusted if necessary.  Preference is given to keeping the
- * the window as close to the requested configuration as possible.  If
+ * window as close to the requested configuration as possible.  If
  * successful, new_win, vout->win, and crop are updated.
  * Returns zero if successful, or -EINVAL if the requested preview window is
  * impossible and cannot reasonably be adjusted.
-- 
2.36.1

