Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9EE4B0A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiBJKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:05:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiBJKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:05:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA1CE8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d10so13914911eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JK7T5HKrHKZUOdro02ZQzGqvMswyHfWEBNHOhmRPSQ=;
        b=pmvXq3BJq2hVhYICOqiKG5t0x03EfzvXbPXengKa9Ac0DUnaNksno3vhK/J7och+qk
         4zLYg+S0R5s9bWrYd2vFqYNdVYRZRNIkNs9NCwKYz6WLBf/H7rY5dc3Iw4SeS3Z7m3qw
         SfvRcPPNgyHeD7+JKzkNvfZ4q51cEcC26LwceKlZRW3u8dl/nrD2QY7rzrdi9Rl3oh5r
         fH5xNw/jKIg3e7C7hDs50c3BmklB8iU+7FEQ8ZNp8U2Zbeoe2MFaaaSID93xfimWg9y4
         6NLVg92Abg9PS2Lz2y+FrqqynLPW5biLP3p+epS3KrVBPFmdf25SjYOtJ/q8R4SstGRf
         Kgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JK7T5HKrHKZUOdro02ZQzGqvMswyHfWEBNHOhmRPSQ=;
        b=JqCteXetBRcHk9bvSPBY4cyqbu5EDK+aVUpKtsOfi/K8C8Ur/2H/0c4K25xyZRfupm
         ondFBLJ7q/D6n3HA8eEQooWKivdUumujX/o1AZFDmuyEcRBQ/QdMvcl+XAylAW17M3Rb
         m5Tyk7xdkoiV0+R4hR8DiMqZehQdir06MDlr76C5Ny1GgI7CF6NRWFav1BpCCenxVJHA
         HT9mEfvGRwB+SrvTajeTiDjCb8ESLxfgLXTIbq3yQU4Y52WSOOCLM1kgfIzYA3Cu4h1e
         E4Pt+74aEESW4fKq1685YNOJQ5jBPv1JF3d30xYu90fPovTC24LHJmAT+he06eHRIGrT
         6vFA==
X-Gm-Message-State: AOAM5337bri+Yma1dJCt2P1mIQ5M0X10KZNh9jTZwAMVM9eGg8aG3e4+
        Iq5OAR+690WEd3asoo1WXZ8=
X-Google-Smtp-Source: ABdhPJyAhfKBdzJQ85JhtOYEbLmhU31v+er6hVVQ1wn4j3jcynj9k8iTXJhJnJYaaUj8/Zvh3dOyDA==
X-Received: by 2002:a17:906:ce3b:: with SMTP id sd27mr5843486ejb.720.1644487526939;
        Thu, 10 Feb 2022 02:05:26 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id 5sm9729858edx.32.2022.02.10.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:05:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused structs from ieee80211.h
Date:   Thu, 10 Feb 2022 11:05:13 +0100
Message-Id: <20220210100514.8506-2-straube.linux@gmail.com>
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

There are lots of unused strutures in the ieee80211.h header.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 200 --------------------
 1 file changed, 200 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 3a23d5299314..f3b20215ca94 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -182,28 +182,6 @@ struct ieee_param {
 	} u;
 };
 
-struct ieee_param_ex {
-	u32 cmd;
-	u8 sta_addr[ETH_ALEN];
-	u8 data[0];
-};
-
-struct sta_data {
-	u16 aid;
-	u16 capability;
-	int flags;
-	u32 sta_set;
-	u8 tx_supp_rates[16];
-	u32 tx_supp_rates_len;
-	struct ieee80211_ht_cap ht_cap;
-	u64	rx_pkts;
-	u64	rx_bytes;
-	u64	rx_drops;
-	u64	tx_pkts;
-	u64	tx_bytes;
-	u64	tx_drops;
-};
-
 #define IEEE80211_DATA_LEN		2304
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
    6.2.1.1.2.
@@ -219,14 +197,6 @@ struct sta_data {
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31
 
-struct ieee_ibss_seq {
-	u8 mac[ETH_ALEN];
-	u16 seq_num;
-	u16 frag_num;
-	unsigned long packet_time;
-	struct list_head list;
-};
-
 struct rtw_ieee80211_hdr {
 	__le16 frame_ctl;
 	__le16 duration_id;
@@ -246,17 +216,6 @@ struct rtw_ieee80211_hdr_3addr {
 	u16 seq_ctl;
 } __packed;
 
-struct rtw_ieee80211_hdr_qos {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u16 seq_ctl;
-	u8 addr4[ETH_ALEN];
-	u16	qc;
-}  __packed;
-
 struct rtw_ieee80211_hdr_3addr_qos {
 	__le16 frame_ctl;
 	__le16 duration_id;
@@ -267,14 +226,6 @@ struct rtw_ieee80211_hdr_3addr_qos {
 	u16     qc;
 }  __packed;
 
-struct eapol {
-	u8 snap[6];
-	u16 ethertype;
-	u8 version;
-	u8 type;
-	u16 length;
-} __packed;
-
 enum eap_type {
 	EAP_PACKET = 0,
 	EAPOL_START,
@@ -557,83 +508,12 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_NUM_CCK_RATES		4
 #define IEEE80211_OFDM_SHIFT_MASK_A	4
 
-/* NOTE: This data is for statistical purposes; not all hardware provides this
- *       information for frames received.  Not setting these will not cause
- *       any adverse affects. */
-struct ieee80211_rx_stats {
-	/* u32 mac_time[2]; */
-	s8 rssi;
-	u8 signal;
-	u8 noise;
-	u8 received_channel;
-	u16 rate; /* in 100 kbps */
-	/* u8 control; */
-	u8 mask;
-	u8 freq;
-	u16 len;
-};
-
 /* IEEE 802.11 requires that STA supports concurrent reception of at least
  * three fragmented frames. This define can be increased to support more
  * concurrent frames, but it should be noted that each entry can consume about
  * 2 kB of RAM and increasing cache size will slow down frame reassembly. */
 #define IEEE80211_FRAG_CACHE_LEN 4
 
-struct ieee80211_frag_entry {
-	u32 first_frag_time;
-	uint seq;
-	uint last_frag;
-	uint qos;   /* jackson */
-	uint tid;	/* jackson */
-	struct sk_buff *skb;
-	u8 src_addr[ETH_ALEN];
-	u8 dst_addr[ETH_ALEN];
-};
-
-struct ieee80211_stats {
-	uint tx_unicast_frames;
-	uint tx_multicast_frames;
-	uint tx_fragments;
-	uint tx_unicast_octets;
-	uint tx_multicast_octets;
-	uint tx_deferred_transmissions;
-	uint tx_single_retry_frames;
-	uint tx_multiple_retry_frames;
-	uint tx_retry_limit_exceeded;
-	uint tx_discards;
-	uint rx_unicast_frames;
-	uint rx_multicast_frames;
-	uint rx_fragments;
-	uint rx_unicast_octets;
-	uint rx_multicast_octets;
-	uint rx_fcs_errors;
-	uint rx_discards_no_buffer;
-	uint tx_discards_wrong_sa;
-	uint rx_discards_undecryptable;
-	uint rx_message_in_msg_fragments;
-	uint rx_message_in_bad_msg_fragments;
-};
-
-struct ieee80211_softmac_stats {
-	uint rx_ass_ok;
-	uint rx_ass_err;
-	uint rx_probe_rq;
-	uint tx_probe_rs;
-	uint tx_beacons;
-	uint rx_auth_rq;
-	uint rx_auth_rs_ok;
-	uint rx_auth_rs_err;
-	uint tx_auth_rq;
-	uint no_auth_rs;
-	uint no_ass_rs;
-	uint tx_ass_rq;
-	uint rx_ass_rq;
-	uint tx_probe_rq;
-	uint reassoc;
-	uint swtxstop;
-	uint swtxawake;
-};
-
 #define SEC_KEY_1	(1<<0)
 #define SEC_KEY_2	(1<<1)
 #define SEC_KEY_3	(1<<2)
@@ -653,18 +533,6 @@ struct ieee80211_softmac_stats {
 #define WEP_KEYS 4
 #define WEP_KEY_LEN 13
 
-struct ieee80211_security {
-	u16 active_key:2,
-	enabled:1,
-	auth_mode:2,
-	auth_algo:4,
-	unicast_uses_group:1;
-	u8 key_sizes[WEP_KEYS];
-	u8 keys[WEP_KEYS][WEP_KEY_LEN];
-	u8 level;
-	u16 flags;
-} __packed;
-
 /*
 
  802.11 data frame from AP
@@ -680,15 +548,6 @@ Total: 28-2340 bytes
 
 */
 
-struct ieee80211_header_data {
-	u16 frame_ctl;
-	u16 duration_id;
-	u8 addr1[6];
-	u8 addr2[6];
-	u8 addr3[6];
-	u16 seq_ctrl;
-};
-
 #define BEACON_PROBE_SSID_ID_POSITION 12
 
 /* Management Frame Information Element Types */
@@ -705,17 +564,6 @@ struct ieee80211_header_data {
 #define MFIE_TYPE_RATES_EX	50
 #define MFIE_TYPE_GENERIC	221
 
-struct ieee80211_info_element_hdr {
-	u8 id;
-	u8 len;
-} __packed;
-
-struct ieee80211_info_element {
-	u8 id;
-	u8 len;
-	u8 data[0];
-} __packed;
-
 /*
  * These are the data types that can make up management packets
  *
@@ -736,49 +584,6 @@ struct ieee80211_info_element {
 #define IEEE80211_DEFAULT_TX_ESSID "Penguin"
 #define IEEE80211_DEFAULT_BASIC_RATE 10
 
-struct ieee80211_authentication {
-	struct ieee80211_header_data header;
-	u16 algorithm;
-	u16 transaction;
-	u16 status;
-	/* struct ieee80211_info_element_hdr info_element; */
-} __packed;
-
-struct ieee80211_probe_response {
-	struct ieee80211_header_data header;
-	u32 time_stamp[2];
-	u16 beacon_interval;
-	u16 capability;
-	struct ieee80211_info_element info_element;
-} __packed;
-
-struct ieee80211_probe_request {
-	struct ieee80211_header_data header;
-} __packed;
-
-struct ieee80211_assoc_request_frame {
-	struct rtw_ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 listen_interval;
-	struct ieee80211_info_element_hdr info_element;
-} __packed;
-
-struct ieee80211_assoc_response_frame {
-	struct rtw_ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 status;
-	u16 aid;
-} __packed;
-
-struct ieee80211_txb {
-	u8 nr_frags;
-	u8 encrypted;
-	u16 reserved;
-	u16 frag_size;
-	u16 payload_size;
-	struct sk_buff *fragments[0];
-};
-
 /* SWEEP TABLE ENTRIES NUMBER*/
 #define MAX_SWEEP_TAB_ENTRIES		  42
 #define MAX_SWEEP_TAB_ENTRIES_PER_PACKET  7
@@ -876,11 +681,6 @@ static inline int is_broadcast_mac_addr(const u8 *addr)
 #define CFG_IEEE80211_RESERVE_FCS (1<<0)
 #define CFG_IEEE80211_COMPUTE_FCS (1<<1)
 
-struct tx_pending {
-	int frag;
-	struct ieee80211_txb *txb;
-};
-
 #define MAXTID	16
 
 #define IEEE_A	    (1<<0)
-- 
2.35.1

