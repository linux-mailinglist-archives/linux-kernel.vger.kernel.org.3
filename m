Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352654793F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiFLINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiFLINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:13:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D21674D5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so5614426eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUhoNTZNrsEIdOu15ISZAAXLEM8PaGxpo0lgCC9aE40=;
        b=DhlnZCj0oLT946aOSSCceCxFOezw9yscz0NjCzFT1taPIc0mrGbd+wiV+N7A7BRSt/
         M3rWZu/VeugJuf4AcdN68G4dKeit9O0aqJtfFC6xEC4NIR1VDEc2529rw8bvdQ6x7rzX
         r981SNcoGB1LIczlwR//joaQkMK+d8Xr9yJlw5Y40FlcjJywj1iVeSpFEnbemFkAhX01
         lBD7YdpOcnjbUMa06hz3jYhyxeTrfVhNGupTRMYfoAiDYC4xUsiinZVZwHHV6gL81/vP
         fFVzMyoyYbMqz/miVEyn+wmCqzCrtHDTeU5B8apgChszkX9z7FeHxMVhIjaQBD+AZuKY
         xLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUhoNTZNrsEIdOu15ISZAAXLEM8PaGxpo0lgCC9aE40=;
        b=VYZM0sBUNJTGdffHgJNymbUu9sI4nyNZ31b33L29lFjpsWuJ2C3p3b7qjjLIw9r5pc
         YgMZkum0zCsWoPqICrHssYy80bLguMu/0mY2JTZxSORodgVAnUq7tGtFif2yA3g7lhMj
         ENFrGgaZYg+NBfRMrRer4J8axeH+/00DnX6Gw4KTfScHwxobVMSANKpTipIO3Xhf3VfE
         Ntf5Eic3uZ9vpvf/ROkOvijwm1ex2ueT7LOSUL2nTxUCQQz/qsTbnAl+dHSvP9Gi+FG9
         bdOsrckzymOSwpEZqJZ48BUw5yvx6Kerx/fxLxge9pSP7p1qzGjLBysv7FVPqsT9iG/5
         tbPg==
X-Gm-Message-State: AOAM531v/m16/y7lwA4OG6V9qFmZh/7BA9hiCJwFZdHQ3IS8vvMIQk9H
        a211qgcE71Haz6i8s9BWvxvXKLmF5FE=
X-Google-Smtp-Source: ABdhPJzvOmY7jP6600tRAUbA7A8owBl/VhRYX17MzGBERdvYcaVG8ZbPlUi0jAFQXEbcjXih+YXaRA==
X-Received: by 2002:a17:906:6c82:b0:709:f868:97f6 with SMTP id s2-20020a1709066c8200b00709f86897f6mr49484659ejr.555.1655021577739;
        Sun, 12 Jun 2022 01:12:57 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:bcf1:6e8b:57bb:87f1])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b006ff802baf5dsm2130637eje.54.2022.06.12.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 01:12:57 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk
Subject: [PATCH v2 2/2] staging: r8188eu: remove unused macros
Date:   Sun, 12 Jun 2022 10:11:44 +0200
Message-Id: <ea62e595714a7cc24204643b90045d0c088aea8c.1655019752.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655019752.git.namcaov@gmail.com>
References: <cover.1655019752.git.namcaov@gmail.com>
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

The macro LE_BITS_TO_1BYTE and related macros are not used anywhere.
Remove them.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/r8188eu/include/basic_types.h | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
index cfd15ac1d9c0..0b71e2c6e41a 100644
--- a/drivers/staging/r8188eu/include/basic_types.h
+++ b/drivers/staging/r8188eu/include/basic_types.h
@@ -13,37 +13,6 @@ typedef void (*proc_t)(void *);
 /*  TODO: Macros Below are Sync from SD7-Driver. It is necessary
  * to check correctness */
 
-/*
- *	Call endian free function when
- *		1. Read/write packet content.
- *		2. Before write integer to IO.
- *		3. After read integer from IO.
-*/
-
-/* Convert little data endian to host ordering */
-#define EF1BYTE(_val)		\
-	((u8)(_val))
-
-/* Create a bit mask  */
-#define BIT_LEN_MASK_8(__bitlen) \
-	(0xFF >> (8 - (__bitlen)))
-
-/*Description:
- * Return 4-byte value in host byte ordering from
- * 4-byte pointer in little-endian system.
- */
-#define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
-	(EF1BYTE(*((u8 *)(__pstart))))
-
-/*Description:
-Translate subfield (continuous bits in little-endian) of 4-byte
-value to host byte ordering.*/
-#define LE_BITS_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
-		BIT_LEN_MASK_8(__bitlen) \
-	)
-
 #define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
 	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
 
-- 
2.25.1

