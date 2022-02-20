Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339714BD122
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiBTTxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:53:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiBTTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:53:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A232EEF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:53:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so27685619ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl57BXl7orHCcHPv9ogsAWm6LF/HEJi7j880PG+4sRA=;
        b=bfaxEUhyUjiEXwLtFX6OYBBIcsUExu30bTZ5cppw6/j93GmqIksSbMNV4KQTEI2ui0
         1Vpu/bYBiNzSucxeUIK5AWf/GJVjYzBZ3j/lEK3WMv8SmGcqykYKWQ0tlt+kzkA5MRi3
         9dFieMEgmD7c9jnHq6MKnr99hCZtJikTFvpDdnGEVm4Q2MQXd6g02mGV3DQaPsJ05q+p
         d6BS12K7JB+3vpXUEDzxEvkr8VpQSjKNI+MALf3EubkynCg6RQMf7qFZgQzDg9VXRMyN
         V1hdjSDza7aGw+Mr/khEmafxL4EKQM9Da5USY5X2RA7iptDfEU306kwTQ9fygdrkCX+w
         uMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl57BXl7orHCcHPv9ogsAWm6LF/HEJi7j880PG+4sRA=;
        b=CqDHHc/pbi44LlHynLiyUV4jMTDyAXrBJ4Rvk3iIviTvyk3iweR2Y6vKDJfhER0nRQ
         vMynzO2Hml9rZllMu1tFEU36WTFNFKbkcs4Qf0MB8E4rc6JgvO0q+ty+T95gZSYxXHSD
         0m/p12zlU9yFzRbxSyEnt6yxPjb5H3+L//YMSqI2tcn2EB/6tyyCUIt2AYxU5uU/nobf
         9uvEtjEjjYfhQDufHMbKCTlW+pHkdRaMuTAhUX+R4x0wu9mTW0rpo1AGNRsxSGd+wtZZ
         eZJhVdhXnlY1lTEW9OHCKZxrDy5HERFHq+22kXfWP/kjTDLJNBbWpvJT2J6c7KvT0Rfj
         TB/A==
X-Gm-Message-State: AOAM532o0NuFhMVPiPXDTp9ZlreU2VnsD6aeQOLsudZvbe/AkNasb6yU
        RdRIYHB761o4vL9ihQlLs8Y=
X-Google-Smtp-Source: ABdhPJzFhizMQQa+ftBaImnNARM3MJ5TOfkJTUFMQ/5KsYucLYQiKXk1Eykp3WLXB7Q3jIBRNJdrSg==
X-Received: by 2002:a17:906:a4b:b0:6d0:fbdd:7cb5 with SMTP id x11-20020a1709060a4b00b006d0fbdd7cb5mr6000655ejf.152.1645386787233;
        Sun, 20 Feb 2022 11:53:07 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id l6sm4354376ejz.189.2022.02.20.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:53:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused macros from rtw_security.h
Date:   Sun, 20 Feb 2022 20:52:53 +0100
Message-Id: <20220220195254.11759-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220195254.11759-1-straube.linux@gmail.com>
References: <20220220195254.11759-1-straube.linux@gmail.com>
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

There are lots of unused macros in the rtw_security.h header.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/rtw_security.h    | 98 -------------------
 1 file changed, 98 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 9231201f1009..94729ff2daac 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -14,18 +14,11 @@
 #define _TKIP_WTMIC_			0x3
 #define _AES_				0x4
 #define _WEP104_			0x5
-#define _WEP_WPA_MIXED_			0x07  /*  WEP + WPA */
 #define _SMS4_				0x06
 
-#define is_wep_enc(alg) (((alg) == _WEP40_) || ((alg) == _WEP104_))
-
 #define _WPA_IE_ID_	0xdd
 #define _WPA2_IE_ID_	0x30
 
-#define SHA256_MAC_LEN 32
-#define AES_BLOCK_SIZE 16
-#define AES_PRIV_SIZE (4 * 44)
-
 enum {
 	ENCRYP_PROTOCOL_OPENSYS,   /* open system */
 	ENCRYP_PROTOCOL_WEP,       /* WEP */
@@ -236,97 +229,6 @@ extern const u32 rcon[10];
 extern const u8 Td4s[256];
 extern const u8 rcons[10];
 
-#define RCON(i) (rcons[(i)] << 24)
-
-static inline u32 rotr(u32 val, int bits)
-{
-	return (val >> bits) | (val << (32 - bits));
-}
-
-#define TE0(i) Te0[((i) >> 24) & 0xff]
-#define TE1(i) rotr(Te0[((i) >> 16) & 0xff], 8)
-#define TE2(i) rotr(Te0[((i) >> 8) & 0xff], 16)
-#define TE3(i) rotr(Te0[(i) & 0xff], 24)
-#define TE41(i) ((Te0[((i) >> 24) & 0xff] << 8) & 0xff000000)
-#define TE42(i) (Te0[((i) >> 16) & 0xff] & 0x00ff0000)
-#define TE43(i) (Te0[((i) >> 8) & 0xff] & 0x0000ff00)
-#define TE44(i) ((Te0[(i) & 0xff] >> 8) & 0x000000ff)
-#define TE421(i) ((Te0[((i) >> 16) & 0xff] << 8) & 0xff000000)
-#define TE432(i) (Te0[((i) >> 8) & 0xff] & 0x00ff0000)
-#define TE443(i) (Te0[(i) & 0xff] & 0x0000ff00)
-#define TE414(i) ((Te0[((i) >> 24) & 0xff] >> 8) & 0x000000ff)
-#define TE4(i) ((Te0[(i)] >> 8) & 0x000000ff)
-
-#define TD0(i) Td0[((i) >> 24) & 0xff]
-#define TD1(i) rotr(Td0[((i) >> 16) & 0xff], 8)
-#define TD2(i) rotr(Td0[((i) >> 8) & 0xff], 16)
-#define TD3(i) rotr(Td0[(i) & 0xff], 24)
-#define TD41(i) (Td4s[((i) >> 24) & 0xff] << 24)
-#define TD42(i) (Td4s[((i) >> 16) & 0xff] << 16)
-#define TD43(i) (Td4s[((i) >> 8) & 0xff] << 8)
-#define TD44(i) (Td4s[(i) & 0xff])
-#define TD0_(i) Td0[(i) & 0xff]
-#define TD1_(i) rotr(Td0[(i) & 0xff], 8)
-#define TD2_(i) rotr(Td0[(i) & 0xff], 16)
-#define TD3_(i) rotr(Td0[(i) & 0xff], 24)
-
-#define GETU32(pt) (((u32)(pt)[0] << 24) ^ ((u32)(pt)[1] << 16) ^ \
-			((u32)(pt)[2] <<  8) ^ ((u32)(pt)[3]))
-
-#define PUTU32(ct, st) { \
-(ct)[0] = (u8)((st) >> 24); (ct)[1] = (u8)((st) >> 16); \
-(ct)[2] = (u8)((st) >>  8); (ct)[3] = (u8)(st); }
-
-#define WPA_GET_BE32(a) ((((u32)(a)[0]) << 24) | (((u32)(a)[1]) << 16) | \
-			 (((u32)(a)[2]) << 8) | ((u32)(a)[3]))
-
-#define WPA_PUT_LE16(a, val)			\
-	do {					\
-		(a)[1] = ((u16)(val)) >> 8;	\
-		(a)[0] = ((u16)(val)) & 0xff;	\
-	} while (0)
-
-#define WPA_PUT_BE32(a, val)					\
-	do {							\
-		(a)[0] = (u8)((((u32)(val)) >> 24) & 0xff);	\
-		(a)[1] = (u8)((((u32)(val)) >> 16) & 0xff);	\
-		(a)[2] = (u8)((((u32)(val)) >> 8) & 0xff);	\
-		(a)[3] = (u8)(((u32)(val)) & 0xff);		\
-	} while (0)
-
-#define WPA_PUT_BE64(a, val)				\
-	do {						\
-		(a)[0] = (u8)(((u64)(val)) >> 56);	\
-		(a)[1] = (u8)(((u64)(val)) >> 48);	\
-		(a)[2] = (u8)(((u64)(val)) >> 40);	\
-		(a)[3] = (u8)(((u64)(val)) >> 32);	\
-		(a)[4] = (u8)(((u64)(val)) >> 24);	\
-		(a)[5] = (u8)(((u64)(val)) >> 16);	\
-		(a)[6] = (u8)(((u64)(val)) >> 8);	\
-		(a)[7] = (u8)(((u64)(val)) & 0xff);	\
-	} while (0)
-
-/* ===== start - public domain SHA256 implementation ===== */
-
-/* This is based on SHA256 implementation in LibTomCrypt that was released into
- * public domain by Tom St Denis. */
-
-/* Various logical functions */
-#define RORc(x, y) \
-	(((((unsigned long)(x) & 0xFFFFFFFFUL) >> (unsigned long)((y)&31)) | \
-	 ((unsigned long)(x) << (unsigned long)(32-((y)&31)))) & 0xFFFFFFFFUL)
-#define Ch(x, y ,z)       (z ^ (x & (y ^ z)))
-#define Maj(x, y, z)      (((x | y) & z) | (x & y))
-#define S(x, n)         RORc((x), (n))
-#define R(x, n)         (((x)&0xFFFFFFFFUL)>>(n))
-#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
-#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
-#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
-#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
-#ifndef MIN
-#define MIN(x, y) (((x) < (y)) ? (x) : (y))
-#endif
-
 void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
 void rtw_secmicappendbyte(struct mic_data *pmicdata, u8 b);
 void rtw_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
-- 
2.35.1

