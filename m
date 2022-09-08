Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3A5B1E18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiIHNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiIHNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D0013F0E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:09:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id go34so2893453ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bFqxdPA34fBehnbSp3k/mNFHYFTdf2a6bzWDE1HOQiA=;
        b=M1xjCXfWrc6HNSbMz1Z5Dc85Hyz/AoQ/ZM0MBsn2McqOk4hTpoojCBxbej/jRFyGbs
         I7LrhNJweCpICR3XrKWTp5mokrPwUXkPRGFVb1etwJdXR6rN9b59Q2cDWgKcq3zdL5qK
         ICnCpl52/pTXSbiTKHElBJkHT0Rm+o/YNEw2SA3VERlRuIlDc04o0XfkM3uk/oorm5ty
         grp0tJxSO74Mw/JP3LlBInn1ZMxP7z4O6lUTIx7QZUqN/Ik5ZFOgtxv+OcACpCpdIxGF
         T1rojMliAgdbwnNMVT6bCFiWPWzNt5LZNMwKX+UElBAI56rzoymJio2dbnetxW2hLPTR
         cz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bFqxdPA34fBehnbSp3k/mNFHYFTdf2a6bzWDE1HOQiA=;
        b=XT8RfPQJlvWo+6hT1Dra5VxaxoukiCGZYVjL/QjyufRq/gDTY7cYuHFZlHmtBdHqnG
         7f/Q69dewD3sMIdEGC0cxpo3HdjK3BC1/4llqFMqwhn+jVrwS9l7eP9CD6Onc1JbpA9a
         dPDB7Ceobt0Tq/oXIggwyXY3tsSC6BNPEdoBlRCqawyubEpINt0QilfokHjsfCnxNNAW
         vzICPcroj83gSPQjaUVJUsHS3wM5dOB8x5FDynICy/7wMrLtJqa+Ofj3Vc5FqgqAQ8Zc
         QeZ7ZrWVr7Q9IfJVlxsmfvtOHp7iWhh09V0o+5DSnYKS0S5e9WJPpIeUZnhXjsNthBHY
         OawA==
X-Gm-Message-State: ACgBeo3hs2PwUxy5YWyS1hUw3bp1aVfFse+7EPVMcw70ADDx9P8ENnJs
        /eWFWqqnp7agp9yXJbNPEa/VpiPWaQA=
X-Google-Smtp-Source: AA6agR7AggqzJ6OW4WbMptOsRrGp+z8wVvemfZdMVRW/PE7dazn1RxQF3O51GGQsuFflQgreDHcZ9A==
X-Received: by 2002:a17:907:2da6:b0:730:8b30:e517 with SMTP id gt38-20020a1709072da600b007308b30e517mr5985555ejc.291.1662642567943;
        Thu, 08 Sep 2022 06:09:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id cf6-20020a0564020b8600b0044edf0a2deasm4847978edb.69.2022.09.08.06.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:09:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: make two functions static
Date:   Thu,  8 Sep 2022 15:09:14 +0200
Message-Id: <20220908130915.8406-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908130915.8406-1-straube.linux@gmail.com>
References: <20220908130915.8406-1-straube.linux@gmail.com>
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

The functions UpdateBrateTbl() and UpdateBrateTblForSoftAP() are only
used in rtw_mlme_ext.c. Make them static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 40 +++++++++++++++++++
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 40 -------------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 -
 3 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ad8bfc29c4ce..03b1e6ab9053 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -932,6 +932,46 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	return _FAIL;
 }
 
+static void UpdateBrateTbl(u8 *mbrate)
+{
+	u8 i;
+	u8 rate;
+
+	/*  1M, 2M, 5.5M, 11M, 6M, 12M, 24M are mandatory. */
+	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
+		rate = mbrate[i] & 0x7f;
+		switch (rate) {
+		case IEEE80211_CCK_RATE_1MB:
+		case IEEE80211_CCK_RATE_2MB:
+		case IEEE80211_CCK_RATE_5MB:
+		case IEEE80211_CCK_RATE_11MB:
+		case IEEE80211_OFDM_RATE_6MB:
+		case IEEE80211_OFDM_RATE_12MB:
+		case IEEE80211_OFDM_RATE_24MB:
+			mbrate[i] |= IEEE80211_BASIC_RATE_MASK;
+			break;
+		}
+	}
+}
+
+static void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
+{
+	u8 i;
+	u8 rate;
+
+	for (i = 0; i < bssratelen; i++) {
+		rate = bssrateset[i] & 0x7f;
+		switch (rate) {
+		case IEEE80211_CCK_RATE_1MB:
+		case IEEE80211_CCK_RATE_2MB:
+		case IEEE80211_CCK_RATE_5MB:
+		case IEEE80211_CCK_RATE_11MB:
+			bssrateset[i] |= IEEE80211_BASIC_RATE_MASK;
+			break;
+		}
+	}
+}
+
 unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	u16 capab_info;
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 065ab274b0b4..e50631848cab 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -222,46 +222,6 @@ void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *bssrat
 	memcpy(pbssrate, supportedrates, *bssrate_len);
 }
 
-void UpdateBrateTbl(u8 *mbrate)
-{
-	u8	i;
-	u8	rate;
-
-	/*  1M, 2M, 5.5M, 11M, 6M, 12M, 24M are mandatory. */
-	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		rate = mbrate[i] & 0x7f;
-		switch (rate) {
-		case IEEE80211_CCK_RATE_1MB:
-		case IEEE80211_CCK_RATE_2MB:
-		case IEEE80211_CCK_RATE_5MB:
-		case IEEE80211_CCK_RATE_11MB:
-		case IEEE80211_OFDM_RATE_6MB:
-		case IEEE80211_OFDM_RATE_12MB:
-		case IEEE80211_OFDM_RATE_24MB:
-			mbrate[i] |= IEEE80211_BASIC_RATE_MASK;
-			break;
-		}
-	}
-}
-
-void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen)
-{
-	u8	i;
-	u8	rate;
-
-	for (i = 0; i < bssratelen; i++) {
-		rate = bssrateset[i] & 0x7f;
-		switch (rate) {
-		case IEEE80211_CCK_RATE_1MB:
-		case IEEE80211_CCK_RATE_2MB:
-		case IEEE80211_CCK_RATE_5MB:
-		case IEEE80211_CCK_RATE_11MB:
-			bssrateset[i] |= IEEE80211_BASIC_RATE_MASK;
-			break;
-		}
-	}
-}
-
 void Save_DM_Func_Flag(struct adapter *padapter)
 {
 	struct hal_data_8188e *haldata = &padapter->haldata;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index e70640f1e41d..b322d0848db9 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -393,8 +393,6 @@ extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 unsigned char networktype_to_raid(unsigned char network_type);
 u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int len);
 void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *len);
-void UpdateBrateTbl(u8 *mBratesOS);
-void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen);
 
 void Save_DM_Func_Flag(struct adapter *padapter);
 void Restore_DM_Func_Flag(struct adapter *padapter);
-- 
2.37.2

