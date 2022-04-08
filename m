Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A78D4F8C30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiDHD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDHDZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:25:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FDF9FBB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:23:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z15so525530qtj.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=lJj3T2FLkU/fy3UcI0gJNfuYvSnLEg/yHUZvxLu2mxg=;
        b=mLDvPn1s6N/IFPWeHwi2ZOJjxat5KPkO6HLjj1kiij81PVnv9zDmqZ1JlaJB+n/pYB
         2SX3X908BtEf5Y6niE8ITU2eQm+9X3rIIrsbAxyKxQj3lIqGSu3rlvrae+TLH78jypJz
         G6mkcgSXM4lv0fYG3Zajn8t8dvNBy0awsMBP1Xy+82/nWCcMgC0DGi1SOsHJiOGDJdVU
         61QXfCdYLPgyO7V/CWaN6OEVrvp6dwpWCYfj5QjPxC47C8KfRin39gREQZwDwbqMrpq/
         0hGtbRMLqxyuNfq5nkHeKPSgN4EgbXyjnEsgH1hmbFskAGs0jxum2l4OebbsypD991Fl
         iPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=lJj3T2FLkU/fy3UcI0gJNfuYvSnLEg/yHUZvxLu2mxg=;
        b=E4bPw1pzZMMTcT7QXVhnkQwU7mb3Bxp+gfDYoeUSOMwxgklrTJ0J7aRhTQ03w1FVGs
         5Qq+sdtJXSMtD5EFFB5Wb1XcKBx2Y9fO+SO+9xjTItlYH0IBoQu4rhtGc/6LdYcUlJaG
         9+HyBcNvxJGHww1xbY6RkEIHBV0ODMszSbautQABUv39rcZGnX1fgCT949dAC00nWQN0
         dfwLYatoU4dgxQBj+y7PMx/3hI1DT0vQVLyWSo2eqJvzs/73+9d7CBwzmeChd1LSd5wP
         k3pgEIlH7V2sdpKFHjk3u0JTwjrkqflL3M0JwSltkW2VXAAgqX59qTVbjwJL0M31yMIL
         pfgw==
X-Gm-Message-State: AOAM530uL5Y/l5GasWjYOrS27PAw2Il+wbYk/+AEBKE3XVSbih0dWc2D
        TvgbpTwoOcfNt2KtC2lbjzU=
X-Google-Smtp-Source: ABdhPJxP5MdndqqO2cns2Rsk+ULlwasthky7YdXN+yBkQTdt6c52e6b8EEogrisFCwVA2kaFofgh2w==
X-Received: by 2002:a05:622a:593:b0:2e1:eabd:5e25 with SMTP id c19-20020a05622a059300b002e1eabd5e25mr14616150qtb.191.1649388233124;
        Thu, 07 Apr 2022 20:23:53 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:9b98:2b92:de9c:bd16])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm17795199qtx.58.2022.04.07.20.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 20:23:52 -0700 (PDT)
Date:   Thu, 7 Apr 2022 23:23:49 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Jaehee Park <jhpark1013@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Use container_of() to get vif. This improves the code in two ways:
[1] it speeds up the compilation because container_of() saves steps to
retrieve vif (the representation of ieee80211_vif), and
[2] it eliminates the need to define multiple pointers. Previously,
after setting the pointer to drv_priv, another pointer had to be
defined by vif in struct wfx_vif to point back to ieee80211_vif.
Remove vif from the struct wfx_vif, define a macro wvif_to_vif(ptr)
for container_of(), and replace all wvif->vif with the newly defined
container_of() construct.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
Note: 
This is a revised patch to sequence the wfx.h file (with the new defines) to show up first on the diff, which makes the ordering of the diff more logical.

Questions:
- These changes had built without errors for me but it would be great if someone can test it on the actual hardware.
- We noticed that the development of the wfx driver is happening in the netdev tree instead of Greg's tree. Do you suggest that I use the net-next tree for this change? 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/drivers/staging/wfx
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/wfx

drivers/staging/wfx/wfx.h     |  3 ++-
 drivers/staging/wfx/data_rx.c |  4 ++--
 drivers/staging/wfx/data_tx.c |  2 +-
 drivers/staging/wfx/key.c     |  3 +--
 drivers/staging/wfx/queue.c   |  2 +-
 drivers/staging/wfx/scan.c    |  6 ++---
 drivers/staging/wfx/sta.c     | 45 ++++++++++++++++-------------------
 7 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
index 6594cc647c2f..78f2a416fe4f 100644
--- a/drivers/staging/wfx/wfx.h
+++ b/drivers/staging/wfx/wfx.h
@@ -25,6 +25,8 @@
 #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
 #define USEC_PER_TU 1024
 
+#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))
+
 struct wfx_hwbus_ops;
 
 struct wfx_dev {
@@ -61,7 +63,6 @@ struct wfx_dev {
 
 struct wfx_vif {
 	struct wfx_dev             *wdev;
-	struct ieee80211_vif       *vif;
 	struct ieee80211_channel   *channel;
 	int                        id;
 
diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index a4b5ffe158e4..98c2223089b8 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -24,12 +24,12 @@ static void wfx_rx_handle_ba(struct wfx_vif *wvif, struct ieee80211_mgmt *mgmt)
 	case WLAN_ACTION_ADDBA_REQ:
 		params = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
 		tid = (params & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
-		ieee80211_start_rx_ba_session_offl(wvif->vif, mgmt->sa, tid);
+		ieee80211_start_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);
 		break;
 	case WLAN_ACTION_DELBA:
 		params = le16_to_cpu(mgmt->u.action.u.delba.params);
 		tid = (params &  IEEE80211_DELBA_PARAM_TID_MASK) >> 12;
-		ieee80211_stop_rx_ba_session_offl(wvif->vif, mgmt->sa, tid);
+		ieee80211_stop_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);
 		break;
 	}
 }
diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index e07381b2ff4d..fd79e03a08c5 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -216,7 +216,7 @@ static u8 wfx_tx_get_link_id(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 
 	if (sta_priv && sta_priv->link_id)
 		return sta_priv->link_id;
-	if (wvif->vif->type != NL80211_IFTYPE_AP)
+	if (wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP)
 		return 0;
 	if (is_multicast_ether_addr(da))
 		return 0;
diff --git a/drivers/staging/wfx/key.c b/drivers/staging/wfx/key.c
index 8f23e8d42bd4..71b1fca70248 100644
--- a/drivers/staging/wfx/key.c
+++ b/drivers/staging/wfx/key.c
@@ -174,7 +174,7 @@ static int wfx_add_key(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 			k.type = fill_tkip_pair(&k.key.tkip_pairwise_key, key, sta->addr);
 		else
 			k.type = fill_tkip_group(&k.key.tkip_group_key, key, &seq,
-						 wvif->vif->type);
+						 wvif_to_vif(wvif)->type);
 	} else if (key->cipher == WLAN_CIPHER_SUITE_CCMP) {
 		if (pairwise)
 			k.type = fill_ccmp_pair(&k.key.aes_pairwise_key, key, sta->addr);
@@ -224,4 +224,3 @@ int wfx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd, struct ieee80211_
 	mutex_unlock(&wvif->wdev->conf_mutex);
 	return ret;
 }
-
diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index 729825230db2..a2745d1024c6 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -207,7 +207,7 @@ bool wfx_tx_queues_has_cab(struct wfx_vif *wvif)
 {
 	int i;
 
-	if (wvif->vif->type != NL80211_IFTYPE_AP)
+	if (wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP)
 		return false;
 	for (i = 0; i < IEEE80211_NUM_ACS; ++i)
 		/* Note: since only AP can have mcast frames in queue and only one vif can be AP,
diff --git a/drivers/staging/wfx/scan.c b/drivers/staging/wfx/scan.c
index 7f34f0d322f9..5c25fde3fc41 100644
--- a/drivers/staging/wfx/scan.c
+++ b/drivers/staging/wfx/scan.c
@@ -25,7 +25,7 @@ static int update_probe_tmpl(struct wfx_vif *wvif, struct cfg80211_scan_request
 {
 	struct sk_buff *skb;
 
-	skb = ieee80211_probereq_get(wvif->wdev->hw, wvif->vif->addr, NULL, 0, req->ie_len);
+	skb = ieee80211_probereq_get(wvif->wdev->hw, wvif_to_vif(wvif)->addr, NULL, 0, req->ie_len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -75,8 +75,8 @@ static int send_scan_req(struct wfx_vif *wvif, struct cfg80211_scan_request *req
 	} else {
 		ret = wvif->scan_nb_chan_done;
 	}
-	if (req->channels[start_idx]->max_power != wvif->vif->bss_conf.txpower)
-		wfx_hif_set_output_power(wvif, wvif->vif->bss_conf.txpower);
+	if (req->channels[start_idx]->max_power != wvif_to_vif(wvif)->bss_conf.txpower)
+		wfx_hif_set_output_power(wvif, wvif_to_vif(wvif)->bss_conf.txpower);
 	wfx_tx_unlock(wvif->wdev);
 	return ret;
 }
diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 03025ef7f1be..b634c8e004db 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -132,7 +132,7 @@ void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 			filter_bssid = true;
 
 		/* In AP mode, chip can reply to probe request itself */
-		if (*total_flags & FIF_PROBE_REQ && wvif->vif->type == NL80211_IFTYPE_AP) {
+		if (*total_flags & FIF_PROBE_REQ && wvif_to_vif(wvif)->type == NL80211_IFTYPE_AP) {
 			dev_dbg(wdev->dev, "do not forward probe request in AP mode\n");
 			*total_flags &= ~FIF_PROBE_REQ;
 		}
@@ -153,18 +153,18 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 	struct ieee80211_channel *chan0 = NULL, *chan1 = NULL;
 	struct ieee80211_conf *conf = &wvif->wdev->hw->conf;
 
-	WARN(!wvif->vif->bss_conf.assoc && enable_ps,
+	WARN(!wvif_to_vif(wvif)->bss_conf.assoc && enable_ps,
 	     "enable_ps is reliable only if associated");
 	if (wdev_to_wvif(wvif->wdev, 0))
-		chan0 = wdev_to_wvif(wvif->wdev, 0)->vif->bss_conf.chandef.chan;
+		chan0 = wvif_to_vif(wdev_to_wvif(wvif->wdev, 0))->bss_conf.chandef.chan;
 	if (wdev_to_wvif(wvif->wdev, 1))
-		chan1 = wdev_to_wvif(wvif->wdev, 1)->vif->bss_conf.chandef.chan;
-	if (chan0 && chan1 && wvif->vif->type != NL80211_IFTYPE_AP) {
+		chan1 = wvif_to_vif(wdev_to_wvif(wvif->wdev, 1))->bss_conf.chandef.chan;
+	if (chan0 && chan1 && wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP) {
 		if (chan0->hw_value == chan1->hw_value) {
 			/* It is useless to enable PS if channels are the same. */
 			if (enable_ps)
 				*enable_ps = false;
-			if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
+			if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.ps)
 				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
 			return -1;
 		}
@@ -177,8 +177,8 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			return 30;
 	}
 	if (enable_ps)
-		*enable_ps = wvif->vif->bss_conf.ps;
-	if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
+		*enable_ps = wvif_to_vif(wvif)->bss_conf.ps;
+	if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.ps)
 		return conf->dynamic_ps_timeout;
 	else
 		return -1;
@@ -189,7 +189,7 @@ int wfx_update_pm(struct wfx_vif *wvif)
 	int ps_timeout;
 	bool ps;
 
-	if (!wvif->vif->bss_conf.assoc)
+	if (!wvif_to_vif(wvif)->bss_conf.assoc)
 		return 0;
 	ps_timeout = wfx_get_ps_timeout(wvif, &ps);
 	if (!ps)
@@ -215,7 +215,7 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&wdev->conf_mutex);
 	assign_bit(queue, &wvif->uapsd_mask, params->uapsd);
 	wfx_hif_set_edca_queue_params(wvif, queue, params);
-	if (wvif->vif->type == NL80211_IFTYPE_STATION && old_uapsd != wvif->uapsd_mask) {
+	if (wvif_to_vif(wvif)->type == NL80211_IFTYPE_STATION && old_uapsd != wvif->uapsd_mask) {
 		wfx_hif_set_uapsd_info(wvif, wvif->uapsd_mask);
 		wfx_update_pm(wvif);
 	}
@@ -242,20 +242,20 @@ void wfx_event_report_rssi(struct wfx_vif *wvif, u8 raw_rcpi_rssi)
 	int cqm_evt;
 
 	rcpi_rssi = raw_rcpi_rssi / 2 - 110;
-	if (rcpi_rssi <= wvif->vif->bss_conf.cqm_rssi_thold)
+	if (rcpi_rssi <= wvif_to_vif(wvif)->bss_conf.cqm_rssi_thold)
 		cqm_evt = NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
 	else
 		cqm_evt = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
-	ieee80211_cqm_rssi_notify(wvif->vif, cqm_evt, rcpi_rssi, GFP_KERNEL);
+	ieee80211_cqm_rssi_notify(wvif_to_vif(wvif), cqm_evt, rcpi_rssi, GFP_KERNEL);
 }
 
 static void wfx_beacon_loss_work(struct work_struct *work)
 {
 	struct wfx_vif *wvif = container_of(to_delayed_work(work), struct wfx_vif,
 					    beacon_loss_work);
-	struct ieee80211_bss_conf *bss_conf = &wvif->vif->bss_conf;
+	struct ieee80211_bss_conf *bss_conf = &wvif_to_vif(wvif)->bss_conf;
 
-	ieee80211_beacon_loss(wvif->vif);
+	ieee80211_beacon_loss(wvif_to_vif(wvif));
 	schedule_delayed_work(to_delayed_work(work), msecs_to_jiffies(bss_conf->beacon_int));
 }
 
@@ -323,13 +323,13 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 {
 	struct sk_buff *skb;
 
-	skb = ieee80211_beacon_get(wvif->wdev->hw, wvif->vif);
+	skb = ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vif(wvif));
 	if (!skb)
 		return -ENOMEM;
 	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_BCN, API_RATE_INDEX_B_1MBPS);
 	dev_kfree_skb(skb);
 
-	skb = ieee80211_proberesp_get(wvif->wdev->hw, wvif->vif);
+	skb = ieee80211_proberesp_get(wvif->wdev->hw, wvif_to_vif(wvif));
 	if (!skb)
 		return -ENOMEM;
 	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_PRBRES, API_RATE_INDEX_B_1MBPS);
@@ -339,7 +339,7 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 
 static void wfx_set_mfp_ap(struct wfx_vif *wvif)
 {
-	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, wvif->vif);
+	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vif(wvif));
 	const int ieoffset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
 	const u16 *ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
 						 skb->len - ieoffset);
@@ -389,7 +389,7 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 static void wfx_join(struct wfx_vif *wvif)
 {
 	int ret;
-	struct ieee80211_bss_conf *conf = &wvif->vif->bss_conf;
+	struct ieee80211_bss_conf *conf = &wvif_to_vif(wvif)->bss_conf;
 	struct cfg80211_bss *bss = NULL;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
 	const u8 *ssid_ie = NULL;
@@ -420,7 +420,7 @@ static void wfx_join(struct wfx_vif *wvif)
 	wvif->join_in_progress = true;
 	ret = wfx_hif_join(wvif, conf, wvif->channel, ssid, ssid_len);
 	if (ret) {
-		ieee80211_connection_loss(wvif->vif);
+		ieee80211_connection_loss(wvif_to_vif(wvif));
 		wfx_reset(wvif);
 	} else {
 		/* Due to beacon filtering it is possible that the AP's beacon is not known for the
@@ -440,7 +440,7 @@ static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *i
 
 	rcu_read_lock(); /* protect sta */
 	if (info->bssid && !info->ibss_joined)
-		sta = ieee80211_find_sta(wvif->vif, info->bssid);
+		sta = ieee80211_find_sta(wvif_to_vif(wvif), info->bssid);
 	if (sta && sta->ht_cap.ht_supported)
 		ampdu_density = sta->ht_cap.ampdu_density;
 	if (sta && sta->ht_cap.ht_supported &&
@@ -565,7 +565,7 @@ static int wfx_update_tim(struct wfx_vif *wvif)
 	u16 tim_offset, tim_length;
 	u8 *tim_ptr;
 
-	skb = ieee80211_beacon_get_tim(wvif->wdev->hw, wvif->vif, &tim_offset, &tim_length);
+	skb = ieee80211_beacon_get_tim(wvif->wdev->hw, wvif_to_vif(wvif), &tim_offset, &tim_length);
 	if (!skb)
 		return -ENOENT;
 	tim_ptr = skb->data + tim_offset;
@@ -707,8 +707,6 @@ int wfx_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		return -EOPNOTSUPP;
 	}
 
-	/* FIXME: prefer use of container_of() to get vif */
-	wvif->vif = vif;
 	wvif->wdev = wdev;
 
 	wvif->link_id_map = 1; /* link-id 0 is reserved for multicast */
@@ -767,7 +765,6 @@ void wfx_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	cancel_delayed_work_sync(&wvif->beacon_loss_work);
 	wdev->vif[wvif->id] = NULL;
-	wvif->vif = NULL;
 
 	mutex_unlock(&wdev->conf_mutex);
 
-- 
2.25.1

