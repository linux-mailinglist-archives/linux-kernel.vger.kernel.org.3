Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33558B698
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiHFPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:49:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934CDF2C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:49:18 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KM39oZntuGDTnKM3AobZvu; Sat, 06 Aug 2022 17:49:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 17:49:17 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Fix the include guard used for include/sound/wm8904.h
Date:   Sat,  6 Aug 2022 17:49:14 +0200
Message-Id: <eff524b78d1f851e3dc42999e68c286492f92b21.1659800938.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__MFD_WM8994_PDATA_H__ is already used for:
  include/linux/mfd/wm8994/pdata.h

Based on file names, use __MFD_WM8904_PDATA_H__ instead here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure of if a Fixes: tag is needed.
If yes, I would use:
  9e50108668a7 ("mfd: Add initial WM8994 support")
which introduced the conflict,

even if:
 a91eb199e4dc8 ("ASoC: Initial WM8904 CODEC driver")
which introduced the typo is more logical.

No strong opinion on it.
---
 include/sound/wm8904.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 88ac1870510e..f74293a83a17 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -7,8 +7,8 @@
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  */
 
-#ifndef __MFD_WM8994_PDATA_H__
-#define __MFD_WM8994_PDATA_H__
+#ifndef __MFD_WM8904_PDATA_H__
+#define __MFD_WM8904_PDATA_H__
 
 /* Used to enable configuration of a GPIO to all zeros */
 #define WM8904_GPIO_NO_CONFIG 0x8000
-- 
2.34.1

