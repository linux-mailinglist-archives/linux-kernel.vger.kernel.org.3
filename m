Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBD4AF6E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiBIQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiBIQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF076C05CBA7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m7so2656970pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsEXiVlyQb6Rm4U4ImPG8xi1NQSKn3tPJmrja66493o=;
        b=Xym9iKiOnlUqKPHInpa8dBWlr8LoDSRrsYo66erdAECO2T2FbcwrAEcUxbWYq9ERjh
         DNKaBNuXdWjvV/LW4unjf4bBwved8dN77s8seRo6nC6tYjDZnzq8EIWjA+npHUDH23f3
         GhEyla7E6z/KhqLQUpIB0hdIH6mVu7bOXGo4MvSdhD54ou4M9b2LULFIgVxG7F8UKy7u
         +K+rSGSyif5CuxOEBGn/OaElsGDBOllEN8NZTArAKNma9AdWn7Rco0+prwTyfxliy65F
         uPfaGcWU8adUVmCjP56hRULk2ThGW2dlmXPFaT0r4GJGy9lXYxn50fPgDPmKm/uj8VRk
         oqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsEXiVlyQb6Rm4U4ImPG8xi1NQSKn3tPJmrja66493o=;
        b=xZEV+d1uDAEkKrFUU+LwhuaHFTDKoozRsogfaKtKmiyQtuPiXg/51QBAYJY3SI5K0F
         lmrBb6V4PUYzYhiJH8gqkYVcFrfG//YsMBiFrTt7i8c2tFVm4zKCFpl2cDm3aGH4s0d6
         j6zn19BZ9Bx+q0gorf9diizOWaD9JVB7++OIeKAjeAR4M933zA0uQrtGUIsdq1cAVyWN
         bb2OdNLliqipDLtYLjao6AvQsETNSarv4545i8AzhEoICptHb9HQci1k9HrIVA3Pl6nz
         NcevvIO5qa7B9w27C+s8T8dqxcnLSEes9oNFSOEGILeuPea5oxAYBOSnm07+iVDTvDmO
         H3/w==
X-Gm-Message-State: AOAM532PF1ODu5GZOnCZKlZbVyoQhHkehmoiGnN+/qA4FvbsLibLViqf
        88JSz9U/7ACZ5AE/Zd5P3bc=
X-Google-Smtp-Source: ABdhPJx6Vmie0LmAh8ASZ7G3tayhzdbM2ZCtfC7iiNPLS9M6lm3sFbvVWDEyfepwGoLdE4ddcoEVFA==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr2943646pls.31.1644424678416;
        Wed, 09 Feb 2022 08:37:58 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:57 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 9/9] staging: r8188eu: remove unused macros in sta_info.h
Date:   Wed,  9 Feb 2022 22:06:07 +0530
Message-Id: <c2453078b2d46119d167f2d0e4690cc87fc4b77e.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

Some of the sta_* and STA_* macros are not used.
Remove those unused macros.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/include/sta_info.h | 46 ----------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 24b1254310b2..874db17df8bd 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -210,53 +210,24 @@ struct sta_info {
 	+ sta->sta_stats.rx_ctrl_pkts \
 	+ sta->sta_stats.rx_data_pkts)
 
-#define sta_last_rx_pkts(sta) \
-	(sta->sta_stats.last_rx_mgnt_pkts \
-	+ sta->sta_stats.last_rx_ctrl_pkts \
-	+ sta->sta_stats.last_rx_data_pkts)
-
 #define sta_rx_data_pkts(sta) \
 	(sta->sta_stats.rx_data_pkts)
 
 #define sta_last_rx_data_pkts(sta) \
 	(sta->sta_stats.last_rx_data_pkts)
 
-#define sta_rx_mgnt_pkts(sta) \
-	(sta->sta_stats.rx_mgnt_pkts)
-
-#define sta_last_rx_mgnt_pkts(sta) \
-	(sta->sta_stats.last_rx_mgnt_pkts)
-
 #define sta_rx_beacon_pkts(sta) \
 	(sta->sta_stats.rx_beacon_pkts)
 
 #define sta_last_rx_beacon_pkts(sta) \
 	(sta->sta_stats.last_rx_beacon_pkts)
 
-#define sta_rx_probereq_pkts(sta) \
-	(sta->sta_stats.rx_probereq_pkts)
-
-#define sta_last_rx_probereq_pkts(sta) \
-	(sta->sta_stats.last_rx_probereq_pkts)
-
 #define sta_rx_probersp_pkts(sta) \
 	(sta->sta_stats.rx_probersp_pkts)
 
 #define sta_last_rx_probersp_pkts(sta) \
 	(sta->sta_stats.last_rx_probersp_pkts)
 
-#define sta_rx_probersp_bm_pkts(sta) \
-	(sta->sta_stats.rx_probersp_bm_pkts)
-
-#define sta_last_rx_probersp_bm_pkts(sta) \
-	(sta->sta_stats.last_rx_probersp_bm_pkts)
-
-#define sta_rx_probersp_uo_pkts(sta) \
-	(sta->sta_stats.rx_probersp_uo_pkts)
-
-#define sta_last_rx_probersp_uo_pkts(sta) \
-	(sta->sta_stats.last_rx_probersp_uo_pkts)
-
 #define sta_update_last_rx_pkts(sta) \
 do { \
 	sta->sta_stats.last_rx_mgnt_pkts = sta->sta_stats.rx_mgnt_pkts; \
@@ -269,23 +240,6 @@ do { \
 	sta->sta_stats.last_rx_data_pkts = sta->sta_stats.rx_data_pkts; \
 } while (0)
 
-#define STA_RX_PKTS_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts \
-	, sta->sta_stats.rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts
-
-#define STA_LAST_RX_PKTS_ARG(sta) \
-	sta->sta_stats.last_rx_mgnt_pkts \
-	, sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.last_rx_data_pkts
-
-#define STA_RX_PKTS_DIFF_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts - sta->sta_stats.last_rx_mgnt_pkts \
-	, sta->sta_stats.rx_ctrl_pkts - sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts - sta->sta_stats.last_rx_data_pkts
-
-#define STA_PKTS_FMT "(m:%llu, c:%llu, d:%llu)"
-
 struct	sta_priv {
 	u8 *pallocated_stainfo_buf;
 	u8 *pstainfo_buf;
-- 
2.34.1

