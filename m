Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9624EDA31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiCaNHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiCaNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BC49252
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so48055947ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLM8ocKt6f0arebieMXLbfikbZM3siH2fLv2W59ipRg=;
        b=GPYA80S5QnuytLdzBu2lKmTT4pttp+NDMO26zncwgWjfyTTSEE0CmyiOb3xx6xTzGJ
         4c6Vhz9iYrJgMYSxW6ZxJxyPo7KS+MoV+BD6TvGVU9GU0rWrhlfCR5ac1eupmJAaoPn+
         b9rWtDUypN8Kv5YWWYUm/hfBLHK4z1wt3lh+SgHiXyBUleZSm280/QZ+DrQG9VSROu9o
         +F+w+oAwV/DlmjW5if8ZPXJYQAoSqy97PgdjH/TAlqTAie5pJsK+c7Giqm5eWrAOPozZ
         LMNCeWCu0isId2APvA/BnHca1f7ZtqVtTZDNWv/ZK2Dfnkk4+8eLuxR1j2XghtXQ8IhO
         FgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLM8ocKt6f0arebieMXLbfikbZM3siH2fLv2W59ipRg=;
        b=caP04sE7kK2dckZEXlMbsIj3cweZr485ct7xWsnIjhTwPqZjg5MkxT/PT3SflpcpSL
         tIKeVa3jTBsNELFmc0+YEoEkfA5km1CD28C4PIHXIEGIVZ1eSA55LuX3+M/DCMQVDtyF
         77XfhcS9xdaBd4hlKZAmtBaLY/ET0H3r4n9pijUY/n0V1snjwmN7wcTYxQU5TFqaq9ai
         A7gDolWCEyqpNhOWcom4B+NzF1kAbkV8pL1GJQIk7BMLjOTABqcjmrbhbvq5yb1WXO6m
         zJv+4nAu1HOuOXqN34zaFpUXjdia+X9FHDYqVPqUG+Ijha3Z2+Dxzvwgh+AmobVxB0Pu
         Gx0g==
X-Gm-Message-State: AOAM530/WOgLATLzvZAr6PDCnWg2oj0IDwDPWTt/ESdeJIlLWC9DZ0gG
        MrYxZxUTFLfPePurtQIeGKE=
X-Google-Smtp-Source: ABdhPJySxYC9VY6GU3cnheaUqRUTgTRtIMdM3cjme2J0sjJokpLC7EyjcXJpEn5RcJALk3PCjETRFA==
X-Received: by 2002:a17:906:1645:b0:6ce:de9:6eb1 with SMTP id n5-20020a170906164500b006ce0de96eb1mr4972136ejd.616.1648731929952;
        Thu, 31 Mar 2022 06:05:29 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: rename clear_bacon_valid_bit()
Date:   Thu, 31 Mar 2022 15:05:18 +0200
Message-Id: <20220331130522.6648-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
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

Rename clear_bacon_valid_bit(). Actually it should be
clear_beacon_valid_bit().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 4 ++--
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 643f9f8a7a3d..15a91c5fc852 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5761,7 +5761,7 @@ unsigned int send_beacon(struct adapter *padapter)
 
 	u32 start = jiffies;
 
-	clear_bacon_valid_bit(padapter);
+	clear_beacon_valid_bit(padapter);
 
 	do {
 		issue_beacon(padapter, 100);
@@ -5784,7 +5784,7 @@ unsigned int send_beacon(struct adapter *padapter)
 	}
 }
 
-void clear_bacon_valid_bit(struct adapter *adapter)
+void clear_beacon_valid_bit(struct adapter *adapter)
 {
 	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
 	rtw_write8(adapter, REG_TDECTRL + 2, rtw_read8(adapter, REG_TDECTRL + 2) | BIT(0));
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index a7337954891a..2e252562e48c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -557,7 +557,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
 		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
-		clear_bacon_valid_bit(adapt);
+		clear_beacon_valid_bit(adapt);
 		DLBcnCount = 0;
 		poll = 0;
 		do {
@@ -596,7 +596,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 		/*  Update RSVD page location H2C to Fw. */
 		if (bcn_valid)
-			clear_bacon_valid_bit(adapt);
+			clear_beacon_valid_bit(adapt);
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 66f7361e7a19..a00da19c4b88 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -538,7 +538,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 		     unsigned char action, unsigned short status);
 unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
 unsigned int send_beacon(struct adapter *padapter);
-void clear_bacon_valid_bit(struct adapter *adapter);
+void clear_beacon_valid_bit(struct adapter *adapter);
 
 void start_clnt_assoc(struct adapter *padapter);
 void start_clnt_auth(struct adapter *padapter);
-- 
2.35.1

