Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D74A3093
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbiA2Qb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352633AbiA2QbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:25 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57361C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q75so8058879pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/iheAiKRNX/zYagp3+t2KC4OOAuSnRdRHqutW+clxo=;
        b=nA9IWgTDotqfDmoKv7jAI40+lzrUkh+z9+by6wqMk3ljCJWHMfYRuOKbEgxC3QXYNU
         cLxIFWe3VDoFvyXN+NEnEeXa5PGl/JhZxp1uL9qyXgBwV4Gc4JaeZJg701RiSJ1Brmfm
         c4c6tghq3u47UHWKPJ+dhriE+YAsbkcuZvAQraS3a32ctt7gzXEswiEWiuGG/FRDzbUB
         9mZ4GQ/xYJtzqxzd/AxDefH/6GzK+IeSVogximlCfD6mroROHp7F2KS5HsMS4IqRvB5Y
         sotf/jQ52nBLP4A0ulProHB9hFZpUF5x/CbW7Jr6zegbWyW5EmRcreszwX8wYZNg/YNl
         5Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/iheAiKRNX/zYagp3+t2KC4OOAuSnRdRHqutW+clxo=;
        b=xENKGdDNmpCn+bVvwqZhx4MpqX4IeE61xrpIzgRE5dVIkbIbjfCsDpr4Hvavt7J8wc
         Sn2myUEXZR5Ogz4BWsvb+rpK8hcmUKH9xawf1HjQduYaeRvAuEpe5QZCQyU1Wr6UzZaR
         +w2gF1qWZcivJO/TkqtMBn+Wp+tM9waK2iA0sEoj/GbSYKEdFP+V6b9Nf7ZlGe0NwjuJ
         31gLx5r2XppcmRRkC21IPnp1nk2kNZzxw8YPiQreC8Qo4YPqIrpMn2o5PvaG09JChWyY
         8ysCZoaDRVBXSAJsKHbE4/H7CuwupJhJbw5tCNiiZuFE4MmTBH06oyaSq13Dcff6Xacq
         VTHw==
X-Gm-Message-State: AOAM531M/D7OxSXiETVUJ9OYb6dfn5z1v/ucyYvBu6oTaNRhr94bYWrt
        Hto09GeeNHtPymQg22rqXRs=
X-Google-Smtp-Source: ABdhPJzZnyEB0ENS44pWvYySVcUEPE95WuntkwrZCiIALKslTQeB6dmyt4rVhh6TwqCRfbnEiQHhRA==
X-Received: by 2002:a62:1643:: with SMTP id 64mr13019916pfw.55.1643473884798;
        Sat, 29 Jan 2022 08:31:24 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:24 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get_wps_configmethod
Date:   Sat, 29 Jan 2022 21:57:56 +0530
Message-Id: <ae35e6f6f603ef83c2bad685ac247273041bd138.1643466748.git.abdun.nihaal@gmail.com>
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
index bc5c8454ebcf..b0f78673d9b7 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2620,7 +2620,6 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2681,7 +2680,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 
 	if (copy_to_user(wrqu->data.pointer, attr_content_str, 6 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_go_device_address(struct net_device *dev,
-- 
2.34.1

