Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D665037E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiDPTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiDPTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:19:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EED40E7F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:16:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so20639719ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=zN414E1wUs5m3NDV6VHa4oOxNF3me+8yZYZGl2DDtrY=;
        b=TGzAL/7uIzYRbvutlfTTnBRfoT7UBe3f+qcHalDuPCNYItpv9XeQRp32C3BMPfyXdC
         9/QxTQUKYSVim/ofADgzOKOrKOhrcLy0pSSdJGTBr96c5DjRqexelQCNtcWghOpVJ63q
         XMHDQ8licyKS8os1TZ3aL67bFr1NhDyNCcJFrQt2Le2At6tb5vLkXkDGS9EnRko0bmcG
         rnVfq6tFfeKR769sUme98ATPGq+532a3P91ap73lCRPYEpxigeAQyeu8jEUC7aMWfxSv
         1p9ImHNGu3sTu5CpdO59PE0Ov31/C57ZVfFjHDnc4N9yA/UA6JgLbDpCV0mL73cQaHOy
         IrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=zN414E1wUs5m3NDV6VHa4oOxNF3me+8yZYZGl2DDtrY=;
        b=IfcuDmxv5yIcW51vlmgzfhleDC99i46bnWScEJwkpQ8DVX3iDQfbQSttd32s40c9zg
         uPAFPTZorMxKuWoPJJyUZDp/biI2I8Imq+Ra389agE2SmJPKoFg2LZtCivvvDMuPpnj+
         bAGdM8wwcl8FQDBjBaW8A6qEILJz59WMM/+OStFzJm8/uQOfaoQiCU+OQUvjedDfubJV
         lxUIdWQ/LvbMplXM4CyIzyb1e8iy5Rrm2cw5ijDTNG+oIkKUZivMKTIizCEh+yJgIZH4
         SGNhSqN6myO8UImiiM/SfQau9roj2Nw2W0mz3f02+LuJu49hKrvphhAfzG96/pOrzh59
         o7Hg==
X-Gm-Message-State: AOAM532uG5bB720+iv37+k6r1HFYAJLhIm7nT1XrgjRIDaKu8LI2Ye97
        pt05h3yFEcEvtmZXxe713IerS5JbC0Q=
X-Google-Smtp-Source: ABdhPJw7E3vIXAdvtrqtmoykHH466O0jyZt/3xo8LRqmJT4dvruixxpc0lTuD8rvbhPIn7MV2JJDNg==
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id hd14-20020a170907968e00b006dbaed543c8mr3584479ejc.636.1650136586575;
        Sat, 16 Apr 2022 12:16:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id y26-20020a1709063a9a00b006e0c272e263sm2941030ejd.71.2022.04.16.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 12:16:26 -0700 (PDT)
Date:   Sat, 16 Apr 2022 21:16:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Delete tmacro.h
Message-ID: <20220416191622.GA11596@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate the only macro MAKEWORD that is in use and remove file
tmacro.h. File needs to be changed anyhow because of use of CamelCase
which is not accepted by checkpatch.pl. Reduced code provides
a better overview.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655
---
 drivers/staging/vt6655/baseband.c |  1 -
 drivers/staging/vt6655/card.c     |  1 -
 drivers/staging/vt6655/key.c      |  1 -
 drivers/staging/vt6655/mac.c      |  1 -
 drivers/staging/vt6655/mac.h      |  4 ++-
 drivers/staging/vt6655/srom.c     |  1 -
 drivers/staging/vt6655/tmacro.h   | 43 -------------------------------
 7 files changed, 3 insertions(+), 49 deletions(-)
 delete mode 100644 drivers/staging/vt6655/tmacro.h

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index decb55e96f02..21e691c3ea30 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -29,7 +29,6 @@
  *
  */
 
-#include "tmacro.h"
 #include "mac.h"
 #include "baseband.h"
 #include "srom.h"
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 1ccf08b1fd5c..022310af5485 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include "tmacro.h"
 #include "card.h"
 #include "baseband.h"
 #include "mac.h"
diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
index f843966a3ea4..1469015eb5b4 100644
--- a/drivers/staging/vt6655/key.c
+++ b/drivers/staging/vt6655/key.c
@@ -11,7 +11,6 @@
  *
  */
 
-#include "tmacro.h"
 #include "key.h"
 #include "mac.h"
 
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 80cced7dfda8..88ddd0676463 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -36,7 +36,6 @@
  *
  */
 
-#include "tmacro.h"
 #include "mac.h"
 
 /*
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 4d8496024abf..7970a42ee6e6 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -18,7 +18,6 @@
 #ifndef __MAC_H__
 #define __MAC_H__
 
-#include "tmacro.h"
 #include "upc.h"
 
 /*---------------------  Export Definitions -------------------------*/
@@ -732,6 +731,9 @@ do {									\
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
 
+#define MAKEWORD(lb, hb) \
+	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
+
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits);
 
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 84ec9eb8cdd3..8786b55161fa 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -28,7 +28,6 @@
  */
 
 #include "upc.h"
-#include "tmacro.h"
 #include "mac.h"
 #include "srom.h"
 
diff --git a/drivers/staging/vt6655/tmacro.h b/drivers/staging/vt6655/tmacro.h
deleted file mode 100644
index 1582c03124c9..000000000000
--- a/drivers/staging/vt6655/tmacro.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
- * All rights reserved.
- *
- * Purpose: define basic common types and macros
- *
- * Author: Tevin Chen
- *
- * Date: May 21, 1996
- *
- */
-
-#ifndef __TMACRO_H__
-#define __TMACRO_H__
-
-/****** Common helper macros ***********************************************/
-
-#if !defined(LOBYTE)
-#define LOBYTE(w)           ((unsigned char)(w))
-#endif
-#if !defined(HIBYTE)
-#define HIBYTE(w)           ((unsigned char)(((unsigned short)(w) >> 8) & 0xFF))
-#endif
-
-#if !defined(LOWORD)
-#define LOWORD(d)           ((unsigned short)(d))
-#endif
-#if !defined(HIWORD)
-#define HIWORD(d)           ((unsigned short)((((unsigned long)(d)) >> 16) & 0xFFFF))
-#endif
-
-#define LODWORD(q)          ((q).u.dwLowDword)
-#define HIDWORD(q)          ((q).u.dwHighDword)
-
-#if !defined(MAKEWORD)
-#define MAKEWORD(lb, hb)    ((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
-#endif
-#if !defined(MAKEDWORD)
-#define MAKEDWORD(lw, hw)   ((unsigned long)(((unsigned short)(lw)) | (((unsigned long)((unsigned short)(hw))) << 16)))
-#endif
-
-#endif /* __TMACRO_H__ */
-- 
2.25.1

