Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C1465EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356001AbhLBHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:30 -0500
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:57669 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355877AbhLBHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431508; bh=Xq55tIfvV+EWtdbVLQfyR97MpcKaPM59jblpvNhML3k=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XvRnQbz7Cpiti2PPy34tBsLShKpD9837Kit3Pf7W7mmVhsV1T5Jn6OCC+q9w3Mpom
         zmetKfNfbBRysXNrEsMB71vExGVQS6jkJcO8jcCS2rDK2Z7rsXjtKLQ1ZRYgG9uFpW
         sLIS+l3ewwVQ5IJzTDdENufkoVdG2HrZP6GbPOdyUNBhREDpz1Snj68/55N9FTy2n2
         p2KduBxxiAxWePvdBCTcTKL4HuIQK8gnNDgTOp5pMAbcNVdXxp/DoM5glP2esJCWVB
         zCjUSLnzukyPXkNjEE/yrNTFJ6gtF7R7xYWnfg62ObKdAV6H6oH/+J5vWLwuLm68QL
         wKE9E0jPpuEgw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 1FB2DC8036B;
        Thu,  2 Dec 2021 07:51:47 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 08/12] ARM: dts: sti: remove delta node from stih410.dtsi
Date:   Thu,  2 Dec 2021 08:51:01 +0100
Message-Id: <20211202075105.195664-9-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-11-30=5F10:2021-11-28=5F01,2021-11-30=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=867 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112020045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delta0 node within stih410.dtsi is identical to the
one already written within stih407-family.dtsi and included
within stih410.dtsi.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 6d847019c554..fe83d9a522bf 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -274,16 +274,6 @@ thermal@91a0000 {
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		delta0@0 {
-			compatible = "st,st-delta";
-			clock-names = "delta",
-				      "delta-st231",
-				      "delta-flash-promip";
-			clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
-				 <&clk_s_c0_flexgen CLK_ST231_DMU>,
-				 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
-		};
-
 		sti-cec@94a087c {
 			compatible = "st,stih-cec";
 			reg = <0x94a087c 0x64>;
-- 
2.25.1

