Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22899536B86
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiE1H7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiE1H7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:59:37 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED3D7A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:59:35 -0700 (PDT)
Received: from pop-os.home ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id urMBnT8ApIaWOurMCnw1Bl; Sat, 28 May 2022 09:59:33 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 28 May 2022 09:59:33 +0200
X-ME-IP: 90.11.191.102
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tglx@linutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: ux500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
Date:   Sat, 28 May 2022 09:59:22 +0200
Message-Id: <84d94977c57deee9e85249f18394ebf8d72497bc.1653724723.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 sound/soc/ux500/mop500.c        | 2 --
 sound/soc/ux500/mop500_ab8500.c | 2 --
 sound/soc/ux500/mop500_ab8500.h | 2 --
 sound/soc/ux500/ux500_msp_dai.c | 2 --
 sound/soc/ux500/ux500_msp_dai.h | 2 --
 sound/soc/ux500/ux500_msp_i2s.c | 2 --
 sound/soc/ux500/ux500_msp_i2s.h | 2 --
 sound/soc/ux500/ux500_pcm.c     | 2 --
 sound/soc/ux500/ux500_pcm.h     | 2 --
 9 files changed, 18 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 4f41bb0ab2b0..fdd55d772b8e 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -4,8 +4,6 @@
  *
  * Author: Ola Lilja (ola.o.lilja@stericsson.com)
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 1ea1729984a9..e5e73a2bd9fe 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -5,8 +5,6 @@
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         Kristoffer Karlsson <kristoffer.karlsson@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
index 087ef246d87d..98de80a9cc4f 100644
--- a/sound/soc/ux500/mop500_ab8500.h
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -4,8 +4,6 @@
  *
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #ifndef MOP500_AB8500_H
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 21052378a32e..56532b62faf3 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -5,8 +5,6 @@
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
index fcd4b26f5d2d..30bf70838196 100644
--- a/sound/soc/ux500/ux500_msp_dai.h
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -5,8 +5,6 @@
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #ifndef UX500_msp_dai_H
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index fd0b88bb7921..d113411a19f8 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -6,8 +6,6 @@
  *         Roger Nilsson <roger.xr.nilsson@stericsson.com>,
  *         Sandeep Kaushik <sandeep.kaushik@st.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 756b3973af9a..d45b5e2831cc 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -4,8 +4,6 @@
  *
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 18191084b8b8..d3802e5ef196 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -5,8 +5,6 @@
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 
 #include <asm/page.h>
diff --git a/sound/soc/ux500/ux500_pcm.h b/sound/soc/ux500/ux500_pcm.h
index ff3ef7223db6..bd4348ebf9a1 100644
--- a/sound/soc/ux500/ux500_pcm.h
+++ b/sound/soc/ux500/ux500_pcm.h
@@ -5,8 +5,6 @@
  * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
  *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
  *         for ST-Ericsson.
- *
- * License terms:
  */
 #ifndef UX500_PCM_H
 #define UX500_PCM_H
-- 
2.34.1

