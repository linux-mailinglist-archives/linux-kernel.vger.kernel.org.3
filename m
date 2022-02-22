Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654C34C0167
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiBVSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiBVSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:33:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCB10782C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n29-20020a05600c3b9d00b00380e379bae2so1220779wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSXL61TJ4FNLzWo1z0RhBOi7zjEjelC9n+5VWaG+Gtc=;
        b=LOawPkVnk1MoWqXpWg+WWqin6xRMXhzW4CLjSSOhnuq+96bpU6bSNdNC/i2q8xxCxU
         pD7o8rNuHyRITWoTZzNmgrO8VQX0+5qvwi6++2BjpM8LQbsaC8GVdmwGyGDyp2qdaW/A
         nwPt+QvZNxnUnk7uGrfM/jc4F7I6LjHiST6yseSPN84zlakeiK/xAmzG8elnlIWDNFF6
         aXuyrcOwDCwH+2AjdPF/Q0uQo+KRibmh8Bfajko2eqMdVqXRQe8bCviaLxssJFnHJAvA
         BrVdS30ex+AOTwkyt0kivVyTgcU84ldmZDLMxz4/jyCeO3CzYRATJKgmy1Y8ZPnZikX3
         PjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSXL61TJ4FNLzWo1z0RhBOi7zjEjelC9n+5VWaG+Gtc=;
        b=Y8tKsHdsh1nAPIi0AtbzC+dwPXWgQLMA4kNsI1yQ69mWxplRk6+uE7NjmZblsOHVgJ
         sbsT4WU5SJrKCD1NlhAJJDuDnLU068hpEe3vj0Ckcr3ynDdN5+HEmjBkD1gjpRy3d4bW
         vUX8br3Cv5WZlNrVujzlaQTiVtgWfw6BbLl6b0bSbJNAGtQKz09Gkk7iU9M3wcOiipzC
         cL9Mh6CxUmp4LhdhKS+v7xOq1QgHHeXH3QSd8R79T+DTcr7rsb3NCmGxSuKQRxNDng7O
         NCt+WDitMgOppU2Y40Dd3vWx2zBKg8+L79ULRJRE71LqbzZ9X2tW+PEMQVtF9jA84vGb
         JOyg==
X-Gm-Message-State: AOAM531dT2knKNOqXi00/dSroVfvj7N3FxZvkqe8J6AZBYpBDt6PmR+r
        8BzFHJ/L8I4Ymyee5legRepE1Q==
X-Google-Smtp-Source: ABdhPJzdgtosvehWqrOxuEsYt+VvH5/nC7aOJ9BODdKou2VckN37w33Q/6riYz0ejmzxIro7uicoJA==
X-Received: by 2002:a1c:a915:0:b0:380:e3de:b78f with SMTP id s21-20020a1ca915000000b00380e3deb78fmr1724213wme.19.1645554755595;
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 9/9] ASoC: codecs: wcd934x: fix return value of wcd934x_rx_hph_mode_put
Date:   Tue, 22 Feb 2022 18:32:12 +0000
Message-Id: <20220222183212.11580-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
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

wcd934x_rx_hph_mode_put currently returns zero eventhough it changes the value.
Fix this, so that change notifications are sent correctly.

Fixes: 1cde8b822332 ("ASoC: wcd934x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index f2674905a4a7..40b414867872 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3308,13 +3308,16 @@ static int wcd934x_rx_hph_mode_put(struct snd_kcontrol *kc,
 
 	mode_val = ucontrol->value.enumerated.item[0];
 
+	if (mode_val == wcd->hph_mode)
+		return 0;
+
 	if (mode_val == 0) {
 		dev_err(wcd->dev, "Invalid HPH Mode, default to ClSH HiFi\n");
 		mode_val = CLS_H_LOHIFI;
 	}
 	wcd->hph_mode = mode_val;
 
-	return 0;
+	return 1;
 }
 
 static int slim_rx_mux_get(struct snd_kcontrol *kc,
-- 
2.21.0

