Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287C1468117
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383707AbhLDAU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:20:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54184 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383653AbhLDAUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6266B20222A;
        Sat,  4 Dec 2021 01:17:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2680E200B55;
        Sat,  4 Dec 2021 01:17:24 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8D0754030F;
        Fri,  3 Dec 2021 17:17:23 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 5/8] arm64: dts: ls1028a-rdb: enable pwm0
Date:   Fri,  3 Dec 2021 18:17:15 -0600
Message-Id: <20211204001718.8511-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211204001718.8511-1-leoyang.li@nxp.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Enable pwm0 on ls1028a-rdb board which uses flextimer1.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 7d87c90652d2..dd75624d3e91 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -283,6 +283,10 @@ &optee {
 	status = "okay";
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &sai4 {
 	status = "okay";
 };
-- 
2.25.1

