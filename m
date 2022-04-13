Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7065F4FEEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiDMFsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiDMFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:48:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699547040
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:46:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t12so1048749pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xNLSOEaEw7kf6bfeQjVyXkvE7jCgutmejEXvvU8XWSo=;
        b=OtDlIGYH3h0B9BRwbrV57CbPXN/vz7g6l0ySDeRFpUDbL5cQgEdhgymu21e5aKKHhj
         fVjTUTVQCknhXOCnxmPn2+aId7q2nddEa4Z7h1GpwU3RXzvPD4YuBE1SH6o1CY7xyNM7
         dO27XZzDcTsjwbZLZrs7GJAWANR/oSFLSAl15GsSIIxDrthvvBCu8gOWHIk7zJPPqeCN
         xgQPh2pQbJi6d3HkQcuS1ace8umFGT4IH5R4VNLo3XcqYlsJgwOvSwdztWToA9K/h5Hw
         2f4Db6tZwj1ErdKtIgjY8PbHY45Fdf3FDURF+uuXI89MFsRm83xrVmu7O29DRM6MQUOJ
         Ko9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNLSOEaEw7kf6bfeQjVyXkvE7jCgutmejEXvvU8XWSo=;
        b=5tHqmLn55zZGfITu6XlOomnTXMh6Dmi1LbckjwDT3Niri4WiWyP+LBD06rcW9NYLoV
         NLLJLKuZ3o4T5COZKavzke1Go3Cxy+KmwIF46DZzib5pVSKRxQezB6BCE6kZbt4aswwv
         XScWcWL5dHrhsTcn0wS4OIswzX1hRuk2/nepO7+jpJbU3ChB+J59Umk6DblMFlO+3Qdz
         7HHmIq6WZergyxDxaNmyT5qQeErAgqI8ZkOpG7WtDXyiQv0/srUi4770ED0dG+dGziC0
         952Ro08NJ5z3svUTrJEp/xdO8ljciiqwU86NdYzkyJAgPfwuZQn0jCBTvTBQQMsP3XEw
         hIBg==
X-Gm-Message-State: AOAM532/eWmFvEVKDgFTK+Qv3Yd2gbI88ZmGlnZn6DZvoS0FhxY8Ywxn
        MSKBabHmwKdL7jE+BFC3Dos+iw8ekrbs3DxF6h8=
X-Google-Smtp-Source: ABdhPJygW9JmRlMvLKBvGYQM+2FqU8G7dLTa/jwfWebLyGBNQGa8Xir5KRKYS3gHJrn/NhZtPkF/Lw==
X-Received: by 2002:a17:90b:4f82:b0:1cd:328f:9cd with SMTP id qe2-20020a17090b4f8200b001cd328f09cdmr6152887pjb.38.1649828771166;
        Tue, 12 Apr 2022 22:46:11 -0700 (PDT)
Received: from mahak-Inspiron-7570.iitr.ac.in ([103.37.201.168])
        by smtp.googlemail.com with ESMTPSA id g15-20020a056a000b8f00b004fa9dbf27desm41365867pfj.55.2022.04.12.22.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:46:10 -0700 (PDT)
From:   Mahak Gupta <mahak_g@cs.iitr.ac.in>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
Subject: [PATCH] staging: r8188eu: add space around operators
Date:   Wed, 13 Apr 2022 11:15:17 +0530
Message-Id: <20220413054517.6343-1-mahak_g@cs.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style.

Reported by checkpatch:

spaces preferred around that '{operator}'.

Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 58 +++++++++++------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 15332f9d6fe3..e1b3e9d5250b 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -87,19 +87,19 @@ static int skb_pull_and_merge(struct sk_buff *skb, unsigned char *src, int len)
 	int tail_len;
 	unsigned long end, tail;
 
-	if ((src+len) > skb_tail_pointer(skb) || skb->len < len)
+	if ((src + len) > skb_tail_pointer(skb) || skb->len < len)
 		return -1;
 
 	tail = (unsigned long)skb_tail_pointer(skb);
-	end = (unsigned long)src+len;
+	end = (unsigned long)src + len;
 	if (tail < end)
 		return -1;
 
-	tail_len = (int)(tail-end);
+	tail_len = (int)(tail - end);
 	if (tail_len > 0)
-		memmove(src, src+len, tail_len);
+		memmove(src, src + len, tail_len);
 
-	skb_trim(skb, skb->len-len);
+	skb_trim(skb, skb->len - len);
 	return 0;
 }
 
@@ -117,7 +117,7 @@ static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPV4;
-	memcpy(networkAddr+7, (unsigned char *)ipAddr, 4);
+	memcpy(networkAddr + 7, (unsigned char *)ipAddr, 4);
 }
 
 static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
@@ -126,8 +126,8 @@ static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_PPPOE;
-	memcpy(networkAddr+1, (unsigned char *)sid, 2);
-	memcpy(networkAddr+3, (unsigned char *)ac_mac, 6);
+	memcpy(networkAddr + 1, (unsigned char *)sid, 2);
+	memcpy(networkAddr + 3, (unsigned char *)ac_mac, 6);
 }
 
 static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
@@ -136,17 +136,17 @@ static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPV6;
-	memcpy(networkAddr+1, (unsigned char *)ipAddr, 16);
+	memcpy(networkAddr + 1, (unsigned char *)ipAddr, 16);
 }
 
 static unsigned char *scan_tlv(unsigned char *data, int len, unsigned char tag, unsigned char len8b)
 {
 	while (len > 0) {
-		if (*data == tag && *(data+1) == len8b && len >= len8b*8)
-			return data+2;
+		if (*data == tag && *(data + 1) == len8b && len >= len8b * 8)
+			return data + 2;
 
-		len -= (*(data+1))*8;
-		data += (*(data+1))*8;
+		len -= (*(data + 1)) * 8;
+		data += (*(data + 1)) * 8;
 	}
 	return NULL;
 }
@@ -158,7 +158,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 
 	if (icmphdr->icmp6_type == NDISC_ROUTER_SOLICITATION) {
 		if (len >= 8) {
-			mac = scan_tlv(&data[8], len-8, 1, 1);
+			mac = scan_tlv(&data[8], len - 8, 1, 1);
 			if (mac) {
 				memcpy(mac, replace_mac, 6);
 				return 1;
@@ -166,7 +166,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_ROUTER_ADVERTISEMENT) {
 		if (len >= 16) {
-			mac = scan_tlv(&data[16], len-16, 1, 1);
+			mac = scan_tlv(&data[16], len - 16, 1, 1);
 			if (mac) {
 				memcpy(mac, replace_mac, 6);
 				return 1;
@@ -174,7 +174,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) {
 		if (len >= 24) {
-			mac = scan_tlv(&data[24], len-24, 1, 1);
+			mac = scan_tlv(&data[24], len - 24, 1, 1);
 			if (mac) {
 				memcpy(mac, replace_mac, 6);
 				return 1;
@@ -182,7 +182,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
 		if (len >= 24) {
-			mac = scan_tlv(&data[24], len-24, 2, 1);
+			mac = scan_tlv(&data[24], len - 24, 2, 1);
 			if (mac) {
 				memcpy(mac, replace_mac, 6);
 				return 1;
@@ -190,7 +190,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_REDIRECT) {
 		if (len >= 40) {
-			mac = scan_tlv(&data[40], len-40, 2, 1);
+			mac = scan_tlv(&data[40], len - 40, 2, 1);
 			if (mac) {
 				memcpy(mac, replace_mac, 6);
 				return 1;
@@ -397,7 +397,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			tmp = be32_to_cpu(iph->saddr);
 			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
 			/* record source IP address and , source mac address into db */
-			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 			return 0;
 		default:
 			return -1;
@@ -422,7 +422,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			arp_ptr += arp->ar_hln;
 			sender = (unsigned int *)arp_ptr;
 			__nat25_generate_ipv4_network_addr(networkAddr, sender);
-			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 			return 0;
 		default:
 			return -1;
@@ -459,22 +459,22 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 							    sizeof(tag_buf))
 								return -1;
 
-							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
+							memcpy(tag->tag_data + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN,
 								pOldTag->tag_data, old_tag_len);
 
-							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0)
+							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN + old_tag_len) < 0)
 								return -1;
 
-							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
+							ph->length = htons(ntohs(ph->length) - TAG_HDR_LEN - old_tag_len);
 						}
 
 						tag->tag_type = PTT_RELAY_SID;
-						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
+						tag->tag_len = htons(MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN + old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
 						pMagic = (__be16 *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
-						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
+						memcpy(tag->tag_data + MAGIC_CODE_LEN, skb->data + ETH_ALEN, ETH_ALEN);
 
 						/* Add relay tag */
 						if (__nat25_add_pppoe_tag(skb, tag) < 0)
@@ -487,7 +487,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 							return -2;
 
 						if (priv->pppoe_connection_in_progress == 0)
-							memcpy(priv->pppoe_addr, skb->data+ETH_ALEN, ETH_ALEN);
+							memcpy(priv->pppoe_addr, skb->data + ETH_ALEN, ETH_ALEN);
 
 						priv->pppoe_connection_in_progress = WAIT_TIME_PPPOE;
 					}
@@ -497,11 +497,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			} else {	/*  session phase */
 				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
 
-				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 
 				if (!priv->ethBrExtInfo.addPPPoETag &&
 				    priv->pppoe_connection_in_progress &&
-				    !memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
+				    !memcmp(skb->data + ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
 					priv->pppoe_connection_in_progress = 0;
 			}
 			return 0;
@@ -549,7 +549,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		case NAT25_INSERT:
 			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
 				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
-				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 
 				if (iph->nexthdr == IPPROTO_ICMPV6 &&
 						skb->len > (ETH_HLEN +  sizeof(*iph) + 4)) {
-- 
2.17.1

