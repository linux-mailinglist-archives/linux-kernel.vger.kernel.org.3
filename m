Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDF465EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbhLBHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:38 -0500
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:60473 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355959AbhLBHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431519; bh=b+xILm5HUFiS/y+k2BPEGKLU/fijdPA42g/Lq5Or9kM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=fSyP+F5l74uCO7iGswbP/KNif5mW81Y/prbLhIznfPwee50q+4PhqbHwkPAefpo04
         Rfaj9kyWqNVE9zyoanpknwjkpm0XSeokUNuWvoD6It/PRQriOs8mre8Tnw2+vliHNY
         jccaxLmHKINHFvLD6xtKWU5+hneBWaVMfwB6x1Qj7+wKCI/plWSSuU1BsqlKV8xRf2
         9eLbqVrIV8L7RMt1qVpnRPHA2LUV35sU6G2+UXXPYEOa/5kHK/c9r6aykgXj15H1HV
         WUW92HhNcLInmI86DGJum43zddL3gUm+9nHPJ15cWSMJ1FmEIiMzGOP8CDzH+34vBl
         i/Rj9pDWw0eMw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id B6325C0522;
        Thu,  2 Dec 2021 07:51:58 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 11/12] ARM: dts: sti: move usb picophy nodes in stih410-b2120.dts
Date:   Thu,  2 Dec 2021 08:51:04 +0100
Message-Id: <20211202075105.195664-12-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update usb picophy nodes out of the soc section following the
related update within the stih410.dtsi file.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410-b2120.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9d3b118f5f0f..538ff98ca1b1 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -24,6 +24,14 @@ aliases {
 		ethernet0 = &ethernet0;
 	};
 
+	usb2_picophy1: phy2 {
+		status = "okay";
+	};
+
+	usb2_picophy2: phy3 {
+		status = "okay";
+	};
+
 	soc {
 
 		mmc0: sdhci@9060000 {
@@ -33,14 +41,6 @@ mmc0: sdhci@9060000 {
 			sd-uhs-ddr50;
 		};
 
-		usb2_picophy1: phy2@0 {
-			status = "okay";
-		};
-
-		usb2_picophy2: phy3@0 {
-			status = "okay";
-		};
-
 		ohci0: usb@9a03c00 {
 			status = "okay";
 		};
-- 
2.25.1

