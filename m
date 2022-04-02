Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2104EFFC8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353978AbiDBIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353946AbiDBIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:53:12 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E41544BC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i7so5060806oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsvg2OPb+FuOq6QpPd6PmHwu11pbVJX0wlikRs5/Wus=;
        b=RGOfLxghPwV+kPX7AQTR+zDf/CJEWHKRESbsvHUIpiBM6PEga0LCzHFs66cHxpzgKm
         jsvZLVPrNUTRm9n52Qz8RmGluY2lEVgCxoko5jofqv3ei1S9+m9iOOmQuxP8GBZPaxQX
         YCOLiVl9utI4JNC9PuBKgqa6Ynmy5nwIlJloCA+DwI4Pf8n1oWzWz+u0aMfOpLIuRGje
         POK1WBHC+bKlEVFdyqS7U7YsAWSKOnNtTecYR830P3bwcWQCGH8NmZ29MoHBMtTDn/mx
         OORf/gDhMe1uKP0C96pbWUUWdE8WP3ak5JdiTaS5luhJIje71/O4hXJFXhKbm7tUMiMH
         UCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsvg2OPb+FuOq6QpPd6PmHwu11pbVJX0wlikRs5/Wus=;
        b=YErGdGVW0tg1VUWNK3jD9/rMXP0LMGCKKRcUCFgmm1SpHmz29UDkDTHksfDQEovMWy
         cDqaQ2CVZV19/dKRKmsCyUg8EUtvVgSJpAtQPg7KfHWeEFSbsNvq6V3Itu39WaQyDkgl
         gCAJy9+ZdQys3C8h9hLOEiq2w8LODF6H30kv0vqUgruuX3lGNd6ocPU+ZrLP03IjonXk
         doNLZUEjG/U3YvWdDBKXCDW645uFD0WpruyGIJBrH5vztzxJ2Az2HlMmkTghP76tKOGq
         9IkhuvWYKUlXMW8mMKRZR3OPaBalKtlTV11YtIEjdbyL2kOtkH3Ly9BiWTH/WYyNSuP2
         //FA==
X-Gm-Message-State: AOAM532LR/XIVQyA+N/Oa6Lvomp7sXvPR+XEqY09K/LVnS7HtotE2myg
        khVOedt+JnpgiY7Fbc14sb8=
X-Google-Smtp-Source: ABdhPJwoPr/yNxlNco+MBnjGbe6z2GYhCoF34vsMysOvLuORVPIv7QjCe6vQqUcHd8o8Nyro437AZw==
X-Received: by 2002:a05:6808:1883:b0:2da:3ed2:68cf with SMTP id bi3-20020a056808188300b002da3ed268cfmr6561466oib.204.1648889480241;
        Sat, 02 Apr 2022 01:51:20 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q11-20020a4a330b000000b003289cbe97c6sm2057675ooq.13.2022.04.02.01.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:19 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: format block comments
Date:   Sat,  2 Apr 2022 03:50:46 -0500
Message-Id: <0387f3df49d89c17acf96cf072e70c98e81e58f7.1648888462.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1648888461.git.remckee0@gmail.com>
References: <cover.1648888461.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ' * ' or ' ' to beginning of block comment lines
to conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: Block comments use * on subsequent lines

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 29 +++++++++++++-------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 2e135bbd836a..0c659b40aa1c 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -12,9 +12,9 @@
 #include "../include/rtl8188e_dm.h"
 
 /*
-Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
-No irqsave is necessary.
-*/
+ * Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
+ * No irqsave is necessary.
+ */
 
 static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
@@ -97,14 +97,13 @@ static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 }
 
 /*
-Calling Context:
-
-rtw_enqueue_cmd can only be called between kernel thread,
-since only spin_lock is used.
-
-ISR/Call-Back functions can't call this sub-function.
-
-*/
+ * Calling Context:
+ *
+ * rtw_enqueue_cmd can only be called between kernel thread,
+ * since only spin_lock is used.
+ *
+ * ISR/Call-Back functions can't call this sub-function.
+ */
 
 static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
@@ -319,10 +318,10 @@ int rtw_cmd_thread(void *context)
 }
 
 /*
-rtw_sitesurvey_cmd(~)
-	### NOTE:#### (!!!!)
-	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
-*/
+ * rtw_sitesurvey_cmd(~)
+ *	### NOTE:#### (!!!!)
+ *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
+ */
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
 	struct rtw_ieee80211_channel *ch, int ch_num)
 {
-- 
2.32.0

