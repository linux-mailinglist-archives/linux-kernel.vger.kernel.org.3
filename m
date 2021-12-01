Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84428464876
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbhLAHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347575AbhLAHdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868DDC061759;
        Tue, 30 Nov 2021 23:29:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4160CE1759;
        Wed,  1 Dec 2021 07:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F75C53FD0;
        Wed,  1 Dec 2021 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343781;
        bh=s8qEk1HK0t6PsaG1jQLTOHouIh3JdaX+ehSo1B9dxfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ot7qo4Jhydns0dhy/K1Ec51bspYFnLpEuq+AL49QhNUE+5Im1VQ7sdxbqu+R5ADWJ
         nKx0e5VHpc7I3YbqCO6BIoHFkkmUJkt5sIavUkTbE9WAtZhp4aHb2WQEKrWnAQsAjx
         DFhyRdSoWD6bLs6wLrZZyJNTwDRpW/+4PX8yzOIVCcBq1AgxvlD/ZjwD+Ua/XMBJ4R
         EXFsOIwmJPhvhUSvrSDcBEEqdrHosICC7574y2mvl4b+Qz82AmF51oIIdcqBRNGH9Y
         rC14MBY0HUEpGYhzry35+8BIftmU9xEtMYYqOvnIoy0fZmGQ95a8TB9c2lZP0h/d3w
         iQIHoTSHxpkng==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] arm64: dts: qcom: sm8450: add smmu nodes
Date:   Wed,  1 Dec 2021 12:59:06 +0530
Message-Id: <20211201072915.3969178-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the apps smmu node as found in the SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 103 +++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 79aead4cba66..53a6f2275621 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -616,6 +616,109 @@ tx {
 			};
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
+			reg = <0 0x15000000 0 0x100000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			interrupts =    <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller@17100000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.31.1

