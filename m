Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B059048BDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbiALEWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350617AbiALEWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:22:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D42C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hv15so2428237pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7osdo2BrmjDyjcS9PkvYkntr2CZq4Fce8zzeRAMN9w=;
        b=MJRkHySPt6R9biKhtWIETa/mGGma9zDhgdKwaT3b2KtzBOoHr89RLeRwj914ky+cLZ
         gPJ2xB5zpFBs65WuPawhtY2f4wweQRDrfu7YiarMdj0n9gk8EhMc5gukRpdomHgEFmfs
         T+4j4KsnUXWKIeAQukVuPH+gM+Y3s10tFmz5QS/1aejjJsB1bpAhf+CiGtwY5COF3ZoB
         4wwJ/WDtSnyzgRDxKzhtCzwcVx20BHmjryPeNhjOakrEIutXqM7t9cOrMzGJ0VAx3+E4
         ZF8K/zJsBy1/7Uq0JU2sZZ6MswnmQJO3l/yBfOe/HUmW5gvnmscB71vnoT4DaEq994/q
         is5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7osdo2BrmjDyjcS9PkvYkntr2CZq4Fce8zzeRAMN9w=;
        b=pXq7kG+3gbnCq3viOHo/K8HrtfBiHFj9gvMQzFOsLewfknb2kpxS0cdHF6tULBrEnH
         +JKUhoTNwihwXobaKArtEoungns3iTrL4jFJG+ewRinirAIR8P/8vXdnj3REjBiLeoSs
         yO5JxzFHmRVk+J2rZEgYKjKEZ9Dy3RCSp0g6+8Lef3i/GwP19VQ/+XIr0jZ4J220rlUA
         880/bpyzF5mnYb+rO4y/0hX3YC0KGAdkhJvpbeDD0CXsirRqe7GRg1cQ2oR1C77UpuXo
         AOmEEtbbpSB5Xz+tEPu/ekiOv00K2iWMqHZNxrlonVxQ44h3aBglWQy8Kun/UYCLC6oq
         Hegw==
X-Gm-Message-State: AOAM5310DvdBSitbDTp1c6dFedkFbdSIM+oBchDPAH9IyuYJdbaDd5ij
        5kQeZN4F5pwGdqxfKd0of1PxJIYBZDcxsg==
X-Google-Smtp-Source: ABdhPJxwgjM4wHLTKFa51oNax5zFELQWraXlDGN1SnqWlEvcRwhlxE0SSqLjxv5NWGsVtrk5UP4haQ==
X-Received: by 2002:a63:5007:: with SMTP id e7mr6729952pgb.295.1641961330772;
        Tue, 11 Jan 2022 20:22:10 -0800 (PST)
Received: from localhost.localdomain ([115.99.137.58])
        by smtp.gmail.com with ESMTPSA id t207sm11237747pfc.205.2022.01.11.20.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:22:10 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH  2/4] Staging: rtl8723bs: Interchanging comparison expression operands
Date:   Wed, 12 Jan 2022 09:51:59 +0530
Message-Id: <20220112042201.5056-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112042201.5056-1-jagathjog1996@gmail.com>
References: <20220112042201.5056-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl warning by placing constant on rignt side of
comparison
WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index ac731415f733..fcecee824797 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1554,7 +1554,7 @@ void rtw_sec_restore_wep_key(struct adapter *adapter)
 	struct security_priv *securitypriv = &(adapter->securitypriv);
 	signed int keyid;
 
-	if ((_WEP40_ == securitypriv->dot11PrivacyAlgrthm) || (_WEP104_ == securitypriv->dot11PrivacyAlgrthm)) {
+	if ((securitypriv->dot11PrivacyAlgrthm == _WEP40_) || (securitypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 		for (keyid = 0; keyid < 4; keyid++) {
 			if (securitypriv->key_mask & BIT(keyid)) {
 				if (keyid == securitypriv->dot11PrivacyKeyIndex)
-- 
2.17.1

