Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4994C0562
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiBVXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiBVXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:35:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D7929CA9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:35:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x15so2010886wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owMM0MyODP9S0fBThXOMsfsqzmiy6hi7ZMz5dzGpfrQ=;
        b=xaaS1XUGcRe5wBuR2EjG/YYJL7aRWre/dZK5/1zvdjYcvp4SEqLVhJeef9dIqE5X/K
         jcL65pSWpn5jyzxAsQ3up4qrEMFn+JxIMUvjDsf33IR8azog7h9jCLu74PqqqyNOY4od
         G7rzDQEelHmLIGqf3KicPgyR3zGfDLnuK6zhNzJk83dKSv3qH7vYUxDuZqAILbNWrFV9
         B2vZFbe7nAvHAFkZPlTXGK8odlgoPXw5ndraZNY21d1LCZ20tmXBMinRZEivkznk6HBL
         OhYbEzDB17g6xj++OT/E7Am/baxgwp1939p1Qm864U1tpmsWKa9MK4BIQmSw7kQHKxUQ
         Vp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owMM0MyODP9S0fBThXOMsfsqzmiy6hi7ZMz5dzGpfrQ=;
        b=lql0/jZhXHOMvbz9fBjQDjCUMEi0F7ppPppLf65HxUA38owDnBvbdXskFEyCvrGvho
         ntjOOLNjdFsjKDm/o90aMjVb5c8p1h1nT1g8QO3uOl4PNwGI74zn3a0wEVKaeNBeUPX2
         Ix5onNw3eVGc/rQ0txntwB/CVSY4OLhXrxt5I99PbQTa0Mc2YYpP4dpl3pmZX9rJk4Lm
         kFkUrzeEhsX0QbJDTxvrM/X2wOKTqLn8V948UDsMzYqoUgLt7mg/xNFrUNhiPpl/F381
         J0YuxuUUFYmGT7wZMM/cp1X+Rwh3PyWR8n8nEua3SJM8NTP4h6tQggaJKBR4ZHwP97rf
         XKcA==
X-Gm-Message-State: AOAM5317CGGAgGiTVWCajg1kY1JwGyVezDoksdEjue6a7Pq3iPFcoMOR
        sHrhdVCjQOeoQV+3L/u/+MKjFA==
X-Google-Smtp-Source: ABdhPJz2ov7OFX6GiQnn5S+SlBfODGaH6/54lyEGQ/ZUYKAI6+txY3GKGWUyHcKVDgOXELiv67sDyQ==
X-Received: by 2002:adf:fd03:0:b0:1e4:a106:8fae with SMTP id e3-20020adffd03000000b001e4a1068faemr20586447wrr.336.1645572907597;
        Tue, 22 Feb 2022 15:35:07 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id f3sm21563638wri.6.2022.02.22.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:35:07 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unused variable from UpdateHalRAMask8188EUsb
Date:   Tue, 22 Feb 2022 23:35:06 +0000
Message-Id: <20220222233506.72778-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 'arg' variable from the block inside the if statement in the
UpdateHalRAMask8188EUsb function in hal/usb_halinit.c, as due to the
recent DBG_88E cleanup series, this is now set but not used. Also remove
the rest of the lines in this block that further modify 'arg' as they
are superfluous, due to it never being used afterwards.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 0704fa3156af..d7dcef3ece3d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1528,12 +1528,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	init_rate = get_highest_rate_idx(mask) & 0x3f;
 
 	if (haldata->fw_ractrl) {
-		u8 arg;
-
-		arg = mac_id & 0x1f;/* MACID */
-		arg |= BIT(7);
-		if (shortGIrate)
-			arg |= BIT(5);
 		mask |= ((raid << 28) & 0xf0000000);
 		psta->ra_mask = mask;
 		mask |= ((raid << 28) & 0xf0000000);
-- 
2.34.1

