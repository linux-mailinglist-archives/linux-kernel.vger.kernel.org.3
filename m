Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAB4F672C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiDFR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiDFR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:28:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76394C65F2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:29:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h16so1744570wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OoZmBV6a3q7C/3gzu8v5F8pfjhaFDRNfwnDlF4guvE=;
        b=oi7mwnQZxklMgYGBbElVGCwjk52RB8MRTrGyWne253R+fc9EBZw3ESQplq60UDOXVx
         wml1DRrw5I37P3RNMaF8TNTGfg81mrCsjydn/389WFITuJEmvJNIyrchU/VJkrDEY2Ck
         ePAJ+3nlylSmAHK3NhsY6+x1mzp4gHiGF9VFhGZhWA4/4A0NcJZCVAi+IeakJMYCei5d
         kZbJuyQVu4PZDzUt1AA9/wJn6jOgd6heJUtDEWR1yDKA5dWWwjdLfZq0M7aJVKd7rA2l
         WM/ndh/hXo+I2LkUpBUW64wUURY66sdi6V84m3hIdCS+5azp2VKcWEoOcQix87MjPftb
         Au6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OoZmBV6a3q7C/3gzu8v5F8pfjhaFDRNfwnDlF4guvE=;
        b=DiYeEEZSwtHed1HKKEt2lkp/6OhfGV35rr6LUk3vLSmtsQbFTTtxH6YKE2nPKzI3tX
         mkEuuRW5fSh/HygukHymA96JM84hy8GN9lSHVGXoPkHqS3U4iBiBw12mfQ8gdawAiV90
         QNb3uDs5hBXjTRyoEiqCUYbnpVdWkA65253gMTxLH5RyrgKRYH2uw9eZbY5g2y6a0bHs
         uNfWr27xvKzDzh0Dj4HByZCeebIySc2J5VCbsKKZUAVcyuyBIgxofdE9TLEhCTuvRzyL
         mv3UIK79MjDkVF4FRSd809swcjo/jRkAlttCKosFDi9NJuV9iFrepE64ikrrIskY3t2z
         vhbw==
X-Gm-Message-State: AOAM532spfIHiyW6971M6XOzcbCIAlvGUndX5yYeLEtef3KscWlqVAdh
        LMLhSEBPlT2jtAr5X2JuLtk=
X-Google-Smtp-Source: ABdhPJxeE1BWWbybSlRUi9+rf49ljbgw6jcOREs0BLela241O37oI6RVcumQU6jROx5xhhq3eykqXw==
X-Received: by 2002:a7b:cc15:0:b0:381:3fb8:5f93 with SMTP id f21-20020a7bcc15000000b003813fb85f93mr7795229wmh.106.1649258942169;
        Wed, 06 Apr 2022 08:29:02 -0700 (PDT)
Received: from alaa-emad ([197.57.159.73])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm6465966wmq.24.2022.04.06.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:29:01 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: rtl8712: remove Unnecessary parentheses
Date:   Wed,  6 Apr 2022 17:28:58 +0200
Message-Id: <20220406152858.14076-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Reported by checkpatch:

CHECK: Unnecessary parentheses

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 3b6926613257..6c692ad7bde7 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -82,9 +82,9 @@ static inline void handle_pairwise_key(struct sta_info *psta,
 	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
 	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
 		memcpy(psta->tkiptxmickey. skey,
-		       &(param->u.crypt.key[16]), 8);
+		       &param->u.crypt.key[16], 8);
 		memcpy(psta->tkiprxmickey. skey,
-		       &(param->u.crypt.key[24]), 8);
+		       &param->u.crypt.key[24], 8);
 		padapter->securitypriv. busetkipkey = false;
 		mod_timer(&padapter->securitypriv.tkip_timer,
 			  jiffies + msecs_to_jiffies(50));
@@ -600,7 +600,7 @@ static int r8711_wx_get_name(struct net_device *dev,
 	u32 ht_ielen = 0;
 	char *p;
 	u8 ht_cap = false;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
 	u8 *prates;
 
@@ -1996,7 +1996,7 @@ static int r871x_get_ap_info(struct net_device *dev,
 		}
 		plist = plist->next;
 	}
-	spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock), irqL);
+	spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock, irqL);
 	if (pdata->length >= 34) {
 		if (copy_to_user((u8 __user *)pdata->pointer + 32,
 		    (u8 *)&pdata->flags, 1))
-- 
2.35.1

