Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42E8465EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbhLBHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:40 -0500
Received: from st43p00im-ztbu10073701.me.com ([17.58.63.183]:44659 "EHLO
        st43p00im-ztbu10073701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355972AbhLBHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431522; bh=B5HbAQ3z6bOY/xQiBfcJ7b3vlYf2meSmO7XfFtNt6aY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XqvU8NwTRMc+tNh/y8wWSW3gaOEmutbBez8Cs7SzCPpmvuewcyzcGH7TodwpAGomg
         xrg5uRbPEXw01AgRp9JTDh3+l6ZpyHbRadGZeeuyCQIg57dS7dZVv34ZSf+SI8oPkx
         f3ycLJ/OGSvZCUksTv1BoEAx0iCQRM42kt+/CvxlrBSj9laZ58IgY5gGCuj+E2e6ji
         cniQifhDN+tMN+NgFUtGWPQzONx5F/QyGseWLithcTxjfQnlQh1Q/HeyqDdYUfaG8q
         VVvTxkh62VE7AesX/VQLc0aqkcn/sxImfiQf6eLQAZDnwuiz2F8ScWyKThk5naAnh2
         DvBqXCvjT3BYA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id E4AD74C083D;
        Thu,  2 Dec 2021 07:52:01 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 12/12] ARM: dts: sti: move usb picophy nodes in stih410-b2260.dts
Date:   Thu,  2 Dec 2021 08:51:05 +0100
Message-Id: <20211202075105.195664-13-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-01_01:2021-11-30,2021-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112020046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update usb picophy nodes out of the soc section following the
related update within the stih410.dtsi file.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410-b2260.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c2d3b6de55d0..26d93f26f6d0 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -82,6 +82,14 @@ phy_port1: port@9b2a000 {
 		};
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
 		/* Low speed expansion connector */
 		uart0: serial@9830000 {
@@ -152,14 +160,6 @@ pwm1: pwm@9510000 {
 			status = "okay";
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

