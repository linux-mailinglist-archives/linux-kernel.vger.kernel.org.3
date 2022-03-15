Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0614DA440
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351844AbiCOUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351808AbiCOUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:52:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440B54BF9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:51:04 -0700 (PDT)
Received: from ipservice-092-217-079-029.092.217.pools.vodafone-ip.de ([92.217.79.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nUE8B-00084h-VD; Tue, 15 Mar 2022 21:51:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/6] staging: r8188eu: remove some unused local ieee80211 macros
Date:   Tue, 15 Mar 2022 21:50:40 +0100
Message-Id: <20220315205041.2714168-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220315205041.2714168-1-martin@kaiser.cx>
References: <20220315205041.2714168-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some macros from wifi.h which are not used by this driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/wifi.h | 27 --------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c1c9bae58d6d..c331be19ff83 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -167,17 +167,11 @@ enum WIFI_REG_DOMAIN {
 
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
 
-#define ClearToDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_TO_DS_))
-
 #define SetFrDs(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
 
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
 
-#define ClearFrDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_FROM_DS_))
-
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
 #define SetMFrag(pbuf)	\
@@ -186,46 +180,25 @@ enum WIFI_REG_DOMAIN {
 #define ClearMFrag(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
 
-#define SetRetry(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_)
-
 #define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
-#define ClearRetry(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
-
 #define SetPwrMgt(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
 
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
-#define ClearPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
-
 #define SetMData(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
 
-#define ClearMData(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
-
 #define SetPrivacy(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
 
 #define GetPrivacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
 
-#define ClearPrivacy(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PRIVACY_))
-
 #define GetFrameType(pbuf)				\
 	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
 
-#define SetFrameType(pbuf, type)	\
-	do {	\
-		*(unsigned short *)(pbuf) &= __constant_cpu_to_le16(~(BIT(3) | BIT(2))); \
-		*(unsigned short *)(pbuf) |= __constant_cpu_to_le16(type); \
-	} while (0)
-
 #define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
 	 BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
 
-- 
2.30.2

