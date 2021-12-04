Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B74681C0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 02:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354750AbhLDBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 20:19:11 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44636 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354658AbhLDBTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 20:19:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E12D1A0793;
        Sat,  4 Dec 2021 02:15:43 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 335FC1A07CE;
        Sat,  4 Dec 2021 02:15:43 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5A10340577;
        Fri,  3 Dec 2021 18:15:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Pengbo Mu <pengbo.mu@nxp.com>
Subject: [PATCH 2/2] arm64: dts: ls1088a: add snps incr burst type adjustment for usb1
Date:   Fri,  3 Dec 2021 19:15:37 -0600
Message-Id: <20211204011537.8963-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211204011537.8963-1-leoyang.li@nxp.com>
References: <20211204011537.8963-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property could fix the defect that external usb device
always prints this error log --- 'reset SuperSpeed USB device number n
using xhci_hcd' when system power on.

Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 1eda080b497c..3ed1f2c51cad 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -497,6 +497,7 @@ usb1: usb@3110000 {
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
-- 
2.25.1

