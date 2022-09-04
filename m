Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4C5AC617
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiIDTZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:25:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5721260
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:25:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l65so6771882pfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=emZNPPVwOPEYtlX5oujYRHUo2IH2LiQXBoAVIF8q5zg=;
        b=kaepJ0W4BxacL0kZ6uRT6GN1grtPahza2D3S0Y9nDBIblRX7LqqRKaCFYX6aX11AjS
         mby8Jh2LEvOln9FNbW7XdBXzqRoUmKVgt9S8l8/32OUuun+mtR/U1mEyqtzIQXZG30pR
         1+2PtRx92nGRi8R7r7RL+hBbMt9auoqtROEAgbe0tuEI0goapEop+zYjM3aejMsrIp07
         msiXjxMVSlgqijzAOQqgLZRb+3omjaI7mMb6qXhzQVWLMGapoqumEJ6d9OgtTQpRhNr1
         dpDtIQqLCB8bgfr5u7jNLH2ULQMMdDnsxF65inL8NX4UgrBBfNSZIOIScTkJbsmkjICz
         yZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=emZNPPVwOPEYtlX5oujYRHUo2IH2LiQXBoAVIF8q5zg=;
        b=oXFvEXTXu24X8IQf90u4WfB5AHPbcwRK6v85/vqapwvG4IyzjjNtOFtyhjOP06sq+f
         G1Iq+2c8mQFsQGkptBOjtuJ/x6CssaZHQ4r6D8RwDZy+qI6Xf80puIyJHYOMSMCGPL9E
         9GmT3c01jOnZHmwedHQ//9b+bYXQwlnLM3lv3uBQCOrDIXy47jJxpH7q9mY4hnt6lENo
         dFug+1LtDNqNpIGQDy7bqiggUTW0iC7cB4BBuhj4dwgSNZnYMITO+XDPSnH1dHzyImIz
         gtCEsTDAQD9RCp8MGSaMMhRofeEPlAhn70tMyfzMnFqhnQLR/lvQWxXrZzcCwugvKBrL
         El6Q==
X-Gm-Message-State: ACgBeo2adq24+V1Vlarz1znL/bxnywvFX147tmWoHbBCJ/pmJsGRxzjw
        ltU9FG2D5yAjLuLs5dA7tCU=
X-Google-Smtp-Source: AA6agR53RUWZD7DU1GRWOn3CBvjcndSAHXe4f89dMVrmtkg2TgC1L7Qo9IicFkuzmTI8p0Cckgih9g==
X-Received: by 2002:aa7:8149:0:b0:536:84bf:69a0 with SMTP id d9-20020aa78149000000b0053684bf69a0mr47231471pfn.85.1662319514634;
        Sun, 04 Sep 2022 12:25:14 -0700 (PDT)
Received: from asif-desktop.domain.name ([122.177.222.82])
        by smtp.gmail.com with ESMTPSA id j23-20020a632317000000b0042bd73400b6sm4968449pgj.87.2022.09.04.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 12:25:14 -0700 (PDT)
From:   Asif Khan <asif.kgauri@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     Asif Khan <asif.kgauri@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix camelcase in UserPriority
Date:   Mon,  5 Sep 2022 00:54:00 +0530
Message-Id: <20220904192400.8309-1-asif.kgauri@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase variable UserPriority with snake case
variable user_priority.

Signed-off-by: Asif Khan <asif.kgauri@gmail.com>
---
 drivers/staging/rtl8712/xmit_linux.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 4a93839bf947..aaabd1189ab0 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -66,16 +66,16 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 {
 	struct ethhdr etherhdr;
 	struct iphdr ip_hdr;
-	u16 UserPriority = 0;
+	u16 user_priority = 0;
 
 	_r8712_open_pktfile(ppktfile->pkt, ppktfile);
 	_r8712_pktfile_read(ppktfile, (unsigned char *)&etherhdr, ETH_HLEN);
 
-	/* get UserPriority from IP hdr*/
+	/* get user_priority from IP hdr*/
 	if (pattrib->ether_type == 0x0800) {
 		_r8712_pktfile_read(ppktfile, (u8 *)&ip_hdr, sizeof(ip_hdr));
-		/*UserPriority = (ntohs(ip_hdr.tos) >> 5) & 0x3 ;*/
-		UserPriority = ip_hdr.tos >> 5;
+		/*user_priority = (ntohs(ip_hdr.tos) >> 5) & 0x3 ;*/
+		user_priority = ip_hdr.tos >> 5;
 	} else {
 		/* "When priority processing of data frames is supported,
 		 * a STA's SME should send EAPOL-Key frames at the highest
@@ -83,9 +83,9 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 		 */
 
 		if (pattrib->ether_type == 0x888e)
-			UserPriority = 7;
+			user_priority = 7;
 	}
-	pattrib->priority = UserPriority;
+	pattrib->priority = user_priority;
 	pattrib->hdrlen = WLAN_HDR_A3_QOS_LEN;
 	pattrib->subtype = WIFI_QOS_DATA_TYPE;
 }
-- 
2.17.1

