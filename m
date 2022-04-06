Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC94F6DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiDFWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiDFWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:43:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1802F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:41:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m30so5320751wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PdPV1uVTDYxkLHZpucjakBPCEtyMndpTWZ3KCVf2kQ=;
        b=K/tka2qPIv59qfxLtVw85vpJCBHTa4X/TfcLU8fXpOOmkj9qIIPBbk9vwtIYubM4N8
         /CHCJA9Nuw17U/Rg0CNWZZnowuyaDnel/AKEQf9olZ//Wy82de74xU0rXwOLY070m/g1
         5NECkgaXaHNJD2iO7jz0iVAl7NvFlVQwOYWLsPZ0OevLwJn9xB5RqZBQ4qClieiBWQge
         A3er0Ic9++9HJc+jvruVD1RJQVugkLn/wjdFpAiEQh3FhHbplDzPT6ZaJWXjfs0qxd47
         kRX8Gwfi9lk6r1ZPvB33yBvRw5MX0qnumpDo4nxhQnPCUidW55hA1fP6yCvIcgrT9Mmv
         JqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PdPV1uVTDYxkLHZpucjakBPCEtyMndpTWZ3KCVf2kQ=;
        b=5gCC0Sc4g5xdVlBPdJTIieGbPdUoI6VEgpUwQeaLQz+FVPGAku3oymes5Pc8BxKGAR
         uadm9/dvIwV1u7J3MB2X0Zu5TF/rFqlFQA38tg0pUDSPoH15G62a7Zl3Tr0pmrpDmkhA
         pCCyBMT6Ze2V8wrEdSr4BRiT95Qt7veYtT2j/eY1pZlPbuqNIQDmdI3XBMWl4OZZe09+
         DIRnZiFXYUAWGehHqjTOhCmU0xcxYRFSOyMoS5dpr7fG6TvV8enbvZRYADU5hcnP5Xft
         PzGEOhkL1lypn4c+j6LQwJMlcilO+B8oqY6xPO/FZrInVUQa1TuQrk96LUVQdb/436nq
         ZHqg==
X-Gm-Message-State: AOAM530NlqtdTxpVqQnwNQFsymkkViSzuQNC6U1NER/tsdIIsLRUNIn6
        v4hhBjfejaj9Dsf991ntmec=
X-Google-Smtp-Source: ABdhPJxwsnlYTRbN7V6B6qVajUOiZuW5HksGNi+sv85WHI0qJWadDMtKjxlO5PV/pjuM+1Zs6sA0+w==
X-Received: by 2002:a05:6000:168e:b0:204:f92:53e9 with SMTP id y14-20020a056000168e00b002040f9253e9mr8589680wrd.349.1649284863065;
        Wed, 06 Apr 2022 15:41:03 -0700 (PDT)
Received: from alaa-emad ([197.57.231.245])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm10218518wrn.114.2022.04.06.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 15:41:02 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH v3] staging: rtl8712: remove unnecessary parentheses
Date:   Thu,  7 Apr 2022 00:40:57 +0200
Message-Id: <20220406224057.5260-1-eng.alaamohamedsoliman.am@gmail.com>
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
Changes in v3:
	return the space before '.skey' in
"memcpy(psta->tkiptxmickey.skey," in lines 84 and 86
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 3b6926613257..f1e352b7f83e 100644
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

