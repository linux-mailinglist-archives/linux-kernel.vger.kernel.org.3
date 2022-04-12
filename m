Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15A04FCD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbiDLEOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDLEOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:14:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD382E6AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:12:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d71so4699104qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=eRN581QAGjUr6HsR2+k0YN+SPaXIkKQ+30nP/UUYQ9Q=;
        b=W6JRtkF9yGE3PtE95d8u2Vaa8ni01UZc1SH16TGlRh1PLM4zg/gjzWHaiWwMs4MUHC
         Z5kPhMTNEThaoTjMGbUBvOI/4iv7y8v9HijJy8ExxzMULngus1dwASAcDzarWdi03oLk
         avKXM+1yQCNAfHmVDSNttnfv4ln7MbOLgo8I5B3nmkkQ6u63mXEs2lbmxADY3pNPNCiM
         j0gRrm5Hl3snUrGtbDbIZ53Onhxz01RgxUPO/WYDT/PL0iOYsPoNHTIrgF/HKHK4cloK
         3qHrcb8InqHcjz0el0x3+LdjPSPVKjtwuf1MTAG/8rbt0DT3nWX421z4/n3z3fEsUbL5
         ApgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=eRN581QAGjUr6HsR2+k0YN+SPaXIkKQ+30nP/UUYQ9Q=;
        b=z//JZ8hQhEiTfpKkexQtNy2dBoehqXSLkLq5vQsX6KIe+pLHdm6s/+kySLkMvzRJZq
         3lqn7AX04YntDa83xR+R9cy6QZNdHw5r3Z9dI/SGgeoL5zqzA+4FkaA+tlabiTn26Dbg
         CCin1oUbdR9iXG1hkvDxGXg+Pyq3l/uLuODjzNKY0xbb1wFwgPlHM4jSkoB0u+AWmCaA
         eNCNCuJNFJiC+Zy39Vf1jas5px8vu84JCLQcJQhIV/xJkz0yGY6WCnRBRoFE4mHgp80t
         y3c5fyIKpcv8Hy3/wOGRvG20JIKdLoVrHobXhWLWrnt8iuoZtn2kvcrSblu3WqGOgM7f
         /jIQ==
X-Gm-Message-State: AOAM531F8BNMqIquIMG58ghEr+Yj9FCi0ALlHERl4M0YnhwgrWktycQT
        84LgggWXd/pQVjIEEsBGga8D16+Tv8xaHk2O
X-Google-Smtp-Source: ABdhPJyTY++kDJcGgELf3rtpY8cNGLbbndgRVnGmG8uo5m/ZrHybqBGTKPLTuWA7zOJJgpuwmw3K2g==
X-Received: by 2002:a05:620a:1a85:b0:69c:6d1:9023 with SMTP id bl5-20020a05620a1a8500b0069c06d19023mr1830583qkb.773.1649736741366;
        Mon, 11 Apr 2022 21:12:21 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a025400b002e1dd71e797sm26651805qtx.15.2022.04.11.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 21:12:20 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:12:18 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Jaehee Park <jhpark1013@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH V3] wfx: use container_of() to get vif
Message-ID: <20220412041218.GA2859599@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, upon virtual interface creation, wfx_add_interface() stores
a reference to the corresponding struct ieee80211_vif in private data,
for later usage. This is not needed when using the container_of
construct. This construct already has all the info it needs to retrieve
the reference to the corresponding struct from the offset that is
already available, inherent in container_of(), between its type and
member inputs (struct ieee80211_vif and drv_priv, respectively).
Remove vif (which was previously storing the reference to the struct
ieee80211_vif) from the struct wfx_vif, define a macro
wvif_to_vif(wvif) for container_of(), and replace all wvif->vif with
the newly defined container_of construct.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---

Changes in v3:
- Made edits to the commit message.
- Shortened the macro name from wvif_to_vif to to_vif.
- For functions that had more than one instance of vif, defined one 
reference vif at the beginning of the function and used that instead.
- Broke the if-statements that ran long into two lines.
(There are 3 lines that exceed 80 by less than 4 characters. Two of 
those lines of code could be shorted but it involved defining two more 
variables, and could potentially make the code less readable.)

Note: I will mail this patch to the wireless-next tree after testing.


 drivers/staging/wfx/wfx.h     |  2 +-
 drivers/staging/wfx/data_rx.c |  5 ++--
 drivers/staging/wfx/data_tx.c |  2 +-
 drivers/staging/wfx/key.c     |  2 +-
 drivers/staging/wfx/queue.c   |  2 +-
 drivers/staging/wfx/scan.c    | 10 +++++---
 drivers/staging/wfx/sta.c     | 46 +++++++++++++++++++----------------
 7 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
index 78f2a416fe4f..a07baadc5e70 100644
--- a/drivers/staging/wfx/wfx.h
+++ b/drivers/staging/wfx/wfx.h
@@ -25,7 +25,7 @@
 #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
 #define USEC_PER_TU 1024
 
-#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))
+#define to_vif(wvif)container_of((void *)wvif, struct ieee80211_vif, drv_priv)
 
 struct wfx_hwbus_ops;
 
diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index 98c2223089b8..3677b3431467 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -16,6 +16,7 @@
 static void wfx_rx_handle_ba(struct wfx_vif *wvif, struct ieee80211_mgmt *mgmt)
 {
 	int params, tid;
+	struct ieee80211_vif *vif = to_vif(wvif);
 
 	if (wfx_api_older_than(wvif->wdev, 3, 6))
 		return;
@@ -24,12 +25,12 @@ static void wfx_rx_handle_ba(struct wfx_vif *wvif, struct ieee80211_mgmt *mgmt)
 	case WLAN_ACTION_ADDBA_REQ:
 		params = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
 		tid = (params & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
-		ieee80211_start_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);
+		ieee80211_start_rx_ba_session_offl(vif, mgmt->sa, tid);
 		break;
 	case WLAN_ACTION_DELBA:
 		params = le16_to_cpu(mgmt->u.action.u.delba.params);
 		tid = (params &  IEEE80211_DELBA_PARAM_TID_MASK) >> 12;
-		ieee80211_stop_rx_ba_session_offl(wvif_to_vif(wvif), mgmt->sa, tid);
+		ieee80211_stop_rx_ba_session_offl(vif, mgmt->sa, tid);
 		break;
 	}
 }
diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index fd79e03a08c5..edaa714ed8f7 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -216,7 +216,7 @@ static u8 wfx_tx_get_link_id(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 
 	if (sta_priv && sta_priv->link_id)
 		return sta_priv->link_id;
-	if (wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP)
+	if (to_vif(wvif)->type != NL80211_IFTYPE_AP)
 		return 0;
 	if (is_multicast_ether_addr(da))
 		return 0;
diff --git a/drivers/staging/wfx/key.c b/drivers/staging/wfx/key.c
index 71b1fca70248..d939803153de 100644
--- a/drivers/staging/wfx/key.c
+++ b/drivers/staging/wfx/key.c
@@ -174,7 +174,7 @@ static int wfx_add_key(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 			k.type = fill_tkip_pair(&k.key.tkip_pairwise_key, key, sta->addr);
 		else
 			k.type = fill_tkip_group(&k.key.tkip_group_key, key, &seq,
-						 wvif_to_vif(wvif)->type);
+						 to_vif(wvif)->type);
 	} else if (key->cipher == WLAN_CIPHER_SUITE_CCMP) {
 		if (pairwise)
 			k.type = fill_ccmp_pair(&k.key.aes_pairwise_key, key, sta->addr);
diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index a2745d1024c6..86290c681541 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -207,7 +207,7 @@ bool wfx_tx_queues_has_cab(struct wfx_vif *wvif)
 {
 	int i;
 
-	if (wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP)
+	if (to_vif(wvif)->type != NL80211_IFTYPE_AP)
 		return false;
 	for (i = 0; i < IEEE80211_NUM_ACS; ++i)
 		/* Note: since only AP can have mcast frames in queue and only one vif can be AP,
diff --git a/drivers/staging/wfx/scan.c b/drivers/staging/wfx/scan.c
index 5c25fde3fc41..e90170062d42 100644
--- a/drivers/staging/wfx/scan.c
+++ b/drivers/staging/wfx/scan.c
@@ -24,8 +24,9 @@ static void wfx_ieee80211_scan_completed_compat(struct ieee80211_hw *hw, bool ab
 static int update_probe_tmpl(struct wfx_vif *wvif, struct cfg80211_scan_request *req)
 {
 	struct sk_buff *skb;
-
-	skb = ieee80211_probereq_get(wvif->wdev->hw, wvif_to_vif(wvif)->addr, NULL, 0, req->ie_len);
+	struct ieee80211_vif *vif = to_vif(wvif);
+	skb = ieee80211_probereq_get(wvif->wdev->hw, vif->addr, 
+				     NULL, 0, req->ie_len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -39,6 +40,7 @@ static int send_scan_req(struct wfx_vif *wvif, struct cfg80211_scan_request *req
 {
 	int i, ret;
 	struct ieee80211_channel *ch_start, *ch_cur;
+	struct ieee80211_vif *vif = to_vif(wvif);
 
 	for (i = start_idx; i < req->n_channels; i++) {
 		ch_start = req->channels[start_idx];
@@ -75,8 +77,8 @@ static int send_scan_req(struct wfx_vif *wvif, struct cfg80211_scan_request *req
 	} else {
 		ret = wvif->scan_nb_chan_done;
 	}
-	if (req->channels[start_idx]->max_power != wvif_to_vif(wvif)->bss_conf.txpower)
-		wfx_hif_set_output_power(wvif, wvif_to_vif(wvif)->bss_conf.txpower);
+	if (req->channels[start_idx]->max_power != vif->bss_conf.txpower)
+		wfx_hif_set_output_power(wvif, vif->bss_conf.txpower);
 	wfx_tx_unlock(wvif->wdev);
 	return ret;
 }
diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index b634c8e004db..c3aa3cdc4838 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -132,7 +132,8 @@ void wfx_configure_filter(struct ieee80211_hw *hw, unsigned int changed_flags,
 			filter_bssid = true;
 
 		/* In AP mode, chip can reply to probe request itself */
-		if (*total_flags & FIF_PROBE_REQ && wvif_to_vif(wvif)->type == NL80211_IFTYPE_AP) {
+		if (*total_flags & FIF_PROBE_REQ && 
+		    to_vif(wvif)->type == NL80211_IFTYPE_AP) {
 			dev_dbg(wdev->dev, "do not forward probe request in AP mode\n");
 			*total_flags &= ~FIF_PROBE_REQ;
 		}
@@ -152,19 +153,20 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 {
 	struct ieee80211_channel *chan0 = NULL, *chan1 = NULL;
 	struct ieee80211_conf *conf = &wvif->wdev->hw->conf;
+	struct ieee80211_vif *vif = to_vif(wvif);
 
-	WARN(!wvif_to_vif(wvif)->bss_conf.assoc && enable_ps,
+	WARN(!vif->bss_conf.assoc && enable_ps,
 	     "enable_ps is reliable only if associated");
 	if (wdev_to_wvif(wvif->wdev, 0))
-		chan0 = wvif_to_vif(wdev_to_wvif(wvif->wdev, 0))->bss_conf.chandef.chan;
+		chan0 = to_vif(wdev_to_wvif(wvif->wdev, 0))->bss_conf.chandef.chan;
 	if (wdev_to_wvif(wvif->wdev, 1))
-		chan1 = wvif_to_vif(wdev_to_wvif(wvif->wdev, 1))->bss_conf.chandef.chan;
-	if (chan0 && chan1 && wvif_to_vif(wvif)->type != NL80211_IFTYPE_AP) {
+		chan1 = to_vif(wdev_to_wvif(wvif->wdev, 1))->bss_conf.chandef.chan;
+	if (chan0 && chan1 && vif->type != NL80211_IFTYPE_AP) {
 		if (chan0->hw_value == chan1->hw_value) {
 			/* It is useless to enable PS if channels are the same. */
 			if (enable_ps)
 				*enable_ps = false;
-			if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.ps)
+			if (vif->bss_conf.assoc && vif->bss_conf.ps)
 				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
 			return -1;
 		}
@@ -177,8 +179,8 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			return 30;
 	}
 	if (enable_ps)
-		*enable_ps = wvif_to_vif(wvif)->bss_conf.ps;
-	if (wvif_to_vif(wvif)->bss_conf.assoc && wvif_to_vif(wvif)->bss_conf.ps)
+		*enable_ps = vif->bss_conf.ps;
+	if (vif->bss_conf.assoc && vif->bss_conf.ps)
 		return conf->dynamic_ps_timeout;
 	else
 		return -1;
@@ -189,7 +191,7 @@ int wfx_update_pm(struct wfx_vif *wvif)
 	int ps_timeout;
 	bool ps;
 
-	if (!wvif_to_vif(wvif)->bss_conf.assoc)
+	if (!to_vif(wvif)->bss_conf.assoc)
 		return 0;
 	ps_timeout = wfx_get_ps_timeout(wvif, &ps);
 	if (!ps)
@@ -215,7 +217,8 @@ int wfx_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&wdev->conf_mutex);
 	assign_bit(queue, &wvif->uapsd_mask, params->uapsd);
 	wfx_hif_set_edca_queue_params(wvif, queue, params);
-	if (wvif_to_vif(wvif)->type == NL80211_IFTYPE_STATION && old_uapsd != wvif->uapsd_mask) {
+	if (to_vif(wvif)->type == NL80211_IFTYPE_STATION && 
+	    old_uapsd != wvif->uapsd_mask) {
 		wfx_hif_set_uapsd_info(wvif, wvif->uapsd_mask);
 		wfx_update_pm(wvif);
 	}
@@ -242,20 +245,20 @@ void wfx_event_report_rssi(struct wfx_vif *wvif, u8 raw_rcpi_rssi)
 	int cqm_evt;
 
 	rcpi_rssi = raw_rcpi_rssi / 2 - 110;
-	if (rcpi_rssi <= wvif_to_vif(wvif)->bss_conf.cqm_rssi_thold)
+	if (rcpi_rssi <= to_vif(wvif)->bss_conf.cqm_rssi_thold)
 		cqm_evt = NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
 	else
 		cqm_evt = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
-	ieee80211_cqm_rssi_notify(wvif_to_vif(wvif), cqm_evt, rcpi_rssi, GFP_KERNEL);
+	ieee80211_cqm_rssi_notify(to_vif(wvif), cqm_evt, rcpi_rssi, GFP_KERNEL);
 }
 
 static void wfx_beacon_loss_work(struct work_struct *work)
 {
 	struct wfx_vif *wvif = container_of(to_delayed_work(work), struct wfx_vif,
 					    beacon_loss_work);
-	struct ieee80211_bss_conf *bss_conf = &wvif_to_vif(wvif)->bss_conf;
+	struct ieee80211_bss_conf *bss_conf = &to_vif(wvif)->bss_conf;
 
-	ieee80211_beacon_loss(wvif_to_vif(wvif));
+	ieee80211_beacon_loss(to_vif(wvif));
 	schedule_delayed_work(to_delayed_work(work), msecs_to_jiffies(bss_conf->beacon_int));
 }
 
@@ -323,13 +326,13 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 {
 	struct sk_buff *skb;
 
-	skb = ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vif(wvif));
+	skb = ieee80211_beacon_get(wvif->wdev->hw, to_vif(wvif));
 	if (!skb)
 		return -ENOMEM;
 	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_BCN, API_RATE_INDEX_B_1MBPS);
 	dev_kfree_skb(skb);
 
-	skb = ieee80211_proberesp_get(wvif->wdev->hw, wvif_to_vif(wvif));
+	skb = ieee80211_proberesp_get(wvif->wdev->hw, to_vif(wvif));
 	if (!skb)
 		return -ENOMEM;
 	wfx_hif_set_template_frame(wvif, skb, HIF_TMPLT_PRBRES, API_RATE_INDEX_B_1MBPS);
@@ -339,7 +342,7 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 
 static void wfx_set_mfp_ap(struct wfx_vif *wvif)
 {
-	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, wvif_to_vif(wvif));
+	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, to_vif(wvif));
 	const int ieoffset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
 	const u16 *ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
 						 skb->len - ieoffset);
@@ -389,7 +392,7 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 static void wfx_join(struct wfx_vif *wvif)
 {
 	int ret;
-	struct ieee80211_bss_conf *conf = &wvif_to_vif(wvif)->bss_conf;
+	struct ieee80211_bss_conf *conf = &to_vif(wvif)->bss_conf;
 	struct cfg80211_bss *bss = NULL;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
 	const u8 *ssid_ie = NULL;
@@ -420,7 +423,7 @@ static void wfx_join(struct wfx_vif *wvif)
 	wvif->join_in_progress = true;
 	ret = wfx_hif_join(wvif, conf, wvif->channel, ssid, ssid_len);
 	if (ret) {
-		ieee80211_connection_loss(wvif_to_vif(wvif));
+		ieee80211_connection_loss(to_vif(wvif));
 		wfx_reset(wvif);
 	} else {
 		/* Due to beacon filtering it is possible that the AP's beacon is not known for the
@@ -440,7 +443,7 @@ static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *i
 
 	rcu_read_lock(); /* protect sta */
 	if (info->bssid && !info->ibss_joined)
-		sta = ieee80211_find_sta(wvif_to_vif(wvif), info->bssid);
+		sta = ieee80211_find_sta(to_vif(wvif), info->bssid);
 	if (sta && sta->ht_cap.ht_supported)
 		ampdu_density = sta->ht_cap.ampdu_density;
 	if (sta && sta->ht_cap.ht_supported &&
@@ -565,7 +568,8 @@ static int wfx_update_tim(struct wfx_vif *wvif)
 	u16 tim_offset, tim_length;
 	u8 *tim_ptr;
 
-	skb = ieee80211_beacon_get_tim(wvif->wdev->hw, wvif_to_vif(wvif), &tim_offset, &tim_length);
+	skb = ieee80211_beacon_get_tim(wvif->wdev->hw, to_vif(wvif), 
+				       &tim_offset, &tim_length);
 	if (!skb)
 		return -ENOENT;
 	tim_ptr = skb->data + tim_offset;
-- 
2.25.1

