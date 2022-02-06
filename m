Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD24AB097
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiBFQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244713AbiBFQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:29 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF399C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:28 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF7-0001bS-5x; Sun, 06 Feb 2022 17:18:25 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/14] staging: r8188eu: remove unused struct adapter components
Date:   Sun,  6 Feb 2022 17:18:05 +0100
Message-Id: <20220206161809.423031-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
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

Remove a number of unused components from struct adapter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 1260cacbae64..4553cfda0aa4 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -161,7 +161,6 @@ static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 
 struct adapter {
 	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
-	int	bDongle;/* build-in module or external dongle */
 
 	struct dvobj_priv *dvobj;
 	struct	mlme_priv mlmepriv;
@@ -186,20 +185,11 @@ struct adapter {
 	s32	bSurpriseRemoved;
 	s32	bCardDisableWOHSM;
 
-	u32	IsrContent;
-	u32	ImrContent;
-
 	u8	EepromAddressSize;
 	u8	hw_init_completed;
-	u8	bDriverIsGoingToUnload;
-	u8	init_adpt_in_progress;
-	u8	bHaltInProgress;
 	s8	signal_strength;
 
 	void *cmdThread;
-	void *evtThread;
-	void *xmitThread;
-	void *recvThread;
 	void (*intf_start)(struct adapter *adapter);
 	void (*intf_stop)(struct adapter *adapter);
 	struct  net_device *pnetdev;
@@ -219,7 +209,6 @@ struct adapter {
 
 	int net_closed;
 	u8 bFWReady;
-	u8 bBTFWReady;
 	u8 bReadPortCancel;
 	u8 bWritePortCancel;
 	u8 bRxRSSIDisplay;
-- 
2.30.2

