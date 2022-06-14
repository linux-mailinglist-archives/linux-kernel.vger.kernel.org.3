Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936F54B537
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbiFNP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbiFNP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:59:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC01CFE2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so12283005edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3gbMv3CLEVw18Z0+GMlsuJYkcEWg9M+cqo68PHCY1Q=;
        b=M7DlVTelkdRHSDTdXFbXqRTjSfrVHM80gWUzdQlAvt08aiyANcUKt2xnHvWIr+Or/V
         n6qHxtuSWdt9ut4qX/tDFnF/GY9fm5ttHMpFHymlI1JkPNoBMLChV+buibbtUWVjo/wN
         9K/0rmRExU2x20F4AejBPwpUCBY71lJMEM5PBJrtmkWEcL4AYmHI8VyvGMdOKQGmkfxk
         a38PKwQLbZn0fuAc9m0xSDLWCrwJzmPBXckQdQ9P7p7ZCxp2zlfpKzBNnFSGiq4xwyyB
         VXePc4WMNsCiClY3QJBFuez50bAj8T4Icp99/L3CacjhQKL3+IBROWHtnto+8DAFqbOx
         0AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3gbMv3CLEVw18Z0+GMlsuJYkcEWg9M+cqo68PHCY1Q=;
        b=xVIZkji/MLwT/fYaHvHmV7ffGxAeJAdetrfyskytlPid0dGmHbOKnmsOBY//r9l1El
         jWbZ6tthb4wVquVjsurqyBKHjNwrQAKzE4CYoiNtH0NsoLTZG6lmBLi3QSU7iG/Oht0e
         4NT2xDYuvvt7VqpV9m6SC+vgvHXkejjm98P0lLZtfxj0dhPhqWGuqiqmMfzjCN5WmEK9
         Zjv0pUeJ4SvIk+5YujMHOcUYdiY2X/4iLu5teznq7/ID9YVfR4GU3XSf6mjGtN5VRzK3
         Qfas9DalCjf3sK1Um202l93qMCrTCN65EVbFHMFqqne7AfNT4BtHhq22PchS7jIjWq25
         yjxQ==
X-Gm-Message-State: AJIora/HSP02dkoCNEzgdCT3oRVVOPT+RmHCXDjUM5b12yi7As7diByA
        6ywit+GtjUnCxkObptTlRXg=
X-Google-Smtp-Source: AGRyM1vAU0DxLPxLYMT9nMistjkeFzzHUlxwynL+MUrAjKN8Oez6KHUFzkRMcICzL3aFAJoVfPiGlA==
X-Received: by 2002:a05:6402:388b:b0:42b:5f20:c616 with SMTP id fd11-20020a056402388b00b0042b5f20c616mr6903288edb.50.1655222355575;
        Tue, 14 Jun 2022 08:59:15 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:c58b:f186:2720:bdac])
        by smtp.gmail.com with ESMTPSA id qk10-20020a170906d9ca00b006fed93bf71fsm5327928ejb.18.2022.06.14.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:59:15 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
Subject: [PATCH v3 2/2] staging: r8188eu: remove unused macros
Date:   Tue, 14 Jun 2022 17:58:45 +0200
Message-Id: <a7f700c0688a16bb697fb693894f4c16594fd483.1655220367.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655220367.git.namcaov@gmail.com>
References: <cover.1655220367.git.namcaov@gmail.com>
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

Remove LE_BITS_TO_1BYTE and relevant macros because they are not used
anywhere.

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

