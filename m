Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E047F904
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhLZV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhLZVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:25:55 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA00C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:25:55 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1b1b-0000qQ-6i; Sun, 26 Dec 2021 22:25:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: remove the private ioctl "tdls"
Date:   Sun, 26 Dec 2021 22:25:33 +0100
Message-Id: <20211226212535.197989-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226212535.197989-1-martin@kaiser.cx>
References: <20211226212535.197989-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the private ioctl "tdls", it is mapped to an empty
function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 47c1662394f3..911f10627551 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4178,13 +4178,6 @@ static int rtw_pm_set(struct net_device *dev,
 
 extern int wifirate2_ratetbl_inx(unsigned char rate);
 
-static int rtw_tdls(struct net_device *dev,
-		    struct iw_request_info *info,
-		    union iwreq_data *wrqu, char *extra)
-{
-	return 0;
-}
-
 static int rtw_test(
 	struct net_device *dev,
 	struct iw_request_info *info,
@@ -4308,10 +4301,6 @@ static const struct iw_priv_args rtw_private_args[] = {
 		SIOCIWFIRSTPRIV + 0x12,
 		IW_PRIV_TYPE_CHAR | P2P_PRIVATE_IOCTL_SET_LEN, IW_PRIV_TYPE_CHAR | IFNAMSIZ, "p2p_get2"
 	},
-	{
-		SIOCIWFIRSTPRIV + 0x14,
-		IW_PRIV_TYPE_CHAR  | 64, 0, "tdls"
-	},
 	{
 		SIOCIWFIRSTPRIV + 0x16,
 		IW_PRIV_TYPE_CHAR | 64, 0, "pm_set"
@@ -4352,7 +4341,7 @@ NULL,					/* 0x03 */
 	rtw_p2p_get2,			/* 0x12 */
 
 	NULL,				/* 0x13 */
-	rtw_tdls,			/* 0x14 */
+	NULL,				/* 0x14 */
 	NULL,				/* 0x15 */
 
 	rtw_pm_set,			/* 0x16 */
-- 
2.30.2

