Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DF4CF42D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiCGJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiCGJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:03:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07066168
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:02:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n2so3666270plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=T9sNyGPslu7pePFJSRIoI7XN6IK0Rl/U6UawibuUj8w=;
        b=kKYdGsJROD4OCCbZLJfSbXDMuUvSumWj8d/pHxsMdlNQJH0c43xdLeVuIhK/9jkAh9
         I/had2q6jkKGNqwPXv2Q2kJ8q1/9lX+z92l3zRzcoUDnXBkuv7vmkyiZz2Tu+srNfcTI
         zqzK+uNoiv9VvRd6zw/sAXbTUf8KfY8LboKMENE/cdvNF2R4HqOqAMQ87X5EIHDFY0tR
         DdakT5HIykvDSRe/c1Ls15g/HzYEurN7pH/ysDj7aYBgDYwnGM6i0EWEPx7G5/OFU9t+
         vSDvBcYM1ZBcHC6Oo8wbjfPGS1j0YIde0h7zzLs4gPVPYfY5/dJJxY3MuWtO9XpOiUif
         biAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=T9sNyGPslu7pePFJSRIoI7XN6IK0Rl/U6UawibuUj8w=;
        b=m8HmqUCMZNZwzgKT9LY+gQ/oqOB9qhSu3oQ3fTBzuWJaVtOrLU1ZwFMmuixDimm/Y3
         YZ0fq1noDitAc42UxCTAYS2uWd176B5RdpCpEXk+D3sCEqcB8scIEnIMbLnWj1toaS1V
         bIulBVL2T0/nQdBii97oBfm0nG126u1gynW5rSHl3FLA7z/Vq8Wza4ZTN7t82LqyPjmZ
         HEe84GewBJ5mdA4ep5n36OYkU5gF/jTdgHLHWGSlreqn0NLCwhAEVwq6zlrIBjdTwRil
         agqVz97QftQE+hxGVB+so1QE3TXJ5Mj/CHAdiSDUzE53PXPrkxna64HCQUnIEbaLHHap
         h5+g==
X-Gm-Message-State: AOAM532Gvd7rzbmmXtftI/ZzJMA6foJAoGBMLh815O6W0fXk8s7Sd5SE
        fPWGKidFOgpth53cocOXkTE=
X-Google-Smtp-Source: ABdhPJzkVOsSJAkFEiNUwUFAsy1730LBS8+OzwMcXGSseI3J/C0zrMKB8QafKzTl3vzqGryZ2R83uQ==
X-Received: by 2002:a17:902:8b87:b0:14d:7920:e54a with SMTP id ay7-20020a1709028b8700b0014d7920e54amr10915799plb.140.1646643755176;
        Mon, 07 Mar 2022 01:02:35 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm11177939pgp.15.2022.03.07.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:02:34 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rk817: Fix missing clk_disable_unprepare() in rk817_platform_probe
Date:   Mon,  7 Mar 2022 09:01:30 +0000
Message-Id: <20220307090146.4104-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from rk817_platform_probe() in the error handling case.

Fixes: 0d6a04da9b25 ("ASoC: Add Rockchip rk817 audio CODEC support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/rk817_codec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index 03f24edfe4f6..8fffe378618d 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -508,12 +508,14 @@ static int rk817_platform_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "%s() register codec error %d\n",
 			__func__, ret);
-		goto err_;
+		goto err_clk;
 	}
 
 	return 0;
-err_:
 
+err_clk:
+	clk_disable_unprepare(rk817_codec_data->mclk);
+err_:
 	return ret;
 }
 
-- 
2.17.1

