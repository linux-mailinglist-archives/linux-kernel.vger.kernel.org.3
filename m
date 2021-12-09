Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB17E46E08D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhLICAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLICAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:00:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FCC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:57:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so3608212pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5JhuTQaSxTx893jA8OEYjLZ6m+UdW5ZaFdhJ6c8uD0=;
        b=Ba1znVjXLY9GcEcVgPC+HjDyG9n6vEr76BaqSF45Rkblx6GhAiq8SPzc9NJLA23TTx
         QT0pbH1LhxSGNgAeqp8W9y1G2PYsmJx//5tjLbJ20xIy3iOXFJKaAtVBNo7YsorhwAAT
         LU5EllIYETKOGr487pn8D/Ehhg8Es07ACMwAVhNT4x4HrsQijtW51S9o+GuHvukAZoIb
         71+he2EX2hylva4nv7QvraTYh4Pus/ACybGeZR99wQAXKtAXx4GMQff9Qx8RVxygHwzD
         UlduSGJvGrYaPjs050TLuLiG43iKTiq/JYM496cEeqUxyh0alkKc/YZCbyXaN4P/L3xn
         8d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5JhuTQaSxTx893jA8OEYjLZ6m+UdW5ZaFdhJ6c8uD0=;
        b=m63AphkDTl9kpKTazuKhcO6mc+/BeukNOI2h0vxvMhpcUUiqwD/ltNstJWbCtUTUII
         9nF5aZk3Gp11Q47vDNYFhV1rZt/c6V33ExCXXUv1FwxdHaS2gcwbTuuniiluA0l4lVlP
         axqEJ2VTr0NHwYs42KXPsmKRFNyQLZySvqlu3xOJPwdh1GJYYWL5vH1v1+ldLnCGiADV
         p95GXB5VMGxd3bcHgY2u3RbIzT/d6PS3angZKdrCmiGWywKUJcqn4+We8WQdCJx2kBjT
         PeJb1so28hGKbmCiL/kwf+WDVYjQcQVc/IW+JP3qTFHZo5k0iIe84HsB0N6Rl6QLQ06z
         1FKg==
X-Gm-Message-State: AOAM531m7E30cJ3eKcSH+XqCLfdoqy2dCmsYXdsWcmNMVnukjnEHJCSG
        shE3Hi8lIrXY6/uUjCoaU7w=
X-Google-Smtp-Source: ABdhPJyn5cV0V2r/Ax01DHo15SrmY4+pGt+Dmaz+wqBD3YLt3imwzKNbDbcT3qSwczTEmqQdiaDiKA==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr11764748pjb.19.1639015032987;
        Wed, 08 Dec 2021 17:57:12 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i3sm4546748pfe.75.2021.12.08.17.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:57:11 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, chi.minghao@zte.com.cn,
        kuninori.morimoto.gx@renesas.com, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, pulehui@huawei.com,
        srivasam@codeaurora.org, lkp@intel.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] sound:soc:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:57:07 +0000
Message-Id: <20211209015707.409870-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/mt6660.c  | 5 ++---
 sound/soc/codecs/wcd938x.c | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index 358c500377df..3a881523c30f 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -47,13 +47,12 @@ static int mt6660_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct mt6660_chip *chip = context;
 	int size = mt6660_get_reg_size(reg);
 	u8 reg_data[4];
-	int i, ret;
+	int i;
 
 	for (i = 0; i < size; i++)
 		reg_data[size - i - 1] = (val >> (8 * i)) & 0xff;
 
-	ret = i2c_smbus_write_i2c_block_data(chip->i2c, reg, size, reg_data);
-	return ret;
+	return i2c_smbus_write_i2c_block_data(chip->i2c, reg, size, reg_data);
 }
 
 static int mt6660_reg_read(void *context, unsigned int reg, unsigned int *val)
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 52de7d14b139..0033d61d42e8 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3083,7 +3083,7 @@ static int wcd938x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *compon
 						int micb_num, bool req_en)
 {
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
-	int rc, micb_mv;
+	int micb_mv;
 
 	if (micb_num != MIC_BIAS_2)
 		return -EINVAL;
@@ -3097,9 +3097,7 @@ static int wcd938x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *compon
 
 	micb_mv = req_en ? WCD_MBHC_THR_HS_MICB_MV : wcd938x->micb2_mv;
 
-	rc = wcd938x_mbhc_micb_adjust_voltage(component, micb_mv, MIC_BIAS_2);
-
-	return rc;
+	return wcd938x_mbhc_micb_adjust_voltage(component, micb_mv, MIC_BIAS_2);
 }
 
 static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
-- 
2.25.1

