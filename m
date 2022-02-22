Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629F14BF787
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiBVMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBVMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD07156C67
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n29-20020a05600c3b9d00b00380e379bae2so211617wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4+KoWOLDfBWBNmg8ATzKj3dgQDIuJh9SiDFM0VqDsI=;
        b=BFcQ0xeGjkb5gAjr4AmA0Upb6D/t5gZ3sgiwyOwFnOPwn7x3emUhI03zW9x9tKD9gI
         XhZcTlsxhpPG756DZ4gni1co0nrdMBbo9jTz/H0WsiBSyskEsiKG8jWaROZiOaZ+UONI
         o1ywDWRZqTdZDrb8uuU3dFlLb0E9wTgK21wlnNyClrSvZgt2CpkgteBG1MhxcUavVKie
         yNTf+OT0eaJFVzXCUT5G+JstVJvzlk1f1r0S6zwH3n/vl0rfBQK9AZ5+9hd8329QWaMW
         BWyFMVbrEnnmYz8GL70pMisVsQpkqxveoYDWvgppJKDE+8dK4GIW3Kts4NPiAEwKzyof
         5TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4+KoWOLDfBWBNmg8ATzKj3dgQDIuJh9SiDFM0VqDsI=;
        b=4nwwKTAt4q6sv+k8RaRWtIUZ+c0chWxROqHHweKNEMl4iel1iQsjV/KIOcJuwjTAeZ
         mqByUF26BmYstoolHRhCgDi8kwEe71Xye7CGfaUq0uwduuQyXTDSUPOYING6zKQJywbT
         XVF6ozfq+x82BlkRmLyNhdS9hnzSBHFD9+jcE4ar814JyTFayFQ20fxOfNqAOPuJKA7y
         61Jr2qJTwmeGdPfTm4n30ZKctXI5O3zVypu3JQd40HzbTkUda6SZrMNTYM13hKRCRdi5
         6rXqBXkQOLD38qmarFCJ0v7rQb5J25ZKXn3bqaNVHo8QZ5PV597BoTa+jdji1ePwHUtG
         f8ZA==
X-Gm-Message-State: AOAM532MxPkLNl8q6HEK/30v3VR5H2PvjMOdkSjW/DBsSHbEZ6qrg1Gq
        A/24mZzJGm0LEwf7gkHYGbKTBw==
X-Google-Smtp-Source: ABdhPJxq6HIDurY9AQGuguDuGeBZZw3FpNl85sCDgC+WPGHKegdDi8iHlSvjQXET7sL/ND1r74vreg==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr3053532wmo.162.1645531192803;
        Tue, 22 Feb 2022 03:59:52 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/16] ASoC: codecs: wsa-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 11:59:22 +0000
Message-Id: <20220222115933.9114-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
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

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Also fix return value of put function, so that change notifications are
sent correctly.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 05bf18ae10e7..7de09c46264b 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1806,7 +1806,7 @@ static int wsa_macro_ear_spkr_pa_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wsa->ear_spkr_gain;
+	ucontrol->value.enumerated.item[0] = wsa->ear_spkr_gain;
 
 	return 0;
 }
@@ -1817,7 +1817,7 @@ static int wsa_macro_ear_spkr_pa_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	wsa->ear_spkr_gain =  ucontrol->value.integer.value[0];
+	wsa->ear_spkr_gain =  ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -1831,7 +1831,7 @@ static int wsa_macro_rx_mux_get(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			wsa->rx_port_value[widget->shift];
 	return 0;
 }
@@ -1845,7 +1845,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 bit_input;
 	u32 aif_rst;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
@@ -1888,7 +1888,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(widget->dapm, kcontrol,
 					rx_port_value, e, update);
-	return 0;
+	return 1;
 }
 
 static int wsa_macro_soft_clip_enable_get(struct snd_kcontrol *kcontrol,
-- 
2.21.0

