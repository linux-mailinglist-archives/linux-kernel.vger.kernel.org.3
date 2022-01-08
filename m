Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D948839F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiAHMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiAHMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF52AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:20 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAm-0005EJ-UC; Sat, 08 Jan 2022 13:50:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/12] staging: r8188eu: CurrentBW4024GTxPwrIdx is set but not used
Date:   Sat,  8 Jan 2022 13:49:53 +0100
Message-Id: <20220108124959.313215-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CurrentBW4024GTxPwrIdx in struct hal_data_8188e is set but not used.
It can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  | 1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index c06a332f6b20..fe15b15ab951 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -589,7 +589,6 @@ static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckP
 	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
 	pHalData->CurrentOfdm24GTxPwrIdx = ofdmPowerLevel[0];
 	pHalData->CurrentBW2024GTxPwrIdx = BW20PowerLevel[0];
-	pHalData->CurrentBW4024GTxPwrIdx = BW40PowerLevel[0];
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 66eadd170c9b..1c52dd9d9721 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -180,7 +180,6 @@ struct hal_data_8188e {
 	u8	CurrentCckTxPwrIdx;
 	u8	CurrentOfdm24GTxPwrIdx;
 	u8	CurrentBW2024GTxPwrIdx;
-	u8	CurrentBW4024GTxPwrIdx;
 
 	/*  Read/write are allow for following hardware information variables */
 	u8	pwrGroupCnt;
-- 
2.30.2

