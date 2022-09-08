Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04425B1E17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiIHNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiIHNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2535C11
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:09:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id go34so2893496ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tReQnZIM/2GXsnwHvYX7dmOzuxjlvlNGIgAsvxQ1yRc=;
        b=i64quYvlQ46IAbHchD9nAqJI/KHzq9w0j8q6dfs7eCEhjUk3Oif4adCO7pMd5bdSIM
         IOu2dEyIA3Sku7i0R8zrnGgvVpEP1w7TlRcZ7Pi15Bb/Tms7sOGXhzKYmFyAeCpp5bQI
         ccqqOeqb+PKRf26AJprMiVpbz1LB2lCUUI3YTcYSN5LL3I3A1mQdjFCr2F70zNFDftaM
         dUZ4D/AUA4JUM2BN3CEemAxPdSkdUIwhb1AUzZY10VwrG5yPY66BD+e5dQ5/iaAQBKus
         rbp5a9YmEkBQ594K4t/9XM0E7dyaIxgwjyymYaVdcKCDk+Ur67cG+QlPJHYsgtlNF5C3
         bS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tReQnZIM/2GXsnwHvYX7dmOzuxjlvlNGIgAsvxQ1yRc=;
        b=uunKcMKKm8MhUT2a5vBNsIsA/NvBHUEus8MUzSWaNcZ/O6sJxPY2fyDYy+w9ybHT8L
         iZALi/t75JxUFx2k8F6gefD66J1Zurga4zFYfLhcO5H/lcCd8XH7iwT2kyNx4zCXJmFA
         KES5GzivWY1ug4VSC3mUO0DOFfRhqRGpkoL7bG8wXdqGuyy4VaMXhu4NVul+gnKxYMU9
         g179dbc1YvM7p0Hw2s0FPLkmmnVd3xOXvS0i3W5a5Yg9/RN6R3YffLtG4x53aGz/eyoN
         Lenw+iWYG3AtRLhqBtoAG5wUopUFzzj+lsQtR4is3ckcr1xZ2bR++Sia0bz8o0tIkvHC
         mA/w==
X-Gm-Message-State: ACgBeo1g1o8drroAM207/6Lm/UEVW3feh94asLDpKbfdxCAT+ujQlln9
        iV74j0XHNKGp9q31mzZQyCk=
X-Google-Smtp-Source: AA6agR6VijqSfYBtjgJ/lXIIch+djV1FGMJrTaOymkJRGHnbP/TSIHqgHGRXbkuLmcToUBeMcizB/g==
X-Received: by 2002:a17:907:2ced:b0:773:6f77:f10f with SMTP id hz13-20020a1709072ced00b007736f77f10fmr2860143ejc.34.1662642568533;
        Thu, 08 Sep 2022 06:09:28 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id cf6-20020a0564020b8600b0044edf0a2deasm4847978edb.69.2022.09.08.06.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:09:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove unnecessary return labels.
Date:   Thu,  8 Sep 2022 15:09:15 +0200
Message-Id: <20220908130915.8406-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908130915.8406-1-straube.linux@gmail.com>
References: <20220908130915.8406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the RETURN labels in rtw_alloc_etherdev_with_old_priv() and
rtw_alloc_etherdev() and return directly to clean up the code and
improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 3504a0a9ba87..875a41650896 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -54,14 +54,13 @@ struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv,
 
 	pnetdev = alloc_etherdev_mq(sizeof(struct rtw_netdev_priv_indicator), 4);
 	if (!pnetdev)
-		goto RETURN;
+		return NULL;
 
 	pnetdev->dev.type = &wlan_type;
 	pnpi = netdev_priv(pnetdev);
 	pnpi->priv = old_priv;
 	pnpi->sizeof_priv = sizeof_priv;
 
-RETURN:
 	return pnetdev;
 }
 
@@ -72,19 +71,18 @@ struct net_device *rtw_alloc_etherdev(int sizeof_priv)
 
 	pnetdev = alloc_etherdev_mq(sizeof(struct rtw_netdev_priv_indicator), 4);
 	if (!pnetdev)
-		goto RETURN;
+		return NULL;
 
 	pnpi = netdev_priv(pnetdev);
 
 	pnpi->priv = vzalloc(sizeof_priv);
 	if (!pnpi->priv) {
 		free_netdev(pnetdev);
-		pnetdev = NULL;
-		goto RETURN;
+		return NULL;
 	}
 
 	pnpi->sizeof_priv = sizeof_priv;
-RETURN:
+
 	return pnetdev;
 }
 
-- 
2.37.2

