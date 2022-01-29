Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299EA4A3096
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352670AbiA2Qbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352668AbiA2Qbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 192so8978741pfz.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6tVV3EV5GZ5J/+KxHkNVwDUV3xfQLU/3YBnbUf4aGM=;
        b=hCgYXrv6DRbcOuxqv2dfwWHpSTMEEg8Mpui5vyFv4gqzTslH62lPPj3eU3lPodSzzj
         20JNikaM7qrs5UqzNvhdJl2HKidG0ehRxcTX/Szw1ZtFQ5eonVSrc6SM7qd7TfYyN9R4
         fMswRD1VjIl6WZoJ9U4Uo5szk31jVCfL/Rp/9JpWcfJvZZyAg+4ZlUqF2yqBAx1vJJ8Y
         6ETl1ssSso0uV8KSoRFJBjFVwlgfb7s+Q9v33Ezd0zAM0tfa7JlB8qwxU9X6fYc+VJK0
         pIklOaTv6E2+//ppXK5jjQRBlA8xXkGg5zvqXaZk1eHptON7+6cW7DWRsSp1DrGq4xIq
         sYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6tVV3EV5GZ5J/+KxHkNVwDUV3xfQLU/3YBnbUf4aGM=;
        b=Di6cqMM9PJ4jZpUU69abvdHynTfwbF8OFxBTqdwJZj4yuivwSEUB/nQ9v0Wh6Jrgof
         GTCf+43y5ZQBycexDR9sUX9X+zwHQR/qxT1CpZlP5g+XGOS3og1eCBb5yUKxEUa0sfxv
         WyXuKX+LnlYtk8B+MqFU9i/SCF37JziJJuRR8tTocIxctc+pwbgE8nkTq+pBrvLwO70b
         ka0wspaxCF0InXVKvCImFg1FFSVvkUarglJAqZYA5/K2Ry1xGyDUkcnMn3emZhnvlFHl
         EOnFHZwMx9Yq/Zyy8FHfLJ5ZxQol+Oojea1BjDO0wAASXZc3EQhiJN7BSJfiP0FRvRIw
         cePg==
X-Gm-Message-State: AOAM530NbM5ihUGAAEuBTYGP28+mzcFnr9JJV/WbJ7duOL/xxydFBomJ
        nob5sOFwfUlgKlPgmK/DhAU=
X-Google-Smtp-Source: ABdhPJxvSzeza5iycL4aC4oHZRG2A7r2dKzZSFqF4ywHytGL0mAiZoaR2F6CsnK03S0PwkJr7xmO5A==
X-Received: by 2002:a05:6a00:1ac8:: with SMTP id f8mr12890844pfv.7.1643473896998;
        Sat, 29 Jan 2022 08:31:36 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:36 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_name
Date:   Sat, 29 Jan 2022 21:57:59 +0530
Message-Id: <d94c3029128b9c094bf4e0b2e4574a177aef46e9.1643466748.git.abdun.nihaal@gmail.com>
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
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 6d72b15541ab..33fe8e944df4 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2844,7 +2844,6 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2903,7 +2902,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, dev_name_str, 5 + ((dev_len > 17) ? dev_len : 17)))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
-- 
2.34.1

