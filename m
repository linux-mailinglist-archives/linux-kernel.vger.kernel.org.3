Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47C56B0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiGHCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiGHCsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:48:01 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D99174370
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1nzot
        kOABl7OCJlNnnM2mS9ytvB/1yubrP9ZFwrsivc=; b=Z6IgAEVGPLj7J97ZlgIO9
        O/S8/ta7p1gaNebKIYKo8zdYOsuVrxf/kyVLHnNIUN/3zcols739BRu7cUWBnnN3
        MiRKs3wrv7JN6ufqfzEGKZHASbWudTS+F6HLrEmqf06HlPQkPemIvJHlSahWc/5q
        qWBbowSiBEOsrcRm1+/1po=
Received: from bf-rmsz-11.ccdomain.com (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAAHCKihmsdiYmyhNw--.45193S2;
        Fri, 08 Jul 2022 10:46:58 +0800 (CST)
From:   Zhongjun Tan <hbut_tan@163.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.c,
        tiwai@suse.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jiaxin.yu@mediatek.com,
        tanzhongjun@coolpad.com, colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8186: Remove condition with no effect
Date:   Fri,  8 Jul 2022 10:46:51 +0800
Message-Id: <20220708024651.42999-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAHCKihmsdiYmyhNw--.45193S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxur4xXr1kGrW3Xr15XFb_yoWfKFc_G3
        s7Gw17ua45GFW8C39rtr4kCr1DXFWrCa4v9F13twnIq34DWF4ru3sIv3s7ur4DZw4kZayf
        Jw1Svr1fXrWqvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnqjg3UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBXgM4xlaD+mHdqgAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjun Tan <tanzhongjun@coolpad.com>

Remove condition with no effect

Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index db71b032770d..6be6d4f3b585 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -295,8 +295,6 @@ static int mtk_adda_pad_top_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x39);
-		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
-			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
 		else
 			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
 		break;
-- 
2.29.0

