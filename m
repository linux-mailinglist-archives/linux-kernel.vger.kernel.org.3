Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DF5539CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbiFUSyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiFUSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:54:43 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99915FE4;
        Tue, 21 Jun 2022 11:54:36 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655837655tbb8zg4g
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 02:54:11 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: e00egQTBacTlcDxwIZzv4cwiUY0YAZ5kptuyvGlLEHWQoXnT7viwCQeLnJBsD
        aCN96z90YuCSZ31/ZQsyYPNbZWAxLGT0d2iCvT20BTkHS1JA0E2DXKE3jB3tGm2drgSZISY
        Spf5wgKE2mL34i4Xkkwbkrjn1vyI9+PegpUGjy4cAamRlmmagAhBa2olMotGHtVILIZzwXn
        WY/y8nnWjzL2ZxqdIhwpgdptfgFTgIGY2GoBbTbbKkXMnU3z9RKrh0jVpWFzz1ufzmtqbQR
        92dYz0J/hhkMH+o3Dq/e4WtIQNNYCQAKE+gZjvG6ERpW13hxk2nRgMOo/9VLgRXZxKnmYb9
        +De5bvlNROZyY+MBq4=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     deller@gmx.de
Cc:     b.zolnierkie@samsung.com, arnd@arndb.de, tony@atomide.com,
        jiangjian@cdjrlc.com, jmkrzyszt@gmail.com,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: omap: Remove duplicate 'the' in two places.
Date:   Wed, 22 Jun 2022 02:54:09 +0800
Message-Id: <20220621185409.4859-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: drivers/video/fbdev/omap/sossi.c
line: 362
     * We set explicitly the the bus_pick_count as well, although
changed to
     * We set explicitly the bus_pick_count as well, although

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/video/fbdev/omap/sossi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
index c90eb8ca58af..66aff6cd1df0 100644
--- a/drivers/video/fbdev/omap/sossi.c
+++ b/drivers/video/fbdev/omap/sossi.c
@@ -359,7 +359,7 @@ static void sossi_set_bits_per_cycle(int bpc)
 	int bus_pick_count, bus_pick_width;
 
 	/*
-	 * We set explicitly the the bus_pick_count as well, although
+	 * We set explicitly the bus_pick_count as well, although
 	 * with remapping/reordering disabled it will be calculated by HW
 	 * as (32 / bus_pick_width).
 	 */
-- 
2.17.1


