Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC44C5C70
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiB0Ov2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiB0OvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:51:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7825D5F8;
        Sun, 27 Feb 2022 06:50:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so20054639ejc.7;
        Sun, 27 Feb 2022 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se5fdTdf84xDWqTWcks3tih8Dd3br+tSQjNncikkPL8=;
        b=WsxMOlMSwbUo4F4tfM2v66cny1ddxMCxjW/WYiH2LPsXUP0Dgw0BB4U5alKPAeg5G+
         E0/6lKV+dL/upl6B084xKPuUNJ5OKq2P50p0DTossOk75HFDqMr8p69TYGbva8QvM3tI
         /ELppltgd1GoRKhJfYnK5didNSdoRgcEJ++Y+wZ62VL0lxEqfWdRoioXUfoCZ3NHhD4G
         Fg3U9k/MUustCZxsQDuEHO2KiD9gKEQdEfL95eW6XonSLkgDMl45BZCN2IoID6Yyd9Pz
         XS4DhLDsiolky6cyni5hk1amiOStXP0EEDh5AKOkTs8V3iQpU4ZAEO/i1kPX33L7hqBh
         p8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se5fdTdf84xDWqTWcks3tih8Dd3br+tSQjNncikkPL8=;
        b=hMiP3j4Q6BiP6cTVaDyfk60Q8q8e8x5Ex4gXudIocxemQw32OizrwNGrA+zLHIobZS
         +yFOhkgG776SupiMj+eGOXV/oEN/daR1NfCKBZmIuinOKeOXt9D212p1pHm1Y58pPMwK
         BHS38QCI7Y3BayrrKCn+oZ1IMcwp2GqgWj1I81SYWgEb6O0wfUNbUeJMeBO6PJ1Jm9ua
         zQPwkwbs+PlR30r73gqnNE45UtMdANEftPDmlA7AU16KNsJKdKhCeHT0y3wOAkDbw6ac
         L7u/S7Depdbh3WqncPrUvrmexApC00t2JV0hWjtlJuhmu60NjB+Dc893ebvmdW5G0V7g
         Yv/Q==
X-Gm-Message-State: AOAM533CqvUfNH6OmRMeo8/zjx32xuFpe6S7+e6OYDsnRf3s17BQGD0S
        YqvKQk0nJ21EyMDlkkzqhVo=
X-Google-Smtp-Source: ABdhPJz2uGFr5qrfNl7dYD/dRIIHoDCaicFBQ09kr3aVt9005jUPJ6GCnQpGx27zrb9Kmn6OzpytMA==
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id x17-20020a170906299100b006cf6b24e92fmr12153116eje.748.1645973437696;
        Sun, 27 Feb 2022 06:50:37 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm3501887ejj.142.2022.02.27.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 06:50:37 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [RFC PATCH 7/8] media: hantro: sunxi: Enable 10-bit decoding
Date:   Sun, 27 Feb 2022 15:49:25 +0100
Message-Id: <20220227144926.3006585-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that infrastructure for 10-bit decoding exists, enable it for
Allwinner H6.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/sunxi_vpu_hw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
index c0edd5856a0c..8d8a8937d6aa 100644
--- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -15,12 +15,23 @@ static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
 	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010,
+		.codec_mode = HANTRO_MODE_NONE,
+		.postprocessed = true,
+	},
 };
 
 static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12_4L4,
 		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
-- 
2.35.1

