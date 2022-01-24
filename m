Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA249A9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1323791AbiAYD3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349611AbiAYDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:17:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749EC034610
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f17so16422763wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=2T+hohDmYoqKFEv3Cv8ZgMQ/mKlBK/a8qNahYuYbb1KIy1ff+H7NPM5NU/qqMnh1nm
         //4lCh+8o4FQSiEge38h2NQSPwbd9gv5iK42Ro+jCgnNkMMkwu+L3qKNcCoQiRoNycYC
         Zke4hjtQnFbhjLblnbWF9+46jR/Fn/gM11g0itXYbO0z1YQBjVgPJCCS4SZqc8kDsKfW
         5wmLXZskPAyp8NPOH4SXftDPH1XejxkYq6Otj3iJt6dfnMahe84KAWWUzzkhZrfxdmV0
         tx6q9FGcodrGjLlTUbBfSYTvBvUYxzopL+0wmxFAvE08M+DOsz2R0ZjsRWzblckfAmaS
         hBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=Phba/22QRi63ulPg48+UmND84ZrtHM7ljBtoF26vrSUAf39NjJu1YwT+OV0n1fWg+y
         6zZJan+WhUgr0K02hUl8Ar1/WUmRxEi0EQ8rCqfg3NBnXFjDdOCwIQ5fMHR3IqS974CU
         mugBXedhP+fCwYdbWKsQRTv/9WW6orJAHp3xJlO7bs7rauakMy4L7IT8mVy7rl81DxKN
         g2LAakRtya35+grePL2VKAs+I4rDvEIavhmGfDPhPZMihYlCLqYEJDf4qFZptghdjuKb
         YD7zQMwWh8iLxucx2vmFSVwWyiQoF6/jyb0xf8vSNkAgBn9jApVK69ZsI0O9lxNplUO9
         19fw==
X-Gm-Message-State: AOAM533YFFOnrwzQWHWGvMZrRI+CigrnCOAXM5bxXRPWx66Um3yoURMT
        VwSGhKlsQzqyexYbVfGIGUVW4g==
X-Google-Smtp-Source: ABdhPJy11Hr0agn/tCEO9xF86BR6hvSBFE0Vp1eHDkwfZat/mTq+ZWfsDfHBlXjBjUggWwNbAeoKIQ==
X-Received: by 2002:a5d:508a:: with SMTP id a10mr1377854wrt.719.1643065193425;
        Mon, 24 Jan 2022 14:59:53 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id b2sm7705113wrd.64.2022.01.24.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:59:52 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 09/10] staging: r8188eu: remove DBG_88E macro definition
Date:   Mon, 24 Jan 2022 22:59:49 +0000
Message-Id: <20220124225950.784-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225950.784-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
 <20220124225950.784-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_88E macro definition as it has no remaining callers within
the driver. This is part of the ongoing effort to cleanup the driver to
use standard debug mechanisms where appropriate.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 311051757715..959fb6bd25ca 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -54,10 +54,4 @@
 
 extern u32 GlobalDebugLevel;
 
-#define DBG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
-	} while (0)
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.34.1

