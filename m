Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944634F6D81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiDFVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiDFVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:55:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57059F70
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:50:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m30so5182986wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctkfWR9bwdMoGeWels/5BpQ7XWMNAq7SYEfgxZw7Pak=;
        b=b8ok8D2tdxUGnElGaaf3DwjFFBoxpOffvCR+9ft/ESApaeDqixS8CjzHXxuNzc9Wn3
         rRWah9UTC/MsgWn79FDHbEREiMVaCUKUFj8LX0PKWslMVFn+tmalnDwnKxIJ6E0WXzdP
         qoCNLku+AEO4W7HiQ+LrKF6mHXKTfByXh9/2bhkklzydm+QHdegSLJOSh24ucH6dutoe
         oHngQjHGMuXgY3syTudv5tz9UxubPIVZpueQQjP+coU+Mk4D5MRbr0j8+0b9ea5OWrBR
         R0G7qNWtyrGQq29s3/rU2Y/bxcjQSG3SE55eivLvRNAhsgUqqvFvuQbpto//knv/DULx
         LFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctkfWR9bwdMoGeWels/5BpQ7XWMNAq7SYEfgxZw7Pak=;
        b=se/KrQd0emeAdu8cuKnHjM4cNOHyYvJ1niGTyIGxYhDqUNaGvagI6av7HtuTenGizE
         lroF6eZwZorlpjmrebMCnP6uxPw31Th1TkzBkh9hSMad0sRxeAxxvMn8gWBEpFmKb4jb
         WEHNH7A2AHYX1IYxgpGJC+tZJ93yoIjuKUZbfJ0uvtgeEpHEuwP6ua/H8I7uNcVbeF5s
         kDdzNSScjj1hvosNJk8Aa/eb3xUBejx4rgGfF1WngBpXgWnw3L7HlKLjykwR1Jss1gkF
         jBX49ITjWOUGTDL2fouv8mjt3HVEQfqkUeWQOhWsbySu6zmcXSCc1F7Auz9W3hWO4ZEF
         QSEw==
X-Gm-Message-State: AOAM531Sezm22efYr/vyZLRrqPNsz5vGRg2BMwbf28/bfbQWDoYJZ6ok
        b2AboIAHp74VBKGaUkFaETc=
X-Google-Smtp-Source: ABdhPJyRHsDWgldGsWPKliidhg48rYOQCvv/fpi0Ag45OOjfpgtLsKmrSWc9bf44Ad+Hg58lMWY8KQ==
X-Received: by 2002:a05:6000:2c7:b0:205:cb41:2a82 with SMTP id o7-20020a05600002c700b00205cb412a82mr7819657wry.395.1649281854803;
        Wed, 06 Apr 2022 14:50:54 -0700 (PDT)
Received: from alaa-emad ([197.57.159.73])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d5602000000b00206120e0b0fsm12555207wrv.18.2022.04.06.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:50:54 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH v2] staging: rtl8712: remove unnecessary parentheses
Date:   Wed,  6 Apr 2022 23:50:51 +0200
Message-Id: <20220406215051.20483-1-eng.alaamohamedsoliman.am@gmail.com>
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

CHECK: Unnecessary parentheses around param->u.crypt.key[16]: 85
CHECK: Unnecessary parentheses around param->u.crypt.key[24]: 87
CHECK: Unnecessary parentheses around padapter->mlmepriv: 603
CHECK: Unnecessary parentheses around wrqu->encoding: 1497
CHECK: Unnecessary parentheses around wrqu->encoding: 1592
CHECK: Unnecessary parentheses around padapter->mlmepriv: 1593
CHECK: Unnecessary parentheses around wrqu->param: 1673
CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1967
CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1977
CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1999

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
Changes in v2:
	- Edit commit subject
	- Edit commit message
	- Fix the same check in more lines
	- Remove space before '.skey' in
"memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 3b6926613257..e11332352285 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -81,10 +81,10 @@ static inline void handle_pairwise_key(struct sta_info *psta,
 	memcpy(psta->x_UncstKey.skey, param->u.crypt.key,
 	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
 	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-		memcpy(psta->tkiptxmickey. skey,
-		       &(param->u.crypt.key[16]), 8);
-		memcpy(psta->tkiprxmickey. skey,
-		       &(param->u.crypt.key[24]), 8);
+		memcpy(psta->tkiptxmickey.skey,
+		       &param->u.crypt.key[16], 8);
+		memcpy(psta->tkiprxmickey.skey,
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
 
@@ -1494,7 +1494,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 	u32 keyindex_provided;
 	struct NDIS_802_11_WEP	 wep;
 	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	struct _adapter *padapter = netdev_priv(dev);
 
 	key = erq->flags & IW_ENCODE_INDEX;
@@ -1589,8 +1589,8 @@ static int r8711_wx_get_enc(struct net_device *dev,
 {
 	uint key;
 	struct _adapter *padapter = netdev_priv(dev);
-	struct iw_point *erq = &(wrqu->encoding);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct iw_point *erq = &wrqu->encoding;
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	union Keytype *dk = padapter->securitypriv.DefKey;
 
 	if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -1670,7 +1670,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
 				union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
-	struct iw_param *param = (struct iw_param *)&(wrqu->param);
+	struct iw_param *param = (struct iw_param *)&wrqu->param;
 	int paramid;
 	int paramval;
 	int ret = 0;
@@ -1964,7 +1964,7 @@ static int r871x_get_ap_info(struct net_device *dev,
 		return -EINVAL;
 	data[32] = 0;
 
-	spin_lock_irqsave(&(pmlmepriv->scanned_queue.lock), irqL);
+	spin_lock_irqsave(&pmlmepriv->scanned_queue.lock, irqL);
 	phead = &queue->queue;
 	plist = phead->next;
 	while (1) {
@@ -1974,7 +1974,7 @@ static int r871x_get_ap_info(struct net_device *dev,
 		if (!mac_pton(data, bssid)) {
 			netdev_info(dev, "r8712u: Invalid BSSID '%s'.\n",
 				    (u8 *)data);
-			spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock),
+			spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock,
 					       irqL);
 			return -EINVAL;
 		}
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

