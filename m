Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9484B0A67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiBJKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:16:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiBJKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:16:31 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699CCEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:16:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id eg42so9997420edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guBM8Thpvta//OnnwvBS2Yed9yNINr+uW6fG9LcJsBs=;
        b=gK6S0oodKqVWX8iXASBOGdbbRb7LpSeLn0enYqZ1fzVs+wPuCjEXP4t++Vwjpdfa5D
         SpXkIm2wP8VJDblOuChUJOSRGnRDYB9VGJ8pj0+Go2n3lU3uC1X6Q53RniuSlcUc9Chc
         XrrSHrXsf6qNe4/mIaFooQeJCvUaLWonBRf+yVD4iS5DzZeNWwcDZy5YfUTTXlfrgp9d
         oGcnL1Upc4TQg+BUdwHyO8HCXhESBR9x6pz2yg91IydBJa2QaDe8ty6KMGViJTvZNRar
         xCQLOgscbXxSLiByLKIxO1zHBe/2CyA2Cm0iZTbMyVK46D73c8TdJ7Ry8vCVF8FNAsUn
         9OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guBM8Thpvta//OnnwvBS2Yed9yNINr+uW6fG9LcJsBs=;
        b=3wFz8NToqooo6iYG4c/mTtvzrAgtXGJ6F/4uQZ5xDzSycL99MTXQzNshAQqM+PoLpY
         +h7RQU6k/OQy2g+oZlmg8XV9ZGi2gwOh+iKyk5CKxB5wdgn+DrDBPEmIqpdtKR+MkWrl
         Zdz2HzGv6c4EU/H9f/wJvoiWLEaH0/lFzVIfV0eUr4304X6Pv78ux+P/UbDvfJl6fjl2
         crFkpQLuED/dIxlg3TAyX/fvJZuaPLFiUJcC1FXvYkWVBIU5DEBpDLlGp6sX6I0jIJZH
         KNTjgQ06O/HqwMWG1lx4+B5V/9why+o/lHa9vnPnoDfKB/wMEZFE4Te2CTtVuKfp8cV3
         KJXA==
X-Gm-Message-State: AOAM5339SnVshMOlbvMOnCRTbEg5JOFWp1Y8EP+agoqDeRA0dBD4c5cy
        Sq/dS60wtUuJxjOOizw0FOE=
X-Google-Smtp-Source: ABdhPJx4qCMHtGUrwTjW8QwWNKukv2KD/kcQAO7oHoyDjVUG938pV92O+8rO7zcnLysK94YvDtGgDg==
X-Received: by 2002:aa7:cc09:: with SMTP id q9mr7548019edt.101.1644488191880;
        Thu, 10 Feb 2022 02:16:31 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id i9sm7994855eda.35.2022.02.10.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:16:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: remove unused enums from ieee80211.h
Date:   Thu, 10 Feb 2022 11:16:23 +0100
Message-Id: <20220210101623.13758-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210101623.13758-1-straube.linux@gmail.com>
References: <20220210101623.13758-1-straube.linux@gmail.com>
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

