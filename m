Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962A596174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiHPRvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHPRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:51:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9EA82754
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:51:35 -0700 (PDT)
X-QQ-mid: bizesmtp71t1660672277tnjh8cwu
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:51:07 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: 6ArnuSDJ+imu+VjUQtt6P1w7IC8Ca6CyTAw+gGH+Fbqri0DwIvDJE92OK7rOz
        ++kG6TwdXmklaZn2d7esEEfsyzaBRtq0W7ot0ZlmrnENkoSrkssWs9wTBa58zktv5IZpwQ+
        FLME7RCIkG0lneYnti7ZOtD7TXs/t5N1FiF87X60Q8HgWNpwK9fn0pi9u71nLgRtFAnWize
        OmrOCG53tZFdlQxNswc2C4oDMwvT6nSNjRVbr0OInY+OM1Mld7fwj1hH5aGwK5+i4eD96Ci
        HlK+GG0Vskr4MnxsUpf1hRv/yVAUJbBbIN4k2zkg3rnm+eh39eZIxY1eTOb5joMLRW4xnHm
        MuG1IZz9utxcLMKFh1UCClrC+VgogE/I8jal8tipIw0CpUGKSKnl8pZ8IhS4fxMvlpLlnQu
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ASoC: Variable type completion
Date:   Wed, 17 Aug 2022 01:51:05 +0800
Message-Id: <20220816175105.8084-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/soc-ac97.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 5f49e3dec3fc..32c5be61e2ec 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -57,7 +57,7 @@ static inline struct snd_soc_component *gpio_to_component(struct gpio_chip *chip
 	return gpio_priv->component;
 }
 
-static int snd_soc_ac97_gpio_request(struct gpio_chip *chip, unsigned offset)
+static int snd_soc_ac97_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	if (offset >= AC97_NUM_GPIOS)
 		return -EINVAL;
@@ -66,7 +66,7 @@ static int snd_soc_ac97_gpio_request(struct gpio_chip *chip, unsigned offset)
 }
 
 static int snd_soc_ac97_gpio_direction_in(struct gpio_chip *chip,
-					  unsigned offset)
+					  unsigned int offset)
 {
 	struct snd_soc_component *component = gpio_to_component(chip);
 
@@ -75,7 +75,7 @@ static int snd_soc_ac97_gpio_direction_in(struct gpio_chip *chip,
 				   1 << offset, 1 << offset);
 }
 
-static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct snd_soc_component *component = gpio_to_component(chip);
 	int ret;
@@ -88,7 +88,7 @@ static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!(ret & (1 << offset));
 }
 
-static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned offset,
+static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned int offset,
 				  int value)
 {
 	struct snd_ac97_gpio_priv *gpio_priv = gpiochip_get_data(chip);
-- 
2.30.2

