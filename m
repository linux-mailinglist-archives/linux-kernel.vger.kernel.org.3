Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B824A3855
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355800AbiA3TDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355562AbiA3TDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C06C061749
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me13so36110979ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEfV06ahonsBQJ0GSyBXy9Nohpt6e+HGvZCgdOKH2uk=;
        b=jzBwIEQAeLJSSiE/JfnVKiEzdMRNfH8uoxLD9L5kWkB9XcYRFRcezhAw5if2jz0Guq
         0a7RApKVksG5mFhf4sb92QceI5A/W3+0kBryEbWScLYtqMcKB+Ms2D3y+cWxr/Hp+EGR
         PzxKoafUcM1ABF2lh8byOLatDz0d5heQkdXXCdGym1aBqA3RvMthAEiZdwQ3bVJM70Tw
         43ms2JKjpD2KH4u9SxYj3YUBwpo2dUBXaeN7OO3SJ+8YUPW+1qEvPiM9K0xM43IQZMsw
         UwTPt2GdEzlPFla9hiKBmcJI3/jnSsurHW1Mh6wmX0sJ+Y7fURbtLLjXufZ7+uEK30ye
         zk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEfV06ahonsBQJ0GSyBXy9Nohpt6e+HGvZCgdOKH2uk=;
        b=PBVcT5+JSAZW1ef94ZLOtC14ngj5td7FswYEyMlVLQvnX2kNJKRvzzXAUKtC+kgu4/
         KUGo6ros+5Ci6fjTE+4nyTW7B5KjoIdCKnIzuaU5bnxxE6haGxyOVmc6jf+c3s08Y0kv
         kPSbqRJgyEObwEnpESQrg5vW5ueTzcf2x/zRCxYCeYz/0e0ZyE7twG2bfVZho66x4uEs
         Bf3D5BwN3d0F5FAw2ueVqWQVa9vKRGBnVi69hVY4tV8qEV5HOd0NNpNNvcFB5/yRACLP
         HfQDD6o778WDQwvnetn/aj80hIOlVt5mnaQtsh2qV7YVf8DmNGycl4OJbPnllEsCb789
         3kyg==
X-Gm-Message-State: AOAM531IX2TiRxo4UUKXwvDqnI30IIONb3UtzENCqO2hcrtZ/qJIeJmK
        Vnj18CrEq0f7gEtdrr/hZvw=
X-Google-Smtp-Source: ABdhPJxY/NebjkBrz+nz7MRwBs+KzOd6JMiFu+84EVl0qwuxLIv7ODjZWT2m1audC0bFdq0eEEM3Vg==
X-Received: by 2002:a17:907:8a0b:: with SMTP id sc11mr14055828ejc.310.1643569417311;
        Sun, 30 Jan 2022 11:03:37 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/12] staging: r8188eu: remove HW_VAR_AC_PARAM_VO
Date:   Sun, 30 Jan 2022 20:03:13 +0100
Message-Id: <20220130190321.7172-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_VAR_AC_PARAM_VO from SetHwReg8188EU() and call
rtw_write32() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h   | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 34d271b737e9..a09a4a5d7dc7 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -567,7 +567,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_VI_QUEUE] = acParm;
 			break;
 		case 0x3:
-			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_VO, (u8 *)(&acParm));
+			rtw_write32(padapter, REG_EDCA_VO_PARAM, acParm);
 			acm_mask |= (ACM ? BIT(3) : 0);
 			edca[XMIT_VO_QUEUE] = acParm;
 			break;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index bdadd9588c79..4af44f0d10c0 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1342,9 +1342,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, RWCAM, cmd);
 		}
 		break;
-	case HW_VAR_AC_PARAM_VO:
-		rtw_write32(Adapter, REG_EDCA_VO_PARAM, ((u32 *)(val))[0]);
-		break;
 	case HW_VAR_AC_PARAM_VI:
 		rtw_write32(Adapter, REG_EDCA_VI_PARAM, ((u32 *)(val))[0]);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0a687fa4326d..c2df72e91701 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -31,7 +31,6 @@ enum hw_variables {
 	HW_VAR_CAM_EMPTY_ENTRY,
 	HW_VAR_CAM_WRITE,
 	HW_VAR_CAM_READ,
-	HW_VAR_AC_PARAM_VO,
 	HW_VAR_AC_PARAM_VI,
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AC_PARAM_BK,
-- 
2.34.1

