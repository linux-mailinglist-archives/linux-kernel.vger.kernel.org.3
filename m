Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC77D595CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiHPNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiHPNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:10:39 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133AB24A2;
        Tue, 16 Aug 2022 06:10:30 -0700 (PDT)
X-QQ-mid: bizesmtp62t1660655421t8je3jh3
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 21:10:20 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: ILHsT53NKPjhC6sTij/xeN8rhMmPWGvtPJWDYLMgqxtZVM17yqE/y8x0oYmur
        P3QNT5Z+NZ2Q7QT5l4tKEdo0LQ5FIjMBiHYQFqeRGLXgCYvv+5HrDPvVPYMO7AeYC2FQX5n
        n5XVMiCVIWdhxo1eP3QsY+fq8o79IPJMfNhkr9lr8DEgRvuEGlH9wfrkDNnY44bxKoK5myb
        wS3wZkQIS0ofdF2hcVsQsThYeFiGDiOE5arlFcm7csNcgcWYe7ec/znNS+g1N5WasmNvHB0
        paeFk/BJErwZyQGzBkdQu/qkJWHOKMnpNidV2BIUuCWfOHRcO1xK41gtBZqbyd34t8epPiL
        l4zgg5ap6dFjEPPNaKrfaMLwgtKLrfnGcMH8I2VjGz+cQ/gOobYAT3Gx2tVlP6NVIqmFHYJ
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] video/fbdev: fix repeated words in comments
Date:   Tue, 16 Aug 2022 21:10:13 +0800
Message-Id: <20220816131013.30643-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'its'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/video/fbdev/skeletonfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index 818b3a5003e1..f316ea320d29 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -97,7 +97,7 @@ static const struct fb_fix_screeninfo xxxfb_fix = {
     /*
      * 	Modern graphical hardware not only supports pipelines but some 
      *  also support multiple monitors where each display can have its  
-     *  own unique data. In this case each display could be  
+     *  own unique data. In this case each display could be
      *  represented by a separate framebuffer device thus a separate 
      *  struct fb_info. Now the struct xxx_par represents the graphics
      *  hardware state thus only one exist per card. In this case the 
-- 
2.36.1

