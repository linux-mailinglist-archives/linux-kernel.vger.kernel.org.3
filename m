Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D638570742
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGKPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGKPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:39:35 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DC32B96
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:39:33 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id trfX2700U4C55Sk06rfXrQ; Mon, 11 Jul 2022 17:39:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvVT-0036sa-FG; Mon, 11 Jul 2022 17:39:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvVT-006sNz-38; Mon, 11 Jul 2022 17:39:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: fbdev: cirrusfb: Make cirrusfb_zorro_unregister() static
Date:   Mon, 11 Jul 2022 17:39:30 +0200
Message-Id: <f4b0278d16982adaffdae1f30a369a24052c048d.1657553887.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cirrusfb_zorro_unregister() is only used locally, hence make it static.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/cirrusfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 51e072c03e1c670b..a41a75841e10ef06 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2301,7 +2301,7 @@ static int cirrusfb_zorro_register(struct zorro_dev *z,
 	return error;
 }
 
-void cirrusfb_zorro_unregister(struct zorro_dev *z)
+static void cirrusfb_zorro_unregister(struct zorro_dev *z)
 {
 	struct fb_info *info = zorro_get_drvdata(z);
 
-- 
2.25.1

