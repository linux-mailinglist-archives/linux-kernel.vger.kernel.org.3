Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8348839D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiAHMuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiAHMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BECCC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:19 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAl-0005EJ-6c; Sat, 08 Jan 2022 13:50:15 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/12] staging: r8188eu: remove unused chip type settings
Date:   Sat,  8 Jan 2022 13:49:51 +0100
Message-Id: <20220108124959.313215-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused defines and macros related to chip type.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/HalVerDef.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 62b94c993f0d..f4816ac765e5 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -6,7 +6,6 @@
 enum HAL_CHIP_TYPE {
 	TEST_CHIP	=	0,
 	NORMAL_CHIP	=	1,
-	FPGA		=	2,
 };
 
 enum HAL_CUT_VERSION {
@@ -40,8 +39,6 @@ struct HAL_VERSION {
 /* HAL_VERSION VersionID */
 
 /* HAL_CHIP_TYPE_E */
-#define IS_TEST_CHIP(version)				\
-	((GET_CVID_CHIP_TYPE(version) == TEST_CHIP) ? true : false)
 #define IS_NORMAL_CHIP(version)				\
 	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
 
@@ -60,7 +57,5 @@ struct HAL_VERSION {
 /* HAL_VENDOR_E */
 #define IS_CHIP_VENDOR_TSMC(version)			\
 	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
-#define IS_CHIP_VENDOR_UMC(version)			\
-	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_UMC) ? true : false)
 
 #endif
-- 
2.30.2

