Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755675633CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiGAMzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiGAMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:55:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74953DDD9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:55:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so3662659wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/zpAUSXHcaK7+lz3X+at5X7Rn81jEs7bS7mt8AYxnk=;
        b=D0AhKSEZcFIDBZ23WtrHIbfZg8MnEF/dKg4mqa2PGaifGv7RQe7whTR/TxHhD5REk8
         j/Xxxo9POeccf3YCBnnku8MldUOgMVE/EiI/vEufpyUDDBol4dzImfjNHbmHiHrXIhdE
         gseBf4Stys2CAlHvdgvqBa/BpKVjkRvsLQPSZ2svmkpPT1lJNXkxtp5L/jSy5LZPnP5q
         8QYUy4CU/sP+rCnAMTxyrziH/Wm8kzkh6s53OQenz2baGYp8BmOxlR6s8JrPuQculXrR
         dtrwz9QwEj7SSm2HjLgG3EBIdm56c4FckBu9FcjO0KS6PzgbcI5OwCdgkqFHLLg2QqBB
         B8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/zpAUSXHcaK7+lz3X+at5X7Rn81jEs7bS7mt8AYxnk=;
        b=tucnVaU3TvPPQNMkMZLlX2sZGQWZbYpC7jJgJSOlP2QaTX5/cdD8kkRPrHum95y9mg
         aaTJDXJiB3uSX0sUcInM4SxJXnhNr7gh7pJb4fggCa6DlOaWivbvvG+7wLxYNmqOMoLO
         38pEB10NfaISxbq8O+OTmYjZyHzQq9vcrgPsKMRGOHf8iAW2STwxu8j4cjxPQTU8MG7z
         G+xDJp2E14hmtI8t+BEfsFavBH236EZGcrFivJ9J6e/tx34zl1nYm5tpj8nHOhHxB+0X
         XJHoljBlHUMMuRuFrlskGQOoq8hDf5xyZTN6AwqmLRx4ePxNCDIhKkc6ioaGrDMAna5r
         nHrQ==
X-Gm-Message-State: AJIora+obDhTvUW0N8G7kZM0IDygWObl+3dgP4dhzhXf45B4u3cKgIQB
        j7b0yOAGKF5PSpqfhMtged6Elg==
X-Google-Smtp-Source: AGRyM1uKRBghJ6kcFj5l5By8aD2i2YYibOuzmE+MmY5PZ5v4hYIXCXbw+CXC0mQh5PUqeSel7HmEsg==
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr17589862wms.93.1656680129537;
        Fri, 01 Jul 2022 05:55:29 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm22798386wrr.3.2022.07.01.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:55:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: codecs: wsa883x: add missing break statement
Date:   Fri,  1 Jul 2022 13:55:15 +0100
Message-Id: <20220701125515.32332-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break in one of the switch statement.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 40c7d64a9c41..dcd88175b9cd 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1204,6 +1204,7 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 						      WSA883X_SPKR_PWM_FREQ_F300KHZ);
 			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
 						       WSA883X_DRE_PROG_DELAY_MASK, 0x9);
+			break;
 		default:
 			break;
 		}
-- 
2.25.1

