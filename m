Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F04816C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhL2Uvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhL2Uvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B77C061401
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so46677671wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL7Kn9Pt7QSxCX3ozk8sdDTpNPjuICREpZJE33+iy7g=;
        b=AJ0GPSzKZkzR0OZtAN1puQWHbU7AlzaOhvVtaTa1+4j7Asij4eJ94eaqLQkWOZjpBF
         /dUNNxFOjemSixCCMXvlNcOTJgU64/dIcTBN2lhJF4qsecQTlbgIWxn8SNbLPG/WQnng
         QIBeHiKQ97snAKh19+I2LhOhxJ7vrU9gzm0mfnA1xdUfosgnPLFwffyge54bLf1ox/Sk
         Yg5qmdcgQEhpB/F1XQ5SbTF5T76d70kPZPdz6rG8uw63mugqbkG7OjZjF9vpNE6PObtL
         zAG4n7/11C3RVAJWEtAwsXmE6hMgnFj0CXcO9iQis5MAlxnYD5u4zRWxPj/VqUgkmpco
         qOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UL7Kn9Pt7QSxCX3ozk8sdDTpNPjuICREpZJE33+iy7g=;
        b=Z2YOWUvxtcktWn0eQhOH+BSyhjLnfb2SDFYNp3WUBTY5ySCKdeTOLE2fylXV4pln79
         cR/oCyy64LLYXWhwLxBswmc4IpBP1Bu9GQ32Kl9Wv/fWlQBQ2LKG5IPm+oCPjfVId7po
         OU98mv901eT7V6l0E+tVZvk2e5BUsnpw8dsfICCU4rQqYkK8DyEKx9IfBaNyibxKugPC
         Jmjs5cYz7osC7L2+aCw2JpE/fKm93wPRylaV9SVuiRCRetzuwsobY8EUpnzZnuyNoK3l
         /5n9o7tRIc9UhE2rPMlW64ulaQVGxpgIQoA4Zf8cshx3g+9m7yJRJjyKJmsbCn2Yyqs8
         eSaw==
X-Gm-Message-State: AOAM5317EwakzO8/7Oq2mSZC3iTe11smT7jHV7uzSvKAAXP75iLwyKGx
        1ySnkWHvr/Q9R+ib1JxKVwA=
X-Google-Smtp-Source: ABdhPJxywXSYd5shvP11bCpoLVc2r4gWUNwGPxvGGsvH7q+xiqL706RvnN/TYXMkje03x0FUCJiEPw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr22680499wry.518.1640811091476;
        Wed, 29 Dec 2021 12:51:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/32] staging: r8188eu: clean up coding style issues
Date:   Wed, 29 Dec 2021 21:50:43 +0100
Message-Id: <20211229205108.26373-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up coding style issues in odm_ConfigRFReg_8188E() reported by
checkpatch.

WARNING: please, no spaces at the start of a line
WARNING: suspect code indent for conditional statements (4, 16)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index b5b614686a65..3c591bf9459c 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -7,7 +7,7 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 			   u32 Data, enum rf_radio_path RF_PATH,
 			   u32 RegAddr)
 {
-    if (Addr == 0xffe) {
+	if (Addr == 0xffe) {
 		ODM_sleep_ms(50);
 	} else if (Addr == 0xfd) {
 		ODM_delay_ms(5);
-- 
2.34.1

