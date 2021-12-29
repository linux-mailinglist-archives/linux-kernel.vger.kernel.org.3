Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405184816C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhL2Uv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhL2Uvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so46592871wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ew7F1lxhIS5r8KK5lw0J3RaoujT9aqfKyhZYEfOCx4=;
        b=o4AGJuLWx9w2v21x6J8BAv3mEbi3IazkRVq3VQJZiFT16p4jsw5TvPHWReTmVOa8E9
         6QsD8KDmbvb2Q8geHamQCNXymMoUd234OT5hZFCVvM818cSA+nTOcJJ09lA1oYOJ0OZJ
         JEC/Tj6I8f37zNop8zW3nogSOz7he+4l8sjedxJZ0izCOyej9FApP4DS8lqgj4Enh4VC
         Oxzuwe+vZzv5Fv8pF5eTDTyaHEqGOEaLFA4QquoWL+evmxmDvlMQB/gfpX7+Cux0Six9
         wmmPD/IH5aaoYNfPeMzd/czTWGjSVF+7O5de5tft28yVe8Xz9FEmSmLPdMlUeTQQUN9a
         D40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ew7F1lxhIS5r8KK5lw0J3RaoujT9aqfKyhZYEfOCx4=;
        b=khybQvX9btvvQazVTzetjSEt9HB52VEiXCIYbk4+8TXA90IEjSHALwoZg4959D82ZX
         8AP+cBbMiI9DEkN2EzGEfrbBCgIzKe9YpwxfqDFeEV/zsI4zEtP43ZZ36yR++I7bY11g
         pW4EHr1L2f/vQUOYoiY+z/tIGI9GGcuzWeaCQeNoudd7Gxw7kS5kUsrRJqg7nKHBURQR
         PxA0adzqFSIuvjQ8w6UdRhHUhmtS2FKpa6YlVYivVQFP8FkNi8+AC/IRca6o/AKnXOHE
         Gr70+Iy+cSweLDIG77C9na9E5nbzVVWPcMEVr9Y0mI0vdchCuj51T9s0HpGC2qf61Iaa
         exkA==
X-Gm-Message-State: AOAM530SCfvAmjNrjuSNhRgmps9/Toh8ux3dIadrR65JeT5P/v4zTKg1
        qMp8N6mrcBE7x8Wym7pg3Ao=
X-Google-Smtp-Source: ABdhPJwYOkerewv7gWD1pfel4pVnEesKUvd0eCbMymilZ39ogjmeuQDaj0uwlKjbp+7caUtkTtjtjA==
X-Received: by 2002:adf:efd0:: with SMTP id i16mr22452714wrp.86.1640811095013;
        Wed, 29 Dec 2021 12:51:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/32] staging: r8188eu: remove odm_interface
Date:   Wed, 29 Dec 2021 21:50:48 +0100
Message-Id: <20211229205108.26373-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanups the file odm_interface.c is emtpy now
and the header odm_interface.h just contains an unused typedef.
Remove both files.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile                |  1 -
 drivers/staging/r8188eu/hal/odm_interface.c     |  6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 15 ---------------
 drivers/staging/r8188eu/include/odm_precomp.h   |  2 --
 4 files changed, 24 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 delete mode 100644 drivers/staging/r8188eu/include/odm_interface.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 5e1649491ef4..a7a486cc16dd 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -11,7 +11,6 @@ r8188eu-y = \
 		hal/hal_com.o \
 		hal/odm.o \
 		hal/odm_debug.o \
-		hal/odm_interface.o \
 		hal/odm_HWConfig.o \
 		hal/odm_RegConfig8188E.o \
 		hal/odm_RTL8188E.o \
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
deleted file mode 100644
index a70fda30a24f..000000000000
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/odm_precomp.h"
-/*  ODM IO Relative API. */
-
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
deleted file mode 100644
index ef96d577cfa5..000000000000
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef	__ODM_INTERFACE_H__
-#define __ODM_INTERFACE_H__
-
-/*  2012/02/17 MH For non-MP compile pass only. Linux does not support workitem. */
-/*  Suggest HW team to use thread instead of workitem. Windows also support the feature. */
-typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
-
-/*  =========== Extern Variable ??? It should be forbidden. */
-
-/*  =========== EXtern Function Prototype */
-
-#endif	/*  __ODM_INTERFACE_H__ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 22299f167af8..a0d5e870c11a 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -24,8 +24,6 @@
 #include "Hal8188ERateAdaptive.h"/* for  RA,Power training */
 #include "rtl8188e_hal.h"
 
-#include "odm_interface.h"
-
 #include "HalHWImg8188E_MAC.h"
 #include "HalHWImg8188E_RF.h"
 #include "HalHWImg8188E_BB.h"
-- 
2.34.1

