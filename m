Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14749465EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355952AbhLBH47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:56:59 -0500
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:45334 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345506AbhLBHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431494; bh=Ma9Hw3+UAFqNL5lNgNwFLIBkViWrF9IckYy0GcLO374=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=tp9ztFHIs2DityYWjiBbyMSCy9Ms/q5OFdz21nzLscD5MWhgJNhRrXSSZ0pfY61Xa
         sBWlK3y9Uw+OOf+n3a0D1yMTPoD8JT7y3AcQZ1cfOhhDNJzhEJojyHrXUdmWlGKCeh
         ayoHig6Iz/34OB/sTD/uBgxI60ym7g8W3nzdfsdXW15w0TQF9xMZ4E1dSLdXIsTSV1
         I/nBwhfjdoMHYFB7809YRmjfyv5EHtI7PCEbcCmVOIIRzpnv2/F69lIy4biovo8gkW
         aJ8y9ew8+asdL9UwbCKFKKk0OUJvT7grDs7sXu9cvUju1HmAUAXOEao0+DahAGqvSr
         nLitw0G/gzJRg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id 9FE2070076E;
        Thu,  2 Dec 2021 07:51:33 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 05/12] ARM: dts: sti: update stih410-b2260 following stih407-family DT update
Date:   Thu,  2 Dec 2021 08:50:58 +0100
Message-Id: <20211202075105.195664-6-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put of the miphy28lp_phy node out of the soc section following similar
update within stih407-family.dtsi file update.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410-b2260.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 9d579c16c295..c2d3b6de55d0 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -75,6 +75,13 @@ codec {
 		};
 	};
 
+	miphy28lp_phy: miphy28lp {
+
+		phy_port1: port@9b2a000 {
+			st,osc-force-ext;
+		};
+	};
+
 	soc {
 		/* Low speed expansion connector */
 		uart0: serial@9830000 {
@@ -196,13 +203,6 @@ hdmiddc: i2c@9541000 {
 			status = "okay";
 		};
 
-		miphy28lp_phy: miphy28lp@0 {
-
-			phy_port1: port@9b2a000 {
-				st,osc-force-ext;
-			};
-		};
-
 		sata1: sata@9b28000 {
 			status = "okay";
 		};
-- 
2.25.1

