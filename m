Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFE599D33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349456AbiHSNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349434AbiHSNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410BFBA75
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dc19so8877743ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KwKZVOZR3GJHc3jlnF0u1iBjRpLe4GFgoYhD+Ro9tFA=;
        b=qvwHqZDuCH3HHIURyEz05igIa18oM7ehQYcNDGhDjBnu2o78KwDvvRYRua5zr+fUg6
         7iBSWZWSkqJE/oT7oe9y8ghNKySlQuhVKbW6uZh5f1WbhvcbEREvXUsHI5/0qsgARJBr
         +THBUXtYdFRxRDzy9xcV+uerLfHezJGy/iVSCQnd5UlDMDTScst3ooosIuRcrdFGbW36
         wFHeF87QFrI+FrYaSAWmR2j8rvmqANQR58WjpAxK7onpqZ29Yk9P/BvPJ1tKurm7rILe
         A0EfgBXikiN5MLlIakkiKmQWtgo/i8P/tVj+FUjI/T/skZVbIWyHr7qx/axOQcdMV0Vt
         dN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KwKZVOZR3GJHc3jlnF0u1iBjRpLe4GFgoYhD+Ro9tFA=;
        b=V7ybfxzGao18M/bNiu1FUJwlnw2KlzwCLJivnDElF/UTyjr/nZYtsP3trurWb8tm4l
         Gq/y7iPtEVXTJQOAVpxhsFzrCmxGIG/cKbaUGdY+pJC17CDymlKuKZ8ZiXBdq9UQB8kE
         X6gd8Y68408oz5EFpkDTFvY7Cb1SKLaiIECxwul9F3Lj+NQ/NA0cYdy5NeG8K3cVB3ZX
         S+Ahz2o75AhLy+dVAlE+7CkkxH/P1TIVV/4Ee3AMClsGomI4vcveqmdRIB2TnYGIQo0Y
         eXFvK/7Z8UGd0QThDwvEs2xhMYYAQw6n3T2MVxFjbs8mMw/FrdDJuMJP2R1G/pLl3+qT
         tlJA==
X-Gm-Message-State: ACgBeo0LRNIOjQ6VVwyWl7SVFGLTmOubli3bwI/1hZ7aqHj3Jr5n0m4X
        sGgRfNNlIJi/bnGjwowtAfPXDIYPvO1+OA==
X-Google-Smtp-Source: AA6agR6X70+haqMOdyzzoiDa9ElTXs1E9C9YBlRkhohwg1DM7BLRO5YcVPaWOiwpytCK99Dyp6Rpew==
X-Received: by 2002:a17:907:9493:b0:73b:e605:f3b with SMTP id dm19-20020a170907949300b0073be6050f3bmr4600437ejc.37.1660917030806;
        Fri, 19 Aug 2022 06:50:30 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:30 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 4/8] staging: rtl8723bs: remove function GetFractionValueFromString
Date:   Fri, 19 Aug 2022 15:49:38 +0200
Message-Id: <e782bcd3ff8c33df8da7eb6b8e4bb00b1c270edc.1660916523.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660916523.git.namcaov@gmail.com>
References: <cover.1660916523.git.namcaov@gmail.com>
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

because this function is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 43 ---------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  3 --
 2 files changed, 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 909b37bcc897..f82cbe5a77ff 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -939,49 +939,6 @@ bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
 	return true;
 }
 
-bool GetFractionValueFromString(
-	char *szStr, u8 *pInteger, u8 *pFraction, u32 *pu4bMove
-)
-{
-	char *szScan = szStr;
-
-	/*  Initialize output. */
-	*pu4bMove = 0;
-	*pInteger = 0;
-	*pFraction = 0;
-
-	/*  Skip leading space. */
-	while (*szScan != '\0' &&	(*szScan == ' ' || *szScan == '\t')) {
-		++szScan;
-		++(*pu4bMove);
-	}
-
-	/*  Parse each digit. */
-	do {
-		(*pInteger) *= 10;
-		*pInteger += (*szScan - '0');
-
-		++szScan;
-		++(*pu4bMove);
-
-		if (*szScan == '.') {
-			++szScan;
-			++(*pu4bMove);
-
-			if (*szScan < '0' || *szScan > '9')
-				return false;
-			else {
-				*pFraction = *szScan - '0';
-				++szScan;
-				++(*pu4bMove);
-				return true;
-			}
-		}
-	} while (*szScan >= '0' && *szScan <= '9');
-
-	return true;
-}
-
 /*  */
 /* 	Description: */
 /* 		Return true if szStr is comment out with leading "//". */
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 7be0ea20bca4..b49b0a0355c6 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -153,9 +153,6 @@ u32 MapCharToHexDigit(char chTmp);
 
 bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove);
 
-bool GetFractionValueFromString(char *szStr, u8 *pInteger, u8 *pFraction,
-				u32 *pu4bMove);
-
 bool IsCommentString(char *szStr);
 
 bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
-- 
2.25.1

