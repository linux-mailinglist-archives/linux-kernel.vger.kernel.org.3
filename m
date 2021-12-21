Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821FB47BF88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhLUMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:15:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59614 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237451AbhLUMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:15:52 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23E661A1234;
        Tue, 21 Dec 2021 13:15:51 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 176ED1A050C;
        Tue, 21 Dec 2021 13:15:51 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CB7F203C3;
        Tue, 21 Dec 2021 13:15:50 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/3] rtc: imx-sc: Add i.MX8QM RTC support
Date:   Tue, 21 Dec 2021 14:15:47 +0200
Message-Id: <1640088948-3690-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
References: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QM RTC support.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/rtc/rtc-imx-sc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 814d516645e2..6828f894e15e 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -166,6 +166,7 @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_sc_dt_ids[] = {
 	{ .compatible = "fsl,imx8qxp-sc-rtc", },
+	{ .compatible = "fsl,imx8qm-sc-rtc", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
-- 
2.31.1

