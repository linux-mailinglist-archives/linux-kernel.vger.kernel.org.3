Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3D4A385D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355942AbiA3TEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355806AbiA3TDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723AEC061748
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d10so36046903eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkpzfLZXkf4Cff58Y+MCWi39G/nogDyQTUwKpV7CqzE=;
        b=AcM7N/PpcJzgUpZ3pWcXxCACuWyBKgDicwdzR1wQY9tnu0tUIOZGEF0BOG4xvBkuzi
         Uxv8NRoIF3LnhS0W24k+h0LGf9hj0FrKfgIE2yJ5vn02OUIVQF0GysWZp4EuWzM6MK3d
         YHJ+jgXkKcnIO0QwY3UufJlixPNHmyFbW2/Xm6mmXHL9GtKHBCUFSrft3LCUgyrZ6/tZ
         QLyBHwmkEumepL80X63i23yJwV0JnOIp84jh+Sh5pnFCgIuHnQu4nzt5VYuTMqhIj89g
         RbvqIFsvezp9AGJqudUzplYjXu9mkeANRZcSeXnLN6tDvsLdVZuRUHqXc4glzJoym9Xb
         D2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkpzfLZXkf4Cff58Y+MCWi39G/nogDyQTUwKpV7CqzE=;
        b=NA+2XcuiIWY1ue1UoLFTWjpeWthOTf2kVN2IwzbThL7T8TtLywt7JGy0xYkA6UQb00
         SYT5BLSdOGMtfJQRASuKVeqyL1RWpRbNVqGl8vKZkl2ZXIjbzwz+5vAn1MgcNar0DHmA
         VIqaAAcvL+FIm9Azsvxh6Uh7hEeJDn2TzTnKRaXgAFpbQpZlnMnyNv7xNP86qKI8Rp5o
         H+MiKlmmDJkzjxDMAaRToRE3e51aSfbGGP7kbHnFgnIfv32wOJauz2T0ipL/4F0xflzc
         +/1uUidiClhuzwfobz3OgKDGgoDuxai4dnKmUkioNDlk4vq2MKN5gfAs/U210WfYNnr4
         OTlQ==
X-Gm-Message-State: AOAM532RJhSfD9x4is1WtDtZCfEhEgNpK6u495uPixN9Tmtw3c4tKaXz
        D8Mkau1BDJalr0iB/nimzMA=
X-Google-Smtp-Source: ABdhPJxClUYmhMwbcglWbNdSaRQ6wu5KPIeYCtpTIecwhVHPk9Y2bk6OVyyxjl0vsgohgSsGMUs+cA==
X-Received: by 2002:a17:906:eb89:: with SMTP id mh9mr14643269ejb.399.1643569424019;
        Sun, 30 Jan 2022 11:03:44 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:43 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/12] staging: r8188eu: remove HW_VAR_CAM_EMPTY_ENTRY
Date:   Sun, 30 Jan 2022 20:03:21 +0100
Message-Id: <20220130190321.7172-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW_VAR_CAM_EMPTY_ENTRY case in SetHwReg8188EU() is not used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 23 ----------------------
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index bab76a92ece5..996ded880034 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1272,29 +1272,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FUNC_CLR:
 		podmpriv->SupportAbility &= *((u32 *)val);
 		break;
-	case HW_VAR_CAM_EMPTY_ENTRY:
-		{
-			u8 ucIndex = *((u8 *)val);
-			u8 i;
-			u32 ulCommand = 0;
-			u32 ulContent = 0;
-			u32 ulEncAlgo = CAM_AES;
-
-			for (i = 0; i < CAM_CONTENT_COUNT; i++) {
-				/*  filled id in CAM config 2 byte */
-				if (i == 0)
-					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo) << 2);
-				else
-					ulContent = 0;
-				/*  polling bit, and No Write enable, and address */
-				ulCommand = CAM_CONTENT_COUNT * ucIndex + i;
-				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
-				/*  write content 0 is equall to mark invalid */
-				rtw_write32(Adapter, WCAMI, ulContent);  /* delay_ms(40); */
-				rtw_write32(Adapter, RWCAM, ulCommand);  /* delay_ms(40); */
-			}
-		}
-		break;
 	case HW_VAR_AC_PARAM_BE:
 		haldata->AcParam_BE = ((u32 *)(val))[0];
 		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 5add8d100da7..cb460d8a4595 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -25,7 +25,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_SET,
 	HW_VAR_DM_FUNC_CLR,
-	HW_VAR_CAM_EMPTY_ENTRY,
 	HW_VAR_CAM_READ,
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_ACM_CTRL,
-- 
2.34.1

