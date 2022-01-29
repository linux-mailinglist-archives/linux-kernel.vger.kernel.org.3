Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA354A3095
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbiA2Qbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352668AbiA2Qbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:31:33 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC0C061741
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:33 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so8099138pgb.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bf6lhHbgkl3pCSqm/k2iChu7YEwDY7WU7VmbDU3O3o=;
        b=dAdoYV5mtnPLehk0FRM4X0AdM8jKLGQFg0jMR+yN5Z5ih+CeKbXRjwBPd2qH4e0B2H
         V+FXAjqf/+SSNo+YVyVYCmjt/MjApPsDSMnS0k+6Pox/4Xkgr1SAE+BviaGXjgoiF5Aq
         lBFDjZie4YiXcpQEa8gfHb63GYizTeLovnGa9OqokDBAxxYCgCmPxhJqwQYGO8ev0S3N
         sYL/I+Az1cO4wHR5ee8g6kS1bUpEmBbReZvolJx65i86JjltY4hvL1PoBi8uA9K7DrXs
         A7LdUQ0md+KZKKnQbwAOYMJPioB7Si7rNHCYV4vIlXNe7ocbYerTjJqOKeL7TTEASZx+
         Caow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bf6lhHbgkl3pCSqm/k2iChu7YEwDY7WU7VmbDU3O3o=;
        b=RSUB1r1MHbx5EPehUk8hZSDaq0rHxXJQd1Qmoeljyyigc/nVDTuKPVR1e5FHHL7aTQ
         RDJ5SCCOHiarzrSf156p5wi9iBmA7ebdWA1C5giZzJtmOuvsvyQq2RHOIvBQUFYE7yV5
         XlFG4n7kpVoDEms/BX/ZGJQxce4YNt0B91z4PqQZtWTfBu1T5B8mySFd0EkKcrSn2AJp
         75CRRVfNsry2xzxnEJ6rj4BPHttrUgeb4TQQos0Mhuy7hmTj9tJ6x44rkfagP64FPeI4
         u4i6VFWNgKY2907yImdJcDtw6S+UrezHjvyN44ajLMZ7Vd8kBc03EJScz4PJ9uum08A+
         sg3g==
X-Gm-Message-State: AOAM530NTMY3R9yyOPZKO2Ywdb2zWc/fHdPWlN2J68kvBaPthMU/GOt8
        8/DPl2yj+2wiqskrY9xm220=
X-Google-Smtp-Source: ABdhPJwKSvI9hGklRZ4LetcksI2zs63WhOMTuytmMMX+51ZZT0rkLUIdmTFvLeTa/j/lxaf24oZ9FA==
X-Received: by 2002:a63:2ad6:: with SMTP id q205mr9014100pgq.46.1643473893318;
        Sat, 29 Jan 2022 08:31:33 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q13sm1893528pfj.44.2022.01.29.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:31:32 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/23] staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_type
Date:   Sat, 29 Jan 2022 21:57:58 +0530
Message-Id: <83609e3c75a0bde4be612d32d76eaed6a26f72aa.1643466748.git.abdun.nihaal@gmail.com>
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
index b093430ff744..6d72b15541ab 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2769,7 +2769,6 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
@@ -2838,7 +2837,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 		return -EFAULT;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get_device_name(struct net_device *dev,
-- 
2.34.1

