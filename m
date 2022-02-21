Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9C4BE07A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358784AbiBUNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358716AbiBUNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E71EEFD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m27so15213939wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2U8Gf3HJdH9syGZl9j1jogHOiAd7YSk+hDONNdww6Ps=;
        b=I+dOyBnJS4SRSq5buGKlAzEiHETqO9p+g2O0IpuK8oBLKaHrXmg2U4VlsqIUFZOSxh
         eHPrGLmQiOBf3HIoYDkTGaPN98bzznwbdXh4kZ5/JCdB6mvnKJgn1ezUlkZb3oV7igRG
         PqQFGVEL5Hhb4lwtAAQxdhR2jV9yjt5aZAekEI14NocbkQ0RIFjHUmbks6YmAjmYEQLy
         Z5pLb8tUjm+cV4AJvnsXVFhAWL8yEzVyaBLUqSizVaT0mLnTgq9kfHcUJwoAUJuIMjle
         ISSAKQptuE+8xA4n0KYfUJF610tWF/rFE/gcGKYZSLplADKsGLMN+lV33IazUFyW8Zdv
         eqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2U8Gf3HJdH9syGZl9j1jogHOiAd7YSk+hDONNdww6Ps=;
        b=XKTQWkffPkJPkaAa+6e1G6jAugq6hmayLI+3a6leM4M33KrNNReQaj+WdGNO3VEFks
         wlYePsOEjflxhfYhZG834nSaMtUdTdz1MPDqmZIMWpWrczzkQg6pV/RCAsAw57XzJ3Rv
         cphRUN/+/uJgDRJwCtDfWWKAT4wETILt1rOMz+nczSJ2A7pp59Fb7Ik06TG2JY/bEy9X
         ZDx6Hvht7Z2H85N4aY7R10rFD79hs+MhmRBbWNp4qjEzPIFtkjIoGm95m9txYBE+nrS8
         CQNm8P7eyELFo38uzk90VlLIsR2xX77ufTJLi+KSuztrysgPxLvnGgD2LgOU3G2O0EvS
         2D4A==
X-Gm-Message-State: AOAM5317gOgk1SbWApouvvHOPYuRRQ3Om//wtOpp7EEci+0W5o6gMJnG
        tlAmlMAOgp9p9La1sCkEkZsCoQ==
X-Google-Smtp-Source: ABdhPJwlbxv93gkUtu9c2GU5/Fcp1Mwcm0jj3wbGovTiBxEEh4DWuGiuIKoTxqB2wGyS9YPkIu9v0w==
X-Received: by 2002:adf:e952:0:b0:1e3:39ed:d990 with SMTP id m18-20020adfe952000000b001e339edd990mr15889802wrn.215.1645449052490;
        Mon, 21 Feb 2022 05:10:52 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/10] ASoC: codecs: rx-macro: setup soundwire clks correctly
Date:   Mon, 21 Feb 2022 13:10:37 +0000
Message-Id: <20220221131037.8809-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
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

For SoundWire Frame sync to be generated correctly we need both MCLK
and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain on,
however after adding pm runtime support its possible that NPl clock could be
turned off even when SoundWire controller is active.

Fix this by enabling mclk and npl clk when SoundWire clks are enabled.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index fb5d4bb8bd8b..9ce83cff3e1b 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3428,6 +3428,7 @@ static int swclk_gate_enable(struct clk_hw *hw)
 {
 	struct rx_macro *rx = to_rx_macro(hw);
 
+	clk_prepare_enable(rx->clks[2].clk);
 	rx_macro_mclk_enable(rx, true);
 	if (rx->reset_swr)
 		regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
@@ -3453,6 +3454,7 @@ static void swclk_gate_disable(struct clk_hw *hw)
 			   CDC_RX_SWR_CLK_EN_MASK, 0);
 
 	rx_macro_mclk_enable(rx, false);
+	clk_disable_unprepare(rx->clks[2].clk);
 }
 
 static int swclk_gate_is_enabled(struct clk_hw *hw)
@@ -3490,7 +3492,7 @@ static struct clk *rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->clks[2].clk);
+	parent_clk_name = __clk_get_name(rx->clks[3].clk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

