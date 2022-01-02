Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA149482B5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiABNME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiABNMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:12:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6DC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:12:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o3so6723128wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHELGdcUhsNgAojzTibF4Qur9j5/s0lL5DAQ2vvBi18=;
        b=g0QR7IOeu+4rvrHJjlsdrTNO5dpk/PXbYvqyPezSDeKJVgI1QbcF8PJM22DZ2jgx6L
         xWkhf4CPloEXwTbXUgzBTD6Y5JKzjbcPXeuruvV6IMoba6QOsQB0BvcJQbQ6BoKwOfYu
         QETp+4UtGyS4wiwv8hCsaWF+TIkn2mbUsIQcMF5TprJprykJ4YCuztYpAg7H5cAZFPRH
         6UVqqnfEXnO03WuIqIYashaszgHqAZwafGWDPknSDYHYYI/s0RCQoA8y7lPJUEvQE6Lp
         qu9zoLjXV906i0CfYz/xXyTN45EGwR5MS/1H+7HWVE2HeFP02fKUFuQD6Olz+e+V36OU
         lX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHELGdcUhsNgAojzTibF4Qur9j5/s0lL5DAQ2vvBi18=;
        b=MKl53wXqMm1dm7rQv9nLoFt+PusyWSzVGHSJdnNfZfyDcWpxtfoHctbJUGepRCWi2G
         muEXNq/u2Gy3HCjUJcrPCRctmKRuTsVzzjOCifDtBpBNCf/ViczO63L378J4YeSeiv02
         hEo0Ng0L5TrSpyHE5GJrUkx00Pehsx5/vsl2qq50ldZfj0bcFwfBJ8Sr2IfYyLAuHG3M
         oYU9jlgSxmZ9exP8GN0+Yu9SFABILGhFY9Sho6itQAxLkxQRmbWMCXb1zYV0GSk3ixJE
         Gb2crNnnCkGNgeM30CxV1kBC8+3YuaWcapB7KcqJSOOVsRpH4614Ue8HjW2RhBpBpT0B
         +QeQ==
X-Gm-Message-State: AOAM532Zqu4Y8qUjLpDVETyxbkpnJCEEUKbUfEyyuRenFBUHPg29CkGw
        SeJGIANzcVWM6KSk1xAnnxs=
X-Google-Smtp-Source: ABdhPJwitywzxxbikp9d703VzuEM13cVljmlKLRNHsBd4uR6JigbiRkhm0sxCtcG78fXIgxwMfJZsw==
X-Received: by 2002:adf:e291:: with SMTP id v17mr34764140wri.479.1641129118760;
        Sun, 02 Jan 2022 05:11:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/11] staging: r8188eu: struct odm_sta_info is not used
Date:   Sun,  2 Jan 2022 14:11:37 +0100
Message-Id: <20220102131141.12310-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure odm_sta_info is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index d81aff9c9467..23a151c558dc 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -116,22 +116,6 @@ enum odm_ability {
 	ODM_PSD2AFH		= 0x00000800
 };
 
-/*  2011/20/20 MH For MP driver RT_WLAN_STA =  struct sta_info */
-/*  Please declare below ODM relative info in your STA info structure. */
-
-struct odm_sta_info {
-	/*  Driver Write */
-	bool	bUsed;		/*  record the sta status link or not? */
-	u8	IOTPeer;	/*  Enum value.	HT_IOT_PEER_E */
-
-	/*  ODM Write */
-	/* 1 PHY_STATUS_INFO */
-	u8	RSSI_Path[4];		/*  */
-	u8	RSSI_Ave;
-	u8	RXEVM[4];
-	u8	RXSNR[4];
-};
-
 /*  2011/10/20 MH Define Common info enum for all team. */
 
 enum odm_common_info_def {
-- 
2.34.1

