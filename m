Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEBD4A3097
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbiA2Qbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352680AbiA2Qbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DEC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d1so8824805plh.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59y5lHN2gs000ZG3867tBGbxqegY+PjUJ9DhuQ1m6Jw=;
        b=aYzc9UvQSShqFwuvEjSRpqL3kkzYaXWL+Ree2TKSdMdJNBPEszjHEr1ooczhTLiViA
         9AL3SFb0m71oDA1HVJnS1CsabRvU52TE6q8DjmFv1IBTtoY0enJU28aa4O/HN/++lbCd
         Bcto+8k0kGA+p4p1ID9sEVbu9FfMCD5fWVTG7L/+Z319LYewY7wGeDjO7sHDV86FfwPy
         iTXD0Ailil1nr/wPzSH5eazOxOPBoqIvC1ux2wBbkT3v0prFchv2dLLwEIdyASqjeUX4
         6fCwxB6vltJ1qvGe3CTDCP7ylmvPeUcztnV7E8VFUO3DB19d7hj7xAQpQmdD/lPFWLsq
         KOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59y5lHN2gs000ZG3867tBGbxqegY+PjUJ9DhuQ1m6Jw=;
        b=t5Zd45sRE2Z14ATQWqexeVhzG/JM+9cvaETuYwte0GTsyOWKpKwn+8E/JctzvxHU5c
         jX8zwW7aPrVLnrsQegVw/DP16pcqDqC2Sh9km4sQrvQ0X4xQaOSEzIuyJvLUYnyk1LM2
         EpkXZqhB3rDu9Uvs9HigZxXw3kxSdJsJc7duTGSv7w3SubhZBGUz3IH0ugGHa+gRDCsT
         HtZTsfuf4Buxxj16mGuKEGrG8VmQBIBeyvhT1lzHmU3x8ODLoTTA9NKTz4HV40ZABtIv
         cj5xPYyHAG0um1vvOiQgKhshrO9pUzXmZEkiPJ3GIkK0UqLx0lzyOnbwLgD/d/HJqdxz
         nZCQ==
X-Gm-Message-State: AOAM532vZuoeNyfE4+KPRKOY4jpz8NPcTOXfew900rqDAUNbR8Q4Yw28
        R4d4qOfBsPUxGLCbEj9nEpk=
X-Google-Smtp-Source: ABdhPJzlcsQcJTyZjb2jsvBoGjUiiqasO3bAH1sR2Gsy8SPZdD9o91H91k1sgJMO3O0MOfjcheJt4Q==
X-Received: by 2002:a17:90b:4d84:: with SMTP id oj4mr15684253pjb.192.1643473900489;
        Sat, 29 Jan 2022 08:31:40 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:39 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get_invitation_procedure
Date:   Sat, 29 Jan 2022 21:58:00 +0530
Message-Id: <ccec1f682fbc623381519610284530f940122d0e.1643466748.git.abdun.nihaal@gmail.com>
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
index 33fe8e944df4..35f7ba66a7cf 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2909,7 +2909,6 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2978,7 +2977,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 	}
 	if (copy_to_user(wrqu->data.pointer, inv_proc_str, 8 + 17))
 		return -EFAULT;
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_connect(struct net_device *dev,
-- 
2.34.1

