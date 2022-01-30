Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9644A3854
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiA3TDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355543AbiA3TDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85FC061748
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m4so36106419ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxj0iB/eMUcfNUAgzK18y+5Dk7DeQji/c56lMFl6ONU=;
        b=K3Onn5NEayj+wNxch/QvAzA/AeIJcpp1mlFkdh+ruahgGHmX23B/v9cu5cqH9RKcX8
         RRQHgFViC48JwugRg9BENIUJpKgBCxxYBQlgXeUr7xZ7GqrzjXAkYSeu/1LNJfjkgepf
         rMgUrEwsQ94dMOosZIXc5rC92+iMtsmDGY6a6cuAcVYTi487sLccJKCihf+38V8rdyDu
         FAhuVL3HlK7Z3XQFfkhr0Q7SOcQEDzqir+nJjqFM2FQO/8zbq5UtnzeYF4bQRaaKuh6v
         SRByIQxfO3fX4QjZMnjZiwOgkYbK6nxd2R+1JLC8SWYpg6u0CXdG4ls1VvM8pfos+U9C
         DZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxj0iB/eMUcfNUAgzK18y+5Dk7DeQji/c56lMFl6ONU=;
        b=KgT9JSsnJs6//rau7570PB0oYR61Rcyfdd79aiuimCxOrFIUdSwuK2oyWHg5pP6E4R
         wX5cVaoSkpronQqGdOohmLlKfQory1/Ed2JFN/F09aaumLRpMm2fUKUF3n5aTfAwThjL
         h1l4Whm8a9K4LfQXpHdFTg0nUF/NUPTsQpZedsYdvcLUMNTZCoBUNDhhqXoN7t2YBoKa
         XIupNy8Z9NKXlDvix1kY9glqlXsDNKLHm1OZfHwpvM3BKv4Fob9BGSFdTKLjgLy0KMzV
         0NUPSIYCqrOQkHDKR5ULfy3viod5m53YjzSLS8uFjT1+4Ip2xsl2WhN1IgoT5bNa9Xtv
         W6ZQ==
X-Gm-Message-State: AOAM533ej7CtZdiyjc66a/O6MiRi2NY0qxk4nKvLYcR774cfnF+4Hyhx
        OKlxtknlzwcFTEffnOiTf8m+xNoTz9c=
X-Google-Smtp-Source: ABdhPJyZW59ublDLOclsFrgWGOh4x3ST2X8l5hkUCNSELgdG58yJEeHDmgDKIyl5jFIH1H5noAUK5g==
X-Received: by 2002:a17:907:7da2:: with SMTP id oz34mr7580751ejc.400.1643569416541;
        Sun, 30 Jan 2022 11:03:36 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/12] staging: r8188eu: remove HW_VAR_CAM_INVALID_ALL
Date:   Sun, 30 Jan 2022 20:03:12 +0100
Message-Id: <20220130190321.7172-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_VAR_CAM_INVALID_ALL from SetHwReg8188EU() and call
rtw_write32() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 4 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h   | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index d40669c21fc1..34d271b737e9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -429,7 +429,7 @@ unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval)
 
 void invalidate_cam_all(struct adapter *padapter)
 {
-	SetHwReg8188EU(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
+	rtw_write32(padapter, RWCAM, BIT(31) | BIT(30));
 }
 
 void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
@@ -492,7 +492,7 @@ void flush_all_cam_entry(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	SetHwReg8188EU(padapter, HW_VAR_CAM_INVALID_ALL, NULL);
+	rtw_write32(padapter, RWCAM, BIT(31) | BIT(30));
 
 	memset((u8 *)(pmlmeinfo->FW_sta_info), 0, sizeof(pmlmeinfo->FW_sta_info));
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1fa57354389a..bdadd9588c79 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1332,9 +1332,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_CAM_INVALID_ALL:
-		rtw_write32(Adapter, RWCAM, BIT(31) | BIT(30));
-		break;
 	case HW_VAR_CAM_WRITE:
 		{
 			u32 cmd;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 5fb0143c86fe..0a687fa4326d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -29,7 +29,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_SET,
 	HW_VAR_DM_FUNC_CLR,
 	HW_VAR_CAM_EMPTY_ENTRY,
-	HW_VAR_CAM_INVALID_ALL,
 	HW_VAR_CAM_WRITE,
 	HW_VAR_CAM_READ,
 	HW_VAR_AC_PARAM_VO,
-- 
2.34.1

