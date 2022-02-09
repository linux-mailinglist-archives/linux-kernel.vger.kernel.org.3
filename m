Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FB4AEB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiBIHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiBIHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:36:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8649C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:36:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so3458601edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESbXKqLaror/W0JvXlaHW+wZzmnanLaV4adNcDrBOtg=;
        b=IOFkR+THHodQt+72OehXoSKXLIbai44sOO7wi1L1gqV6704LKcFLdtaIPiC9SW0Zzq
         BSMUp2g8wxekyLtkgSlFmQdbtuvyvdbkisvlLXaWwgQRZtNl2apuznopBAa10RNGxO8O
         WvnDEHYBueiveqSz+k8Yw5MKm7oDcuZK26Gp3TzAbvqFR9l88dGdxsZWbdPb8i5hYvyF
         pToJbgfyGNVQYGmL6y7AdxV6hs5I4y8qABkLuOfB9ugPowsS+g3OQv2d+3nEPm6rFx4o
         dGqQ0Sn0nH3pJjksIVzdqUca/D3ZI6L71H8ehpsj1SVR8IakgeS/MqwRpxpQSHKOootE
         WanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESbXKqLaror/W0JvXlaHW+wZzmnanLaV4adNcDrBOtg=;
        b=0nGBrAaOENRDwkg/NS9YSFfnIVq+2JjhD54DBBcXUrusYxOZRKLIait0ITF9qYG1Qq
         5VjJmvmBkgifREX8PJ98HmGTcuR7/yiCOX88b3LSxO4FWz82OBrVYYg7UZ0dMRJV3Ug1
         DwCjn25hWBdTVloho+/qI2iDjQfKAzMd9lXEpSMKQiD+iHIFLQ4jDk9Q5iQjpmfvFiBQ
         KaDgLoVuPtmhCNjIsMaqgXJs6R6fFkb1XVy3SmnmbzDuvSlGPAQl8hKV5/UDUHU9dlaB
         eVSnrJVVkneznjAHbN0A1ergPFdXZv39WeOhoAyLnck1GTYiRBfj1jtGCCm12IV77LpG
         iS6A==
X-Gm-Message-State: AOAM530FZw/pWqaA0uTU2HPf8U7OeqBNhiBE5GbP2GQFguHrgi7uOZyw
        aq5aujqRBPZxia6f6Vqds1U=
X-Google-Smtp-Source: ABdhPJz+CIrabQp5ulemkhUBcsFadYSZDzSmWrvgFNjlxuVXyccTmRpVGFHJHPoYOw7gN6yay8PMKg==
X-Received: by 2002:a05:6402:b9c:: with SMTP id cf28mr1062592edb.295.1644392186590;
        Tue, 08 Feb 2022 23:36:26 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id y27sm3731813ejd.19.2022.02.08.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:36:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: clean up enum hw_variables
Date:   Wed,  9 Feb 2022 08:36:18 +0100
Message-Id: <20220209073618.29725-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209073618.29725-1-straube.linux@gmail.com>
References: <20220209073618.29725-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constants from enum hw_variables.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/hal_intf.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e8731e2668f6..8e204d61cc53 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -11,7 +11,6 @@
 enum hw_variables {
 	HW_VAR_SET_OPMODE,
 	HW_VAR_BSSID,
-	HW_VAR_INIT_RTS_RATE,
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_DISCONNECT,
@@ -25,7 +24,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_SET,
 	HW_VAR_DM_FUNC_CLR,
-	HW_VAR_CAM_READ,
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_ACM_CTRL,
 	HW_VAR_AMPDU_MIN_SPACE,
@@ -35,24 +33,9 @@ enum hw_variables {
 	HW_VAR_H2C_FW_JOINBSSRPT,
 	HW_VAR_FWLPS_RF_ON,
 	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
-	HW_VAR_TDLS_WRCR,
-	HW_VAR_TDLS_INIT_CH_SEN,
-	HW_VAR_TDLS_RS_RCR,
-	HW_VAR_TDLS_DONE_CH_SEN,
 	HW_VAR_INITIAL_GAIN,
-	HW_VAR_BT_SET_COEXIST,
-	HW_VAR_BT_ISSUE_DELBA,
-	HW_VAR_ANTENNA_DIVERSITY_LINK,
 	HW_VAR_ANTENNA_DIVERSITY_SELECT,
-	HW_VAR_SWITCH_EPHY_WoWLAN,
-	HW_VAR_EFUSE_USAGE,
-	HW_VAR_EFUSE_BT_USAGE,
-	HW_VAR_EFUSE_BT_BYTES,
 	HW_VAR_FIFO_CLEARN_UP,
-	/*  The valid upper nav range for the HW updating, if the true value is
-	 *  larger than the upper range, the HW won't update it. */
-	/*  Unit in microsecond. 0 means disable this function. */
-	HW_VAR_NAV_UPPER,
 	HW_VAR_RPT_TIMER_SETTING,
 	HW_VAR_TX_RPT_MAX_MACID,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
-- 
2.35.1

