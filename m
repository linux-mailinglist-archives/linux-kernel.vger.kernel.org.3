Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756549AB40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254887AbiAYErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S246822AbiAYDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:48:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B71C03463D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i2so16419605wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97GwBkpfkEyDXPs9Xg2PMr7/QxnDaM9vXKCUdcNdzlQ=;
        b=cSB/z8nP/EPc8vBGTiIFEGRg/yxgfdchoLPkyLa1lG+cSSReAzP7a/9R8Elmp7Kulm
         JG+LmFDnVugXtHjs+QyFPhBXjDyArt1hznXnBx/9rgQAKEcIaFJ0U6JyqutSlWo5Sxzo
         a0VK4/ntJX7TNCEjmd8eCgI/9ovhaFx6WCvcTTHO+coo527Q+wR8adfQL+hBEsW+GY6T
         BZ5pcuFO2gVBcF/DwRIyj8bmBan/7pVt6/vp/qep5yaiSmSygRYxezQ69BsGaaUJKjaM
         oP4IIcDFbLgvX91ujzIAzC/Cx9pqactPorRoUtlaeFUnB57NSRwqp7FsFW/MO0DwKd7c
         iCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97GwBkpfkEyDXPs9Xg2PMr7/QxnDaM9vXKCUdcNdzlQ=;
        b=p3cAoKOpfdpA8fNHWEbv/H9/qtnng5K2YnPASWYfQxLxQdoS0H+1F7wrioMwpvR8wb
         Q5AcZRxQbXbhnk7Vbe7/aeR6KgzJi99UwLfe1EX5YaMAQ0fpgzNgj9WjImUfeEC7iMss
         tP+nFGXgXeSLbxDoUtkbnkLQzh78nbgeKB4zhNGn3hR/lH5uf3dFrsYV3GAcJDcUQ4Rv
         JXlhApzjks6yT+w4k0qeDJVz6iBS5VzC7J+eV0O15ayFGPk1fSssFlxlLPYSJMUYiqW/
         ozCJujMXMFw7RQv3K53XLmY66cOG0BOdFmt+VsMiZr3EBR7YsokCy5eGi2EK3irzkH0i
         LKZA==
X-Gm-Message-State: AOAM533SuEpZP+M0cdy4D5mS8dAS+mbSvfhI+tgUHBdBeNo3qVOF9gMo
        7/kRxOcIVwDTXpttD2w0PlSZ/Q==
X-Google-Smtp-Source: ABdhPJxvj4y/r67o632Jti5YKslam0A/xl/LO1syWrSwgU80Ex12QDWGkYInS4USMDbVXhya43ch9Q==
X-Received: by 2002:a5d:6d4f:: with SMTP id k15mr15999516wri.345.1643065194697;
        Mon, 24 Jan 2022 14:59:54 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id b2sm7705113wrd.64.2022.01.24.14.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:59:53 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 10/10] staging: r8188eu: remove GlobalDebugLevel flag
Date:   Mon, 24 Jan 2022 22:59:50 +0000
Message-Id: <20220124225950.784-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225950.784-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
 <20220124225950.784-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal/odm_debug.c, to get rid of the GlobalDebugLevel flag,
and remove the two other lines that reference GlobalDebugLevel, as
the last remaining user (DBG_88E) is now gone. Also modify Makefile
to no longer build hal/odm_debug.c.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/Makefile            | 1 -
 drivers/staging/r8188eu/hal/odm_debug.c     | 6 ------
 drivers/staging/r8188eu/include/rtw_debug.h | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 1 -
 4 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index a7a486cc16dd..ecd6fe5bd94c 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -10,7 +10,6 @@ r8188eu-y = \
 		hal/hal_intf.o \
 		hal/hal_com.o \
 		hal/odm.o \
-		hal/odm_debug.o \
 		hal/odm_HWConfig.o \
 		hal/odm_RegConfig8188E.o \
 		hal/odm_RTL8188E.o \
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
deleted file mode 100644
index 7a134229fe39..000000000000
--- a/drivers/staging/r8188eu/hal/odm_debug.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/rtw_debug.h"
-
-u32 GlobalDebugLevel;
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 959fb6bd25ca..01a7d987d6cc 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -52,6 +52,4 @@
 
 #define DRIVER_PREFIX	"R8188EU: "
 
-extern u32 GlobalDebugLevel;
-
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 17249b4fb7ad..8589de487289 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -155,7 +155,6 @@ static uint loadparam(struct adapter *padapter)
 {
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
-	GlobalDebugLevel = rtw_debug;
 	registry_par->chip_version = (u8)rtw_chip_version;
 	registry_par->rfintfs = (u8)rtw_rfintfs;
 	registry_par->lbkmode = (u8)rtw_lbkmode;
-- 
2.34.1

