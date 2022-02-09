Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322C94AF6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiBIQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiBIQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:39 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C233C05CBA5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so5654095pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgATqU9c1hElp+Wd/gtbcr99xTSxIouLe++OQoZawys=;
        b=LbBAdmqxQGrIHhwPyiZPcCUa9v+KCfzvzxRYxIWNQLtk90sLp5HPW1rbZ3fTnaK0PD
         jJL00j40twvO5u7DEokkXM56xGLUApP3y/ui+i/LRHid8hyfNlMh7UgPtz+BJC7goVDD
         JNu8m5r4mPMWyfFc7d6YemVlXekXfTRETJXehTnQmtflKcVpp3FygNbb4ChqtgSfshvn
         jLMIc1FzrXfcU6SYt+7jtXc6C/REj+RkbRt203rhgNXdP9NhLEZAT9kn2yjlo6egdosJ
         m/woHYjDmMpbNav4OHU/CgrUTet7NUlVlmPupkZqC26XQj8DwGlANGsbby9zji74ZFIT
         NPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgATqU9c1hElp+Wd/gtbcr99xTSxIouLe++OQoZawys=;
        b=YjeI0FSIliZ1rxp7S6rFgOc1bHidYsNzeLtedss7tJdLNb9+v6j6SeMaw1PedFnbzy
         9CqhOFSA1isBzbZi6T/o0lTwRfm677+3P6CPIYGaYY4fyzmSs6fu3sMx3DvAUeh9lqTR
         2czdmPQ4rx3nsufFIRDYtzlDndMepY/3pfuhqS1Zv8uZWRdb8O8cPbcmB1TFR7KJbMwA
         t2eqFGIt1gFKkxfpbiAne3ELtZuWwGMX3kp7LNWQBAjghZa6rv/Q7ViKYH2KAqM5eqzp
         IE+9IpW2jLl670sAGGkNKljCUWGGMmM1BJF0xS1Eijigmeb9Ap6xpLzwAp2UXE2mWGw1
         /5Mg==
X-Gm-Message-State: AOAM5310VXtgEi+7MIITCwbaR17nhcNMRpFaIjPh9AhwEDWpGZTr75tP
        nTStlJUcQguSFQfmHpLVODCY8Kz7seg=
X-Google-Smtp-Source: ABdhPJyeJ1klmNjps3PIopH3mxh7qImtE/5HuoP4T+LudKukmBHOLHxD6VIkFCf9FblvEuptqMzscw==
X-Received: by 2002:a17:90a:670a:: with SMTP id n10mr3361325pjj.123.1644424661930;
        Wed, 09 Feb 2022 08:37:41 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:41 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 5/9] staging: r8188eu: remove empty function __nat25_db_print
Date:   Wed,  9 Feb 2022 22:06:03 +0530
Message-Id: <98d201e029dba9acf707ed020b5a5604029ca710.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

The definition of function __nat25_db_print is empty. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 4951f835feaf..088145118b41 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -319,10 +319,6 @@ static void __nat25_db_network_insert(struct adapter *priv,
 	spin_unlock_bh(&priv->br_ext_lock);
 }
 
-static void __nat25_db_print(struct adapter *priv)
-{
-}
-
 /*
  *	NAT2.5 interface
  */
@@ -422,8 +418,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
 			/* record source IP address and , source mac address into db */
 			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
-
-			__nat25_db_print(priv);
 			return 0;
 		default:
 			return -1;
@@ -454,7 +448,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			sender = (unsigned int *)arp_ptr;
 			__nat25_generate_ipv4_network_addr(networkAddr, sender);
 			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
-			__nat25_db_print(priv);
 			return 0;
 		default:
 			return -1;
@@ -535,8 +528,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
 
-				__nat25_db_print(priv);
-
 				if (!priv->ethBrExtInfo.addPPPoETag &&
 				    priv->pppoe_connection_in_progress &&
 				    !memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
@@ -597,7 +588,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
 				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
-				__nat25_db_print(priv);
 
 				if (iph->nexthdr == IPPROTO_ICMPV6 &&
 						skb->len > (ETH_HLEN +  sizeof(*iph) + 4)) {
-- 
2.34.1

