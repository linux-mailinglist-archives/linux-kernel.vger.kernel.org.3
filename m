Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8074A3094
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352660AbiA2Qbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352665AbiA2Qb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA04C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:29 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i186so6501504pfe.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPVQMO6visW/k5DSDZIWEQ4IZV34Wlm68x5zMJm/R0I=;
        b=WSDNrWKl8naM+RFgkzSqxqTkKDc1jpU7DZOBA/NEBqu/I/rykIr9Yyjj2OBwDb5oLg
         Hf446toFtvEF3ub5mBeQYpLxbztATMtEsqE8aSDBCvkD+yuPFYtsQG+V89Qh4N6zOqxf
         vSjB6N7BtsMUp/JuNcqLI+QHYX6z7zfd6zbiOxkbHv4+HVqeD68zMYbag2bOCMNTG8di
         jb7RCfqjDFDftbr0nuNC+7QqxZWDvzYysxMWdKB6lsgfKoXXIUwR5MwynE+yBFrQeKDZ
         PDdp0VkzGxMFOwEMGiA/LPo/mtjIQ5UPr02BC1DSt94Fc8ldIDX4JPif97C109OEj5LK
         yEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPVQMO6visW/k5DSDZIWEQ4IZV34Wlm68x5zMJm/R0I=;
        b=RxtRDa76g/NyuZujOJIcjlKEHc2K7/nrhsrkqQCP/gx/nvDKc3yUtfcr5UTW6exUSK
         pZWgt1jtzdr2Q57sLL/SPnoF0kZIqdPBLwU3M2l7wM4nsL0ENbLOINHI0voK3g1360hD
         WUXmOagxG/V0gNFI4wtu+ws/R3PLX62sAsC4OC5ErNr/D/teu9v3HcbOA/0Qu1SH047d
         /srcy/OfN9t4CxeRzvb1doDydbGW7z5Z6YlYc4teAH+by+eo46iC+U2mdd6MNasScPZB
         3i2Rrww2Y7ZRR1XEJNF3IKatPSuwEZD2/O9zd9ldAFfyWhn8j+b1tQlyU6Bc675QYWnh
         vo/A==
X-Gm-Message-State: AOAM532vrxXmyq4c6IYMY72gkEbBc875IxtQ7eSdsEB5/Bby2IhQNcTY
        29175nF749Gyth2f/B9kgKY=
X-Google-Smtp-Source: ABdhPJyerL4RXYIUlTQj9uW1X/4hRF6FpxS55GEMsr3DNoFwOBFgWPe+ixX32fFaLTsXMJLuk/9rGw==
X-Received: by 2002:a62:8183:: with SMTP id t125mr13046503pfd.41.1643473888852;
        Sat, 29 Jan 2022 08:31:28 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:28 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get_go_device_address
Date:   Sat, 29 Jan 2022 21:57:57 +0530
Message-Id: <26a84fbef7e06d518efc29d2cd9e3dd685c96e0d.1643466748.git.abdun.nihaal@gmail.com>
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
index b0f78673d9b7..b093430ff744 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2687,7 +2687,6 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2763,7 +2762,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_device_type(struct net_device *dev,
-- 
2.34.1

