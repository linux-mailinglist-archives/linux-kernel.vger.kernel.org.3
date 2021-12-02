Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD465EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbhLBHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:10 -0500
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:46562 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355900AbhLBHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431502; bh=hXgTv0fD+nHb+KzRO/cW3CKzsrKWzzR1fxhdzXLhqvg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=pEavVnOnBzjEoicLfXW0oqJe0M4D2NrUSAJ76Z9yn/MD5dwrxRbZSnVfnniMXZy4j
         cdVIiUylhQrQMy35njUjAuPmoxhXdH5uKjwTHiL0PUfdmwldgslZi9iVc0LKk10MyJ
         hV9Mhu8zL6Lk6uibnP2Mv6Ek/2DtaZF+PIYn6ncgeWxDzgtPRil5ckisNvYdflvB50
         nQtILKp0lOcHiduN3NR1Xs44FqIJIWFIBzL//NoehCoAUupuDNjq2idd1r+jVdQLZP
         w/0dl1pUU44bd2VrIPcLBz3p4YvL9a+riK1aaYl45gf+sZNjOJFmU8yH7j3P9ykD2b
         apZtwMDWEjrng==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id D8E8A7005AA;
        Thu,  2 Dec 2021 07:51:41 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 06/12] ARM: dts: sti: update stih418-b2199 following stih407-family DT update
Date:   Thu,  2 Dec 2021 08:50:59 +0100
Message-Id: <20211202075105.195664-7-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-11-30=5F10:2021-11-28=5F01,2021-11-30=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=743 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112020045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put of the miphy28lp_phy node out of the soc section following similar
update within stih407-family.dtsi file update.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418-b2199.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index b66e2b29edea..d21bcc7c1271 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -37,6 +37,17 @@ green {
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
@@ -84,17 +95,6 @@ mmc0: sdhci@9060000 {
 			non-removable;
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

