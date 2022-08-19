Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF959984B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbiHSIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347733AbiHSIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA047755A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z2so4863235edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KwKZVOZR3GJHc3jlnF0u1iBjRpLe4GFgoYhD+Ro9tFA=;
        b=bHnTY0e17WQrnhkFe0v0JcWa1ICaH84+lJTKQZlqf9QimQBOyoFYY9ahRRTUZCBY5N
         siQMhNHdYC4xbwXG0rXg+//A4DpZfUTJ5cua9+ag0c1WiH1/vFBtxwpr4qxTf3RbsfW1
         KyAkSveejM5NREf78Rw3v0PHtnAsPzy+xf2ak6sRfls2TKx/8+xVdjsFeOl2MzaqzCiG
         NQIld02ZUEdnNBt6IPbdJMrA5bav0uaDcaZgR6Am9ddoEvNNYkxRZvHssPJMFVmwzkHg
         In4fr1rTSRWuwtxrGNJN+ToP6RAxJlkk+eLPIj5/1fjbRxl7732aVSXAabjFktMlsuXS
         paGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KwKZVOZR3GJHc3jlnF0u1iBjRpLe4GFgoYhD+Ro9tFA=;
        b=nxDTMUeJcZx3TekKHYu9Wqr4PFimykTaoKhGRELuf32WTfH7ICfQ23AdQMBzk/Cpk3
         Q7fNzHs/O4zmKeKNrUAyAgf5Qc1VPk9zh0G/Q09KVLTGD8I7ykhqxG9dt5ho9LM9t9pi
         y7P5j+cAg9/ku7O+cSgUMnt46P4SquluTLrCK3Q3dqvbp6jBaX+ULVvn43a8dzh652Q/
         ykPurqrGZzfiqwuegK+luJ6q1hXkkBTlpIEcu4BvV8rfPtfpqJR33RrpgTEtXGPjOtI1
         /xHKpLGO6ahdMHDlY2/0blC0dM68ZQS8GFkdbNLob8r2iJUWJ6qTcZp1e+wCg6lvNblM
         J1QQ==
X-Gm-Message-State: ACgBeo0rIJ4ZQhrqMDYOYBPDPL+DoyuAnGrb2jWduWg243okby0CFJxd
        z8r0V91+3yhU98jJPo7iup0uPj4R5MGidw==
X-Google-Smtp-Source: AA6agR7qM5bf/Q68jZvJnIa1spu+fyHZvz11/ztBSI7zFdKT40RfuwXvcXpe/5fUkXNLaDf9gTaH0g==
X-Received: by 2002:a05:6402:1d4e:b0:43d:9822:b4d1 with SMTP id dz14-20020a0564021d4e00b0043d9822b4d1mr5390131edb.212.1660899247969;
        Fri, 19 Aug 2022 01:54:07 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:07 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 4/7] staging: rtl8723bs: remove function GetFractionValueFromString
Date:   Fri, 19 Aug 2022 10:52:54 +0200
Message-Id: <e782bcd3ff8c33df8da7eb6b8e4bb00b1c270edc.1660898432.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660898432.git.namcaov@gmail.com>
References: <cover.1660898432.git.namcaov@gmail.com>
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

