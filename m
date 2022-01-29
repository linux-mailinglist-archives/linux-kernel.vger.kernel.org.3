Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198014A3092
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352615AbiA2QbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiA2QbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED1C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so13876765pjt.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zjHCA2mlhxhOhnGWQKP59mu6FW4vaokSvYIkJkIJG4=;
        b=NWXU90bGfAUDA6hnvcDB5yiOVHb+f9xHcauQTwA8xma4HVI6f85R1CSe5QwHGt93UF
         hYkCtOtC1zkTgqdFTuVkozOgwh/ZP/3xhmwWvEMRSqkGNMoxYWbmnyWajPXkzYEQPj+Y
         k5d8KOEDxUIQ+FyY+drr/o1eCPdqEoD0rgXDbPGjrm+VdfeXD3kvVlDifqKyYFmE2Hl3
         23cM3m3Q/Mb+VH4NxUWko8dDRsEpYFugSblIxuo76jWrNlZKe8TQEyzvW5/MTm1YDibx
         UcUDnSOfpuVTjXacv+0KPW8veRh6vqfPTIlhdtyuVEgE8p4gvStyP+3AiD0D9JGAEljl
         mL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zjHCA2mlhxhOhnGWQKP59mu6FW4vaokSvYIkJkIJG4=;
        b=5AnBFHTJ48JyDtwwmcdw5HQYtJifUCb5c6xocRZwSoxZfA/IFiKu4bQxzAb+nyqjGT
         TrFyWopobjPEIg6o+UX+mvOtGkHDDIiPy8Pc8aYS4iJe8PYQetOKq4AmnTlx1UoMNH/b
         bbqcZCbiwiDDkRISh6TMAls1LfYX/lGhTNhg3e3JsXtjLOHBl5AXKdxkod6qpiQ6FqYp
         Hx4SXJ2ApASA90TP5pVysLRVsTVmMkkJiFc7XGnRHHdIPg2o71w66XP0B7rly9CmATH6
         DlBeOYD9Gc+BozFgz9fRRv4GL1Kz+gyLqG0xWaHBhb+EVgdm/omGjtu2anpApniK5nhx
         14cA==
X-Gm-Message-State: AOAM533E+nrqJDZUGIqZ9UjZldk4kbfZZbd25PT2TZ4aMuidoDjhn/FS
        +D1zJdQvEe67yiUWSIR9Rqo=
X-Google-Smtp-Source: ABdhPJyQSOi4W71WzoPSJo03LOFHDk6YD4WNRlSITcWcGAElPRpQy9HNiRGkqU01AEMV+9nqf9YmNQ==
X-Received: by 2002:a17:902:e746:: with SMTP id p6mr13284175plf.78.1643473881469;
        Sat, 29 Jan 2022 08:31:21 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:20 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get
Date:   Sat, 29 Jan 2022 21:57:55 +0530
Message-Id: <6c992e9481c7481aa5931635e162dd7a4400a2e2.1643466748.git.abdun.nihaal@gmail.com>
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
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index f99942417a71..bc5c8454ebcf 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3422,8 +3422,6 @@ static int rtw_p2p_get(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	if (padapter->bShowGetP2PState)
@@ -3447,7 +3445,7 @@ static int rtw_p2p_get(struct net_device *dev,
 	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
 		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
 	}
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.34.1

