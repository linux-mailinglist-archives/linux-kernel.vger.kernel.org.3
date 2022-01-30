Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BEE4A35E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353675AbiA3LMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345648AbiA3LM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:12:29 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E5C061741
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w14so20957176edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1AVN0e7+wSCiMDsgVXe5hxd5jK8h7WXEx+niad3RkKM=;
        b=WIX5Uw146iMBjci2EHosCeX+KCz9g06Fel/rdo63DdjpuFbWYHM1SSYBgRT+7/4RNN
         1x2lQmXMS+9KwyjU5b1+PUZaNZd+Ri/6PUDxm86TsVGKijnhwQllx+ja0XBzJKcqUJp7
         dZP/rT+tollXnqjSujFZgaC2wCHO0m0YZNVEOtLnKb5Ne9qj9JSD/L4oNMQnEyps9Dzi
         LrTQPn0EhIm5pbjLHljeDjTgGVXYV2jjupfb2lpbVD+xCLoeo2GgR/8nw4y6NuIJdsMc
         2F2DE3qOjfL1WH3WJjlQu1WIUZTM2oaHAntTa0i/3W2xsIVsrGENMJuoBWA0dxR8qajh
         HxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1AVN0e7+wSCiMDsgVXe5hxd5jK8h7WXEx+niad3RkKM=;
        b=4r9IrlF25LVr41yPIEqwWbE1RqNAPu/UU6ljzMY32clsft3J4aOCuz8LXz5iXwrUqY
         AQvCHVt68SaCSBuE942vLgHx4ijmCAyNDZMk3ir1bL1A1+ltIKTknHEgrwF/Q7UinufJ
         W4G5KC1MzF6TZZ4+vtFM1aDgMNioxEcO2OQZaZmNjMOXajzF5leevG56uS3HHyeG35AE
         AfKx8hL8HGu2Ev6g8Fy5Ui9aTQ+okuZJvoEOVD0KG26qf0rHjB/+HIZirR7Ya905yxmd
         ME9RL3omTZls5k/2AoGI0sqR9e/odCvanWFl1ftv7PLIKZX27v8IQqaq9GBWAvLDYxwz
         w0Mw==
X-Gm-Message-State: AOAM531t353ePWeImdgdo5YHXHsxScJkbTPqa3DwJqJViqw6yI60X/C4
        H7v07emGUM41c5QuCMByGIA=
X-Google-Smtp-Source: ABdhPJxLt2+gku5XsKep2reM7iU2/MjVVZqNEs/B6nGbEk9D0CC14SZ5FQ+XP+5xm9xdbAeiCjijbQ==
X-Received: by 2002:aa7:dbcc:: with SMTP id v12mr16266757edt.263.1643541147394;
        Sun, 30 Jan 2022 03:12:27 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id nd9sm12129510ejc.169.2022.01.30.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:12:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: remove unused parameter from hw_var_set_*
Date:   Sun, 30 Jan 2022 12:12:18 +0100
Message-Id: <20220130111219.6390-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130111219.6390-1-straube.linux@gmail.com>
References: <20220130111219.6390-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused parameter 'variable' from hw_var_set_* functions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3aa5289a61f0..c5282603a42c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -970,7 +970,7 @@ static void StopTxBeacon(struct adapter *adapt)
 	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
 }
 
-static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
+static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 {
 	u8 val8;
 	u8 mode = *((u8 *)val);
@@ -1027,7 +1027,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 	}
 }
 
-static void hw_var_set_macaddr(struct adapter *Adapter, u8 variable, u8 *val)
+static void hw_var_set_macaddr(struct adapter *Adapter, u8 *val)
 {
 	u8 idx = 0;
 	u32 reg_macid;
@@ -1038,7 +1038,7 @@ static void hw_var_set_macaddr(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, (reg_macid + idx), val[idx]);
 }
 
-static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
+static void hw_var_set_bssid(struct adapter *Adapter, u8 *val)
 {
 	u8 idx = 0;
 	u32 reg_bssid;
@@ -1049,7 +1049,7 @@ static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, (reg_bssid + idx), val[idx]);
 }
 
-static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
+static void hw_var_set_bcn_func(struct adapter *Adapter, u8 *val)
 {
 	u32 bcn_ctrl_reg;
 
@@ -1078,13 +1078,13 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		}
 		break;
 	case HW_VAR_SET_OPMODE:
-		hw_var_set_opmode(Adapter, variable, val);
+		hw_var_set_opmode(Adapter, val);
 		break;
 	case HW_VAR_MAC_ADDR:
-		hw_var_set_macaddr(Adapter, variable, val);
+		hw_var_set_macaddr(Adapter, val);
 		break;
 	case HW_VAR_BSSID:
-		hw_var_set_bssid(Adapter, variable, val);
+		hw_var_set_bssid(Adapter, val);
 		break;
 	case HW_VAR_BASIC_RATE:
 		{
@@ -1122,7 +1122,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		}
 		break;
 	case HW_VAR_BCN_FUNC:
-		hw_var_set_bcn_func(Adapter, variable, val);
+		hw_var_set_bcn_func(Adapter, val);
 		break;
 	case HW_VAR_CORRECT_TSF:
 		{
-- 
2.34.1

