Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED5482B58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiABNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiABNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA572C061784
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so64990606wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FcuxhwxA5QMteVz+dapvBt2ioof0RJo+WgQY+1qaFU=;
        b=ClqFVtQ27afGBtsd9P8NRcZtFgbUn0GbZhBhHzTVxdstKryiIvu3h2esV/ovl5qULA
         7Gz1maecuVRHyUhJboHzKsnVL/Oso0g7mmMrUtg8MOQtvMBr81KvlkUb5OFiWche0l3X
         UQ1wdu9SwUDCWBekC6lQJTN2LvKWyGSjZEdbjVq59WQqpYD0WE8qZ2Gmzf01HQzyo+LR
         Jh6jytQBi6wpPm/pawhblDgkXsxj3EpB8734WfGe7RmybNi+FVxAbD/n9FDsZKZrSLUL
         vJYGKVP6YmodCqpnYzTdj5DTXLOj+nM9ORJVSMhwEQ33xETx/hBf37GXGA8TVgR8sE7K
         c5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FcuxhwxA5QMteVz+dapvBt2ioof0RJo+WgQY+1qaFU=;
        b=KjQuDXO2E6GgONaGaytQwAfvTkriD0dZjPmmSVQSCjhqKi/SEdm6bGdQaF3Yb+7uqK
         0EdYnGeek8RgBERbo3nCg4JQCHkupFTWw64bwE0HO06KoFoO4Tx0HBnvY/17awwno3jp
         Y7mq/BM0NJ1GDpVfUdkqwBj35CcCKo3Jq4+cNtJ8qkAZUVGjQXGEXyIDx1qbmuB7KPEN
         BDxDE19j1b2wRvw2JTDJT9PHYr+QZLLpcD2qx3nNiRZCtPRW57JDPoqnTFx0PtZXDHM7
         9xeThH2PURcizEuGbIqRje6jgO/6Jmpb6OB4fW/BMiiZPHVt0WCeWLi5TFwx3f57Ybu1
         vRYg==
X-Gm-Message-State: AOAM533EWGTPaPThasqxSsqBL+eRwT/6suINR7c9k6xncseyMPaPmCFo
        Q/QOZgd9LzWiZyNpNBoaUN0=
X-Google-Smtp-Source: ABdhPJxoRV57zkp1eGgtUzwoslhlQLTzAUyiQDEENopv32U4gWm2YKTKIN7n7XO3nKn8rNbUbG9a9w==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr36540919wrg.118.1641129114538;
        Sun, 02 Jan 2022 05:11:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:54 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/11] staging: r8188eu: remove MAX_CHANNEL_NUM_2G
Date:   Sun,  2 Jan 2022 14:11:31 +0100
Message-Id: <20220102131141.12310-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants MAX_CHANNEL_NUM_2G and MAX_CHANNEL_NUM have the same
value. Remove MAX_CHANNEL_NUM_2G and fix the place where it is used.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/r8188eu/include/rtw_rf.h       | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 5b307ad3afa5..afdbc5e28fca 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -163,7 +163,7 @@ struct rt_channel_plan {
 };
 
 struct rt_channel_plan_2g {
-	unsigned char	Channel[MAX_CHANNEL_NUM_2G];
+	unsigned char	Channel[MAX_CHANNEL_NUM];
 	unsigned char	Len;
 };
 
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index d0a408b903dc..2308a00b5dec 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -19,11 +19,6 @@
 #define RTL8711_RF_MAX_SENS		6
 #define RTL8711_RF_DEF_SENS		4
 
-/*  We now define the following channels as the max channels in each
- * channel plan. */
-/*  2G, total 14 chnls */
-/*  {1,2,3,4,5,6,7,8,9,10,11,12,13,14} */
-#define	MAX_CHANNEL_NUM_2G		14
 #define	MAX_CHANNEL_NUM			14	/* 2.4 GHz only */
 
 #define NUM_REGULATORYS	1
-- 
2.34.1

