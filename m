Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C0E468118
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383743AbhLDAVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:21:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41840 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383662AbhLDAUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:50 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E981A1A25BF;
        Sat,  4 Dec 2021 01:17:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A7D1A1A07CC;
        Sat,  4 Dec 2021 01:17:24 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 23C2840577;
        Fri,  3 Dec 2021 17:17:24 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v2 7/8] arm64: dts: ls1028a-qds: enable lpuart1
Date:   Fri,  3 Dec 2021 18:17:17 -0600
Message-Id: <20211204001718.8511-8-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211204001718.8511-1-leoyang.li@nxp.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vabhav Sharma <vabhav.sharma@nxp.com>

LPUART nodes by default are disabled in LS1028A device
tree, Enabling LPUART1 node.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index baa1cc9b9835..782853a449cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -336,6 +336,10 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart1 {
+	status = "okay";
+};
+
 &sai1 {
 	status = "okay";
 };
-- 
2.25.1

