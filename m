Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D94465EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355909AbhLBHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:17 -0500
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:34483 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355911AbhLBHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431505; bh=2cygzh32sg6fJlXtQ60vZgu1z6mh69gpVg6FC4BVoUY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=iyMyHZl818U0tJokcbjRWDrLa5p51ZdssAenN4DHnmMPmLemhdOf4Yqiyij47Jw+p
         V67BWCUIRMx7yc22K774+d/kI3dAzrI670a3CEeWIeaMrp+3fE43Axqf9gR08bbvgD
         1ZVXzNLqRQ95gMGiuXZ3oj6uXcG8GAIt+68r1H5WAStV9SFwnapi0DuxRKsUvNUMGQ
         IG/zPjWbxI3TaJplbc+vFeibQ22+DnHKb25bapBvbwuZ4Y9RKiuYJFk1CdYC8qravj
         XEdvxS410+EVETXpnrDSzfC6GjWCU66jUc5CRlDWH11KryvNMMW/FSjDUk9WllpeB/
         XHrTkrYP/96vQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 430BB222073;
        Thu,  2 Dec 2021 07:51:45 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 07/12] ARM: dts: sti: update stihxxx-b2120 following stih407-family DT update
Date:   Thu,  2 Dec 2021 08:51:00 +0100
Message-Id: <20211202075105.195664-8-avolmat@me.com>
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
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index d051f080e52e..4c72dedcd1be 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -71,6 +71,17 @@ codec {
 		};
 	};
 
+	miphy28lp_phy: miphy28lp {
+
+		phy_port0: port@9b22000 {
+			st,osc-rdy;
+		};
+
+		phy_port1: port@9b2a000 {
+			st,osc-force-ext;
+		};
+	};
+
 	soc {
 		sbc_serial0: serial@9530000 {
 			status = "okay";
@@ -128,17 +139,6 @@ hdmiddc: i2c@9541000 {
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
 
-		miphy28lp_phy: miphy28lp@0 {
-
-			phy_port0: port@9b22000 {
-				st,osc-rdy;
-			};
-
-			phy_port1: port@9b2a000 {
-				st,osc-force-ext;
-			};
-		};
-
 		st_dwc3: dwc3@8f94000 {
 			status = "okay";
 		};
-- 
2.25.1

