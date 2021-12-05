Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0E468C5E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhLERSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhLERSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A6C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so33246188edd.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Woq3HlHO11za/Z8dWOzGeHMcMYdN1R19HxtEMwFIAg=;
        b=ZZuvakSXZZ01pG4mSgAMWwjQu8MLUQi3a2MZpP73gTs1HYk2KwASM5WI0bLn8ItaCT
         42/kVAwPtdeKgNczVfUd3RgZifx9OpIGuabJB1ZiSf5AOvFD/L8qth0t2cezBF+2qPCv
         vRozTX4XdDdDD5mckNCZa8ZrqzbWkHAtRGL08Ik1hh1h+1+LVOvGN1yCy0aEn/h9pxSo
         ADJG+BSd9qhaxHIkfMJk9g3yXHOapA2cIyCDI+402T3GEhf00nP2qln9GHRNIIcR67jH
         p+CVON8FbWXEMuzEYPtcTXx5hG/QP5rRKp3XjSiBJzFH6KcPUhkcSyFii83jnID5GZfx
         A7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Woq3HlHO11za/Z8dWOzGeHMcMYdN1R19HxtEMwFIAg=;
        b=rKbG0I8HVMeE1yJSCS4B+eLeapHjP64AAgjhOxT9LwayB/J/Agi4MVNr5rV6nmLgXN
         eUpQ6GKf6iZT/wxnzI+8ek4RsIUIxC8DZAeLrGBfSLOTg6AAPkae2mN839OJt92u4Z4D
         e8izqhZHxGDtCVVEhgQCGUSDXfYte25M8JFSEWKOOw0g97GFYkapUA5RLdQCCF7GAOsx
         3qbk4YdXmwQkHtm/PnF5obUWPRmkCJTFxSR1ymuRdQxHeWyfGepJH3XCe6oImbwZLKu0
         0+FMvsss9cjm9rIuNYbR/o0lvCFta+MNyh/CUR9HvjMs/QSQObMK4hobaK3vExx0RudE
         xFZQ==
X-Gm-Message-State: AOAM530iKtLdwnJYVYFKAD2ev4XGcVou08u1RBDYj9qlpy/Di1Vtg2YV
        0RBU0/pTq/5ufrMG1gG3LVk=
X-Google-Smtp-Source: ABdhPJz8aFC18yk1YvQ47BDoZz+kT1vbI3rr82ngQ///0L5gOHTBcy+O5KYCLDGb+T5D0In6RW7eZA==
X-Received: by 2002:aa7:d5d6:: with SMTP id d22mr46674724eds.364.1638724478399;
        Sun, 05 Dec 2021 09:14:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 07/10] staging: r8188eu: remove duplicate defines
Date:   Sun,  5 Dec 2021 18:13:39 +0100
Message-Id: <20211205171342.20551-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following constants are defined in three different header files.

IQK_MAC_REG_NUM
IQK_ADDA_REG_NUM
IQK_BB_REG_NUM
HP_THERMAL_NUM

Keep them in odm.h and remove them from Hal8188EPhyCfg.h and
rtl8188e_dm.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_dm.h    | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index f4cfd11b36c1..addc6a5354a6 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -11,11 +11,6 @@
 #define MAX_TXPWR_IDX_NMODE_92S		63
 #define Reset_Cnt_Limit			3
 
-#define IQK_MAC_REG_NUM			4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM			8
-
 #define MAX_AGGR_NUM			0x07
 
 /*--------------------------Define Parameters-------------------------------*/
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 208bea050f6f..0b3a9a1a4e5c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -8,12 +8,7 @@ enum{
 	UP_LINK,
 	DOWN_LINK,
 };
-/*  duplicate code,will move to ODM ######### */
-#define IQK_MAC_REG_NUM		4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM		8
-/*  duplicate code,will move to ODM ######### */
+
 struct	dm_priv {
 	u32	InitODMFlag;
 
-- 
2.34.1

