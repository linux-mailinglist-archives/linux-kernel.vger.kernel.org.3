Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA686536B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiE1IBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiE1IBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:01:03 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBD41142
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:00:58 -0700 (PDT)
Received: from pop-os.home ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id urNWn1xHmP8ApurNWnc56v; Sat, 28 May 2022 10:00:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 28 May 2022 10:00:56 +0200
X-ME-IP: 90.11.191.102
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tglx@linutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: ab8500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
Date:   Sat, 28 May 2022 10:00:53 +0200
Message-Id: <28c0833d4a11f8f75f385e5aad93c23721b06c7e.1653724847.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Replace GPLv2 boilerplate/reference with SPDX" has left some empty
"License terms" paragraphs.
Remove them as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/ab8500-codec.c | 2 --
 sound/soc/codecs/ab8500-codec.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index aefafb0b7b97..cbd4a92cb06c 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -12,8 +12,6 @@
  *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
  *         Jarmo K. Kuronen <jarmo.kuronen@symbio.com>,
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <linux/kernel.h>
diff --git a/sound/soc/codecs/ab8500-codec.h b/sound/soc/codecs/ab8500-codec.h
index 0ac87d0446c2..2a6f6409f1f8 100644
--- a/sound/soc/codecs/ab8500-codec.h
+++ b/sound/soc/codecs/ab8500-codec.h
@@ -11,8 +11,6 @@
  *         Mikko J. Lehto <mikko.lehto@symbio.com>,
  *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #ifndef AB8500_CODEC_REGISTERS_H
-- 
2.34.1

