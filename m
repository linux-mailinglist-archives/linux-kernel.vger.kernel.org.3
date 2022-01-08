Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB64883A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiAHMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiAHMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18181C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:23 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAo-0005EJ-JG; Sat, 08 Jan 2022 13:50:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/12] staging: r8188eu: CurrentOfdm24GTxPwrIdx is set but not used
Date:   Sat,  8 Jan 2022 13:49:55 +0100
Message-Id: <20220108124959.313215-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CurrentOfdm24GTxPwrIdx in struct hal_data_8188e is set but not used.
It can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  | 1 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 24b5604afbc9..a80f40fccf09 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -587,7 +587,6 @@ static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckP
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
-	pHalData->CurrentOfdm24GTxPwrIdx = ofdmPowerLevel[0];
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 0c7f5e078bed..fd2ee1739f88 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -178,7 +178,6 @@ struct hal_data_8188e {
 
 	/*  The current Tx Power Level */
 	u8	CurrentCckTxPwrIdx;
-	u8	CurrentOfdm24GTxPwrIdx;
 
 	/*  Read/write are allow for following hardware information variables */
 	u8	pwrGroupCnt;
-- 
2.30.2

