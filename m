Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF04A3857
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355863AbiA3TEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355631AbiA3TDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so36012657ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6O9P4Kn3wzm5lIy7NIDIKwmOMq5SzJG+TZSo9CxgId8=;
        b=Ddhz1OwGjmXtYEI7suKaTmxXESQgm5tcS1Ejzb/nuKsQLkDzk3GXMstz+jinBK/R2l
         MmgEGFR7llBRoYe6yILkxTSbwxhgn7W1tplCKEAe02SjH/holnPS7h17MouXbQSi+XHP
         CWu7710SoiOrmJh9YRDzOgzVKuJubZNNSAHVYCtPPXUpdpLD/54oU0iaIz7QGYrmpBrz
         NfL6BA5lihH1Ry0EVsh/vMoBYGxzVTULlxaiyykzhvKDbbIqOn3H0pp5tg2HqWu1QJrI
         U9LaCaobBbo3VXuEELpF8Uk/NDfmg21akFM95slHOYixiilIee8dGoMDw7qRYkgGj/b7
         p84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6O9P4Kn3wzm5lIy7NIDIKwmOMq5SzJG+TZSo9CxgId8=;
        b=I8WNifJO3bF2EFPudeOznCv582iwx4xQL/v3b7rJVIQtol52y+GfsT0Z57VuGxz1ks
         9sPPJXe6Vbe92Ec0ROeELzocW01YzDoTam4Zba3ksHXzWh//LDr9wmDHmvqfSqsMvav0
         VXz9McKudlqtNqda0GNgVZnrlUannAIJZF+gfiIj7UdAHEEAshrJ4sLjWaSMgMoRfdvp
         2Q2sMAhakUH6rZ92h0+VM9R52Fa3KYpmCOPoWxQBE3X2eBuh6y54wrRM5HHcGVyaxmVn
         N+F6XmAdapRDBI1S4Zq2BbmcTxBh1+rWkTpMnayY2IrunMDRkocxx/gJmOzKW1EKw9eo
         n1dg==
X-Gm-Message-State: AOAM532qG0b0zZ8hOdDskZD138RlEb30aCN5wEohNrEWXkb0bsKozAhn
        5+9w8Ix541V1LAwKQCWXMaM=
X-Google-Smtp-Source: ABdhPJw/y5MTRn6TA4GvLFeY4yLkecZYWSgilPqzGI9fa++8QTlZWpkwniwsyidm4WRwxGB+wuQSTA==
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr14987414ejb.325.1643569418851;
        Sun, 30 Jan 2022 11:03:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/12] staging: r8188eu: remove HW_VAR_AC_PARAM_BK
Date:   Sun, 30 Jan 2022 20:03:15 +0100
Message-Id: <20220130190321.7172-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_VAR_AC_PARAM_BK from SetHwReg8188EU() and call
rtw_write32() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h   | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index ac1ab5c6b169..62a96e59b00d 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -558,7 +558,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_BE_QUEUE] = acParm;
 			break;
 		case 0x1:
-			SetHwReg8188EU(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acParm));
+			rtw_write32(padapter, REG_EDCA_BK_PARAM, acParm);
 			edca[XMIT_BK_QUEUE] = acParm;
 			break;
 		case 0x2:
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 82dc0324fbab..3d05bae459b7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1346,9 +1346,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		haldata->AcParam_BE = ((u32 *)(val))[0];
 		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
 		break;
-	case HW_VAR_AC_PARAM_BK:
-		rtw_write32(Adapter, REG_EDCA_BK_PARAM, ((u32 *)(val))[0]);
-		break;
 	case HW_VAR_ACM_CTRL:
 		{
 			u8 acm_ctrl = *((u8 *)val);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 03566f317513..169f1cccafdb 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -32,7 +32,6 @@ enum hw_variables {
 	HW_VAR_CAM_WRITE,
 	HW_VAR_CAM_READ,
 	HW_VAR_AC_PARAM_BE,
-	HW_VAR_AC_PARAM_BK,
 	HW_VAR_ACM_CTRL,
 	HW_VAR_AMPDU_MIN_SPACE,
 	HW_VAR_AMPDU_FACTOR,
-- 
2.34.1

