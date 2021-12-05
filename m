Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497A0468B53
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhLEODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhLEODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:03:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4DC061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x6so31925405edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2glchpcv+1d/9FAJVmf1wbGz2GHlcABraoRmMcJeBDE=;
        b=b+40/mFgq7OEUK+kMv5lhAte63pNSTfefUkkc9omG6HGP6e9Hy5AvZgtXeGNkwOjl+
         ES1L7rpUNd92URj9vl42wetXf1itxhVSFYYOWyAuL6PJL6dHa4fnhcVukh56EqYa4d0+
         4tejmyixlIB6qLEpy3Txloe/gn14r0IWQr6JKAF2oiSBLq1H8S2289osefBcYDQxbSZU
         NqygO4kc37zF/V0Ay1PGSP6e2aeyhiAfkp0faB1zf/mRxyiP3y1Oqp9EbTEgRudPiGtD
         8tRt4ZA9A2AwEi7WQ805T73JdKVjD6RIH273hdlLxNK/4n/ln9eObYOuBEdPXI7Xa1nq
         ZyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2glchpcv+1d/9FAJVmf1wbGz2GHlcABraoRmMcJeBDE=;
        b=jqQ7ySS0OkZlkOSIV+F523+Pg/ZVeZWWGzvlGs8tfsmn9nMeRBxystHw1hb7zVhpDa
         LLvTpneiJiffzZroJg0D5E6X4CE+24JoGxAYJw3Pxsy4dbT7lB721HVaT0Mz+DxDcTqw
         IjFpb6OV8Y22zadlsTM+sYWqZm6G7kU8i4hmG8PyT+CwM/dIpNxNqi9Nh0X2yKkKS+aO
         myylDhPD13qFEJuWcMpVi63Ea+/zJWYekwHXPsIIgufdGD2Bj/9+nQFtH8rSCTrlvze+
         b4fbTpCbG0OYRTjsHdFiGg1dv3IWxhc6DfcWA+gVWB60Fbl/Ucicss1YjUfNwHoyYJpg
         rklA==
X-Gm-Message-State: AOAM5310M8VvrZjvMdVCNvckjSXwP9WljYMWYiK62QiJO6hpEEMUErSV
        pe9S1Z1peDjGjf6G56DMYbI=
X-Google-Smtp-Source: ABdhPJwQ6TYXOaa+6LJAwH2wJNpTaY4dqRIQNjXZbpviol3mKr9pNZDtjHg5aEjzoEHtAIZM3FAISw==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr37955459ejc.191.1638712774609;
        Sun, 05 Dec 2021 05:59:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/12] staging: r8188eu: remove unused macro IS_FW_81xxC
Date:   Sun,  5 Dec 2021 14:59:17 +0100
Message-Id: <20211205135919.30460-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro IS_FW_81xxC is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5791172fa5c4..3fbaccbbe775 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -508,8 +508,6 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	return _FAIL;
 }
 
-#define IS_FW_81xxC(padapter)	(((GET_HAL_DATA(padapter))->FirmwareSignature & 0xFFF0) == 0x88C0)
-
 static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 {
 	s32	rtStatus = _SUCCESS;
-- 
2.34.1

