Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB24B0A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiBJKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:05:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiBJKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:05:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A7C55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id y3so14069691ejf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guBM8Thpvta//OnnwvBS2Yed9yNINr+uW6fG9LcJsBs=;
        b=Tm/wv7cKv2FbBy0bMrFuaOlLuudZSDznlEvy8sBfc2zcokikXC9yhQzXRlJ/Y1lx5e
         BHoSHZvOjU9H8VLpWnfdKs/94x964AaFKSThO8LwB087CMSOX8TelluBltkA0puNBjI8
         nBW4zaBM+TDehPKP9YlJW3K4/sBnbCpGzbGzfxmX9ItKhiV6JZw7gjmcbzeUrUnr4wRf
         G5q/hXG1ZxO8DZpfAkKy7abmwRAvBio993DejU9wbW7r8MwsgULhGjdYmf5gm43ydSri
         nWfALiD/goJARQGd8BRgbU4Y/+dGwsBmTHol3oj8KHXKDZ5q3mdAwfbymAPPNnTOWMNN
         bopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guBM8Thpvta//OnnwvBS2Yed9yNINr+uW6fG9LcJsBs=;
        b=iRwQL1DGiwDCq7kBZQbB9yE4EfzTDm3gc0KiP8taEHrgrCfm9NDY2pIbIbhRn54qYl
         4g6psS4RWaKyI1EuKJT5PvLhdRFjh8sN3Kwj6AcR5YluKbsnEjPuiUW5fewnHmr64f8s
         pxuFmDuFzc8ZWxJ7zxUjJPdw3WgPGONfiRrw+WVo0bfPlvneT/JFxUmFEVFzSjMjUbWu
         qblmENIzwTjIjiS54ibO8eEX4wUeiQpgxNiuImAm7Ymx6/z6SpzF0sXBprDSda1EuFaz
         vZgcZ8I09LubSnwNtvbnVbedo03ZYxitRC2X/PrOqZdyAnFiSotlGW2fMrQhX6AME6Tw
         lhxg==
X-Gm-Message-State: AOAM532FpQ7Sa72ETvtf4NBsC7sWZBHIVmyif5wyWDuRw35/pPvdr4Jy
        DiJw0eq8tIZnLKPyrBJy4cg=
X-Google-Smtp-Source: ABdhPJwbbIHoip3yuFrU9pvr4k+UNZWYzH+DXO5/8KmWMM4oA+hFgWn5MjsLYLkd1vS48VBkLIVsAg==
X-Received: by 2002:a17:906:74c2:: with SMTP id z2mr5774479ejl.36.1644487527748;
        Thu, 10 Feb 2022 02:05:27 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id 5sm9729858edx.32.2022.02.10.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:05:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove unused enums from ieee80211.h
Date:   Thu, 10 Feb 2022 11:05:14 +0100
Message-Id: <20220210100514.8506-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210100514.8506-1-straube.linux@gmail.com>
References: <20220210100514.8506-1-straube.linux@gmail.com>
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

There are some unused enums in the ieee80211.h header. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 66 ---------------------
 1 file changed, 66 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index f3b20215ca94..1793b99feb9f 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -226,14 +226,6 @@ struct rtw_ieee80211_hdr_3addr_qos {
 	u16     qc;
 }  __packed;
 
-enum eap_type {
-	EAP_PACKET = 0,
-	EAPOL_START,
-	EAPOL_LOGOFF,
-	EAPOL_KEY,
-	EAPOL_ENCAP_ASF_ALERT
-};
-
 #define IEEE80211_3ADDR_LEN 24
 #define IEEE80211_4ADDR_LEN 30
 #define IEEE80211_FCS_LEN    4
@@ -626,44 +618,6 @@ Total: 28-2340 bytes
 > 0: TID
 */
 
-enum ieee80211_state {
-	/* the card is not linked at all */
-	IEEE80211_NOLINK = 0,
-
-	/* IEEE80211_ASSOCIATING* are for BSS client mode
-	 * the driver shall not perform RX filtering unless
-	 * the state is LINKED.
-	 * The driver shall just check for the state LINKED and
-	 * defaults to NOLINK for ALL the other states (including
-	 * LINKED_SCANNING)
-	 */
-
-	/* the association procedure will start (wq scheduling)*/
-	IEEE80211_ASSOCIATING,
-	IEEE80211_ASSOCIATING_RETRY,
-
-	/* the association procedure is sending AUTH request*/
-	IEEE80211_ASSOCIATING_AUTHENTICATING,
-
-	/* the association procedure has successfully authentcated
-	 * and is sending association request
-	 */
-	IEEE80211_ASSOCIATING_AUTHENTICATED,
-
-	/* the link is ok. the card associated to a BSS or linked
-	 * to a ibss cell or acting as an AP and creating the bss
-	 */
-	IEEE80211_LINKED,
-
-	/* same as LINKED, but the driver shall apply RX filter
-	 * rules as we are in NO_LINK mode. As the card is still
-	 * logically linked, but it is doing a syncro site survey
-	 * then it will be back to LINKED state.
-	 */
-	IEEE80211_LINKED_SCANNING,
-
-};
-
 #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
 #define DEFAULT_FTS 2346
 
@@ -741,26 +695,6 @@ enum rtw_ieee80211_back_actioncode {
 	RTW_WLAN_ACTION_DELBA = 2,
 };
 
-/* HT features action code */
-enum rtw_ieee80211_ht_actioncode {
-	RTW_WLAN_ACTION_NOTIFY_CH_WIDTH = 0,
-	RTW_WLAN_ACTION_SM_PS = 1,
-	RTW_WLAN_ACTION_PSPM = 2,
-	RTW_WLAN_ACTION_PCO_PHASE = 3,
-	RTW_WLAN_ACTION_MIMO_CSI_MX = 4,
-	RTW_WLAN_ACTION_MIMO_NONCP_BF = 5,
-	RTW_WLAN_ACTION_MIMP_CP_BF = 6,
-	RTW_WLAN_ACTION_ASEL_INDICATES_FB = 7,
-	RTW_WLAN_ACTION_HI_INFO_EXCHG = 8,
-};
-
-/* BACK (block-ack) parties */
-enum rtw_ieee80211_back_parties {
-	RTW_WLAN_BACK_RECIPIENT = 0,
-	RTW_WLAN_BACK_INITIATOR = 1,
-	RTW_WLAN_BACK_TIMER = 2,
-};
-
 #define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs)
 				* 00:50:F2 */
 #define WME_OUI_TYPE 2
-- 
2.35.1

