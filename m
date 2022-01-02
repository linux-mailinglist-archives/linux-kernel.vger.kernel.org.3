Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1773482B59
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiABNL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABNL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF0C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o3so6722950wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WRmSbNzgWOXiMDGVVnAVNx8XhmqTwc1mqlWVbXaNZE=;
        b=AgQQA3VOaFswdo+96dHSKeKXWqCzBv4sEGG0+XDZbLwpOw4kx+LGNU6mLXDP6GRK/Y
         sfp888SMqC5N1ZefU5f9vI4iMpwesGm5sXI2VLkfepSWtyyFamXZGSkCnboCdTCKuTch
         KZB6MEsGnsRlj2BwSnhWrPx4IEP2rrY41p7zjZL6Tw3rvPhWKpjIcyhFP16q9JRlLpRZ
         nFzYwi4ifM1yDVOuG6QrDGN7iC3X+aqoLUW8c2w1vEzbAq93D9SACXgI1aAN3RsrMtl5
         5JsFmv+CUbzn7HAbO73lrzUlU1zPE6DnR7c9q2JcPaBcfDnVkd+r3BGVmepGXUiCpWpN
         cYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WRmSbNzgWOXiMDGVVnAVNx8XhmqTwc1mqlWVbXaNZE=;
        b=OBP/7voEHJRhTT5N3klvCCZGlzixKqGfbJVGw1+0sMmKUlpwoOfQa4JuBn5fmqhnDf
         bg6/SisbNmq6LJpDdg/is0237f0ODQLOi8d+3xUJdloXUK92Q85G6xP7XrJa0/g0JLHm
         LZguNHfSEcV28zzVpL5EN6dEMug/MyNRo43iAcgzlbRClpk2neXAHIbQVWMqInhwBbZB
         F4tFg5HYOt5bbVzKeTh3JL0IykhYYaLVvnTPUHqNRZ7jvbAl2st2pGOvTTZcajhuJPxQ
         AQvSgnp74YGEWgpdIc09R5cYTpKN7bjpEkpsrqZNFFCMf/5BbT/Fx4MfMbBJ/YDAVzni
         dkjA==
X-Gm-Message-State: AOAM531dfkox2OYJy11zwc95uYex4AL8Sr259JJRQnJebAxUw/312Yeb
        eFMxSjOPkWHFJQe+Vh3YlQQ=
X-Google-Smtp-Source: ABdhPJw3AnXnf6Xk5SmwrhaOPtV5gLupolOxQpYoQrDoHW/RM9OvlMGNHzXzQ3OxSEET1drfrdTCpQ==
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr36312225wri.632.1641129115244;
        Sun, 02 Jan 2022 05:11:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:55 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/11] staging: r8188eu: remove struct rt_channel_plan_2g
Date:   Sun,  2 Jan 2022 14:11:32 +0100
Message-Id: <20220102131141.12310-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structures rt_channel_plan and rt_channel_plan_2g are identical.
Keep rt_channel_plan and remove rt_channel_plan_2g.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0aa958f20cd6..a9141ab1690e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -76,7 +76,7 @@ unsigned char	MCS_rate_1R[16] = {0xff, 0x00, 0x0, 0x0, 0x01, 0x0, 0x0, 0x0, 0x0,
 /********************************************************
 ChannelPlan definitions
 *********************************************************/
-static struct rt_channel_plan_2g RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
+static struct rt_channel_plan RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x00, RT_CHANNEL_DOMAIN_2G_WORLD , Passive scan CH 12, 13 */
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x01, RT_CHANNEL_DOMAIN_2G_ETSI1 */
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, 11},			/*  0x02, RT_CHANNEL_DOMAIN_2G_FCC1 */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index afdbc5e28fca..26f31f20e428 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -162,11 +162,6 @@ struct rt_channel_plan {
 	unsigned char	Len;
 };
 
-struct rt_channel_plan_2g {
-	unsigned char	Channel[MAX_CHANNEL_NUM];
-	unsigned char	Len;
-};
-
 struct rt_channel_plan_map {
 	unsigned char	Index2G;
 };
-- 
2.34.1

