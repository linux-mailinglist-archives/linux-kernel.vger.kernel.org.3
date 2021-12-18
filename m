Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB424479AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhLRMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhLRMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB50C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:52 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYSG-0008I6-Bo; Sat, 18 Dec 2021 13:04:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/9] staging: r8188: remove unused odm capabilities
Date:   Sat, 18 Dec 2021 13:04:21 +0100
Message-Id: <20211218120423.29906-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove odm capabilities which are either unused or set but
never checked.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 2 --
 drivers/staging/r8188eu/include/odm.h     | 9 +--------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index f8d2c98b3e35..6a5a80bfe7e4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -55,11 +55,9 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	pdmpriv->InitODMFlag =	ODM_BB_DIG |
 				ODM_BB_RA_MASK |
-				ODM_BB_DYNAMIC_TXPWR |
 				ODM_BB_FA_CNT |
 				ODM_BB_RSSI_MONITOR |
 				ODM_BB_CCK_PD |
-				ODM_BB_PWR_SAVE |
 				ODM_MAC_EDCA_TURBO |
 				ODM_RF_CALIBRATION |
 				ODM_RF_TX_PWR_TRACK;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index b28294527ca7..8ab173f7c6c6 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -241,26 +241,19 @@ enum odm_common_info_def {
 enum odm_ability_def {
 	/*  BB ODM section BIT 0-15 */
 	ODM_BB_DIG			= BIT(0),
+
 	ODM_BB_RA_MASK			= BIT(1),
-	ODM_BB_DYNAMIC_TXPWR		= BIT(2),
 	ODM_BB_FA_CNT			= BIT(3),
 	ODM_BB_RSSI_MONITOR		= BIT(4),
 	ODM_BB_CCK_PD			= BIT(5),
 	ODM_BB_ANT_DIV			= BIT(6),
-	ODM_BB_PWR_SAVE			= BIT(7),
 	ODM_BB_PWR_TRA			= BIT(8),
-	ODM_BB_RATE_ADAPTIVE		= BIT(9),
-	ODM_BB_PATH_DIV			= BIT(10),
-	ODM_BB_PSD			= BIT(11),
-	ODM_BB_RXHP			= BIT(12),
 
 	/*  MAC DM section BIT 16-23 */
 	ODM_MAC_EDCA_TURBO		= BIT(16),
-	ODM_MAC_EARLY_MODE		= BIT(17),
 
 	/*  RF ODM section BIT 24-31 */
 	ODM_RF_TX_PWR_TRACK		= BIT(24),
-	ODM_RF_RX_GAIN_TRACK		= BIT(25),
 	ODM_RF_CALIBRATION		= BIT(26),
 };
 
-- 
2.20.1

