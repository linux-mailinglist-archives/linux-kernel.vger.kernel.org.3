Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4D4A3856
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355825AbiA3TD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355573AbiA3TDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:39 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80163C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r10so22694846edt.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWKC8EYtadWC+XGVduMfPXQkoMLfg/diQ6x5K2CsNlg=;
        b=g4pdwXr4gipw3Aw0TAzR5Ia26hePTyoFqBjjR5A+tyMOS1fUXpP36QgLhK9nugIb9/
         KspkISq4y202PbWPtFHWiSydoNlTGdQpkRY1n2XbXRg1ma066UfI2+Wo+LBDYfiMbiA4
         IE/V95hqiTrjMKMNYmx0pYeNNcitq6pGe0sPwUKmAYyPvXMLtKxMyKBSlgdhzi9MuFHi
         DQzYOoNiTVEAA1eoUbaHdLZQEpd34zdm2JEhLTCyAdldkc6rKs8KAuz0RO4GEh2aU5jN
         g1t8rLGr1XxnUOnDloi8/IFJvyuk1WMnehZCoNEUuVYoww9IV443Hk4cdeOPWQoCbzyP
         1RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWKC8EYtadWC+XGVduMfPXQkoMLfg/diQ6x5K2CsNlg=;
        b=38gsjmY8Swd4NNUOdbBnG+PEKaHjm6aGWXbu1tJaBeAkdGU1P0b3TiPYEOUio/X+7Z
         ygq71Pag8Ei7RreSAX8DUlYXv73N+SC6XoYoJbB0cbnvt1IsBwfZi7+gu4jYGxkP6+Vj
         vUeHAxPpaWit83FEWP9uydpKa0KEo7t+hRIvksTGH8L5qXOOeWfqNPPT1miecysPU929
         IjPEzdfhT7AlNGvdBhDs5hUyiS5KemTXJX6IOU7yAV+Uax4jX6pCe6jKcGZuMOJ0MpCd
         Xh1v9lrM58WkEWVlTcA1CW+xBl1wieDGK3VD4bv/618fq/VzJ2U+V17LwNGeH8j6rwfK
         sPQQ==
X-Gm-Message-State: AOAM533p3HJ+SfO86RvLfKHSG6KBk05WKR8hDgi/K9NAhpKt1d2jNv+T
        IkfmJ78MzOw4BocdYU8/3wv/JhkpSqo=
X-Google-Smtp-Source: ABdhPJxjqA9ClXlm0KoCtzlrvLlHrIyubx4WMVqLWfmViGIyO0vpqBgpOGAWcwFeEe9jLEl3SKTbmA==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr17384039edz.195.1643569418088;
        Sun, 30 Jan 2022 11:03:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/12] staging: r8188eu: remove HW_VAR_AC_PARAM_VI
Date:   Sun, 30 Jan 2022 20:03:14 +0100
Message-Id: <20220130190321.7172-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_VAR_AC_PARAM_VI from SetHwReg8188EU() and call
rtw_write32() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h   | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index a09a4a5d7dc7..ac1ab5c6b169 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -562,7 +562,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_BK_QUEUE] = acParm;
 			break;
 		case 0x2:
-			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_VI, (u8 *)(&acParm));
+			rtw_write32(padapter, REG_EDCA_VI_PARAM, acParm);
 			acm_mask |= (ACM ? BIT(2) : 0);
 			edca[XMIT_VI_QUEUE] = acParm;
 			break;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4af44f0d10c0..82dc0324fbab 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1342,9 +1342,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, RWCAM, cmd);
 		}
 		break;
-	case HW_VAR_AC_PARAM_VI:
-		rtw_write32(Adapter, REG_EDCA_VI_PARAM, ((u32 *)(val))[0]);
-		break;
 	case HW_VAR_AC_PARAM_BE:
 		haldata->AcParam_BE = ((u32 *)(val))[0];
 		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c2df72e91701..03566f317513 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -31,7 +31,6 @@ enum hw_variables {
 	HW_VAR_CAM_EMPTY_ENTRY,
 	HW_VAR_CAM_WRITE,
 	HW_VAR_CAM_READ,
-	HW_VAR_AC_PARAM_VI,
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AC_PARAM_BK,
 	HW_VAR_ACM_CTRL,
-- 
2.34.1

