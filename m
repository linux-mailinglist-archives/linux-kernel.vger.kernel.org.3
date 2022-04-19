Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF83506CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352366AbiDSMrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbiDSMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:46:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E3369FD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:44:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso1710312pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kTjxTQXy94UFrgYUrNam3OH7v2BLwex8CnUUFkNtqs=;
        b=eYnRCYmUHPBbB0hgpTbjVrJsD+KIZP78jYJLsHX/tMicCUjBq17DTwWjdKyYNZjare
         Sxi1RWs/UeGRzTQ85ET1OQdF0NLWQzPNVm3eup+yd/uPtP5Krc7jiiUKMKZdfLt6pncV
         SYjCU9bJX+aZtNx08sik0tKY1V4+u7yx4XSUSsfob8DHrdm2gWY9ot1q6GgiFDxintK8
         0y7TOwiIhRx6SXH38WgeD+7Rb0jWd1U4oQ75naQC7iydX75AC1p/634XjLeK62Zo03xy
         YKKrFbNSl1avFK4qxee8CF+jNCTftOrkUfBuMBzcPRwMEdb+imL4/vZj+KjbFKnsK1vv
         x2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kTjxTQXy94UFrgYUrNam3OH7v2BLwex8CnUUFkNtqs=;
        b=pNuwC2lwHw7gHKDaGoaPL6NOGk9/Z9Mbrl/FaqgOx2PdmB12bAf/GSevYxgp0sOAwz
         JgudkNMjqvlwcg+PWlOalwkGZ6TZ+e0FlPHRkPAXV1thTHKsJdOxqddKkOSvv12zNWpF
         d+4kSMonJlW0YdyvILKZUM8lOJRt80s15UPd5NgoOueokG/bRsO1QPXGPZ7XCnEHad+P
         karj6KhST6nK1SMkDX7Q0JHo9qcsApv5k48v7vvTjidqpAx3NpfhLeV5yZlqokIqQ0DR
         l1j/CIXTbfcfTSFOuzDzcvIHho0sw5rFGwVgGWj/pv7KT/PXve1rSYx3DRdnk2seQ6BO
         tPaw==
X-Gm-Message-State: AOAM532dKEtCTER4PqjMTCCGmeXAmez8AJv5HCLvkDqRq5JFQhACOUEH
        +8jZb1OAlGx846VG+ZQG8tMn8pG2rm428w==
X-Google-Smtp-Source: ABdhPJyagyli18Wee6thUjpXalPWMEt3uVfThMmAK1kXOzvkCejHjbLwTxjBq2/8WUTmYONrFX3Dug==
X-Received: by 2002:a17:90a:1a0b:b0:1d2:a1e6:230 with SMTP id 11-20020a17090a1a0b00b001d2a1e60230mr10081951pjk.179.1650372250672;
        Tue, 19 Apr 2022 05:44:10 -0700 (PDT)
Received: from localhost.localdomain ([14.100.48.186])
        by smtp.gmail.com with ESMTPSA id v5-20020a655685000000b0039d519701a9sm15981240pgs.27.2022.04.19.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:44:10 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Remove space after cast
Date:   Tue, 19 Apr 2022 20:43:19 +0800
Message-Id: <20220419124318.8028-1-wjsota@gmail.com>
X-Mailer: git-send-email 2.35.3
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

This patch addresses the checkpatch.pl flag that there should not be a
space after a cast.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  | 10 ++---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  | 38 +++++++++----------
 drivers/staging/rtl8192e/rtllib_rx.c          | 20 +++++-----
 drivers/staging/rtl8192e/rtllib_softmac.c     | 34 ++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
 drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
 9 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 7f9dee42a04d..a45ee95a8e6b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -221,7 +221,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			 &priv->rtllib->current_network.qos_data.parameters;
 		u8 pAcParam = *val;
 		u32 eACI = pAcParam;
-		union aci_aifsn *pAciAifsn = (union aci_aifsn *) &
+		union aci_aifsn *pAciAifsn = (union aci_aifsn *)&
 					      (qos_parameters->aifs[0]);
 		u8 acm = pAciAifsn->f.acm;
 		u8 AcmCtrl = rtl92e_readb(dev, AcmHwCtrl);
@@ -811,7 +811,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	rtl92e_config_mac(dev);
 
-	if (priv->card_8192_version > (u8) VERSION_8190_BD) {
+	if (priv->card_8192_version > (u8)VERSION_8190_BD) {
 		rtl92e_get_tx_power(dev);
 		rtl92e_set_tx_power(dev, priv->chan);
 	}
@@ -1613,9 +1613,9 @@ static void _rtl92e_query_rxphystatus(
 				total_rssi += RSSI;
 
 			if (bpacket_match_bssid) {
-				pstats->RxMIMOSignalStrength[i] = (u8) RSSI;
+				pstats->RxMIMOSignalStrength[i] = (u8)RSSI;
 				precord_stats->RxMIMOSignalStrength[i] =
-								(u8) RSSI;
+								(u8)RSSI;
 			}
 		}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 756d8db51937..aa942d915992 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -844,7 +844,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
 		for (i = 0; i < CCK_Table_length; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
-				priv->CCK_index = (u8) i;
+				priv->CCK_index = (u8)i;
 				RT_TRACE(COMP_POWER_TRACKING,
 					 "Initial reg0x%x = 0x%x, CCK_index = 0x%x\n",
 					 rCCK0_TxFilter1, TempCCk,
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 97afea4c3511..4616ea8266b3 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -238,7 +238,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 			     skb->data, skb->len);
 #endif
 
-	req = (struct rtllib_hdr_3addr *) skb->data;
+	req = (struct rtllib_hdr_3addr *)skb->data;
 	tag = (u8 *)req;
 	dst = (u8 *)(&req->addr2[0]);
 	tag += sizeof(struct rtllib_hdr_3addr);
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index ed968c01c7ff..a8d22da8bc9a 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -103,7 +103,7 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
 	if (a4_included)
 		aad_len += 6;
 	if (qc_included) {
-		pos = (u8 *) &hdr->addr4;
+		pos = (u8 *)&hdr->addr4;
 		if (a4_included)
 			pos += 6;
 		qc = *pos & 0x0f;
@@ -130,13 +130,13 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
 	 * A4 (if present)
 	 * QC (if present)
 	 */
-	pos = (u8 *) hdr;
+	pos = (u8 *)hdr;
 	aad[0] = pos[0] & 0x8f;
 	aad[1] = pos[1] & 0xc7;
 	memcpy(&aad[2], &hdr->addr1, ETH_ALEN);
 	memcpy(&aad[8], &hdr->addr2, ETH_ALEN);
 	memcpy(&aad[14], &hdr->addr3, ETH_ALEN);
-	pos = (u8 *) &hdr->seq_ctl;
+	pos = (u8 *)&hdr->seq_ctl;
 	aad[20] = pos[0] & 0x0f;
 	aad[21] = 0; /* all bits masked */
 	memset(aad + 22, 0, 8);
@@ -186,7 +186,7 @@ static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	*pos++ = key->tx_pn[1];
 	*pos++ = key->tx_pn[0];
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	if (!tcb_desc->bHwSec) {
 		struct aead_request *req;
 		struct scatterlist sg[2];
@@ -235,7 +235,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	pos = skb->data + hdr_len;
 	keyidx = pos[3];
 	if (!(keyidx & (1 << 5))) {
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 4a760ecbc31e..a305b79c53e7 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -136,7 +136,7 @@ static inline u16 Hi16(u32 val)
 
 static inline u16 Mk16(u8 hi, u8 lo)
 {
-	return lo | (((u16) hi) << 8);
+	return lo | (((u16)hi) << 8);
 }
 
 
@@ -220,7 +220,7 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 	/* Make temporary area overlap WEP seed so that the final copy can be
 	 * avoided on little endian hosts.
 	 */
-	u16 *PPK = (u16 *) &WEPSeed[4];
+	u16 *PPK = (u16 *)&WEPSeed[4];
 
 	/* Step 1 - make copy of TTAK and bring in TSC */
 	PPK[0] = TTAK[0];
@@ -231,15 +231,15 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 	PPK[5] = TTAK[4] + IV16;
 
 	/* Step 2 - 96-bit bijective mixing using S-box */
-	PPK[0] += _S_(PPK[5] ^ Mk16_le((u16 *) &TK[0]));
-	PPK[1] += _S_(PPK[0] ^ Mk16_le((u16 *) &TK[2]));
-	PPK[2] += _S_(PPK[1] ^ Mk16_le((u16 *) &TK[4]));
-	PPK[3] += _S_(PPK[2] ^ Mk16_le((u16 *) &TK[6]));
-	PPK[4] += _S_(PPK[3] ^ Mk16_le((u16 *) &TK[8]));
-	PPK[5] += _S_(PPK[4] ^ Mk16_le((u16 *) &TK[10]));
-
-	PPK[0] += RotR1(PPK[5] ^ Mk16_le((u16 *) &TK[12]));
-	PPK[1] += RotR1(PPK[0] ^ Mk16_le((u16 *) &TK[14]));
+	PPK[0] += _S_(PPK[5] ^ Mk16_le((u16 *)&TK[0]));
+	PPK[1] += _S_(PPK[0] ^ Mk16_le((u16 *)&TK[2]));
+	PPK[2] += _S_(PPK[1] ^ Mk16_le((u16 *)&TK[4]));
+	PPK[3] += _S_(PPK[2] ^ Mk16_le((u16 *)&TK[6]));
+	PPK[4] += _S_(PPK[3] ^ Mk16_le((u16 *)&TK[8]));
+	PPK[5] += _S_(PPK[4] ^ Mk16_le((u16 *)&TK[10]));
+
+	PPK[0] += RotR1(PPK[5] ^ Mk16_le((u16 *)&TK[12]));
+	PPK[1] += RotR1(PPK[0] ^ Mk16_le((u16 *)&TK[14]));
 	PPK[2] += RotR1(PPK[1]);
 	PPK[3] += RotR1(PPK[2]);
 	PPK[4] += RotR1(PPK[3]);
@@ -251,7 +251,7 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 	WEPSeed[0] = Hi8(IV16);
 	WEPSeed[1] = (Hi8(IV16) | 0x20) & 0x7F;
 	WEPSeed[2] = Lo8(IV16);
-	WEPSeed[3] = Lo8((PPK[5] ^ Mk16_le((u16 *) &TK[0])) >> 1);
+	WEPSeed[3] = Lo8((PPK[5] ^ Mk16_le((u16 *)&TK[0])) >> 1);
 
 #ifdef __BIG_ENDIAN
 	{
@@ -280,7 +280,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	    skb->len < hdr_len)
 		return -1;
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 
 	if (!tcb_desc->bHwSec) {
 		if (!tkey->tx_phase1_done) {
@@ -357,7 +357,7 @@ static int rtllib_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	if (skb->len < hdr_len + 8 + 4)
 		return -1;
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	pos = skb->data + hdr_len;
 	keyidx = pos[3];
 	if (!(keyidx & (1 << 5))) {
@@ -485,7 +485,7 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 *hdr)
 {
 	struct rtllib_hdr_4addr *hdr11;
 
-	hdr11 = (struct rtllib_hdr_4addr *) skb->data;
+	hdr11 = (struct rtllib_hdr_4addr *)skb->data;
 	switch (le16_to_cpu(hdr11->frame_ctl) &
 		(RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS)) {
 	case RTLLIB_FCTL_TODS:
@@ -518,7 +518,7 @@ static int rtllib_michael_mic_add(struct sk_buff *skb, int hdr_len, void *priv)
 	u8 *pos;
 	struct rtllib_hdr_4addr *hdr;
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 
 	if (skb_tailroom(skb) < 8 || skb->len < hdr_len) {
 		netdev_dbg(skb->dev,
@@ -558,7 +558,7 @@ static void rtllib_michael_mic_failure(struct net_device *dev,
 	ether_addr_copy(ev.src_addr.sa_data, hdr->addr2);
 	memset(&wrqu, 0, sizeof(wrqu));
 	wrqu.data.length = sizeof(ev);
-	wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *) &ev);
+	wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *)&ev);
 }
 
 static int rtllib_michael_mic_verify(struct sk_buff *skb, int keyidx,
@@ -568,7 +568,7 @@ static int rtllib_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	u8 mic[8];
 	struct rtllib_hdr_4addr *hdr;
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 
 	if (!tkey->key_set)
 		return -1;
@@ -584,7 +584,7 @@ static int rtllib_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
 		struct rtllib_hdr_4addr *hdr;
 
-		hdr = (struct rtllib_hdr_4addr *) skb->data;
+		hdr = (struct rtllib_hdr_4addr *)skb->data;
 		netdev_dbg(skb->dev,
 			   "Michael MIC verification failed for MSDU from %pM keyidx=%d\n",
 			   hdr->addr2, keyidx);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index eb904b42f9c6..08aceb42abe4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -250,7 +250,7 @@ static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
 	if (skb->len < 24)
 		return 0;
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	fc = le16_to_cpu(hdr->frame_ctl);
 
 	/* check that the frame is unicast frame to us */
@@ -299,7 +299,7 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 			tcb_desc->bHwSec = 0;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
 
 	atomic_inc(&crypt->refcnt);
@@ -339,7 +339,7 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 			tcb_desc->bHwSec = 0;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
 
 	atomic_inc(&crypt->refcnt);
@@ -936,7 +936,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	} else {
 		struct rx_ts_record *pRxTS = NULL;
 
-		if (GetTs(ieee, (struct ts_common_info **) &pRxTS, hdr->addr2,
+		if (GetTs(ieee, (struct ts_common_info **)&pRxTS, hdr->addr2,
 			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
 			if ((fc & (1<<11)) && (frag == pRxTS->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num))
@@ -1100,7 +1100,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	if ((frag != 0 || (fc & RTLLIB_FCTL_MOREFRAGS))) {
 		int flen;
 		struct sk_buff *frag_skb = rtllib_frag_cache_get(ieee, hdr);
@@ -1152,7 +1152,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		 * delivered, so remove skb from fragment cache
 		 */
 		skb = frag_skb;
-		hdr = (struct rtllib_hdr_4addr *) skb->data;
+		hdr = (struct rtllib_hdr_4addr *)skb->data;
 		rtllib_frag_cache_invalidate(ieee, hdr);
 	}
 
@@ -1165,7 +1165,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep) {
 		if (/*ieee->ieee802_1x &&*/
 		    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
@@ -1397,13 +1397,13 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		goto rx_exit;
 
 	/* Get TS for Rx Reorder  */
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)
 		&& (!bToOtherSTA)) {
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee, (struct ts_common_info **) &pTS, hdr->addr2, TID,
+		GetTs(ieee, (struct ts_common_info **)&pTS, hdr->addr2, TID,
 		      RX_DIR, true);
 		if (TID != 0 && TID != 3)
 			ieee->bis_any_nonbepkts = true;
@@ -2053,7 +2053,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			}
 
 			network->ssid_len = min(info_element->len,
-						(u8) IW_ESSID_MAX_SIZE);
+						(u8)IW_ESSID_MAX_SIZE);
 			memcpy(network->ssid, info_element->data,
 			       network->ssid_len);
 			if (network->ssid_len < IW_ESSID_MAX_SIZE)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4b6c2295a3cf..2ba75db0f055 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -202,7 +202,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	unsigned long flags;
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtllib_hdr_3addr  *header =
-		(struct rtllib_hdr_3addr  *) skb->data;
+		(struct rtllib_hdr_3addr  *)skb->data;
 
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
@@ -279,7 +279,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 {
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtllib_hdr_3addr  *header =
-		(struct rtllib_hdr_3addr  *) skb->data;
+		(struct rtllib_hdr_3addr  *)skb->data;
 	u16 fc, type, stype;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
@@ -856,9 +856,9 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
 	if (ieee->pHTInfo->bCurrentHTSupport) {
-		tmp_ht_cap_buf = (u8 *) &(ieee->pHTInfo->SelfHTCap);
+		tmp_ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
 		tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-		tmp_ht_info_buf = (u8 *) &(ieee->pHTInfo->SelfHTInfo);
+		tmp_ht_info_buf = (u8 *)&(ieee->pHTInfo->SelfHTInfo);
 		tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
 		HTConstructCapabilityElement(ieee, tmp_ht_cap_buf,
 					     &tmp_ht_cap_len, encrypt, false);
@@ -912,7 +912,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
 
-	tag = (u8 *) beacon_buf->info_element[0].data;
+	tag = (u8 *)beacon_buf->info_element[0].data;
 
 	memcpy(tag, ssid, ssid_len);
 
@@ -1303,7 +1303,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			0x00};
 		struct octet_string osCcxRmCap;
 
-		osCcxRmCap.Octet = (u8 *) CcxRmCapBuf;
+		osCcxRmCap.Octet = (u8 *)CcxRmCapBuf;
 		osCcxRmCap.Length = sizeof(CcxRmCapBuf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
@@ -1776,7 +1776,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
 		return 0xcafe;
 	}
 	*challenge = NULL;
-	a = (struct rtllib_authentication *) skb->data;
+	a = (struct rtllib_authentication *)skb->data;
 	if (skb->len > (sizeof(struct rtllib_authentication) + 3)) {
 		t = skb->data + sizeof(struct rtllib_authentication);
 
@@ -1799,7 +1799,7 @@ static int auth_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
 		netdev_dbg(dev, "invalid len in auth request: %d\n", skb->len);
 		return -1;
 	}
-	a = (struct rtllib_authentication *) skb->data;
+	a = (struct rtllib_authentication *)skb->data;
 
 	ether_addr_copy(dest, a->header.addr2);
 
@@ -1817,7 +1817,7 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	u8 *ssid = NULL;
 	u8 ssidlen = 0;
 	struct rtllib_hdr_3addr   *header =
-		(struct rtllib_hdr_3addr   *) skb->data;
+		(struct rtllib_hdr_3addr   *)skb->data;
 	bool bssid_match;
 
 	if (skb->len < sizeof(struct rtllib_hdr_3addr))
@@ -1865,7 +1865,7 @@ static int assoc_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
 		return -1;
 	}
 
-	a = (struct rtllib_assoc_request_frame *) skb->data;
+	a = (struct rtllib_assoc_request_frame *)skb->data;
 
 	ether_addr_copy(dest, a->header.addr2);
 
@@ -1884,7 +1884,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 		return 0xcafe;
 	}
 
-	response_head = (struct rtllib_assoc_response_frame *) skb->data;
+	response_head = (struct rtllib_assoc_response_frame *)skb->data;
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
@@ -2167,7 +2167,7 @@ EXPORT_SYMBOL(rtllib_ps_tx_ack);
 static void rtllib_process_action(struct rtllib_device *ieee,
 				  struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *) skb->data;
+	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
 	u8 *act = rtllib_get_payload((struct rtllib_hdr *)header);
 	u8 category = 0;
 
@@ -2206,7 +2206,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 	int aid;
 	u8 *ies;
 	struct rtllib_assoc_response_frame *assoc_resp;
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *) skb->data;
+	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
 	u16 frame_ctl = le16_to_cpu(header->frame_ctl);
 
 	netdev_dbg(ieee->dev, "received [RE]ASSOCIATION RESPONSE (%d)\n",
@@ -2351,7 +2351,7 @@ rtllib_rx_auth(struct rtllib_device *ieee, struct sk_buff *skb,
 static inline int
 rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *) skb->data;
+	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
 	u16 frame_ctl;
 
 	if (memcmp(header->addr3, ieee->current_network.bssid, ETH_ALEN) != 0)
@@ -2391,7 +2391,7 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
 				   struct rtllib_rx_stats *rx_stats, u16 type,
 				   u16 stype)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *) skb->data;
+	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
 	u16 frame_ctl;
 
 	if (!ieee->proto_started)
@@ -2811,7 +2811,7 @@ static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
 	if (!skb)
 		return NULL;
 
-	b = (struct rtllib_probe_response *) skb->data;
+	b = (struct rtllib_probe_response *)skb->data;
 	b->header.frame_ctl = cpu_to_le16(RTLLIB_STYPE_BEACON);
 
 	return skb;
@@ -2827,7 +2827,7 @@ struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee)
 	if (!skb)
 		return NULL;
 
-	b = (struct rtllib_probe_response *) skb->data;
+	b = (struct rtllib_probe_response *)skb->data;
 	b->header.seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 	if (ieee->seq_ctrl[0] == 0xFFF)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 57a6d1130b6a..70a62ca0f69a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -41,8 +41,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 
 	/* if setting by freq convert to channel */
 	if (fwrq->e == 1) {
-		if ((fwrq->m >= (int) 2.412e8 &&
-		     fwrq->m <= (int) 2.487e8)) {
+		if ((fwrq->m >= (int)2.412e8 &&
+		     fwrq->m <= (int)2.487e8)) {
 			int f = fwrq->m / 100000;
 			int c = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 0d67d5880377..cf9a240924f2 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -660,7 +660,7 @@ int rtllib_wx_set_mlme(struct rtllib_device *ieee,
 {
 	u8 i = 0;
 	bool deauth = false;
-	struct iw_mlme *mlme = (struct iw_mlme *) extra;
+	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
 	if (ieee->state != RTLLIB_LINKED)
 		return -ENOLINK;
-- 
2.35.3

