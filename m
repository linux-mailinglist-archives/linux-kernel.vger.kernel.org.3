Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6C656437D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGCAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGCAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 20:30:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74079FFE;
        Sat,  2 Jul 2022 17:30:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so8335484wrc.2;
        Sat, 02 Jul 2022 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R00o61OzkDCWM/phMsT+E3U9y/KbpzXga3rwLBN2UGo=;
        b=K7OrXvi5SfHGEJO0ns+EcfkxNyb3ZY4CgP2dbORVOlywAIoV+24N3k1UA6HrjQR7JJ
         nssDwVYx27D3SqD3qz+cdBGroHJFK7pixzb+5lJ4i4+qQ6oVeCKBhsF7mYuEOdgwjPRy
         TpN13esYE0TMUh4nAsAWjYMpNgVReaWQ78dHqaUOLYenAyALdBd4EA0bR5EvhVk/3x4h
         2uwpSb3xz3QtvLu38jCytGl9jFv5ujrSEstVV+QU5mTg1M6RhCvEP/a9mQRq7n3ALtPA
         c5e0nrPxAKJ95qWzjIyKJ1/tVLYJWYmn+g3Sx25x34Sske0IKbqAX6zFSj/KQUHmH7al
         NTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R00o61OzkDCWM/phMsT+E3U9y/KbpzXga3rwLBN2UGo=;
        b=PBbY5/VheY0owFXiPE17b/IgfwhD2Dp7FipF46JLMwAquANryV63aOhPq4kf/lTraL
         BPaQ8avW17ZqlWQlpcGi3H3UrpO+kICwQJSemAVnLhN6pQuhRhqps6h0k8pUqt9DjYtJ
         WfOrjcSfzj+bOXvAi16MYZodbV0ZDHLSauMWpJMcaCLihWcSqt4+R0OUlMBAHn1ZWwYQ
         fGN7xpRYJuSxGh2U6v1Vz7uUKPz41y5tCXmxY+1MSat0RwerOPyD3ZNYKhDCYy1Jg4qH
         mPdCm6fqLOCTds8w6ycK3lViTUDfYN6cSi+AyreYR3iVjnwJzMm6CDkwSMaVvnjqDwL0
         rRog==
X-Gm-Message-State: AJIora8RIK3zJAU6/STY8P2Mex/GjKxSKjcPB8rMPHiYv7tNsdlVrQ3C
        jth1ZP0GB6zkyaA5v2Qso5Q=
X-Google-Smtp-Source: AGRyM1vyAOgOR4X4yWSTBM1B896tjyc6x5kPkLdW+ZN3DIrJjUiGXMtDT7cDXn5WtU+5IsjXi4V8Ng==
X-Received: by 2002:a5d:588f:0:b0:21b:ba06:4d46 with SMTP id n15-20020a5d588f000000b0021bba064d46mr21654834wrf.58.1656808221125;
        Sat, 02 Jul 2022 17:30:21 -0700 (PDT)
Received: from javier-S1-WHL-Series.www.tendawifi.com ([45.158.103.138])
        by smtp.googlemail.com with ESMTPSA id j19-20020a5d6e53000000b002102b16b9a4sm26180703wrz.110.2022.07.02.17.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 17:30:19 -0700 (PDT)
From:   Javier Abrego <javier.abrego.lorente@gmail.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Javier Abrego <javier.abrego.lorente@gmail.com>
Subject: [PATCH] ACPI: acpica: acmacros: fixed linter issues
Date:   Sun,  3 Jul 2022 02:30:14 +0200
Message-Id: <20220703003014.52949-1-javier.abrego.lorente@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixed a coding style issue with the linter.

Signed-off-by: Javier Abrego <javier.abrego.lorente@gmail.com>
---
 drivers/acpi/acpica/acmacros.h | 212 ++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2f3e609df..597070cde 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -15,18 +15,18 @@
  * get into potential alignment issues -- see the STORE macros below.
  * Use with care.
  */
-#define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
-#define ACPI_CAST16(ptr)                ACPI_CAST_PTR (u16, (ptr))
-#define ACPI_CAST32(ptr)                ACPI_CAST_PTR (u32, (ptr))
-#define ACPI_CAST64(ptr)                ACPI_CAST_PTR (u64, (ptr))
-#define ACPI_GET8(ptr)                  (*ACPI_CAST8 (ptr))
-#define ACPI_GET16(ptr)                 (*ACPI_CAST16 (ptr))
-#define ACPI_GET32(ptr)                 (*ACPI_CAST32 (ptr))
-#define ACPI_GET64(ptr)                 (*ACPI_CAST64 (ptr))
-#define ACPI_SET8(ptr, val)             (*ACPI_CAST8 (ptr) = (u8) (val))
-#define ACPI_SET16(ptr, val)            (*ACPI_CAST16 (ptr) = (u16) (val))
-#define ACPI_SET32(ptr, val)            (*ACPI_CAST32 (ptr) = (u32) (val))
-#define ACPI_SET64(ptr, val)            (*ACPI_CAST64 (ptr) = (u64) (val))
+#define ACPI_CAST8(ptr)                 ACPI_CAST_PTR(u8, (ptr))
+#define ACPI_CAST16(ptr)                ACPI_CAST_PTR(u16, (ptr))
+#define ACPI_CAST32(ptr)                ACPI_CAST_PTR(u32, (ptr))
+#define ACPI_CAST64(ptr)                ACPI_CAST_PTR(u64, (ptr))
+#define ACPI_GET8(ptr)                  (*ACPI_CAST8(ptr))
+#define ACPI_GET16(ptr)                 (*ACPI_CAST16(ptr))
+#define ACPI_GET32(ptr)                 (*ACPI_CAST32(ptr))
+#define ACPI_GET64(ptr)                 (*ACPI_CAST64(ptr))
+#define ACPI_SET8(ptr, val)             (*ACPI_CAST8(ptr) = (u8) (val))
+#define ACPI_SET16(ptr, val)            (*ACPI_CAST16(ptr) = (u16) (val))
+#define ACPI_SET32(ptr, val)            (*ACPI_CAST32(ptr) = (u32) (val))
+#define ACPI_SET64(ptr, val)            (*ACPI_CAST64(ptr) = (u64) (val))
 
 /*
  * printf() format helper. This macro is a workaround for the difficulties
@@ -51,31 +51,31 @@
 	 /*  Hi...Lo                     Lo...Hi     */
 /* 16-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
-			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
+#define ACPI_MOVE_16_TO_16(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
+			  ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0]; }
 
-#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d))=0;\
+#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0;\
 					  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
 
-#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
+#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0;\
 							   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
-							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
+							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
 
 /* 32-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
-#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
-									  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
-									  ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+#define ACPI_MOVE_32_TO_32(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
+									  ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
+									  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
+									  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
 
-#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
+#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0;\
 										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
 										   ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
 										   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
-										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
+										   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
 
 /* 64-bit source, 16/32/64 destination */
 
@@ -83,14 +83,14 @@
 
 #define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
 
-#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
-										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6];\
-										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5];\
-										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4];\
-										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
-										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
-										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
-										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
+#define ACPI_MOVE_64_TO_64(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
+										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6];\
+										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5];\
+										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4];\
+										 ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
+										 ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
+										 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
+										 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
 #else
 /*
  * Macros for little-endian machines
@@ -127,35 +127,35 @@
 
 /* 16-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
-										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];}
+#define ACPI_MOVE_16_TO_16(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; }
 
-#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
-#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
+#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
+#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
 
 /* 32-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
-#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
-										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
-										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
-										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];}
+#define ACPI_MOVE_32_TO_32(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
+										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
+										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; }
 
-#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s);}
+#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s); }
 
 /* 64-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 #define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
-#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
-										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
-										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
-										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];\
-										 ((  u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4];\
-										 ((  u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5];\
-										 ((  u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6];\
-										 ((  u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7];}
+#define ACPI_MOVE_64_TO_64(d, s)        {((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+										 ((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
+										 ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
+										 ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];\
+										 ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4];\
+										 ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5];\
+										 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6];\
+										 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
 #endif
 #endif
 
@@ -164,7 +164,7 @@
  */
 #define _ACPI_DIV(value, power_of2)     ((u32) ((value) >> (power_of2)))
 #define _ACPI_MUL(value, power_of2)     ((u32) ((value) << (power_of2)))
-#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) -1)))
+#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) - 1)))
 
 #define ACPI_DIV_2(a)                   _ACPI_DIV(a, 1)
 #define ACPI_MUL_2(a)                   _ACPI_MUL(a, 1)
@@ -232,64 +232,64 @@
 
 #define __ACPI_FIND_LAST_BIT_2(a, r)        ((((u8)  (a)) & 0x02) ? (r)+1 : (r))
 #define __ACPI_FIND_LAST_BIT_4(a, r)        ((((u8)  (a)) & 0x0C) ? \
-											 __ACPI_FIND_LAST_BIT_2  ((a)>>2,  (r)+2) : \
-											 __ACPI_FIND_LAST_BIT_2  ((a), (r)))
+											 __ACPI_FIND_LAST_BIT_2((a)>>2,  (r)+2) : \
+											 __ACPI_FIND_LAST_BIT_2((a), (r)))
 #define __ACPI_FIND_LAST_BIT_8(a, r)        ((((u8)  (a)) & 0xF0) ? \
-											 __ACPI_FIND_LAST_BIT_4  ((a)>>4,  (r)+4) : \
-											 __ACPI_FIND_LAST_BIT_4  ((a), (r)))
+											 __ACPI_FIND_LAST_BIT_4((a)>>4,  (r)+4) : \
+											 __ACPI_FIND_LAST_BIT_4((a), (r)))
 #define __ACPI_FIND_LAST_BIT_16(a, r)       ((((u16) (a)) & 0xFF00) ? \
-											 __ACPI_FIND_LAST_BIT_8  ((a)>>8,  (r)+8) : \
-											 __ACPI_FIND_LAST_BIT_8  ((a), (r)))
+											 __ACPI_FIND_LAST_BIT_8((a)>>8,  (r)+8) : \
+											 __ACPI_FIND_LAST_BIT_8((a), (r)))
 #define __ACPI_FIND_LAST_BIT_32(a, r)       ((((u32) (a)) & 0xFFFF0000) ? \
-											 __ACPI_FIND_LAST_BIT_16 ((a)>>16, (r)+16) : \
-											 __ACPI_FIND_LAST_BIT_16 ((a), (r)))
+											 __ACPI_FIND_LAST_BIT_16((a)>>16, (r)+16) : \
+											 __ACPI_FIND_LAST_BIT_16((a), (r)))
 #define __ACPI_FIND_LAST_BIT_64(a, r)       ((((u64) (a)) & 0xFFFFFFFF00000000) ? \
-											 __ACPI_FIND_LAST_BIT_32 ((a)>>32, (r)+32) : \
-											 __ACPI_FIND_LAST_BIT_32 ((a), (r)))
+											 __ACPI_FIND_LAST_BIT_32((a)>>32, (r)+32) : \
+											 __ACPI_FIND_LAST_BIT_32((a), (r)))
 
-#define ACPI_FIND_LAST_BIT_8(a)             ((a) ? __ACPI_FIND_LAST_BIT_8 (a, 1) : 0)
-#define ACPI_FIND_LAST_BIT_16(a)            ((a) ? __ACPI_FIND_LAST_BIT_16 (a, 1) : 0)
-#define ACPI_FIND_LAST_BIT_32(a)            ((a) ? __ACPI_FIND_LAST_BIT_32 (a, 1) : 0)
-#define ACPI_FIND_LAST_BIT_64(a)            ((a) ? __ACPI_FIND_LAST_BIT_64 (a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_8(a)             ((a) ? __ACPI_FIND_LAST_BIT_8(a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_16(a)            ((a) ? __ACPI_FIND_LAST_BIT_16(a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_32(a)            ((a) ? __ACPI_FIND_LAST_BIT_32(a, 1) : 0)
+#define ACPI_FIND_LAST_BIT_64(a)            ((a) ? __ACPI_FIND_LAST_BIT_64(a, 1) : 0)
 
 #define __ACPI_FIND_FIRST_BIT_2(a, r)       ((((u8) (a)) & 0x01) ? (r) : (r)+1)
 #define __ACPI_FIND_FIRST_BIT_4(a, r)       ((((u8) (a)) & 0x03) ? \
-											 __ACPI_FIND_FIRST_BIT_2  ((a), (r)) : \
-											 __ACPI_FIND_FIRST_BIT_2  ((a)>>2, (r)+2))
+											 __ACPI_FIND_FIRST_BIT_2((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_2((a)>>2, (r)+2))
 #define __ACPI_FIND_FIRST_BIT_8(a, r)       ((((u8) (a)) & 0x0F) ? \
-											 __ACPI_FIND_FIRST_BIT_4  ((a), (r)) : \
-											 __ACPI_FIND_FIRST_BIT_4  ((a)>>4, (r)+4))
+											 __ACPI_FIND_FIRST_BIT_4((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_4((a)>>4, (r)+4))
 #define __ACPI_FIND_FIRST_BIT_16(a, r)      ((((u16) (a)) & 0x00FF) ? \
-											 __ACPI_FIND_FIRST_BIT_8  ((a), (r)) : \
-											 __ACPI_FIND_FIRST_BIT_8  ((a)>>8, (r)+8))
+											 __ACPI_FIND_FIRST_BIT_8((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_8((a)>>8, (r)+8))
 #define __ACPI_FIND_FIRST_BIT_32(a, r)      ((((u32) (a)) & 0x0000FFFF) ? \
-											 __ACPI_FIND_FIRST_BIT_16 ((a), (r)) : \
-											 __ACPI_FIND_FIRST_BIT_16 ((a)>>16, (r)+16))
+											 __ACPI_FIND_FIRST_BIT_16((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_16((a)>>16, (r)+16))
 #define __ACPI_FIND_FIRST_BIT_64(a, r)      ((((u64) (a)) & 0x00000000FFFFFFFF) ? \
-											 __ACPI_FIND_FIRST_BIT_32 ((a), (r)) : \
-											 __ACPI_FIND_FIRST_BIT_32 ((a)>>32, (r)+32))
+											 __ACPI_FIND_FIRST_BIT_32((a), (r)) : \
+											 __ACPI_FIND_FIRST_BIT_32((a)>>32, (r)+32))
 
-#define ACPI_FIND_FIRST_BIT_8(a)            ((a) ? __ACPI_FIND_FIRST_BIT_8 (a, 1) : 0)
-#define ACPI_FIND_FIRST_BIT_16(a)           ((a) ? __ACPI_FIND_FIRST_BIT_16 (a, 1) : 0)
-#define ACPI_FIND_FIRST_BIT_32(a)           ((a) ? __ACPI_FIND_FIRST_BIT_32 (a, 1) : 0)
-#define ACPI_FIND_FIRST_BIT_64(a)           ((a) ? __ACPI_FIND_FIRST_BIT_64 (a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_8(a)            ((a) ? __ACPI_FIND_FIRST_BIT_8(a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_16(a)           ((a) ? __ACPI_FIND_FIRST_BIT_16(a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_32(a)           ((a) ? __ACPI_FIND_FIRST_BIT_32(a, 1) : 0)
+#define ACPI_FIND_FIRST_BIT_64(a)           ((a) ? __ACPI_FIND_FIRST_BIT_64(a, 1) : 0)
 
 #endif				/* ACPI_USE_NATIVE_BIT_FINDER */
 
 /* Generic (power-of-two) rounding */
 
 #define ACPI_ROUND_UP_POWER_OF_TWO_8(a)     ((u8) \
-											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8  ((a)  - 1)))
+											(((u16) 1) <<  ACPI_FIND_LAST_BIT_8((a)  - 1)))
 #define ACPI_ROUND_DOWN_POWER_OF_TWO_8(a)   ((u8) \
-											(((u16) 1) << (ACPI_FIND_LAST_BIT_8  ((a)) - 1)))
+											(((u16) 1) << (ACPI_FIND_LAST_BIT_8((a)) - 1)))
 #define ACPI_ROUND_UP_POWER_OF_TWO_16(a)    ((u16) \
-											(((u32) 1) <<  ACPI_FIND_LAST_BIT_16 ((a)  - 1)))
+											(((u32) 1) <<  ACPI_FIND_LAST_BIT_16((a)  - 1)))
 #define ACPI_ROUND_DOWN_POWER_OF_TWO_16(a)  ((u16) \
-											(((u32) 1) << (ACPI_FIND_LAST_BIT_16 ((a)) - 1)))
+											(((u32) 1) << (ACPI_FIND_LAST_BIT_16((a)) - 1)))
 #define ACPI_ROUND_UP_POWER_OF_TWO_32(a)    ((u32) \
-											(((u64) 1) <<  ACPI_FIND_LAST_BIT_32 ((a)  - 1)))
+											(((u64) 1) <<  ACPI_FIND_LAST_BIT_32((a)  - 1)))
 #define ACPI_ROUND_DOWN_POWER_OF_TWO_32(a)  ((u32) \
-											(((u64) 1) << (ACPI_FIND_LAST_BIT_32 ((a)) - 1)))
+											(((u64) 1) << (ACPI_FIND_LAST_BIT_32((a)) - 1)))
 #define ACPI_IS_ALIGNED(a, s)               (((a) & ((s) - 1)) == 0)
 #define ACPI_IS_POWER_OF_TWO(a)             ACPI_IS_ALIGNED(a, a)
 
@@ -353,10 +353,10 @@
 
 /* Macros to extract flag bits from position one and above */
 
-#define ACPI_EXTRACT_1BIT_FLAG(field, position)     (ACPI_GET_1BIT_FLAG ((field) >> position))
-#define ACPI_EXTRACT_2BIT_FLAG(field, position)     (ACPI_GET_2BIT_FLAG ((field) >> position))
-#define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG ((field) >> position))
-#define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG ((field) >> position))
+#define ACPI_EXTRACT_1BIT_FLAG(field, position)     (ACPI_GET_1BIT_FLAG((field) >> position))
+#define ACPI_EXTRACT_2BIT_FLAG(field, position)     (ACPI_GET_2BIT_FLAG((field) >> position))
+#define ACPI_EXTRACT_3BIT_FLAG(field, position)     (ACPI_GET_3BIT_FLAG((field) >> position))
+#define ACPI_EXTRACT_4BIT_FLAG(field, position)     (ACPI_GET_4BIT_FLAG((field) >> position))
 
 /* ACPI Pathname helpers */
 
@@ -379,7 +379,7 @@
 /*
  * Macros for the master AML opcode table
  */
-#if defined (ACPI_DISASSEMBLER) || defined (ACPI_DEBUG_OUTPUT)
+#if defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUG_OUTPUT)
 #define ACPI_OP(name, Pargs, Iargs, obj_type, class, type, flags) \
 	{name, (u32)(Pargs), (u32)(Iargs), (u32)(flags), obj_type, class, type}
 #else
@@ -421,8 +421,8 @@
  * the plist contains a set of parens to allow variable-length lists.
  * These macros are used for both the debug and non-debug versions of the code.
  */
-#define ACPI_ERROR_NAMESPACE(s, p, e)       acpi_ut_prefixed_namespace_error (AE_INFO, s, p, e);
-#define ACPI_ERROR_METHOD(s, n, p, e)       acpi_ut_method_error (AE_INFO, s, n, p, e);
+#define ACPI_ERROR_NAMESPACE(s, p, e)       acpi_ut_prefixed_namespace_error(AE_INFO, s, p, e);
+#define ACPI_ERROR_METHOD(s, n, p, e)       acpi_ut_method_error(AE_INFO, s, n, p, e);
 #define ACPI_WARN_PREDEFINED(plist)         acpi_ut_predefined_warning plist
 #define ACPI_INFO_PREDEFINED(plist)         acpi_ut_predefined_info plist
 #define ACPI_BIOS_ERROR_PREDEFINED(plist)   acpi_ut_predefined_bios_error plist
@@ -467,17 +467,17 @@
 #ifdef ACPI_ASL_COMPILER
 
 #define ASL_CV_LABEL_FILENODE(a)         cv_label_file_node(a);
-#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)   cv_capture_comments_only (a);
-#define ASL_CV_CAPTURE_COMMENTS(a)       cv_capture_comments (a);
-#define ASL_CV_TRANSFER_COMMENTS(a)      cv_transfer_comments (a);
-#define ASL_CV_CLOSE_PAREN(a,b)          cv_close_paren_write_comment(a,b);
-#define ASL_CV_CLOSE_BRACE(a,b)          cv_close_brace_write_comment(a,b);
-#define ASL_CV_SWITCH_FILES(a,b)         cv_switch_files(a,b);
+#define ASL_CV_CAPTURE_COMMENTS_ONLY(a)   cv_capture_comments_only(a);
+#define ASL_CV_CAPTURE_COMMENTS(a)       cv_capture_comments(a);
+#define ASL_CV_TRANSFER_COMMENTS(a)      cv_transfer_comments(a);
+#define ASL_CV_CLOSE_PAREN(a, b)          cv_close_paren_write_comment(a, b);
+#define ASL_CV_CLOSE_BRACE(a, b)          cv_close_brace_write_comment(a, b);
+#define ASL_CV_SWITCH_FILES(a, b)         cv_switch_files(a, b);
 #define ASL_CV_CLEAR_OP_COMMENTS(a)       cv_clear_op_comments(a);
-#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d) cv_print_one_comment_type (a,b,c,d);
-#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b) cv_print_one_comment_list (a,b);
+#define ASL_CV_PRINT_ONE_COMMENT(a, b, c, d) cv_print_one_comment_type (a, b, c, d);
+#define ASL_CV_PRINT_ONE_COMMENT_LIST(a, b) cv_print_one_comment_list (a, b);
 #define ASL_CV_FILE_HAS_SWITCHED(a)       cv_file_has_switched(a)
-#define ASL_CV_INIT_FILETREE(a,b)      cv_init_file_tree(a,b);
+#define ASL_CV_INIT_FILETREE(a, b)      cv_init_file_tree(a, b);
 
 #else
 
@@ -485,14 +485,14 @@
 #define ASL_CV_CAPTURE_COMMENTS_ONLY(a)
 #define ASL_CV_CAPTURE_COMMENTS(a)
 #define ASL_CV_TRANSFER_COMMENTS(a)
-#define ASL_CV_CLOSE_PAREN(a,b)          acpi_os_printf (")");
-#define ASL_CV_CLOSE_BRACE(a,b)          acpi_os_printf ("}");
-#define ASL_CV_SWITCH_FILES(a,b)
+#define ASL_CV_CLOSE_PAREN(a, b)          acpi_os_printf (")");
+#define ASL_CV_CLOSE_BRACE(a, b)          acpi_os_printf ("}");
+#define ASL_CV_SWITCH_FILES(a, b)
 #define ASL_CV_CLEAR_OP_COMMENTS(a)
-#define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d)
-#define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b)
+#define ASL_CV_PRINT_ONE_COMMENT(a, b, c, d)
+#define ASL_CV_PRINT_ONE_COMMENT_LIST(a, b)
 #define ASL_CV_FILE_HAS_SWITCHED(a)       0
-#define ASL_CV_INIT_FILETREE(a,b)
+#define ASL_CV_INIT_FILETREE(a, b)
 
 #endif
 
-- 
2.25.1

