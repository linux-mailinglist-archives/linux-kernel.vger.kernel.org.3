Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF20548015
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiFMG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiFMG75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:59:57 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74CB165AB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:59:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0B9761E80D53;
        Mon, 13 Jun 2022 14:58:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jrgQAJbPANH4; Mon, 13 Jun 2022 14:58:42 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 98E401E80D05;
        Mon, 13 Jun 2022 14:58:41 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, srinivas.kandagatla@linaro.org,
        rf@opensource.cirrus.com, steve@sk2.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        qixu@nfschina.com, liqiong@nfschina.com, yuzhe@nfschina.com,
        hukun@nfschina.com, renyu@nfschina.com
Subject: [PATCH] soc: There are several spelling mistakes. Fix them
Date:   Mon, 13 Jun 2022 14:58:58 +0800
Message-Id: <20220613065858.23369-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 sound/soc/codecs/lm49453.c | 2 +-
 sound/soc/codecs/rt5631.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index bd0078e4499b..2eb43e93778e 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1201,7 +1201,7 @@ static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	case 12288000:
 	case 26000000:
 	case 19200000:
-		/* pll clk slection */
+		/* pll clk selection */
 		pll_clk = 0;
 		break;
 	case 48000:
diff --git a/sound/soc/codecs/rt5631.h b/sound/soc/codecs/rt5631.h
index 8a6b99a48c7c..0caca2e1d31b 100644
--- a/sound/soc/codecs/rt5631.h
+++ b/sound/soc/codecs/rt5631.h
@@ -373,7 +373,7 @@
  */
 #define RT5631_SDP_DAC_DATA_L_R_SWAP			(0x1 << 4)
 
-/* Data Length Slection */
+/* Data Length Selection */
 #define RT5631_SDP_I2S_DL_MASK				(0x3 << 2)
 #define RT5631_SDP_I2S_DL_16				(0x0 << 2)
 #define RT5631_SDP_I2S_DL_20				(0x1 << 2)
-- 
2.11.0

