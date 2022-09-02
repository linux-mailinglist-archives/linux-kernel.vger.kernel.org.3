Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF835AABE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiIBJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiIBJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFE797530
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a36so1958434edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1V0D7g9msPu8a6+/7FcOIu4QO4uKpG+49B4mm720QMo=;
        b=niJSuOFGRclob8bhd9d5H3VQs8OHKfgamiLz43grGd3kzsRcTb+rBVOo9b1oNEcJir
         GfSp/FWfGqvHp7y19EDA6It9UfYcemwhHrElZ7uYDaZITAG2mXEmHZoB7GTwGOCi56g/
         Lotg6qT46sbnNmgvEZoDscQpwB6K+TbW2sI2v3vGEj4ToEe3R/CG7mqwqnTf+dG5Z+nt
         Ep/kfE1PERgScXjtOALFZoL8b/H2qPQGRbO73JVjlBErPh05EMJwQ/rD53xCrPNfCv9R
         3xS1De8QLVEOVXzdOmT8vJXc/BmTJLSLkHFrXko9InOREL6DlYWiAYt6+o6VjA+9K4b0
         Pe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1V0D7g9msPu8a6+/7FcOIu4QO4uKpG+49B4mm720QMo=;
        b=h66p1R3YzH0TFsOcYAa2SBcNyq5ec97UljPtTOGSL6HeBF/7l3fIJP0FT4zNoTe49m
         Mp0aPEtPw6b9gcRnqV4+pgfdH1qxx2Yf8tmRdfS2g9K6+6Yy6dJiVnotOc6qyjs1Iwed
         ci6sSyRfRLnSh+PMZ2O55aYkwvT2iXTqmatsJcuNLgCIxBBUGfcxRtFPUxnzRV/bAiYn
         AAsm7r6GxXiyECFXpkleRzJhB9DPcYO3tsZH/h7A85DjT3HtD4JSFtSbFtmK3mfc+Y5L
         17dhszoye2koKxlbk6luSnn65ZiZjRBAniTFF2PBQSulRAKzLpZqZeNbeu7rQgIIpZ4l
         XJlA==
X-Gm-Message-State: ACgBeo3lwoCx43oub4kgwDlgn1z0gYMUTzm9Zc1PKVrx2IAuxwsTk9sZ
        uQjW8Fti+P4DwS8qwKdQwJw=
X-Google-Smtp-Source: AA6agR7BP6fvV8AgyA1KKeVceZSAq4x4kFmJ0OKgHMPKI2+x0sMhGtX8ZmhOFhnyT0QT4Yp1MnQr1w==
X-Received: by 2002:a05:6402:34d2:b0:448:9fac:206e with SMTP id w18-20020a05640234d200b004489fac206emr17352011edc.171.1662112360625;
        Fri, 02 Sep 2022 02:52:40 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:40 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 09/10] staging: rtl8723bs: remove IsHexDigit
Date:   Fri,  2 Sep 2022 11:51:59 +0200
Message-Id: <8c70ecd9bea1dff2cb8f69e12bbef6aa4ee39977.1662111799.git.namcaov@gmail.com>
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

Remove function IsHexDigit because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 19 -------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 010a097c3afd..e42556d03bce 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -859,25 +859,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num)
 	return true;
 }
 
-/*  */
-/* 	Description: */
-/* 		Return true if chTmp is represent for hex digit and */
-/* 		false otherwise. */
-/*  */
-/*  */
-bool IsHexDigit(char chTmp)
-{
-	if (
-		(chTmp >= '0' && chTmp <= '9') ||
-		(chTmp >= 'a' && chTmp <= 'f') ||
-		(chTmp >= 'A' && chTmp <= 'F')
-	)
-		return true;
-	else
-		return false;
-}
-
-
 /*  */
 /* 	Description: */
 /* 		Translate a character to hex digit. */
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 76ad979c2a36..6356b8c2ef81 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -147,8 +147,6 @@ u8 GetHalDefVar(struct adapter *adapter, enum hal_def_variable variable,
 
 bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
-bool IsHexDigit(char chTmp);
-
 u32 MapCharToHexDigit(char chTmp);
 
 bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
-- 
2.25.1

