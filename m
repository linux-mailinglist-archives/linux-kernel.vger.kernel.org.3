Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E8502881
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiDOKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352401AbiDOKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:52:41 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A0344DD;
        Fri, 15 Apr 2022 03:50:13 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 58A216046B;
        Fri, 15 Apr 2022 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650019811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/r9DJSM9esswD1O3AzR1QO335XskjFIKH/yz95f+Oo=;
        b=q1nObm52xIBoPNRhN+q/auCKEUXd4PFVqo11iXybCFUGnQt9STlVnRFZeQZ2hU2eLIna+h
        HZzRNAsE3nmZnzbed15gt4u8ymY7aFnJRB221ITCRvbJ1IXgkxSKEIxv3q6vx7l3Zt6utN
        v75mWpqkg4IOxlNKS2mYWmyEx4Momp4=
Received: from localhost.localdomain (fttx-pool-217.61.153.244.bambit.de [217.61.153.244])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 25BEA100501;
        Fri, 15 Apr 2022 10:50:10 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: set display regulators to always-on on BPI-R2-Pro
Date:   Fri, 15 Apr 2022 12:49:49 +0200
Message-Id: <20220415104951.27104-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415104951.27104-1-linux@fw-web.de>
References: <20220415104951.27104-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a209ccd2-0066-4cf5-b936-ad920be5a2a8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Set display related regulators to always-on on Banana PI R2 Pro
board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 2700fb18a3bc..0950f9659bb4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -225,6 +225,7 @@ regulator-state-mem {
 
 			vdd_gpu: DCDC_REG2 {
 				regulator-name = "vdd_gpu";
+				regulator-always-on;
 				regulator-init-microvolt = <900000>;
 				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
@@ -274,6 +275,7 @@ regulator-state-mem {
 
 			vdda0v9_image: LDO_REG1 {
 				regulator-name = "vdda0v9_image";
+				regulator-always-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 
@@ -369,6 +371,7 @@ regulator-state-mem {
 
 			vcca1v8_image: LDO_REG9 {
 				regulator-name = "vcca1v8_image";
+				regulator-always-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 
-- 
2.25.1

