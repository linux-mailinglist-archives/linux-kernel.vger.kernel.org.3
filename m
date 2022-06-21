Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D85539E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiFUS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350789AbiFUS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:57:10 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985B2A26F;
        Tue, 21 Jun 2022 11:57:04 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655837745tf77ccv4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 02:55:40 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: OgQh5dxRN5wbavA1GfzuufKZqLUg4wAI9+JIV47vYKEuw9sHuek563x2EmWfR
        kUKQViagBIljkrsybiRSNkrMi6wkuyggXAxdkvDVJtwanDJJ8c8QRNHn2z1Ot0T9EvTHnPW
        M2UkZD8DJRDIA9R830uknoMgoCkgyQfYIXib8KN8Y43WCgQVDTgKM4pzuDn1YettdaXVutc
        0K/I0zkp+PKvgPqGjTXeEYgQhN7TwPhP3D910qO+BIQ9NKmMm4f/gSIGFAPwVp4FHM5WCPD
        DAtYyuHoD86E9umdDIYD668uz5v8lsQSQe7vZUuQ9d/ssCeeueTkIRukdpENqNDc6HfONnM
        kjmHDaXMESyv6oqCY0=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     deller@gmx.de
Cc:     arnd@arndb.de, tony@atomide.com, jiangjian@cdjrlc.com,
        jmkrzyszt@gmail.com, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: omap: Remove duplicate 'the' in two places.
Date:   Wed, 22 Jun 2022 02:55:38 +0800
Message-Id: <20220621185538.6072-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
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

