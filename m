Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4055759FAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiHXNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiHXNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:05:23 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF480353
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:05:21 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661346298tp843bcd
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:04:56 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: +ynUkgUhZJkLxFtXN86+G8go8a45t2aO+VokbAhAjSgUtoGyXv/Qd8qE9QoS3
        L1pRXk+dh45bkdtBatHvkWSfwpxIxM8DydQz9CmG2HEYMWJCYI9gklWbE5OjFHpgfhC5gPi
        QVw8xjWaVB3m+SDybAMqTWaXiY6abH+hv2lFB4u92s/NJUM9uKQHl++CPgKUe5dcOBbQ+CM
        uRw99H/h+YoiuaGowC/BqE2fDL5swpgPU1jqnjM/Tq+76Y9myTWFmUvxflT2j80DHpyfn0q
        1U0k2oYhBOOSkPU5Bs20RqlWpgfUUpHozruy32co459sHcNHrSZoqSLkgaS++jLW7TCuX9S
        oju0GFtUBTtMhatIC6qhMtRA+90n0gFgumNAdN47rX01wLKXCXppMUZRng/oN4Lfz52R7Kl
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jyri.sarha@iki.fi, tomba@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/tidss: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:04:50 +0800
Message-Id: <20220824130450.41703-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/tidss/tidss_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 666e527a0acf..7de3a5ffe5bc 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -71,7 +71,7 @@ static int tidss_atomic_check(struct drm_device *ddev,
 	 * changes. This is needed for updating the plane positions in
 	 * tidss_crtc_position_planes() which is called from
 	 * crtc_atomic_enable() and crtc_atomic_flush(). We have an
-	 * extra flag to to mark x,y-position changes and together
+	 * extra flag to mark x,y-position changes and together
 	 * with zpos_changed the condition recognizes all the above
 	 * cases.
 	 */
-- 
2.36.1

