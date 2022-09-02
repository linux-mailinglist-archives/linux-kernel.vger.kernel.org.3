Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09D5AABE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiIBJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiIBJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537783047
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w2so2032092edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XpHH42SQLJDVes7ZZ1hXimWD0tWN6qFGRFQjolXplgk=;
        b=p2HZ+y3PZt8dbds1f3sAYhlZgc6o0fIxKkgVd5OdusQC8+2V6emYxX4kaoXmhyfW26
         z+2DqwS2uvTawWnsfIgWB4bB9ZPNyDY9PkhBEf9w+old+3r4vcrTpAtH3EAuGLMU63On
         u/yI8+4W2NtvlZBElgO1Tf8oBW6h9dACoJOj1dahexueIY3OjKoLoiNVNMWEOe3YI8Rf
         N/9EnEAqDm33Ka6CvqXDjtTeoTc7f4gdZcrod4TzB/528ruAFKUPoe9f1UheR1IH1PA1
         pX5eEw4uCtUB9+m4mOvXnPNj5uJOfY/PEHHPDgQ87VAWzjqnqPNPdtQA8X25PoZp/Owq
         pwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XpHH42SQLJDVes7ZZ1hXimWD0tWN6qFGRFQjolXplgk=;
        b=BM4YI+a7S8un2Afq8FqWW/aUtRI8FC6h9lgd67ahxCThmzfkSv3SKP6SpM79UHyuEn
         1iWzOvaqCHgutqfdZsmPk7+b8pyuDDa+awk2NSUa7QBpCJtlFwEg7rmYurIHl+wB2ifo
         n5FIxg1hDDATzCHEnm6ZDoL/flVIQ+u0xNesYbQWOewa80vQ0QbBGET/Iu4L9YFDmsh0
         607NaeMU5/m5iiAp9RV18ZE/CcgZHNTimsidWY7BbUUoV0wM1Vp/hXeUeVNedNpYtNKi
         V81KWfoDvMgML5uyy/hu5gBnRCTJhb5ucMV1sIr87fr6TrR2sZx79VmdBQox7vjKeMpp
         Mvyg==
X-Gm-Message-State: ACgBeo0wekJq6J0Kopl15vAMwXJG2QaR8jtDgr5ztpgt7hNRE64MHRx6
        /E1jvNUZPeFI+3ur0GVlyJI=
X-Google-Smtp-Source: AA6agR7n1eVccxBiIatilAWpw3BtoSPNWeTYij8m1vB+lPsqVlB9a+PqrG7YqmxistKcFn42Mlnl2g==
X-Received: by 2002:a05:6402:550c:b0:443:7d15:d57f with SMTP id fi12-20020a056402550c00b004437d15d57fmr32044758edb.147.1662112358353;
        Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 06/10] staging: rtl8723bs: remove GetHexValueFromString
Date:   Fri,  2 Sep 2022 11:51:56 +0200
Message-Id: <74c77a5d86570065a5fe96446063595b649f76b0.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Remove function GetHexValueFromString because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 45 ---------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  2 -
 2 files changed, 47 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 1c744d0b4742..010a097c3afd 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -894,51 +894,6 @@ u32 MapCharToHexDigit(char chTmp)
 		return 0;
 }
 
-
-
-/* 	Description: */
-/* 		Parse hex number from the string pucStr. */
-bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
-{
-	char *szScan = szStr;
-
-	/*  Check input parameter. */
-	if (!szStr || !pu4bVal || !pu4bMove)
-		return false;
-
-	/*  Initialize output. */
-	*pu4bMove = 0;
-	*pu4bVal = 0;
-
-	/*  Skip leading space. */
-	while (*szScan != '\0' && (*szScan == ' ' || *szScan == '\t')) {
-		szScan++;
-		(*pu4bMove)++;
-	}
-
-	/*  Skip leading '0x' or '0X'. */
-	if (*szScan == '0' && (*(szScan+1) == 'x' || *(szScan+1) == 'X')) {
-		szScan += 2;
-		(*pu4bMove) += 2;
-	}
-
-	/*  Check if szScan is now pointer to a character for hex digit, */
-	/*  if not, it means this is not a valid hex number. */
-	if (!IsHexDigit(*szScan))
-		return false;
-
-	/*  Parse each digit. */
-	do {
-		(*pu4bVal) <<= 4;
-		*pu4bVal += MapCharToHexDigit(*szScan);
-
-		szScan++;
-		(*pu4bMove)++;
-	} while (IsHexDigit(*szScan));
-
-	return true;
-}
-
 bool GetU1ByteIntegerFromStringInDecimal(char *Str, u8 *pInt)
 {
 	u16 i = 0;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 406fccbcd4b6..76ad979c2a36 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -151,8 +151,6 @@ bool IsHexDigit(char chTmp);
 
 u32 MapCharToHexDigit(char chTmp);
 
-bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove);
-
 bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
 			  char RightQualifier);
 
-- 
2.25.1

