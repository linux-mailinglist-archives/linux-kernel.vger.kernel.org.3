Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A703557759
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiFWKDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiFWKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:03:23 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E90BC0F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:03:18 -0700 (PDT)
X-QQ-mid: bizesmtp78t1655978521tbfj69q5
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:01:57 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: hOPADF7UwX4iFB/7g9JVub6CWGg5wL+Zwsx+9FUj+tJK97Ei0f+gQUuzavP5y
        3z7R5vr7gKFIJejzAb+9iYRtSW4d8HJqBkBq4/II4Z5l9Otnt7GJRHqN9VKsayV8SDIBxjM
        6BTqf+lUZ9Jt+Fy5r0VSv0TXD41wTiHW71aZO8rEDypAkFQBr3KMmQ3KLCId6AgcHfrEpkl
        4PXCloDmexVIaHmRIcsyxZdvZEQLxHLFyWbMkGFO2RO32t6ai5zhNpJE+LQmxyRa6vFAXk0
        95pT9AW5s+8h4sZPSpXHi3l8j6+URymXTd2HkbOJh+/fmZvTwYMrsoyTKYPVraZNON0+bXt
        H9dmLnRsmoUWJXrClklHt8oQGZCoA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/gma500: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:01:55 +0800
Message-Id: <20220623100155.24806-1-jiangjian@cdjrlc.com>
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

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/gpu/drm/gma500/oaktrail_crtc.c
line - 312

/* Wait for for the pipe disable to take effect. */

changed to:

/* Wait for the pipe disable to take effect. */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 22398d34853a..407ce948bf68 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -309,7 +309,7 @@ static void oaktrail_crtc_dpms(struct drm_crtc *crtc, int mode)
 						   temp & ~PIPEACONF_ENABLE, i);
 				REG_READ_WITH_AUX(map->conf, i);
 			}
-			/* Wait for for the pipe disable to take effect. */
+			/* Wait for the pipe disable to take effect. */
 			gma_wait_for_vblank(dev);
 
 			temp = REG_READ_WITH_AUX(map->dpll, i);
-- 
2.17.1

