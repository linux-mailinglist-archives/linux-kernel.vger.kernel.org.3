Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3547F901
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhLZVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhLZVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:25:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BEC061759
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:25:53 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1b1Z-0000qQ-LS; Sun, 26 Dec 2021 22:25:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/10] staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
Date:   Sun, 26 Dec 2021 22:25:31 +0100
Message-Id: <20211226212535.197989-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226212535.197989-1-martin@kaiser.cx>
References: <20211226212535.197989-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the private ioctl "wps_assoc_req_ie", it is mapped to
an empty function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index db88a78b1c87..776b4f5cb77d 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2106,13 +2106,6 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_wx_set_mtk_wps_ie(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-{
-	return 0;
-}
-
 static int rtw_get_ap_info(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -4293,11 +4286,6 @@ static const struct iw_priv_args rtw_private_args[] = {
 		SIOCIWFIRSTPRIV + 0x6,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "wps_start"
 	},
-	{
-		SIOCIWFIRSTPRIV + 0x9,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "wps_assoc_req_ie"
-	},
-
 	{
 		SIOCIWFIRSTPRIV + 0xA,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "channel_plan"
@@ -4359,7 +4347,7 @@ NULL,					/* 0x03 */
 
 	NULL,				/* 0x07 */
 	NULL,				/* 0x08 */
-	rtw_wx_set_mtk_wps_ie,		/* 0x09 */
+	NULL,				/* 0x09 */
 
 /*  Set Channel depend on the country code */
 	rtw_wx_set_channel_plan,	/* 0x0A */
-- 
2.30.2

