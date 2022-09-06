Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D15AE41F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiIFJ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiIFJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA21CD9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 363D46601EB2;
        Tue,  6 Sep 2022 10:27:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456459;
        bh=WyVYZj+c9maI28dTmRLQ5XLV8nr4NB4/PmV9sY12Gmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvL7hcmYNk/2CwJ3pZ9ZoLT98cjdp69vFL19MlIdv+b7lziyVountzzH4vlXnc+OW
         ZTh6WDE0KOWl2orEeVlPnAn/FoTp89rCJcgn2Vpe/cDljqQ1xRznKoc7ZYK8cniwN0
         oJHCPQFf/HvsWwA8hz7UHDIyTlINe1FLJIbh3GOKC5BODT2+k0UE27D5qFz2nsXsBb
         HjWhFFGg4O4ItFmN6/wKmHnXBw10ndrFevUobUu9h7fUP4TFpVz2mWYvfXa6e/ey2g
         J7Ef/JeNGkzLlWg2byJkSY0xCD5IQRHpbQPRs7/ogKE7A7NCgHzZASY5PMPtOxELof
         zDGl05rTg4iwQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, wenst@chromium.org,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, trevor.wu@mediatek.com, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com,
        Allen-KH.Cheng@mediatek.com, geert@linux-m68k.org,
        chunxu.li@mediatek.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 2/5] ASoC: SOF: mediatek: mt8195: Import namespace SND_SOC_SOF_MTK_COMMON
Date:   Tue,  6 Sep 2022 11:27:24 +0200
Message-Id: <20220906092727.37324-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
References: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we're using function mtk_adsp_dump() from mtk-adsp-common:
explicitly import its namespace.

Fixes: 3a054f90e955 ("ASoC: SOF: mediatek: Add mt8195 debug dump")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 9c146015cd1b..ff575de7e46a 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -652,4 +652,5 @@ static struct platform_driver snd_sof_of_mt8195_driver = {
 module_platform_driver(snd_sof_of_mt8195_driver);
 
 MODULE_IMPORT_NS(SND_SOC_SOF_XTENSA);
+MODULE_IMPORT_NS(SND_SOC_SOF_MTK_COMMON);
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.37.2

