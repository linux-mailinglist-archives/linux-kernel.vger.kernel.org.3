Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7544F8817
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiDGTas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDGTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1429AD3D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r10so7614399eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spUrDlTPoQb5W/WISiaHwyVQFy34aqJXbfUX39rUuXo=;
        b=Aqbx7GkMI7y3Mql3+83x97cVq81FAobXYw3EYgB12+sq7PCKL3BtUqylLZGXxHYU6B
         5MHQdGl4PeqwrjydEQrzzK5bDrymR9qPSJqCc/nf7K9wk7hM1/nQjPEQ+374QYvNOFbW
         zdOmlj4553NM4DOqRCJKoysqoxQge2RHM17mPBb7woEba9yx0I+pPWFddhU4YlG0lLx3
         /2cZFmh6Cfwnbr5E9VZbWf9U+/MF1iIZfgrl8Oypej/ULmm5Y9hkpr3VIdtkIxLkdk9r
         CDJsmf7XpYK/DHKhi0T5S/Mp0aieQffFrbhXpFalnef/6MrxtoxIvY2G9fhxa9aHi6Rl
         JN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spUrDlTPoQb5W/WISiaHwyVQFy34aqJXbfUX39rUuXo=;
        b=bqkxsDm1ZP5O2t6LXJQNornTlbAk0ANlI2g4vafbUJ7TAqOPc0Zp0kCWW6k8eh8wnV
         3XjhRifQ1edsv6jtGInQ8qK/cS8yLmD1+YlrlbwL5D4plKt2IsPfuiNHaBtz/TDN1bft
         iXP2es4xoZWdQkqZqQl7Q4clI5RhSp/bN2opBVTxTcB9zdVyHhp5pzltUcBWICi3dKju
         9L58teSLh0BHkm8nTIg3RD5utsfn1BiGJvXAsS9Ae/yy2PJbtUbJb23G661oCLgQIZCc
         PJlnq114FYO34r759xGrBpPoFwbeb1PhccR7Mlu4Fk67R8TIjQiNhvYvdKXKBI8ISRV5
         A9yw==
X-Gm-Message-State: AOAM532bIUUDAPZEGljZoK6F4vvQ66AQavMR9lZuPOrJML4fKZe040tJ
        42z9LzIeEF6KEdxdxul+c6o=
X-Google-Smtp-Source: ABdhPJy0WSU5QEc5x0vj8sGv8dkjsmkhDZ5gorxeDFvh5gqutGlefXOAZ95I0YAKafdhoNI0oqpDsg==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr15790385ede.218.1649359703905;
        Thu, 07 Apr 2022 12:28:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: r8188eu: remove unused macros from basic_types.h
Date:   Thu,  7 Apr 2022 21:28:12 +0200
Message-Id: <20220407192819.10661-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

Remove unused macros from basic_types.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/basic_types.h | 73 +------------------
 1 file changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
index d82b2171d584..ffb21170e898 100644
--- a/drivers/staging/r8188eu/include/basic_types.h
+++ b/drivers/staging/r8188eu/include/basic_types.h
@@ -4,9 +4,6 @@
 #ifndef __BASIC_TYPES_H__
 #define __BASIC_TYPES_H__
 
-#define SUCCESS	0
-#define FAIL	(-1)
-
 #include <linux/types.h>
 #define NDIS_OID uint
 
@@ -14,9 +11,6 @@ typedef void (*proc_t)(void *);
 
 #define FIELD_OFFSET(s, field)	((ssize_t)&((s *)(0))->field)
 
-#define MEM_ALIGNMENT_OFFSET	(sizeof(size_t))
-#define MEM_ALIGNMENT_PADDING	(sizeof(size_t) - 1)
-
 /* port from fw */
 /*  TODO: Macros Below are Sync from SD7-Driver. It is necessary
  * to check correctness */
@@ -31,86 +25,21 @@ typedef void (*proc_t)(void *);
 /* Convert little data endian to host ordering */
 #define EF1BYTE(_val)		\
 	((u8)(_val))
-#define EF2BYTE(_val)		\
-	(le16_to_cpu(_val))
-#define EF4BYTE(_val)		\
-	(le32_to_cpu(_val))
-
-/* Read data from memory */
-#define READEF1BYTE(_ptr)	\
-	EF1BYTE(*((u8 *)(_ptr)))
-/* Read le16 data from memory and convert to host ordering */
-#define READEF2BYTE(_ptr)	\
-	EF2BYTE(*(_ptr))
-#define READEF4BYTE(_ptr)	\
-	EF4BYTE(*(_ptr))
 
-/* Write data to memory */
-#define WRITEEF1BYTE(_ptr, _val)			\
-	do {						\
-		(*((u8 *)(_ptr))) = EF1BYTE(_val)	\
-	} while (0)
-/* Write le data to memory in host ordering */
-#define WRITEEF2BYTE(_ptr, _val)			\
-	do {						\
-		(*((u16 *)(_ptr))) = EF2BYTE(_val)	\
-	} while (0)
-
-#define WRITEEF4BYTE(_ptr, _val)			\
-	do {						\
-		(*((u32 *)(_ptr))) = EF2BYTE(_val)	\
-	} while (0)
-
-/* Create a bit mask
- * Examples:
- * BIT_LEN_MASK_32(0) => 0x00000000
- * BIT_LEN_MASK_32(1) => 0x00000001
- * BIT_LEN_MASK_32(2) => 0x00000003
- * BIT_LEN_MASK_32(32) => 0xFFFFFFFF
- */
-#define BIT_LEN_MASK_32(__bitlen)	 \
-	(0xFFFFFFFF >> (32 - (__bitlen)))
-#define BIT_LEN_MASK_16(__bitlen)	 \
-	(0xFFFF >> (16 - (__bitlen)))
+/* Create a bit mask  */
 #define BIT_LEN_MASK_8(__bitlen) \
 	(0xFF >> (8 - (__bitlen)))
 
-/* Create an offset bit mask
- * Examples:
- * BIT_OFFSET_LEN_MASK_32(0, 2) => 0x00000003
- * BIT_OFFSET_LEN_MASK_32(16, 2) => 0x00030000
- */
-#define BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_32(__bitlen) << (__bitoffset))
-#define BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_16(__bitlen) << (__bitoffset))
-#define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
-
 /*Description:
  * Return 4-byte value in host byte ordering from
  * 4-byte pointer in little-endian system.
  */
-#define LE_P4BYTE_TO_HOST_4BYTE(__pstart) \
-	(EF4BYTE(*((__le32 *)(__pstart))))
-#define LE_P2BYTE_TO_HOST_2BYTE(__pstart) \
-	(EF2BYTE(*((__le16 *)(__pstart))))
 #define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
 	(EF1BYTE(*((u8 *)(__pstart))))
 
 /*Description:
 Translate subfield (continuous bits in little-endian) of 4-byte
 value to host byte ordering.*/
-#define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
-		BIT_LEN_MASK_32(__bitlen) \
-	)
-#define LE_BITS_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P2BYTE_TO_HOST_2BYTE(__pstart) >> (__bitoffset)) & \
-		BIT_LEN_MASK_16(__bitlen) \
-	)
 #define LE_BITS_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
 	( \
 		(LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
-- 
2.35.1

