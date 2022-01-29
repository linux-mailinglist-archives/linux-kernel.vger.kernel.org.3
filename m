Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893E54A306C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351528AbiA2QFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351513AbiA2QFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:05:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B480C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h14so8849027plf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnbU93vWGV651EUjlzxYJgD/J8Jnot+F9jtiMaEhyAI=;
        b=DoCu4VSTL/VXy1qaQWua2z8oAd/y6fgGWU7W5ZR8KskvW8xP480BlgXc3FL7fAoc1A
         LKKK5eZ0XC3o/3q2ykRBc30nfyHVbmLcfT0OwIcjFrQ1FfgK/mLyBwoiwlMJ2O/4WDeY
         cuzIcYgZ++sYothW7hU3FUsb6yehknz49JTflbzwmPoKttL/r67dTwcGmiRP2QhmN3ZB
         DMdhY2v6W4ikEqfYad2LIB+2Fw+9O60CiE+DrLZvtw3tWIX7svbZrj2CYX59AsHRaHdO
         xfTbho91ruL2hPmGNjOdQyjIyLwRluI1ihrde2hTA2lX8S5Yw/7O+lToCwUzQee0tVao
         JQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnbU93vWGV651EUjlzxYJgD/J8Jnot+F9jtiMaEhyAI=;
        b=oPZumd2WmuLpR9Fh2E1k2DoMBY9AP1HrKWZdr5BjvoXeiWfXuv5X5c9EYmPCTxol+/
         t7qCZpkLOMRXT/sMAo1QYCoMKXdrcPccnummBOcQ8aUvO8q4bnjkiWRjtQ5be77xsRus
         nnZAo42bVOc4s9vhsifpkJslfZzJ7NxJ+GUh2JUm6duBrs6xO8+v9VllVafhai5nWyF8
         +J+gAeyIgiLX0wDupl5FzczDMFsse7dpDHMvcrvxE3vfSOF+LVv5bP4+sxRQQ1DeTy/m
         B18Uol5C2wu8svbVfwsGmGZ2jFQ4DM1Tm7ag4a0c25ubDidjsbxIi2nTi0U+qTkspfqa
         gcjQ==
X-Gm-Message-State: AOAM53000Ul8npjyLsSuk5j8qteLO3BQu3q2giXGSlkl/DzfQVsinxV1
        11k6w/mZofySnnOt+fLrlyk=
X-Google-Smtp-Source: ABdhPJyUB/YePSOX4rrwQOnm1FOUbvi5tDeD6LRqBCNKxaRa588oXCVIUfazXLkuNrGtoVcuJzywPA==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr15556737pjb.243.1643472342592;
        Sat, 29 Jan 2022 08:05:42 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id t9sm5672868pjg.44.2022.01.29.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:05:42 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/23] staging: r8188eu: remove unneeded variable in rtw_wx_get_essid
Date:   Sat, 29 Jan 2022 21:34:07 +0530
Message-Id: <d0208689dffce91c52afbd5938b2704a8b1b554e.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded return variable that is initialized to 0 and not
assigned after.

Found using Coccinelle
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b9f9698d70cf..3a60e1f81592 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1383,7 +1383,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 			      struct iw_request_info *a,
 			      union iwreq_data *wrqu, char *extra)
 {
-	u32 len, ret = 0;
+	u32 len;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
@@ -1399,7 +1399,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	wrqu->essid.length = len;
 	wrqu->essid.flags = 1;
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_set_rate(struct net_device *dev,
-- 
2.34.1

